Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794553637;
	b=v13wEBKxyHqF9iAQeDmwxmSAy6q6lglJle/m7K2MwylJDzg/Bt3VWPGRBT160nKppDUq
	 2UOhZ+AeGrimvsSYGoo5xvpKBsYmB3thMJLV6SvMn/yaeaCczd1wgosU6LYWOf5HrvKRw
	 NhSGipHViS0WHCg6U3hpVtlBwMyLB6+S2G8qIC8PwCk//pDxp+ZZCoJZcV1VwebqOeg+i
	 B5xr274IxQUgg6VqUYN+msgHfLtBXkC7Mk4OdTzUkmFz8+i+i7NCgB83UUcvxwJ8nFytG
	 cucx3nkfdIvkXiUHTau6OLRDRuP4vhKV4gYxK1twnkgseeTR+c4iGxu1I+yUZJUerEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553637;
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
	bh=BCIyuKgR2mXFjriA+21jezGvJTvqZ8GSLLDB5O4k2z8=;
	b=yqyWxwqLTgKuma+KUvlXWFX+8DEMqx2i+YmEdBRuwg400vOlv+jJxb/oy4pe0s86a2gV
	 u8ZyWfAbXfBHAoWvoXWUzKQaw/3WeKU6AL10tD2Shp+NDaHWYurZVU6xYL3+d8fE+rK02
	 jm8GyJ+OQFX/Wdtft77zqJI8PCiekpzJUP/ZkIogwpAEnWr+BerUcxncMi0vyl0gpgYcg
	 b614YQ4P57Q6dw+YOO8vTGTEI182LaXuljsCNF74/zSkWXq7HVo6vcPiYpYOpsPOd/0yB
	 0NJe60gX2qBjzEok9VmX1snoM1I7TE0L4dx/Y+WM/T0wn9sTxInbcQQuD/OgBUzrSDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=gGXem1tc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.13
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012013.outbound.protection.outlook.com [52.103.23.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3E606A327;
	Fri, 13 Nov 2026 07:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99D3E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=gGXem1tc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL2ykWNQEhmi0AHP9JfQU1NGW0A0ICEIMcWtP02hilDVOjoHgs3iGmqGQJX99Icqkq4QEYuD7I9meA7/i0mmuN40H4R4evJzdyK9OUiF3VmPSZTeVOwaHLwcvP30hz4XC+Q0OFW8ve65K9dGApaHof3gihtr8BtGTZiXQqBMndAQSSI8tBa+ezITMJgCcSWN1+c9eyp/mf54aYmKJBZmT+4lmI/59CVTMqwN6ziVlG5iRZ/yw//6FhbfDJm728ASnd8nrciJnT7RJ0QTH/OACfznj8tbPyBHJLxtK4PCRZARgr07jzZx9KjXKln7vkBoMnXB4rXrDK3gkNFHvLLRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCIyuKgR2mXFjriA+21jezGvJTvqZ8GSLLDB5O4k2z8=;
 b=ExBGcabBFvH30cW3jTUbdKi9EMMVEE5rTcKI6bBEylsryDAb3TlLqLGiCC0rK/MObEWS0d4ROqHOYUTXtdEitPLyhu8wUtYgacCoJAy1mkUguB9IJ+MZL8gdOLd0QVVZQtBkT/wK2FTYgiN8Ag9O7H9fUvHtg2X1Q/V1Ee3qk2ESrbV+qXos3OE7mv8mMuJQLNxDHH39gh9rxvfRlx0SomxmrwMyHmmSNEWnmqgr9YHfvDPMDgKaavuqRsAC9EpFtGL5VgPonZmm+5OhWPtURG/8B15hDpuNo4yFRTncuYUQu18xsPG8gx8XHaltXoQBiBhA//rKZnc0S6LcpG4uzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCIyuKgR2mXFjriA+21jezGvJTvqZ8GSLLDB5O4k2z8=;
 b=gGXem1tcGip64BttA1z8/bEEgaIL1/q5g/NCi1lyqxAMdIMqE0+YM7FVsBIqcmIXQPtFPBkVbEyoRKTzfwCTIIWWtgPI8gTSGW5SpPQn2rJeMiYpWg/RuQjTMN4Sb6WkGUWHUVHuLjzWJySX7Dbh0bdUvHYZ//B6xFVrYhS/v8SXNjTZDrTlQyopq9AEUVWnHtCRanPbfundYTwLbzCzeLcFNgP7ZOdlQ9s5bXwEDnMCff1f29LldfJV6l0Ps3ZkdkuiAjebZZVhFRD+XOZSH9b8WmhBVjqHKN2iYHtAurENm/ifyrCijBUjaISA1vl8lFBuwfUwWPi2V+22tVL+1g==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 07:02:40 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 07:02:40 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] iio: accel: msa311: use regmap_reg_field_* functions
Date: Fri, 13 Nov 2026 00:55:46 -0600
Message-ID:
 <SN1PR12MB25284D05A476483E668E1255A57F2@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SN1PR12MB2528812E26B65457239E9EEDA57F2@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB2528812E26B65457239E9EEDA57F2@SN1PR12MB2528.namprd12.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:610:b0::8) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261113065547.709782-3-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: dd190431-726c-45c8-1b45-08df41532c64
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25010399006|4140399003|12121999013|260925184616899003|24021099003|15080799012|22091999003|24121999003|23021999003|8060799015|39105399006|19110799012|41001999006|41105399003|40105399003|3412199025|440099028|18071099003|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N51gXWHsq6TfIKT731Q1PJq3k+ztPKeYQI3JM4Seml8a7Cr7lyvAfxxL604k?=
 =?us-ascii?Q?K88tRvTLSBwwUBsKfesQMZ4F212/B1BJui6OHiFfra0GXEcjx+GJpGHbKSsM?=
 =?us-ascii?Q?PPgBqP+5BO+BZahhUyx48QEa8d2WQ4S3Gc86FxYNnYkp/nq07axN0HLDGp2F?=
 =?us-ascii?Q?zuKQMfcUDGlBcXZOG6oHZxVyXsv+B8SiIsefjxk8arBOSYY3/+rGhK+9k4ZO?=
 =?us-ascii?Q?UhgHwiFuQOd1pzfrq4iNMKb4R2/bX13BqoNWpoKwnSXui/qyyasfcsbslhkr?=
 =?us-ascii?Q?CaXLoZ5iH0GHqDI7WpurVottXvmMeonqywPQWEE1qK92IRLZez+LIsQUAJkL?=
 =?us-ascii?Q?55UiKmTYnOfjsA18x17o9SKclUj2VNxQAnZprv7SuIV8V54nasg7uCvCs+4L?=
 =?us-ascii?Q?ja1yMiVgAOETxAs/7oH0lHe0KOVCFz7/8+1wfrOnoafjpMnam/vS3mJAozBX?=
 =?us-ascii?Q?4W3LesW6FShbsdw7i+Jgw9eCD7YTqbPc/b1zw9ZcFktfxQAsUoisH4Dejcy7?=
 =?us-ascii?Q?q9CdUdbIQ/9EP+Av+V7podC3zHjmAcm2Gj7Z+XI0UvmGbaX0M2IIQ4de79iz?=
 =?us-ascii?Q?acG7/waTuQQ94wMXlrfbNp3ut71aIXDkQgWhkGzj1hEOHP6okyanttXjIj3t?=
 =?us-ascii?Q?1ObXaK/web9NQYxFRShQbkhEOei0sv8MvpdzXVu6RBzujQ91kK6wYkdQUqG7?=
 =?us-ascii?Q?EGf7XSmlkLw2jPo5FJ/sPkxCSeg6FIc/pJJTe5zvH+br/pBmuODS3tYuHNZu?=
 =?us-ascii?Q?XS89RnbkVh783JWHLo5QYZW9rNXq6Md1ZmESLRKabmFLr1pVM1FW/0ztPiVC?=
 =?us-ascii?Q?8f7/2ZPb69+2TzeVqYDp2+E/Bc8dL5bkYbfDYFOXt98uL7bXEJQWSl+IVybt?=
 =?us-ascii?Q?GaZAC2Mur7l0jFP5swXKZAB28yqw9ugIBl6QNttMFTaPmjQvKe4Nx9+9wA8S?=
 =?us-ascii?Q?zxMUJcN2x6Ez84wkJcKvQ7MHKme/rHnh7zsZU24aXXSaof8Naf3BPO99mKko?=
 =?us-ascii?Q?u0om1viP0bGV8JVguxIETlo6E0yiQ0hhhDqcDnzgD4E+5Nxe+DKjW8Yj43Z6?=
 =?us-ascii?Q?FRftEnNuNoIVg7K95aZ95KoBhJWJHW5+Y61Y27+O6NBx9+Z0/493R8Nqyn04?=
 =?us-ascii?Q?xOMuf8h5QJq25t6s6buT/dCv5qJ9kNF7XWVrmBfE/Cz1sl9yRoBle0ujthty?=
 =?us-ascii?Q?TUi7rjUATYHi2NUe?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p5USpRz2OomXtRw2jB5fpn1QFTsOYkute7Gt6cGcwlCf+3FxGPu3Jopo+8sz?=
 =?us-ascii?Q?kCg7ZHhb/m6ZRYt6Y7E8qXPL6Oi371Uy1+oz0zgQqOapJ3O2PlzXhZfyISz0?=
 =?us-ascii?Q?F1dhEkFey9rLqbBPvJ0/d3aYlZTajvVMKSoqbdY8x2eNUEfEdgn9zDjRux8l?=
 =?us-ascii?Q?LXKQLVuUo1Zi2Y6ifbpM8uxbvillWLKMq0cm43RkyPXjUxU4g2ZRirENFBXL?=
 =?us-ascii?Q?j1LUOMJH8b/py62oQKqmjQxWfqZ5dX6VCa4wzXt3r7KENgw6gap8aYirJQ5h?=
 =?us-ascii?Q?kdtTwM5hEjVW4mzSDQAs0vbNDTcWMe8GzRqXghXcUa+1cAMOvhWgHxuz64TB?=
 =?us-ascii?Q?DfCR9it4bbSFbRKz1ihAMyi3mqoLi+Jhm9XMcMIdoxden2zEvAhXV6OGTmex?=
 =?us-ascii?Q?92jNPq441Ue8BLIcS0S3BTc3GVQkjv2X+HzLGEjtUaBd5tW0Ubilju4HrTjF?=
 =?us-ascii?Q?/vreU3vJ3UKW4/SFnQ6y4KMu8QhjhWFqMkNT659/4XNhX/vrg7ZGitxpEXs1?=
 =?us-ascii?Q?VAhM7c0REyqVfks5f9EYmzxtgdQAh2f9lQF76ujVyT6aoEZSTQDMtMSSW4fo?=
 =?us-ascii?Q?4P8VI6sWER8DNWEgZPFI7lTjM8He5rgacjqhJZXPdoXuEn0U9wvRiiGlCkXy?=
 =?us-ascii?Q?iwdmxlwf2EmBQGS+Mr12PKJE5WE929QgZvK/bETJQXBCk0XqSVCykHn0UnWq?=
 =?us-ascii?Q?rHI4zQhUDP31O8A1DDh/IcJEOyDf3jvbrO2YQxIzr+JXQ6/yesgRX3DqzPdQ?=
 =?us-ascii?Q?0wKPzh3bCqFQjxUV7DEx048tFgkRYY+AIzKH1teuyyeTepepDftXoaFJ/R1t?=
 =?us-ascii?Q?2CqAHbf75lc2MbhLJkHurETMM5ZXffjSpSLw0dj3560HOJiMc/uxikZ4RGAr?=
 =?us-ascii?Q?uSFs4qntZb0WANlSVxuaT7SaMR+bRg3JWLvl4eUvuUHjqCLCTfRW685EXyNG?=
 =?us-ascii?Q?7nTEaDG72jtLuFVJmL333y2xHiAnxH1gFrGJeV+4XgCwukGQBkZIewoFIOiV?=
 =?us-ascii?Q?EtXHRY5HjEkd3DqauydXpyM3vP7Bv29GRyX/vtsk7s3+gEuY9v8vlZDgNm4a?=
 =?us-ascii?Q?91WDEzw6LxUdhvi5Lb6Yk28pQV3JYbMG8130qsIEvhAZkOXkt1j2dRkVaqK0?=
 =?us-ascii?Q?F6WhUdjAYBYWcpK2gJ+HvscunbwRZAORnQefKH1ilQJMdHnP5l8Uy7q+MPRZ?=
 =?us-ascii?Q?NSzsVfWavDqc8kK6BC22pANfCUzFq5sQiGer3hNcPJj/ukYxiFp1rYe64Kn8?=
 =?us-ascii?Q?SbqYLGP9BX6TAG3x6DB4IugLHc7vuqAFQN5RzsWul+NU7yLYvS3nHUKwWBwH?=
 =?us-ascii?Q?m6Oa6J5opn+0F1SB5SP2yEiCUYRT3mYZZXGrn2ggj0MXHmrVucWrePieOA4M?=
 =?us-ascii?Q?hI1U1pGZy50vNU8tGTgd0Oe/RVYIEqOkuvKt5uZ30JSxZq4h3g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd190431-726c-45c8-1b45-08df41532c64
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 06:55:59.4959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

Simplify the driver by using the new regmap_reg_field_* functions.
regmap_reg_field_FOO is equivalent to regmap_field_FOO, but takes
a reg_field directly instead of a regmap_field.

Tested by compiling.

Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
---
 drivers/iio/accel/msa311.c | 298 +++++++++++++------------------------
 1 file changed, 106 insertions(+), 192 deletions(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index caf9b1b6397f..63c795d6bc99 100644
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
 
@@ -334,17 +282,10 @@ static const struct regmap_config msa311_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
-#define MSA311_GENMASK(field) ({                \
-	typeof(&(msa311_reg_fields)[0]) _field; \
-	_field = &msa311_reg_fields[(field)];   \
-	GENMASK(_field->msb, _field->lsb);      \
-})
-
 /**
  * struct msa311_priv - MSA311 internal private state
  * @regs: Underlying I2C bus adapter used to abstract slave
  *        register accesses
- * @fields: Abstract objects for each registers fields access
  * @dev: Device handler associated with appropriate bus client
  * @lock: Protects msa311 device state between setup and data access routines
  *        (power transitions, samp_freq/scale tune, retrieving axes data, etc)
@@ -354,7 +295,6 @@ static const struct regmap_config msa311_regmap_config = {
  */
 struct msa311_priv {
 	struct regmap *regs;
-	struct regmap_field *fields[F_MAX_FIELDS];
 
 	struct device *dev;
 	struct mutex lock;
@@ -410,7 +350,7 @@ static int msa311_get_odr(struct msa311_priv *msa311, unsigned int *odr)
 {
 	int err;
 
-	err = regmap_field_read(msa311->fields[F_ODR], odr);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_ODR, odr);
 	if (err)
 		return err;
 
@@ -453,7 +393,7 @@ static int msa311_set_odr(struct msa311_priv *msa311, unsigned int odr)
 	bool good_odr;
 	int err;
 
-	err = regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_PWR_MODE, &pwr_mode);
 	if (err)
 		return err;
 
@@ -472,7 +412,7 @@ static int msa311_set_odr(struct msa311_priv *msa311, unsigned int odr)
 		return -EINVAL;
 	}
 
-	return regmap_field_write(msa311->fields[F_ODR], odr);
+	return regmap_reg_field_write(msa311->regs, MSA311_F_ODR, odr);
 }
 
 /**
@@ -538,11 +478,11 @@ static int msa311_set_pwr_mode(struct msa311_priv *msa311, unsigned int mode)
 
 	dev_dbg(dev, "transition to %s mode\n", msa311_pwr_modes[mode]);
 
-	err = regmap_field_read(msa311->fields[F_PWR_MODE], &prev_mode);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_PWR_MODE, &prev_mode);
 	if (err)
 		return err;
 
-	err = regmap_field_write(msa311->fields[F_PWR_MODE], mode);
+	err = regmap_reg_field_write(msa311->regs, MSA311_F_PWR_MODE, mode);
 	if (err)
 		return err;
 
@@ -634,7 +574,7 @@ static int msa311_read_scale(struct iio_dev *indio_dev, int *val, int *val2)
 	int err;
 
 	mutex_lock(&msa311->lock);
-	err = regmap_field_read(msa311->fields[F_FS], &fs);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_FS, &fs);
 	mutex_unlock(&msa311->lock);
 	if (err) {
 		dev_err(dev, "can't get actual scale (%pe)\n", ERR_PTR(err));
@@ -734,7 +674,7 @@ static int msa311_write_scale(struct iio_dev *indio_dev, int val, int val2)
 		/* Do not check msa311_fs_table[fs].integral, it's always 0 */
 		if (val2 == msa311_fs_table[fs].microfract) {
 			mutex_lock(&msa311->lock);
-			err = regmap_field_write(msa311->fields[F_FS], fs);
+			err = regmap_reg_field_write(msa311->regs, MSA311_F_FS, fs);
 			mutex_unlock(&msa311->lock);
 			break;
 		}
@@ -863,7 +803,7 @@ static int msa311_set_new_data_trig_state(struct iio_trigger *trig, bool state)
 	int err;
 
 	mutex_lock(&msa311->lock);
-	err = regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], state);
+	err = regmap_reg_field_write(msa311->regs, MSA311_F_NEW_DATA_INT_EN, state);
 	mutex_unlock(&msa311->lock);
 	if (err)
 		dev_err(dev,
@@ -934,8 +874,8 @@ static irqreturn_t msa311_irq_thread(int irq, void *p)
 	 * specification it's cleared automatically after a fixed time.
 	 * So just check that is enabled by driver logic.
 	 */
-	err = regmap_field_read(msa311->fields[F_NEW_DATA_INT_EN],
-				&new_data_int_enabled);
+	err = regmap_reg_field_read(msa311->regs, MSA311_F_NEW_DATA_INT_EN,
+				    &new_data_int_enabled);
 
 	mutex_unlock(&msa311->lock);
 	if (err) {
@@ -995,8 +935,8 @@ static int msa311_soft_reset(struct msa311_priv *msa311)
 	int err;
 
 	err = regmap_write(msa311->regs, MSA311_SOFT_RESET_REG,
-			   MSA311_GENMASK(F_SOFT_RESET_I2C) |
-			   MSA311_GENMASK(F_SOFT_RESET_SPI));
+			   REG_FIELD_GENMASK(MSA311_F_SOFT_RESET_I2C) |
+			   REG_FIELD_GENMASK(MSA311_F_SOFT_RESET_SPI));
 	if (err)
 		return dev_err_probe(dev, err, "can't soft reset all logic\n");
 
@@ -1029,9 +969,9 @@ static int msa311_chip_init(struct msa311_priv *msa311)
 
 	/* Disable all axes by default */
 	err = regmap_clear_bits(msa311->regs, MSA311_ODR_REG,
-				MSA311_GENMASK(F_X_AXIS_DIS) |
-				MSA311_GENMASK(F_Y_AXIS_DIS) |
-				MSA311_GENMASK(F_Z_AXIS_DIS));
+				REG_FIELD_GENMASK(MSA311_F_X_AXIS_DIS) |
+				REG_FIELD_GENMASK(MSA311_F_Y_AXIS_DIS) |
+				REG_FIELD_GENMASK(MSA311_F_Z_AXIS_DIS));
 	if (err)
 		return dev_err_probe(dev, err, "can't enable all axes\n");
 
@@ -1074,30 +1014,30 @@ static int msa311_setup_interrupts(struct msa311_priv *msa311)
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
@@ -1105,33 +1045,6 @@ static int msa311_setup_interrupts(struct msa311_priv *msa311)
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
@@ -1152,9 +1065,10 @@ static int msa311_probe(struct i2c_client *i2c)
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

