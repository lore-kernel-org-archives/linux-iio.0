Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.88
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837466;
	b=GNYir+16D8kjczgGHUUJBK1Qyad0vGp5vemECWM4sA6JALS/HNz3iBcrn1TsnGgcmZh7
	 XeDqKNULGAHedY2ipDylSC1M+Xx72/xjgiHdx5EH+57k3QPtPGVRCLCJo26bwupCvLRUm
	 LMzUPWbr7f0SnGR4kT7R63SAinDygKbUPZeYtGy4K1Im2qAmcNOH73yfqWQhIOFvXNNuS
	 OO3mVtKAHGLH2vWkAisHKCBOfXD9XvMkYVCbn7abN3ciMXHRYlmyV37/cAiKTcokVqeYg
	 w8HzGOmIY/Gu1nNuvg9jPZR2KQeH778ogO4gC+cvkZsRXPDBxqwaBW4ZvXEVf615VVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837466;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BM/mEYAnHJt5nEFY5gWtLDIiFJ2QGEN9ZLlKrnuRubk=;
	b=njDTKQhqdT0qtF/XvFIpBb7tlp7pxI89K2jTNacQ1Uz4Apk8lCy3iwZKJ6exsJSh307t
	 F0+2DzJ0NMimE/mmbbFStFlMsAFdZGVjaAapen4mwQ/1nrvBZTIk2APoqXX5mHKW5Se1i
	 u29wjOm6497gIbUDGGKta8qCfos9vghL06GXSKOVCnNoOwdP9N7IUFF3ii4YYAE66dlCo
	 BFvmdHxrzXQcxNnj1RLxULRjs2Lnbm4JfVsoOqbsR2VJJKx2yCJHjuizVe8K8mBHY/JXe
	 HU1x5VicXTTJAXLtkiv8xfEenAPZKe5LpluyeZIAEyv+u37K7WuXXqxPX0Uy9GL3BCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=j+RGZq1l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.88
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010088.outbound.protection.outlook.com [52.103.10.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D520606D807;
	Thu,  5 Nov 2026 00:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D520606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=j+RGZq1l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUt0WriAUAH+VBxyELOKjpKuqRdyhN29g8JjA7eOYvtuJZcZUurx2EST/J6TmRl6cooiCW0zUkCOE6veGR7g5UCg8GJp/tX15ll/tpZu58e2gIYmpUvDueawIwIAgUSM1hIWte0ebco4vDMGMpQtKNH7gBwq2AexPzANtHLSy1ghuiH6IyN8zeBEQ+bI6JDcMbUhS1SQQYT8YLXaVMPnDPFrdPM7Rv7qaU3bgZwn6txf5y974A6CUparcL5ir4eg/8viH//0wOa9hHirEMlVMLRuWsZzmAXzu2hfPk5pI9oisoWeQe6LLInfW0hu9diBosh+rDXL+/VpVa7u3l2B5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM/mEYAnHJt5nEFY5gWtLDIiFJ2QGEN9ZLlKrnuRubk=;
 b=ti7m4oThGXWDayGvgAS47N6BGbM5x44rmC3jIV9DoWetPRo0mQgQ5A9xDWT+9rnVI3h8jufhInO+MWu8XJl4GVRfUg+fDz3s53b4+1Ec6bsytM9K9T63pK8MtoVIslVIjK2UFWelBhu8ZeoS4tHZBPArjFbadJ9s7P+nfgGVeJCZSlTt2OKT3+swp/IkmzU1++l7P/3Pn3dGk5/0I2VBn7chonIiUiU/tC92mCYMHtns7WlE9lp4514hVkRb/UJyeQ0wslWeUPXnQI85yMcy3ubfN6ff68btYoF5Jd4m6TbX6sN4E1W7Dl7znIGj2jo6Sb9ehMAp+JKY6T2Ve80w0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BM/mEYAnHJt5nEFY5gWtLDIiFJ2QGEN9ZLlKrnuRubk=;
 b=j+RGZq1l7E4C/HDEsqbw7q04fCrnVt260o5rqGGEZ6eJF64uRyFz0+zONvOUZHtsUCzaIu2YEvSvvS6QpqggMSwqrUpJqdoWIpAmbSSiXnImCrSLhxWgDn3DTl4Vwuoa/KusSq0Q9kE5x1CuegGsLAKtmQL6GJ+kMrxNA+fvR/LJhe1ErtXh7vHNjGGp7VIuvPT1t3wK3Ndx8FJTMb6YEWYz2pWADj8veDUfTbZcXUJXT4/9dOEn/ialpgh/IJHy/PdenhzBmooHa6e8mJd3oxWo34TssbYRKJYqpoC20Zritb8VGQZQKMVnNg2C3M1YunAwTmKqdv83taq4kuJsEA==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 00:11:03 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 00:11:03 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] iio: accel: msa311: use regmap_reg_field_* functions
Date: Wed,  4 Nov 2026 18:09:50 -0600
Message-ID:
 <SN1PR12MB25282EC93A27F3577BB9B454A5772@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528754CEF9D8E5103ECAE28A5772@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528754CEF9D8E5103ECAE28A5772@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::16) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261105000957.695605-3-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b050636-7acf-48c4-36db-08df3ad1468b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|12121999013|8060799015|22091999003|23021999003|41001999006|15080799012|24121999003|19110799012|8022599003|24021099003|260925184616899003|25010399006|440099028|3412199025|3071699003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9zvZKQifNPAEQ7FuRj9710dx0vCRTTY78mZ/ZVmESoPtg5MhPU40GIyPP5lj?=
 =?us-ascii?Q?Q1ihPl5xYhl/bNNwG90+h297C92+bHw/TV+2T+zg86fpbh7Ff0mY8g5SJGLS?=
 =?us-ascii?Q?nMOIubL5qyGt6U3pZIzE4KJSa1YxJ64ioATGWah7JRWeyzfLlqy50cHlmdxu?=
 =?us-ascii?Q?7FXWCWEfScyy6EEd629daSXmeBNaaKu7TAHQNuKbQLPQExpJ+xRCN7knAJmc?=
 =?us-ascii?Q?Rtyo20mReNxSIMhqLmCSDAybAhhx8CVlCF2tlFcjdl1hjMbB448MOV+3N+Kw?=
 =?us-ascii?Q?DeQ+1/5D+HKfEDQVsKjDdZ4cRwHtf045YaPeNYoL9yZJ3cl5NBtxWsPqlvyK?=
 =?us-ascii?Q?7Qd9iUUUz/pjtgSIMFtn7htyQxVQNGeX+X7uepZKAc74sOK3Ba+Zszs48m+k?=
 =?us-ascii?Q?tciosZFGhO5HPnTTq1WEGzfRtD7nNr1D3pIjkaW87Dk8AW5r/rVNk9URzKRT?=
 =?us-ascii?Q?t96LB/I0mXOkTpViiYUO7HY6PuJZn/xFGJSDjThgCorbNYIQvqIcgrlrRZvG?=
 =?us-ascii?Q?ncQgSglHxnKJh0D09wCxDRv4y/4RRxqmHZiELExFZyu1yEwTQnmonI8niWzS?=
 =?us-ascii?Q?ps4D1mKObV+bY40CgSdI6s157tV855WdsBlhjrZ2yuP3S1bkSkRhwt0dFjkZ?=
 =?us-ascii?Q?loPix5zmZvhjmrsPNilUsDngYOaMocMK2KIMg4e5pRQASKm9d+wLJqVVGp2x?=
 =?us-ascii?Q?ddxr4yfCssOtm/QDxbDWK79YoQRcx14BrVfVwQY+T+32xdopaBtmMX1Cqjvo?=
 =?us-ascii?Q?fk5QLeJwSWckQH3Q6xNyeIiu1yiosRlq0iedKaQSj4aleuXKb/FZHchjZ2LH?=
 =?us-ascii?Q?cW2jJYLcbFQZ8WdzKYG6N6b4nQBdLOplsxhuRatTBK8/cwLxDsnx2nlaeRzN?=
 =?us-ascii?Q?7NmVVDQkLcujfZWMsnyX513GXXwbur/t6I++VOxqLdcio5esQ6/F/rNcikYp?=
 =?us-ascii?Q?fEAibfEfHAMVIOLb8VrtNWcOi/Gc9PdgZWlWTOXBWbb10HjSggt2OK50fB3k?=
 =?us-ascii?Q?Ln9jJNkauz6nD4qX3BjDBY494mcJtBxDV81N4zGjw1Me0xqSeBkVzG45f4qN?=
 =?us-ascii?Q?ZstfO4SN4sejeA0LZOo0s6HHiFvfDNJU7UX+LTZzjbkOI2nOXcLGerXhK9cS?=
 =?us-ascii?Q?DMakEM5eNSfp?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tts5XOxfVr5nzN3UGcvj1VJFX6dW0VeTkZwEhzIpoHCvbfzRdVQiQ5Gmgbuo?=
 =?us-ascii?Q?uP2lAYGXor7F96qTocnh31qONBsq170pi4dhPiU3sMeFN5bYWJYFb4Mo1aWG?=
 =?us-ascii?Q?G/XK8gWqRJvQXL7SoUdTWtjqTwwxON7t9z4XihYcsbimOuZ+oh4nqRYvlJCZ?=
 =?us-ascii?Q?/GJDbIiYn2E4nALQHX8yh6pcuBj5Csw3n3psEZrBRcTPprr4llOnALRPcqAp?=
 =?us-ascii?Q?hiO9P1WZkuImEvKyUAFaD12nF1uaZs+wyJ/uft06FAogA9de7DM7MF6G8eR9?=
 =?us-ascii?Q?zyKwxDJPuYbuvzNLcgT9KlwH4WlO5lOQ0FiWg1P/nn6tHEqGMlioFfcITpTK?=
 =?us-ascii?Q?ZbUdSvevS6qK01+DGm49aOuh9cyt0Q9RuecQ6jAkuLlUmOeIRSafVXL+erkf?=
 =?us-ascii?Q?tU8O0d0LeEqWXYrQcWIkGjx7G7Rzzf+4jbW3qMXNBuSNbgDPjK1Djm0akeuT?=
 =?us-ascii?Q?ERdkFAbeJufVyjB+6BK36IzddTFe1XdlLlSLxlEK3y12AM/65F1GN0B1N5zL?=
 =?us-ascii?Q?l7qd56TDcFiPJKkdM019DCKXfwCYyUqLl5xU8KbN6kLIPgoAzDArEGQ6d23W?=
 =?us-ascii?Q?KP5NUZszo9lse1nv2SVBHZhFqpECiSC5uoh3ygVvOTJPOFHDqtjHgotJnSBw?=
 =?us-ascii?Q?GSX1g4mfN8mkLzAcydUfh6MgFCoKS8RFbWsIOUWa8/Q0u6V61z4W9VY8fXCl?=
 =?us-ascii?Q?Z6K943/gynLCY9IiXMkfDTZzR1tL+hYh4C50BHVED3Rh7xf2GADAbH5J6T95?=
 =?us-ascii?Q?ZBES6CDxkqZbWn5xlKm71IT8wyPkN6unFwSYq/fv/KTJ8nL39GSwh+fyt5W8?=
 =?us-ascii?Q?6VmVejyfymFMlh9DBJvVlMUI6UO/t0goXS7WZdCGYHSfLDZDfkdoqbpSdvDF?=
 =?us-ascii?Q?wTU4TIUInle9w2V5J2M2rim3hzfu7NQN7ebtTCw3sIMKAwv0iXb35zYS+Yb7?=
 =?us-ascii?Q?WrZ92coKFKQ/tX7YHbnpoSrtI5Vbrz6Mzea73zkv2/HVYqcqNn/ZkuQ3pi+e?=
 =?us-ascii?Q?Bj4Xmdtw52z13E2wjVSfIThYLpfoDK/OXmT/0snnxjQItOrGlp7x9DXKPFT3?=
 =?us-ascii?Q?t/VzEjF0ptCdLgQigTX4OAe9sUrxx+Etpdx2LJcYtB2oPLGrR5ghzQe7ByMB?=
 =?us-ascii?Q?pUnDHsJBAd1icOrKCgOO8uTvYyI0Z5mfnbYxLo1UihWj3OUWHoK2kKeiRNbp?=
 =?us-ascii?Q?ip6gN7gXqWZ5AIIqK5G3xjpmc/UOh2tv3H/TqruUVQptkWFlECwxCEqVHb3u?=
 =?us-ascii?Q?Ce7eLlgp2tvA90ZdJd8uJSsro9k7rslfE7WC0h6A/wvVbUu9DdaUSb4/gBtD?=
 =?us-ascii?Q?8Cq5GP+Rxoy7vzycpjaIQFlYFm+gJpgDaWJPK0TAfShflqkJV3RCRUAye0Od?=
 =?us-ascii?Q?eePthJ2+DVePZl4si42Fie78QiD4EfrYwhGHLJPgNiLRYbRLzg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b050636-7acf-48c4-36db-08df3ad1468b
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 00:11:01.8110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599

Simplify the driver by using the new regmap_reg_field_* functions.
regmap_reg_field_FOO is equivalent to regmap_field_FOO, but takes
a reg_field directly instead of a regmap_field.

Tested by compiling.

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 drivers/iio/accel/msa311.c | 297 +++++++++++++------------------------
 1 file changed, 107 insertions(+), 190 deletions(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index caf9b1b6397f..191109ae92b1 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -75,137 +75,85 @@
 #define MSA311_OFFSET_Y_REG       0x39
 #define MSA311_OFFSET_Z_REG       0x3A
 
-enum msa311_fields {
-	/* Soft_Reset */
-	F_SOFT_RESET_I2C, F_SOFT_RESET_SPI,
-	/* Motion_Interrupt */
-	F_ORIENT_INT, F_S_TAP_INT, F_D_TAP_INT, F_ACTIVE_INT, F_FREEFALL_INT,
-	/* Data_Interrupt */
-	F_NEW_DATA_INT,
-	/* Tap_Active_Status */
-	F_TAP_SIGN, F_TAP_FIRST_X, F_TAP_FIRST_Y, F_TAP_FIRST_Z, F_ACTV_SIGN,
-	F_ACTV_FIRST_X, F_ACTV_FIRST_Y, F_ACTV_FIRST_Z,
-	/* Orientation_Status */
-	F_ORIENT_Z, F_ORIENT_X_Y,
-	/* Range */
-	F_FS,
-	/* ODR */
-	F_X_AXIS_DIS, F_Y_AXIS_DIS, F_Z_AXIS_DIS, F_ODR,
-	/* Power Mode/Bandwidth */
-	F_PWR_MODE, F_LOW_POWER_BW,
-	/* Swap_Polarity */
-	F_X_POLARITY, F_Y_POLARITY, F_Z_POLARITY, F_X_Y_SWAP,
-	/* Int_Set_0 */
-	F_ORIENT_INT_EN, F_S_TAP_INT_EN, F_D_TAP_INT_EN, F_ACTIVE_INT_EN_Z,
-	F_ACTIVE_INT_EN_Y, F_ACTIVE_INT_EN_X,
-	/* Int_Set_1 */
-	F_NEW_DATA_INT_EN, F_FREEFALL_INT_EN,
-	/* Int_Map_0 */
-	F_INT1_ORIENT, F_INT1_S_TAP, F_INT1_D_TAP, F_INT1_ACTIVE,
-	F_INT1_FREEFALL,
-	/* Int_Map_1 */
-	F_INT1_NEW_DATA,
-	/* Int_Config */
-	F_INT1_OD, F_INT1_LVL,
-	/* Int_Latch */
-	F_RESET_INT, F_LATCH_INT,
-	/* Freefall_Hy */
-	F_FREEFALL_MODE, F_FREEFALL_HY,
-	/* Active_Dur */
-	F_ACTIVE_DUR,
-	/* Tap_Dur */
-	F_TAP_QUIET, F_TAP_SHOCK, F_TAP_DUR,
-	/* Tap_Th */
-	F_TAP_TH,
-	/* Orient_Hy */
-	F_ORIENT_HYST, F_ORIENT_BLOCKING, F_ORIENT_MODE,
-	/* Z_Block */
-	F_Z_BLOCKING,
-	/* End of register map */
-	F_MAX_FIELDS,
-};
-
-static const struct reg_field msa311_reg_fields[] = {
-	/* Soft_Reset */
-	[F_SOFT_RESET_I2C] = REG_FIELD(MSA311_SOFT_RESET_REG, 2, 2),
-	[F_SOFT_RESET_SPI] = REG_FIELD(MSA311_SOFT_RESET_REG, 5, 5),
-	/* Motion_Interrupt */
-	[F_ORIENT_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 6, 6),
-	[F_S_TAP_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 5, 5),
-	[F_D_TAP_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 4, 4),
-	[F_ACTIVE_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 2, 2),
-	[F_FREEFALL_INT] = REG_FIELD(MSA311_MOTION_INT_REG, 0, 0),
-	/* Data_Interrupt */
-	[F_NEW_DATA_INT] = REG_FIELD(MSA311_DATA_INT_REG, 0, 0),
-	/* Tap_Active_Status */
-	[F_TAP_SIGN] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 7, 7),
-	[F_TAP_FIRST_X] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 6, 6),
-	[F_TAP_FIRST_Y] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 5, 5),
-	[F_TAP_FIRST_Z] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 4, 4),
-	[F_ACTV_SIGN] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 3, 3),
-	[F_ACTV_FIRST_X] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 2, 2),
-	[F_ACTV_FIRST_Y] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 1, 1),
-	[F_ACTV_FIRST_Z] = REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 0, 0),
-	/* Orientation_Status */
-	[F_ORIENT_Z] = REG_FIELD(MSA311_ORIENT_STS_REG, 6, 6),
-	[F_ORIENT_X_Y] = REG_FIELD(MSA311_ORIENT_STS_REG, 4, 5),
-	/* Range */
-	[F_FS] = REG_FIELD(MSA311_RANGE_REG, 0, 1),
-	/* ODR */
-	[F_X_AXIS_DIS] = REG_FIELD(MSA311_ODR_REG, 7, 7),
-	[F_Y_AXIS_DIS] = REG_FIELD(MSA311_ODR_REG, 6, 6),
-	[F_Z_AXIS_DIS] = REG_FIELD(MSA311_ODR_REG, 5, 5),
-	[F_ODR] = REG_FIELD(MSA311_ODR_REG, 0, 3),
-	/* Power Mode/Bandwidth */
-	[F_PWR_MODE] = REG_FIELD(MSA311_PWR_MODE_REG, 6, 7),
-	[F_LOW_POWER_BW] = REG_FIELD(MSA311_PWR_MODE_REG, 1, 4),
-	/* Swap_Polarity */
-	[F_X_POLARITY] = REG_FIELD(MSA311_SWAP_POLARITY_REG, 3, 3),
-	[F_Y_POLARITY] = REG_FIELD(MSA311_SWAP_POLARITY_REG, 2, 2),
-	[F_Z_POLARITY] = REG_FIELD(MSA311_SWAP_POLARITY_REG, 1, 1),
-	[F_X_Y_SWAP] = REG_FIELD(MSA311_SWAP_POLARITY_REG, 0, 0),
-	/* Int_Set_0 */
-	[F_ORIENT_INT_EN] = REG_FIELD(MSA311_INT_SET_0_REG, 6, 6),
-	[F_S_TAP_INT_EN] = REG_FIELD(MSA311_INT_SET_0_REG, 5, 5),
-	[F_D_TAP_INT_EN] = REG_FIELD(MSA311_INT_SET_0_REG, 4, 4),
-	[F_ACTIVE_INT_EN_Z] = REG_FIELD(MSA311_INT_SET_0_REG, 2, 2),
-	[F_ACTIVE_INT_EN_Y] = REG_FIELD(MSA311_INT_SET_0_REG, 1, 1),
-	[F_ACTIVE_INT_EN_X] = REG_FIELD(MSA311_INT_SET_0_REG, 0, 0),
-	/* Int_Set_1 */
-	[F_NEW_DATA_INT_EN] = REG_FIELD(MSA311_INT_SET_1_REG, 4, 4),
-	[F_FREEFALL_INT_EN] = REG_FIELD(MSA311_INT_SET_1_REG, 3, 3),
-	/* Int_Map_0 */
-	[F_INT1_ORIENT] = REG_FIELD(MSA311_INT_MAP_0_REG, 6, 6),
-	[F_INT1_S_TAP] = REG_FIELD(MSA311_INT_MAP_0_REG, 5, 5),
-	[F_INT1_D_TAP] = REG_FIELD(MSA311_INT_MAP_0_REG, 4, 4),
-	[F_INT1_ACTIVE] = REG_FIELD(MSA311_INT_MAP_0_REG, 2, 2),
-	[F_INT1_FREEFALL] = REG_FIELD(MSA311_INT_MAP_0_REG, 0, 0),
-	/* Int_Map_1 */
-	[F_INT1_NEW_DATA] = REG_FIELD(MSA311_INT_MAP_1_REG, 0, 0),
-	/* Int_Config */
-	[F_INT1_OD] = REG_FIELD(MSA311_INT_CONFIG_REG, 1, 1),
-	[F_INT1_LVL] = REG_FIELD(MSA311_INT_CONFIG_REG, 0, 0),
-	/* Int_Latch */
-	[F_RESET_INT] = REG_FIELD(MSA311_INT_LATCH_REG, 7, 7),
-	[F_LATCH_INT] = REG_FIELD(MSA311_INT_LATCH_REG, 0, 3),
-	/* Freefall_Hy */
-	[F_FREEFALL_MODE] = REG_FIELD(MSA311_FREEFALL_HY_REG, 2, 2),
-	[F_FREEFALL_HY] = REG_FIELD(MSA311_FREEFALL_HY_REG, 0, 1),
-	/* Active_Dur */
-	[F_ACTIVE_DUR] = REG_FIELD(MSA311_ACTIVE_DUR_REG, 0, 1),
-	/* Tap_Dur */
-	[F_TAP_QUIET] = REG_FIELD(MSA311_TAP_DUR_REG, 7, 7),
-	[F_TAP_SHOCK] = REG_FIELD(MSA311_TAP_DUR_REG, 6, 6),
-	[F_TAP_DUR] = REG_FIELD(MSA311_TAP_DUR_REG, 0, 2),
-	/* Tap_Th */
-	[F_TAP_TH] = REG_FIELD(MSA311_TAP_TH_REG, 0, 4),
-	/* Orient_Hy */
-	[F_ORIENT_HYST] = REG_FIELD(MSA311_ORIENT_HY_REG, 4, 6),
-	[F_ORIENT_BLOCKING] = REG_FIELD(MSA311_ORIENT_HY_REG, 2, 3),
-	[F_ORIENT_MODE] = REG_FIELD(MSA311_ORIENT_HY_REG, 0, 1),
-	/* Z_Block */
-	[F_Z_BLOCKING] = REG_FIELD(MSA311_Z_BLOCK_REG, 0, 3),
-};
+/* Soft_Reset */
+#define MSA311_F_SOFT_RESET_I2C	REG_FIELD(MSA311_SOFT_RESET_REG, 2, 2)
+#define MSA311_F_SOFT_RESET_SPI	REG_FIELD(MSA311_SOFT_RESET_REG, 5, 5)
+/* Motion_Interrupt */
+#define MSA311_F_ORIENT_INT	REG_FIELD(MSA311_MOTION_INT_REG, 6, 6)
+#define MSA311_F_S_TAP_INT	REG_FIELD(MSA311_MOTION_INT_REG, 5, 5)
+#define MSA311_F_D_TAP_INT	REG_FIELD(MSA311_MOTION_INT_REG, 4, 4)
+#define MSA311_F_ACTIVE_INT	REG_FIELD(MSA311_MOTION_INT_REG, 2, 2)
+#define MSA311_F_FREEFALL_INT	REG_FIELD(MSA311_MOTION_INT_REG, 0, 0)
+/* Data_Interrupt */
+#define MSA311_F_NEW_DATA_INT	REG_FIELD(MSA311_DATA_INT_REG, 0, 0)
+/* Tap_Active_Status */
+#define MSA311_F_TAP_SIGN	REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 7, 7)
+#define MSA311_F_TAP_FIRST_X	REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 6, 6)
+#define MSA311_F_TAP_FIRST_Y	REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 5, 5)
+#define MSA311_F_TAP_FIRST_Z	REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 4, 4)
+#define MSA311_F_ACTV_SIGN	REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 3, 3)
+#define MSA311_F_ACTV_FIRST_X	REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 2, 2)
+#define MSA311_F_ACTV_FIRST_Y	REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 1, 1)
+#define MSA311_F_ACTV_FIRST_Z	REG_FIELD(MSA311_TAP_ACTIVE_STS_REG, 0, 0)
+/* Orientation_Status */
+#define MSA311_F_ORIENT_Z	REG_FIELD(MSA311_ORIENT_STS_REG, 6, 6)
+#define MSA311_F_ORIENT_X_Y	REG_FIELD(MSA311_ORIENT_STS_REG, 4, 5)
+/* Range */
+#define MSA311_F_FS		REG_FIELD(MSA311_RANGE_REG, 0, 1)
+/* ODR */
+#define MSA311_F_X_AXIS_DIS	REG_FIELD(MSA311_ODR_REG, 7, 7)
+#define MSA311_F_Y_AXIS_DIS	REG_FIELD(MSA311_ODR_REG, 6, 6)
+#define MSA311_F_Z_AXIS_DIS	REG_FIELD(MSA311_ODR_REG, 5, 5)
+#define MSA311_F_ODR		REG_FIELD(MSA311_ODR_REG, 0, 3)
+/* Power Mode/Bandwidth */
+#define MSA311_F_PWR_MODE	REG_FIELD(MSA311_PWR_MODE_REG, 6, 7)
+#define MSA311_F_LOW_POWER_BW	REG_FIELD(MSA311_PWR_MODE_REG, 1, 4)
+/* Swap_Polarity */
+#define MSA311_F_X_POLARITY	REG_FIELD(MSA311_SWAP_POLARITY_REG, 3, 3)
+#define MSA311_F_Y_POLARITY	REG_FIELD(MSA311_SWAP_POLARITY_REG, 2, 2)
+#define MSA311_F_Z_POLARITY	REG_FIELD(MSA311_SWAP_POLARITY_REG, 1, 1)
+#define MSA311_F_X_Y_SWAP	REG_FIELD(MSA311_SWAP_POLARITY_REG, 0, 0)
+/* Int_Set_0 */
+#define MSA311_F_ORIENT_INT_EN		REG_FIELD(MSA311_INT_SET_0_REG, 6, 6)
+#define MSA311_F_S_TAP_INT_EN		REG_FIELD(MSA311_INT_SET_0_REG, 5, 5)
+#define MSA311_F_D_TAP_INT_EN		REG_FIELD(MSA311_INT_SET_0_REG, 4, 4)
+#define MSA311_F_ACTIVE_INT_EN_Z	REG_FIELD(MSA311_INT_SET_0_REG, 2, 2)
+#define MSA311_F_ACTIVE_INT_EN_Y	REG_FIELD(MSA311_INT_SET_0_REG, 1, 1)
+#define MSA311_F_ACTIVE_INT_EN_X	REG_FIELD(MSA311_INT_SET_0_REG, 0, 0)
+/* Int_Set_1 */
+#define MSA311_F_NEW_DATA_INT_EN	REG_FIELD(MSA311_INT_SET_1_REG, 4, 4)
+#define MSA311_F_FREEFALL_INT_EN	REG_FIELD(MSA311_INT_SET_1_REG, 3, 3)
+/* Int_Map_0 */
+#define MSA311_F_INT1_ORIENT	REG_FIELD(MSA311_INT_MAP_0_REG, 6, 6)
+#define MSA311_F_INT1_S_TAP	REG_FIELD(MSA311_INT_MAP_0_REG, 5, 5)
+#define MSA311_F_INT1_D_TAP	REG_FIELD(MSA311_INT_MAP_0_REG, 4, 4)
+#define MSA311_F_INT1_ACTIVE	REG_FIELD(MSA311_INT_MAP_0_REG, 2, 2)
+#define MSA311_F_INT1_FREEFALL	REG_FIELD(MSA311_INT_MAP_0_REG, 0, 0)
+/* Int_Map_1 */
+#define MSA311_F_INT1_NEW_DATA	REG_FIELD(MSA311_INT_MAP_1_REG, 0, 0)
+/* Int_Config */
+#define MSA311_F_INT1_OD	REG_FIELD(MSA311_INT_CONFIG_REG, 1, 1)
+#define MSA311_F_INT1_LVL	REG_FIELD(MSA311_INT_CONFIG_REG, 0, 0)
+/* Int_Latch */
+#define MSA311_F_RESET_INT	REG_FIELD(MSA311_INT_LATCH_REG, 7, 7)
+#define MSA311_F_LATCH_INT	REG_FIELD(MSA311_INT_LATCH_REG, 0, 3)
+/* Freefall_Hy */
+#define MSA311_F_FREEFALL_MODE	REG_FIELD(MSA311_FREEFALL_HY_REG, 2, 2)
+#define MSA311_F_FREEFALL_HY	REG_FIELD(MSA311_FREEFALL_HY_REG, 0, 1)
+/* Active_Dur */
+#define MSA311_F_ACTIVE_DUR	REG_FIELD(MSA311_ACTIVE_DUR_REG, 0, 1)
+/* Tap_Dur */
+#define MSA311_F_TAP_QUIET	REG_FIELD(MSA311_TAP_DUR_REG, 7, 7)
+#define MSA311_F_TAP_SHOCK	REG_FIELD(MSA311_TAP_DUR_REG, 6, 6)
+#define MSA311_F_TAP_DUR	REG_FIELD(MSA311_TAP_DUR_REG, 0, 2)
+/* Tap_Th */
+#define MSA311_F_TAP_TH		REG_FIELD(MSA311_TAP_TH_REG, 0, 4)
+/* Orient_Hy */
+#define MSA311_F_ORIENT_HYST		REG_FIELD(MSA311_ORIENT_HY_REG, 4, 6)
+#define MSA311_F_ORIENT_BLOCKING	REG_FIELD(MSA311_ORIENT_HY_REG, 2, 3)
+#define MSA311_F_ORIENT_MODE		REG_FIELD(MSA311_ORIENT_HY_REG, 0, 1)
+/* Z_Block */
+#define MSA311_F_Z_BLOCKING	REG_FIELD(MSA311_Z_BLOCK_REG, 0, 3)
 
 #define MSA311_WHO_AM_I 0x13
 
@@ -334,11 +282,7 @@ static const struct regmap_config msa311_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
-#define MSA311_GENMASK(field) ({                \
-	typeof(&(msa311_reg_fields)[0]) _field; \
-	_field = &msa311_reg_fields[(field)];   \
-	GENMASK(_field->msb, _field->lsb);      \
-})
+#define MSA311_GENMASK(field) GENMASK((field).msb, (field).lsb)
 
 /**
  * struct msa311_priv - MSA311 internal private state
@@ -354,7 +298,6 @@ static const struct regmap_config msa311_regmap_config = {
  */
 struct msa311_priv {
 	struct regmap *regs;
-	struct regmap_field *fields[F_MAX_FIELDS];
 
 	struct device *dev;
 	struct mutex lock;
@@ -410,7 +353,7 @@ static int msa311_get_odr(struct msa311_priv *msa311, unsigned int *odr)
 {
 	int err;
 
-	err = regmap_field_read(msa311->fields[F_ODR], odr);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_ODR, odr);
 	if (err)
 		return err;
 
@@ -453,7 +396,7 @@ static int msa311_set_odr(struct msa311_priv *msa311, unsigned int odr)
 	bool good_odr;
 	int err;
 
-	err = regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_PWR_MODE, &pwr_mode);
 	if (err)
 		return err;
 
@@ -472,7 +415,7 @@ static int msa311_set_odr(struct msa311_priv *msa311, unsigned int odr)
 		return -EINVAL;
 	}
 
-	return regmap_field_write(msa311->fields[F_ODR], odr);
+	return regmap_reg_field_write(msa311->regs, MSA311_F_ODR, odr);
 }
 
 /**
@@ -538,11 +481,11 @@ static int msa311_set_pwr_mode(struct msa311_priv *msa311, unsigned int mode)
 
 	dev_dbg(dev, "transition to %s mode\n", msa311_pwr_modes[mode]);
 
-	err = regmap_field_read(msa311->fields[F_PWR_MODE], &prev_mode);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_PWR_MODE, &prev_mode);
 	if (err)
 		return err;
 
-	err = regmap_field_write(msa311->fields[F_PWR_MODE], mode);
+	err = regmap_reg_field_write(msa311->regs, MSA311_F_PWR_MODE, mode);
 	if (err)
 		return err;
 
@@ -634,7 +577,7 @@ static int msa311_read_scale(struct iio_dev *indio_dev, int *val, int *val2)
 	int err;
 
 	mutex_lock(&msa311->lock);
-	err = regmap_field_read(msa311->fields[F_FS], &fs);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_FS, &fs);
 	mutex_unlock(&msa311->lock);
 	if (err) {
 		dev_err(dev, "can't get actual scale (%pe)\n", ERR_PTR(err));
@@ -734,7 +677,7 @@ static int msa311_write_scale(struct iio_dev *indio_dev, int val, int val2)
 		/* Do not check msa311_fs_table[fs].integral, it's always 0 */
 		if (val2 == msa311_fs_table[fs].microfract) {
 			mutex_lock(&msa311->lock);
-			err = regmap_field_write(msa311->fields[F_FS], fs);
+			err = regmap_reg_field_write(msa311->regs, MSA311_F_FS, fs);
 			mutex_unlock(&msa311->lock);
 			break;
 		}
@@ -863,7 +806,7 @@ static int msa311_set_new_data_trig_state(struct iio_trigger *trig, bool state)
 	int err;
 
 	mutex_lock(&msa311->lock);
-	err = regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], state);
+	err = regmap_reg_field_write(msa311->regs, MSA311_F_NEW_DATA_INT_EN, state);
 	mutex_unlock(&msa311->lock);
 	if (err)
 		dev_err(dev,
@@ -934,8 +877,8 @@ static irqreturn_t msa311_irq_thread(int irq, void *p)
 	 * specification it's cleared automatically after a fixed time.
 	 * So just check that is enabled by driver logic.
 	 */
-	err = regmap_field_read(msa311->fields[F_NEW_DATA_INT_EN],
-				&new_data_int_enabled);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_NEW_DATA_INT_EN,
+				    &new_data_int_enabled);
 
 	mutex_unlock(&msa311->lock);
 	if (err) {
@@ -995,8 +938,8 @@ static int msa311_soft_reset(struct msa311_priv *msa311)
 	int err;
 
 	err = regmap_write(msa311->regs, MSA311_SOFT_RESET_REG,
-			   MSA311_GENMASK(F_SOFT_RESET_I2C) |
-			   MSA311_GENMASK(F_SOFT_RESET_SPI));
+			   MSA311_GENMASK(MSA311_F_SOFT_RESET_I2C) |
+			   MSA311_GENMASK(MSA311_F_SOFT_RESET_SPI));
 	if (err)
 		return dev_err_probe(dev, err, "can't soft reset all logic\n");
 
@@ -1029,9 +972,9 @@ static int msa311_chip_init(struct msa311_priv *msa311)
 
 	/* Disable all axes by default */
 	err = regmap_clear_bits(msa311->regs, MSA311_ODR_REG,
-				MSA311_GENMASK(F_X_AXIS_DIS) |
-				MSA311_GENMASK(F_Y_AXIS_DIS) |
-				MSA311_GENMASK(F_Z_AXIS_DIS));
+				MSA311_GENMASK(MSA311_F_X_AXIS_DIS) |
+				MSA311_GENMASK(MSA311_F_Y_AXIS_DIS) |
+				MSA311_GENMASK(MSA311_F_Z_AXIS_DIS));
 	if (err)
 		return dev_err_probe(dev, err, "can't enable all axes\n");
 
@@ -1074,30 +1017,30 @@ static int msa311_setup_interrupts(struct msa311_priv *msa311)
 		return dev_err_probe(dev, err,
 				     "can't register newdata trigger\n");
 
-	err = regmap_field_write(msa311->fields[F_INT1_OD],
-				 MSA311_INT1_OD_PUSH_PULL);
+	err = regmap_reg_field_write(msa311->regs, MSA311_F_INT1_OD,
+				     MSA311_INT1_OD_PUSH_PULL);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "can't enable push-pull interrupt\n");
 
-	err = regmap_field_write(msa311->fields[F_INT1_LVL],
-				 MSA311_INT1_LVL_HIGH);
+	err = regmap_reg_field_write(msa311->regs, MSA311_F_INT1_LVL,
+				     MSA311_INT1_LVL_HIGH);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "can't set active interrupt level\n");
 
-	err = regmap_field_write(msa311->fields[F_LATCH_INT],
-				 MSA311_LATCH_INT_LATCHED);
+	err = regmap_reg_field_write(msa311->regs, MSA311_F_LATCH_INT,
+				     MSA311_LATCH_INT_LATCHED);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "can't latch interrupt\n");
 
-	err = regmap_field_write(msa311->fields[F_RESET_INT], 1);
+	err = regmap_reg_field_write(msa311->regs, MSA311_F_RESET_INT, 1);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "can't reset interrupt\n");
 
-	err = regmap_field_write(msa311->fields[F_INT1_NEW_DATA], 1);
+	err = regmap_reg_field_write(msa311->regs, MSA311_F_INT1_NEW_DATA, 1);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "can't map new data interrupt\n");
@@ -1105,33 +1048,6 @@ static int msa311_setup_interrupts(struct msa311_priv *msa311)
 	return 0;
 }
 
-static int msa311_regmap_init(struct msa311_priv *msa311)
-{
-	struct regmap_field **fields = msa311->fields;
-	struct device *dev = msa311->dev;
-	struct i2c_client *i2c = to_i2c_client(dev);
-	struct regmap *regmap;
-	int i;
-
-	regmap = devm_regmap_init_i2c(i2c, &msa311_regmap_config);
-	if (IS_ERR(regmap))
-		return dev_err_probe(dev, PTR_ERR(regmap),
-				     "failed to register i2c regmap\n");
-
-	msa311->regs = regmap;
-
-	for (i = 0; i < F_MAX_FIELDS; i++) {
-		fields[i] = devm_regmap_field_alloc(dev,
-						    msa311->regs,
-						    msa311_reg_fields[i]);
-		if (IS_ERR(msa311->fields[i]))
-			return dev_err_probe(dev, PTR_ERR(msa311->fields[i]),
-					     "can't alloc field[%d]\n", i);
-	}
-
-	return 0;
-}
-
 static void msa311_powerdown(void *msa311)
 {
 	msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);
@@ -1152,9 +1068,10 @@ static int msa311_probe(struct i2c_client *i2c)
 	msa311->dev = dev;
 	i2c_set_clientdata(i2c, indio_dev);
 
-	err = msa311_regmap_init(msa311);
-	if (err)
-		return err;
+	msa311->regs = devm_regmap_init_i2c(i2c, &msa311_regmap_config);
+	if (IS_ERR(msa311->regs))
+		return dev_err_probe(dev, PTR_ERR(msa311->regs),
+				     "failed to register i2c regmap\n");
 
 	mutex_init(&msa311->lock);
 
-- 
2.53.0

