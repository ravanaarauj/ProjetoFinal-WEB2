<?php

namespace app\controllers;

use Yii;
use app\models\User;
use yii\filters\auth\HttpBearerAuth;

class UserController extends \app\components\controllers\ActiveRestrictController
{
    public $modelClass = 'app\models\User';

    public function actionLogin()
    {
        $matricula = Yii::$app->request->post('matricula');
        $senha = Yii::$app->request->post('senha');
        $model = User::findOne(['matricula' => $matricula]);
        if ($model && $model->validatePassword($senha)) {
            $token = $model->newAccessToken();
            if ($token) {
                return ['token' => $token, 'usuario' => $model];
            }
        }

        throw new \yii\web\ForbiddenHttpException();
    }

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className(), 'except' => ['login', 'create']
        ];
        return $behaviors;
    }
}
