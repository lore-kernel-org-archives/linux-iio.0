Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013039.outbound.protection.outlook.com [40.107.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3010625B099;
	Fri, 24 Jul 2026 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862420; cv=fail; b=rutAXqvHHuqaor45L/Xoe2kuTYUzNLf2WWAmBhwi63ZztAbnP0XSm7X0ktHD9QdbqCzN218R51UQK0vpzv3qQiTtfSd/gw5dZ4EsiahXt9iFeDnC96P1yl1Xovteu8FQ3fTHVIQHVum5WbY9+pqzHvKwUAiAq5fC6WRoAfepi/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862420; c=relaxed/simple;
	bh=XGEzWW0cgM+Q0CfB9614WfLrT2IE16i9jJozd75lc20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=asYUglRbLFpdnSM7coPQF7GPhcI/wnneouswm/ip0tpUsI7dy27D6QwfCGmgEs0RKkhIRD9p+7hhC9hhau1fPLAbnjMG9DQdEm7nw0IWGbSQM+/nC+QZMUdh7kacFIE1vxhE+d4UB+C2Qyu7FEKR14TgNhDZa0eSojl5Qivs0r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CXrMp2Cr; arc=fail smtp.client-ip=40.107.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CXrMp2Cr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br95Yq0tj7vgu9h36r0Y8QtHN6ch1Ptk9h1Xz6yBqeUFphFnW9zfk6H3Ffxmmxn8TeDDGFwRdIuiijjcU4zMfbfuLhRMKaHcm0HGrmF7M06DvF7NWJn/MFirc0dHjU58INQ2N7TuigtICjz2N2xlwz6K0BOTSJmCAyQ05ejptMCkl4FW2zGwrKxp+xUVqY2n9inqm/AwCUP4DtWKrWogF8k5Ln94To/mQNNUD7/B7uPI6xD3JwyWGAFstzkTQVlsLp5PZh/mEnA6iumqYGCYBwrV5UwST1YL89CtX2gKEMh1CM6FP0qRAxIgXiKpXDMfqoNEU3GZhm9V/kLRcoGWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+/+MheP9w2lcvpT2o8jIGT/WPyZelumpYhsCD0ekEo=;
 b=BARap+q66X/aVH8WiDX8HW2T+AiR9Zp406Qc82N/ohaDsoK6mHHjLKGesI3Qxhx31gG2P1lgxEa9UlTNU2LUMA2wcs47EDpmVk2u8J7fiXQamQx0qu5a93oUNVGyCh/84AGhrG0v0lL/XyffxfboYu4pZUVws5tS2OghFqjUeodYK8FWViMY43lJ072dwWhY4OxVd8I5HQvxI5qd1Edu7z5jkc//T5WUcHNln22+mhRhfuFedcKHtOGmpbO3rKX+8pXeCElzneNrZsjqcaIztOIBWgUiNt1GI+ifUv3wcnTeCBXMMfA3YiwCHqrCzKxt5D0qn/jysxi1xTIfzc+YJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+/+MheP9w2lcvpT2o8jIGT/WPyZelumpYhsCD0ekEo=;
 b=CXrMp2CrIfkaZkY2uiT3ukoaXSJQ6XIidhcNrWhPWW6jQQMTBtuyTBJ1Fc4LQjFBS8mGZvfLjX/Xo2XVHWTKM9wtgKsp+zaypVuTBsRxgvMqEWbeFwIAwU+sWZ+6rGm7mVQ21I611EjJC0hhsGPI+n5wQ5O1oPeXg9EBAffdDKC2uu0NTMt4LGjSsHJmrsCKc/3DLYAbD5quyuEehoerjkoCttxxHqUgAQyYmGHgoEOIEvLcqU6oi/e8bdWLMN21OZ65WkOfeWYhzQVFcMnQopJGkxBDf5Lm8Pdrx04j0pGxVA3mgzCs+pF9lyVsquiu+ciChrYusxu7Gchy6qfDhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPFE340CD3DF.apcprd06.prod.outlook.com (2603:1096:408::92d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:06:54 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:06:54 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Song Qiang <songqiang1304521@gmail.com>,
	linux-iio@vger.kernel.org (open list:ASAHI KASEI AK8974 DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 09/13] iio: magnetometer: Remove redundant dev_err()
Date: Fri, 24 Jul 2026 11:03:44 +0800
Message-Id: <20260724030524.607185-10-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0e643b5-1976-4911-4e44-08dee9309d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|10067099003|11063799006|56012099006|38350700014|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	G6iDeXy8T6ON+lZP4D+XV8zCsWtKrXK6ddXgc7169LL5UT1wyckhhNdoHS5Ui4JGKnpnL0V+az4LYoywDkwsUcMPnu/d7OYYoAxRdFLLqD5BfonsgTyc7Kuk1h0qvdT4JnDl9dMdxTHEFbrcALQAWews9jy4ewVchQvhCZz9EC1r4r5rfNV3IkmL36NvG+X81S0/FWq6p/Wb5FA5Hjai9wpnrgbgHd0eqr5wNybk9F3cF8A2sKMWdb/55C509F8TZPaOmEcbPEIhlf0+yEd2p8L/yZ9BkAC+q+GfYda4kYbKBA9Li5F+cu8NiM12XJL3a4IP6iaGsGtXFxEDgGwKZKCVplIEGyRbOj2BZ9wgFz7NPmc8FKHba5ny8UnQJ5oGERZlS2OJmjyVXEHb5+jXF+2w14vImIk4shPF8LLTU1G9V6gAkt8pj/Cc6SK6qv33/6iRGiDSBTth0AWszfIQKKr03A3H5QemSCotet3D9cDfy3HfJiywni0MGWxS6SQeJ/HxxRT8I1KD9Le3pHp+1S3OrYN+pkASMlipHotVgHCWTmUFdstn5SjAySkA+8SK6xbte9P85NNz6iOCubHaNt7XAR7bZoC7I7Ja+MNhCLtvcw/FYSbo2tSqayJBv6uNkLW9/gyUyyv/UkCCCVNYByXc/UOJiqkX/qexA4JmJkD4deQSNrFdJPXvchTAU0PZ2UIxIYk7BGC43als7BqWx4e3kAMo80UBD4F/EIvDTUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(38350700014)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQn0tsKI/DYTFWpYSvXRno8I50XNaCRzxJFdeNmNz90rT9uqZ9Tk9nEOcqQV?=
 =?us-ascii?Q?uLlLymO7+v5By3egUf1V8qu3KO308DZT8iQVSnMml301wmUZp6Tr0P5LtX/J?=
 =?us-ascii?Q?jMutkSEi04bAlK66BD7pf4syrbVRf7EgIwRDiA20CulGk55wAHwPj0eNRi76?=
 =?us-ascii?Q?ISKgSsVUEh2U/UuzgyoXuerkqAd0CWm8771m4UTYG5i98apORL/HwQvY6H3X?=
 =?us-ascii?Q?jnhnuvsUvhAGJTXU494TvwoAMv2a6UxbH/4Rjn+8L1JasLS0yxN79Kz0i0fe?=
 =?us-ascii?Q?eY8EXm9YYay7mPOgGpcQcuOG5gMjwE4mZs9j963RytgDbsBXLX5HGpQRghz2?=
 =?us-ascii?Q?pmzZyzbRMCave3LDiPSH4QDuxy92Vx5SPdwGQmU0s/Rae0rhzUF7IsxsOFBg?=
 =?us-ascii?Q?m34EVDfAA39QujoGQsiW/vL1zA8isUxhhNklgEGfs66GrggN2b60P5bZh+nh?=
 =?us-ascii?Q?dIa+PEZhIt79VSCsdKszDuvtoeiTlKVpiDrpmMn4JMEcWBLJ3JYyQVsrb/4Q?=
 =?us-ascii?Q?Dd21U2k1OdkbbI/QZm+nM7oLktTKE7kQyVJGs2hKY+p1zyCSOvmdZlkikm++?=
 =?us-ascii?Q?Yncm94rPUAn+tvpJXHPZQlEXVUSV6nzQPh+CcGpmDAqNvHXDTQjynlwkRLsQ?=
 =?us-ascii?Q?XxUEPi6FqgrZWvKxV/1q4XMkNeQcmP4l/1ytwnueMNUCWtsbXxGpVw5SHbkK?=
 =?us-ascii?Q?FrcnemaoMg7ITDj09++kx1gg4brPcvcc2pJzVY64z9EWDWvLSzT/RpxGV0Rx?=
 =?us-ascii?Q?EH0ZKtXwSyOvboEUDBxNcOSyWG7cAHbhlCBk/bnveYnt9Ckc32KcskwP2r6b?=
 =?us-ascii?Q?6WrALmwqv9Capk8MrMfnkzE3m9yPTBCEftRnhiyZyzALj2aQPVlFCU4eQL5E?=
 =?us-ascii?Q?UFUFpGBcqd5/BltzUagb+CknU3CvODKOKixBUfn6iHPYVhN37cf5l3e5dumG?=
 =?us-ascii?Q?ivNjDmGwL/Z9YUUwCVZvoNrCH6GDGRmN6DGX9Rc6l9oEEM8+eExS2I/YBK9Z?=
 =?us-ascii?Q?e5UPDe5qbTkG7BUm5ROFaG/E2K6X+hBNmjNTrx0CvjNTBkiB0MGNF4QRX0Pz?=
 =?us-ascii?Q?6XQpApzOEHTSP18CYRFu/zm+OvsWVR664BCyvAa3yIR8OhNnfqZ/hHIAJtQt?=
 =?us-ascii?Q?1NlkodcsFgCeiaEzehLWGDZPB0TBTpYdz0ScdXHqIP6Uop9NJYzIkYqKRuJL?=
 =?us-ascii?Q?QKwN2mPUwalJs9X0WMaUh3+WVknHT5HPDbKf8IwgeKYMN62jlvxm1rk2ZR3k?=
 =?us-ascii?Q?YG9XRATUUqNTkgiUQZIs+JgYtCxht3Zh0pd/qC6BY/tTizQPlQB2PJDDFEY4?=
 =?us-ascii?Q?GngmpyXLkh3QivKCxgaVwEyt7ryXhwy+lBY1KlJk71Jqi9NwwsCI02+BMTFS?=
 =?us-ascii?Q?EuIuE4XjICrNYLZ+qWqFj93ZWwVXg0op0MRZlKgILXEiNvPYSk+VPbCwbQwk?=
 =?us-ascii?Q?tOfvvACQBJLiC3cW86nnJDTgGBL7ol+ZYqrWb1rZm/waSNK3MJpD8Dm32JmC?=
 =?us-ascii?Q?PYLY1Val7PGfEZSI8ZoPxcMSeks+Yj2R2TI1IQZ5uUS/T8QG1yOposoi1A+B?=
 =?us-ascii?Q?H91OkVitMHmCMXQ3I8894q6uF4PpUZDmDSJVe2BVPypHIwer+ficUQGw6764?=
 =?us-ascii?Q?tLPx3S7R/KEuLrPk+vZnOVJ4uBALYe6p9BPlD6LrEH5OEh1YKe78eL4VsnIm?=
 =?us-ascii?Q?8E/EmMUmePoczPQZeJv9x+UYZMiqwGCXajrCcz2LyfXH7IBhnyE9MsgnUSo4?=
 =?us-ascii?Q?DtkDT5px9w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e643b5-1976-4911-4e44-08dee9309d4c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:06:54.2103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1W+TKp+E3d5beArjNS0oLb6FJEF9+gIh9ujWExInQsN6IW29u2QQ5/ro1kVl5qJ+bsUzRhpv89JGlwvT8Pg6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFE340CD3DF

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/magnetometer/ak8974.c      | 5 +----
 drivers/iio/magnetometer/rm3100-core.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index c7fdb7c2f543..28d6cadfd9f8 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -926,11 +926,8 @@ static int ak8974_probe(struct i2c_client *i2c)
 						irq_trig,
 						ak8974->name,
 						ak8974);
-		if (ret) {
-			dev_err(&i2c->dev, "unable to request DRDY IRQ "
-				"- proceeding without IRQ\n");
+		if (ret)
 			goto no_irq;
-		}
 		ak8974->drdy_irq = true;
 	}
 
diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index ac3f9f7fc808..46fce2978d76 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -568,10 +568,8 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 						IRQF_ONESHOT,
 						indio_dev->name,
 						indio_dev);
-		if (ret < 0) {
-			dev_err(dev, "request irq line failed.\n");
+		if (ret)
 			return ret;
-		}
 
 		data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
 							 indio_dev->name,
-- 
2.34.1

