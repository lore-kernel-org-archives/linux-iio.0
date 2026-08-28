Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011016.outbound.protection.outlook.com [52.101.125.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F33472F74;
	Fri, 28 Aug 2026 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929260; cv=fail; b=A8OMHyLNtN8ls9PwQg9TBBuFSAKdFeQG+H2K3A0FYpTgESh+vXRXTpJMmPqcN2ocT0LBPX7Zg0koyJLBIoNzK6s+rOm1t1Zs6s7RQqGoFGJzFrFR+sKZKVyqn7xRJH2k3rr1K1EoKOqv4h3UYudZqnZibDKPuFUOjmmQGHjYFPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929260; c=relaxed/simple;
	bh=MErkyTnIzYWU9SgA9ipf/xkh7U3aJqtowmsVaZGboUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aT/mSv2/RhBp4yHvtpo+wJW9zLcL04o0xoByOEDGUrYIx6TQ2T41DTfet9BIWIvY2KZcRJ8N8l6xpjbvassRKXXZG2xvHNtasFj7C6yvNEgqoRyRg26icsu7a2UNLKa1HZm4YUiEd3PuPWeUS1HGW/PisHAnEcvxUXar1r63EYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LhzxJTiR; arc=fail smtp.client-ip=52.101.125.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LhzxJTiR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnWqAnDfuR7+FOAsncMwYcVqFld8PgI1WFsZr3BqWogiOzJaGhWOL13sdCA2E7LNnxmK+RkSNtIO4b2bQBdjc/650ekxlNd32VJefRqW3phJrvGmNxhSU7Pa2oevkFFg2yaiohtyNh4WzM9XvKXFBHb558dIVuadXuW4rcMMteSsbAyxIooEGRfL+d1PlslOmFX3gLdNdBpwh1lwCsJtKmD5KvuF4IHqz1ugQwD091amOfb2MLPv4NB8zphAHCIXbUrA3gXRIsRgqnfGUowGoMjsdsd97xDlXVZZFR7eRDlwhneZaXaeAEiLcXzVtvf+4AJewGE4yZr2PKokeyyNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gCgh4PvXk9vEZ1Ti0bsDCmkY/XwfKsXX+xiYhMkwGA=;
 b=Psa343/tXPNN5HXvesz+ZBiV5/aQxqOarXcUW8Mo3bkkX1d2KUZA0n3lzcTWZvae6nBJTtJGNoL4RgzcUXBbA7seO7+Mh7D+xa8AlDGauUajBp20TIw0s7OdUabEC9JtpEuHli9PKRGDg5xwJNtviJublN8CpCBhgiXv/p+9Q4U3UghnspCFftajjueaPOPM2Og0RXiK9AR9Lo9LGGiZyQnm/Z7JoPNs69WJ2nKJhlzv7FMoih93/L3hrMfJGGehJaRaVyqHievPeeVat9obMO7vgBhSAylish57erp24GIk7OTqg1L9JKaMwpMHFLN1AxJdX9c2GrEeEbkPIPil+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gCgh4PvXk9vEZ1Ti0bsDCmkY/XwfKsXX+xiYhMkwGA=;
 b=LhzxJTiRAGPWWdf72j7fWCmvN5xkDGJuEFEWSIOhllaoUl6f+WixBJBKOMCf54uvnnzsZibsDRqgaNxWwGCll1wEW45DWbqo+GwdDPgIp80IyCEM0EiKnnWU4C3QRiBa3ML6DnAvmLiwYvkg28qHnl7W5LefhhC2uQ5xeZBPwuQ=
Received: from TYCP286CA0299.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c8::19)
 by OS7PR01MB18245.jpnprd01.prod.outlook.com (2603:1096:604:4bf::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:00:54 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8:cafe::5c) by TYCP286CA0299.outlook.office365.com
 (2603:1096:400:3c8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:00:53 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D1D4C30001E6;
	Sat, 29 Aug 2026 00:00:48 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 1/9] iio: adc: rzt2h: remove unused struct rzt2h_adc::max_channels
Date: Fri, 28 Aug 2026 17:59:34 +0300
Message-ID: <20260828145943.2077589-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|OS7PR01MB18245:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 276a8730-787d-4e92-e376-08df05152800
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Q24bqvjN57AsBNlM5YQOLoGQTkQkSKAVnHgAkji5oXqbvdtBPKcCxXKunRnGuk46IGVbsMz31d5600ZNO8MDW7+XkMZbKRTEDRnUe5oszxsJPh6qcluik4O/4nHJql+l++69R4ektr/WO+2FQHYqSPWKyflwJ3ug/c7+AiNxgedgpfMPxce6vhPYz1HErrPUA7D0vJnEEiLoOvVlhRmdRLkxlQKUVvVX/pkp9caw9E3KZPMDwccg6IFeXaKrutWjTmF07bFEB1JZLcg4pgzJ4OWjapJgfcDhc5iLa0w3Nvz+/avINUMyArLcY6mlxBkrpKEIPWLE764OGJILd5qW6UKciB8BMTK2czrVFhuuAuZQ0SJysjIV/BXzknefHlsfsvZyYruA6n0BSEHhGT9pmT2h5M1BXWRX+VGX+a2zYhsYeV1UpNW4B1UQv8acbMX10XJCJC5saRGGBtj/d2AJrCnNuYTtEQSOfHb9lDOx8+EcUnekt/T6RUJETLcguRadpkt8xDTUj48k+BHgTUmX8EPt8VqXDdo/LMXKPUBcht7CYazEqLYjo1fAcBGDYl6UKqFDCvD26e2q1NWH2bcMhucrGXnjLtGAOVMlTmwoSvbksinzIFKlPNUW43CN7XiB8A89lqOQjYscP29WEx4KW/abn1HWHHTpX/U8xZjcgIYApICHex21e3IqPLLlVnDUKu7x3Pae7FViR/LohN3lqQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BGaZxT0aGubvN/0fTJ19ni1J18djyXZzDr6SnDyFGyMulQ+T4Daf7siLTbObvzEPfh8yW5c9CNbMqUW6F9uRvq1uwRNXb7OwGsuphlE098b1ekF6p7/HKVb5WIWNCbNT9rJyqtN5VAW9s3Vb9VeVryge4QDikN1ruxVDpBqPjK7F6lr/wvK2NSptKYnIoslyiPrKSJ1YtIhpSN3GK+Xq7bbG1/2CwQ61gI8y4YkuhP1riQz/TTlJAYSXgvqp6k2oaatKThcBjZgvJzG8u5tHf1WVFZuzEaF7Ax1Ekjtp569uN3ZbA/CcPeggC101Ixmjyz3Bt90trMTLOkhx9y65YMfJVjeLuHsMXfjw1qp19IBIdwoYdOLCXSd2RhB5JAA3sv081bKJnKx7wbv0OUpGtZgyD0LpRSVLFU9yE2+fXkyiVCmmN7cJ7wqhKuAZQsPd
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:00:53.2993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 276a8730-787d-4e92-e376-08df05152800
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18245

struct rzt2h_adc::max_channels is unused, and is probably a leftover
of the devm_iio_adc_device_alloc_chaninfo_se() conversion done after the
initial submission. Remove it and the logic used to set it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/iio/adc/rzt2h_adc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 4e0eb02d3d14..42ff6bf2ab08 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -42,7 +42,6 @@ struct rzt2h_adc {
 
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
-	unsigned int max_channels;
 };
 
 static void rzt2h_adc_start(struct rzt2h_adc *adc, unsigned int conversion_type)
@@ -190,7 +189,6 @@ static const struct iio_chan_spec rzt2h_adc_chan_template = {
 static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
 {
 	struct iio_chan_spec *chan_array;
-	unsigned int i;
 	int ret;
 
 	ret = devm_iio_adc_device_alloc_chaninfo_se(adc->dev,
@@ -203,10 +201,6 @@ static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
 	adc->num_channels = ret;
 	adc->channels = chan_array;
 
-	for (i = 0; i < adc->num_channels; i++)
-		if (chan_array[i].channel + 1 > adc->max_channels)
-			adc->max_channels = chan_array[i].channel + 1;
-
 	return 0;
 }
 
-- 
2.55.0

