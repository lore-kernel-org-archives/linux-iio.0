Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023113.outbound.protection.outlook.com [52.101.83.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98E3C8C68;
	Mon,  6 Jul 2026 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324119; cv=fail; b=sdlKHNiBj1x/o/ORZYbWo7bnqzBzL1HT6Wqy/SmK2lqr54wjdrp20DdW0y5uLov5iwao/HumwP26KD1AD7pnn38rmyLKgqbp12h51sV7CUldvWXDbw0dxu82NYfun/tRdxJBh4NXwSYHxUQhzTx6MtIyVdOX34Xpdia9MiU76s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324119; c=relaxed/simple;
	bh=vxsY+R8rpKu0J2QyoZA5Qbee4gEdxMb7EBoNkE/7pII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkDgDg09/00aBbAlwKKOgyTzIGgMIj4sk210YHWlqxsCbGDksUxe4ZtmE7wm/AdNYH7+zewbOM1gvZJAO1O9+JlcuxM/zxlQlyAsSnBdgrDE8S/IKtKiR7QfBeBZNnofnx9fsphR+q+YKQIaciGSNztf9m2yOeRjorH72zL1dJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=nDtbeb72; arc=fail smtp.client-ip=52.101.83.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="nDtbeb72"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/8Zj51E8j9F6fNeQTjew8N4lMFWdFrZlqT2Hnip+xOUn0rPPkotncL0auCC7mZDUaCHEwSc6Fk2ZcJ9mWNaD64gut+TKg5M3X5R4I/SwjmyF1Ep0l7cY0ztPG2UUQwGzIG3JFzOP5w+orTe2ilD8WFiaiEJZ3DU+9j2l/fr7zJwHAsJau6tCG+O5+aGCdWqzN+9CRh+TCOGwxstmwGJaZh4fx5V75LZrypFpGPDGH11nCoWBawzEZPQSx7HaBIhdbUFkaJEvnpi9c14eXluW86+qk9bvkVS9oyge+n/sih/biwFnfR70rKvk3/asvJpmoHWm4X6YJLb5mhFWW5QVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUT1HBNXhUmJ+pcq7qH5j1j1c4fl0IjYVDovdNZiOFw=;
 b=dvwhvfRa3IIZibKKPELLaiwr4JJ0LBwqZ32pqTwRDfijP9VdRNe5xJM52wxDICxxu9NjZHWOyFDf/p2hsBKys6Hu8Bv2id6wSIqbWdUoyStpn8sWFuMGE0Lox8HzEWTbw+d7nAQSlmoShD/FDKKLculq714CTpzwbnAdj9gHkF44vZMtvyWm3cqHdcLY4IfVtncNDYqF+ZWcxTKnzHgmGMpucWcskYngYq3HxkaMEHopBps9ELdWP+vKBw0jyU7aTal05mAS5yZlka3TIKQQY1dyS64AHi5vzGpbvMsXceKvQOjWtW18Ogg25ppgbk8d2pawoYpqHh0qkJKQGmN7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 109.94.150.189) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUT1HBNXhUmJ+pcq7qH5j1j1c4fl0IjYVDovdNZiOFw=;
 b=nDtbeb72TsSBQX9Gw1woeWT/3Mqr4Ru61GHe33Qzb09T/DzANGRH2hrmBKALvum61B+6BNQFnRHPLQfqVvFbhO4DqR/qSjQsW8PqZPL7yW8XKaSr3IUysFQMEgEe78hKxCEO4+CbszjyZ5llv/EnXy/EyeUbcVfauqqftqJtjRE=
Received: from DB8PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:10:110::39)
 by AS8PR02MB9934.eurprd02.prod.outlook.com (2603:10a6:20b:619::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 07:48:21 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::8) by DB8PR04CA0029.outlook.office365.com
 (2603:10a6:10:110::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 07:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 109.94.150.189)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 109.94.150.189 as permitted sender)
 receiver=protection.outlook.com; client-ip=109.94.150.189;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (109.94.150.189) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 07:48:21 +0000
Received: from EXCOP02.bk.prodrive.nl (10.1.0.91) by EXCOP02.bk.prodrive.nl
 (10.1.0.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 09:48:10 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP02.bk.prodrive.nl (10.1.0.91) with Microsoft SMTP Server id 15.2.2562.43
 via Frontend Transport; Mon, 6 Jul 2026 09:48:10 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1wge3m-0003j8-1v;
	Mon, 06 Jul 2026 09:48:10 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tobias.sperling@softing.com>
CC: Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: [PATCH v4] iio: ti-ads7138: Disable STATS_EN bit while reading conversion results
Date: Mon, 6 Jul 2026 09:48:03 +0200
Message-ID: <20260706074803.13624-1-paul.geurts@prodrive-technologies.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|AS8PR02MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: e9da1fb0-8d77-4df8-e1b9-08dedb32f36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|13003099007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Sicf9g2GMMHheop7kWcstgR3qXjVfsBTtp1PCA/Na8fcPmdIDnl97G1RPcpGxRRLZlIIsgyM5rfKYMBIYrQepx3piSg6Nghe5fLFHlNOhA4PAwHgMm6lKYFd2/z3GZVmyuFsrZ2IViGHNtJtXVBC3DpmVi0QiX/hPFpUCtl5tSAm5hns+SnV3L8V1W2SkCF0QiuqjpueJFWChHJDDgp7g9BAbby7ZUATiW3QpJojib6ZTRlgp+PjaI74zWIUAxlYC7y9gKR+RRt2DlAK9gnIva/5jClY9NK56a3S1G+pPkVjRbt9Af7loT2J65BaINA7y9PKs5UUdPJTvZ5hveRkgZAUlQjzV/DrYMZGmigizX0/yDA/5pBJl4BLkho0g9Lo5fBGHa1tvnrJfHvX55h4HvHxEIYLuL0ihHr/Sccvbe7iQjVqaLvcdnBKyk1c4A/p6XMRGAJNc9jAuBpJUwgBJGMjoOfD2klCAQJ6I67XrgHkTq4uNsksDxJhvlN57XfPY5zwln+Hu9itBGyRmnPG/7FY3KTz80It+kcsEnyJBe1zUrQnElu0xNbaqZBfpngG0MB9thMdyjMKzip26pj5LmgETGjq9r4g4HVskN6D2YW2WEbhR7eyByMtO6f4OGmy1OJAuYeumoA7zMexZYDrIiQ6tlGHiap8YHLNrpHWIX4qGYePJ0Fv2luWwHm5NIDa2ULJNVAUwcG2dI6jDH1SDA==
X-Forefront-Antispam-Report:
	CIP:109.94.150.189;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.prodrive.nl;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(13003099007)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eFQ70cfDWfShmmTTtN5vadEzVsMogiLbxfokOJWJ2EzvqLMLaLThFiS9unUYWsJW0lY4F//5hLAZOtLNLvm4qoK9MvA4Cz0+8xLbziAw4H572nlORKwKpuRNJgFwDWMHoCK0/kt1cG7ZRx0FMW83W0IjrgKdesEK9npxM9wBiV8SxehZHpnj4cV6JUZOxzrDLoUVQotsxHugwM90J018gQ4zlXRN42I8mMlFDW3YNluDNvoFUN0i/fB0zTcOWGE0GE8Iotl5/xj/Jn5/Ji+rc0uGwxV1E1Xxmw0QTAxFMljBaTE2CVROc9+EcWOwCpg9J2u0zW3+fGBozatq1Qn74XJRgVMQhdfW0M7EtnHVETkAtBuqRiItw/jEtulUpSDFklhVAhIuj0yU9++aeEv52jQr5bzH546gNXvks/zi5Wz9YtVL91Rvs0pZJoNPidsp
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:48:21.1345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9da1fb0-8d77-4df8-e1b9-08dedb32f36a
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[109.94.150.189];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9934

There is a data race in reading the STATS registers, resulting in wrong
data being read. When the data in the RECENT register switches between
0x24F0 and 0x2500, occasionally value 0x2400 or 0x25F0 is read. This
happens when the value is updated inbetween reading MSB and LSB.

The datasheet says: "Until a new conversion result is available,
previous values can be read from the statistics registers. Before
reading the statistics registers, set STATS_EN to 0 to prevent any
updates to this register block." As the STATS_EN is currently not
cleared, the values of the stats registers might change mid read,
giving faulty values.

Disable the STATS_EN bit before reading one of the stistics registers to
make sure the device does not update the register mid read. This is
applicable to registers MAX_CHn_xSB, MIN_CHn_xSB and RECENT_CHn_xSB.

This means reading one of the statistics registers resets the MAX and
MIN registers. This is unfortunate, but necessary to get correct data
from the device.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")
---

V1 -> V2: Checked return values and prefixed iio: in commit msg
V2 -> V3:
	- Clarified commit msg
	- Disable STATS_EN for MIN and MAX too
V3 -> V4:
	- Clarified commit msg more
	- Reduced code duplication by creating a statistics read wrapper
	  around read_block

v1: https://lore.kernel.org/all/20260619075646.4100193-1-paul.geurts@prodrive-technologies.com/
v2: https://lore.kernel.org/all/20260619090004.355053-1-paul.geurts@prodrive-technologies.com/
v3: https://lore.kernel.org/all/20260624080131.3669357-1-paul.geurts@prodrive-technologies.com/
---
 drivers/iio/adc/ti-ads7138.c | 40 ++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
index af87f5f19a0f..14096bf3373a 100644
--- a/drivers/iio/adc/ti-ads7138.c
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -227,6 +227,25 @@ static int ads7138_osr_to_bits(int osr)
 	return -EINVAL;
 }
 
+static int ads7138_read_statistics(const struct i2c_client *client, u8 reg,
+				   u8 *out_values, u8 length)
+{
+	int ret;
+
+	/* Disable statistics update so the value is not updated mid read */
+	ret = ads7138_i2c_clear_bit(client, ADS7138_REG_GENERAL_CFG,
+				    ADS7138_GENERAL_CFG_STATS_EN);
+	if (ret)
+		return ret;
+	ret = ads7138_i2c_read_block(client, reg, out_values, length);
+	if (ret)
+		return ret;
+	/* Enable statistics update after read */
+	ret = ads7138_i2c_set_bit(client, ADS7138_REG_GENERAL_CFG,
+				  ADS7138_GENERAL_CFG_STATS_EN);
+	return ret;
+}
+
 static int ads7138_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -236,28 +255,31 @@ static int ads7138_read_raw(struct iio_dev *indio_dev,
 	u8 values[2];
 
 	switch (mask) {
+	/* Reading the statistics registers reinitializes them. This is unfortunate
+	 * but necessary to prevent data races
+	 */
 	case IIO_CHAN_INFO_RAW:
-		ret = ads7138_i2c_read_block(data->client,
-					     ADS7138_REG_RECENT_LSB_CH(chan->channel),
-					     values, ARRAY_SIZE(values));
+		ret = ads7138_read_statistics(data->client,
+					      ADS7138_REG_RECENT_LSB_CH(chan->channel),
+					      values, ARRAY_SIZE(values));
 		if (ret)
 			return ret;
 
 		*val = get_unaligned_le16(values);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
-		ret = ads7138_i2c_read_block(data->client,
-					     ADS7138_REG_MAX_LSB_CH(chan->channel),
-					     values, ARRAY_SIZE(values));
+		ret = ads7138_read_statistics(data->client,
+					      ADS7138_REG_MAX_LSB_CH(chan->channel),
+					      values, ARRAY_SIZE(values));
 		if (ret)
 			return ret;
 
 		*val = get_unaligned_le16(values);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_TROUGH:
-		ret = ads7138_i2c_read_block(data->client,
-					     ADS7138_REG_MIN_LSB_CH(chan->channel),
-					     values, ARRAY_SIZE(values));
+		ret = ads7138_read_statistics(data->client,
+					      ADS7138_REG_MIN_LSB_CH(chan->channel),
+					      values, ARRAY_SIZE(values));
 		if (ret)
 			return ret;
 
-- 
2.39.2

