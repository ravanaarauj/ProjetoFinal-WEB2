<?php

namespace app\controllers;

use Yii;
use app\models\Fornecedor;
use yii\filters\auth\HttpBearerAuth;

class FornecedorController extends \app\components\controllers\ActiveRestrictController
{
    public $modelClass = 'app\models\Fornecedor';

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className()
        ];
        return $behaviors;
    }
}
