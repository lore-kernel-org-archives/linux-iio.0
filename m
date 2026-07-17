Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013040.outbound.protection.outlook.com [40.107.44.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E03E638B;
	Fri, 17 Jul 2026 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281584; cv=fail; b=ak7eHI6egUzDH+QLLTVtHMnKK9YM14IVu9SsmerEbV6ugojfpyYAuMaRnW9S0D8cdMYlcW3EtG18FHzMS5sssvquvJqHmYMIm4t+sJWf+aQSTp3vNgnitgZ16c+CO/mkDUMZwgniaAtsUfShclfKnKtCZPRh/nd9CbANI2WCTMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281584; c=relaxed/simple;
	bh=eqAA5yZvAqT9sCHoDvoVIpfkJauwLWqnmqpn9vbJaMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l2HUdlVWL+fSKkNDCRkOMZ7bc7WIUWvMazCvHpJp35X3YJrC+2NEYpQPiCEmVuoS87JsGiyRu1N+Dl3QsJMVMdjVTbyOc6epwB+wo+jsS4lea3qJkaGV4X7QhHYPH6sS0PNsxtdBVUy7BWCScE24cS1u7f1TyoM+llYPY7EPBxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Xcrht1up; arc=fail smtp.client-ip=40.107.44.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Xcrht1up"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1njpIY6oqztpFX7SHAiqmJsJ/rXvLqKhI/IZT7Nvn1Bq5JRK0Rl6qPlK9SSd0k/ZYfMsDj8jjqQSqQA28fbRUmaBnIdDWqpd2xRPzewj4qQf4KMpDW+TI5Nmjf4V7sKQXVW/LSwi25M45vJV27RBs5zkhJ1cRU7OkzLlTn4HQW0FifEgdtHMfUnQCi2iHC3KXjUf1VYd19WcyXmwSJnGiFXjGfZJ0ip3mY/kiuxE2R6uVgRqIoBChOhNwCYc9JBeX3/auDsXxYSbUMG6O6dNksN1yPPjr1OKKD3xNCkv61PvQHpsbVZPUQF6EkoVnr5BCRRJlOrWsLv6uVHHDc6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB27r7zRcz+1x+dwa930A05jOAsoWCojOodn7Hp7KkQ=;
 b=xcJiDsqOtBKcIiMoeiCudB6Gyao8GoqDvtuxh7bU8nrGSQUtfVjOobGuz7+E/LxFiS6eV/iqq66Cldj4KAz2aJb7MR3d5dc1fsZ4ECJwQQ09OwKngRDw2vIs7sRurL8fka2MR2oYV+GwmtdvGm5jXgy9P2N9O9rnceTDU3XAhF4miM/I0qKrCbfLul7+v21riX5yxrxtB8hhGIFXONQw6/Gb8BKY8K4IcLgtgXHm/8lXxoTEM0yK7a4X+sNizlTvlp+1uWHXSCZ416V0p6tpFLGr/+ejfgQDXD3kwQXCoF/OLoP0Xvuv3UtLVC4LTq+z/UCkZlmMv9exu5azjF/h8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB27r7zRcz+1x+dwa930A05jOAsoWCojOodn7Hp7KkQ=;
 b=Xcrht1upRvb3ay9Ij0yOm8Ge/S1F1gwTYhFB1Zxz7ZoiT8RGGhGZAromjVNgo6YC3RXBPMvPDZPW2jwLYLw1MYgwYc/QCitvIpbaCbdvvyCXMxQ8c3GPKtgOGIMvn2jHiHQxPEZmkIbyMPdfypTaWFbmOI7kmWteGMTqijyMONQ60ABzcVFmotVP69FF0sSCwG+aC6EiQl1ksCn7gsPuF2Ic7OrlN9eIHnwU+8LRl/PSGKc78yHovQp1sKgmJ32JG2b13MgyA8GAyo0gjg0vBsYXA4TmR2cg7TFrPglAWnXoP5Gvziom4vbGQbZzAiu8tnFrfWn79rnzzb3c0UKZww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:20 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:20 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Nishant Malpani <nish.malpani25@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:ANALOG DEVICES INC ADXRS290 DRIVER),
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 05/13] iio: gyro: Remove redundant dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:28 +0800
Message-Id: <20260717094408.509583-6-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34dc77a7-37f3-4fee-7259-08dee3e84135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	2wv6PQ6H8fshUgnq6+TeN1LXZmuc9xoxi5CMNqXC97tf4s2CnELKNNARZG2yQ4hYYGiz6d90l0bLwwXjYKJk9zn5JqHgcCqZvzdmRpxxIshV4btLMg9UYidFtlBSDpHHlfyRGxfhLMXO+ZkIub4lxLPw3SJ2vps3bRQXfKJfP0jgQOwKk7l+rs2JzG9kMW5zrZGEylnmAZ2ZOH0VUp8c3HiAcSAq+w81VyUymBZiX7e14CHDp0Ls7YqI7OYhNh5KhCnSk/rwXNDYYmNurXYfqHIKADy2N3mL+7gh7cWw5qLlYOjVFnHy5RzV+S0xJLHx7dIDOC2h3InNC0VLXxvoAj2Uuf4UY86A3d7IewMuRQ4U7eysJtZqohxhmib9qIBR4kAlMkSsjmeCyYPpo3/yfq1R5jyveEeiAJ3mxpo0l5jzadyF2M7L1yGUV3CxWJk4JVwJLTSskfj/y4qlyMTuq9y5BwaXu/5mNZUHrkFtLcuim2m10Ghj3biI18JQdUSKmWBhiEuz811iSjIzDz6D7CXCRGgc6o11aqCaz1F5Ouhw0/qYKJlPt3DaRFtcNJDMfZDp1U+KXRW2yugrRHIswESIiSFw1nz7wUjBBiOl6xOY/gZFBM8LWLmMt7SGkuwB3YgQsMWqSjBP+iad3OtZDAS1CtFEUQTM+5Rux786HCYtuuMKM50vuS1QdDlVouPEubwDscA0t7ho07NXqKhvg4L+1uaQOuwWq1j3uTd8L28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJYv+29R6ADo5TF8CH9GSxyxPK8NoJ4LWn9RIm1TOMAKNeIrtp+nslDAR2SX?=
 =?us-ascii?Q?crMvjd2KzmvdMeyeEmu+OjyuB9aTI+FzlEmFS3Y9frY7mQsAWMQJHaBuKe8U?=
 =?us-ascii?Q?20CDMpTCFKPpo28LffFmmt0KZYj1KRnbxTtNPvbsiShMURsq+U9VXMXq5dMb?=
 =?us-ascii?Q?aSXeomUabc/Mp6Xez2X2SBLK7N6s18n3QtwwiA5Y8fejOzddtdOCRcbmTiFb?=
 =?us-ascii?Q?09T30CS8phHtruOKGqghYt7+rlx00URjJ4YlZYK8+yZA5BOPr9SVU9h7fDtX?=
 =?us-ascii?Q?dpQUDD0gXyNB2BSrf7PFml/zq/43RJTx1WaXJhfdn5uGBwtwfyIGX90Hbinz?=
 =?us-ascii?Q?S51q84qqkkwa5C3XFt3mNJ4I/hohZAHrJ90D0EjY8qezmT7TOyZDqJco/HwF?=
 =?us-ascii?Q?Pv1gARv8blsrjZ7wyyokmjcTadC2jo8DEqvD/XwdMbBYjln/G/6G8nwEMDF+?=
 =?us-ascii?Q?1c5TJjbaSLXbIXutMgGYtS3/kFLo8w3sVR8C5TLomqpx09cWFA/RAlQTK7hU?=
 =?us-ascii?Q?NTzpJsAd5C/fvyc4GYayB4+ucMtuuiovcescCY35jkw5CYIWoma/J1QxzC20?=
 =?us-ascii?Q?O/G1zwxxRbvZwE3+GFW68B0h9L2ZgOThDlbCLcIRMljDQ1BWB8IH4poe4BTB?=
 =?us-ascii?Q?fSN9p/mBcGwPGj1G5HKDmPC46PT4UqnJKtPN9izZ1zVZ0i/WQYuzb5CG333z?=
 =?us-ascii?Q?p4MLhqP5CZ2bC3zHEO+fRuRDKxLuY9DL2yYIZ+OTUbG7cplZOUTiYYjPTU6y?=
 =?us-ascii?Q?pFLjWCoFCoBBco/FpWD76iuNsqQWFzvneCH1UO58AbyALzAfA/W9YXaaQU8z?=
 =?us-ascii?Q?54VGFFTNRQg3c909elC3OQRaV1Ns/tmfO1EABD/+Bpumkiwr+ouw4TR3ZzDw?=
 =?us-ascii?Q?098ae2j0ZkieBYhgC7NJsAjfNYDNpSOg3AvTKWH850s9EIu/UUlpTv2I47em?=
 =?us-ascii?Q?AWOAntf7sdu3FhbiuNhzpRdxEvWQ00wH21wC+vLeujP6it3Ksnv2SHz4e5cH?=
 =?us-ascii?Q?lktkmvpM8AQ2B7g2fJxAsRmGjiDMXqsbZGxNDEWz5/rRjt8t78YxTDFamQx2?=
 =?us-ascii?Q?8jx5rQONHfC7BtOp0ZjMvGXt+bQ42jnHRTDm1bO6DbcZBHXObpARht7FoUEw?=
 =?us-ascii?Q?BgwqBExtMAMtDmblaOvnoYpNRwTh8O8m6NHs3sSspQB3TDmpEoWp143sNZIF?=
 =?us-ascii?Q?9tUs9HCTU9a6w5kZPEdbKnKAavihi76tKklG2Y4eYfWmEU7QsvG9x6b9RuTu?=
 =?us-ascii?Q?cZtMRMseXUzkLSOCR2lXThYJM070jRNgvv1a8CZa9TOo+XufNzCaKrKW/2vt?=
 =?us-ascii?Q?j+Xasi+hfbb3273E8rj3iSoOm/9enqHbKNjNHO/8wk7DWu/rzVO2naJ37LbQ?=
 =?us-ascii?Q?l7n1JNi5p23BAWJbncwPYMjYryy98juvDD3k4KqX4Nm5BcNhphFEunYwlVlA?=
 =?us-ascii?Q?xtYkcthvbhHO1P2C8yKXsLp+hzW131ENIyCVwBX+Cq8lQS+RcqmmBqieJrVT?=
 =?us-ascii?Q?sup1g9rad2zYXQt2NMBaJ/NRWAkQuTFF0pcvGbSUnUCM7fOdp44koxifVnGZ?=
 =?us-ascii?Q?Ztzzo5UagDWgHt0NClR8ifsxregbwQ85sUBM02HoNAYSeT4og3ZJDRxRNxe9?=
 =?us-ascii?Q?JQ03VMLzwaf+Rv1uwgg80s7p6IUE1I+viGS9qMDoFDTVGag1sYvYAbV+F520?=
 =?us-ascii?Q?VzCM3a2xt2CPEWjc5xKgQRCO2QFsyx5o+pFcdUbpz66F8VNG7of7WKGpVTmy?=
 =?us-ascii?Q?rdqaPEA4Rw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dc77a7-37f3-4fee-7259-08dee3e84135
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:20.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiUJjVq0l0f+BYqsZp2M3CcbOXE2q35qB6dbaUZ5PB7Zn6huHUziSUFVhX99YEup3UX4FqqgzjfEXWu0PkOMKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/gyro/adxrs290.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 35928383d4f2..61956e4fe8a9 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -586,8 +586,7 @@ static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
 			       &iio_trigger_generic_data_rdy_poll,
 			       IRQF_NO_THREAD, "adxrs290_irq", st->dready_trig);
 	if (ret < 0)
-		return dev_err_probe(&st->spi->dev, ret,
-				     "request irq %d failed\n", st->spi->irq);
+		return ret;
 
 	ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
 	if (ret) {
-- 
2.34.1

