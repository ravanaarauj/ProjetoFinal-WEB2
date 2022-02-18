<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "fornecedor".
 *
 * @property int $id
 * @property string $nome_fantasia
 * @property string $razao_social
 * @property string $cnpj
 * @property string|null $email
 * @property string|null $telefone
 * @property string|null $celular
 *
 * @property Produto[] $produtos
 */
class Fornecedor extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'fornecedor';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['nome_fantasia', 'razao_social', 'cnpj'], 'required'],
            [['nome_fantasia', 'razao_social'], 'string', 'max' => 100],
            [['cnpj'], 'string', 'max' => 18],
            [['email'], 'string', 'max' => 45],
            [['telefone'], 'string', 'max' => 14],
            [['celular'], 'string', 'max' => 16],
            [['cnpj'], 'unique'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'nome_fantasia' => 'Nome Fantasia',
            'razao_social' => 'Razao Social',
            'cnpj' => 'Cnpj',
            'email' => 'Email',
            'telefone' => 'Telefone',
            'celular' => 'Celular',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProdutos()
    {
        return $this->hasMany(Produto::className(), ['fornecedor_id' => 'id']);
    }
}
