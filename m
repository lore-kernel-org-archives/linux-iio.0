Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021077.outbound.protection.outlook.com [40.107.130.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E7306D26;
	Wed, 24 Jun 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288106; cv=fail; b=SVIEE6YKG/eyGeZuX+FtN5hJ32dsFaO6fcQwdKhJa4QJSapLCUi9E5I0e07JAfV7lelNQmPLwtIiJqMnNMUdwixWljQUrjwhIRTKAtZwYrOg57c6tf9Lb+RRZNakU1BTHNuxKqxAlpbIyffiVN2WTNuoOdFFYrBCA2sSB9BGNWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288106; c=relaxed/simple;
	bh=NDxYbxpjYh+36RJfL1oTDFOxYK/sSPDu4OxFgwD1bX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tC+H0sixJVB2BLBqP7vcoPdXXKU6yAGHWRR0CDBVuvQjmNSXeP7CPxSAzJpn75J6c2+CTqUFxlytpx8l9HAy+fEypZn8PowqrwjmYH+1W2U+b6NaVulX+kpNmiHLM6FFziQ6Ksd7rj2pmqsIp7ROXeXx9HkLEqw5He4OlaK+Rbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=cSLxRzHn; arc=fail smtp.client-ip=40.107.130.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="cSLxRzHn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVSomQNHOjEexJ8PLgGj9cPMjDhN0Rq84846sZpLkXqi6lTywPSj3I0ncrHss5CGq9vQinEM9N1mrh7T1XMgiIY385VF9/2NL0QcoIvOG9RhcvPsYHdO+meGMM0hWJemxJPR/6GekWgNLBFerV/8At1PHQlPttBnyLQdxYZ6QGBTXE96U73GgQuEjz0JvHWiRbymsfPfn9D9vQSGfVxNKgx61b2zv7QP0lZ3BbNB+qIrDFP58d5VMriVund85NsKP7qCsEu3V20uzUVky4ZOtdjwsNCrML6qT/rV7Q0TsiAdnbXnv76FMTMDd/DpeDPcUUFqTrXJ/+6ZX0M5EMHiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiHFOAVKgOSfhfNbvpycZf0TsEIx/cbxshZa2uJLISc=;
 b=MxzkahA1nvo6xDH6Lk/Rn/Cutx7BAUps86lDfey8HW/EPivuPQOvVuDFLAfZDTju9kKJwyRWEpkNarXXUndtLaoPjDPdOdPUEauY/8Wr1fx6NitKyVJS5/yKbcPptYnQThH6GfDwxzceEuzJAeylc7z6aLKbCc6fA4XuwXt49Lu+2ZnNx0u2MSBG5PcniarPzzL8CiirOjvPNRhwDuQ+fqAP+hO8dFOuju4kLWpi1GwmU3EbOxZngwGdH8Nz5p2G9pl7HiCoPGIWnA7AAnmDrq66pbZv1yZbWdp5qbG1fSnx+3kcxyTiQm7BbdpCAEPSx+HoFERwMeV4yPUpjxR81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 109.94.150.189) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiHFOAVKgOSfhfNbvpycZf0TsEIx/cbxshZa2uJLISc=;
 b=cSLxRzHnEZou9QeRIRXOmusZHlNnRdH22jWFLK2ACzHIIxJeeuzg4uY0ODovFYHeLDs8UeJddeOCrzyEA869jpY+kPgV1UiAhogwg7p/vruS2k3glwi0h6+9YQKlhX11Gr09RT2MXw/ABJB5sEg+6sRbLPWDlGuB7+OI1qQLfXs=
Received: from DUZPR01CA0118.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::29) by DB9PR02MB6683.eurprd02.prod.outlook.com
 (2603:10a6:10:21d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 08:01:39 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::46) by DUZPR01CA0118.outlook.office365.com
 (2603:10a6:10:4bc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Wed,
 24 Jun 2026 08:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 109.94.150.189)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 109.94.150.189 as permitted sender)
 receiver=protection.outlook.com; client-ip=109.94.150.189;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (109.94.150.189) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 08:01:39 +0000
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 24 Jun
 2026 10:01:37 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.2562.43
 via Frontend Transport; Wed, 24 Jun 2026 10:01:37 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1wcIYD-00FOng-2o;
	Wed, 24 Jun 2026 10:01:37 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tobias.sperling@softing.com>
CC: Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: [PATCH v3] iio: ti-ads7138: Disable STATS_EN bit while reading conversion results
Date: Wed, 24 Jun 2026 10:01:31 +0200
Message-ID: <20260624080131.3669357-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|DB9PR02MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fffead6-3f05-46e9-6e78-08ded1c6d20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PrjOSGbtGWmR5bIbZIqYrzSNDJeWc4pQLugrqJU50EyRbr1iFSli+m9JscrIm/puOyYZNA0BQ/Y9OebBBlVZxuBWoCeGIFznKO4ri/waZQ8gVtO2QxkqtjOVcjoPUeIl7Pf7ACMDCUdlk9lrmBt1KCcmXqnD0TqTzHU4zzt+O0ji3i2nToMQaSN6iNOtIlc+7PlagSX5XoyfYlfrT9NOW6SXSqJMMx8YQj+Dw/6Wcw3rO/wmZnr5LxXkNGmI/mNVIHnFob2yRq7rI+Ug7VWe0qpTCoRIuVv6YeVld44RMAKv/4TEKiQFyTlSt5ki6vQmo2X5vzeBsMJbZHrq+DQVqKo0hIWo4Vz7CVyA1tB/pskEbCHq3xjbtwIA5SlztNlUJpDeHro8Mny9bPFXLzuN+pbmmkud9ldPk3/ctbGOj0wSS7BQ6bI3o1/gcbF4tKuTHYiOdCDfjikWRd0Gm0D27IpLlsT7dLj7mcQ1yJh3KyIx4W9qUd0gIrzWjY+i+KdSKsIDvrRqtPEQNUrEHf/rvZKm1ET9LpygGodPfbwKq/3rAI/swHl6R4tAROa4idsp2ZPDj4O+sVCTXzdXwb928ydys8UcZTsM5xD1XrfVdxpusoERFYYLa6OgizVcm2s/tClJNvxmARZtFFWxZa+n2ExeUwu97W3zGmwqWRG7863lfDSpY9UXHg3PjyzHT/H83gxV1qGDadEoMx1f4g90aw==
X-Forefront-Antispam-Report:
	CIP:109.94.150.189;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.prodrive.nl;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VScU9/b22Th2/5vJw+1hm8idENcOl41PpIB4JcfJAHzAtMygYq7IetY7V6ihljhzTQXQ8qQ+STznPSyv9X7kub1rZdPuDEtmoGBqn4aJUwRRJXk2PQoiXbdCT7IxRpLbJslMqprLNgKrJIWqtLP/gal/cQeWfov9rNWEF+pH8FEeEcmBnM7a13a9kcaP8ez2JP9rpKdwo60nhqy1rkxnovzyuXyTbovnFSUdHgT/rX9zGiWhC1lz6dI8PLByeOQ6BTlXTGNtxIqmXsChfMVg+Bdw316MPP3OFF32dQBGCpW/RsgeMlBfEgSa4fXXKLrH4uKbdgX51dOqjNyCcPYxlVaW5zGXig8yeMrDGLzcV9iTjQPOZDRqHNGSe8SNgY87Vlung/WCFixzmVeeYdLQmSTtFIkokIYuJnY64XOaeQ/pGwlRbi03/c+TP75lBA+9
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 08:01:39.0492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fffead6-3f05-46e9-6e78-08ded1c6d20d
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[109.94.150.189];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6683

There is a data race in reading the STATS registers, resulting in wrong
data being read. When the data in the RECENT register switches between
0x24F0 and 0x2500, occasionally value 0x2400 or 0x25F0 is read. This
happens when the value is updated inbetween reading MSB and LSB.

Disable the update of the channel stats before reading the values, for
registers MIN, MAX and RECENT.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")
---

V1 -> V2: Checked return values and prefixed iio: in commit msg
V2 -> V3:
	- Clarified commit msg
	- Disable STATS_EN for MIN and MAX too

v1: https://lore.kernel.org/all/20260619075646.4100193-1-paul.geurts@prodrive-technologies.com/
v2: https://lore.kernel.org/all/20260619090004.355053-1-paul.geurts@prodrive-technologies.com/
---
 drivers/iio/adc/ti-ads7138.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
index ee5c1b8e3a8e..3e7b87d1a18a 100644
--- a/drivers/iio/adc/ti-ads7138.c
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -236,30 +236,63 @@ static int ads7138_read_raw(struct iio_dev *indio_dev,
 	u8 values[2];
 
 	switch (mask) {
+	/* Reading the statistics registers reinitializes them. This is unfortunate
+	 * but necessary to prevent data races
+	 */
 	case IIO_CHAN_INFO_RAW:
+		/* Disable statistics update so the value is not updated mid read */
+		ret = ads7138_i2c_clear_bit(data->client, ADS7138_REG_GENERAL_CFG,
+					    ADS7138_GENERAL_CFG_STATS_EN);
+		if (ret)
+			return ret;
 		ret = ads7138_i2c_read_block(data->client,
 					     ADS7138_REG_RECENT_LSB_CH(chan->channel),
 					     values, ARRAY_SIZE(values));
 		if (ret)
 			return ret;
+		/* Enable statistics update after read */
+		ret = ads7138_i2c_set_bit(data->client, ADS7138_REG_GENERAL_CFG,
+					  ADS7138_GENERAL_CFG_STATS_EN);
+		if (ret)
+			return ret;
 
 		*val = get_unaligned_le16(values);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
+		/* Disable statistics update so the value is not updated mid read */
+		ret = ads7138_i2c_clear_bit(data->client, ADS7138_REG_GENERAL_CFG,
+					    ADS7138_GENERAL_CFG_STATS_EN);
+		if (ret)
+			return ret;
 		ret = ads7138_i2c_read_block(data->client,
 					     ADS7138_REG_MAX_LSB_CH(chan->channel),
 					     values, ARRAY_SIZE(values));
 		if (ret)
 			return ret;
+		/* Enable statistics update after read */
+		ret = ads7138_i2c_set_bit(data->client, ADS7138_REG_GENERAL_CFG,
+					  ADS7138_GENERAL_CFG_STATS_EN);
+		if (ret)
+			return ret;
 
 		*val = get_unaligned_le16(values);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_TROUGH:
+		/* Disable statistics update so the value is not updated mid read */
+		ret = ads7138_i2c_clear_bit(data->client, ADS7138_REG_GENERAL_CFG,
+					    ADS7138_GENERAL_CFG_STATS_EN);
+		if (ret)
+			return ret;
 		ret = ads7138_i2c_read_block(data->client,
 					     ADS7138_REG_MIN_LSB_CH(chan->channel),
 					     values, ARRAY_SIZE(values));
 		if (ret)
 			return ret;
+		/* Enable statistics update after read */
+		ret = ads7138_i2c_set_bit(data->client, ADS7138_REG_GENERAL_CFG,
+					  ADS7138_GENERAL_CFG_STATS_EN);
+		if (ret)
+			return ret;
 
 		*val = get_unaligned_le16(values);
 		return IIO_VAL_INT;
-- 
2.39.2

