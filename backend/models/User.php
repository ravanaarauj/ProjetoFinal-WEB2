<?php

namespace app\models;

use Yii;
use yii\web\IdentityInterface;


class User extends \yii\db\ActiveRecord implements \yii\web\IdentityInterface
{

    public static function tableName()
    {
        return 'user';
    }

    public function beforeSave($insert)
    {
        if (parent::beforeSave($insert)) {
            if ($this->isNewRecord) {
                $this->authKey = \Yii::$app->security->generateRandomString(100);
                $this->accessToken = \Yii::$app->security->generateRandomString(100);
            }

            if (($this->isNewRecord) || $this->isAttributeChanged('senha')) {
                $this->senha = Yii::$app->getSecurity()->generatePasswordHash($this->senha);
            }
            return true;
        }
    }

    public function rules()
    {
        return [
            [['nome', 'matricula', 'email', 'senha', 'tipo'], 'required'],
            [['nome', 'matricula', 'email', 'tipo'], 'string', 'max' => 45],
            [['accessToken', 'authKey', 'senha'], 'string', 'max' => 100],
            [['matricula'], 'unique'],
            [['email'], 'unique'],
        ];
    }


    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'nome' => 'Nome',
            'matricula' => 'Matricula',
            'email' => 'Email',
            'senha' => 'Senha',
            'tipo' => 'Tipo',
            'accessToken' => 'Access Token',
            'authKey' => 'Auth Key',
        ];
    }

    public function getPedidos()
    {
        return $this->hasMany(Pedido::className(), ['usuario_id' => 'id']);
    }

    /**
     * Gera um novo AuthKey
     */
    public function newAuthKey() {
        $this->authKey = \Yii::$app->security->generateRandomString(100);
        if ($this->save()) {
            return $this->authKey;
        } else return null;
    }

    /**
     * Gera um novo AccessToken
     */
    public function newAccessToken() {
        $this->accessToken = \Yii::$app->security->generateRandomString(100);
        if ($this->save()) {
            return $this->accessToken;
        } else return null;
    }

    public static function findIdentity($id)
    {
        return static::findOne($id);
    }

    public static function findIdentityByAccessToken($token, $type = null)
    {
        return static::findOne(['accessToken' => $token]);
    }

    public function getId()
    {
        return $this->id;
    }

    public function getAuthKey()
    {
        return $this->authKey;
    }

    public function validateAuthKey($authKey)
    {
        return $this->getAuthKey() === $authKey;
    }

    public function validatePassword($senha) {
        return Yii::$app->getSecurity()->validatePassword($senha, $this->senha);
    }

    public function fields() {
        $fields = parent::fields();

        unset($fields['senha'],$fields['authKey'],$fields['accessToken']);

        return $fields;
    }
}
