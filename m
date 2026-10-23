Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792758644;
	b=KrUOoBFii1IL1I9bWGkAhdzuIOl0XDV0L4R0PtEUVhv+N9ZMh9LpJakjtx6aHs7yV415
	 Ds9fY5NZNiwVJuPPP2d8hl4SIvChMPFhIJgJWCWDYLUdTsUY7BvDssLFveXIk7i38To98
	 Vhe1nu1i2l21nSANUUJ87FCBD3ZvxBWedw2bQYVVfCwa0ostIa7medJ3007lXz84jU7rH
	 uKu0Le8kePeUn5n76PJV+qfE+eJ1A6N/+BM1ogvJfWD8Q/WX9ki6WTtor6Lz/VaBY7j8t
	 JE6/ggvHIj951LE+JEFEVeio09w4RPvfX+P+eU3RVmRqphbJvdE0/Ds9mY/iIUSp7HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758644;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DU9pwmmVPx7cA/5X07m/JlfGSFMHCTnSleW2cRDW5eQ=;
	b=rwMpC4586QF0/zbO2DEo83IElDELDoWMuMhh1xVfbzhtsbCdF9YEiCZUZ/E+LPlh4lHd
	 NoywEsFTOEAe8mnrjm/T0ksm6BekHKEOt6bEHlDJasKA5lUyF+mNjd15T7sqeI43ubvIs
	 jJWc3+TKwwe+aJG7PKdnsokM2jRqgNRGJF2BtGvyATA+Y1Y3mIjlesveXQG8YCUgZqlNX
	 vfV9FlD80zPamCEOfOvdSWzkFeh2cB2iYih0Qbe7RXrgAB76VIrlNG2RIUMoSfx+/ctkV
	 Ol4fmdStcSLnPLqXta0J8agoCrTBPH5PeWOE7z1q1lqcJFB4e5VtvqxG7Y2aRffqV1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=czlTQmp8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.31
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC7606A31A;
	Fri, 23 Oct 2026 12:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95FC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=czlTQmp8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVWe8xzlw1aFxw7izbXnttWHGJw0UWisCNmN2WrWqCjAI8Jeq/kMAKlKQ+ByA8OyePIfTsDx1jyo/L0hvkpg9yrOaeJr3mGHcKB5WUAHphnf61GZ/du4L1Lq6zh0W6J6F09hjpQ5V4he07yKCa3mIWJCkeC2fwnvpuPh3yxdS7/5a/TwuWtk+tCbd+o/nuvFw3SuDwmFv2uN7lWj1NyWzjAkfXNXqWQRkkmZpCCHxDNLxOdwHMLKgmljQFBPOXSSj7dexyJfcCBuLPNinbpDbDPg6O/Jyckq6GG1gOwGpIMimhPN4nBpvKk29FCz5QMpGnbWy+QJ8VWtTc298GDw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU9pwmmVPx7cA/5X07m/JlfGSFMHCTnSleW2cRDW5eQ=;
 b=X1Aj3WGEYJjKo81bbH1xJ31Lq0CxTcjBiDLWTf5BomNHzi+i4poruLQUV+wKX2IzOsYDunvmK5S8vTCcQKTl8fBNAIZ5cdlTSe9iKy0Mv7qHwvLurb9ZUTc/V259xO4CoIfTLI3SkDHV5KrpeL8lcdj7FFJpYaIfiZaq1Vs/SXBKuly2MljejrtqVMcrmRR6F7FvqBFPYWS5URGtVDBIugMqTC8gW6L1xAWVqbGAjt6EXchPKepCJ3XU5+Bt7ZzOEvjsVlGAzJ5uuk9VnhDjfqtzVogXy1sNQghlFV62Ihbb/jJ8WGidMPFt/9RfOEkjPwscaeIz1sLzrBHZGiyY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU9pwmmVPx7cA/5X07m/JlfGSFMHCTnSleW2cRDW5eQ=;
 b=czlTQmp8dwaBbnoGMgsZ2yxL2ZFWkLnlHylMM6jD1eeLo+BvXKYY/96LjazzjAn12lNqYSu/e/JNn3sEAOo92UWtVxwpmPcHZD70Qw/imn3dIbS0Zj3PVzPv88QDla9/GFTDB0Ry3fMHw7ia5mYIAk/nCL8szg/gW4TzHcSTubU=
Received: from PA7P264CA0242.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::10)
 by VI1PR02MB5888.eurprd02.prod.outlook.com (2603:10a6:803:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 12:30:39 +0000
Received: from MI3PEPF00008555.eurprd05.prod.outlook.com
 (2603:10a6:102:371:cafe::9a) by PA7P264CA0242.outlook.office365.com
 (2603:10a6:102:371::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 12:30:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF00008555.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 12:30:39 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 23 Oct
 2026 14:30:37 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 23 Oct 2026 14:30:37 +0200
Received: from pc46036-2141.se.axis.com (pc46036-2141.se.axis.com [10.94.180.139])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id ABBDD2CEA;
	Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
Received: by pc46036-2141.se.axis.com (Postfix, from userid 16197)
	id A5F45584AB8A; Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
From: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Date: Fri, 23 Oct 2026 14:30:29 +0200
Subject: [PATCH v2 2/4] iio: light: opt4001: Re-use generic struct
 s32_fract
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261023-opt4041-v2-2-ee320812804c@axis.com>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
In-Reply-To: <20261023-opt4041-v2-0-ee320812804c@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Stefan
 Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesper X Nilsson <jesper.x.nilsson@axis.com>,
	<kernel@axis.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008555:EE_|VI1PR02MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 9651d229-07c6-4c5a-f1b4-08df3101723c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|23010399003|10067099003|261021123027099003|261021121427099003|261009223027099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HcItUnYbBmwp3ee5fGPBuJ3aktZP1jWwjsETyCJ2HQemNc1aDxGnyreUpO3NPOkAkp3AC0yQpBP0Jfvx1zxELeGqMVFVDjYGQ0W76RVQKbTGbjAICkLvW1+U9rzfYX9Yi9zKxIlHyYKB7qm9com01g4uTccLwsgbEMGRL0oN8Pn0TtoydZHojFh7ovqBxhLJrquGDqf6/sQaJLJyoSm+3+F4QYkfelScJ0Ia6E7ABuBItbr159VnI70CPpV3QXuPYqr2+sVi9N+lP5Z85Un0E4lUSsl9/tZFdKntfHHvRxkHb9+5yVl1aE9BO7wyIOX1wlAgusyc07HgptW94nLs0R3z+rHGDruF7plk3C7mn3n/JeJd7yqswiAkzOT2MJDEMKUdFfgZurWTi2/9B9DiHEonR20W9L6ZYtbD8DjYWiZSmI+OF5hRdA6+dcdR0Ycd8JMGBp6qD/4D52ok6yb+4JbNaZ2mVLDffqjpPJTDIDCZd5Ile0XOOue9MlQS2eNaBzN1o+azwXpOmBw8G4Crd4mN/2+SnNQL6qgw2RiYKNP7KIpxcAi8ADk+mOf6Ijqg9ehGNpuc0uGBJIW/spdHvADfoIdkV4S1CZfZOpaxhU6W665E0yoYU8UgzbVxTtaCRzk9gzFJd1LtXiLSNHwwEkP0vrOq6nLzLTIVIGN89oJlzCWNCqFD+WMIz9PwRTfDS4oDFBoBYc0cj7+nofYcZw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(23010399003)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pp1z6qGw80k2gnGoGSt7r5D8rBpya4lv1uUJSxmTmsKipZeX8hgIpyZQjLh+cxY/4Pxy1mlJge1b3uAhBknp3bTQXJL+WzLUqwFfihrpyaRLSXjRndXBk6kwP24SSxHku/qULI8M+ioZqmcskz24XzV9HVmr7rr/07S0pq/8VR+9OznII9mdP9zk8QFFeoIffTrlCOrHimrw6uhETJkR5hA8bf6N8KLU3GhsSokKpLD6q9gBKWtjAO0JVtdjCLmBdA2qmr8sDSd3C10uSTLulaoPsvczWVJsHKx3zO6GrOYh07OpwedGXLYu4z31kfw9XQnxvU/v+J9FucsQgFBVAl6+GymCheyvR+JpAbXgC7P8df4wrdvN3gqhVmfGXbBxyMcYVeUgElH7F3IApfIv18Mg9EQFrm9itnPEvsT/kMIQ5i/sqQBUbbAMmV6Sn7oj
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:30:39.0518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9651d229-07c6-4c5a-f1b4-08df3101723c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008555.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5888

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of custom data type re-use generic struct s32_fract.
No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
---
 drivers/iio/light/opt4001.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index aa3d87995b7c..dcde10914a1e 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -75,8 +75,7 @@
  * lux values.
  */
 struct opt4001_chip_info {
-	int mul;
-	int div;
+	struct s32_fract ratio;
 	const char *name;
 };
 
@@ -88,14 +87,12 @@ struct opt4001_chip {
 };
 
 static const struct opt4001_chip_info opt4001_sot_5x3_info = {
-	.mul = 4375,
-	.div = 10000000,
+	.ratio = { .numerator = 4375, .denominator = 10000000 },
 	.name = "opt4001-sot-5x3"
 };
 
 static const struct opt4001_chip_info opt4001_picostar_info = {
-	.mul = 3125,
-	.div = 10000000,
+	.ratio = { .numerator = 3125, .denominator = 10000000 },
 	.name = "opt4001-picostar"
 };
 
@@ -199,8 +196,8 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 		return -EIO;
 
 	lux_raw = lux_raw << exp;
-	lux_raw = lux_raw * chip->chip_info->mul;
-	*val = div_u64_rem(lux_raw, chip->chip_info->div, &rem);
+	lux_raw = lux_raw * chip->chip_info->ratio.numerator;
+	*val = div_u64_rem(lux_raw, chip->chip_info->ratio.denominator, &rem);
 	*val2 = rem * 100;
 
 	return IIO_VAL_INT_PLUS_NANO;

-- 
2.43.0

