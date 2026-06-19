Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023086.outbound.protection.outlook.com [52.101.83.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162125742F;
	Fri, 19 Jun 2026 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855820; cv=fail; b=CFvZTRqWoQaiEavb62I4LSpC9ydJtK2RwRE+C28dS2S12ijXOorwonDB2y1EkmTEQ8zpjUg3OBCSxBx1SmmJRN6+MWhbOScz14oPLXEszn7LS86ZsRBtyyoC7ty8NrDTTNP3ZOvCuyKTMmdRZrA7eaCHBhy7xtOWYLHg+5e522Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855820; c=relaxed/simple;
	bh=yev0UsX04HAU0IoyGxgfTLIpMM0NZLLzUGoi6DAMapw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rgdsEmtaDNBLrfWXcFoooyqkv6WS1sYM6wfK9UyebXZS/1iZgOnn/hr06+TqJzIaPOQdR/OfebEcZR5cy3QVOsmo9mWh/kdlCH2uKVpEHD5QnJbbwV2j6X7TKSibSdwEwOhaDXZND4vCmGJxOWuDmeEcOrKbHZzXRlkYgzw2OCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com; spf=pass smtp.mailfrom=prodrive-technologies.com; dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b=Qua0ip/6; arc=fail smtp.client-ip=52.101.83.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prodrive-technologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prodrive-technologies.com header.i=@prodrive-technologies.com header.b="Qua0ip/6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyWx6DmR+rBOiKQBhd+g9wPdIrnxz73jwAQ0CYep2AiaYPDmZ+T9HIdt6E/dlSS+mb/IvN+Yc1n6HBaKCkqL3e44Srl4PDdb2pyRQ3CLZnhRnEkWcOQ9GRFWNeTa0PoAfay8uk73s+jx7lbalp5Y+9i/TGcfIC3DLkENPNEAz/6UaMc+sy2lBD+JWUI7fxUIIMyBzU92k2cEt0F1FF3WvxboFoQYe1E8dkhyQSmPw5w4OQv8ch/2atZFMqA0/UtTy9AqomEXWROsALZCP5g7hPU/Tp+cT58hwtTqTUhBwtEjkfsbsPe+TPhYQ40oKrbjCK3OdxJqie5EWUyVPHEvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTu73ZpevIvZw8qe568Epy2RqDr5TuOwVo1xnbohx4s=;
 b=shn/ED00FccPKXmIjKq6nrmgSDsbZfHnnYCtp+3IpT48jwMbwCMiOHFOK0aFcmM2PQgq6ZObv52ESitIyNj9qVEjs6sq4/YWRzEtGQN7ny5+Lmv/O/V/eULlwc4EH3jC+MVHmHn1Vq4vtJY/oKRWlfzWjTmrpvy2CPAT4EWbCPDA+6cZWM1J93ZFMbEDugdSr7YQ86i54+48PLIebhrty1BGxrIxN+8pfq4kNdXzqErfj4A2QLJT/rrIjdqSz0iNbkLME6qi1b1BLq6EL4L7k+9u8TI5hp3i2mYViMq6xF92S3mdcMyAb4/KANriwEDk4iTQfeuWZeSrqtR7ra1p5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.61.153.66) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=prodrive-technologies.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTu73ZpevIvZw8qe568Epy2RqDr5TuOwVo1xnbohx4s=;
 b=Qua0ip/6m6RmwylIiCks1s7roIOW+YzmCHoCvdOKLSWajkceEigbZL5KdwGsQHt0D8nytbT8vQbfaWukfe7c4e0XoPIsY/jSl+CH6IFQA7V35D7jNPZ4d4Ngx7axxqbE3gmTXCr+gd1E3e9yUNhHWEYn/vPRqeKmxlyB9ppQZbQ=
Received: from CWLP265CA0507.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::21)
 by DU0PR02MB9420.eurprd02.prod.outlook.com (2603:10a6:10:41b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 07:56:51 +0000
Received: from AMS1EPF00000090.eurprd05.prod.outlook.com
 (2603:10a6:400:18b:cafe::81) by CWLP265CA0507.outlook.office365.com
 (2603:10a6:400:18b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Fri,
 19 Jun 2026 07:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.61.153.66)
 smtp.mailfrom=prodrive-technologies.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=prodrive-technologies.com;
Received-SPF: Pass (protection.outlook.com: domain of
 prodrive-technologies.com designates 212.61.153.66 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.61.153.66;
 helo=webmail.prodrive.nl; pr=C
Received: from webmail.prodrive.nl (212.61.153.66) by
 AMS1EPF00000090.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 07:56:50 +0000
Received: from EXCOP02.bk.prodrive.nl (10.1.0.91) by EXCOP02.bk.prodrive.nl
 (10.1.0.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 09:56:49 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP02.bk.prodrive.nl (10.1.0.91) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Fri, 19 Jun 2026 09:56:49 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.96)
	(envelope-from <paul.geurts@prodrive-technologies.com>)
	id 1waU5p-00HChi-2r;
	Fri, 19 Jun 2026 09:56:49 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tobias.sperling@softing.com>
CC: Paul Geurts <paul.geurts@prodrive-technologies.com>
Subject: [PATCH] ti-ads7138: Disable STATS_EN bit while reading conversion results
Date: Fri, 19 Jun 2026 09:56:46 +0200
Message-ID: <20260619075646.4100193-1-paul.geurts@prodrive-technologies.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000090:EE_|DU0PR02MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc1c64d-64a9-4090-eb1b-08decdd85247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	98Hr4S6ON6lmrh2dhn5I5d43BGJpIv/AohbNNZS9PF1u0+LRPhS3zAopMhaaVZQW+WmCXq5dj9MgfQ5pRYtw9dl5YOXd5pc0mvMruc7qbBx51UtAxcjlOS53duMWFedjTaZzxuljCH1RYGJ3qiMF/lNFNkiMA4j3D5IqDI+tmI/9ubzLEpZO61j7sMhUN7pG1kEnUdKSW3LzQNp02sQnHKowsmxWbzN/0uLY1XcGKcnxwdIHp79hZ4I+5ty9CV4W28iNQqefeLN/42KYD4e/gZkeQ64R3hwRu9fYlcGO3H7EPUAWA4tJHWMwVKvUSEs4Skj7++KYsft0tQHsjUVAWzXC/v74LQA0DAtqBR95XyEUQ1nPByG/S6Tj6d7cY3fjfh7NHRCidcUezlM2cduKLL6CB/toRCSQ/v9MkOmrwwtbnv96q6kNy327iP+wayJDXLeuOV4Nbg4S8sn9lLQIcVU6tRIdwNxzvQ0owBt20LR9MJsbB0D6aTMnU8pZRdJ804F7/OFB+EpqUXKNFk5uFLt0dA+2a6M2sjIhyf5al7NYysMKxS89U3ossd81NyDe2sncPPoK1fiQoNfZAQWCh4b2v+Y2QPmB/YSC4KCHYiqQcp7yPQnSMFy+uRE7dKnhvqb9ln2VRRy/pfTPzWz2OV+N89/5xkoMbBMFSU2yLeDSYxIm1S4V2RG1EmiNh9lFJvCbyHRX+eT/e3bpl6ZoJg==
X-Forefront-Antispam-Report:
	CIP:212.61.153.66;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.prodrive.nl;PTR:prodrive.fiberspeed.claranet.nl;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sDcoIXTGWyvbNYC6B9fNs1szrY0+JiPblMVjmSp/F0Vj1EEJUyaTQFSb2wmAfaZ4CbG/qYZLuPwXlTSvW3YnMjSFpZ6DKlY83VGM1qrzoMIhY4Vo9aOd7sS81q/7v/ZCQzusbZe2w/Dp12q246rLFrCK1QE/I+FzXLVo8CJRJMH0io6Ggg1IfWvZTcdD0HGn/YFx+G0myDr6vs0nwYpAYoWNRPKOuH/yBNK/vuxCS9XdNWUGtevn0pI+fk7QDIW63uZi9JAagG6tI3XDXYchAP6y6asHgyWMrnGAPVZg2Z67477cY5acDa2ea3Q3z93kqzaputxhy9/z/eRrWIuOQhBfGIYHQs0XPU0TeelzQszI3T2MH6541tNDFDLhg4mwXKgFr/m8XILxP64gJENQAFgliHHNfMandeqZ5jxsw6eGKeOEzZNGIG3seXNNA23e
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 07:56:50.9975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc1c64d-64a9-4090-eb1b-08decdd85247
X-MS-Exchange-CrossTenant-Id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=612607c9-5af7-4e7f-8976-faf1ae77be60;Ip=[212.61.153.66];Helo=[webmail.prodrive.nl]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000090.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9420

The device might update channel data while it's read by the host,
providing a data race. Disable the update of the channel stats before
reading the values.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")
---
 drivers/iio/adc/ti-ads7138.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
index ee5c1b8e3a8e..f47cd083fd26 100644
--- a/drivers/iio/adc/ti-ads7138.c
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -237,9 +237,15 @@ static int ads7138_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		/* Disable statistics update so the value is not updated mid read */
+		ret = ads7138_i2c_clear_bit(data->client, ADS7138_REG_GENERAL_CFG,
+					    ADS7138_GENERAL_CFG_STATS_EN);
 		ret = ads7138_i2c_read_block(data->client,
 					     ADS7138_REG_RECENT_LSB_CH(chan->channel),
 					     values, ARRAY_SIZE(values));
+		/* Enable statistics update after read */
+		ret = ads7138_i2c_set_bit(data->client, ADS7138_REG_GENERAL_CFG,
+					  ADS7138_GENERAL_CFG_STATS_EN);
 		if (ret)
 			return ret;
 
-- 
2.39.2

