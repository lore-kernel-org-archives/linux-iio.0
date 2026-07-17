Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013040.outbound.protection.outlook.com [40.107.44.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A893E5A32;
	Fri, 17 Jul 2026 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281580; cv=fail; b=O8W4BWzal+ujJdCkYPINKiDIophqWfJ7va/uMLEb4Zn85vvMAgjx8D8l3DY3BQcKyS//keKiAIfxNKkiAK+69Jm3bZeU3TshORzrncJGEY8evy60aelTolCzK7Orr88N9CCa5ViPYUZOoMFW73AXsD0CiKVDcJPn+xTUIWxHuGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281580; c=relaxed/simple;
	bh=0CkFVpFr+6PwT5/yn/vkBfMH04Lc5o3BpFftyUT0QaY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m44IPj8tV+b/HZ68BxiXoal6lDrXz0DXT0AOiWp6xaei7uDIN0iEtJCiPTY04rrrc10b8TI8ARusA6PtwKVEWOp5rwUOQrHjur3KDpJiqXJGX4qScM3kReuL/0LqVrrKck8VJH+W00n7j/SArZk7tG1VNWhKXjE0YdSID7AxIJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RqPbSyWw; arc=fail smtp.client-ip=40.107.44.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RqPbSyWw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEVNd06u1NVuk7TPNRopoouaOqyCVu0x0PbKT3pfpOmGZIOtiz6hS2ElEl6dGBkDREBwq+wabKV/Z90fqUVpFUa/T51xFA3NDbgZwjtLMgDlP8epqF1fHC2zH/zMoGxh9n/0hGTAaAFHChhkH6lujwY7ZNG+oMYJ1n6gbtRKWsdGtEV8S5F6BQumTERiKjRNe+2SlHEtd3qYwp93nwLWbvF/mwJ6zQl6WA4zq+ea09WaPn+pGMjSTfr9c4Db81Y2LTBukszuewy6wyFZ6tND9dcW7NHViv0wwvlv2dfqZiljzAj+7np4KHcD9LGPXNR/8FAOKjsDF0npuwwZvH7thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WelLbW/ZF16JIBNWad/T62V5DDuzAYI3TPhRJQjrErY=;
 b=EDNOIFSQUUlTTWsPRuqTP+b8FgumBrgcAxG14yFh49rg97DaTbgAVW5z2WVUlafA5ygZGzGm7etvmjrMoH8yDdO0n/rLsJh5ctkPbCIuLI6zwhjSipj6749DUZATJG5uuC5nxjP3ZXULrL2aSRtH5griKofdkc+ixZPB2q45jIKB+ytoD6UtkvQyU+jSVwlfKfNoaUqQ6iegOP+21jfR7XIXmBdZrSyOJNdgyhkNq8T/m+RGVF9Nbdm8Gn49FrSkmyUlQAPIPGybymN1d5egUBRll9uk/OnwCzM7s56aafClDxwlrbRi9qruPRqRHzL6wg+aPTvXyBOjosrBFSL0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WelLbW/ZF16JIBNWad/T62V5DDuzAYI3TPhRJQjrErY=;
 b=RqPbSyWw4ERxkQnBoSwnDKJAhSy2H69x7hEylUsMQNKPkO3Trvbj5evhjJYrveFC/HhNA8MIJoOviiapyh/91w6ar9IIGQQgxhq9FI77BezTsWFC6W/xm3vzJp7owV90ztMFI8FNQeI3VNRs4u/tyrv0MnsAQfcbJtIGABfIMWwoyHX4vvm+YyKNgbBxBr1SDWxLU/aRqNtj1gPL4wy4kZBk5v2aVvFiXh8qmZrYA30hvvaUH0umauPLMaFxe2dj2n9juzafO11DKhVdIF7ee0iwg0nGQNDoUjixNd8uPpYurBgNo/r9xj1xhkqQFjuhu2Nyyq45BeXk60mU5xktbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5139.apcprd06.prod.outlook.com (2603:1096:4:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:46:15 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 09:46:15 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Siratul Islam <email@sirat.me>,
	Pan Chuang <panchuang@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/13] iio: chemical: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 17:42:26 +0800
Message-Id: <20260717094408.509583-4-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b35a95e-25b4-4fef-920f-08dee3e83e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|10067099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	Q17+tIF/+LbVXJy4KnS46fJ4xj7eFRBJ+01Fj33b5Sb6k+OwX0Ys1hBGEGJfOvfucUQI6+0DwJV8xsLmeF7kL/WX7/WlwB/TWCkdcmfAvoO+Dpvx6nckeTWdU97ZvcU/vuxoOn1xyQxpjXKlEeUV/ZPJytCZdkj1dZRb+GRV/F0flr0VYZ0lFGjSQe0WkUPb5LFqj1AECqJIL1S807+hmeULB1gIyJZEckH0VVG0m+petezdrtOSdXRshJNP0zkYW/gEv1PGApUvze5x9pWinwL0ckqAv3yNSZdP1n0lP7maVJRgRZoEiMPQbk5rHc4eLpcVeXoAtTVP3elOZ8/TBdp2F2PLSG4mnA6yFKZdlbbyi9VYtxvL9j2AJ6U1OBJkvb5uxLZuLBR03aglpueda1naGzxlc09jFfuu/NRwTR3Yulblgo63swVzbj6v/k9J0sIik1SJ5cmh+WmCdend8AubwlkwEgCmQi8qnpsuGnC9nnv4RRh2gkJQ38c2gSOI2vl+yzlgQ2eCHs5gyq/xTWY+da2QGouykvASCp5X/SECyTNQGpCOAJGF6NnDUq5zUp33mbrNSHxj2nvQWpxWM2eTOQ/FzotmaCOkxoxj4zORMoMmKFjY9swxBGHoW3CZQNiTMvJ+cMJq8406q133EvIfcHm8DgpQ7Xz734djKfKXiwWLzlU6YaF2roVpeyyyzvTF35OV8eXO/FpyZxGtPBLilon8HksEbmCiOjnb/eohbsOIgkUFDj92vdZVM0r3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HPXNz/9/N4q0pa6h07VWfzu96XsjDoy4njElOwNRj1hZCdZSeAy/5Q7KjgQ?=
 =?us-ascii?Q?X5gsPxVqYD3a2hOFBpHkp8uR5auUFyTuVggZeca6A+k4osDPp5d5/xGXT+FX?=
 =?us-ascii?Q?SGSRbJjPXfusHd6yW+oQ9fcqakeUV416Vk3p8ouXTBVgQECnSN0+8oca7GKG?=
 =?us-ascii?Q?ivr6RK7doNgtT8qf9JF53CujSIQaRVlGcauUoWYZytJQETMvOTdiiJKC9Qdf?=
 =?us-ascii?Q?ovC9kxMvcJjTzkKRr5jVTUs/wSu9YYQ8nZssIzeFxwc6Wa5VskgdLi3b2c+G?=
 =?us-ascii?Q?P0JERj166sebwHZCcJ9laU22c9dNvGGLVfeEmp+CrnlkTLJd+UV0aNjeNUgO?=
 =?us-ascii?Q?SXOKZjLoy5N1mC2LOl2cFFsVLMvPlRSq8F3x3oLSKXYtJ45E0C6Fcnlz1LaY?=
 =?us-ascii?Q?ZjgrHF6nalMVVBKFrV3RWtRv1Ba2lCRAAWARaNeTuIBbb2vxzvGB737ilj3n?=
 =?us-ascii?Q?EeDwBMXqYfg5DN5xkNIpywzG/uiVyaf5ilHKGRY1I7yR38TCmGoXT71HtxJo?=
 =?us-ascii?Q?Lb2w/BFKzEUsAML66S4g5hu4byiK46ytKhiamHf8v4Bw7mc+S6P9uVMMA3+p?=
 =?us-ascii?Q?7BlEw2kt4EmqKNRuepsi6ovBLPO1dm+wU0GVE5gLLlH2hlOkcyHGwHS4pyR0?=
 =?us-ascii?Q?alEY05nauG9hJ6MJhpAKjPNFgrBPoMSYZfI+T9DrMCH6pcHeJ0u0BbuhY6Xi?=
 =?us-ascii?Q?5CuaaZS3/LMP2wBh5CkV7amf5uf3TKpBMeHfdzjwW0Dr8VuIvuhjPStjWaM9?=
 =?us-ascii?Q?plH+288i8bwPc7fI7GG3GFtDsLwL3XRcH0n9P+YOpQM+LMKKerNRvNe+/LNG?=
 =?us-ascii?Q?3CW8Ett1MtemiEF+oP+KoqaZ2cdZvDQzp7OaIw3VWT+aZWIHXkW7wotZuB62?=
 =?us-ascii?Q?YKob1FgV6EQ0PPfSathksYMVT2Eg7E3oK0ImXHC3ONfzRTIazgdSI503O3/i?=
 =?us-ascii?Q?FPdIV8u/grKB7Pr5+pCUBsvQhIaNnebzH9bhTLu+mTVlALzXIbuCoiex0mIs?=
 =?us-ascii?Q?gNCF8xCRq/h3ioQglY9BSx6KS6ZRO7RjbUzOaB4qpvp+J2Qqx8HhwMfoUxKN?=
 =?us-ascii?Q?4LEH4+t0rp49xBQQoGnJmFtH0fDsesezF7/EQPQwpXydajDZNgKDVbXCqBwT?=
 =?us-ascii?Q?FhiOiLuJFuGxLNXKQR6o2IOOXVJbOIfVTdxnIlPfXzif26R4CZ6gA6wF4w6W?=
 =?us-ascii?Q?DgVURHQ9jGe3kNS/QQzkuNA8Le65TNwI/gDSZE2O7+Ergn8444n6z47WbMrA?=
 =?us-ascii?Q?BE44juFT+36Xlt8WULFJF0t/WpyFHHlQTEy8xylYhmHaRC32rHmWsFy0k5RL?=
 =?us-ascii?Q?QjT+cqxAmzHlF6Js5LLnWlXHPgPaZIuNxWxnu29LSXNDhx+OpMczyPcfq2PJ?=
 =?us-ascii?Q?/H1sXaIsc88dUGLzuBxlW1XZgNKiVv8B7thLRhgd9Kir3XGzCHpLYnufJjKD?=
 =?us-ascii?Q?wG0qFpCQ9kp/nKL8tLdv72UuSJaS+zsNECPlTX7fbwe2TRWhnBFlLi3OP63a?=
 =?us-ascii?Q?/X1tsj5WamREaUpUQx+9g9aAEeGccoF3eDmNM/+d6iAozhN714jcZYEz8fGH?=
 =?us-ascii?Q?tySVLY0ppe3MFRUtP4Mr3sE7W1dfqJGs9xgQis441Jv0zhCz5SRlEdERk/jI?=
 =?us-ascii?Q?0nL8mZFKv70A15JMbp0Aj4ChllrF00cyAiMnZ4ez4Gn7ADgVghWd++Fvrone?=
 =?us-ascii?Q?Zi3FTohWDJnTRW8FtnZp+/VJt849ecxyrRdSRbKvNQtzbu3ktf74+nAXL4H3?=
 =?us-ascii?Q?5MYEL+/Gmw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b35a95e-25b4-4fef-920f-08dee3e83e4b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:46:15.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhtPWksDiBpm/n41KzrmmvpEJ1JyHZRDEy1cK576fZO3lhmt2hKpGIyGJvPLR2RHGlScaHFw3R52Bi6qy8Iz7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5139

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/iio/chemical/ccs811.c      | 4 +---
 drivers/iio/chemical/ens160_core.c | 2 +-
 drivers/iio/chemical/scd30_core.c  | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index ce7187ccd706..d126ee12ffe5 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -484,10 +484,8 @@ static int ccs811_probe(struct i2c_client *client)
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"ccs811_irq", indio_dev);
-		if (ret) {
-			dev_err(&client->dev, "irq request error %d\n", -ret);
+		if (ret)
 			goto err_poweroff;
-		}
 
 		data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
 							 "%s-dev%d",
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index bbc96c4c6283..7c1ffda38b99 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -320,7 +320,7 @@ static int ens160_setup_trigger(struct iio_dev *indio_dev, int irq)
 			       IRQF_NO_THREAD, indio_dev->name,
 			       indio_dev->trig);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to request irq\n");
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index f85cdd8bd84f..770571c21521 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -686,7 +686,7 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 					IRQF_NO_AUTOEN,
 					indio_dev->name, indio_dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to request irq\n");
+		return ret;
 
 	return 0;
 }
-- 
2.34.1

