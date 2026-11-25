Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626713;
	b=diJTiMUKATI1RaJtq7M48tyGb2I/dyREgDJoAzjOkvo5POInBjRP871TUqLShIljIplG
	 sHThekDEnttexFU4d0ZImdiZcm6ti7trScqPSbthp4IbYOdgg5lzU5ymrFTmUI5K3kXO6
	 HyChu+Z/WUMeYjE2APLf8l3LtcoKxxsL6diheJBroFQ759/cbFkHRsRI3ESYrI2jP3QA2
	 nd0RV/+8Z03fSoS4ZjIiMgixVU20jsJtqTNRhi72n+Fk2G2qs6NZvFP0DhXCTuFv5Rbzm
	 N8ka3URIcwqclaRg8ah5SQFjPDFJh3/F54YWNGkB+WyqB5N7fMno8WXNwWZQV8KYHXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626713;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PNRf00ZIYOeLn/+aeUz6iiql93RuriUiGR4O40rMTlw=;
	b=Va1uCGV/lQ/HBYpqCN3vqbDhs3fEpIcvcVJEGO/nytCnMQRcTZNdba13U1Wm0ksKK6Xb
	 NU+xjVO2oBB8/LqCSihO5WxZSlNgXr+chzGtQIDw/8hdXYoZQcvJbn2Bhp3N0bC0Iv5CQ
	 fCN2Bs9bzp4r88Aybu/ZFL5ZbH+/GPpZLxQH6Lb6x8w/KKbuluk6IrOUgJzlD0OAt3HxV
	 a6XKuejPQvpSWYhPUgi8Wfv2R8sXZFwgQHfVULe0E9NDR4w5FaPn9G45RJ/dpmiJCJlaL
	 yVz2w4t2/QwXxlyIA8zQGotROcp168mbK6IGRmYxmoNV+s9GA4TyI/MYU8mchx1KSRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JEHYsXu1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.26
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C57606A32C;
	Wed, 25 Nov 2026 17:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C57606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JEHYsXu1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUfiYuddLN2FcVyJ+biPf2IsZOsUCuCqEW4LmmF1AUTMzdU8vP7Qiy8d439uRghLOPrBfnaB0CnvidC1NQ23ug+eH+2Jsz1Fp0d0Vg+iY6egmopD9zS/iXfDk3I+3b4m4aSJkKqhKREIORhB09QZEInyVKF2MNfEh/vQYU5dcuFBXH1PjvSazTCWnR4XpcSUGA8KKRALj3RZbWytAvJi0zQmYk066+ptwPDPF5cl52gx9I9oytXh4/kbnUH9RIm8Qhx+oeIJeGOkS6T47N2oOBZQ8aSBCAmk2K1+vQrFEHaqaPMOgFemspVv9D+nELYEaGUM0uBjEJJhGF/43W5HQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNRf00ZIYOeLn/+aeUz6iiql93RuriUiGR4O40rMTlw=;
 b=stEZ0SeAhyXctWONssF74DaygTbKs4LBo/ow+PhC8a447RNzhSHBKEt7Dw/klmjzBGp8Nx48UHnTlfOTvON9x5ZRbO9l6zykwPDYewvcJudgWnOQsiPrH97sSAu9ssHqZ43J2kS0BX/OUGSoghkbmL+a3lV6G9DDBtWPVi0che5Ep9wymajqAHQsgi7NBS387e6WlJKbBzYa4FCNlqqvLTDBu1odAh4rbUaSKpa6suoEAuQL1BVQB9nAAhDfcR6Vi/R/lvO6Tkh5e0b0T70z6KNz28RCDZ+0sgK8i1aOgP0cWWnCBHpYYeQt/O6XBhe9HJe/wwUN8k9BsXhXgDPQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNRf00ZIYOeLn/+aeUz6iiql93RuriUiGR4O40rMTlw=;
 b=JEHYsXu1XOC2gv1ddPCysyeJVeZZ6mzx+xR51ETTKFrT5j0pGdEJgkronXkk4pCbq+cd9riIhL3THg56+VQRf+IQmWpLCn4etvt2NAKnKoPqJ08g69QF4TL/qKwslwHEx1C7K8l0BqtyPPr/BihBS6zcgSKZ+4tE5zvrOZXsIzE=
Received: from PH7P220CA0102.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::12)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Wed, 25 Nov
 2026 17:11:47 +0000
Received: from BY1PEPF00026968.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::f) by PH7P220CA0102.outlook.office365.com
 (2603:10b6:510:32d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:11:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026968.mail.protection.outlook.com (10.167.244.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:11:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:46 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:45 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:42 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v6 13/16] iio: adc: xilinx-xadc: Add helper functions for the device setup
Date: Wed, 25 Nov 2026 22:40:27 +0530
Message-ID: <20261125171045.1246381-14-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
References: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026968:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: ad405d9c-6d9d-471c-a39c-08df4b173046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|22082099003|18002099003|11063799006|261028144727099003|56012099006|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	meu9+qC6NrOiAqx1d1vbkvxUvQ6bq8ohTZ8LdzI8loxNY7UfvTo6Mc5Gi5IYrIsQmSq6OuriI9oLhpHewmR0k8ZH062XsbNx4rFR84eR+vRBv5lPMELXZjM5mOueX1EjPIcpBKERXpWoCC5Al0cB0vPV96hIXRmuwkGLDRwYs7yGfD2eUwVjhcL1cE+yli53JWx1gJoTXUBlg0bzRSrjAGCiGvK2q6prXuN1crj1c+U1KAeXawcWwGtRYVEuydn7su5N6gQw0kAsJF39mwDA/lsMq9fXJIXeqQv2nTsjULZso6S0YQ5S1edzmASwSdSyzYlsQQJvTNVvo+MJZM5Zfb8jFFPlcYPKQt3Zqcbw+ofLiD+/zjMaQV2Z+WeuUnpj8muXidSZPvbDwV0Psj2VnfP0Tc4rvtucsludng17vRZnPEMTlsBldLBenhANydGjiaytTXtoK9RDyI87ihgoMrgsL00iczPnx1JiWcMTvk0ln5IhJBI7UB76u6dDmf7tENB+iWzK2qkPDckpddiMgs2radO3oqRLmW4Eowmf0GG6MmIDMWfFNPIblnlaN3sV9BRN2jWoF+rsC5eYJubjU90+Lz1bKChvuRJ5/o2MIX/7JZ0Qey2gt3CGeD/gb5CHNV5qPW27CPbD0IBwntvrx5I3T9ueGKwSA6mOLMG5KWv9HzbrpRodPn4nNpBMTZ2t7uhTZjeMpeEe/BIL56UFDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(261028144727099003)(56012099006)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0P3phCljFKrsi7IlV+rJDPtiZlnvsswLtuPaiJxV3y1cqdb1PJ1OM5UwAqYTtJYid13SmD8rCHL7y9UsyXYVkCBb/F+AiY+SnkriaT/CuIBcFZK1ws0Qy27xcZ3cziF49BBDHXcwV5WnTcinzd+tRe4j6su+lll9xkfqkz1QvB9eGb5DwVIwmNgjUBWr5aWE/n/c5O7m4dlT6t8bKJu9IOxL/3ba2T6q36+ujoWwgUePFj/vEN/BHFvsYDZVxvwWfgOIB4RL4RLaeGHQp5zkvig5F8MwaECmdqASGVYZ0lEDSFeeaIOnEFR3PzfHQrYejYoqez3cvxdlmNdRo6pICBoC92mAuzlBTPmRPQMxLmhuZkDdT477Jt8mGCHhBQzlgBcVmu6zfeqNYYxktoWBrhtpJekFxbpiCyELyXE5v4Yuo7A5EisHbt5TY8hGujQA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:47.5397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad405d9c-6d9d-471c-a39c-08df4b173046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026968.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

Refactor the platform driver probe function by extracting device
setup and configuration logic into reusable helper functions:
xadc_device_setup(): handles IIO device allocation and basic setup
xadc_device_configure(): handles device tree parsing and bipolar mask
configuration

Move the bipolar channel mask calculation immediately after
xadc_parse_dt(), as the channel information used to build
the mask is populated there and remains unchanged before it is consumed.

This refactoring reduces code duplication and prepares for sharing the
common setup logic between platform and I2C drivers.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 115 ++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 8463b6268c89..60aa4e6ef52d 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -899,7 +899,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		val16 >>= chan->scan_type.shift;
-		if (chan->scan_type.sign == 'u')
+		if (chan->scan_type.format == IIO_SCAN_FORMAT_UNSIGNED_INT)
 			*val = val16;
 		else
 			*val = sign_extend32(val16, bits - 1);
@@ -949,6 +949,34 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct xadc *xadc = iio_priv(indio_dev);
+	int ret;
+
+	if (!(xadc->ops->flags & XADC_FLAGS_BUFFERED))
+		return 0;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
+					      &xadc_trigger_handler, &xadc_buffer_ops);
+	if (ret)
+		return ret;
+
+	if (irq < 0)
+		return 0;
+
+	xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
+	if (IS_ERR(xadc->convst_trigger))
+		return PTR_ERR(xadc->convst_trigger);
+
+	xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
+	if (IS_ERR(xadc->samplerate_trigger))
+		return PTR_ERR(xadc->samplerate_trigger);
+
+	return 0;
+}
+
 static int xadc_write_samplerate(struct xadc *xadc, int val)
 {
 	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
@@ -1036,7 +1064,7 @@ static const struct iio_event_spec xadc_voltage_events[] = {
 	.num_event_specs = ARRAY_SIZE(xadc_temp_events), \
 	.scan_index = (_scan_index), \
 	.scan_type = { \
-		.sign = 'u', \
+		.format = IIO_SCAN_FORMAT_UNSIGNED_INT, \
 		.realbits = (_bits), \
 		.storagebits = 16, \
 		.shift = 16 - (_bits), \
@@ -1056,7 +1084,8 @@ static const struct iio_event_spec xadc_voltage_events[] = {
 	.num_event_specs = (_alarm) ? ARRAY_SIZE(xadc_voltage_events) : 0, \
 	.scan_index = (_scan_index), \
 	.scan_type = { \
-		.sign = ((_addr) == XADC_REG_VREFN) ? 's' : 'u', \
+		.format = ((_addr) == XADC_REG_VREFN) ? \
+		IIO_SCAN_FORMAT_SIGNED_INT : IIO_SCAN_FORMAT_UNSIGNED_INT, \
 		.realbits = (_bits), \
 		.storagebits = 16, \
 		.shift = 16 - (_bits), \
@@ -1235,7 +1264,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 			continue;
 
 		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
-			chan->scan_type.sign = 's';
+			chan->scan_type.format = IIO_SCAN_FORMAT_SIGNED_INT;
 
 		if (reg == 0) {
 			chan->scan_index = 11;
@@ -1272,6 +1301,39 @@ static const char *const xadc_type_names[] = {
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
 
+static struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type)
+{
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, size);
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev->name = xadc_type_names[type];
+	indio_dev->info = &xadc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return indio_dev;
+}
+
+static int xadc_device_configure(struct iio_dev *indio_dev, int irq,
+				 unsigned int *conf0, unsigned int *bipolar_mask)
+{
+	int ret;
+
+	ret = xadc_parse_dt(indio_dev, conf0, irq);
+	if (ret)
+		return ret;
+
+	*bipolar_mask = 0;
+	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].scan_type.format == IIO_SCAN_FORMAT_SIGNED_INT)
+			*bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
+	}
+
+	return 0;
+}
+
 static void xadc_cancel_delayed_work(void *data)
 {
 	struct delayed_work *work = data;
@@ -1293,15 +1355,19 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ops = device_get_match_data(dev);
 	if (!ops)
-		return -EINVAL;
+		return -ENODEV;
+
+	indio_dev = xadc_device_setup(dev, sizeof(*xadc), ops->type);
+	if (IS_ERR(indio_dev))
+		return PTR_ERR(indio_dev);
 
 	irq = platform_get_irq_optional(pdev, 0);
-	if (irq < 0 && (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
+	if (irq == -EPROBE_DEFER)
 		return irq;
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
-	if (!indio_dev)
-		return -ENOMEM;
+	if (irq < 0)
+		if (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL))
+			return irq;
 
 	xadc = iio_priv(indio_dev);
 	xadc->ops = ops;
@@ -1314,30 +1380,13 @@ static int xadc_probe(struct platform_device *pdev)
 	if (IS_ERR(xadc->base))
 		return PTR_ERR(xadc->base);
 
-	indio_dev->name = xadc_type_names[xadc->ops->type];
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &xadc_info;
-
-	ret = xadc_parse_dt(indio_dev, &conf0, irq);
+	ret = xadc_device_configure(indio_dev, irq, &conf0, &bipolar_mask);
 	if (ret)
 		return ret;
 
-	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
-		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
-						      &xadc_trigger_handler, &xadc_buffer_ops);
-		if (ret)
-			return ret;
-
-		if (irq > 0) {
-			xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
-			if (IS_ERR(xadc->convst_trigger))
-				return PTR_ERR(xadc->convst_trigger);
-
-			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
-			if (IS_ERR(xadc->samplerate_trigger))
-				return PTR_ERR(xadc->samplerate_trigger);
-		}
-	}
+	ret = xadc_setup_buffer_and_triggers(indio_dev, irq);
+	if (ret)
+		return ret;
 
 	xadc->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(xadc->clk))
@@ -1383,12 +1432,6 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	bipolar_mask = 0;
-	for (i = 0; i < indio_dev->num_channels; i++) {
-		if (indio_dev->channels[i].scan_type.sign == 's')
-			bipolar_mask |= BIT(indio_dev->channels[i].scan_index);
-	}
-
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
 	if (ret)
 		return ret;
-- 
2.34.1

