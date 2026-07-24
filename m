Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013009.outbound.protection.outlook.com [40.107.44.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE044372B41;
	Fri, 24 Jul 2026 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862451; cv=fail; b=bwJJ+Axg7zrktF6rd/1e8EwNdowF04yrHsrLIqdRnev2hLUzqntsxsOupZ5ZWIqYzYge1y0Mj5gTrPuIx4Aav/DzBEeATJE/m6hyVDRQhn8kl3p2rBFzZcRh0muAVjrPBwYxsa+tllVxv/RfPN2oorF/vVuUvfxRchCNeT4PQUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862451; c=relaxed/simple;
	bh=zcFli1Ht3RGGdefN6p5NQH87nshvSbDbtK5qwHC0AIk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OwoYBlN5HtN61/qHcyEis++BBm5DKnZN/cnTGBoSWqCdSNfZgJrWyuCLlJa4JiCloxze/gPzR+eMn48fpxelbhn1HIZn8DreGAjwyl9gaDOod2NiMFAQQFaFPXghM8DiWLcx8CHUm8Yqp5Jb/gEA6EYpR7vC0yrmE+2GA5P/hKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lRw5UXJq; arc=fail smtp.client-ip=40.107.44.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lRw5UXJq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+UfC13a+6pEu/vtOKLc+AS8s3/2ZT6cYuQ3JFJzJZ+B7+lirnYN+X44Nc0s8i/y+Xd+nbmJaR0sWHvek5z+75kndvjahZcsCR22E/aT3UML5kXIBgpRpjXahyoCGCLjpM62+Y3K8DAlD1WWJ/6sr7ExhaMUTnDOyZc5QrwjGm+b14xiZfC8gpXJg52IKOtI6Sx9pqOBw+lwqG/iu+v51Swgztj1MNqflzV1IXt3cQ7EMIw6+AlWutCM/B5IL3/6nhSTTXhaEXY+Af+0w+aZueeuWdr9SnUfr7xChKC+ctt+2B0QlzZkRE0Y6ktriBZGlk9myiN5E2SMOAm+dF3Yeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgHqUPIx78uGNeQBCMSMJhnsa+yglM3p9Gh/moTPMJo=;
 b=NByzG+1TeH1CCOa/HQupUOY0SUxkOP6FE6v7ThGhiwzx3xJ3NzXmfKE81i2khJXUiRdYo1kcfJIU4aiCBy+jKZCEnCmSJ1dhuciAQ4BLmgBdlfqtp0NGZVLpY7c/IYdXoFLub5vwuslPfL26YXd5ftCjxvcPA7mxRB5PcrZWq82gyVX8tm7qfn7D4EWlpONbvQrgnAT+yEE6/HG3JBB2pjWEqWQ4LGu05sEpcMbfir933F4jyaUz0kL+LcLfN+Rzw+snTNAmmEiuhL5ZrKeyj2c8+uME7HO432hmbrJdeKRjJoV8AXbyv1LAz3Ys0hTvpeX9GqYpHAkqmEYzUKgpOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgHqUPIx78uGNeQBCMSMJhnsa+yglM3p9Gh/moTPMJo=;
 b=lRw5UXJqffyqMOqBJN68enD7/S2xbx2veK9UZ19xbe0wVQwfYWAEeuzsWzlVQMlCzka5//PQfyY1lR+IS2mF1etxjCt5I+IswyJC1TlQd+g3Wo+Cs+ottBHMxmt7XESRgM4BhPxBTnx7c5cKD20Aau9pEJSl7dqGD1nkqaLByUjHVVNysgsvBBSWeEN0qgy8ihbMTpBACNSt/vo+sv1nhWBKmY7p+iB9YQDr3DYY3eGDW2Jo9DjmaJheooaJ9LN8UsQwUDdqbOkBnSI/8kodCPua7Rw0RaCePLqDJI8QiVAve0AKB8/l8RsFceFguuwh8j6ab6TLCdJAIt1VGrY9uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPFE340CD3DF.apcprd06.prod.outlook.com (2603:1096:408::92d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:07:26 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:07:26 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Song Qiang <songqiang1304521@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Pan Chuang <panchuang@vivo.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 11/13] iio: proximity: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:46 +0800
Message-Id: <20260724030524.607185-12-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c478b6b7-17b4-4bde-2dd7-08dee930b089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|23010399003|10067099003|11063799006|56012099006|921020|38350700014|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rLJPD7GedzagvdT0Ky04GGcQyGrJ4vypqHco+4tnE6+Lg6bDl9O/VzemPuqfzklKam5QSzwDdLHSERuDoaG24xfo9fOCDrsIL87/NL6AJCuAs0EPAqUIjFhrfs150YJpQbGnWjqENl2fKRTtcXCCCwnS3MeR7c+TN2YTcjVabpSQaFODDncetos1bMbkYTxhk2LBjy8jvGsgoMkVFww7VW113ZyX2f9K4iTctmwITX4l7qskcoVN9WniCBcxNinP0KF2kEMtR8+XYnNWyra9mDOvDtYvdwQtLNY9ua48mXKqmh3jbRKAD/7wbMlqcN/N1xtbXPmZF8Jauxz0s6GL5oxBzZOdWnsdbudkuP4gudHQjVsutKw4wytDFO/sFfuCcFcWztc00uu123+hkbMOsxGKeiZLRsGBAHx3Dt/7Wcgxd2a3P9i8mC3qPFFSRTohF1tE7wZqcWMZyoKvgvHpwP4mqSvx9zwCC7VC256xXhGnabJnsAMGkFGFSJEVQY+AuL+F9EH6X+rliaR/uwgDb4YwJC6JhFv66O8wvPJe/L1Blnc/XOdnKpXus6/SCu4rph6j3VUKot+1gmPyyY9pytasTznnBeX67Upyjz172y/+LzKS2gKyorglf1fMbVd4PB6fp3f6jz2BdUyVJi8kiDbPdXxsVfxCyfWTi02U0uYemosQ0Ld2e77QdUghVrObN4/kOWJ+SPzLLJFFTMWVwk6BhR0rCimzzOSuSZQyl/RSthrUdqjHwVDuhqHb8fb+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jOlZGwoJNH2f2DBbE0N34oZDrIJH2HNgC+VPpdeeBeWeJyiAIGw6mwSgqBIM?=
 =?us-ascii?Q?Zd7cXW6lfsTuczeOSbijoDw+/xaUv7GsDSLJzxexsW210jiasrJs6MqdWQET?=
 =?us-ascii?Q?U3SwAEs27byEQSPbz8cWxRp6vwa5C9tiEL7Js7RQ+EbpF0ZcB53d7hIqFQx5?=
 =?us-ascii?Q?pA2YcKxN0+uIrgjTD32hrKgr096uja9++eLpZpri8z0oF3IYSrjD+wkoLJ50?=
 =?us-ascii?Q?8A0XWFYCxD7n3KCiokdOnHVcr1vha7wH6C+3diRSxfyimVIvM0Fwvh79LM8M?=
 =?us-ascii?Q?X9klrT2NIqKOFjtZ54Q7lM64CbgJNIdXBI0wVlQ4AQCi6py9bC03GiF2eFuF?=
 =?us-ascii?Q?JnWDFg/8NVEC8vDjAreaq4CyiRbFuIll1vFiX8G25BoC2D5OJnOd2xiPNWUL?=
 =?us-ascii?Q?0DXSslpg7QWg9Lr2YM9KpuA6g8MsdoxJLbO92kvx5J4hkn8z3OxWBSkHvcmV?=
 =?us-ascii?Q?pniY6nrgk+3g5b/BJ8Z4NmdnRf3ZMW6P35dbyMEA6+Asbm8270ePKrkjUsSA?=
 =?us-ascii?Q?IkmV2pHAkIUGZLDz19+g/hwlC8KK8iVD3ec9eOgKnqZULlFOPRIKbMCJxsht?=
 =?us-ascii?Q?zpa9jaGTyuumt5Zoazwe3p0kuuwRjajrlh0609yA5+hI/QT7CfI7gECrOQfx?=
 =?us-ascii?Q?wc/lTZ2VwUTyarHgi/s0PYo2plxDdrjVgm9ZTm7sh82nNuofw0hJMTV8C9e4?=
 =?us-ascii?Q?FmLB0q/v0WHH15aezHlgZ9M1eSxMZXQOM3pUHUJ0ZTaeXsty3ZwhlIOsUhA7?=
 =?us-ascii?Q?D7BwDoAu/yYq2gxOGuhityx9XCzpA9zmYFFuYK3MIOm70/+WlU07MdO2TU1a?=
 =?us-ascii?Q?LBsJkA6b74OOgk7vUzwSp6RnZ8qXl0QWWxp9pZfKiaN2YHwV1NvubYEZM2nP?=
 =?us-ascii?Q?9LnX8ztAuwdEH8zOstfn9vLS91GV2rG9BJavxuXkgytroPudFm+m8uPr9QCM?=
 =?us-ascii?Q?3lAomikzqIBpJB6KnCmJZyk0KXQhQOWFBAX/jFPoYnL00KJN4mu5wOe5yUIL?=
 =?us-ascii?Q?8dtWRmPegpL9RVXvdScJHOjsnEgcKQc+D5KOVCtPY03hO3m9ZWEEckH7e3y2?=
 =?us-ascii?Q?1f00CSGr/f2SIK49rpRPxovt/4AhFzvK00ulZ/+dwx1jS/Mhg7wGxuV40kyK?=
 =?us-ascii?Q?PtrrJJrbKt8XUm23AfDI9VOZXZlh9ReFBGrl8KI5e6LtPKl5hyJCofbT0A4Q?=
 =?us-ascii?Q?Q6l53u4LhBg4/NXq3kTxjXkw5XTCTzyj/ZY719UDTa6j0q2HN/GDpas5JmA2?=
 =?us-ascii?Q?fkIvp/ZyXrt4WjFCm/HduowltSCC02CPmWiOFO8nOfp2z+PqMjX/ftQfBzOR?=
 =?us-ascii?Q?FuJQApe7pHY7QgS0Ef0vK8rVfqj7raVKIKa6nX2dTjqtx3p8f+1STHXZSp2g?=
 =?us-ascii?Q?HxrKoCJkTYWyiVLNu6yX260L/vUMxzkHbFRVogZZBKM9f1WEsyq5xcYOWGwx?=
 =?us-ascii?Q?mrdaCQb6BT34AYe/5wGIuffPYk/zCPkV4t6cQQ84wHrZKBF/k0QljBDMx7Sz?=
 =?us-ascii?Q?RVc4pIpZLHypDm0FVFixj/Ds39XfJ9Blw+i9VYy8khqUMYVD4V3IifmlD0IP?=
 =?us-ascii?Q?2JlD0m0Ddv32ZuWWN1iOBzpp4TLkBLcPmUngP1Dszlwu+a63iKEW82OIa40n?=
 =?us-ascii?Q?pIS9KVv5Dew2xZPZemqrHoOzSzKX9KHPge93r6fzzDgTW1oo8ljVoDhtBCsr?=
 =?us-ascii?Q?HpFcKlEc/jWl3htQSPocggiQDbpI6zxp72yxKBlxmygmxGd0b2OVyOsBkFqO?=
 =?us-ascii?Q?ZzEE/zj4Ew=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c478b6b7-17b4-4bde-2dd7-08dee930b089
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:07:26.4656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We0RCqDa19dpcPuqwTVbwc7igviPclOoVDdA1nv6wH8wFcSXO68AFgkqMvKq8jcfO0UTn5uJ4DFo78vTNJJfvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFE340CD3DF

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/proximity/as3935.c      | 4 +---
 drivers/iio/proximity/d3323aa.c     | 2 +-
 drivers/iio/proximity/hx9023s.c     | 2 +-
 drivers/iio/proximity/irsd200.c     | 2 +-
 drivers/iio/proximity/mb1232.c      | 4 +---
 drivers/iio/proximity/srf04.c       | 4 +---
 drivers/iio/proximity/sx_common.c   | 2 +-
 drivers/iio/proximity/vcnl3020.c    | 6 +-----
 drivers/iio/proximity/vl53l0x-i2c.c | 4 +---
 9 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 93833037bc94..d7f43c3af165 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -428,10 +428,8 @@ static int as3935_probe(struct spi_device *spi)
 				dev_name(dev),
 				indio_dev);
 
-	if (ret) {
-		dev_err(dev, "unable to request irq\n");
+	if (ret)
 		return ret;
-	}
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0) {
diff --git a/drivers/iio/proximity/d3323aa.c b/drivers/iio/proximity/d3323aa.c
index d40e3dff9eb1..1f43c1fed342 100644
--- a/drivers/iio/proximity/d3323aa.c
+++ b/drivers/iio/proximity/d3323aa.c
@@ -771,7 +771,7 @@ static int d3323aa_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			       dev_name(dev), indio_dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "Could not request IRQ\n");
+		return ret;
 
 	ret = d3323aa_setup(indio_dev, D3323AA_LP_FILTER_FREQ_DEFAULT_IDX,
 			    D3323AA_FILTER_GAIN_DEFAULT_IDX,
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index a6ff7cbe9e65..0199a6351a46 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1139,7 +1139,7 @@ static int hx9023s_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"hx9023s_event", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret, "irq request failed\n");
+			return ret;
 
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index 65af31d43453..b3db7f3a49f6 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -910,7 +910,7 @@ static int irsd200_probe(struct i2c_client *client)
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					NULL, indio_dev);
 	if (ret)
-		return dev_err_probe(data->dev, ret, "Could not request irq\n");
+		return ret;
 
 	trigger = devm_iio_trigger_alloc(data->dev, "%s-dev%d", indio_dev->name,
 					 iio_device_id(indio_dev));
diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index eab881b0cdc7..accfc296e1f0 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -213,10 +213,8 @@ static int mb1232_probe(struct i2c_client *client)
 	if (data->irqnr > 0) {
 		ret = devm_request_irq(dev, data->irqnr, mb1232_handle_irq,
 				IRQF_TRIGGER_FALLING, id->name, indio_dev);
-		if (ret < 0) {
-			dev_err(dev, "request_irq: %d\n", ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 7be50bdebfcb..01fbde4d9d36 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -303,10 +303,8 @@ static int srf04_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, data->irqnr, srf04_handle_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			pdev->name, indio_dev);
-	if (ret < 0) {
-		dev_err(data->dev, "request_irq: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, indio_dev);
 
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 59b35e40739b..4d4937395d9a 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -517,7 +517,7 @@ int sx_common_probe(struct i2c_client *client,
 						IRQF_ONESHOT,
 						"sx_event", indio_dev);
 		if (ret)
-			return dev_err_probe(dev, ret, "No IRQ\n");
+			return ret;
 
 		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						    indio_dev->name,
diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 7f417372566a..6b0d7a9038d9 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -638,12 +638,8 @@ static int vcnl3020_probe(struct i2c_client *client)
 					       NULL, vcnl3020_handle_irq_thread,
 					       IRQF_ONESHOT, indio_dev->name,
 					       indio_dev);
-		if (rc) {
-			dev_err(&client->dev,
-				"Error (%d) irq request failed (%u)\n", rc,
-				client->irq);
+		if (rc)
 			return rc;
-		}
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index b7127c3c52d2..9fe14ceb8be7 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -127,10 +127,8 @@ static int vl53l0x_configure_irq(struct i2c_client *client,
 	ret = devm_request_threaded_irq(&client->dev, client->irq,
 			NULL, vl53l0x_threaded_irq,
 			irq_flags | IRQF_ONESHOT, indio_dev->name, indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = i2c_smbus_write_byte_data(data->client,
 			VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO,
-- 
2.34.1

