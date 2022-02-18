<?php

namespace app\controllers;

use Yii;
use app\models\Pedido;
use yii\filters\auth\HttpBearerAuth;

class PedidoController extends \app\components\controllers\ActiveRestrictController
{
    public function actions()
    {
        $actions = parent::actions();
        unset($actions['update']);
        return $actions;
    }

    public $modelClass = 'app\models\Pedido';

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className()
        ];
        return $behaviors;
    }
}
