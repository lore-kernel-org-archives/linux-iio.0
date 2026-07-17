Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013005.outbound.protection.outlook.com [40.107.44.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BA3E5A37;
	Fri, 17 Jul 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281611; cv=fail; b=gyFjwnGenuhiXe+s1MJqu/AaVoM54BTfJL6gfkORivJ/5FQ/3k52owFXWT+x9jhUf21sQvlEuu/zIf7e0ZBiyljKdUfAczaE5weoYGdScREU9eNrzmwVzAMkfLDkqOPAufK5+FPO307dNXKQJwqATSzE0ZpCH5KCzEGaaMcZ3AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281611; c=relaxed/simple;
	bh=DjAjTxUPHVcvHduA5lRMJiqjbN0WOMNAoUZLVPqApe0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rdPR5SXj7fj/SQ0lXSz8ZJIgyexiA1vZkVIr3aB6JpAiYI5R3yer75RyZ00BXFkj3uSKRyD0EZxdy9yGzpy5ezMXzn5j7H4gvF08JP7Ydt+MV5PfKmAi8NLUPXjwI1AfGNhDiHWBDy1VkQzOdD3Y6BeNFU2Re0v4vjweh6vqLhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lqihV9Jf; arc=fail smtp.client-ip=40.107.44.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lqihV9Jf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SINoBvL+Ecl8rhngAU0LRKOTA/kpHpzqdcagY0Cp9NUIdqZatNixsHbsfKldnnlCOqfiiZKn7bDVQ0bhMTC5DInuHLaaBsF9oBiC3Wi+DJnXWcPE6pEl5UVWWsjQ3QxL7Iemc06NGtPj/Av9GzJVzMMV9OGZzwDP1xRSiMbHkdKPDQaKLUcO40jZsePZYkMvKxeZGI+weIPbJRTWE672netBv195ZtqIKRG6Fb9zY+1OdxK11sEs6CnMI05DGjpM/BK3fVBJorOWWxLopAH8VXlDRa4laQ1bj5cZDkOg2HlNCI/sTWPPetF2llTYsQchy0YMzF6cM4jz7ymzmk7PUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqchGOcWw5E1ej4Yw9drA3eGcY53lp1Nd7EYQtz5T20=;
 b=FOkm2E0S0MmlEYPrDkljXMpPLE8raC+EeF2C9a6Aa3ww0MWW5qnsC0DOHEFVSSH/OR+GxNeGZA5WlzlFfFaUDpwHm4OKftM0c56v36Ddd47gLUgg7xoyfFTuxjs6haCxy/iOBijICNLWqFh7yugNkiN3oKKuf/pumCZEd23ksgErKvCyv0gDGdey/A2hHaWQDyQ1mcGU7BuAKHvDo5GGRB9Iazsx9mcuR21CCaVz37xRLvkW4GeKpTjVhFrla19HH+up9PVQcR0ivVHTA823ktYtZiZ/STO8UV2UTNYBA6DqwhlTGZ2DydSQn/3NvMf/UPV+JYVO0L6191S7SDfsvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqchGOcWw5E1ej4Yw9drA3eGcY53lp1Nd7EYQtz5T20=;
 b=lqihV9JfQFaIei7RQiohYUtWmpv9dPUP0VXSS/RhgoAlx8D6O19faS+nJU2bbaCtz6cKAyPy5sSPImZzKngH8gZQtmKp4Ab9r3FNMpIqTzJ8dLgShwW6ssO8S+YtwJxwHqLRuhg1PdSIroCeIAutMTthWsMcoltzaN/lPJkYm5fmwLXM0+KaMEKQ1kIXL3Q+SE1IVikwOLYIv2cH9tcA5DVq3jL7IueYTAF21GCqXai+U9dwNFZ6Umk4I8T18RqKOcRKIOVvM0/Mxi6Ow3BuFrrahRpOcafGV14SasWovmebSW2bzurSx9shxPvBi0Pa3xV17IA1/Ri16D5mwf8oKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:46 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:46 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Salah Triki <salah.triki@gmail.com>,
	Yury Norov <ynorov@nvidia.com>,
	Pan Chuang <panchuang@vivo.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>,
	Yash Suthar <yashsuthar983@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/13] iio: pressure: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:33 +0800
Message-Id: <20260717094408.509583-11-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 912e8596-1301-421b-8cf3-08dee3e850f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	JB2xjSo3vTYYW6Ds71l7+E7F0nvEk2/JCO+6sSzjzVW3NoEpntf8CFNZgJWrd1mi5lVAAaZCFQyesV4rMeXFnCoq6IBOQZ2fRHNGgoYU5iFQblT5ausm7ysQemoSDTyO9hIBTYDLsRoC102rXmfqce54E5uYwNbDsJ71pcRTHDHqul77lRZM2xv5AmmhbRGEdFU7d6OvFRy3gj7KeoEwLQ0Vks/3088dsR2ztxECAwDBtw+Dkalfz91uPRwqd1HeW5Xjx5YKe/devQND7hwQ8/ESsD9QCEKj+kXaYOAKy6ILZLThagmVdLKbyNveekRSvkjx7M5VWOb00YIpbaunMCFlGVE2Y0nKBl+yLQgz/6+a3iC0Y/9hmiE52Ks+jp8mR7cI6NBfAxrHEPfv2Z+s7UydBZTodFoq8Sx1WoHnW4yIuI5fElA+9w8cSPIV1Yspf2lQDzRXbYOueilFfz/LSn1pkjSxhJvzaiZCOFwMA5SpFVsDkMyNx7PDiuZJ6g8PjU+1Z3X4gfSgE68H24yn5W/JDDuUlSw+AkqYSuOQPKDA8lJCSPHkPwPhwcjs5rQhPSekmRTTfJXq72l5NgP/N6wG8JMVFzQXcLu6apsaHr82ZWeUSWjXBuvNWXFzbyj34KGxH9ps99czf9BFOz34eIX5eOCm4443kXZHoY5lqPJ2xfiFTOn2RDd/L2K0EqvREGsZOur+TXLnpUrVGCwEI+6/tqBAKCNdNT/zeKLZzhQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SYHNjQHeaxFSrbIgQ4Hmvu9jNU2Ehsc8xkvKE+hJN3+JUn+Xz4EDYQMJ6qz?=
 =?us-ascii?Q?kTT7e64GbqSr0vgie14+WyC2Bmp/Pfvyy7+RY2/v+EZ2jeMho/z8tIcSoarO?=
 =?us-ascii?Q?64ZggQ8MDlacaC5OBGgZfT56Pm+1766SVNREkJrNqWs3bxAaJCwTTX4WgVZG?=
 =?us-ascii?Q?jg2O4BqpQQXk0OjznbkCPy01yHWNp2ZAXywc9iNwkTyGVjd6PIH1y0Rp77s6?=
 =?us-ascii?Q?Wzvp4/5StEimB++m9WIOJQxh41Ipx3WN8P2NmD4Q2PXWXZElIHrH4I9wMpam?=
 =?us-ascii?Q?lM+zO4ufWG++7AH3dzhC+YMy2d4sPvrKsCCk/a0WZi4Mtzpuz8Hs3BkXwFW0?=
 =?us-ascii?Q?N45kXnf+Gr7m3M8sg+pkpxr12k3l8wDP2/9MfYU6WTc4S7/QbLAFW6Lac4ft?=
 =?us-ascii?Q?Mxw3aOn9KrR09GsuKYlZVaRQt8VxYgSsw1NU+C3TjAVVxg8RJhCi6oFwQhag?=
 =?us-ascii?Q?B4YqXOSulR991PYJmkOb26FsZCV0A2i+ZuBOfrDsRxfZCNuc/ALlRWPJRQcY?=
 =?us-ascii?Q?K9Aeqh8jWe7jNIWfBGXoUe9e63hu7rokgJC1FISt3y/bfGk6s6NNpQEodLR/?=
 =?us-ascii?Q?aMWZ2njucoC3CuqDI3vjImYSOpTTeCVhFoaRJFEnkoL472jd8ocdSrlhBqax?=
 =?us-ascii?Q?LyJLM+lQXA3prnVXLv9/mNgmcDrkDgzK+jNDZto4pltrGRwYggAJ+Ljh66AV?=
 =?us-ascii?Q?S2lQmqG5VusdsdD+fqLadd8WYM92XsrWsSdxmQIetneomQnWXu1sSEfxcgTA?=
 =?us-ascii?Q?4b9CYm5/hX0DxXMnMAJKC9dKlUsvCHmHSoLjqGDc1sLLcV/VNKCRMXi9uJ8N?=
 =?us-ascii?Q?I+6dNGHH/APUI1/y94ywfBO0VWakHaBk2ZbJGHLUI8JucO/rWwXaQXWFZy3b?=
 =?us-ascii?Q?IZC94FzVBiMRyt/vLGHd1jQXjgBlE1KpuTVHVDCtU+3QNrDb61qJtAhitfAP?=
 =?us-ascii?Q?pwsRTIFmacoanthx+fGNRU+ned7+o9g00FHB8itvaM/EHr9E8a56rfZcMrFA?=
 =?us-ascii?Q?ZMPeVlwf7jED+BnBNfnQgpoYB2NJtan8Qt15Oly26uC7ESd2+Xr6NR16T3wz?=
 =?us-ascii?Q?YqVL1Tn/x+BHiGyZp1sF8chCo0yG3JwSVah+4g42Tehxf2zuIiu+48N9N/w7?=
 =?us-ascii?Q?9CzuHB9Ljsw54d9P2F22SnkbZlpwGZEZABy7FVl6Ul5JvcQaFfgOUO7Vl0EI?=
 =?us-ascii?Q?J5JL5h7tocT56fifnGRux0FFmiS577vj3K4LUU3MZpkC9mRX9yhbtHT8FQfq?=
 =?us-ascii?Q?RYHnX9boR/nyJZ8a+KtYEl0nz9EBSX2Zj1mLj1fCS9wzqi2SOoWlWXkAH38s?=
 =?us-ascii?Q?1xW3JaERxHy1hAvGbVSPvn7qoYK4k60Fm8I11hyjUiDe9hOqnV9ZXF8xQkgh?=
 =?us-ascii?Q?qQ/psjtifWNT0qxSRNzn83xTn6Wl/nxY3SEKbVDsUhw4yWNXQSEwX8kJXdhC?=
 =?us-ascii?Q?Yad7S30uoSZHBZN95yKVR9AKLBXWnxfbkqjPqoTpHGYFeA/xY767W3Igm1ru?=
 =?us-ascii?Q?A1FDShdc6VszSUJFhrfYCf/u6zxuQ7BSRA04rswr8nGRac8W5WQbXU2/wpN5?=
 =?us-ascii?Q?NaiHn5hLcj/t93dahXN+vtpYSMvHAgbeWiwnF9yEwbOR3/dt+zVR61b2JmW/?=
 =?us-ascii?Q?5IsXI83UvU+LcpP+nKSE37H+f3lwYBsSCGLRk0E/VYlQc/IVnbh2jS9EyBiM?=
 =?us-ascii?Q?l7QcukcUmR/SaGFk14QB/+ZBsIcsAV4DnvrZvknU6E61DJYiX3Oa6IdGPA+o?=
 =?us-ascii?Q?mu3qz6j60w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912e8596-1301-421b-8cf3-08dee3e850f7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:46.5313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkJVVOnOndVSIr6sF7myVc5eRrcnIr0hOqWL5Q8kQ3CxKv8mLW6RSGSYhN4JyqAG+NRjjmxBsPOhgN4lHhitkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/pressure/bmp280-core.c | 3 +--
 drivers/iio/pressure/dlhl60d.c     | 4 +---
 drivers/iio/pressure/rohm-bm1390.c | 2 +-
 drivers/iio/pressure/zpa2326.c     | 5 +----
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c89153dcc323..6270309db5bb 100644
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
@@ -3070,7 +3070,6 @@ static int bmp085_trigger_probe(struct iio_dev *indio_dev)
 			       indio_dev->name, data);
 	if (ret) {
 		/* Bail out without IRQ but keep the driver in place */
-		dev_err(dev, "unable to request DRDY IRQ\n");
 		return 0;
 	}
 
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

