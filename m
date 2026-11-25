Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626724;
	b=5bxQT0Xiw7nF25olDgdaRrN40BAsc8/a6DvMgekSMsyevQfITFRttYgW9AzNWJHdEUGH
	 NOyXko5h62hynz4SKkvMhgAJ4RLYpeEIlJP0atmVNssrfZDyJYWW5kPaNNy5wdnyg8Uq+
	 unC9WPJsAQlzl6hkwsocroz4vrMz4yXV0chBUK+WLfiZwmkcWdYTZMRXiri0i6bXKqZlt
	 xK7jeBjaAZkAIraH9KXJYUETE25ke7d/ZxAYxQ/gpEG6bXSdPDZdl7CwJCikYRuEyGVrd
	 vWd3z+A0JE/ip4zfM3NrJxQPrw5eSh9mmDG+JBkYYCY7xzZaix522ZPLNvs+s8iTsHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626724;
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
	bh=UKBX84GpacGpEjshidV9wDSlmwQluTRMwI1iOz2FPYk=;
	b=hYbQoWb46PvA+/cF1T7Nc4lXbaSO1FR0Ftx2ESAJrrWVWq41SZKunJVCnUvym0bMfioN
	 J7R5qV1tKHRv17QRQKn1F3P3wIIOO5zXaXG/Rq3ugDES0b8DF2CzTZhD20UQj8J/YTZFw
	 73vUlHEK8HnxhgyQQEOTVMoSJTZMRxRnJnfAL/VejG86sVqqTYGVkJrAG8Uxnk5DQR+8P
	 sd9FDAwZEZNXRPgbBxzibrVc4H84nOrhngbNCdN4PyQgue/vA6dXrP/zYiF62+DV3eBmk
	 HWd7OhrDxoyPvF2mYhN9b3mPH3Ca5syJcDzryhcojCfhauaRf454jZz16eKiucMGJVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QJSyFO68;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.50
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013050.outbound.protection.outlook.com [40.107.201.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECA606A32C;
	Wed, 25 Nov 2026 17:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09ECA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QJSyFO68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8ZLv3ZRDE5f2vfdzt4OA8tNp9J4wHI8DmmY8p+XOyOzPvmq9CVrxw7Q2Zx9fmGGDvhdfBWGjwgNPJUZHMuFAiMUia6iGd2W1t55IcR2rHmlSgnFcDW5pDqKJQeoqUe3mE09tgUrnsjJidiiYBLuNPy2ydmibSP5P6DGBHPf03yZTI6nL62Os9TbjquWTUrEDEWZyLdXhZ488OK5phassTt1AtUuQbHNCvyTfCi5P7ey62Pl9EW4oLNEwahRapRyI4ryvNla+LaqOWGjxUs39xuk8b4Vabiu6SoDgU31D4yVf2JN5UBjnePZ6SfVYOzaDil9z3xP1+RdY5SleLXkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKBX84GpacGpEjshidV9wDSlmwQluTRMwI1iOz2FPYk=;
 b=Wf0BrThSqBmID1dVhyA/X0q4Yf7IAzLLbrkVU2DUe2AT68kndAZuiWQ4LjgNyAKxIQ7GohA6LXfju7KZLwmhZypPfCCys4xYILrHACweVtj+tEGk7RK7Qa6/I7RzNbjH4NW/a40KHpzCCalvHWxZSvK74nsWRFor3K9IrwDzwgaM1f2btucJOYZzG69LMpYkxEaFzbwrbOSNngoa0jZsRXtbhx/50Ff3d/hROt2n3ENv9DCws8QlOo/HziPkiZeewKNiD3afpo9Y2Cwemn+/sVGGaHIa8GbKstU5otkdnrfA4K7KpQGwquTTYxrJn89NvPG+IQl0RgMoWfZcnY4FnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKBX84GpacGpEjshidV9wDSlmwQluTRMwI1iOz2FPYk=;
 b=QJSyFO68py2l+HUgIvjyQZEd7lKx3Bx96CYdhle6/NWmGMU56w9swRabEIfYKk3VhiCDKoqs59zlFomc2mJlpjm65rX6vylz7EO+OblY+R3navQZZmAbP3XLjeqJwBAEnsXSaRZ5Q2di3zGuFoHz6LwmyOO7q7j6qtYINIldYgA=
Received: from PH7PR02CA0006.namprd02.prod.outlook.com (2603:10b6:510:33d::17)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 17:12:00 +0000
Received: from BY1PEPF00026964.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::13) by PH7PR02CA0006.outlook.office365.com
 (2603:10b6:510:33d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:11:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026964.mail.protection.outlook.com (10.167.244.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:11:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:57 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:56 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:53 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v6 16/16] iio: adc: xilinx-xadc: Add I2C interface support
Date: Wed, 25 Nov 2026 22:40:30 +0530
Message-ID: <20261125171045.1246381-17-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026964:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf977d5-27ae-4026-d4b1-08df4b1736d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|10067099003|261026140227099003|261022105027099003|261021123027099003|261021135927099003|261021121427099003|261026121527099003|261022075727099003|261028144727099003|261102123227099003|261102130727099003|261009223027099003|20046099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	r9RqEvBGA8fOCty4BbBLkuUeOfC3Xx9ZrbqRf5aJC9c/ADJFPnsWEXrSOuZYdf1ThQYoVC5xo1cgrZxNl3zoGXJS7IFRMXFpJhwMVYt/Kg2BQEXu9z/3Kd/jt4u5Ft1gFSN41oS5L1at0VwnYnydvAYGUtE3zgjqUL2GHuUA55II4bUZGnjM9NxBPoXXAa3q9eMUyuo2IpNYIoaMx/LhiPdqKfGF6Pz2zhoSngTC7rw2zTSQwLX+cmo1Vv4u3908mZTwFRpGHhQnUwRW83h5ZyTh/4b2IjdxhMAnUuqWM5JkAnihoxDRjx/ce4YxHwzbRy/Dv5HOw2BX33e4YXibtDHty2VeWOFM70YeM/lq8bUQBwTM2Sf2fyjfGglVYcg5VZu9j9fC4HCaq3uF77dpgzWZdq6y5pUmUQ+R9TFYpY3DR4lAflh2+GpEvQWrAi1a3wRjGqRXya9LEqr/kGxQFRcpge+yl+eUbY3zBBN+6RnBcA9XuP6c2a1LK9uf1YLA+8/PY3HbXe86SZmoow/ZaQH/FZgn+SniaSJ6T/ATOi6ou6sltThthFmOpLsedncghigRZX5q3xBzc/C39hpAVJOyD8+32ap5F7XWR0Jq5w8hCUA/ujAKVGjiZVUX6AnwBa5h/7wnSy5HSUmcmBhFMiLRpT117kVhKsPVKnoOUS4Du2PlJk8SjtN8c6z9asUmkpMM61YZLRJZ9WdK1OeA/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(10067099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021135927099003)(261021121427099003)(261026121527099003)(261022075727099003)(261028144727099003)(261102123227099003)(261102130727099003)(261009223027099003)(20046099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D/ZfxhF8rmzDUsq/HV8JRlr2bhaHYckoz39zEZDbvoQEzFfo+kl7tNBGMtgerRD8r4QHEcopmHSSvN2XK+nxAe85pm/YjGD07eflkPHOrmNdAPRPIrxZ4VMUZ6nTlMIAFi03tJPppAGtODaON2OD0fDMccF8GrQFVra9q8KD6NSPHgYSFeRVMkO36LakA4fpnwehEyDdx/6i9agnOjs5rlXTUz0Oy7tHZH55aB8t40G3IrH8wr4GTUKnhfk62YItSBfs755lBbqByYp5BGNa4mIRSID1E6ixAMOlh/AZ24SqKDFrRvZiuvPuLyyJmUdqNjJzlfJvxiC5AKKaz9FvsijQf6Ig66tzRaByF24eQRkWTp2/g5CgUJzDcsWs1PJFRJmak4FmBOlxyqj+fQiVwrxw0s9dEH8LUix6LyW0ubDZp7cGbFRTpk8G2VzP5Z3r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:58.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf977d5-27ae-4026-d4b1-08df4b1736d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026964.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802

Add I2C interface support for Xilinx System Management Wizard IP along
with the existing AXI memory-mapped interface. This support enables
monitoring the voltage and temperature on UltraScale+ devices where the
System Management Wizard is connected via I2C.

I2C path supports only the internal System Monitor channels. These
are converted continuously according to the System Management Wizard
hardware configuration, so the driver does not program the channel
sequencer, and VAUX channels and the external mux are not supported.

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
 drivers/iio/adc/xilinx-xadc-core.c     |  50 +++++-
 drivers/iio/adc/xilinx-xadc-i2c.c      | 235 +++++++++++++++++++++++++
 drivers/iio/adc/xilinx-xadc-platform.c |  16 +-
 drivers/iio/adc/xilinx-xadc.h          |  10 +-
 6 files changed, 315 insertions(+), 12 deletions(-)
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
index 8989c752e57b..aca326ddafcd 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -220,7 +220,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 	 * non-existing ADC-B powers down the main ADC, so just return and don't
 	 * do anything.
 	 */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (!xadc->ops->has_adc_b)
 		return 0;
 
 	/* Powerdown the ADC-B when it is not needed. */
@@ -243,7 +243,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	unsigned int aux_scan_mode = scan_mode >> 16;
 
 	/* UltraScale has only one ADC and supports only continuous mode */
-	if (xadc->ops->type == XADC_TYPE_US)
+	if (!xadc->ops->has_adc_b)
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
@@ -350,6 +350,9 @@ int xadc_read_samplerate(struct xadc *xadc)
 	u16 val16;
 	int ret;
 
+	if (!xadc->ops->get_dclk_rate)
+		return -EOPNOTSUPP;
+
 	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
 	if (ret)
 		return ret;
@@ -460,9 +463,13 @@ EXPORT_SYMBOL_NS_GPL(xadc_setup_buffer_and_triggers, "IIO_XADC");
 
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
@@ -753,6 +767,11 @@ int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 		}
 	}
 
+	if (!xadc->ops->get_dclk_rate) {
+		for (i = 0; i < num_channels; i++)
+			channels[i].info_mask_shared_by_all &= ~BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	}
+
 	indio_dev->num_channels = num_channels;
 	indio_dev->channels = devm_krealloc_array(dev, channels, num_channels,
 						  sizeof(*channels), GFP_KERNEL);
@@ -767,9 +786,10 @@ EXPORT_SYMBOL_NS_GPL(xadc_parse_dt, "IIO_XADC");
 static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
+	[XADC_TYPE_US_I2C] = "xilinx-system-monitor",
 };
 
-struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type type)
+struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops *ops)
 {
 	struct iio_dev *indio_dev;
 
@@ -777,8 +797,8 @@ struct iio_dev *xadc_device_setup(struct device *dev, int size, enum xadc_type t
 	if (!indio_dev)
 		return ERR_PTR(-ENOMEM);
 
-	indio_dev->name = xadc_type_names[type];
-	indio_dev->info = &xadc_info;
+	indio_dev->name = xadc_type_names[ops->type];
+	indio_dev->info = ops->info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	return indio_dev;
@@ -805,6 +825,22 @@ int xadc_device_configure(struct iio_dev *indio_dev, int irq,
 }
 EXPORT_SYMBOL_NS_GPL(xadc_device_configure, "IIO_XADC");
 
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
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("Xilinx XADC IIO core driver");
diff --git a/drivers/iio/adc/xilinx-xadc-i2c.c b/drivers/iio/adc/xilinx-xadc-i2c.c
new file mode 100644
index 000000000000..9609426c0116
--- /dev/null
+++ b/drivers/iio/adc/xilinx-xadc-i2c.c
@@ -0,0 +1,235 @@
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
+	unsigned int conf0;
+	unsigned int bipolar_mask;
+	bool hw_initialized;
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
+		return -ENODATA;
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
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>");
+MODULE_AUTHOR("Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>");
+MODULE_DESCRIPTION("Xilinx XADC I2C Interface Driver");
diff --git a/drivers/iio/adc/xilinx-xadc-platform.c b/drivers/iio/adc/xilinx-xadc-platform.c
index 8d3b5cdbd969..3b214366cb1b 100644
--- a/drivers/iio/adc/xilinx-xadc-platform.c
+++ b/drivers/iio/adc/xilinx-xadc-platform.c
@@ -409,6 +409,8 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.update_alarm = xadc_zynq_update_alarm,
 	.setup_channels = xadc_parse_dt,
 	.type = XADC_TYPE_S7,
+	.info = &xadc_info,
+	.has_adc_b = true,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
 	.temp_scale = 503975,
 	.temp_offset = 273150,
@@ -515,6 +517,8 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
+	.info = &xadc_info,
+	.has_adc_b = true,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
 	.temp_scale = 503975,
 	.temp_offset = 273150,
@@ -530,6 +534,8 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
+	.info = &xadc_info,
+	.has_adc_b = false,
 	/**
 	 * Values below are for UltraScale+ (SYSMONE4) using internal reference.
 	 * See https://docs.xilinx.com/v/u/en-US/ug580-ultrascale-sysmon
@@ -576,7 +582,7 @@ static int xadc_probe(struct platform_device *pdev)
 	if (!ops)
 		return -ENODEV;
 
-	indio_dev = xadc_device_setup(dev, sizeof(*xadc), ops->type);
+	indio_dev = xadc_device_setup(dev, sizeof(*xadc), ops);
 	if (IS_ERR(indio_dev))
 		return PTR_ERR(indio_dev);
 
@@ -589,10 +595,12 @@ static int xadc_probe(struct platform_device *pdev)
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
index fa214b2f2328..45f681f21ed2 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -18,6 +18,7 @@
 
 struct iio_dev;
 struct clk;
+struct iio_info;
 struct xadc_ops;
 struct platform_device;
 
@@ -72,6 +73,7 @@ struct xadc {
 enum xadc_type {
 	XADC_TYPE_S7, /* Series 7 */
 	XADC_TYPE_US, /* UltraScale and UltraScale+ */
+	XADC_TYPE_US_I2C, /* UltraScale+ I2C interface */
 };
 
 struct xadc_ops {
@@ -85,6 +87,8 @@ struct xadc_ops {
 
 	unsigned int flags;
 	enum xadc_type type;
+	const struct iio_info *info;
+	bool has_adc_b;
 	int temp_scale;
 	int temp_offset;
 };
@@ -219,9 +223,12 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
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
@@ -229,5 +236,6 @@ int xadc_read_samplerate(struct xadc *xadc);
 int xadc_write_samplerate(struct xadc *xadc, int val);
 int xadc_setup_buffer_and_triggers(struct iio_dev *indio_dev, int irq);
 int xadc_postdisable(struct iio_dev *indio_dev);
+int xadc_common_init(struct device *dev, struct xadc *xadc, const struct xadc_ops *ops);
 
 #endif
-- 
2.34.1

