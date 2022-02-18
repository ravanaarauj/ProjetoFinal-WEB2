<?php

namespace app\models;

use Yii;

class Produto extends \yii\db\ActiveRecord
{
    public static function tableName()
    {
        return 'produto';
    }

    public function rules()
    {
        return [
            [['nome', 'categoria_id', 'fornecedor_id', 'estoque', 'validade'], 'required'],
            [['categoria_id', 'fornecedor_id', 'estoque'], 'integer'],
            [['nome'], 'string', 'max' => 45],
            [['validade'], 'string', 'max' => 10],
            [['categoria_id'], 'exist', 'skipOnError' => true, 'targetClass' => Categoria::className(), 'targetAttribute' => ['categoria_id' => 'id']],
            [['fornecedor_id'], 'exist', 'skipOnError' => true, 'targetClass' => Fornecedor::className(), 'targetAttribute' => ['fornecedor_id' => 'id']],
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'nome' => 'Nome',
            'categoria_id' => 'Categoria ID',
            'fornecedor_id' => 'Fornecedor ID',
            'estoque' => 'Estoque',
            'validade' => 'Validade',
        ];
    }

    public function getItempedidos()
    {
        return $this->hasMany(Itempedido::className(), ['produto_id' => 'id']);
    }

    public function getCategoria()
    {
        return $this->hasOne(Categoria::className(), ['id' => 'categoria_id']);
    }

    public function getFornecedor()
    {
        return $this->hasOne(Fornecedor::className(), ['id' => 'fornecedor_id']);
    }

    public function extraFields()
    {
        return ['categoria', 'fornecedor'];
    }
}
