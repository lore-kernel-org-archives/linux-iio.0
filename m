Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022124.outbound.protection.outlook.com [52.101.126.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065D4217F33;
	Mon, 23 Mar 2026 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774229703; cv=fail; b=sdM36Q6+5zNfMhIjxEOwe8zbcwgBy6nZLk80cfKMXMe+TvgxKxe5limYY00W2PJ41EsulQxCiB/y/Z4v4XjhH3GdmD1e7bjd4IjriYGRnIXUqdita2EHPlOZdzxwbpB2/5OqAvAt6T5o1oTI4ZntuxwBDxTZEhDcWZkBLimi2LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774229703; c=relaxed/simple;
	bh=kPM7Q2UJajVSEMOntyzHuK9NStgHAj4T60wIkAhburs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q8xetsfgqreXvyO+TUWe9GKjVpPsWxS4qhP7QzW/yj3oiPcDms96LTicP4HyUB1EjOh2NRmFNs1cdaPuDxMkGORYPccY2EJTu4NMwDyewTKoUxy4z4y2EsWLZvb0m5NbG9B9rtT2smE9ncKw/FikKO0evdd89n7ypx2tsFS8ae4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=52.101.126.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngcRUOdUgowqcftQzZNTQG8aQd0D8VRioR+Hp0aCWojCO91UZU7JmenmpSGZCcI752NhkoETZ+UtL9RlX72QNMlZ5Zalb8u1v1OwB62AA2A8f6JXp8xhRkHhwhmL/vasQEpseDRZPUQcf/UruT8/tdxqF/qbAEfsYDrV4tLfsGPMaBe/UNB332MFv9jsXLg4cuekziDq/uugkBcsxy/+nalLd3liNucCi40y61eQvCUoaF2cq0OI+APNivq5hYEqSzfLyuVIQwXokqvQhjTtYv1caHnfyCWfKhf59S4iZnUA5npDNDG2IhPSUk1Xlh3PfD/5MCSiDUy2J82G3yixsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhqqYGLL8pIaTxzVn0mR11Hl+lZdSTt0w8pBNzdgUWw=;
 b=LmOb0KuqHSf7g8z46CeV1lgWODlXhDUVr0TZWNHeQqyTxo89hx2eJ3+jjoCkbJMQWwdQUQJ+VibBBaGgZ11CgyKlmRqM4J4GSrJKK59aYnBoyPYfWTHBkm8UBUKlp+lcczt2I1OarVDg1HSxogu36bfi4XXXf3s3tWLvCM6X6uThTvhfd0Fwkit79aRFVo6bXJyfic20JCZ5YjHT5YYF67VaL6CDvuo2+dNkz0gngI7O8f35E3lq92WGbcVKakdk1Kr2RFFNiNtkzFVJgBnMoJTR8dkJosDCZlYCUE+ObXb7j4fwyDk2R0auB70xuMeJY25Izfp8wgJb5WJ33Za+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by KL1PR03MB8142.apcprd03.prod.outlook.com (2603:1096:820:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.30; Mon, 23 Mar
 2026 01:35:00 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 01:35:00 +0000
From: Nick Xie <nick@khadas.com>
To: neil.armstrong@linaro.org,
	khilman@baylibre.com,
	martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nick Xie <nick@khadas.com>
Subject: [PATCH v2 2/4] iio: adc: meson-saradc: add support for Meson S4
Date: Mon, 23 Mar 2026 09:34:06 +0800
Message-Id: <20260323013408.429701-3-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323013408.429701-1-nick@khadas.com>
References: <20260323013408.429701-1-nick@khadas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|KL1PR03MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: a9aa056a-0a7d-4026-b491-08de887c65f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/bHAMeqw44ZoYimK+zvMFF5M5i00g1rlwHkLvvqJPJxIXErqGBm7LS39C/Fq9qfB9um7kPWM6EjN3jWDqvHEUbJwjBR47lKsOhZBqimvFNkst/Iu5dC4At1DgQFOZs9xtW/7A/pST0NLugg54SN4YfOqmEejpgKOSpQmlWSiyPWnHy2B1bdYQJPGk0IFkHhPINwU5mn/nUefb9QfBtA/W60MDdBbN51OfXmL+WmOfl0+pRf/g5jqMA7lhyWTZ59T3frqp3qLp60m28AH9JQ0fA2R3+S/eoX7//pNws2xk7AEYW79d95Z6oljr4RFq8OpLq2FOLqtCHQyCw/B3HU6RM8JPjn6jpdRecImBPcsYPMQTxUKZCGMAjbK1lWB33hrfV0ecedWPpIPbigig2QsgBr/v2pcCGBy3klxwwgmJ44Tlkj/URj7eo7D/vHsaz8rCKg3WiUKrZS1fqnWQ9PFo9kQTBDavG/Uwj90Nyfs91u7jxkYYZvCPctZAWedoPpe+uPfJ/6q0U0pzAhdztfY4WyXazggXHfw/k5d33+iESBNxQmkennRAJkCFX8Uf9aGzwfTrf3rqENp0TecuUHUlPs8p2Boi6sVB19IrrzoqAE1RI/oFzdPDDN4OT1MGEPsQWmffNYAeb2fvq6tZWZGGbDDeJ1ESNDmyYExAK0mM1otLv78mKdU0emXpD2pVN1yAuxYodj4onFOEvgbFbkSeqW7k3cMZ6hmvOjwygcaM+Niot9SruHd7MpUsoJOqOdRqOCw09bJynbQjampqIkfAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d1sp+9p5RJbJWTSknAyYC07fwM5juM92nXXNXdnFtI0k2dLV+dyqenzizqlQ?=
 =?us-ascii?Q?2ewCEyFvK1wTRSCFm8jCHek2bYiSA1EWftdF8XAljEiiRp5CWitD9UOXFe3r?=
 =?us-ascii?Q?fusMbxLlPeaNvy+TuiwJO0EoNCML+OaHBUG86OOrNwOHtdSqG3lYAooSLVYo?=
 =?us-ascii?Q?iQiaPdfNvof7KjEr8lNfVmbkQs80CIoQ495Hu+68UwIJL/orKoRFDjgHRW1l?=
 =?us-ascii?Q?paJlZJ4dvOgIYpa/aN0GzdD5LPPrKLuhYeGjBeOaB2GejiQQNp2urEmuonpo?=
 =?us-ascii?Q?3t/8aGkkS7FvIZuj8eJD6JLkPVZ2D5mjQUMPqndZPE/UI7FOrKqj5daGwJLc?=
 =?us-ascii?Q?qBfTeM3brTGnqOhmxJRZuk8D9uGVNwPZoMOlTSg9R58IoZoNxdEejawOS6uy?=
 =?us-ascii?Q?yV7S/QguMaltg8i2LWjzilJnsalPCBptB1c0bgA2vPJBTQY4CN/+4qQHeTOa?=
 =?us-ascii?Q?U4EaWDEOSnPTYav6xqjr10n1yXPmwTzbo8NKnDv6k7OQp6A0lE1f1PfQJFBk?=
 =?us-ascii?Q?8iZfgR/GBzoWMO+9gD3lwFOdYSAO9u2Ae4qpcV0dPQ3mJV0C9m76r/wbF0Lg?=
 =?us-ascii?Q?D445/JQ/JxlNpoTurAS93BeL1NcSFY8uJVIcPl2T34qOzEYxZDnvtjAUMwBZ?=
 =?us-ascii?Q?+qsimIXWNVcXL0idoqpbLDawKaiIU78et/f6ILY5idUM6cXllNl0xmvJbErF?=
 =?us-ascii?Q?czepxBrX+osss0/bGR9ogFpK67y/hvwUoB8ZWY6koME6PySUPR2lqNSyat6a?=
 =?us-ascii?Q?GPZev39yYAAahutiyna/djz3aykyP8k3wc40mgTjAhUJIL6bVtDunUOsJZBn?=
 =?us-ascii?Q?bQLc/dfXjkvWlKgJYXN2W9wkRMd9RC4Th52yQv0P6GgXcYfkS0crzHssmnEe?=
 =?us-ascii?Q?EgnAbu43UTm4NWtAR3y5t54McVzLfgNmWUnIGoBKDyDUOJnyaHZeyQsF1PE+?=
 =?us-ascii?Q?4C4v1HySJfqu+xkoZTfMc8p4yiK1MH27HTrhHSpnXHoUSAbCWRxP0+2glT+q?=
 =?us-ascii?Q?fScEqwVpwO27ZkCXrhX4P7aWA2nY7Xw9u18GIYcOOJ+n96BRzTYJL1cEm019?=
 =?us-ascii?Q?D21P3LtfS1lGh4nnrCkvZjw7XqopcRExCfYInm7bP0hgOdBp3c7LczD3x/8m?=
 =?us-ascii?Q?788xWSu31TkoXhdVo1KxYdiHd62mQWaD4wAlWozYH6YRY2C//rI1xktVmD7E?=
 =?us-ascii?Q?CiafLf16Jw4avy1VgMl51xi8Eu2VE9fnMmFUIXjl9qOPuac2hVANjUxO4kJG?=
 =?us-ascii?Q?sShwoTT+ey/WPNKFWstP5luWPZQvJjKNYKmPoqmYChZ0K2CAkkITaMexBqib?=
 =?us-ascii?Q?1dcrXwcmlj1z2VLAUZtg5W0qbaXytKpt9PpMRCrNsWLYsSL5mZopI5RBWsEB?=
 =?us-ascii?Q?Wf9Wnb7V+nwr27Uq+mtSxU9D2LM9E7xURrK3etU/C4uhFJICtqCeUtVA/clb?=
 =?us-ascii?Q?OvzqAkCk7UnkAqnhYARwBfCvSiup54hKBL8gxScEGTjcLbP94xKsV2kcefSY?=
 =?us-ascii?Q?ARtm9eIsNRyegwgEohBaDYj86dxCuri/TgNWnhRBO7VzAxd/WTEsroQVFOIF?=
 =?us-ascii?Q?IpK9TfUBuWukEoeMKe7AoLO1clkjr3mEHvZFIApx7WxQ1mHPAggZvshkBBUT?=
 =?us-ascii?Q?Ycchshe91LUuotHZyTINhuu/hEzVMNsy9G6MQHvDlTeTa0WxBNfVZDePv9fc?=
 =?us-ascii?Q?LSmTogbSGGsZ1+4mtGVmz/FGFKFxtq/9s12o2Q2BQoR20gGY?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9aa056a-0a7d-4026-b491-08de887c65f9
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 01:35:00.3339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9p7oqSMQXGtHPe08uML23VKHCS4B90zzZeCHsCnkXd1VtfMkqatVN4tBQG6qlux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8142

Add support for the SARADC found on the Amlogic Meson S4 SoC.
According to the documentation and current testing, it is fully
compatible with the G12A parameter set, so we reuse
`meson_sar_adc_g12a_data` for this new compatible string.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Nick Xie <nick@khadas.com>
---
 drivers/iio/adc/meson_saradc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 47cd350498a0d..3ac48b7842c4f 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1313,6 +1313,11 @@ static const struct meson_sar_adc_data meson_sar_adc_g12a_data = {
 	.name = "meson-g12a-saradc",
 };
 
+static const struct meson_sar_adc_data meson_sar_adc_s4_data = {
+	.param = &meson_sar_adc_g12a_param,
+	.name = "meson-s4-saradc",
+};
+
 static const struct of_device_id meson_sar_adc_of_match[] = {
 	{
 		.compatible = "amlogic,meson8-saradc",
@@ -1341,6 +1346,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
 	}, {
 		.compatible = "amlogic,meson-g12a-saradc",
 		.data = &meson_sar_adc_g12a_data,
+	}, {
+		.compatible = "amlogic,meson-s4-saradc",
+		.data = &meson_sar_adc_s4_data,
 	},
 	{ }
 };
-- 
2.34.1

