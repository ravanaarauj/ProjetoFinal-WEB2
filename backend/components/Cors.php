<?php

namespace app\components;

use Yii;

class Cors extends \yii\filters\Cors
{

    public function beforeAction($action)

    {
        if (Yii::$app->getRequest()->getMethod() === 'OPTIONS') {
            Yii::$app->getResponse()->getHeaders()->set('Allow', '*');
            Yii::$app->getResponse()->getHeaders()->set('Access-Control-Allow-Methods', 'GET, PUT, PATCH, DELETE, HEAD, OPTIONS');
        }

        return parent::beforeAction($action);
    }
}
