Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013017.outbound.protection.outlook.com [40.107.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519F1419A4;
	Fri, 24 Jul 2026 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862380; cv=fail; b=UWn+dm5b3V3l43d6K4VBdBIpoLw/teOehatPzVXS3agy1YFDlC7NmxZxOdAqm8cguvPyMGHtEP3SADZ+9bhHKFDppW0wXGtHz99NjrUkQsXsw96rAZbdpMzf+83HxeWxhrb5CbEOi9Ipx77OjmNBAypN2eqbYZBsNgjh3rq+97M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862380; c=relaxed/simple;
	bh=38kdOIGnFJbDH+xS9qnMdRn5CQXDgMAVvGGcChoxKtU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCo97zclIA1NgwvLDa+prONIvn7qpDMeMy008oZe/faNF6Ps6kzaV8jIBt5IVcLMOvwknsrieS1TD4dBDeSeFp/wEkyJ2GnpHhKEGL88u48x2et5ZHTHn7dwlc+akIhEcPLLMj+kpwQucmEjZK2R48VXhA+meD3K+zutz0FH/vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=n99wHPd+; arc=fail smtp.client-ip=40.107.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="n99wHPd+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqV6360i58R0Ns1sm1GpSIMfIXmtaezv7A0gLSU8aDI4J2YZmWZMw4F3Pm7NXFL+JchOsU0PnBezl9rIFGqMkvIdQ5ndQkRGVT4O5BfXSauUhTgglYSoRaZi0f0XXVKI5AOMxHIQBG6ry4JfmFSd+huKDlVtrusJCRIynxo8xGswLu58O9gdA+s9Z57SNzBawLBJDsIw66+ImBjD+/lax8jDRkJitNfT5EYeN+31pFdkdxgoTMJEooJfth67eXqNbKcT/DpH2aGRHGrBsgwWkX4iw6SSWR57ZZ5AF5eaF8H4f+G/Xsqep72VKEVdl7MQI0EudkJ2WsWYSOSi/xKgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt3qrvnLKi9bnbu4e4Wd1RsN+mD5YdxJcptna2OnETs=;
 b=GNvk2TEoYHijzcQKb5x2hoGEtG8/Y5X56oOh/Qq2dPAsCD3svIi78QtkiYXmDQw0KYL0uJQX5oBzhS7CEzxoOZU/UAW6GvtD3Gd88vqvR3/LlmfI0GwUR21paQvPxGQVJSyBYY2zDrfGontBpSODOucbZrMjQO3d8aNqs5ancLNJdRBjjYs8/WbAgIKPvMxPKV7VoWsDEWtQV6HKSoXzXSB7zld7ZLeuJf/bNPSKkwN5YT5crozcrnVF9Z6l878PLmmb1XFNtfVRizVWfYD4nDKnwR/I068W1IutcI+0ZrhsC2WWbBvRcazTDX1Arg6zSzzeJKDfSL93MHpc0xpe5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt3qrvnLKi9bnbu4e4Wd1RsN+mD5YdxJcptna2OnETs=;
 b=n99wHPd+5v6HYtWXEG6bs2kAwDec+Ozh23RI2SSSOTjfjZbarXoTpNxie/cRpHu3Gd19otFA7LGrgJh9vvv/VEcEa8MaywGllHxqU9Unmc4zcxmTFK0LwKiYd8I9O7K6LobdNYaU9R2zrAMyQTWOpeJplkguCrV3J0+lGcC0kf1t+ZXIN8ekrXSWi3iSoN9rmGIlOz7P1PAuBBSpy2K+ivVa/JetwxmF7KTWuQqcjlvaXc57be6kHyC2DmYUOv8qQFMoqL3/QZAMZKJIsUGoGbQCJA/05EceIg6ZBOV6dl/fpxYsg1NexXby34mpD/0hxNLcBlZg9MmdK9B77QQnjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8717.apcprd06.prod.outlook.com (2603:1096:405:3d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:06:15 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:06:15 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Siratul Islam <email@sirat.me>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Miao Li <limiao@kylinos.cn>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-iio@vger.kernel.org (open list:ADXL355 THREE-AXIS DIGITAL ACCELEROMETER DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/13] iio: accel: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:36 +0800
Message-Id: <20260724030524.607185-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724030524.607185-1-panchuang@vivo.com>
References: <20260724030524.607185-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TYNPR06MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 786b1bce-e290-4145-b5b2-08dee930864b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	nyAh0zh4ja2/wWSPg6F7elyrb9BsR23ce8vURy84jU6NKh8XRCLiVZbeVpZF9g9YyUSSqyvhJyjJ6Kz3v345VHQKHO2HC0PXYGwFq0i4HeI2/kGKQUUXgsYjWUcOFmvF7XFhFjp+9gqSWF3egIUCNS51QeAoZdThWnQLpwYmaZS1KarDvFOWQy0JtrM53LIzrN0mgIiugqZUJYdrB5yM/vTpi8KjVnhNXUbFviLh7Ghuq+BN3XcO+5ToBPQAY8ZNihIcn+bDuvoOfKpSAinvq3/80QfxChXZu39bj2FV97nHPmeAoLWOB2tyBm1TUSgdr67jotWAVSE6QLE4FTClAgNQR+YnqHXaFbgk/qrVo3/0KaXNnn/VCrgexwQ+ICrT+QE4Y/GtHT/MvzoZmIPIze5NIucDy4hFor4oiOHo7NiDUeOGBgcVBSG7MH6emIgkRScdX47RhvW/ns4jhgtoFG1ny5MCT99dJwfydK6wWbRgert4GuM8Q4Qtu5QF4zbk2l3qZL7RiA+CuoV83wq8iSt7r5vSRSdPPs00hanOZaVlnOZRZzRhTK31xBWGg3mUyQlilrdpy76qsbxtpIuZ2902nQcoShBLteQcS8s1M5xn7e7RBzb+qTJgRbcDGn3RPd1TBfbGuPZeMyy/8QSiBQpU4H6WTXxhhtgKTPa2K1Fzs0CAlOTWkX/ifUhc11K5uhGkQP/yNXarhjLthpJhBi7aKVG9KJW2md/Al6VcdRUScPEhSZ21cpddHlzUy59o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZbAN2xGNZ1g8nUlvYnyPfxZSNv25elfIeTH1KMjIyvcy8pzKSig3SyTBs2Wq?=
 =?us-ascii?Q?gkgepqzNNL+EEmoW3MOuYiK5YtD1cW21Nh/yxhxVtLFlKf4bUF2PjY0a2UDY?=
 =?us-ascii?Q?oUieEqjU51ZJ1ovfw4zkeM9FKvkxUZJp5wQdq92Ph56pt7TdZcQWe04ocxPb?=
 =?us-ascii?Q?0ZtvkHIwCVCac5PdsIReWn43gDeGJvgQgOVRryb46GAj2SXUZ/w42tLqxo4B?=
 =?us-ascii?Q?60I9OeZRi92mj8EOViKUizRxf/eZgL7WIbbpzKFkNGQhneFL0IGDktxGy+IW?=
 =?us-ascii?Q?w0r0MkXeW5/7ATVwsfv0+RVDWI7vzZTmF+irsarSIZyX96zXCxyeNdcAi/11?=
 =?us-ascii?Q?0UGmerpNJ1iu3prNZUQfEWkrFO0nbITYwFuOI+x3jA+oh9mU2zmmo1/rSDP5?=
 =?us-ascii?Q?10l6XUxVPJjjgOOgXSjoEGhPsxkE7Rgj7gF+8ZqPvWd8ok7QvTvxVaRln47L?=
 =?us-ascii?Q?wp7oiLUB1B53bIXIN0iW1jmEm+xzY4smS40dNKEShQThJeMCIz6gYOMdPTnY?=
 =?us-ascii?Q?BSSyJAw09AkMqkcTCqW7VKEHCLq+rjHcOn/1kERliQTe/2Uk2aCrOpirmNk5?=
 =?us-ascii?Q?7wdatUodxeRHEHwhIrth5E7+1h2I2bpuoLUsyyNlee+/ag8EYTScDFNFY4Gq?=
 =?us-ascii?Q?YbTDGD7zfNCRVplodC0KS4U/QBAzK2aqd+3YrCegsN6aIIDuCxm3WtH2bexT?=
 =?us-ascii?Q?80gNTBuvEY6QdVTHTSWagYIFRMyzRTviawhZHDl/gx5HjcfcLFGzm6wD/vxP?=
 =?us-ascii?Q?MUdvVTn9QxEPZA1emFclHIfteMBdVu7reIIKqEtOCeWfXWvTmh8zwBCq7Kiu?=
 =?us-ascii?Q?ZSVe03GXTNCStDWs2LdkKMuiiEpXyd5ZcnL+ppJRCgf3LSm3DkH0gpHTGY3B?=
 =?us-ascii?Q?L2gGVgcROAdHOGGWls+ECBT47V+cg576slly7pbOaaA4KHEmwWkdSjFS4UiY?=
 =?us-ascii?Q?GPRTg33Elgf4sq2JN79L5PqTu6rpOk6tUzR0KfCMyA5KtqforGnGxqlog9xj?=
 =?us-ascii?Q?T0R2T+JEVpDqxa8SkzAZ2xV4Ja76nyH4qvM4aGQVx5aAnQYk8kUUwpwAbLOM?=
 =?us-ascii?Q?i03UFv5wuT7pJiKXp5yHpUKKQTucEsNgZLHsX/cciF2ywx7MwybZGV2UthqH?=
 =?us-ascii?Q?QOacTo3wVWnWgCxIgoiDtrSc98KrNdYy450rXzBUAUfZl/fiCTgrj5XiX+4C?=
 =?us-ascii?Q?KTTL8Uv/uN0KfRCUT0aBhB+iMeQa4rmjaOfjtg2hhqgbQh26Ail27oGsNrrv?=
 =?us-ascii?Q?CLpIeNaKFQtRC2JuPdw5uZ7ukXJKjBEo1Z+Q7nUrNcjEGrXM415DGqOQDpwE?=
 =?us-ascii?Q?HNBResE80UQn1QkjrviOc5htX+9A8UMMDZAgbw+WjO4m23IlZev7//soYYaO?=
 =?us-ascii?Q?EeYOODrbQstTQCMAtLlaDZl8/mn2732o1DjkFJEOuGbygVJzTKTSCO/HR0hq?=
 =?us-ascii?Q?xbEfpGuomwb6d2RTQGCq4cNCAw9Z/INY8HJRx/qVpXZ174AC8cvj1ERhmXb5?=
 =?us-ascii?Q?oCm70gi+5Tbua+1Us06FPZyCgalSuX1gL1vDDmzXZVmjUsBsSW96ygxOJK6y?=
 =?us-ascii?Q?B54V6OLA8ZAcJQXIN1FrfA4HCWPDz8htxDFDzzJqywG6W8XEMB5nvbbpsXg4?=
 =?us-ascii?Q?h1/YPuii10AZtQOv00MJZQCinKzVgrtl+KyrzRBRt++KdVwAy56g1+YXRCws?=
 =?us-ascii?Q?IawTtow9WW4FWxW8lN3YeCZE7g5VXbdfqqBXCeGvoV3c1qPdOLck41wy5TZj?=
 =?us-ascii?Q?P6gEiV2M/Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786b1bce-e290-4145-b5b2-08dee930864b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:06:15.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0xTi2hPr0QIhBX+SfmgGQUUe675hFl/IJVtIQx9mH70IOZJVaSkxc7/ojNLqF7ugHzomIk0XLc2cR2nFFDJCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8717

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/accel/adxl355_core.c  | 3 +--
 drivers/iio/accel/adxl367.c       | 2 +-
 drivers/iio/accel/bma180.c        | 4 +---
 drivers/iio/accel/bma220_core.c   | 3 +--
 drivers/iio/accel/bma400_core.c   | 3 +--
 drivers/iio/accel/kionix-kx022a.c | 2 +-
 drivers/iio/accel/mma9551.c       | 4 +---
 drivers/iio/accel/mma9553.c       | 5 +----
 drivers/iio/accel/msa311.c        | 2 +-
 drivers/iio/accel/mxc4005.c       | 5 +----
 drivers/iio/accel/stk8312.c       | 5 +----
 drivers/iio/accel/stk8ba50.c      | 5 +----
 12 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 68cb2557f390..080c9f6f9a11 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -768,8 +768,7 @@ static int adxl355_probe_trigger(struct iio_dev *indio_dev, int irq)
 	ret = devm_request_irq(data->dev, irq, &iio_trigger_generic_data_rdy_poll,
 			       IRQF_NO_THREAD, "adxl355_irq", data->dready_trig);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
-				     irq);
+		return ret;
 
 	ret = devm_iio_trigger_register(data->dev, data->dready_trig);
 	if (ret)
diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 8c3de11a10a3..4ff1c7a0988b 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -1486,7 +1486,7 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 					adxl367_irq_handler, IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
 	if (ret)
-		return dev_err_probe(st->dev, ret, "Failed to request irq\n");
+		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 62bda8d76691..e7dbbd4766dd 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -988,10 +988,8 @@ static int bma180_probe(struct i2c_client *client)
 				       iio_trigger_generic_data_rdy_poll,
 				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
 				       "bma180_event", data->trig);
-		if (ret) {
-			dev_err(dev, "unable to request IRQ\n");
+		if (ret)
 			goto err_trigger_free;
-		}
 
 		data->trig->ops = &bma180_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 269e2b720ddb..b83abfdd84fd 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -544,8 +544,7 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 						&bma220_irq_handler, IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "request irq %d failed\n", irq);
+			return ret;
 	}
 
 	ret = devm_add_action_or_reset(dev, bma220_deinit, data);
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 05f72707f830..7e3cff4cca91 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1789,8 +1789,7 @@ int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
 						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
 		if (ret)
-			return dev_err_probe(data->dev, ret,
-					     "request irq %d failed\n", irq);
+			return ret;
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 39485572a76b..02dd1db7a646 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1435,7 +1435,7 @@ int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chi
 					&kx022a_irq_thread_handler,
 					IRQF_ONESHOT, name, idev);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
+		return ret;
 
 	ret = devm_iio_trigger_register(dev, indio_trig);
 	if (ret)
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 7d9cbfa01360..7e01427fd9c4 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -420,10 +420,8 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 				NULL, mma9551_event_handler,
 				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				"mma9551_event", indio_dev);
-		if (ret < 0) {
-			dev_err(dev, "request irq %d failed\n", data->irqs[i]);
+		if (ret)
 			return ret;
-		}
 
 		dev_dbg(dev, "gpio resource, no:%d irq:%d\n",
 			desc_to_gpio(gpio), data->irqs[i]);
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index ab43b1e0ff04..8e7aaac89d47 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1099,11 +1099,8 @@ static int mma9553_probe(struct i2c_client *client)
 						mma9553_event_handler,
 						IRQF_TRIGGER_RISING,
 						"mma9553_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+		if (ret)
 			goto out_poweroff;
-		}
 	}
 
 	ret = pm_runtime_set_active(&client->dev);
diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index e0e73b87cba8..caf9b1b6397f 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -1059,7 +1059,7 @@ static int msa311_setup_interrupts(struct msa311_priv *msa311)
 					msa311_irq_thread, IRQF_ONESHOT,
 					msa311->chip_name, indio_dev);
 	if (err)
-		return dev_err_probe(dev, err, "failed to request IRQ\n");
+		return err;
 
 	trig = devm_iio_trigger_alloc(dev, "%s-new-data", msa311->chip_name);
 	if (!trig)
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 2034fe92bae3..a66fee828ec1 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -489,11 +489,8 @@ static int mxc4005_probe(struct i2c_client *client)
 				       iio_trigger_generic_data_rdy_poll,
 				       IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
 				       "mxc4005_event", data->dready_trig);
-		if (ret) {
-			dev_err(&client->dev,
-				"failed to init threaded irq\n");
+		if (ret)
 			return ret;
-		}
 
 		data->dready_trig->ops = &mxc4005_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index ad4d11337f4b..50840c3440c4 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -550,11 +550,8 @@ static int stk8312_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"stk8312_event",
 						indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+		if (ret)
 			goto err_power_off;
-		}
 
 		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
 							   "%s-dev%d",
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 54638cd75ea7..6c1e286c0a1d 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -438,11 +438,8 @@ static int stk8ba50_probe(struct i2c_client *client)
 				       stk8ba50_data_rdy_trig_poll,
 				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
 				       "stk8ba50_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+		if (ret)
 			goto err_power_off;
-		}
 
 		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
 							   "%s-dev%d",
-- 
2.34.1

