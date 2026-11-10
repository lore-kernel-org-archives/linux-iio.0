Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287375;
	b=JdmkbxcweGg6AuZ1W8i26okqzLyu5qX+88ptHZTplGl+QhYbMoEALEv3v+71cbgwibtH
	 X3n63J8fnbA7FXj9v7Pfy/ldnezXvZvi3PQ7x3anN+W0Hfxb/leIed+kkf0ZpYic1gaKj
	 QaLUbe/YrB2JAUoxQB0c4ccCu/A/XxSpv1fssIqGJHyLUPrS/ybt58Z7Dab+7nL4bqCXX
	 s3lm0VcLh8woSwwOVFgv3HpG7lP5722hFoRnUPoFiBOLlmql3EYkYNz0RvNfbOiZIyD7m
	 CvxcJUDpX9/kI4Ekm0WPEMLqbNpbAmf6SXx0LRoaC2e+cGHyAdLUP+piaZ+O1GzGsHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287375;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=4sGm1DUcV4TFm6XNeapmaQVGXI5J+O2daDNA49TDbOs=;
	b=L0d+MweK5nTi2qInWfwxDsjMDblAAxC5k2dzsRmxo0gm7befxmfBjtgjQzn7fI9RCWoa
	 q305fE1ci58Mt9tK1Vt0g3qfZwQV97rCak9DAJfGAsQ7rG/iVCWXCEm3q2qsm5F1pMMpY
	 U6iPOkzS8yFIm27Oj4AmjnoTKkPFEMuScAPGX0/ZE/ww8rySXaU7LiB+KA9W5e6ElBv0X
	 tUibjlII8wLjl3qfYy6a8AnymxnvEbO2mVsSVwetFrO+oBQeg36GlppfDd4K2otLB6wiu
	 ghI6ro5ehjZpS3yIODzM1mbrJd1q6QzJApSJCvfntjFA6p2zoOFBPPeGbc0Bpwmdt7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CbAw+yjZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.62
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A560A2603;
	Tue, 10 Nov 2026 05:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 250A560A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CbAw+yjZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxDD7XaAaRrFtHoaujth8+0X0p0lxqwwpIte7B2GnNErZ3MyWEVXCNHP7YJGz5hfy4xF/QNQrvbyzfr4BhUUgO45hvpX6NgEZTvpitzkygVp32fxbpMsEU5qYDDOrc3moVlXvZRGSaeLqx722sK8wdXfLUBWD13X7aZSxJjemUtb6f4oUOzyO9v4g4el7PZ0NhI4wob4pCn1RZNTSqagThVT7oqKoMVb9GbZyyFme1taqvkydPKaAXdpP8iSLi0HhxA/Dli8WTteXUM23sHiLi34TRtOslkRMUrga6eNnxU2J0QENw4hMlZrA75dFe0jqy6Fsfve/pdooBM2jgwfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sGm1DUcV4TFm6XNeapmaQVGXI5J+O2daDNA49TDbOs=;
 b=bBl0G0aEWXIoUEjZHgSRZMNyMOH5MMYye7WJrTw6Xz5E3L3rNv1GjC3Zgn5za2G7+8XMfe7rUtNhIirVPpgVq5kmTeyhVQ5wXty5e0XvbZ/BKoKdjm5inarnbPS3rPxnQK86im3VH6+slPMDO0NAg1B8WCUHYlhCW+1l/prbCo+mWcIU7pmPFkuw11ZXwuPtmT2pX5rHN7u3JaMogTAAgcroOWf4Re41RTLWr18pHwDI/Wl9FnhkHWsCn+AgJCQ4NyjirG4vOwsJnqLi5dvkBz/+kgCn+m9k6ji0npAxV0QMI4D7/Uz2ScqueXeoQdFSw0bd942rfEeMAhOpZ633pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sGm1DUcV4TFm6XNeapmaQVGXI5J+O2daDNA49TDbOs=;
 b=CbAw+yjZZtPbBP9+DFIVV/TewPQUOnJlrSJ2xo0VOcrO4kDFI9vNLqjSPNspcblspW5eMGrkypwGuZYcuzNXs7Dn0EXkpGhNl8bxGEEXFmZRWg78DFBEmaq/CDa9L1mxOnSMPrSTP88hAd09wqZizL92HWorXn9LE+EZe/75aXo=
Received: from DS1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::12) by
 SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 05:09:30 +0000
Received: from CY5PEPF00000E74.namprd02.prod.outlook.com
 (2603:10b6:8:44c:cafe::63) by DS1P220CA0016.outlook.office365.com
 (2603:10b6:8:44c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 05:09:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY5PEPF00000E74.mail.protection.outlook.com (10.167.247.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:09:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:09:28 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:09:25 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 16/16] iio: adc: xilinx-xadc: Add I2C interface support
Date: Tue, 10 Nov 2026 10:32:01 +0530
Message-ID: <20261110050201.1850399-17-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E74:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 9183dfc0-bc41-4158-162e-08df3ee8cc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|261009221227099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261102123227099003|261009223327099003|261009220027099003|261022075727099003|261009221727099003|261102130727099003|261028144727099003|261026121527099003|261021135927099003|261026140227099003|18002099003|22082099003|6133799003|10067099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	y/7OuA2BsobrkJ2Msyenf0Bm3yBkYidBHyJfweu6tFqW/YcK2lY9CTkPPL0nb/SA7TjQahYZsxKP7oQ+Aw8Rpk2+ywJwtam91YgfeXwOI5+/fpYqlBbtXQ9UsPlgnu5qyXcc2eFX/FuOSgmJxEwARVYJ+eCk1KNOr1NeKP+oR0B5IJGFtpadMS1Si5Ax7VdvUfub9M85AerH+xvJqv4qaF07pwSUHZoqrUZHHLct+TlK2F77qR1c5IqvPReLF+It36mG98xE6vdWQIXSczLRsoQLLDhOE5LR1JOmGbHitoX3PW16XR9Ny2VimHrB8oj6fLJH18S0keUSLzrvIOF2N5YZHg26bBt7qtHFxYytLqsDnf73uKynw1fEnZXZC2UhXYqzU4g1v+y/09N71DOtfk1GaUIi1zrXnuMrAg+OeNLDnKJm/vOTX+M1xHCLbNFjV6Tddz1qJJ5vFpLlLtzWnCtkcvWZedm7TET9dLwznuxD/8xiOCy2A1o27zVeUSqS2PTStQt4pha2bOLjK62SRWoDUQOl6E1x/lJiSeweQqhhLlmH2oZTKUsmNzJ21avNo534I6gpZCSnb8wg9FRkcE6G5JO0sV7Sw0HQbLrduHp6Pd8cvpXwRezM3Wkp9y4+u4zkH3QkRjUJxK513YwXU8t+wOxyXBLR7NRskRtd97klQGTNQqY3YmqzH/W1B+BgD1AxvqBPfE3Xi3QSW6r7SQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(261009221227099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003)(261009223327099003)(261009220027099003)(261022075727099003)(261009221727099003)(261102130727099003)(261028144727099003)(261026121527099003)(261021135927099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aZ2AorGQPOMxW61rBEsSh+WoQbKgF47F0wJs03mg8TVEir/1ANDPc6R067ZX/pPXfi4TOVDCt1cUrxRtaMerBHNnAELF/N2XipggGotFthFdCsME08x5+H5R/suLE++b7XZdXWdFa/PVO5mZailkqCsXGJGd60qLNV/DcuHLDQsm3l3KuminL7jjJdRK9ENx/OmwLa11q0zPRUJDAK7Lfuo52B2XQMMFLskN7aJgXcjmkUTwdvsN3SeNkqqbZ32y9KWWSPgnRPvGWc3Lqi3P2VY5UR+Mb8aQZ3hdmStJUFsJrb+MFXn5KZBzP7vbkA7ClcL9q0r0FTFGAmYpIp/2zYDYsijqJcJWvOMnVX4Udm920r3JgjHS1EDqZJUmbxjTBCgoKQbKTq1Huw/cRIwM7F9pmcEY8uBz1FClJSoD6yP6oZ0OsVahpWiD8WGWYfCj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:09:29.4135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9183dfc0-bc41-4158-162e-08df3ee8cc8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

Add I2C interface support for Xilinx System Management Wizard IP along
with the existing AXI memory-mapped interface. This support enables
monitoring the voltage and temperature on UltraScale+ devices where the
System Management Wizard is connected via I2C.

Key changes:
- Implement 32-bit DRP (Dynamic Reconfiguration Port) packet format
  as per Xilinx PG185 specification.
- Add separate I2C probe with xadc_i2c_of_match_table to handle same
  compatible string ("xlnx,system-management-wiz-1.3") on I2C bus.
- Add NULL checks for get_dclk_rate callback function in sampling rate
  functions to support interfaces without clock control
- Create separate iio_info structure(xadc_i2c_info) without event
  callbacks for I2C devices
- Add xadc_i2c_transaction() function to handle I2C read/write operations
- Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI
- Defer XADC hardware initialization until first device access, since the
  I2C path reaches the PL SysMon indirectly through a platform controller
  DRP bridge that may not yet be operational at probe() time. Initializing
  on first read/write instead avoids probe failures caused by transient
  unavailability of that downstream path.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/Kconfig                |  15 ++
 drivers/iio/adc/Makefile               |   1 +
 drivers/iio/adc/xilinx-xadc-core.c     |  29 ++-
 drivers/iio/adc/xilinx-xadc-i2c.c      | 242 +++++++++++++++++++++++++
 drivers/iio/adc/xilinx-xadc-platform.c |  32 +++-
 drivers/iio/adc/xilinx-xadc.h          |  10 +-
 6 files changed, 317 insertions(+), 12 deletions(-)
 create mode 100644 drivers/iio/adc/xilinx-xadc-i2c.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 864d3cd928c1..0be6ce94c66c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -2180,6 +2180,21 @@ config XILINX_XADC
 	  The driver can also be build as a module. If so, the module will be called
 	  xilinx-xadc.
 
+config XILINX_XADC_I2C
+	tristate "Xilinx System Management Wizard I2C Interface support"
+	depends on I2C
+	select XILINX_XADC_CORE
+	help
+	  Say yes here to allow accessing the System Management
+	  Wizard on UltraScale+ devices via I2C.
+
+	  This provides voltage and temperature monitoring capabilities
+	  through the same IIO sysfs interface, but using I2C communication
+	  protocol.
+
+	  The driver can also be built as a module. If so, the module
+	  will be called xilinx-xadc-i2c.
+
 config XILINX_AMS
 	tristate "Xilinx AMS driver"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 97aed4a40135..90adb0f5026d 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -186,3 +186,4 @@ obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
 xilinx-xadc-common-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC_CORE) += xilinx-xadc-common.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc-platform.o
+obj-$(CONFIG_XILINX_XADC_I2C) += xilinx-xadc-i2c.o
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 24b2a8118daa..efbd5da72b02 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -222,7 +222,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 	 * non-existing ADC-B powers down the main ADC, so just return and don't
 	 * do anything.
 	 */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (!xadc->ops->has_adc_b)
 		return 0;
 
 	/* Powerdown the ADC-B when it is not needed. */
@@ -245,7 +245,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	unsigned int aux_scan_mode = scan_mode >> 16;
 
 	/* UltraScale has only one ADC and supports only continuous mode */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (!xadc->ops->has_adc_b)
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
@@ -351,6 +351,9 @@ int xadc_read_samplerate(struct xadc *xadc)
 	u16 val16;
 	int ret;
 
+	if (!xadc->ops->get_dclk_rate)
+		return -EOPNOTSUPP;
+
 	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
 	if (ret)
 		return ret;
@@ -461,9 +464,13 @@ EXPORT_SYMBOL_NS_GPL(xadc_setup_buffer_and_triggers, "IIO_XADC");
 
 int xadc_write_samplerate(struct xadc *xadc, int val)
 {
-	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
+	unsigned long clk_rate;
 	unsigned int div;
 
+	if (!xadc->ops->get_dclk_rate)
+		return -EOPNOTSUPP;
+
+	clk_rate = xadc->ops->get_dclk_rate(xadc);
 	if (!clk_rate)
 		return -EINVAL;
 
@@ -646,7 +653,7 @@ static const struct iio_chan_spec xadc_us_channels[] = {
 	XADC_US_CHAN_VOLTAGE(24, 31, XADC_REG_VAUX(15), NULL, false),
 };
 
-static const struct iio_info xadc_info = {
+const struct iio_info xadc_info = {
 	.read_raw = &xadc_read_raw,
 	.write_raw = &xadc_write_raw,
 	.read_event_config = &xadc_read_event_config,
@@ -655,6 +662,13 @@ static const struct iio_info xadc_info = {
 	.write_event_value = &xadc_write_event_value,
 	.update_scan_mode = &xadc_update_scan_mode,
 };
+EXPORT_SYMBOL_NS_GPL(xadc_info, "IIO_XADC");
+
+const struct iio_info xadc_i2c_info = {
+	.read_raw = &xadc_read_raw,
+	.write_raw = &xadc_write_raw,
+};
+EXPORT_SYMBOL_NS_GPL(xadc_i2c_info, "IIO_XADC");
 
 int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 {
@@ -767,9 +781,10 @@ EXPORT_SYMBOL_NS_GPL(xadc_parse_dt, "IIO_XADC");
 static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
+	[XADC_TYPE_US_I2C] = "xilinx-system-monitor",
 };
 
-struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type)
+struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops *ops)
 {
 	struct iio_dev *indio_dev;
 
@@ -777,8 +792,8 @@ struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type t
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
-	indio_dev->name = xadc_type_names[type];
-	indio_dev->info = &xadc_info;
+	indio_dev->name = xadc_type_names[ops->type];
+	indio_dev->info = ops->info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return indio_dev;
diff --git a/drivers/iio/adc/xilinx-xadc-i2c.c b/drivers/iio/adc/xilinx-xadc-i2c.c
new file mode 100644
index 000000000000..25ae0c0650ff
--- /dev/null
+++ b/drivers/iio/adc/xilinx-xadc-i2c.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx XADC I2C Interface Driver
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ *
+ * This driver implements I2C interface support for Xilinx System Management
+ * Wizard IP on UltraScale+ devices. It uses the 32-bit DRP (Dynamic
+ * Reconfiguration Port) packet format as per Xilinx PG185 specification.
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+
+#include "xilinx-xadc.h"
+
+#define XADC_I2C_READ_DATA_SIZE		2
+#define XADC_I2C_INSTR_READ		BIT(2)
+#define XADC_I2C_INSTR_WRITE		BIT(3)
+
+/* Byte offsets within the 32-bit DRP packet, per Xilinx PG185 */
+enum xadc_i2c_drp_packet {
+	XADC_I2C_DRP_DATA_LOW,
+	XADC_I2C_DRP_DATA_HIGH,
+	XADC_I2C_DRP_ADDR,
+	XADC_I2C_DRP_INSTR,
+	XADC_I2C_WRITE_DATA_SIZE,
+};
+
+#define XADC_INPUT_MODE_BITS		16
+
+struct xadc_i2c {
+	struct xadc xadc;
+	struct i2c_client *client;
+	bool hw_initialized;
+	unsigned int conf0;
+	unsigned int bipolar_mask;
+};
+
+static int xadc_i2c_read_transaction(struct xadc *xadc, unsigned int reg, u16 *val)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+	struct i2c_client *client = xadc_i2c->client;
+	u8 read_buffer[XADC_I2C_READ_DATA_SIZE];
+	u8 write_buffer[XADC_I2C_WRITE_DATA_SIZE] = {
+		[XADC_I2C_DRP_ADDR] = reg,
+		[XADC_I2C_DRP_INSTR] = XADC_I2C_INSTR_READ,
+	};
+	int ret;
+
+	ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+	if (ret != XADC_I2C_WRITE_DATA_SIZE)
+		return -EIO;
+
+	ret = i2c_master_recv(client, read_buffer, XADC_I2C_READ_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+	if (ret != XADC_I2C_READ_DATA_SIZE)
+		return -EIO;
+
+	*val = get_unaligned_le16(&read_buffer[XADC_I2C_DRP_DATA_LOW]);
+
+	return 0;
+}
+
+static int xadc_i2c_write_transaction(struct xadc *xadc, unsigned int reg, u16 val)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+	struct i2c_client *client = xadc_i2c->client;
+	u8 write_buffer[XADC_I2C_WRITE_DATA_SIZE] = {
+		[XADC_I2C_DRP_ADDR] = reg,
+		[XADC_I2C_DRP_INSTR] = XADC_I2C_INSTR_WRITE,
+	};
+	int ret;
+
+	put_unaligned_le16(val, &write_buffer[XADC_I2C_DRP_DATA_LOW]);
+
+	ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+	if (ret != XADC_I2C_WRITE_DATA_SIZE)
+		return -EIO;
+
+	return 0;
+}
+
+static int xadc_hardware_init(struct xadc *xadc)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+	int ret;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(xadc->threshold); i++) {
+		ret = xadc_i2c_read_transaction(xadc, XADC_REG_THRESHOLD(i), &xadc->threshold[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = xadc_i2c_write_transaction(xadc, XADC_REG_CONF0, xadc_i2c->conf0);
+	if (ret)
+		return ret;
+
+	ret = xadc_i2c_write_transaction(xadc, XADC_REG_INPUT_MODE(0), xadc_i2c->bipolar_mask);
+	if (ret)
+		return ret;
+
+	ret = xadc_i2c_write_transaction(xadc, XADC_REG_INPUT_MODE(1),
+					 xadc_i2c->bipolar_mask >> XADC_INPUT_MODE_BITS);
+	if (ret)
+		return ret;
+
+	xadc_i2c->hw_initialized = true;
+
+	return 0;
+}
+
+static int xadc_i2c_read_reg(struct xadc *xadc, unsigned int reg, u16 *val)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+
+	/*
+	 * Deferring initialization to the first real read/write means it
+	 * only runs once the device is actually being used, at which point
+	 * the full path down to the PL SysMon is expected to be up. This
+	 * avoids spurious probe failures caused by transient unavailability
+	 * of hardware outside this driver's control.
+	 */
+	if (!xadc_i2c->hw_initialized) {
+		int ret;
+
+		ret = xadc_hardware_init(xadc);
+		if (ret)
+			return ret;
+	}
+
+	return xadc_i2c_read_transaction(xadc, reg, val);
+}
+
+static int xadc_i2c_write_reg(struct xadc *xadc, unsigned int reg, u16 val)
+{
+	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
+
+	/*
+	 * Deferring initialization to the first real read/write means it
+	 * only runs once the device is actually being used, at which point
+	 * the full path down to the PL SysMon is expected to be up. This
+	 * avoids spurious probe failures caused by transient unavailability
+	 * of hardware outside this driver's control.
+	 */
+	if (!xadc_i2c->hw_initialized) {
+		int ret;
+
+		ret = xadc_hardware_init(xadc);
+		if (ret)
+			return ret;
+	}
+
+	return xadc_i2c_write_transaction(xadc, reg, val);
+}
+
+static const struct xadc_ops xadc_system_mgmt_wiz_i2c_ops = {
+	.read = xadc_i2c_read_reg,
+	.write = xadc_i2c_write_reg,
+	.setup_channels = xadc_parse_dt,
+	.type = XADC_TYPE_US_I2C,
+	.info = &xadc_i2c_info,
+	.has_adc_b = false,
+	.temp_scale = 509314,
+	.temp_offset = 280231,
+};
+
+static int xadc_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	unsigned int conf0, bipolar_mask;
+	const struct xadc_ops *ops;
+	struct iio_dev *indio_dev;
+	struct xadc_i2c *xadc_i2c;
+	struct xadc *xadc;
+	int ret;
+
+	ops = device_get_match_data(dev);
+	if (!ops)
+		return -ENODEV;
+
+	indio_dev = xadc_device_setup(dev, sizeof(*xadc_i2c), ops);
+	if (IS_ERR(indio_dev))
+		return PTR_ERR(indio_dev);
+
+	xadc_i2c = iio_priv(indio_dev);
+	xadc_i2c->client = client;
+	xadc = &xadc_i2c->xadc;
+
+	ret = xadc_common_init(dev, xadc, ops);
+	if (ret)
+		return ret;
+
+	ret = xadc_device_configure(indio_dev, 0, &conf0, &bipolar_mask);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup the device\n");
+
+	xadc_i2c->conf0 = conf0;
+	xadc_i2c->bipolar_mask = bipolar_mask;
+	xadc_i2c->hw_initialized = false;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id xadc_i2c_of_match_table[] = {
+	{
+		.compatible = "xlnx,system-management-wiz-1.3",
+		.data = &xadc_system_mgmt_wiz_i2c_ops,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, xadc_i2c_of_match_table);
+
+static struct i2c_driver xadc_i2c_driver = {
+	.probe = xadc_i2c_probe,
+	.driver = {
+		.name = "xadc-i2c",
+		.of_match_table = xadc_i2c_of_match_table,
+	},
+};
+module_i2c_driver(xadc_i2c_driver);
+
+MODULE_IMPORT_NS("IIO_XADC");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>");
+MODULE_AUTHOR("Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>");
+MODULE_DESCRIPTION("Xilinx XADC I2C Interface Driver");
diff --git a/drivers/iio/adc/xilinx-xadc-platform.c b/drivers/iio/adc/xilinx-xadc-platform.c
index f3e44f768656..c9dd3d21b4f9 100644
--- a/drivers/iio/adc/xilinx-xadc-platform.c
+++ b/drivers/iio/adc/xilinx-xadc-platform.c
@@ -414,6 +414,8 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.update_alarm = xadc_zynq_update_alarm,
 	.setup_channels = xadc_parse_dt,
 	.type = XADC_TYPE_S7,
+	.info = &xadc_info,
+	.has_adc_b = true,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
 	.temp_scale = 503975,
 	.temp_offset = 273150,
@@ -520,6 +522,8 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
+	.info = &xadc_info,
+	.has_adc_b = true,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
 	.temp_scale = 503975,
 	.temp_offset = 273150,
@@ -535,6 +539,8 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
+	.info = &xadc_info,
+	.has_adc_b = false,
 	/**
 	 * Values below are for UltraScale+ (SYSMONE4) using internal reference.
 	 * See https://docs.xilinx.com/v/u/en-US/ug580-ultrascale-sysmon
@@ -565,6 +571,22 @@ static void xadc_cancel_delayed_work(void *data)
 	cancel_delayed_work_sync(work);
 }
 
+int xadc_common_init(struct device *dev, struct xadc *xadc, const struct xadc_ops *ops)
+{
+	int ret;
+
+	xadc->ops = ops;
+
+	ret = devm_mutex_init(dev, &xadc->mutex);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&xadc->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(xadc_common_init, "IIO_XADC");
+
 static int xadc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -581,7 +603,7 @@ static int xadc_probe(struct platform_device *pdev)
 	if (!ops)
 		return -ENODEV;
 
-	indio_dev = xadc_device_setup(dev, sizeof(*xadc), ops->type);
+	indio_dev = xadc_device_setup(dev, sizeof(*xadc), ops);
 	if (IS_ERR(indio_dev))
 		return PTR_ERR(indio_dev);
 
@@ -590,10 +612,12 @@ static int xadc_probe(struct platform_device *pdev)
 		return irq;
 
 	xadc = iio_priv(indio_dev);
-	xadc->ops = ops;
 	init_completion(&xadc->completion);
-	mutex_init(&xadc->mutex);
-	spin_lock_init(&xadc->lock);
+
+	ret = xadc_common_init(dev, xadc, ops);
+	if (ret)
+		return ret;
+
 	INIT_DELAYED_WORK(&xadc->zynq_unmask_work, xadc_zynq_unmask_worker);
 
 	xadc->base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index e52e90a22a67..10a397ebd0b5 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -17,6 +17,7 @@
 
 struct iio_dev;
 struct clk;
+struct iio_info;
 struct xadc_ops;
 struct platform_device;
 
@@ -71,6 +72,7 @@ struct xadc {
 enum xadc_type {
 	XADC_TYPE_S7, /* Series 7 */
 	XADC_TYPE_US, /* UltraScale and UltraScale+ */
+	XADC_TYPE_US_I2C, /* UltraScale+ I2C interface */
 };
 
 struct xadc_ops {
@@ -84,6 +86,8 @@ struct xadc_ops {
 
 	unsigned int flags;
 	enum xadc_type type;
+	const struct iio_info *info;
+	bool has_adc_b;
 	int temp_scale;
 	int temp_offset;
 };
@@ -223,9 +227,12 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 #define XADC_AXI_REG_IPIER		0x68
 #define XADC_AXI_INT_EOS		BIT(4)
 
+extern const struct iio_info xadc_info;
+extern const struct iio_info xadc_i2c_info;
+
 void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val);
 void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val);
-struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type);
+struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops *ops);
 int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 int xadc_device_configure(struct iio_dev *indio_dev,
 			  int irq, unsigned int *conf0, unsigned int *bipolar_mask);
@@ -233,5 +240,6 @@ int xadc_read_samplerate(struct xadc *xadc);
 int xadc_write_samplerate(struct xadc *xadc, int val);
 int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq);
 int xadc_postdisable(struct iio_dev *indio_dev);
+int xadc_common_init(struct device *dev, struct xadc *xadc, const struct xadc_ops *ops);
 
 #endif
-- 
2.34.1

