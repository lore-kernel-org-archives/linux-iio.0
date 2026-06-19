Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020084.outbound.protection.outlook.com [52.101.84.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C635F182;
	Fri, 19 Jun 2026 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859616; cv=fail; b=dSXE+UDqebPIBrvCYzTcqcIWIgH9tJu2oFvvwMM/a7vZz5jIhyW9nGAqqkhjwgehwRsXvA7U5KrJ3IkauyBk0yNufLrCV+8reCIJQcVPXzDU8K4To5HFLpZYfAUN0WXj7G4cHwLGtWrtbqT93mj3zzrEnx72hx43LWQiTszCdbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859616; c=relaxed/simple;
	bh=LMDAKOjQixETtvgTL/U+JcwcDePWJ8A7LCMiQZF61xk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mVhuqDyHdwymr3kDv9BH0jzP4e2pjcyCPZkNtUo3tMPwdJSnmcI5hAdUFgrHyf8kii8n6hfPJC1kH8+Oa6TwPvF9c0ZqTGli3TGKj1is4E0t19vMfU2NkhjMIQFueRI2yfXVW06GGCHJubAhWW70XO/aCoTV9DL72euZGm3wsnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=BGvbzXme; arc=fail smtp.client-ip=52.101.84.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="BGvbzXme"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fg+YpuYmXQVKbXoR/WhScFwfbUBlXLJ03E/8gqCFK3jpPbx2sq6j7gsn0c3mQFJ2FS1mpLhv+dv5GSUFiySxEe1lCZj9EQ+CZTycovDvGFvh1lN/oBgDqwwmUC6lQXV2zcKktkLAh/jUJt6rKnZq9jynKtc7UNmz2NGuz1Ow+cP9MGcwHu8t4PtNR2wUJeeAVIN1ZV3lbCEjYyhU91EwoNTBbZm3Tm/ECjUHwmVW7R9+aWFeBFZmvEtJ/mW+Ffb0UaepQ/p7ofXv9zonUPPdTKJCu3pQM10eOhA14odMMceigp90E55NTu1wt1M1qgsc1VJqVwLnzaOrHE7gOSj3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re1/FmRuzYPch7kcJ6n0JJQzpxZ7/F70kvwOowbWe+Q=;
 b=YfPJsu5ueKTyWRgEWDkzH1yhve7DY5zat67wYSQHkzyz2WOY4JTNSQ0cHmyAygkE+6fKWEiEVgTqXTi5ufJXrvygGXz1aTwXiYPMdJlaewio64XTjadrQ7xxCYGU6kxn+o77HwDtO/JS0DUQBoDolnsWR/Jm9cJLwcJn6WCTsgKsNKa/HVYbmlWeY4NN8Lp/BdJ5di3saSQFBsMErYZp/OXQIuAkqRzebgo54myYcSfxon/hskjKkSJeEBs566/OBMD1pxEm1cPvYu6rw+sVG4j3T/Rh5sPEOg9jmwC6v9MmdDdxY4eYQFz1T5DnAsRF0TyoM6hcflKWtopsRvlJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.61.153.66) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re1/FmRuzYPch7kcJ6n0JJQzpxZ7/F70kvwOowbWe+Q=;
 b=BGvbzXmecUbWNp1F3G+jY2EOejuGgYYlrw/7ApEisP8/MSlsrdDsL6+YwQVPaEdJyUejbGPu/583fHgHru31Zofw+biRgFcVljfnnBGtDeOPMChHxNjoHZHHX3su5ylxvmQJ2bsOwK5dLe1Jh9A8zap0UY/G+2letM1q5x5Bb2c=
Received: from DU2PR04CA0307.eurprd04.prod.outlook.com (2603:10a6:10:2b5::12)
 by DB4PR02MB8655.eurprd02.prod.outlook.com (2603:10a6:10:381::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 09:00:09 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::95) by DU2PR04CA0307.outlook.office365.com
 (2603:10a6:10:2b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Fri,
 19 Jun 2026 09:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.61.153.66)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 212.61.153.66 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.61.153.66;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (212.61.153.66) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 09:00:09 +0000
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP02.bk.prodrive.nl
 (10.1.0.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 11:00:07 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Fri, 19 Jun 2026 11:00:07 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1waV55-001Ua3-0I;
	Fri, 19 Jun 2026 11:00:07 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tobias.sperling@softing.com>
CC: Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: [PATCH v2] iio: ti-ads7138: Disable STATS_EN bit while reading conversion results
Date: Fri, 19 Jun 2026 11:00:04 +0200
Message-ID: <20260619090004.355053-1-paul.geurts@prodrive-technologies.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|DB4PR02MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3f0b80-2006-4c5c-0f44-08decde12a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	aDiDhUOYnZ4Ob/ZKB+DYp98vaukLsumsvXn1Fr2fTvhmDHDa6WgHWofSVm7Rapmh9RQekvAAsWS6FcMfcTTPYlLLytEpwsjJWcF+KHdiAETVXo4mwP3Bds5JXNWlYG/6reQwVLjO+nzkDFD8e3gpbhdmuABuLupeH10le0oxxHMnyx13aESPUX48k/4ftHwzkDKrR57NhdsfZTp81FBQFOiBzhi8FubZvUPGL9TEHFnip6ea3wQyyIIzq5CVXMHrsObF10DRj+BC7C6pBopC1FmDgr8GmGD3TpoqYjcnRG9f4wFfxxofzQUPUGRlMVSrVT3TolCxyhvtSQe0y0CXa9X0Z1GVVpkG+JwlhoeT4QbBwt+/UVbxtQyKplz9YNdqaNunTu28uvBo3iEb4Kekmf7zDZ5M7FUtRFk84JuPzTgF1Qukf8fwB8XG1FxMpfYNlvnAMzBsfrNQwYw6eVBMUA+coI2VNJyja6YqjowJigyDH3Kf+Ji5AQLDl1LYiWBwVpfKY17vFR+CeMRw4+c80YQwsee8UkWVBL/AQayJ6R9QyH5+gPJrFRntD6YhKYh/wCR9yJtB1OzR5YYGtV+UY2j3v5pZU9kSrdyFy+DMFrq/HNjcNlmeS9D6jH2x9bcea9Q63DQTPzeqHsjGqJ1y9Ux1Ha5taMYvWoXwMo3GWyttl+QinceDR43OSSGJlIpujmQydoh0n7o8/LNboaHNqg==
X-Forefront-Antispam-Report:
	CIP:212.61.153.66;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.prodrive.nl;PTR:prodrive.fiberspeed.claranet.nl;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OJ6YLDrmYEMTYmuZrmtjwv1vmH39wREJYGnU1ihZP6LfkZ69rhIigpokS1RDWRMpeFgJzWUaiDIKpTHWMhZt176mPVP2ThmffE96vh8bpv7Yn7MyP5gXLnAgHW0SVO+Yo4Pibe6JhwIMfBRPqCioUjVqb/yCjmds7noEnFq4JmIQt+Grb0kBsbAD29GAJcO7oDbntz6RGmdTf13CIqb1yfCrigBRsFNxHNhCF4iQbyze0S8xB5tvYEKOCkiq769+wqL8VSwWWc3rYje8I92YWyIIr5IxVXZpKdK0/Ioo0PoLtbcJ3Sg7ZTSwRdJcH+JWHS9vRC9M+eazJgMoTr+JQCYMpCzKRBHOIg87ZUeHWaQK2PBtfG098920jUfEB0BDqNmnEn+QllcDLGeerxDg+GKMn51aN5lAgLysImzYOTwDho9ZrtKR8MEfcDUyVurk
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 09:00:09.0790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3f0b80-2006-4c5c-0f44-08decde12a21
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[212.61.153.66];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8655

The device might update channel data while it's read by the host,
providing a data race. Disable the update of the channel stats before
reading the values.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")
---

V1 -> V2: Checked return values and prefixed iio: in commit msg

v1: https://lore.kernel.org/all/20260619075646.4100193-1-paul.geurts@prodrive-technologies.com/
---
 drivers/iio/adc/ti-ads7138.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
index ee5c1b8e3a8e..81380fd2badc 100644
--- a/drivers/iio/adc/ti-ads7138.c
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -237,11 +237,21 @@ static int ads7138_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
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
-- 
2.39.2

