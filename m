Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626714;
	b=KqB5t7fz4Vfd+C34/46yJKX+0ahVFPSEbbnkFkWXUpOpQfXPe5S6C3FFM8ICxpYGQPh0
	 TS1iNgtul8Xlqf2rQhlsXzY7JEPaXQI1BveiEwi/7dMB65S1GHA5ZJUB5gLmDM9BTnXLV
	 EkjHFSmXM5BXV5Z9sV6xWhZrr1gzYyQDHaj6fWMEj9cZvDwEVOm01Fl11Bxc3+AfomXxF
	 1qjKXoiHCP5nJjOD9YD8BiqBYk4a0gK6SQT1hDSsf5Pm6K2CyY9qrKP0vEk/GmVPguQUk
	 ycgDNrQw7niBDk5DFLdV/zANqC1/1ICAyqiGES5K2NTK+RYEjIFFRv3RIEhevCratgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626714;
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
	bh=6u9dSRLoFjV+tXDzJkQPtTAoaS8EfJzNpx4hnjk7qXA=;
	b=kn2/cF/jX9Mv8Y4fIBy6BumiFJbAeOksVtXniQgR+O+p/+DaQd0hsfbGkdxIgDU9nTqj
	 R+de4kRu74JoRwS+c0CYGKzkn+aF5sqMDoc2w9Xw9aYJJ04p3cYGd0kzoW0GoocRwbCxX
	 XwpaYxgDcAlLRzPvFJPBTS+pa6dQnME8dZj8d7C8hUfbDWXpDwt8VF11oQEaqHy4sqoQ6
	 BF9nGeHCoecUgdAf2OiU7EKoJB3pEVjJ1EwnzYA/eTq2NSRL75ackzXIO3AQA5Cr/ij9X
	 Ph4SQ+cX10/ftnBdO/H2yU1KMqpXllkeq/TVTGzYyPO03HlL4Cwg8WaYgwyk2+z8Dpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WcZ+ZrvH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.12
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D347606A339;
	Wed, 25 Nov 2026 17:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D347606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WcZ+ZrvH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQVIMDoix9wVyAYtx5ZZuppBwMEnZPjyY6qrPU2Ka/RUIoN1a63J7lkZGyeeuGfxONfSS8R2ouBwytDDBffpt9mpF/HGjYINGfv9t+NJ4VPqdT2Tju/tBdmebIBLVH8DN0iML2jkZAIlDeItk09vrjnr2r+5G0AZrSiz/QVBvLA4hKhaM7XO9JZw0U/nRvnbilnaemHtshIHJI12IBpvEmoXPaqjVFJHSJ2W7yTMUH77etJyVzZ2MxIQ6Cd81h0L1ULA5+QUQ8UFYCY4BAmq5sToEQ48n4K5IwAyElxW7ymQwbyy/tWi29sz8uHLeOiNKVQZ707s0kVmPn1limJP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u9dSRLoFjV+tXDzJkQPtTAoaS8EfJzNpx4hnjk7qXA=;
 b=cO6UhcS7FytOd90n/h1EYaNcibeQXZihUZBPONpXA0QfxqBwmt+Cpg2H9URSxKxdFiTL3UD2L+jjIr3j6XBCdHWT7YOegsTxQSHvDtAU/v+A7HvH6O93JisLDOZChxAmOMtS9jVHRQIdSb4BTyAz7BkPX95Gi5Ykfu1bn1zVlORrRy5m/2Xae1o4VKzwq9yPALDliUIxUzWyK/SkwJYn2skXkJcHsECjq9y8Vo4fHVfxJLSST/OXAtyV4JInl9qujy+i0y2ImE+GisDYLDPNe88w9GLWGMTRMVxBBjMR2GPBvsv1sBGJ9TFT74NdzBB5gmHcK2zEXNrz/oWMTJ+5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u9dSRLoFjV+tXDzJkQPtTAoaS8EfJzNpx4hnjk7qXA=;
 b=WcZ+ZrvH0ib1hnaBMgSYj9MkizJuL/sUmxADY2WLiPbDE2NDUcEbCLpfAXhpWzw4MgJFpqmDp3fnBrT4W8PQoxhFw9U/HoJXeu+B9Fr5QWqZwjvGZRbxtG3zxODPTCz6BrFNF4Qa6Pq8obD3gcwmYBmSD57V+GKXPcKbAbnWxXI=
Received: from PH7P220CA0105.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::20)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 17:11:45 +0000
Received: from BY1PEPF00026968.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::a0) by PH7P220CA0105.outlook.office365.com
 (2603:10b6:510:32d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:11:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026968.mail.protection.outlook.com (10.167.244.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:11:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:42 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:38 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v6 12/16] iio: adc: xilinx-xadc: Add clarifying comments
Date: Wed, 25 Nov 2026 22:40:26 +0530
Message-ID: <20261125171045.1246381-13-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026968:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 848af26f-16ea-4a64-b043-08df4b172eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261021123027099003|261026140227099003|261022105027099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GKyToi7MCRV0c5UZmZvDv3saxsHd13pLF2OdSYNUwKn+LsRntWp2NL4UmxbhLv1Ep7F21NyRwAvTRHkwuWg33fr9B44G3zye7o2xh74DHGQzMJrIhKPxJwqs5GQAe5wb7a9GfWIz7ZeI6XW9QPKsG6XumV/oACy+rgR2ovNAel+JcVqAnVU0TQkw8cvHYxJ1h6EHlzegCHQUTRQvLpUsFrsGgoQG/mWg0rRiR7pR+n7R7wyJktCy6UVKVgCBr+KzXLG8EY3huho3GCtURcYI2ULA0G6/dO/nKtu4ZA54/NG7OADzb6yCQT8DsqdQE6JS+F/kLk7B+oHY+i1c6nFyNU6YdlAeVaZRISQSDWeTP05fKEyFrwjQshB3esmWAqNC07oKYTWEKACl6pZX9tRJE6qVfgDPqbp7HeEygV3cYsvogF1lPD5irzljOVXe5Ur8DWSXXayQXRyKsfLpcg2QYpynWHkkQdh8eAkk2rYxuevZgLEtWI4P2qXF7Ct90SwJlk2k7QqZDNvvlM9ppTfCWyiw4lSIZ9hwtkA2We87T4IvVfusMuGJBoWNG4E8Sw8zvGy/C4sHMypUhLJxpsoY5eZZBnf9XWcmMg9Fhm/UlOgbpBUhMsD7YQWY9vMQMW+5ccUN8LyXB6GxHQ/azj8+yfievDjVqQfwG+ngwXAl8nKCymeQZ4pZamHLWU6tiZPH92gKyNhONVN6lS3MY0OTlw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003)(261026140227099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zGp4oZs8PFX6AohQpMyHTZ5lZKvrKeDt8qhefVfvaS03OTUTXqVgXkhzzQqM3FbyhuyJhnE95wtFHOWdktR0oJX/KIWbbRFeGR06m582ottNhQcgO64zF1S549lRoyIamjyWzilLIW2JLY2MP01cNCzZGmcFzqsrlVfxjI6NQPIl5k/GAUesg10S2/QF5DvxGE1anuoW+XsUoiNNNxvdJ7N6s+vV0qa0E1itSz3wxHombd9mOgFr98tFPnJv+AWuIlZrnx/osa9Jhy9z0NBqEqh/Ey2v/LHT+JB9gMiOdCcXQ/kJe8qYO+E/CNTsHc1f7U542RXrZ1S23GAe4Cmw8YXMBuhU/eycOtFnvSds2qZntd5FFB9fdXG7WkqPORz16n5ZR7/FCH+F4W826b9TNNVtlM6qh/3QFn+gFH/0AJ8xTKrKRhCfi774r37zp0JV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:44.9186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 848af26f-16ea-4a64-b043-08df4b172eb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026968.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202

Add missing comments on struct mutex and spinlock_t in struct xadc
(per checkpatch.pl), and explain the non-obvious FIFO-drain loop and
Zynq alarm-bit reordering logic.

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 9 +++++++++
 drivers/iio/adc/xilinx-xadc.h      | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 7a92ea75cbdf..8463b6268c89 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -153,6 +153,11 @@ static void xadc_zynq_drain_fifo(struct xadc *xadc)
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
 
+	/*
+	 * Reading XADC_ZYNQ_REG_DFIFO pops one entry from the data FIFO.
+	 * The loop therefore removes one pending entry per iteration and
+	 * terminates once the hardware reports the FIFO empty.
+	 */
 	while (!(status & XADC_ZYNQ_STATUS_DFIFOE)) {
 		xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
 		xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
@@ -239,6 +244,10 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 
 static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
 {
+	/*
+	 * Reorder the Zynq PS-XADC alarm bits defined in UG585 to match the common
+	 * XADC driver alarm layout.
+	 */
 	return ((alarm & 0x80) >> 4) | ((alarm & 0x78) << 1) | (alarm & 0x07);
 }
 
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 4f412d60e3a5..cf282dac4dfa 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -60,7 +60,9 @@ struct xadc {
 	unsigned int zynq_intmask;
 	struct delayed_work zynq_unmask_work;
 
+	/* Serializes register access and device configuration updates */
 	struct mutex mutex;
+	/* Protects interrupt state and FIFO operations */
 	spinlock_t lock;
 
 	struct completion completion;
-- 
2.34.1

