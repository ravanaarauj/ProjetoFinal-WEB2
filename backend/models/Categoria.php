<?php

namespace app\models;

use Yii;

class Categoria extends \yii\db\ActiveRecord
{

    public static function tableName()
    {
        return 'categoria';
    }

    public function rules()
    {
        return [
            [['nome'], 'required'],
            [['nome'], 'string', 'max' => 45],
            [['nome'], 'unique'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'nome' => 'Nome',
        ];
    }

    public function getProdutos()
    {
        return $this->hasMany(Produto::className(), ['categoria_id' => 'id']);
    }
}
