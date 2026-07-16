Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011009.outbound.protection.outlook.com [52.103.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87330B509;
	Thu, 16 Jul 2026 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163912; cv=fail; b=S5g12gcTYAampZizl/14bn0QzbWarxsVbNfYlQN7mf7N9lOvX13hfwl++hSoy4TWA+iFVEKN0sCmdqpD6mSmsK/RNHBpJ9v2ZoEFOAS6q3rufAaMKYgXfmlcKn2G4hjRLO5AJhkHggBaU8srRjLjcvjaWxeOvtiZfJU67afcvIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163912; c=relaxed/simple;
	bh=jw3QmP82iFW3/vVXXTlh46uibzn0Iom4NyjTX0L3+QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bha+Fd2XbGlPfJdXxcMQH5HA6OUA3x9kU4Rw0SvcRdEtWnA4DkR+2RMOT4mzQKdt5SN7pUgsJRHuX0LrK/j0j5so7PYjpO/6sIe/dJdyqGGsY7cBIZr/WmlRgQkvUEoAypT5Y3VIn0Kl+adZ64TcvRi/VYGX6rrbbHPSbgyrNs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h99MsmR+; arc=fail smtp.client-ip=52.103.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h99MsmR+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3GbebeiJK73mbF3oHBapMEAUinfjxQB3rmjv3mG+warhEKvUV+wjozs73OLjzn2XI1Xs8g9UAA5Y8eSZuNYUt4Tq1VykaC6xues6XpGiVZsLsq27PYWKym6r6T3aWz8WYruUI6s8i2q/jGxnN6ZA9s3vH7gzs1WHeGamHvaKYquUa0kdRjIoulv3+z01gTB0R2a4XbSA/ZYRa73tjmLSN2q2I2jV0sAoSRQ3E2wWLw22S5Td51fG/vr4HH9BTh7wR2Qb6++SonAeERSUjpcpkbetyBQfJugAPDy3aMDjyz/74QlOy75wlpAQmDp+yQa9w/qCR9+mB8AeVp3ZlFbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDEHFG9axwNdUbA/tBwfB1DYjNp/ex53/DGpPyR4DNs=;
 b=R3lM/44LJkPVM8a0Ypm5zM6OhcME028J9c5eJKIbz70HmIuGSXoxaGsGnzOTpK+51k2zG3MXGG4WMYcYlU79SHbaBQ4La3QG6aBL/WFaWyqvJXg0rO48LWrnSFB0/rdUne+VcRK6CGYPeCPRuYB6VuCubMw4Pc8RQqsX9n1D0Ybya9LL0nf1J34YOM5lm1IRcVYw8dv9cA0XOaig0sLnIzBmvycsR58zj+iUT7f/xv0Mk7E3Fdrl9MXqTiGGV8VaZnXx2Q4p0NUFuKllaeaFZvqF0CDmr1sVtYWhkrD0aJePujye7snmUFEZ4zOciw8gulA7aLWHygqPOhMGMAuZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDEHFG9axwNdUbA/tBwfB1DYjNp/ex53/DGpPyR4DNs=;
 b=h99MsmR+ud41aQpVf+hX0DQuumc337s+pFNtOS51Rgy4AV5TS3QtaZ+W8oJryfdTCV4hmREnlJkDiVrycVyQEHN03pIMj/hRQGLzDedo1yqB/NNu1QJy+qNg+Bx8VlnRkJGvRCiKBYVW07c3e3VZoveXHB6eUdZYh5UwP16F8ZQgCXu6Dn1rFx29w5q1O21yF6ejjmDqzbMW0afEvOCoLWWXIcutMwi/830Vm0dYA58OnO3f0ONZ5zk/VHg7mDk/WHJuOrXAxqfh6JJn3K8Hq6m+7u6WT5H6CpGlS5GgxjsUM6SHT/c+eR3VYGWp8/q3M2lvftdRVLr8m9CWiY4qzw==
Received: from OS3PR01MB8244.jpnprd01.prod.outlook.com (2603:1096:604:176::5)
 by OS3PR01MB9332.jpnprd01.prod.outlook.com (2603:1096:604:1cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 01:05:08 +0000
Received: from OS3PR01MB8244.jpnprd01.prod.outlook.com
 ([fe80::cfbb:cf9d:dd51:7971]) by OS3PR01MB8244.jpnprd01.prod.outlook.com
 ([fe80::cfbb:cf9d:dd51:7971%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 01:05:08 +0000
From: OrangeBlack0765@outlook.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengrui Liu <OrangeBlack0765@outlook.com>
Subject: [PATCH v3] iio: light: tsl2583: migrate to sysfs_emit() and sysfs_emit_at()
Date: Thu, 16 Jul 2026 09:04:35 +0800
Message-ID:
 <OS3PR01MB824492E7AFD347208E0C149AAFC72@OS3PR01MB8244.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0179.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::12) To OS3PR01MB8244.jpnprd01.prod.outlook.com
 (2603:1096:604:176::5)
X-Microsoft-Original-Message-ID:
 <20260716010435.9970-1-OrangeBlack0765@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8244:EE_|OS3PR01MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 282ecab2-2e3d-4e42-d266-08dee2d6457b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8022599003|5062599005|24021099003|15080799012|8060799015|19110799012|41001999006|25010399006|23021999003|5072599009|25031999004|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WyaCegj4u81m4tM7ULBmTRDkvhF33W5zw1ZIzz2vrVT3nL2i2QDhEXH14tsV?=
 =?us-ascii?Q?97kA7rh2K8pwlExxw5dOiieu8t5b4eGmE6hXQvC6G9ou8jPQh52q+/kwfsml?=
 =?us-ascii?Q?hil4jTweAAzK9hPhaM+PqhqkZgTnRFFfEj7jjXDKrqkRTxZSLyWD7F18uTYU?=
 =?us-ascii?Q?r0/HeO0A1TGqL0SWj9xW7DJXcW1b1xEJNSNEzp5LBljtrRg6dqgLGx/QJqE+?=
 =?us-ascii?Q?8U0hg86fQsLKBbpCkrjJXAusUa0axtu/hdMJ8EFtKWzs0fPDvt4AcVH8OoE9?=
 =?us-ascii?Q?MqM04HYBhyXeZXjDkPafziHnuhvRwYHMhBsDSQoGhgmMo7lJEdgZpb35t+7g?=
 =?us-ascii?Q?sW4YGZGSeOIGIawB+xaXMBOSZCOlpxPN7zuvESgyw2V3C89Nr5L8HuHdSjaM?=
 =?us-ascii?Q?ipxTL9+/YoHZN27MY9vAAYjZeRa2vjvd14G3R9GuZ5L6Xm9QX1VIRkVdaJHZ?=
 =?us-ascii?Q?keMA3tR94N0dLM1HNXUtHabRfl4YAGLWPOuu3p1F7AEJS61j2hADuQ2k7Xkx?=
 =?us-ascii?Q?/uDOoRqlDCO5ZAh5E6AOylDjeW111YUnG45GlVTuLFNI741BHjVaYbw7usSy?=
 =?us-ascii?Q?I0Laao6aoH1+cIPBWKk1HpklusNb7tjM1NB5jOUybzLTmR/Kev3/Zx93S1bv?=
 =?us-ascii?Q?ZbqNrF27tt4Pt222NXXT1L7DrqkLGVfZwQj/KbNTWZ+Xq6HmU4ROvwRSN2Ae?=
 =?us-ascii?Q?O8WxvPb+gr8KL7sFtMz2OIIMWCaaiWx/oJ6L0BnlZ08p77E2IK7jLQ6khmf0?=
 =?us-ascii?Q?2wchbUPE5BOrtQyRNRVL2yIDmKOyvrpaaD/bUM//1n7ltAz82JIJdVobxKkc?=
 =?us-ascii?Q?r4fULJzxhOyFN4HQD+nQZMso8Ca15f4fLnMNxTV4kmBFqkNyjOrKWpdEb//d?=
 =?us-ascii?Q?769NeV1Jl14ik1rRkwfNYMTzl90P2iNL1Q5szljogY3DK1HGFisOCYTzjynR?=
 =?us-ascii?Q?2xWOyB75NDUnR2Hji0zZosgVz9vS2MOEczQokzPWU77fFgE/cI7WdYj2gmhV?=
 =?us-ascii?Q?+BqmZI0oXRjUv3MEYtMRVJDO9g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n+GBcdVndXAJ4VjwF78zHgSVD2ReEQjL6CeLnjfE3JCq/deG2L4ZMtJ6KAPE?=
 =?us-ascii?Q?pURNlcheRhDz48E09OfjCncqnTjZDoT796VWFcbG3KpwgJjtyInHo18kPc5o?=
 =?us-ascii?Q?mQlncMdnr2mm94OBGEqVa5NGnMjwmHQL+VR68rPguqGpKU7S5S8KaVb/i/iv?=
 =?us-ascii?Q?Y43eecI8Rg9DGTUpHCbcoGHhVxF43J36pCT7KrPwElOXbpyejWyZoZ6KfY2s?=
 =?us-ascii?Q?mijG6h80uwr47bNHPoEaQOEvfG/aL8QWFg3DVJNYdFaoMIshIZNzbaUMcmTP?=
 =?us-ascii?Q?kyHSLRNr9786kM7GaC86UdFSeq9zhBfOEXvQ+Dbyj6uaMHbRTLecKHrv7DrL?=
 =?us-ascii?Q?1WEj8kfFKG13oBJRT59ITIi2D8Zr19wKjon9jLNy0A5CgX9VUhXpYpi0aO6w?=
 =?us-ascii?Q?NKXTEyE4VidZ9N4eRYiCRvBeVDJiH1EEKLpS3/FUrm5N6HP6BPYUWARLqu5B?=
 =?us-ascii?Q?x7rSPu+lTKR00xL3wKoeKdu8Tmsgf+uu/+YrAI3C1v41bPyLmO1K5vMycpUJ?=
 =?us-ascii?Q?tgClZEUH3iQghzTxFtWeq+BvIgRY/78b5rRZ2Ue+J0eX8DNhKELgwxFNw64M?=
 =?us-ascii?Q?YQEb355fSqFHQJ6kATskHxqBdmrv7/869IW1TgI/Fg7Zx3HpfHvdbqE2yeEr?=
 =?us-ascii?Q?SscAzuGNViGomMToHvi+2GnL2n3iiyt0P0NAQLYzm2HeLn+4XlTeyEoS14HG?=
 =?us-ascii?Q?5Sd50dlWlQUHF1bGhyfsYFfpLq6px4s9RhdVyGgW6mvyAE/NUTnC12h6U8p8?=
 =?us-ascii?Q?Y7UCi26T5zxHLarerQqUZPdXIqg0dLiQiAe1Dhyn2XTyGibLSj2wx3GFLCON?=
 =?us-ascii?Q?Ctrq1hkGaz7u53aQSIzUtcTae+mok8eIHRH65/fon5+CPb2OgvNV8917nLaK?=
 =?us-ascii?Q?YgS1W8PBwtxye1RkAp6ovlwJtwG6vsr+8MYS143jGFenA34xD7tytpELjWRw?=
 =?us-ascii?Q?awuaLnyss0pS1MQy+pKcltQaF3gByE2d/yGAL2wm9+DvGIlTITLAYKa+m3Ps?=
 =?us-ascii?Q?F8tOqlhjV7K3eyP3MzOR1ktVFPbOYjkYOsYZE3thv/cihjDxHb+xO7ya/Dfu?=
 =?us-ascii?Q?pX5rjoi3i26sXnohrXDYW6DvDpY6IoNzw9dAnNS21d5ssTfleQWCdANZ2gCN?=
 =?us-ascii?Q?/GEgGG9uEf/EH84pT1VRRMYiOyQy4gl5FMu/jSIDKCoWyzFgk1otkEMtfAzu?=
 =?us-ascii?Q?b/HkAvQmLetEzGEoiYs7rcCZ9AFzC0s8bN9AZkpSUx+dpcM7ByLpk+9z+HHx?=
 =?us-ascii?Q?YNneY5zpxXO1JiQVgBVJ/26zlEEq7s92ZP3LcBGlqYFEDceq2bV7EJRviN4L?=
 =?us-ascii?Q?B0BDGrAf6tfSroTVliMAQ9agIKnJGiT9vxIl0LwXeZIHIy+Lq5adYCIZzRmi?=
 =?us-ascii?Q?P+t0qneepvTUVLK/ut0KHFFL6T640ZXrhgknkJQfY4PZxoX9/uusj6kXqYaY?=
 =?us-ascii?Q?Btle/nvlkVD7uo/NZJv2Hznfzy4wWY++Lx/Belbu+CQGcSVksBI/0g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282ecab2-2e3d-4e42-d266-08dee2d6457b
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8244.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 01:05:07.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9332

From: Chengrui Liu <OrangeBlack0765@outlook.com>

Replace sprintf() with sysfs_emit() for single-value sysfs show
functions, and use sysfs_emit_at() for lux_table_show() which
concatenates multiple values. This ensures buffer safety and
follows the modern kernel sysfs API.

Signed-off-by: Chengrui Liu <OrangeBlack0765@outlook.com>
---
Changes in v3:
- Use tab-only indentation for multi-line function arguments to pass checkpatch.pl

 drivers/iio/light/tsl2583.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index a0dd122af..a210d87a1 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -475,7 +475,7 @@ static ssize_t in_illuminance_input_target_show(struct device *dev,
 	int ret;
 
 	mutex_lock(&chip->als_mutex);
-	ret = sprintf(buf, "%d\n", chip->als_settings.als_cal_target);
+	ret = sysfs_emit(buf, "%d\n", chip->als_settings.als_cal_target);
 	mutex_unlock(&chip->als_mutex);
 
 	return ret;
@@ -533,10 +533,10 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
 	int offset = 0;
 
 	for (i = 0; i < ARRAY_SIZE(chip->als_settings.als_device_lux); i++) {
-		offset += sprintf(buf + offset, "%u,%u,%u,",
-				  chip->als_settings.als_device_lux[i].ratio,
-				  chip->als_settings.als_device_lux[i].ch0,
-				  chip->als_settings.als_device_lux[i].ch1);
+		offset += sysfs_emit_at(buf, offset, "%u,%u,%u,",
+					chip->als_settings.als_device_lux[i].ratio,
+					chip->als_settings.als_device_lux[i].ch0,
+					chip->als_settings.als_device_lux[i].ch1);
 		if (chip->als_settings.als_device_lux[i].ratio == 0) {
 			/*
 			 * We just printed the first "0" entry.
@@ -547,7 +547,7 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
 		}
 	}
 
-	offset += sprintf(buf + offset, "\n");
+	offset += sysfs_emit_at(buf, offset, "\n");
 
 	return offset;
 }
-- 
2.53.0

