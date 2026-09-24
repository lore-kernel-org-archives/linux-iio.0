Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010054.outbound.protection.outlook.com [52.101.69.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC3349CD6;
	Thu, 24 Sep 2026 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239082; cv=fail; b=KJ8ByCOTq5/rQAeRNf32SsmW/B9d4YNjCC46r7dtUlc6k3ZJpAcvg8TyThqKxPDoLpkkMxQ9Rp/rwMJGPzaTIGQR+zlOgrtGBjosRUr9NSHomfWQ/fknkUrZixecjxuv1cgPmkj7OAxmUk0VRj3wVtr9eM8SSZyQwseaBvq+l+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239082; c=relaxed/simple;
	bh=e/5whYIRersyeGER04RPF5ocOWrsLrcMrWOgREwjNCk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AmRWPZE0FogYwPVxv6qLXsLkA09tMKcQM1iVG+O7j7rhj9DajfKmlaW8CkQongoerANTEw32CQXFYdMyGMnvF28uMTv0Bl0EuAVVQvl05a3DXNdSQ/64OO/UafiSOUeK7k4BrRl4KPJK/FPvD7jFGkdHd9CTyBaQzQp4sPJv/T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pcJMuAJ0; arc=fail smtp.client-ip=52.101.69.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pcJMuAJ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTcTFFB513T+kKmzSVN/jYg0a8avcJVbNvJgjimHLTrf79nrzcFFivkHzyyRCej4Xuhp66otr2B8vu6BNs1WZsbj8lfzAxl1Q4zmI1sA/htrqcPKspLk5aXlufJPY0fWhJieN/nSBbnfawWNLoe2DU+lcdJlC4gAVp2dkuH9oPPDG2QuuF9QByDFDbLY2U/WFVvimFlrMPmp9ZCdGvsQAAW/jIQqFcD0nsXv/3IUO5wl7DmnaqyiUnxGAQHfUAxYwXUyreTboALxgcBtWrM6+1vZPKhQIrPfpUFzD9dGh4D46ru0BgaAVJjLwvMI5F9WNhq+NcuDZfxupg6hrxmSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k+67wjzDnUNsW2+YAmpq571O1G/L6PJnN/01ZGUDwA=;
 b=cHuxgnstI3sRUmqus7R6KcHCRJ/auNoIxIcdZzAC8A3Xc+T39B0ES5z4IZQADgoADtHP2kSaS313sBkSvzboQqUAkNSsuIYcgbGSpym2IpdS1IMOmCCaevzV5QlrqZLyCN3EZkhDBvs1IpZJ1FrdZCnKUoPMqqK54uNx/QeSKBqeWVSAVD4gCfDTG0ZO/WSkbd8xINBD6CpGzwYreOIlRPxVnzhQVYrkAh+91tzsI9rYcXrJhcQO418/TgZHPiRzhEhJNLZsJzR0O3LsDfqj7exYl/wFHa1sSexdba4mvlZfWxwXuZRG93yduzBzpwarnB+fLbPCiXHtQKfjM6X6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k+67wjzDnUNsW2+YAmpq571O1G/L6PJnN/01ZGUDwA=;
 b=pcJMuAJ0HohggFhOG2fQjEwTKxpcRSuKHFKWLLTsttZf5tNzMWiXejctfJTCVaw1yQNTLdLWttZ1HoE8OjMnSlij3LT2TrhVezWTLhVYNTdsnhn35nkcOMJbaAlUSreCl8kssC6MCoyDgJ9mKwjYLwUgonq1O8dLgZjGmab/aoi9PK8XeyEIwSKx1PUsFbjpTWYKXClQM8i3wMEbzTvZvWRoV9bmr8JSj066AkHtGvATQquIzt1zcJyftIbWUMMgI1g2q4HzLi7xeqMOyRYohgNfimxYNqeE1whtZbzaqsPSU0t+8L7ZAAC87K6sQI7Ft3FkCyj9bQQhjZZobf9MWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB9937.eurprd04.prod.outlook.com (2603:10a6:10:4ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:37:56 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:37:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Gustavo Silva <gustavograzs@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: chemical: ens160: use regmap_assign_bits() for conditional set/clear
Date: Thu, 24 Sep 2026 16:35:26 +0800
Message-ID: <20260924083527.461864-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0119.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::16) To DBBPR04MB7883.eurprd04.prod.outlook.com
 (2603:10a6:10:1e9::23)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: 203a3b52-fe87-4db5-a4b6-08df1a1721a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|19092799006|10067099003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	S4Du3ucptUxg9gnC0awVc1gBjxd7BIzSYp628WrlZBoX+UZrwvncpOL/EY7ieOXXtHVmYdchbCcNCX275K5KG83H6HstBDWGZ9RB8DdFxO5JoGgcqkEMJslpQgE7sXaHa1PrJCdC0Mtn/RUZdtAy/Qb0OEcEqL60X755oU1AA/Or7u94sVKvlQvgea6USfuil4hChBW4Taie6AVRnVTdl/5N+hCctJ9USTZ9xl6yD6OanyzL8+qQyLw13qRpRGpHEa9r1+2WS5rkGiUtPr1/GaFcQ14w96AsFERZ576UkYJSZzVXDgWe6AFM2SVQgRPIrIv3x3sx/iBCjqZoIWrIiF6VB/IjfnCnuMTAVl8yaZ5oHjWxLUDzkWVLyk4S8JMkZa83iE5N4qs9sKt9MUmvbYjawOFcaoAl+Ke48FkGtFL8xVQYKNh+urLNiJXtYAGgxjdSGhvYaFp/AqgU+9gbAnSxyD0jpOEyzs0xNjywdnKqE687lInGHs81WHCvGBPAGOjAZTjzjF3Or5ne/GhRCKO/eou3jhSGwrh06HCMyO0A8GA4TQtfAvXgvYyXm541b+eg2/YeEgcUhvfxUMv48pjZ1OeoYuOkLCEiczIbeNl2B387iQsCddDL+IiJzCjlnZLb79zDy0p8BAh0F8Yt+wDK/SPWtxfKBwHf0LszRG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(19092799006)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XxNxR+xIrNPnTULIVTTS4WDQwOcC0Z1s+HIkAB99HZx4jqDDmsHc8DkveEd3?=
 =?us-ascii?Q?mi3ILw8O2sDOXtUyz0TVdIJNMCrKWDKdRn/0NnrxGYbBeIjTAk3gSbo7akLC?=
 =?us-ascii?Q?ZazXCVQNFkbyHwbWpkHjDngaOOwrYu90EU+tLxKhI3ohdgVPeO2VeHNzVykL?=
 =?us-ascii?Q?vgXGHV712uTAhV6xCh8vifTiakM4E07nDzm5R7wMPtbOAAsZ1PGaw8o8z1OW?=
 =?us-ascii?Q?wJbzTopm0kVgqLvvog4oLsXifiyQt+agFudCD3iSgKT/IKqSacrAS4TfUXur?=
 =?us-ascii?Q?UJ03f0veIfOvv7kCAaZCXSFVzQTTMRXEhAGgul1Ly0ThcVqMEhaoIYgOsF8k?=
 =?us-ascii?Q?iD8soxQt1vmSKhkUZNmHuyK34zYID8dyAcbWuiMWQrlcqnJ455xB/ls9qCgk?=
 =?us-ascii?Q?+OyXa2CmryW/nVmcRbUMTIt3YMAyr0tWlEELZB/PhZ/rA8hWE5Ojb+gJoHdi?=
 =?us-ascii?Q?KHilP2Wllyz0S3PWNNuTu6vl7GPuu1yK42kVAAmw/DBwqnB4aNX+OQzfDGB5?=
 =?us-ascii?Q?ULKWiMnidfDyaAfvlGKsPae5j4HpN2jjMQtLh1pbIcdTgR73tWUkme3CxfcR?=
 =?us-ascii?Q?/WSGNCeW+j8U1PTtkTSNfnnjcWg9/yT9blUforBIqF4o1zKN0cM2MDEZZoXA?=
 =?us-ascii?Q?13nCSnIpdgkQzBKWifFdZEOzXdrjk0j3wyZyE+wSFvqDzYKgLxuDtrVUgZ2f?=
 =?us-ascii?Q?/PBjBx6MUvbndYUP8NqqmmesNIgNJ2NzIFgFtRqn2isV+CQaF+xWt2KdP2DK?=
 =?us-ascii?Q?hWE5dWw8x2Z7dpcGxHgpC6ytZ4cUTUsGF8NPRzIdXjfa7OHp0k8KOJ9p28Lq?=
 =?us-ascii?Q?YOekSqQql8BqSYc9wF4fAyGJAmsnTnJ+RgG1fcuhigGJh8BCHXDMUkIs0a3V?=
 =?us-ascii?Q?k+yMP9DHYFxjD9UTkqeB+K/aCc1ce0IKIeRdLYQOJlSi1JSKKx9Y9UjUMr/9?=
 =?us-ascii?Q?PHeU161r06q+OCKEVXbBzmRB+0HTD3qInSbn/yuDf2c5wWkZTXeX6roU5zAu?=
 =?us-ascii?Q?cjeMnFzWl7QY8r8ae8RrqMnbeGq11ysiBhKjbOujH6/K/HeAg+ZCMcq+aXRJ?=
 =?us-ascii?Q?zKdjBToEZTVUzlMIjeiKyamxS2zi/XucALWPWX8woNhggVIyI2xjo/HJSJvF?=
 =?us-ascii?Q?Ftl/AAEiDHhE4jzH3xXbSx0IElGHIxEQ/By+c94q0ZKw47YX7AI2SQbIoQZQ?=
 =?us-ascii?Q?+TtvZuo0Uib+VzNPWC6FVuqkn8T1NUX5Kw4YI7qUb4gkoeJGXZqsxlhIYb4O?=
 =?us-ascii?Q?+QGkkLTxgaHPzTc9TQJUWGe89XkM3ycxajDpDVb7G2rK7tgjmBc6NlOajKey?=
 =?us-ascii?Q?y7vTiYOKFNmrpUreM3AYgV28vpMCJ+z6LV5GjxiH3o7fDbwbpogrFQl9/zL9?=
 =?us-ascii?Q?DkrcQi6I8UQFiMDod7wT/q0MWzZTpeVuYm55IVRbtUPr1nu/+HQG/ycV0Am+?=
 =?us-ascii?Q?RpGBwzGus5h5tmTMecQk3mQGwIhQC1vjpb+aNFmCWT2stga3plLzlrk2KSYt?=
 =?us-ascii?Q?c0ki7HVIfSGzl8mXtF5ojXC1HbRYAc136bJnOdDnECg39xwbPuqAzHDtb+ed?=
 =?us-ascii?Q?jb0ek8wIBV1w9YXxEh4j/JDi0vnMXRpmzeFXxbWhxPNrfsM04qsIelIBCbSN?=
 =?us-ascii?Q?irp+fBnVTR8IdXHvdXQj1JBJe64rAM1Yql4kAO+xHt/anbWOqS8CnzLCy7b3?=
 =?us-ascii?Q?ATSCUFHE1SztBEdjyaqiVSu6yx4IRc1kuNxYbVw5AGFwmGhNsV6v+LWZE6uf?=
 =?us-ascii?Q?3aPFK275N4bi/fRp1DuM/bYONayKJE0nvNaa46AAWvODtNckFpNo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203a3b52-fe87-4db5-a4b6-08df1a1721a3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7883.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:37:56.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GccRB3J3Oiyejkion4Esf2ErEnS3La0CQoUkI8ca4Z0bZom1HPpzhlVDRsT89GRF5vGRrVZDAeM0j+FG6hAwy+208bpZKKYZMWkjt4ykeHLB/KrwDNRfTK7un1bupsQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9937

From: Peng Fan <peng.fan@nxp.com>

Replace if/else block using regmap_set_bits()/regmap_clear_bits() with
the simpler regmap_assign_bits() call.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iio/chemical/ens160_core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
index 7c1ffda38b99c..5e2b15463c99e 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -283,12 +283,7 @@ static int ens160_set_trigger_state(struct iio_trigger *trig, bool state)
 				ENS160_REG_CONFIG_INTDAT |
 				ENS160_REG_CONFIG_INT_CFG;
 
-	if (state)
-		return regmap_set_bits(data->regmap, ENS160_REG_CONFIG,
-				       int_bits);
-	else
-		return regmap_clear_bits(data->regmap, ENS160_REG_CONFIG,
-					 int_bits);
+	return regmap_assign_bits(data->regmap, ENS160_REG_CONFIG, int_bits, state);
 }
 
 static const struct iio_trigger_ops ens160_trigger_ops = {
-- 
2.50.1

