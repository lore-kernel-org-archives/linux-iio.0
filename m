Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013040.outbound.protection.outlook.com [40.107.44.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3BC3E5588;
	Fri, 17 Jul 2026 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281576; cv=fail; b=PBj33Hy2Fv8F/FgR/vTJC+GDVWuQF6qtS3WU2ScVPdbg6A3lHnYJZH1Js32RwFjBJdqM5AdlJ0VgkNCfXuhOXxy7mfphUaENCzmSEU+FxN1QT9EWmevyC4VkwNDaflbXscFmisWpimrJT4Yr7KDCn/8DpwonkB79FHfeYSNPGfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281576; c=relaxed/simple;
	bh=aEAIPC8urAx53WpXiUTWOANUj2LwyJQAhFqd2chc76Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cXIlXwt8z43nsr8N6ApSY7hl9XES/4XLQuZIrRDTI8PQXxp86ztHd+6sAvvPmWk+924Tb5lSvev2B4DoY3en92aHCRmpyKvOyr099P++96nvPeFOZo1PHEByQ/s8mLATXxo/oo8gc0otVFJyUuqi+iSM0arTijAryok0RzchzKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Rik8wkGQ; arc=fail smtp.client-ip=40.107.44.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Rik8wkGQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8qD3MNmvRExur5CgoJWmUl2ejLs/anyOiFNDAHYAdU/IIm51rAdhUvBGAIm3J22w8lc6J4rdzF9S0MVfXrK3rFxbOOCx6j3t/JG7d+Rw9nFyY/rG5jh0sgO5Z4gbo6GuC8SKcV45ZaZn1M91yh41XVZDkKl6HlbO2zDDyv64uWbbHm8eoBAVcR8l+ZTFp3wn4Rx5XcqQKMB/BsoV/q4YKd/kEe9qeWsLxGDQXONNe40F48D3WIvwdpGxmrKbGq44C0q5Fa3L/V2KyGCxt5xSdE9UInhAGDVYzyMcftulOl4ucwHFkMhWQG5iyMLQv9tSVtQmohBF9dc/rOiZG6h7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg0CzCq1g1h43z6SyXphX/pJGxReYOz6eVvBkK1UZI0=;
 b=V4JP55rMRb40ezFLKsipM1gsxvOD/Aj6MCGPfokmXA85BC+Y7YYufXsFDhGvZsDIevLfijcsLBH0fx09XkJHTJimcWFnNQZDaCzMGsP6WsTab8V+E/uSlSAjTgV3AxyGGvckljrT5ym8C+Mn1OHFdS8sK9AWLKvyMdpG/+xuVnCY3Z6c7LjSD8BzOGE5pEX9aboqCQippuTeG6ZJaNAwTyxdaFJrCQpC/rOGpa8lctRvJbK6X8zeh8BvPrLmTHy/p28AN36Q3EDkuDzg3dapEzsd1FFkukNo+F2+uhc4Rh15jM1m0nWrviuWRDY6JTav2/3TkbhasQDnCj1sRVCtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg0CzCq1g1h43z6SyXphX/pJGxReYOz6eVvBkK1UZI0=;
 b=Rik8wkGQ5rGq2bcOD2+BuzZ7okQfE52Xy6rOwsgiHDe7QO/1SzDscFINAqR6sF+WTDex3FagmQrQZlZxStOXMVT9S9R92iBIXX3sD1t60VrdDa8Zv26lARqx46mhfezBbpSPA32Yz49KeE7irSMcTMTnsXQofQenTxMJBlDZ0yXKZAUvbkjHrX0EJstEJ+psHmVe0It0na9Dw7jYClaWZb7zrbr+ua1NyAcAjhJCJqAG23m6QNffFK03cj1OPEFGVUF+X1CJ7H4NwYp7HDTPhoAsbHuQ1oXdi1xBzmeXrJj/Z3WrVL49E5IKRt9mwTZ6z00FC1S+qVf27E/cpUUmQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:09 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:09 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Danilo Krummrich <dakr@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Siratul Islam <email@sirat.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Miao Li <limiao@kylinos.cn>,
	linux-iio@vger.kernel.org (open list:ADXL355 THREE-AXIS DIGITAL ACCELEROMETER DRIVER),
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/13] iio: accel: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:24 +0800
Message-Id: <20260717094408.509583-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717094408.509583-1-panchuang@vivo.com>
References: <20260717094408.509583-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:405:379::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI2PR06MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 88afeaf6-5f75-4d90-5e8e-08dee3e83afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	PWQS8WjqVG10GkLh2slt6j4w6mEiYPp10R1etVoxWdvbDOYsr5MwqWDbsUQPIuTztJed84P62URlRisaAhMuxBMA1BrAbo8RbDzdjDwF8FflOnZ3ihV5pqfR1mjZ17zjfFcn+V/BLqC6tGHAIwuFgJApYXCjFzn5xnkIvd8HF5A92DPYXOCqDAL/YWZYMUwWTrNzmcDRMeeUGuREPq1SKYB78fwgyHbgIqdgShfI0EJ6ex1nnUYXCqRccNvPEEvrLiuF7C89SvhG1nCppLzySmXb7gBzFAJbgfDU+1dzjiOxMJ6lXYL0ZvBo87nxP/BOhfkE682o99pDvLjffgoQTBpkRQpKd2MqBxEG3lmKXQclzcOVC5PTI3uijaRWZ/CSVoMIO8mAK29+PVRkW/2sTIQYQh71GEsmoLBMPHiL5tF4xveKIKsFAoBP2hgN5gZpyFIuFt7prX3peLmPdo71rdHH8bpu6Gnjb5dQPioLS51Iu0dQYBiPgcly6+6swqZsTMXqU+Ir1BL9yDN93BUEqfnE1Is6g6XMCWeEOQ5YIJ628H6U4/tmFsFla8SyXkoe9noUXDf0sO5LkVrNK7Tm6JYkcztVuASKssBSfRMuiJVirUxD0Z/EEEJ7H5MUmp8mUE0UWe9XSkLtbDNfbKoBF79x6D4MRXAG2EFvMIkYZMKH/bm7L58he4TdyjIJOfZQV1GIjdOZ+bTtMPV6EkXI/LGmDEdXataJ+LMoebEoOeM3MoGmDsi/sPbGsBLFMSGS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xpJdKvStUfGCxXmjWlC0dod71FMSu8LMnN5dtI0A6SHmFT223ZhL/VRddF2G?=
 =?us-ascii?Q?MwxSlElKtJNBA/Ug1yU0pQEkX+XXPIwQ8NMPhfdPHqAmStZsM6pD026J3a4p?=
 =?us-ascii?Q?64VG1uCteJvmdXtVtgtEh46OyiAPidLF05gzWcyo0qWASnpjDorZoD8oYz4H?=
 =?us-ascii?Q?yeSMwEvabgUxfl/JWy47wNxZczc9hcheceDiTH3qfv9VPzEdm5yquWYXBbWi?=
 =?us-ascii?Q?9Xxi37diVUhlUzERs1ecms/Lsh63P+VvOKW6Hzn2Wi8OoXRMC4oUE8pYt3hV?=
 =?us-ascii?Q?/uRoj8o7Td1HjBYCRMaI2jJrBrUnwOGTDydo7/Uz1V9g0N6QfWlpuqMHLNZW?=
 =?us-ascii?Q?aAB6P161w28yE1lqLdkQVVQlvoGK/MoVhn3TUku57t62tfeFg7ubTr3a1/df?=
 =?us-ascii?Q?ghVaOu/3dHwr3FZuv0aTYhluOM6ro2yrCiNrS614bmSNI6mf6LOAWatc5yKE?=
 =?us-ascii?Q?DDKLqFzALiFdYGZIkps+8Bfh3M1sKnbJyEVM+ujTL8ekhGqNxFHlbeLmP+S1?=
 =?us-ascii?Q?0EIbL7u4Dodp99ewFcKBOPApiYjbXCcGoKx18334I/iHVTBmeORVbI19cBEI?=
 =?us-ascii?Q?MgvdwljD/bmDjrGcVVFWBDI1+Y0t60v1eZ+uqfqrH+xdZUE0OYN/kLYw5idp?=
 =?us-ascii?Q?0Pdptf7DXjXBvNFXFzHf6A64Cx5hooMQjAmiPxjn7wOkfrhkHNGP40TMoo25?=
 =?us-ascii?Q?q3IL2G4iYkyHjvW9GTbt1rcX3cjEm6H2/H2lIVD9TQG/Xodopq/50GdLBUVj?=
 =?us-ascii?Q?Cc50vGOLjXn0F7eQZ55UiUqhyJdQ8kpRMXJlcbGF2dRMSDxzVvcnD+uoDMQI?=
 =?us-ascii?Q?5n/VMCwJ/Nes+CF+893mlZyFZkmLcpkwYVpijyJ58o1/gRT45aYaaVpPRRpc?=
 =?us-ascii?Q?oquD9Q387oWgiMSxU/qAve/hC39nJxoRKndMzQV6fGQvnIH7X5GRktIpiD4X?=
 =?us-ascii?Q?vB33xqL5TU7HkpnuXXkDzzwHLbvTLpVKTFcwrBdEoDFZv1b4wATVO+bmpSYy?=
 =?us-ascii?Q?QXhF9/9TQNnG7EFCOFwJuv17hf7sJtNHlyiLIpkYbLkXWG7V1dwWxLQreE/f?=
 =?us-ascii?Q?PXldfiVjiHjT5Olb6aK5DSLmbXizCfz1rTqP4UiJ//RjRCfhIt6xo3CUgQCq?=
 =?us-ascii?Q?HEIQQUkwA/Zd7e+ztINnvhnYZ5KirwXDiDrSvM4qsNeSK/kcq3zHzWmC4pdS?=
 =?us-ascii?Q?QyWRaeXq/mHO83tvK9k80S9PCjaE6BbOwPvfcbAS2mQ4Deys12Y3pUp727PH?=
 =?us-ascii?Q?08XMNAzGgRIhmsAQTGqv9oGhRKUTMJ4x9cv6EOTrBUaxOvk8rlknX3yViP0o?=
 =?us-ascii?Q?TFRIeafmyiCAv4rDEN5GRaey71R4X2Mcq6AG0vwo+OK43S7VdqYgiL02/9H+?=
 =?us-ascii?Q?fVHqKLl/PW2aTCtFZdFDLrO0Ytaj+yhnwapLTJV/Ew5E7TSbuUvWj7/9P9NF?=
 =?us-ascii?Q?6wnJrHYHuLz6u2gAw8Y4FtxE5aITtlHSD7bEsp5Ty2GEE5dH2hDdSBLQK0EN?=
 =?us-ascii?Q?3+zktiTb8OPe+xwt7N2r/92bl9OTuY6D9g1Y5zP+I2f/QLnHIEAHouPs3QMZ?=
 =?us-ascii?Q?0eW7nhtH/qxI36VGr2mpal9yZ4KQaBQ0cia3PxZNsp8NJe08iajnRNTnY2Ns?=
 =?us-ascii?Q?3nj+GaJ2WMiGt+plaspbcZtaVEoj6DsbGhh41U0MNR4ZaNk2zGrxbzObeccG?=
 =?us-ascii?Q?T/4Ulq8w2hJq1plRC7qapRsglMBLROyeWmMjiKMuPlNhEpGKfOiHZ1oVvbs/?=
 =?us-ascii?Q?O64YEwivTw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88afeaf6-5f75-4d90-5e8e-08dee3e83afa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:09.5919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmhymDkh5CmEbecquWflhEhPeoeDo3AKUq8KvpXb0reGcedkQI+olWhc7OEh6zdX3gTskyWbp6h5LBZnVFdHsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"),
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
index 7d9cbfa01360..21e87c7b6f5d 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -420,10 +420,8 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 				NULL, mma9551_event_handler,
 				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				"mma9551_event", indio_dev);
-		if (ret < 0) {
-			dev_err(dev, "request irq %d failed\n", data->irqs[i]);
+		if (ret < 0)
 			return ret;
-		}
 
 		dev_dbg(dev, "gpio resource, no:%d irq:%d\n",
 			desc_to_gpio(gpio), data->irqs[i]);
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index ab43b1e0ff04..5d6c2dc83016 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1099,11 +1099,8 @@ static int mma9553_probe(struct i2c_client *client)
 						mma9553_event_handler,
 						IRQF_TRIGGER_RISING,
 						"mma9553_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+		if (ret < 0)
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
index ad4d11337f4b..77d8178ffa25 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -550,11 +550,8 @@ static int stk8312_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"stk8312_event",
 						indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+		if (ret < 0)
 			goto err_power_off;
-		}
 
 		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
 							   "%s-dev%d",
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 54638cd75ea7..643fac8aaf70 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -438,11 +438,8 @@ static int stk8ba50_probe(struct i2c_client *client)
 				       stk8ba50_data_rdy_trig_poll,
 				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
 				       "stk8ba50_event", indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+		if (ret < 0)
 			goto err_power_off;
-		}
 
 		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
 							   "%s-dev%d",
-- 
2.34.1

