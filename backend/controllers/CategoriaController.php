<?php

namespace app\controllers;

use Yii;
use app\models\Categoria;
use yii\filters\auth\HttpBearerAuth;

class CategoriaController extends \app\components\controllers\ActiveRestrictController
{
    public $modelClass = 'app\models\Categoria';

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className()
        ];
        return $behaviors;
    }
}
