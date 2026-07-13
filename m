Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010005.outbound.protection.outlook.com [52.103.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80063340A46;
	Mon, 13 Jul 2026 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962530; cv=fail; b=NToenqkrxoG2keKAVZZUEJMXI4pLnUbzwO/YkkvylLBIZQZlzYE0IflwrbLBBcv3KEi19rXany6SQfaL19ceUU7hh8rMZ9TPXGoSbbEC2XmVTw74I1RVt0wlM+ofZIrkrhlA9LPH8/leoe4Tu/bhk++nFsBEfhTDPJhtALqIn6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962530; c=relaxed/simple;
	bh=gGBQI8FO7XoQCYmJR3nyERhTEMsOM9MvB+KxLun7rFg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=INPZWMDDgtkbuC7u+smkZ98BwpdlVENSYfA8qnv5QOMkPK2D+/yaMagwX0Ph1pbrwZn9fNZsUao4v0poYg0ceE4fmBVomUKV24Bd4XwGDkHcGEWEToYBzmbXnayC/eD321xXHKQCaVLtbFcUQxjQTl/w55Jtft7MtokGWJa2JzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=k0L92+gk; arc=fail smtp.client-ip=52.103.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k0L92+gk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3oEpRlcHtnabBnpv9LEcxioE9opoH7mdt5aWcZAJZxVaUsrvFE1rmG/h4BRU881tdrwzSUIrN3mrqyMHEP1DqJGuxjnnonxvTQ35ospYqL/YbDkrlqM1vYh4iEOqBlcGTXoMwOy9ymyGdLwZxMtRzusXKKQ2aBYCzcJ7B15CavnfZQW98M9/8151wH8A1ISV2+6B6OQkz2nKAf4t0z+FeYbC6b8KpXTdplNbH9JkvimmZV3WrhQE5wbMYfuGsdowbe1+AIBcnYyhN9eHGU7iOMyIMOP8Ay9esg4f01+z3Iglel+qo25XdCq55gsD8Yn3n4hBcw5HwDTYJL1rGWtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDKJjr+2GrZpHCFDiqcCMw6xTkYUDQvr4yAywVF1ecs=;
 b=GuMkeX/zOZCy0AKRmp5CpGsLXx6d7NTp7eJupHwFpnzVL26dn5vA7nKdLOJep/33yrDOiWwm9pAw7kEMqyikF+/GpjLrAW/MlFEuz8lMS2ODqkkkEzhL4NdEASM2Fdxt8nXkigtNcvGfkjQ6rZfT+qCsBc6l6X9mDSTU/asY5ye+55sSsAo1EoY9at2WQjSInvRCob/nM8U3dHRR5QCRUE467Jxe+VlQDJjRPOB3GzcMXuoe857T4WRklPpRXYEjQ1xbUCu1vB2Xm242plJmE/rL8++c18465JciZ4yphJ5xGnDFt2BmtAavCV8g096PMiG82EkU+8UwNrUZ3+mV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDKJjr+2GrZpHCFDiqcCMw6xTkYUDQvr4yAywVF1ecs=;
 b=k0L92+gk/NnOSnKKfKCa2i2vhkwnG8FEZtitv+AIrW4fLDJ91EAWqn4VQex+KsroBs5FvyNlqL2B2wYCHJjOwUdjezxNnagtj2Uzv0/BgzvoYCht6NOG91vZgnhA22boTaqnAILSK5LlD4Cn24A9nEyuGfxZczkDg3xgNKcooY9hibwekgC35F9vPPeps4LUifj3wzbViCmFOem0cNZYBaiYtPNvrrvN9srmmj1xHamuM5l2UANonlIvwoYXaBnRB/z3E+TTh9Qy0VW4bAH1nxAZkXaqscBW635IzRTpU0HilXVnZKB/JQLW4vnEx5yLD/qLJ2SXsL7n3gi+UYCdMA==
Received: from OS3PR01MB8244.jpnprd01.prod.outlook.com (2603:1096:604:176::5)
 by TYYPR01MB12563.jpnprd01.prod.outlook.com (2603:1096:405:195::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 13 Jul
 2026 17:08:46 +0000
Received: from OS3PR01MB8244.jpnprd01.prod.outlook.com
 ([fe80::cfbb:cf9d:dd51:7971]) by OS3PR01MB8244.jpnprd01.prod.outlook.com
 ([fe80::cfbb:cf9d:dd51:7971%5]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 17:08:46 +0000
From: OrangeBlack0765@outlook.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengrui Liu <OrangeBlack0765@outlook.com>
Subject: [PATCH] iio: light: tsl2583: migrate to sysfs_emit() and sysfs_emit_at()
Date: Tue, 14 Jul 2026 01:08:33 +0800
Message-ID:
 <OS3PR01MB82448EEC71E6AD3236F39E3FAFFA2@OS3PR01MB8244.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To OS3PR01MB8244.jpnprd01.prod.outlook.com
 (2603:1096:604:176::5)
X-Microsoft-Original-Message-ID:
 <20260713170834.73259-1-OrangeBlack0765@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8244:EE_|TYYPR01MB12563:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb2c23d-cf4b-42a0-fe34-08dee1016620
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|4140399003|5072599009|25010399006|23021999003|22141099003|25031999004|15080799012|39105399006|8060799015|19110799012|5062599005|24021099003|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqhCLaE4rpYm9YmszC6mSiAYugGkG03X8MPudSohXFtiF33ssq3Bvq4/GMRq?=
 =?us-ascii?Q?WoYEAfedPu0YiSxcYlGWEqhKhIhMkUnbx9EbStw83/Ijg7IbHgZU/O13smR7?=
 =?us-ascii?Q?f1S6Lhd1bYZCpG/5PJiIIjb1kzDchZaFi82gzXS4OUEDYQEWceaR7yPrvu0d?=
 =?us-ascii?Q?ViC/oQ0I77kc3ls8F2cpPcF0glVLyiPaPvKCH2XLJu5W8znlmtGNywD5e79W?=
 =?us-ascii?Q?dRd0p95wy0ia91mi+/YpX6wFP/aGqfpSdJVEQPsNmLJAwgJlUNmtfVQ4fU+J?=
 =?us-ascii?Q?dU3YTYf+P/kVWdGF2ipaG2URLZqcjEhOWNQII4Egmx2GvkXt8klctmTLM5ck?=
 =?us-ascii?Q?ngXGZRSz5/ZqrkAegZEmLElk7rKcfzKYkvgRt+4PK9CPscezIYOqugkAlGRh?=
 =?us-ascii?Q?YxoWAkmdbjBh+Djzi6iI6uIDAxyVKdVq5/QY+erzrqmK73LN5GXf3RnWjzRt?=
 =?us-ascii?Q?Fy19Hv2uknmqwwZQxv1g87J2HCXG5bPrWX0aD54ejf/hvFDkUX4Yh1VdtF4o?=
 =?us-ascii?Q?eEjw23Ddw+VJ9repynp4EByqJ3aEl0lRNVsfA6Pw2a+H5b5QD1HTV4oRhPZ6?=
 =?us-ascii?Q?mDqIZFXffvCwt3gxDKen9GHDkaDGjwkPqrA6EGZhYi283IfhhI532brK7gpK?=
 =?us-ascii?Q?IO6mOuT44CRkw1H4V3Ayg7L0a5ZEyR7cyIMUbLcCCqeFAkayktvkTI19xYaX?=
 =?us-ascii?Q?wGe6aL5PBj5wtQbsFyI9fWL9ATAq6cbQEAzWnd0eMF/0dmmOMt3L1WOWuLrD?=
 =?us-ascii?Q?0TD0THqzfXq1GlS7c/MSyY3LPq30sPVXB3RppmwPBb60YSoWxLSgpEkWaMpi?=
 =?us-ascii?Q?t6c4BdZ2Bz7K7qDgYcsm/HetmdtdwgIp4bnYXecG8ecS3RJ+Zy78qh/Au5J5?=
 =?us-ascii?Q?V8meE3I86Io+w9jUfXYmc/6sdSsfn8UeTyWXQXzt6bZ/sbxkDOFZUNWnIumM?=
 =?us-ascii?Q?ZuIf86tXWmPd0vViMwZ2Lnx5tr5nAazvBpVATZV925xc3qwUC0JX/kYMksZv?=
 =?us-ascii?Q?yHzo50ueqm7fZExWQXt7D7F+kW4UxXThlhlAygR5Y3aCFP/NmdABSKtE6pJ3?=
 =?us-ascii?Q?xoiGm1pWyXaEiCf7OE48q0u7r6DtKw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DmyP75HZm3tiqP34Vorw0aJFOKQNR2Fkycx5WYfuTZSiItBzZ2LnVUjgFZKY?=
 =?us-ascii?Q?WRlBJ6tYNeZDyj/54cZUzPfHoGpsnzCxMtIQb+mTb4i9NWhEEncXaG7auvmU?=
 =?us-ascii?Q?FokGBAkz8XhE8B2F/YoyOwnSB1BrE6XDbAcs++JqiyOj6UiciUsTJeFngcUn?=
 =?us-ascii?Q?DFWEI4/ATy+y1kGdisVpscmcQozlOj5P6Wo2HwXfDNL2NnRRM3aqkfbmqvMF?=
 =?us-ascii?Q?2yIk2JVwQ5tL3SXESjnPrCVsOEs9HLpHrl2D4COue+iW9dOqaHR4SrzqQfn3?=
 =?us-ascii?Q?YtE20So49LbzhRCngLkpYwZUrHbT6WIS46Ui+8Lonjx5LpVNPmU/AP5ATLUf?=
 =?us-ascii?Q?GELBmcmTx2HoHBADi15ISG3V/nkChx/BtQQFM6birX1Td1CbEsXC31c23sMU?=
 =?us-ascii?Q?5tn1AfnlAJeBr5byRTMnhOm9K/KhUufQRwCtYEofjeRbvnCGrpC94HG/I4LP?=
 =?us-ascii?Q?ncgD9tXrIz8YlrbykwAm86NCWgIUowFH4vNfSiQ4LMzfnkmY1UqQhksGv4TN?=
 =?us-ascii?Q?geNOT5upQdCOO6gUNmU9eVtFnlEMKoKNMwfmCTGNlQVTSIrNw8D2YWGBfdx1?=
 =?us-ascii?Q?SlbjI0VkJMWR0W25kwHOru8iT3AyJFJRF73H+AFNGSBvT9pU0QEXaMveg1oZ?=
 =?us-ascii?Q?ton6w1+5r5lBRux/fZYOdU31g6pr7mvhj8nbyCB/LJ/c8WzNSwB1poqISaXK?=
 =?us-ascii?Q?xzSOH02tzGWLuAc8WlSpiFAmgSoef+PxkB9ogz2zDqT47CX4vGTXdf2fAgwk?=
 =?us-ascii?Q?tXx3sIUXOW+mg2mSUitPiLUcPUCcUgFcimUEV5yd5iWS/NGD6NtFLS82/LCK?=
 =?us-ascii?Q?3Va9gnOPnDsdlzgk14qudbhUG4FKGiyuQdboYrne13NIzPvJ/vuv6UOVJkP8?=
 =?us-ascii?Q?sTqkxoc9cT05f8Dw6FQqlo/Sw39ne4S/b5dvLy9oR1njgk02y0qy7xj3wZVS?=
 =?us-ascii?Q?oDzrvGHr+F/vKJ5LVh4Rp1+NwjZsHGFL5y7BCfx3RUiV0KqT6Bie7sroHNcf?=
 =?us-ascii?Q?x5x5naXOyds07bIL5NH0Q1nYhgvbOL5se9/RzR5MFe1uZFQrl/g2qc8CLQTD?=
 =?us-ascii?Q?Z/kC/75+ROJeXZydADN/xb8Gl1cZ6Zs6twaFZJwXPgUkDwHd++I0ChZwt2T/?=
 =?us-ascii?Q?d+yoOgXmraSuIl39xDuGYv4Pr9hCokTwBE5uwFJEZv9xbIG1zB4zwN9tGfI0?=
 =?us-ascii?Q?YPrbCyeVv9o18G9Ddrpn8EACwEiRsJYLcaXoC+UofSeDDKvP8MEFRh4b7s6N?=
 =?us-ascii?Q?aQP2C+6005dnPpNrubZGJpwFLyTAN2KTuIrACSP6wYoaYZUFae4Rp46LbAuo?=
 =?us-ascii?Q?VW3vQJB82+oC72q9s4LX650y+nLCrqojbvLBE0SRaTwxJj6Zn66+T+2g1BQ4?=
 =?us-ascii?Q?0epyuBkKzWiGg36kBpnqYwxp7hG0+iHhvgEFBCmS+BVfYjvDgxR4tBC7H5XW?=
 =?us-ascii?Q?vOPKrPRzEslrPzJQRJwXPg2HsP5Vz0RrGfp0QFvfKv/wIyabeuT09A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb2c23d-cf4b-42a0-fe34-08dee1016620
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8244.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:08:46.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12563

From: Chengrui Liu <OrangeBlack0765@outlook.com>

Replace sprintf() with sysfs_emit() for single-value sysfs show
functions, and use sysfs_emit_at() for lux_table_show() which
concatenates multiple values. This ensures buffer safety and
follows the modern kernel sysfs API.

Signed-off-by: Chengrui Liu <OrangeBlack0765@outlook.com>
---
 drivers/iio/light/tsl2583.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index a0dd122af..9ec2747e5 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -475,7 +475,7 @@ static ssize_t in_illuminance_input_target_show(struct device *dev,
 	int ret;
 
 	mutex_lock(&chip->als_mutex);
-	ret = sprintf(buf, "%d\n", chip->als_settings.als_cal_target);
+	ret = sysfs_emit(buf, "%d\n", chip->als_settings.als_cal_target);
 	mutex_unlock(&chip->als_mutex);
 
 	return ret;
@@ -533,7 +533,7 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
 	int offset = 0;
 
 	for (i = 0; i < ARRAY_SIZE(chip->als_settings.als_device_lux); i++) {
-		offset += sprintf(buf + offset, "%u,%u,%u,",
+		offset += sysfs_emit_at(buf, offset, "%u,%u,%u,",
 				  chip->als_settings.als_device_lux[i].ratio,
 				  chip->als_settings.als_device_lux[i].ch0,
 				  chip->als_settings.als_device_lux[i].ch1);
@@ -547,7 +547,7 @@ static ssize_t in_illuminance_lux_table_show(struct device *dev,
 		}
 	}
 
-	offset += sprintf(buf + offset, "\n");
+	offset += sysfs_emit_at(buf, offset, "\n");
 
 	return offset;
 }
-- 
2.53.0

