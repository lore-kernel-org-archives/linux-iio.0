Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013017.outbound.protection.outlook.com [40.107.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFD36F8EF;
	Fri, 24 Jul 2026 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862382; cv=fail; b=kyibCFazm0ph2vS9Q5NhICd0MnvBgZl7cx5iCUHWbCl40tKjE7B5y2W9dkn1CooGbMIwYy09WWOmnP28yG+gASpGJH3PB6TWEhmce4ZPIe6vK3klMGi2oHQQQN2Z7eg1s2vjb5FF1PbsSPXqq5yhiwPuWgi/QnQmhKIBm9a4OjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862382; c=relaxed/simple;
	bh=hHREfG/weNgfBQkOddNdGMVvXQcNSzAijeDC+CGvUV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ph7MVQ09Kibr5y225DJ8LZdPSWKjIpE3LLccON4ToylbFYNeHOizoQCAQ1RUlzV9RglhuEIzrePf9DtjXKBbcCUzuGWmPvhAeoxd/OYJruCO/Om2Yq2/Kjw3xFZklDn+f1xBIL1zq+Dta8JIhxWwk5rZYkKgFQ5CcpKuixlb4xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kkMLU6cF; arc=fail smtp.client-ip=40.107.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kkMLU6cF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGdQ6b/YSTecljFv3fIXqbLYz6ioD8/8Zn64E9nEU2ZLngzYm512jwk9gRzEeY0Sef2Gx9Gs/TMnSlsVLCcxHs64YN57NJ7xH33tlzc5Zr0Kn7yOncB2J8krlLPPsZQU2UHc3F8ahfrHXZjWgpAnI2Z0id1+veKnJk8Zlgf5tR7mg7FgtER84oUKa6ZA8hj1o/kTvEfaQRBxMLEmVJ79hskSztoDizyz65y0X9ydoAuundAA2leSAaZmhDfutIyHub20gac4neqtINTKDdt1BXgxulT372njQFAaikvtXhnMFfAY6PTNKci13AH7lJMImKliOgvH0/242/cp8TCIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv4jmybL6fK5uTKxBj80kee+E14/ohKsDQTkEP+s9kY=;
 b=KVPoRBGFU2+gq08KWNVjdQY8ash+J/cFGKP2pxMAcrcLIn8X4DjNJscrAy32eo6RJphQIot6uU3EGbjFdYSdhGwqHeGviRv9zx60Q5wLlqj1g3Zhpi0fayiuJB4QUkG5h68+qxjIKv5n27TByzGyzlni+udqMuI23pRVDpQt6eHkGe2r/h1q1WakdS3WtrFe9NUl5kWKVT1bb9MVPTWZWK+IWGoo/w9VI2iLgIZFIhAvO4ti+lwUXN4HsUX69ge3B7ho7uDqmshnK/FeYMrBkwpeA7sJFIcDx80PMHhAWyVP4ole7z8gMxNo2nA5kDscecmGCX6SBGrmT+oVyXgMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv4jmybL6fK5uTKxBj80kee+E14/ohKsDQTkEP+s9kY=;
 b=kkMLU6cFHvgh/glFUvESMP85QZtbdZRX1MzRj0tfgaA6YcUZ8wQDRarz5hi5jcVfi1jFRGWeo+HCEsjRDbosq+HEnP9A0VPCT0xgCUVoBe8pFhPvguMYZMjE4eUbxPc8irZydpJy/YF17JCHm4cBgZ/b/m6qGLPqCDjjicrByulOVmhwrRPRlYyhILNF1A4AhuvsiEs1UbVJWDbVTddff+OvSUxHPjPn9Qx5H3xV5gfeYgodR6N2bLukVZcKxua5Rf6t8NYQw/6WVyXttTdvNQtOQKAJJ1kwqiijuFH+G83AwvelBw5iF4X6Mtkn4HDgUM8ItPzR37lifRIAeIdtBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TYNPR06MB8717.apcprd06.prod.outlook.com (2603:1096:405:3d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:06:18 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:06:18 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com (open list:ANALOG DEVICES INC IIO DRIVERS),
	linux-iio@vger.kernel.org (open list:ANALOG DEVICES INC AD74413R DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 02/13] iio: addac: ad74413r: Remove redundant dev_err_probe()
Date: Fri, 24 Jul 2026 11:03:37 +0800
Message-Id: <20260724030524.607185-3-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96b6652e-a048-4272-8d24-08dee93087e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	rot/Vm2ByHx798i2VsB57QWuFsv6G+eNe+6/FwFi9EU4WBZDX4Ofqum18e4EOzcWMrCO+D24FEsh8Y3ax9C6nWT0NZ/+rMKqspYfbFXXGGGTdq37vN2+tD/fte+4dMqaLTI0FrX/Sga7iW4EbxO2TW4c9QVJlC+BQpY1L5sGpneg16w+kU9sgpHGLb7jp5wYJIQBCKGXsbMxsv7drmbDQvcNmedzabiOgx0WuVwWZVOdrpuIWTzb2n0N4mjlC6Z8ci1gA3pxwrAkehSikZhC/jHfhsMmptC9g/xgK3Lp6gcbI4/H8WCbLIiSlRqZh/3WBTIAJtUGXxsSMe4FKUouNcMtbasMsvAKxBD6U/2+s2IJd3oyTjpJ+Mbf66OwQxO46uGbTV0VSHoG8wgD5noOBlVdKP4Yfz7Kj1GKb1p0Epx9eP82oFGfXzPke7uMwgAugQtINorEC/MYaOdVBPVZZZA7i2VqD3ysPdIklVYG8Ep2/AerbKlm8KFSGKLveDBOnbtfYzBzT74qZdNsYEXhmhkNpAu4wh56hDqIHRMkKglvmva/+hGnCdKzabzqZgOpAdAxpoG7dRpRts1jN+6oVF88mZqwg3LcHMMPTD/zCqbxBZ1+6EB5x/y9LO3B477P/mz8Rnu9GV4AOiSHFjZYgamZ6Y5N0qXAVGHV1jJ0dmTjgLO3g9r3yV6KABUFVvUFLtcMpUt9ghO/cXhbolEDlxrNFwlL4oa3B+0xHSCN/3g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2bgioPLuHWn76EjF3n7O4weVCFDnhOunM4qN4b9VcKtthCSSG8Y8iUu/l5Dd?=
 =?us-ascii?Q?EYC16yI36YZ8blH4Q+Xb6A9wQqhkY+A7u+VXcuvkiYSxeUzvK8F4wOsX2x0W?=
 =?us-ascii?Q?D35SbBTSBObp5Iwy5TZQClt9Yz+v1b5Hk+1wwWbJ+DKbjWVcDoLQdlfOR38F?=
 =?us-ascii?Q?/YpO4DOmpXXdZ4mKhnTvHbNk9pAJaiNsnIGEFGIrs3x8A3BKCb/BtGv9EzHs?=
 =?us-ascii?Q?Do2u7D9t+xI4vLMRSdR9eHXEAshgmXAkp5A1TdQLXYO0A9lDIvx1ay0QvihC?=
 =?us-ascii?Q?5mLLBptFpmhxS01PVWR/6xKLfzbLgOgSaiMDt8UeMq5ETsvGHnAZqwCiDieC?=
 =?us-ascii?Q?h0vXb/y4rMlA40wkZEKIbkgXKEOtxkwyFd9MJcUj+17W19zhBSoxg9mq15Ww?=
 =?us-ascii?Q?FdNgHwSI3RrerhzQFA+M/e5CdZLjn6kRmbLPfnT9n+vL0Ui1V295h4Z+kJcy?=
 =?us-ascii?Q?/d3e83iXxWFopfQTjZ9f05J4anG4ZV/gsgfYj1Bck2GNlMzt8IhaJ8wyqeig?=
 =?us-ascii?Q?/vtnItDc4lpSxwCuKM30Au2ajO+GNxyo4YvkmdwZ60JExWBu183Aw/20Tbd+?=
 =?us-ascii?Q?lrHZI4cL2hroHsafD3qz+5PvnFPXVn5PpFcql6C93yN8EjtxRxXPdCFTZzb5?=
 =?us-ascii?Q?jo6KOLQd42RSN7LOaWMQcuTNuUM/izFB0Gizw6i61wvjwM8IGPFxt4DjD0Ut?=
 =?us-ascii?Q?TZL9mKCNZh/sIv6dBaSa1tYI/a8Rw0lYuztmIlHeJ96237IAazOnYG2Av29F?=
 =?us-ascii?Q?7WGKcRVjRkRZMHrPwRGexvUGxqrYslaabtpPw3PV9NzWTV/sA2feIO3lXXlV?=
 =?us-ascii?Q?Oi2TbjrDI1edb/DYvJYOwFi3lEcE9E6cPWWQ30AjgByXbHwEdOLXeCGk52xn?=
 =?us-ascii?Q?Y0Xe5xpSmY2lFy/7O1gMdVJU8icfKrSO7TUdRmG5MCw4TQekHeogijCgefG1?=
 =?us-ascii?Q?qo14JvrBUzmGMR2B52Plsi0pPzMg6csAfl0m3EDZfsqb1kU7T5JFOT3tX/KM?=
 =?us-ascii?Q?NDsuRax8g/Ef48USGGILrgLq9Zmdp/9HaAsg7A85oh6A+N6UTGfualljj3sY?=
 =?us-ascii?Q?Z9ynCNXdv98gvylPxaS/T7Kc0LtbJJ69dJeYx/YSRijvoZ/KdFXasin+ikaJ?=
 =?us-ascii?Q?gIhzwoo4xqMwjfp4dHxTDIF8YoRCEQon5OAskMHFn1hBF1+RSYXe6IqKhQ9S?=
 =?us-ascii?Q?ozv017N6cB0bpA56asAWaluX44o/IYp0s8+JRZaK+pg8PkefXBJNHH/MK3z6?=
 =?us-ascii?Q?f+OL7BXI3aTmtWL58bBsBq//Apii/r9ulxSnX7o8eUGDORyRGw9EILvSCq9R?=
 =?us-ascii?Q?dKA9G+SbuzlWe9obx+q4mC8jGb/JNizRy1qT1J7DseRbUB++tsx+yUM7/F1w?=
 =?us-ascii?Q?vsMVM5o99Yoy47RqvsRGLp61UfKaFid6FKMmXP5F32QX4sDFzyms7OkSExOe?=
 =?us-ascii?Q?h5FYJJ+EaTOl0PnrlTw579hMOTzsydnhik8BXfqAoErWPyCPih0xOLpdPlb1?=
 =?us-ascii?Q?eovGpKQDe99DMTdPvqKX2Fo9xDUYE28avjAe9PDQpMPwKdjzIAvC/xDSTZd6?=
 =?us-ascii?Q?HEol1KnYZObisZrr8DWEp7si1sbqaaaUEhfzLxc2TpHo93NVD9fiSM4FB+ya?=
 =?us-ascii?Q?yMWukI7UdGzXCUP8eguBDG1qPy7XHK2FxasNEmvBkO6hlibrw0F2obF9Wu7J?=
 =?us-ascii?Q?KQ21uojX40IlEG6Q74ZOSRcjk8clDhqtPxFRDJB1MVrJZjX4njTk6LAHsbzc?=
 =?us-ascii?Q?KmfB0ip48g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b6652e-a048-4272-8d24-08dee93087e6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:06:18.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mZpw+O+uDVvqdIbvdQp6M9GwkQw/cxhnQyMUq+wtsJUSCNzgBzcVjWobF/xnu3bT//S/93vlI6fNtRq+Oni9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8717

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on failure.
Remove the now-redundant driver-specific dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/addac/ad74413r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 43bd2079cf6d..2e5a58e48a89 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1457,7 +1457,7 @@ static int ad74413r_probe(struct spi_device *spi)
 	ret = devm_request_irq(st->dev, spi->irq, ad74413r_adc_data_interrupt,
 			       0, st->chip_info->name, indio_dev);
 	if (ret)
-		return dev_err_probe(st->dev, ret, "Failed to request irq\n");
+		return ret;
 
 	ret = devm_iio_triggered_buffer_setup(st->dev, indio_dev,
 					      &iio_pollfunc_store_time,
-- 
2.34.1

