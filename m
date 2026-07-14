Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010021.outbound.protection.outlook.com [52.103.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1484A466B65;
	Tue, 14 Jul 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036363; cv=fail; b=kQFYFjY72ONYhUqW4kD1t+3/C3cRQO+jDM/MrU9XSr8Vt9OzpY9GEzZh98luU8ejgkY5/00wfbFW4oqpRU24K9Qp/t0d38QWOHlQOHVtpxAI38RKHKmCjwWU+MchR7SfQy7Xz9pLth9bekQpmcHlknhGxZ+jAdoWlXMSqTf1lY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036363; c=relaxed/simple;
	bh=6/cAuIE+XmSzaVBvyQ9ibG6YmZPI0COqeOQfw397/Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b+fEsW/9YTykzYMkRTnfEz1L4iYnIFJNeBN2jjoDkPNvDVANXIU4ruQXexgP3qpGzBiGnD4dX2+gV4n+z6xY9i70AweWzC/x4FmtMyrQgtkL0MyqWSd3NmmiGwntegoH5Ak5UcBnRfmugGSckg1t81yg1hNGuH1CFI7GWv4sYxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NZ1XczYb; arc=fail smtp.client-ip=52.103.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NZ1XczYb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MalpIS1eLpt1Jh2jvCRoLpgM5vyp49/qC/eroY75IgycSdJtD8Y+Kn38OBuusTqdZJd8ltMH7dGXfHS1JMlobX6K7lq0xqx6KNDzfhXLYh9QLJV8rrl2MGdtL072O1lRI1XQITKyOCmedOvL5RNasTFOualPqezrfbXNAMCN9pjGMwo6Gd5NlASRr6XPSsDQMjGTWPEX6AoUCeuH8yQz3i9U59B6ZDyv6tgqvPByQIHTGwi3YCcuw2DLylqwDKwtREnlA8i5ZEIyw7sq57LfFFEGCQHV5JDIVZA8NVhlDiq7Pu8Xvl63m1SDvwh5fZK2LP+4mICva2dsOnQjlIrRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiUHPIGcVC7JUv5ZS//dDFTENAYMUyUQLPQ10TruJTw=;
 b=fwvFY0z9hTZGmHRgqiG35MwtJ0LsS5MgCV7s65ncFy01P9o48TQ/36jOdtDhHYMNiU4loITAgEtklwHAZQL9NULgX3WWpeVoYvM7MkCX9/oODuYUM8XhdK/UnJ+xUy3qZTducGQrPM8gqQ5m6QyWTCris4Rq0TxZRsgxcn3m4df4Ppb3q1m/HZFmGihZiR6rya9ffMVVNzSRULOJxclcZ9Swj5zPZeKTWZaJOYFb4ex7/4fB9MogCLiG7eEzTvOhndNvHXhfJUjfDBsvImr5sHEetHLj+jsTBRJFH4V7zOXvP6IGtvMYP/zOnDPb/jW1Qu/LJASVzW3YwhyOQpTnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiUHPIGcVC7JUv5ZS//dDFTENAYMUyUQLPQ10TruJTw=;
 b=NZ1XczYbWz6rdS8UtjgkAkRQ79W3Z75TfEe97RcFOqSpuW86a7k551nKfunJh9UMVZ1bZgcy/TxKx48ZtwvFOUsWs3MnETLjjpcgxY1dUHe/PqQNSZXi4ZlpOUXKY+AmdMsZmGS9ATX9vmA8N4UpKXZw4bPxh+3vXrqtODLg4mZ9k0ZcvEPiEJY0rmOZUpy7embenzE4KtaoB4WTiLcNUWK/xE2l68uXEL+W7eK0ZkBIYSygJ+zPKvb1snWUJa4RbI5A51fdoe6FbpOF55IzNm+pJzjo+G+rSTi83gGjrvefickwba4XsAFcxsg07BXQ0cFyR1w2lVDWm39+HeX4xA==
Received: from OSZPR01MB8235.jpnprd01.prod.outlook.com (2603:1096:604:1a6::10)
 by OS3PR01MB10298.jpnprd01.prod.outlook.com (2603:1096:604:1e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 13:39:19 +0000
Received: from OSZPR01MB8235.jpnprd01.prod.outlook.com
 ([fe80::91ec:1d9c:731c:db2f]) by OSZPR01MB8235.jpnprd01.prod.outlook.com
 ([fe80::91ec:1d9c:731c:db2f%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 13:39:19 +0000
From: OrangeBlack0765@outlook.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengrui Liu <OrangeBlack0765@outlook.com>
Subject: [PATCH v2] iio: light: tsl2583: migrate to sysfs_emit() and sysfs_emit_at()
Date: Tue, 14 Jul 2026 21:39:00 +0800
Message-ID:
 <OSZPR01MB823573E3C75B7D3813708F75AFF92@OSZPR01MB8235.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <alX5FkSyqo6taYl9@ashevche-desk.local>
References: <alX5FkSyqo6taYl9@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0054.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::18) To OSZPR01MB8235.jpnprd01.prod.outlook.com
 (2603:1096:604:1a6::10)
X-Microsoft-Original-Message-ID:
 <20260714133900.12633-1-OrangeBlack0765@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8235:EE_|OS3PR01MB10298:EE_
X-MS-Office365-Filtering-Correlation-Id: e1178869-d41c-4918-ae29-08dee1ad4e04
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|25010399006|25031999004|23021999003|5072599009|51005399006|41001999006|19110799012|8060799015|15080799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m4dFWP6JKyMbDUY99pMVJ1qKBeWYD65nvVdaZb+43hnUGseP82uVcEMhqLTO?=
 =?us-ascii?Q?DShMttLnPk9XyzudMPHJpg8j3sWS2XzjIj45KjLHcYcrCac7Kt6KbNRH+jFE?=
 =?us-ascii?Q?aeUdBOouK4sJ/Iqlhc/MAKfsUoyzLBYG3qtgXJdFA2CmNF++IAWTYk4yffkb?=
 =?us-ascii?Q?dgbRfLrIubd453Xebe4ivw4J37OSNojYGAyLN5rVkMeaNLSTuDF0yQFNy+/y?=
 =?us-ascii?Q?KJly4Go0vM0gxVbF68mw6roU/MzSCyP+X4d1zzbn64mkDQCealBbWlT3PaQM?=
 =?us-ascii?Q?BM/SbN2Nb5HiUzzlHQmccrXtPy9AxgfzUoTAPLd1hbreS+sWVId5g1+f0cLM?=
 =?us-ascii?Q?D3PP6mlRhrHkollV56kPzumXlCfK7uy/6u94HU2DUOsx9sgBDUVGjYit8GKp?=
 =?us-ascii?Q?8H/Bs6tmF4ml6QHuA7faxm5ApGLRd3QOjIb1M5swP1Sn6odYygtVUEqDvyZE?=
 =?us-ascii?Q?Kn8HY7//19at9RqejXeDVnSsl14ODjNaF1aIpXp2mcHhc7oQjNYBxAS/uj5G?=
 =?us-ascii?Q?ng2UQGJR/OFz42f8h7iYXXWTMuRNAFQntgH8yd/Vw83dBPqJ4Re+DPEyRBmP?=
 =?us-ascii?Q?mrMI2cIXPL/mGaS0jOgqoMsS8GIJYutkf3Tr+Nna9Ddna9NvaGulsyqWlAsB?=
 =?us-ascii?Q?/Z6E4nL4R155RS3Y93RM9wbPIBAvyNnLnYYdljhU/qnZEnhfdnUKzsXIq4br?=
 =?us-ascii?Q?32ohtIpeRMX87LFmryrZvaKj+vBxbd8sfhZxdavk7ljuSjwBgakTXOLNFbr1?=
 =?us-ascii?Q?ZdpItCRFzTptiqLlsXviUrl1PKmK0FKsIi5OKx2syvAMRcYls5cW/IMjhgwv?=
 =?us-ascii?Q?PaFUDd3lEj+uHCqluca4Y53Wnq9SXm4n83BOn5teRx73OGi6tyoGXaarUlPF?=
 =?us-ascii?Q?q9NI/Phco6G0awzhPsyyiDBREFiuuFOLDEV46MgoYjZGsaGQXorqATeKAbiC?=
 =?us-ascii?Q?X2ZGJyVFYxIXdwp3clBDTgbcMmr3wGrXM9gRGDV9a8GKaLpK2LzBm+Avt7+D?=
 =?us-ascii?Q?XeaSskg9K5q3RrjvnYBIgVU2I/UMQftopNSLoOUD3Q4mhcw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IkyGJiIBeQbie8DijMAwBbVoiu1bIwGp1h94slcAy663L52g4qwFhUYVVmR3?=
 =?us-ascii?Q?5S1GUccnZ53D2t3P3i9WakIj6o+F8X6U9eFFy2L+kfnqFlY/Y8jbpBxGss7j?=
 =?us-ascii?Q?XfPhY1yDkC1+Yb7IS+5LzKl/PVA+tQndbVv9ML497Znm+N5eu5n1R7+sZ4oO?=
 =?us-ascii?Q?Uf1LR6fq0dAuqw1sWBga8q8jy+VjguKv7SWE6e7aarEXSLe2/zuxv+R/PN2k?=
 =?us-ascii?Q?9fpRNjlWxbkGTmUPBBr1sv7w6gze/qoJCw1eknPqIBHGaVFDVOFLHEmV97fe?=
 =?us-ascii?Q?jbevBvhM2gwRjtJdVEeTF1ohzWoaxkZQtVqw+XmkqaEhypfrp8ku8ExAk45L?=
 =?us-ascii?Q?WjABh5oaTZqC6SSZ1XkrXdzczYZXEjPGpdkVdw+hufMzwstVXglpJm1nPM46?=
 =?us-ascii?Q?QR93AQf8B+R6zZ2Y5MV/uhZYbukcVRtA6x+sj6xYQqBUopxJdxx/SLYwpuRK?=
 =?us-ascii?Q?2V3I9k3WA0bIEhIBIerZaoVaLRbQvFoTx+3u3Ha2PmpZd/e2cWNuVrWUSQfk?=
 =?us-ascii?Q?RP14EEJf/XtavAjvTkBIchnwFStWzwB7XbrxPPqICvk82nSLaFney6WJH7un?=
 =?us-ascii?Q?8fVtfvUW41LG82mri+0h6wxLx2xZXOi8w1ERkl7dRvnQmRrQTfw6JEK3jLxH?=
 =?us-ascii?Q?J4IV7L13VKuILQwe7NKdnT72J7LoMDmSiaC4iqeyipSwyadYJGcn+a91xbjR?=
 =?us-ascii?Q?LqIjQ+zWhikCZNETQbDeO2KVxjbYI0qQ+CI/zOcpfCN17G+HYmQxtNO58+Sc?=
 =?us-ascii?Q?UEQv2hGezYM3xEyhAxT0eDjvBZTUjb69HKnr6p7HuSX+GjZ4VnOoqe2X15+V?=
 =?us-ascii?Q?qgAtoRnCKpYo+5UzOhwgsMte54dwlO5SRiM6G4Uq/Xlt86sEHpxEf7QLA5zu?=
 =?us-ascii?Q?xz5Dfvpjc7GammSLBp5hpK8oxe3ceYHbjtfGtji4DiqPW/1ScZDhMTgIp7Zz?=
 =?us-ascii?Q?kA+qDLFWpHqOpXLWYVGXCznM+PE/JtTO6Mq+htqzZUGuwEbJm9tqvNHbe7ec?=
 =?us-ascii?Q?DMW4fzYko+0/S+5xp8zSVL8BHTc+sy1Au9r98oJy/d17wtdSHMxzrajDmC6E?=
 =?us-ascii?Q?Hs3gA5z46PznLrc09jtixM0EkrdjsPrEvh+jQMzjpifSYgh4IVs+wi03K9Rb?=
 =?us-ascii?Q?L/doYtntrKzSwP0fYaBKuSVEJwq13T4vxE0DW3T6GKDykve8IZH+r+EAe4N/?=
 =?us-ascii?Q?kNEJuDjJGuHaKaAYBQi/RXjcMcO8ewTNGWu4RNrHm3smYIfaeuB28qAxMxC8?=
 =?us-ascii?Q?G0bWyKb+E9ojvX06DX15AI5lhayRbxeJDzrICt0RbBw1ZGN+eDG/LqOdbK+G?=
 =?us-ascii?Q?ScHZzP6MwhSYAkngVz9xBXn6vEsXsODj4+4K0yr9KyUXmSkq2xaKIQI8OyAV?=
 =?us-ascii?Q?cixLtJJTKoJJ3opWrepliGjIfDD8qw+2x3jJOsfqeGp2qtg9Z2riGDgfNsXr?=
 =?us-ascii?Q?+wy9jku4Qoxsprn7GufqsO9Bb/fWqdQ5GT6w198biowJv6DLOFg6Kg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1178869-d41c-4918-ae29-08dee1ad4e04
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8235.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 13:39:19.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10298

From: Chengrui Liu <OrangeBlack0765@outlook.com>

Replace sprintf() with sysfs_emit() for single-value sysfs show
functions, and use sysfs_emit_at() for lux_table_show() which
concatenates multiple values. This ensures buffer safety and
follows the modern kernel sysfs API.

Changes in v2:
- Fix indentation for multi-line function arguments (align with first param)

Signed-off-by: Chengrui Liu <OrangeBlack0765@outlook.com>
---
 drivers/iio/light/tsl2583.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index a0dd122af..db0dc2c3e 100644
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
+				  	chip->als_settings.als_device_lux[i].ratio,
+				  	chip->als_settings.als_device_lux[i].ch0,
+				  	chip->als_settings.als_device_lux[i].ch1);
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

