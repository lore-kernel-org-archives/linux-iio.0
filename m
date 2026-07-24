Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013037.outbound.protection.outlook.com [52.101.127.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF423371D02;
	Fri, 24 Jul 2026 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862491; cv=fail; b=XMbDhMGzaidFn5WBAKrF7YAHLGwXSyD9ZaY8nI8fvZSzDa1mjoDLpX+hO4qfVVn48zTvFQc4Mfkd/njfaFdDHNuP+hC2LaCn2/pzUj4dk4sqsPXjuslVyAj01bubhif/3hd58nf4aLc4qIt/RW2SAEFBlIC9cWx5JsuwjUapSaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862491; c=relaxed/simple;
	bh=JVi4rVXSMCIJn703o+XuI7r2SKSpsuTXeXVs6Q76VQQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fp99mwJYEKDWg4b0I1po0wK/hKTPFvcHm/BMmiR1RcWup6XpiOUxp4PfcetX1/I2QqyOm44OBKDBuoevAUpNZOrQz8ndA/6fFROV1GNuTCHE0+4/oaO4c1QhxgqXl7Ahp1DgjlPjMOvX1iS+bUxwzbAUh1TciyJ8m6Zq1jMXCpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aoBMC3E+; arc=fail smtp.client-ip=52.101.127.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aoBMC3E+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGby89+gUEOKFzKxKn3VmzNbaeMyIKkegQXoyrkgVaTmA1t/K/JcQp0CNdtMXjkto8tT5Rw8Hqp6kRhSZM6BpG5PpNxt7seITHR8fYGdPukDRXwCDkZRTwZTYsTXIWLSc1M73QdU0sr2ar5WzJGEJJASvMmSIuv+m4O7iUH9oIhWpDrXvtdGmsk4lUG0TnH5cs7u7MfufSMg/oyYcbMhztdh24iIPeBNZKbVUVbecK0CLrS0NhcwG0ygXtnoc7D/DS+8sJQDSWBf0EB4yidTZjNG5uZRf+Bd1+ZXXFNK2hm5PK30+xb4XamElvPj//E9sogE5/KnC1z7moXZsdhXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BzjoiipElPySKulLIcn+2dm2FemrMcQ7K1n73OdTvg=;
 b=fk6rRuc9/bVcFPgCAdhavSA5Aw6i58pDV5uQiLPagq2nZozvJ4Lz8TyaaD0jMwPpGrm8ax1v/uVrpc/XTP31Lr6qfTqFFuzoMgWwrC+z3jMjctL0YSTzQIm4Vq4U7V/LLtdrO8wqxujrP4Pc3dxR29MXh4GvA/98VoGXGzu5/j2VIqSsl2ysRLZYw8btVB58r4kQWxSfkW3R8bCKvwlX6vyV8xU3lJG/FDNnJFpMI1b5Krz/IKNYssY9Vzw3goTDrj/A85LMlPzLR0cO9+RTUDa9RS4KXMiQghWQsfz4da6phqG5oLiihfvDb/Y6dBoAzSIhejVWtf+cjmwWnhwg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BzjoiipElPySKulLIcn+2dm2FemrMcQ7K1n73OdTvg=;
 b=aoBMC3E+KRY9ExaUDIT3eJwsG291U+Csa75HUc/axmfReXib3pc3VXtzn98bWjR76ZyHf8+lUwH+nYSdArVd9Oqk2ulgpE2V+ky+BKVZTyk0VzO7jmFp6q7mm/4tYMxWkLlJsi/Xon52t7tdM+0dLyU6QZd1+z8qhelPKZPO8IS2sn5bMF2K4x5bZzZCEkn4fq5m1JtupkvM1i1B9qfiMJn3Nu5ysraltqTOFNUwkBrIDAtaYNEGfW4ubhYw7Rit/Ceq49JDRm9Tmddq/lpp8Go6/i+htB68miypYd1VynvDH/Xa6nGnV1NPAaOAEkqQHAGq84P+HGbd0ncvFXIgnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY1PPFE340CD3DF.apcprd06.prod.outlook.com (2603:1096:408::92d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:08:07 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:08:07 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	linux-iio@vger.kernel.org (open list:LTC2983 IIO TEMPERATURE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 13/13] iio: temperature: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:48 +0800
Message-Id: <20260724030524.607185-14-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27ef2f2c-6b2f-47ee-19cf-08dee930c8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|23010399003|10067099003|11063799006|56012099006|921020|38350700014|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	AhSi1QQl+307TGJpOVTk1sr44JuCHf+gJXZhKcV426S7ymD7yxQPtKGaKGIRT5WmpFcyifwo9j/9R7FAUc+2Lv00G+aSBg2wxfX6A2XZ1+XvS6thKcCFc4NAy7odiltJvrh1P0tk9WZFq2GJJIFMmcKtOYwsCSo7Y14lhm0k3CLePHD/KX+pICnU4Ajvyy49WM6IsLf4G0/YozuRKNBWam0cO+37uXAERSXfqXy7Euyz70YERiADaRra5zWSJjlzQVGVY14BKGhoa9KP6vD72FAF0YUwmoOxeIjHQNFlp4FMjg1pk5+zLB/dfmVrCIhpmqlxfrC73srM6TWIlz4STh0vh6iyjlp9yUdXYzaqWB3W4Q+cs+aR+YYvCSkV2Q9K5Yi26H/6G55xU4F9yXPmszWR+elbrnDNf+OedtOf/xwsUXQ7f/zSWmP8zg8bNsHgVMNm1HYRfSIN4Kge7u/m4aj3+YCcfarDRt5dTxhCkS40YOkmY+TvNTnAwyM8l1JyW9EeaRJt3M6jmyIeXVLH3vPSNj5jkZZWtoff1doWlXqX9eLFWI1xC0IDHBNg3EnoW2WEgb6pGgQ53f1KW/KUHP5s/dVANq6MnX3YHWMyFQPnn1eu7/gmHIbaAkbMX0bgenxR8cvGg3JWARF8lQwGSYJFns2Y2EfIO59EGcNPANG5GIp5JmwuPwOIropBtvTJ3W2nZ2yNyeMbg8hHYxCVcm6CaosGb96tDOG5sjKQGZ8lrj5jiy58XrdTwR6xihVO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ib9IJdvDQQe9Y3Za34szkvZGhBEu4uCId5qLsZPLnbHc8cNzpUkU1fZylsLc?=
 =?us-ascii?Q?3uwQXIFOyOng3hbMOPkauxewp56gxiti00DS19M677G7jU092iS9luBXrN1H?=
 =?us-ascii?Q?SUhojjK2SvOVHrrDU0GPeQ/T7gcqnSFmCocpul/DAMfptqPlYMH+Bgn1+Dqq?=
 =?us-ascii?Q?kbXbaqSKspabqXUTwLiJ9A/b31e9ltqPK6gsG7hTxRDW1MycQFF4vt/f8YQb?=
 =?us-ascii?Q?Zc5OlJLdDhb5fVoF6yyMMxHn+aRrAGDOcF7QEK4Hwry2dDmq9BNd0VNrd/hj?=
 =?us-ascii?Q?/ARJPV/73IUYoDezcZlxzI7yTAokxKrmNxbC0ml072rclK/SPqKLS/NQpcGy?=
 =?us-ascii?Q?DPwBLlOziLC/Bo9IjvqmcMgc2OxdmlE4BQEGdvFExdiT+Fa6U+10ahGwmhgZ?=
 =?us-ascii?Q?HxVKqRrGd7Eeuz5J5ApMh5RqjlmbNtowDGzXsv1CoyNTT1YvALSCv0qrDloS?=
 =?us-ascii?Q?+WThuraRIFOZJ8gK0JDgMR/eZuPP+v44tNOM7h+oWgfnugUspv5JLDhcYC6A?=
 =?us-ascii?Q?nRIsSEYdSuB7n6suIf17Ef89diZQh/dfWtNWNKQxNc9nUo1Ag1EVLFm1h9BZ?=
 =?us-ascii?Q?tda/b98rK6+HE+FUwXQ6mrSSC625QlkHnh/kKS/YQGF56dFV34BMqk93qWC+?=
 =?us-ascii?Q?9HEaztY67ImsODee/GsSlumb//SSlhHI3Xd3gL7uMyh1LUfaj7VMmwspXjGT?=
 =?us-ascii?Q?dAchLIDA6qJMHLlco3kQE5PQprKSQczkA+BbMcrYxqn0L/leh+jZI4VC7P/p?=
 =?us-ascii?Q?01oROlc94U7uIpGL4+kqMx0jMiPWdDqJvYHCpVqvTswdWrYDmk44Y0WY5Z4G?=
 =?us-ascii?Q?khzvuzbOPXTmpvp0E1lBP+PcEbAtvPUdo0iSqK9HENze2Y3SFtMA92th8Hnz?=
 =?us-ascii?Q?xtH507/gyK6uZE8FB63G/RW7CxThw7Ru170N9PDkzMJzaag/lzjkDRbagXvR?=
 =?us-ascii?Q?9eDlgginS3YlO2+BmeNHrKPMs2VTFDAGKmQwEyJKc8SR7TDh6R1U0ytY9yuT?=
 =?us-ascii?Q?4Dw+Wln+Z4F6s3HKAmcWEGrAdbE0yEAYlOZWJd7LJfBKOEZkoI7JjTFlZA+i?=
 =?us-ascii?Q?LHqvnvEXXqtzPnSnSCZp6064KoAx2McNQRt89WloIIEmTwv7O9ehX40E9MUe?=
 =?us-ascii?Q?C8jhBHLQ4Eo9jvdLdEXZFCR5NVLPM1CaOIzFhSqT5Lbvaj85aF1KPpB4LtfN?=
 =?us-ascii?Q?kbqSe1cWHFVmUEeCmj3WKwLNRlIKSjmwaXXmfUAItj2fh5QdeP4e62V6dfSw?=
 =?us-ascii?Q?aSyMXRx4DdSusofa7Qvo1Lhl4ZFVzM/9MzPpXgdj0uhJ+U59wqomEQgaTU3C?=
 =?us-ascii?Q?PxBe+OPJD5UsWLehKRnIT5ZKRWEEQGwlrUy+Vt2BEuzvHTGQnEBAwj0wjT8h?=
 =?us-ascii?Q?SAzZ15REmDHnquHxBt/gNFv1yoC1JBC3W9XqkQRApDw+Xf+AwZSeR5JU18vx?=
 =?us-ascii?Q?5chWGbDqdqExFlDowm3sJS1YtCkAq0oC3/9JpZjHAliDuSfKXPXCU7/yIr1v?=
 =?us-ascii?Q?klkrq0gJNAK/+Pr+v6ftFtpGWT7281LeobfzaZf+AvwYPTnIDykjNq33jKp2?=
 =?us-ascii?Q?kqhp65UeDMECaSx8b13IQ0MXBqQEOD8rU+j0XFCRRpKRPQJWcc8043sLW/ZK?=
 =?us-ascii?Q?30vEEU9q/AeMO/nSo5YTIkfDRRNuYLgeoq9qhfFhr0NcGdTO4Lu6dTwUl4+M?=
 =?us-ascii?Q?NknMJqH+c7vB4PZueELFL9qVYXOKDAKwancLOZGZT1fWtUdBrJs59bU7XpQL?=
 =?us-ascii?Q?AJyMih7M8A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ef2f2c-6b2f-47ee-19cf-08dee930c8f7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:08:07.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FP8sBC945ze6vAGDutYCopAEZbBUMXPjafsuAep5lwa/tYCTX6sIRGBJ/oKeyFVlRkZDIbyOSshFvvWAtlqEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFE340CD3DF

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/temperature/ltc2983.c | 2 +-
 drivers/iio/temperature/tmp007.c  | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index a9d38ed45da6..6efb5252a773 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1994,7 +1994,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	ret = devm_request_irq(dev, spi->irq, ltc2983_irq_handler,
 			       IRQF_TRIGGER_RISING, st->info->name, st);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to request an irq\n");
+		return ret;
 
 	if (st->info->has_eeprom) {
 		ret = ltc2983_eeprom_cmd(st, LTC2983_EEPROM_WRITE_CMD,
diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index 2f6ff87d2a37..4e743424f88e 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -527,10 +527,8 @@ static int tmp007_probe(struct i2c_client *client)
 				NULL, tmp007_interrupt_handler,
 				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				tmp007_id->name, indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "irq request error %d\n", -ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.34.1

