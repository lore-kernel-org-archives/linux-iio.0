Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012031.outbound.protection.outlook.com [52.101.126.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373A3EA963;
	Fri, 17 Jul 2026 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281671; cv=fail; b=SMclWL/Wa1W5Lbc4qek425zCjDaj4B/gFwZdVuOhr0g8CIzHKv14kdaReBbNO3b7MLTeR3CeePOcxN1RG97X2HKAbdlSJho/akzLZhzURxF+NcmgXJaZGaOGRvi66FUplnKxfdeBnxBKeX2URTM5rwj+b8mRA2i35+U+wKUD8HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281671; c=relaxed/simple;
	bh=Rly32vpqajE2tExnAaFbvKj7/aqcoqKICvjkFMGZjlk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z8SQKIg7IYmT3lWIjT9bSTOySAV7WcgI7s9g2zDFbdo1GROUNI3Ab/vgbyXUeubPa/iG+y6wdbdEEz2uRlxKBQevVxaIpvC4TJouJynTJ5EaiEhhHyLwjGfRgJYZDPRMhWuz5ca7FQ5ZTaL+HyiRHsG4+ocBeDDZ7hzYAmxaI3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PZBZimVw; arc=fail smtp.client-ip=52.101.126.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PZBZimVw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHK4TTgCETxyu7HU5jV8k0OYB+xiGvyKddhYgOesHTfoNXDQtGhuG+3+VcIQbbwAej3kpzcZhdXGy0/ndzM0TkRRJcmjGxd3mDhq6cnbo4Voj1ZSPykY++ncuLDZMcf2CLJ5mczqsViBedonaUeRXVInXMfcHuuHPrrZ7B7PwOWpm2I+7njf1Ousz7gue+XDUuatmjsbotMiMpsWWM9E6l7tC/iMeocwo/N42ZTlLo+hWSh2VX55HI5o+jzQYwbnDX2sQN6gRsVw++eXf1YKPIEPkm1qRJMXaJ+x/l1IvhKd2syVXoCSBvTBEzk3G9SP4nxwe/fXmdySfZckDjkThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvT/wwvqexP46IbpMgHtkLhfPCii1nzHIEtJ7W6ac+M=;
 b=GoLpy3DdG4poGvfMV7PctQSkqTinltFGJezf0WLuP/UkDAqqG2XLBpZIUXINT1m85Ka+3xhh5ADJSQiLXEp9rcgqSfH+s8E62phHnA4zR/Dsb1J/G5yzruw3H99g+hcHnF5gBy1ZwuqwEAoDBBJwvoeZR/YtPlwqhRQ7TOQJipv9WUTJSUnYYdvf2siGhbEOcaDGXZJFHrsIieVuVApLoT/MPA/zwEsBi+sIhaGJQ3rPO/v5CzQ2ozyUP3gemRTr2ZEno0UCZuamJTp/zoGy12YEh4+IWBCelh6JWkeiYjOmmY2KLVUVY5cbWnprEYHSaWUr42ZlsKoLYdy3zSsOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvT/wwvqexP46IbpMgHtkLhfPCii1nzHIEtJ7W6ac+M=;
 b=PZBZimVwu9SS7MI4We6LhsSnQy0+2Qlo+PvRpk3MCDWfVpRbtNuPuUODrD0CNDKLZE3RnbINT+U+jbMB0byhB4KBnZo5zxcpO10QTsVAc1U+s+HtaiL8t7Z6azGWgtGI55fWgU9AJPxEGibhdAFAw2goVzsMA2NZtF/+Xe+ImDkM5iBDA12RxlqHCwU5uKKrmyZXOVoMR4Fy/w7t+j1XUd94BD6OcmfH4Q6ahe1p0wPTB/CJVjiPmc3lUtf4Yvufn5hx+u+OSdbx2REPF0tIoOqbCibOVJeTZHygb/rVALbotp1nefNQRpIJJxtg+bo1HK/4MJqBNAV7aOZPdDTcBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:47:43 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:47:43 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pan Chuang <panchuang@vivo.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-iio@vger.kernel.org (open list:LTC2983 IIO TEMPERATURE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 13/13] iio: temperature: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:36 +0800
Message-Id: <20260717094408.509583-14-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd40da21-d3f0-4a7f-8aa8-08dee3e87307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	XGHIVGSnj+7056YfdfaZK9FC7JK795p3cO/19T+7tCTDqko81/exc6zyGXg4oFNY1xGJIGo76yALRd9B9/qbilz9WjJ6GNgmVftLsaCI7zIVzW57/6keXAzvLyZf6W+seX7wu9pKP+XJ/Idtndl78DEgNjJdVtKPkvPSneoEQ8pKgPXTdkom6zWIFMbxuOBcVqGbKVRaFe/Z4lMuoz92LVlaFVKshyT0cpAuARUWMEE4WY6wDe8GVHgc0Hv+Q/dNxRxbwecljhwZf6YhbVM//19VX25sKHDVSgprRJdCBvxmgV4ZDRNU/pKEd3msu6s/RXvAMIS6Ia03nOAK3ZXfW7ds4Wicj5YWKlAvTQFDNZrmFWEtIVMJN7sxQwOgk4xtPPV061PK3yIL/NLBihqtDa3OS74tBEp6xuTC3DsX5Ju41/YzAMLNF6qngV5+1ifVUvgaeUNyI6hZ6QPEu85EAh9IIk01w1exkj2HG6vNaJzhV8wTjwZTbRCnLdBKcxMlHebYeA8rUbavIzLg9BwF/qoK6IbDuPTMZhoWPhRAJqwuJnNUSetaaGVYnORIPXuhtisOVSny2npn+CPP3yqU6lGw03Vyxv1bnSAvVvpCPnnRMmenxV0YCzneXlA1PUPe6u62M6STtLMRDHo9Gwe7Blv0qER5bH+by0SPe9MXvR7gYsLFTVPxvoF+L3CQzJQ+MK/1yzYx38XYRqRpb+0USigD/13D+S+/hBELPAlg6s6FlRdnsABfbBXgvJ+tWUqz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L8I+PkQGjL393T5cnTDDq+e8R5h1Lo9U2SYxXN5clZBmhe7ljOY/oszS905J?=
 =?us-ascii?Q?6bmZIMZiOB3TEwsRGnXMTaXvulAd8hc4lHi1FJmPep68rUkyy1JJHMB/fx++?=
 =?us-ascii?Q?FTNfxhP80cwHqgyXGT/6jCqXpmg6njBPJWCZuxYBGCUG3okSR/Wq9HtmVDVe?=
 =?us-ascii?Q?LAOmvgQRnr06ORmugE+ttJN21vgZEmKFilkRkpNvCD6QVSsRuuEtLVhAcCJB?=
 =?us-ascii?Q?7WOJL82hwehVuBKWRLVfJRZtOWFVR5wSVcYKbY9foY36lUzdOXR7IcWDlFK+?=
 =?us-ascii?Q?ga9h+rksA8277DEGeVdc38myDZDAKybSlqevZnzIQH/TF0TkxrN5s3uACmSL?=
 =?us-ascii?Q?5ofba9Iot7gPBAcJ0NBTvHuL9/yjQcgBYwgjOUXhMf2T9C4T8ov1CmU/akst?=
 =?us-ascii?Q?IL/0Uytj8rZHgaFXbZrayWsXwJnL9Vhp1j38rX5SZm6lLBlKYn278AORl3NX?=
 =?us-ascii?Q?gt2WNGFIkvOyRzccFpCDjweTdZk3T+dCmJ0z7CqaTTEKDFpOK0ytsFz/ZO1R?=
 =?us-ascii?Q?VgK+TotpxRbLkJjX1k56VHKZQIkaM35j1B8KTWahO0qj83mf9GBhv/cjv697?=
 =?us-ascii?Q?S/dIeNnrBM5EY0+/5Mu95/ATOmCLEc/Ma+TThtAEx07XMdUM6FwWC//Ih4bG?=
 =?us-ascii?Q?gv4IEdeEjzxJfpVbX5Ha9el1xDJg9bYFbsIZuXOYDZ/gapWdsDb44h4Tp/yw?=
 =?us-ascii?Q?WKRPURrGFrMNWdUWt0Q9Zahv3uD3Ytsfmd6z9JBhmawPTwIgg2KDt1mKQdKs?=
 =?us-ascii?Q?uGLX8emYvNfIJIVBHVjBgsaheWcSDtMjlH6y0+Xw3d5x+LCzU1d+ipmmEiea?=
 =?us-ascii?Q?Ylv470O/IT+/J3kueIuU+3b5+Endfpo1ldjeNkVr8SgdkzvW042HzBU1VX4o?=
 =?us-ascii?Q?voI/+k5bwQGrgokjKOD7XpVEL+wqe26cbFkw+MflVmmRSBngWJASwauZ9tVW?=
 =?us-ascii?Q?5N5KnFb1ThaK1dddlSSdO28KsPDm6wuFfXEcC3OECrRSb/VtNg+nf438PXnW?=
 =?us-ascii?Q?vW20ux/xmOD1Vf/HWwtinhIhDGtQ4TJYNp5Qy+TgKRtQ31kJ96p2rNf3+c81?=
 =?us-ascii?Q?HdFIo3L+JclOA/qR/SA1Yg4CEYUJhIqLXopg2C/RYKn7CjfwEG67/S49APeq?=
 =?us-ascii?Q?5s0kxH087ElxwQbR5yKAA2rfQe/p0v+uwtU1BQ59PnFzaZzkmbLlI+UU9fWk?=
 =?us-ascii?Q?HdkgWiFTJ/pBR0hVjXWK60Bo1xmD7/Rms+yGkE6FynONydKKhOV3/gTPG5Ly?=
 =?us-ascii?Q?DfxOBVSG9pI2b1P5wLsvSkAI+Bw9D2Bug6CmtWj1++hLlNtoNs7CbFazCZKJ?=
 =?us-ascii?Q?QnSxTtdpJoQ4wqlKjyuMmrTuWTw4R4N7vpWa62Jwxsams62Q451khWNTro2P?=
 =?us-ascii?Q?1ala09q8/L3Is3EX49iC1oM3WGbkomSn9tuljRvrvwqCpYfd1tLQFQLXai3w?=
 =?us-ascii?Q?0a84b7OXg/IPOSuTaBFSbBIO/eD5ipU4ZaeGcZ66vT9lb0ePG7T7NX0Y/ALd?=
 =?us-ascii?Q?Aw04zjGJLlgc2Yza2MD0bDHDk9peEsr8I/XubAWgi7j+3HqRqcRecWDLXZtU?=
 =?us-ascii?Q?3w7yuGYCkDnOJgJjyp+5ZCJL8mydGyHweoUyjfJHese5LNyUzivUWr38X8ZP?=
 =?us-ascii?Q?HPooLKdnfWOmJbTfnb6dYf41MaRd0zdFTxLIZIFOd7lgoadjx8VO8ilSYx2/?=
 =?us-ascii?Q?XiHiDgAGwhlvOrEr3354Ohvxe7IXPSH/xqGN2sD+9sq1SLZqEU0QyO934U6l?=
 =?us-ascii?Q?EShMU0PBbA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd40da21-d3f0-4a7f-8aa8-08dee3e87307
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:47:43.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbu3vAZAZSIXD5U0NFOjEkjsYCIUHHyJx1u+0cTga3XPNIkJ2now0LaoGkrv6JYC+sL7/D/8l0s/DYepbrNowg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
automatically log detailed error messages on failure. Remove the
now-redundant driver-specific dev_err() and dev_err_probe() calls.

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

