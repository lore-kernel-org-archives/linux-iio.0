Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013066.outbound.protection.outlook.com [52.101.127.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA6376BC1;
	Fri, 24 Jul 2026 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862430; cv=fail; b=G58XQ1T8cw8gcGmKDYMb1Vs4jq2Fhd4UfKzeXr+iQCe3i9N5OzrhsXC0JrbzKDWtWza6hwLmZGEFxReeRUh4gDMPBYE6KztjCUC7jZesZtvBVdhe8JRpGmZ4vvlXeFWAncT2wWeoarrxqpubwRH2vzgt3gpi5Io9vNJVYN5JlKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862430; c=relaxed/simple;
	bh=4ok+WkoZcpqZlKIi/nOLBGvxuqmyaWKdIwKUOJO0NrI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dl1Ic7G0d+/zawzmw0li9F/68n7V/9ucegquHF83DgLunJttgxzF46fVSNpS2r4E5PeqrjqmB6Tqt3RK0mwEq4FRkIk1E6vt7G4GJWC1hkGZPoiPyKt5Njh20vUp5erovitFiARF4aJT3wg2KqaXlR+zzMjE6XjkMni7RzpmyIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PPKtyaWP; arc=fail smtp.client-ip=52.101.127.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PPKtyaWP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STOBtSf9sFIpNHbbZSK9eAo8NXh1Nokr8ParsyzVZm0/JbyRexPcMf2u27IlyDdKpBbo0lTTt6Rf4Cqz6rNaJJ+mG3ywiu5dlNTC5tgTCA7QG3w5CzIMHy2Za8WGdaSnmr0VJbqZkkNFt1V3TY4A4U6BlJokVoUKaNwOz7iXyl+/6VvISNZWakiLTbgQCyGN+2zuG8mCsIOoRdvOV7JUFN+Ewqc2+sac6q/VCZ/5/GGXQTx7BEDh34Pp3sdKamzzgUHKfAx6yT5qNRk92s/+XD1HO4NkS5MAW7FR3rNRvCxmq7IiSRL8YLxmcJS0jxd83SUJqyPfx0wORBGnlOaGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYUmmHOLGowsqGfplBWF7ZxUewLXzT43nUOWtk7k8xw=;
 b=glXBo68vkHZ/fIpFCzMHVhDYsQCSMust8IUnX9i+PWJcscPf4fT91y92JrD6r3dTBvhvZxQrAIVZ7ZjnEyWdqX6ZfQCGrbOtYfbNfc6U6Lr31wuopT+6b+r4j08XyZrBsDJY2+MZA0br+KuiDGaT3sTURgcIM4be672R2yTwVvO99Qq9WQyBpHYj8OjAPicYGwiIUYJXVwpvsXq5GodoklvOjMHpW0qbTVexsiAZVWHXA3T26kinPBCc4s6gj62Z/22sWptL51pEFh3S4GAS/wTve9VzQgZUgcsSL/qgTClmFoXN9IxDvjtWVHXa9cqksSt/xDcUpMMnwhbscJ+VNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYUmmHOLGowsqGfplBWF7ZxUewLXzT43nUOWtk7k8xw=;
 b=PPKtyaWPkH3fDK7HDYRJ5fZYHqKhyoLAPbj8Kjzm0fSpRyHnAJGTC0qqR86PYK3ckrm1J6Xv0EiE6FQyXsm6ly7CrqTIqGzMCjUl+i8SZRtqp+RHDHsjxzj3qSHRnuwiyM35J14sdbFS2sb0zVort0a8oE4biuYweNkSL8n2Ogg7sBNl8RUHwigTtwQMGshm9n/HhlhY309eLmeA4nnWf5DPdusdYtaGegNEu7On9WrXsvjlEocVO7D3BYLedVN3AVN52lEf4UzloZTY0Q5fKxi2+c9Hnl5Re+finwmf/lwJkmId0jngUIs2AD4QDt7JbgxEtrPY60iq05G80NHLoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPFE340CD3DF.apcprd06.prod.outlook.com (2603:1096:408::92d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:07:06 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:07:05 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Salah Triki <salah.triki@gmail.com>,
	Yash Suthar <yashsuthar983@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Carlier <devnexen@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>,
	Pan Chuang <panchuang@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shi Hao <i.shihao.999@gmail.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 10/13] iio: pressure: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:45 +0800
Message-Id: <20260724030524.607185-11-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY1PPFE340CD3DF:EE_
X-MS-Office365-Filtering-Correlation-Id: b61bfd6d-3551-4ad0-bd73-08dee930a42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|23010399003|10067099003|11063799006|56012099006|921020|38350700014|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GpJHW6I3ZN4NTR46/bn7n9YIPk6uwJ5sq4nJE3qY/j5jXqicfntgtIMzybGMC2RUM8ESb5LlLKL1TKlzaOt5sM+SQBcP/lx+samZVxghd1dS3A2KDmKJOqTFV7LGA1PtISev21S5ZddH8yLc7DPVVNxZz1z04Hj5MKjNhr02fn6w7G7YKgzTyzyMY9S1atlXQFZBoULG75NVUtbCq9HGsEptdtObv3RnNnjXhlUbubOx/9LjUmLaN4wYzEBKR3sTXzbl0y8mhLT14n+Nxadt0EVQJ4u2vCXwLdD6v/lPWMaAbVj1ZAOvUQOtSwJo9S09X+YkCIqKz/idEEkFnpwU2NJACVpN3JD+t3MX1KnUyp70D+pJf7UWiBgWSu8JNQdscTnzgoNekyA68zK4piLMuo7ZXO0IMIHeHZNWBdSQmQboQ675dhpP2f43R4oGbfrs5RJeoQUTVFBv9q5wswbTK+N//A3WbqrO+h3U4HR9q0W84uXUoUCTT1KHBG43i64mUYfnFegxXKu99dUkNScMwU8XsstqhFhWKF4ZbnqEgwsXJif4Vyd2ufykmH/AN31DfFn+Yq4pQ7auIfVqSY36WL78BLs2rcGZE/tC28azR1KuyF8qarlO3T/NcOzTyWnL2VtP31HITPZexphdoXtATpugPkDrBnkUta4MXrf79cHaohDnz+RfB0wUEuRP95IRQcEhWPP4ceJ2gM8pP1oNvZQs0YPBJULS4eZpTuurgDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eY7tAbtqa4rVJdULnb/LnZXwCVBhWUuE8YmlO0PrK0hPqfyLUIUiqR3vQz5O?=
 =?us-ascii?Q?IKPMGLFaMAhdYo8eS5nNOr25G+XCN9gyo0MMfzAmDS1nyH3VDgjSY5q5YwCP?=
 =?us-ascii?Q?p5kHKz5JKahKKR692jun9lX9iYbw8ymM/tousyaYYaHoSjg0JfnZiACT9r/3?=
 =?us-ascii?Q?Smy0Q0RSaX3c3RsC2UBMG0Db++FL5RmiXnIKf1LQH4AkLNy1yjHh85FkCPX4?=
 =?us-ascii?Q?nHmSgkjjlViP4VLII2IkD98boNOtkrNFAo43aT62eeyyzwo+G5K7ZTqkbwS7?=
 =?us-ascii?Q?n+pkI+Lr/Q+SUGbojMaaRgBeke/kVrUAdGQg8DQpWmg4sOLCu6jtP9SeBubR?=
 =?us-ascii?Q?IV/bx2aNGF6BQIXnu5hj84h7awCzWo0jbhuT8LYNa7QV2WpWusc0yf0mEbvZ?=
 =?us-ascii?Q?89YD9lsZKu5vunArUhI84umgLLimph54uHvrgoZzfwXsdXu7GTnayPnoP2mU?=
 =?us-ascii?Q?+xRNdAFpZ8eZnLgWVv6CtsIa7PoHvey1DOUtzScuRd32w1NpdycLoRB2TOAg?=
 =?us-ascii?Q?DrbMdm8YjwYbelVyZ8CXk8wOiNyOiniMH1HgtWCcTnkz6p4SrMI3OOdZuVIh?=
 =?us-ascii?Q?q8bRKp3oesT7cZtrXGcSr6WjxtZmk/mS1dkAzIs2cfEKiT1wr4ioMijVHbCp?=
 =?us-ascii?Q?yuxcKU0FnOEnNy3rZyiTinbIqz4MzRmYGMRdP7UJ7Z0mzfSX8vyDLJ5QQfYn?=
 =?us-ascii?Q?xndQ6WS9fhFtSv70xHTpb++Vtd3bNTGs+kZ44H/AE5ZMIxcT5nntNaE0Jdjl?=
 =?us-ascii?Q?Gdx1IHCDU53gA9iMg3exOr1LTJERXBBwaM6Q+k3fQnMx53wKZVHBWkEDzaoc?=
 =?us-ascii?Q?lR5Il9ODxJajqL012YHySVzhhmSFBpxYBwt0TtfLtoMfzTBI94zJLto9z+R9?=
 =?us-ascii?Q?bgLx1G0ZX20HT0kpP4ZudmtCGRQb89HRrOj+FZv+CS5nWGzyGvTPdDaIxKWX?=
 =?us-ascii?Q?fOIgqBRtqycAGLGb9c+HpvqyLEV8QhMDNBan9MaMdK7EXBcx3zkp4J3xs4Zj?=
 =?us-ascii?Q?Trfa15Se3na3yEBaV3pboQv2BeT1Fph0vCteobG+9LPpjtmrwYe9XmOQgVsq?=
 =?us-ascii?Q?wZ4VF3P4QiwnbRwYUsKJyFBo/ABmDlAGp2f2hE9/SIf14DKtW5mgzq2SObGm?=
 =?us-ascii?Q?k2XDL/EpqRURk3T/wcGG4JBTv6AsZQ5WI/fyEFz/J3fEB+JA+MgptN3uIcSf?=
 =?us-ascii?Q?eAyF5ry6qRE1pXSfA9jAgLI5Ep0PA1XMrWeRk2AG0EXpRxLlVyjJn7A5R25C?=
 =?us-ascii?Q?Gb80vWSkEYr/Gl6BHrYKE0GPX2x4fgOq0eQXR6FspEEDB22ebGNGZCkVLnfW?=
 =?us-ascii?Q?d+BFOJzOeZ4XB15hVaMLU4UoIRagB+BZxKWQv+HK5tG/aGSbA6RycelScKBz?=
 =?us-ascii?Q?LAeVeml+KSGkN8EDReNJDLCOAErhjsNoyWi6V6JWdcfU7+8Z3ZBKBUWn+I2E?=
 =?us-ascii?Q?D0al9vqCT+sE5E/KhTqM+q4jBBZLsC3wxh1YuluedMfQatR1l99s3/CiPf3C?=
 =?us-ascii?Q?ffxB8115xfws8kom730dilKwfyIEjuiGxlbCvmYlj1f2oBWpnxtY/55dh9IK?=
 =?us-ascii?Q?/NidgkReqe9VqH5rcux+G26Vya2J0yVWRYh9HQd01RioiKJgU9ccPub/MCu6?=
 =?us-ascii?Q?BVsSe43TwA7gZZ1YMGX3YmewiUWd24rfQIjMK4e2OdqYm9M7yOfGzDdntlAp?=
 =?us-ascii?Q?JNfXp+dnzbdBMkXbHvmZOeSbHYWKFUCvvog8NuPpU5ti4vry4e+xTftx/iGe?=
 =?us-ascii?Q?x4MpNRp3cg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61bfd6d-3551-4ad0-bd73-08dee930a42e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:07:05.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr2KRF3tPfeUKoQwPVWG34eBeJjAiEB830BmTLh31pEa5SkXMtCnDPam/wd6oVvQOZStAI+R5bOBP+TrlCyFpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFE340CD3DF

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 drivers/iio/pressure/dlhl60d.c     | 4 +---
 drivers/iio/pressure/rohm-bm1390.c | 2 +-
 drivers/iio/pressure/zpa2326.c     | 5 +----
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c89153dcc323..1066792b9087 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1339,7 +1339,7 @@ static int __bmp280_trigger_probe(struct iio_dev *indio_dev,
 					irq_thread_handler, IRQF_ONESHOT,
 					indio_dev->name, indio_dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "request IRQ failed.\n");
+		return ret;
 
 	ret = devm_iio_trigger_register(data->dev, data->trig);
 	if (ret)
diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 01a873165923..961888fd03a7 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -309,10 +309,8 @@ static int dlh_probe(struct i2c_client *client)
 		ret = devm_request_irq(&client->dev, client->irq, dlh_interrupt,
 				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
 				       st->info->name, indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "failed to allocate threaded irq");
+		if (ret)
 			return ret;
-		}
 
 		st->use_interrupt = true;
 		init_completion(&st->completion);
diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 9d72ae64126c..57941fb4a535 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -805,7 +805,7 @@ static int bm1390_setup_trigger(struct bm1390_data *data, struct iio_dev *idev,
 					&bm1390_irq_thread_handler,
 					IRQF_ONESHOT, name, idev);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
+		return ret;
 
 
 	ret = devm_iio_trigger_register(data->dev, itrig);
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 2c68fdf2744e..b38493ff3b8b 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -911,11 +911,8 @@ static int zpa2326_init_managed_irq(struct device          *parent,
 					zpa2326_handle_threaded_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					dev_name(parent), indio_dev);
-	if (err) {
-		dev_err(parent, "failed to request interrupt %d (%d)", irq,
-			err);
+	if (err)
 		return err;
-	}
 
 	dev_info(parent, "using interrupt %d", irq);
 
-- 
2.34.1

