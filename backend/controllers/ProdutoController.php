<?php

namespace app\controllers;

use Yii;
use app\models\Produto;
use yii\filters\auth\HttpBearerAuth;

class ProdutoController extends \app\components\controllers\ActiveRestrictController
{
    public $modelClass = 'app\models\Produto';

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className()
        ];
        return $behaviors;
    }
}
