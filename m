Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022128.outbound.protection.outlook.com [52.101.126.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BB363C7E;
	Wed, 25 Mar 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422410; cv=fail; b=qmIUe1C3q1PBW90Wv6ufBj/D/qMeTEpKll2w1/oDH5LuJ1dDdIYPAtYYrGjE9lzt7TfCOWUrJ0SKBHjUipO4VUKeCI9N+rcGgIIdZ8Ha7ztEuhTi2kfQuoXxQeNIa0I7cQrwMU3Qnt5g1JQo8GMMSnff6PFcgYIkT30V9TqPAjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422410; c=relaxed/simple;
	bh=ypQdPEUe0+Vqm+Yb7ZFauGX2FJj4/74O/LI5usEgLZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CIqflTWmD5fCDvvu/D5D1DNArkUy64gKiGK2WVGdWXt7tjo46uAFsAZ6GEGSoWEePUfUvXx+GK+yhM120gO6d4TviTUarWQp13qfb5vx4DLB79XQZq8oE/ilTNyGtkKIFdFSjti+3HpZbFJwmWZKAIPpfmI+zeBR4jmFiErNhr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com; spf=pass smtp.mailfrom=khadas.com; arc=fail smtp.client-ip=52.101.126.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khadas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khadas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdhuVMDBTGreCekkCG+f4z1/vZUbVujLFFyPH1KoqS5KC5PnbG07mcoihcoHx0+MG0kG8DP4U/PgwSPCwLmNwwF9G9NvaYCTDAUVXYqHG1S60AIRIClGTX3amB1LT7fYzAFAHu73oT5fm6rf9vLW3906dZ+iB0M6Uw7hmwQNi8h7xqA9RVYmO6DmAz4MO4dSrHldZzteF6JN/llbenemfM6BnmvKA2WrHaRrwaKExVaWUbpzyawUmclhOTuFVLdDBI/UoBgvHCmCSILKCoUUWoCJPNAsTzrZZfi3xFH4g/JsABlxYa2RbV5+UAza6SXYQP3uQiEW1Fwvc/mIXTxd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puorEd6yf3aPkBxx7SMwWJteiTaI4jhoauNxekAkl7g=;
 b=WPMbJia1LijdGqBJw1LlF1QeVbu68d/q0Hi8s7MbQndr0fLQWqznNwovfQCQehEw1MbBJxeAXwlgk/8IUehnEGKrVUFdLL1p+aV6zMLkaHPuchpXVl85BbY8FgvjA2PUlvPyj4WJJB14yTFfGqY0muAOvrZvqGKiTEE9/8+CpvRkVYd+DgHo3I/FlHiFH7HnqkqEwacRCbLntaamdCG5fH1B8nLloOPsyMdNRh9yDkBobimTls5XQ5fVTiI26LPTcTjwKZV23jok6a5lucXY2zYYjRv5JO6hlRUf8G0/nL+cWBTUwy34F/fc/jh4R+Uli4Js34y4R/MhoncPbP7vAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=khadas.com; dmarc=pass action=none header.from=khadas.com;
 dkim=pass header.d=khadas.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=khadas.com;
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com (2603:1096:308::2da)
 by JH0PR03MB7343.apcprd03.prod.outlook.com (2603:1096:990:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:06:38 +0000
Received: from PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549]) by PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 ([fe80::20a2:a696:ac88:2549%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 07:06:38 +0000
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
Subject: [PATCH v3 2/4] iio: adc: meson-saradc: add support for Meson S4
Date: Wed, 25 Mar 2026 15:06:16 +0800
Message-Id: <20260325070618.81955-3-nick@khadas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325070618.81955-1-nick@khadas.com>
References: <20260325070618.81955-1-nick@khadas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
 (2603:1096:308::2da)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF62EEA9B1D:EE_|JH0PR03MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 3176913d-5e2e-4b97-25e2-08de8a3d0ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AhFFlUFHZlj4l2SQZnnlKiVXqN1PSOf0mkUJJ+XIytTymRZgcjr1xHqc1NdthoqO3cbhdO2lVkuqnmvPzDzNGrBrmXD4YcqZLZInQeP+AvjXZ/DxSamMQUaN13duMGejqllu7d20A0WugrXLMWDMUr32J+wyP9zv3um001L1DQnX7KI4KokxIZm7BEfN0s5oUz4RzdzIQxwnjww72E3DuL6SfcJGde9OFGdA0zlssTKHmKxfCpnFnce4V8YwisT2wLQ3lkGPhgVQJH+xJEZnF2l4DWyKC9h4vmA29pW+hO3hd1pS6RoprSlj7gDk9RHUUwTit2SE2qxnkGbZSzKKhpf9EQrpVpvbo32IbmUcbyNL6s2K2g+7dt22zHVncHmk5NWrK/LQHMkJxpoAdmTawVRsQG+5TM7I8ha6GnvrCem1mFUFxZOY3sUZKaKYb47Miz8EPkZzrU+glqylbkmJvAE2tDD6qPPVOfH5r/DQUgvDyiByf4bue4QKOCINtyvWBDuLkcata39P8FXow04bRiWUaClCc2dLRrV5tqq8hOC31U1T2t0bjkb+lv4qCKC8yEHJNZhVLGRNEn22wRkKszFpjPIJYUvgGLZPNy5kpb8E1AkUDu50CqOvGEDpeFm2vjtICdD5gC9ycTEivfqjwmDCYIdW5B/CTm3lTOgUqa1sLBX3ykVRwXtD3k8qW32AxDwk6yo8CmIEhORROq2nl41j6fFsZgw52IbCasrPRw2cikj8SQ+pe4Wxv4shmxMTBHI29TUdbduBZ1j4h2Ey4aOJk3HOYHxnKaX+v5Hk9cU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF62EEA9B1D.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DOCivgJdByL+8m1Rc80vwbYmK14ms+7UsB6AHz/iQ1vxwltwzzh9iwmphCf5?=
 =?us-ascii?Q?u96pq23ILzGtMUHvHWTzHcrZQ1Jg2lmEJALYd1kLXqY7dTxAFAOSErlLaLIa?=
 =?us-ascii?Q?3EJ7iPO/pCdwORBtUVXQ6503HZGEgONBlX+YGccD8igzzkAnuUIAMtPk+R1H?=
 =?us-ascii?Q?Ln2MpHQtHUzei6FV2pMuftNO+I2mi0tZ9+pZaU513wCvV2ionwjXFLILvOrY?=
 =?us-ascii?Q?aEW/ZKVQQjag0goKN+j1XiYDgFfETwsblOx6K25LqYeXG0uO+Y9OXAMRuWmC?=
 =?us-ascii?Q?lxsjdVW9Ketjpg+8ES8vy2ZyHGQr9M895V+3A63krxiZNKe3ls+3NYiUWUme?=
 =?us-ascii?Q?WzqDOnwa88aA6VuLFC/4OXIAKq2aQOjvtZkJdZUyrOrkaMxaAk5P3cB0dlKR?=
 =?us-ascii?Q?6CRrWXPFk9tmjLy1lvluvPBKQSvev8/8ec7UuWtsEtPTG0AvtKK7u1+TzuHq?=
 =?us-ascii?Q?jXXFAl+5GDw/TzRXlFpUCP9iQq66YJd+Vzzg8AfdGVIGAVUpmx+Ofiy/ST1X?=
 =?us-ascii?Q?c+gWRGn79ddz1NAL/s5o8kfLUptk5wVj1qB7PTONN4PcIWGoqAfd72jChjAq?=
 =?us-ascii?Q?ch2PegfW0LUvtjd5H20oLrwu8wqdmMxjVZyF/4WbV9PvwivuzPBrWFQnjswF?=
 =?us-ascii?Q?u+tZhdcexopF2RN5iqOrGAuLieh9CGbUreCpRuzJv+XBBk99Px4HoJV2e83Q?=
 =?us-ascii?Q?9p5UfSbjEANtQko/TIGhTqCzA8ZEcM5a7WIA514/Su2MGv3+lofqWTihJOX/?=
 =?us-ascii?Q?ahKGLEq6rcqvjZv/bOEFOfSoM1Ptg0ea3uoTdz6DRxd4ZxjacyVhiYkrZNSd?=
 =?us-ascii?Q?+OOnEd3Xnovpjn5Pwuh3CAApaGay9SPNZ/ynHO1I7mKL4PM6dKEkCDEl0FLI?=
 =?us-ascii?Q?ec51tIILuOcQqhmWOFFqRFfhdV+TamFk+nAOC/wbQdvN1arPsH+EOBR05piQ?=
 =?us-ascii?Q?FRpJfeICSMHuK7A9DTZpOcVHDhAApIpN1t6U+YvMHVedvX3eoSerP1aMqQoR?=
 =?us-ascii?Q?TCx4qgR1+1XfvKL9Ickt0gepIUImMcTLVaxwXVGLMnWdhcLxVoS7m//p3fy+?=
 =?us-ascii?Q?prhysO+Lbj2IAe0vfCy2rIiFTlTNzQWgFZhVcUiT0Zl76V5flIgYtu/7k0Z5?=
 =?us-ascii?Q?wPJ2S6x6/GJb6UTRTjiRfHFLueaukZY8nZzEBVF6tbWTdII/aOnJu643soHL?=
 =?us-ascii?Q?KnwWrAEC0XdA3eC+ov1DH+WIOoKNu6pGYWG0s+5SlhHxv4IUXNRZOYnCjpuo?=
 =?us-ascii?Q?gmeojq3/s5KD9V7Ge9R4ZOE2tKL5ycQWewfaAmG6ApkveM/MOY+S4Hnt9a1j?=
 =?us-ascii?Q?fsXe5eG3phy0bxBQOC73cZsftZXNjd0Wp9AHrZCeg+8HJFuf44HwMDbWlKs+?=
 =?us-ascii?Q?fhhqrLy0loRJQ+RhnXOqgbLBvHksgrgLoe01rfLBVvQPDAXrp2y2AzefEwNY?=
 =?us-ascii?Q?HUa0I7voxqNJnOoBYccoZCVEPuZTxPjCZMaFe/qQcT84NftZBpC2Zexg6SrR?=
 =?us-ascii?Q?yoykj0ihbq4MBNeLlDM27ejrmf2e1w5KWLdFH/NHFLbFQn1AEcb5yuT/qbng?=
 =?us-ascii?Q?9v3IJOZk2JXVSpddTgrzF1bWP9oqJB32CcX8VDCkXO9laz/x/Co7EBkRRtX8?=
 =?us-ascii?Q?FOIJTvf5sEPiyghoU6yygcBTx/D1WQ5r61pH4Wq5zfglZcV82V4o4jz34uSo?=
 =?us-ascii?Q?bq5C84G9WSYeh4sNTc9hrkRh9uGZNiPH/WSWBh1jW8dJHaVK?=
X-OriginatorOrg: khadas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3176913d-5e2e-4b97-25e2-08de8a3d0ee2
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF62EEA9B1D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:06:38.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGWEAteNvt85bwnTIkpi0Xa8Ea+ppESv3Ubaaq3ah+KYAAgaOBweYBJQtYhWwx/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7343

Add support for the SARADC found on the Amlogic Meson S4 SoC.
According to the documentation and current testing, it is fully
compatible with the G12A parameter set, so we reuse
`meson_sar_adc_g12a_data` for this new compatible string.

Although the device tree fallback mechanism could handle the match,
a dedicated entry is added to ensure the userspace ABI correctly
reports the specific part name ("meson-s4-saradc"). This allows
userspace to accurately identify the exact device and maintains
consistency across different firmware types where automatic fallback
parsing might be problematic.

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

