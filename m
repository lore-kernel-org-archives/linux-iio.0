Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CCB3CD8D3;
	Tue,  1 Sep 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273379; cv=fail; b=oJsq8lrrghNsnPiIY+UyM7SBVgApwy6zaz3P6scqP6hVlqjpk6TnEtNEfddiOe2JjS/uY+pjtshzK4X8XE+8woAQHBhI/yuxbgeO8yrpYRcMLEZjaVap7ZX4M3mDFywp3KjL/l8OvFI0/eMUrRpyUl0RckcNTlp5EJFDRq9ji48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273379; c=relaxed/simple;
	bh=UvuNPv9ZfwU3jy+vPNZI4tVK+/qWMQB7sBDGCYvuCOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=McnJ0lgV/S79I3OYm0g8C7pJ0KivFGWNMlntX6JjJK2alSp3qFWC4/nOuAYYYlKZBJuzq4u4I+WX3I3x0/+XvDNHJ4OWvMTUgG0IYXno+7LRCkiw3+Hq/wKJijfmnUARwzjrpkZjVZ/pH/7wPlA/gxdBOqEzrs6WDQ6yAApvteg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=S1E/OtGE; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="S1E/OtGE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEFp6nMxsWktVqRx7mBCECsQBWDU7pCaNmkFeZm3PaMqnMYkaVL7dQtIjOUw5RFObRtus/gfM9YKWQQUsn/rej1Yy4gerTRYXaebKh8VuBz1Lyx8l0840ji3bvgFGtmuXcjt16yZm0WlI1HHUjbS0T9xamSRBaIlMoDo0hlOOVemzlUsIOZmQpc6GOhLmhrZ/2x8CJwLmHheSEPbty/n+Gjp32vQNK/et7u13btas2wYxEY9TGwI1DRfv0DLGjapHDcERx35SrES+GE3fL5OpAB+3qPWHGEZUVTpAXGMcwkIJ9QvfMH96XwjkkjMuJxIL9w/tKfmZV+ZaepuFYYuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfNvwt6s71vFESLO0ZyCE3C66EsmBhtcEqcmnn4fZtk=;
 b=HKBEeoQtNY9qSSlWF5EPG0uzol8g/NpJJZ2hB4iTqCKJQm9a3lkm84wHBZLeVnIiE3wUZ2UUuYGa3ZlHS2YgZmtPVSF6Hif84wFHFvaOMkTE24MW38HFbrGeenppbnZ4Kb8ZLvLFviuFsbY/MWHBn+jiJtoLkAkYwgMCWjp19v4SqxgSqUoxAhNIT8DtU1h8rwUrDzU0ANSMIGMaYpXxjzvCcH6g2kwP+Fw34230owYKtnFcuy164iDQ8pqwHN363E1n4mQfNdzD6L/O1X+QD5b0Av+Opg0miFhXs7hlryXupSn5sJPpDzUhgjwqlHjiLB4OgFTp6pAF4ljdW4Uj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfNvwt6s71vFESLO0ZyCE3C66EsmBhtcEqcmnn4fZtk=;
 b=S1E/OtGEsfkjDCI/Te1Guny7ScQ+fe1KKlTG091HA4zNR53Y7WQNYx5x4h0yPmnzhKA6RMwz16znu9nrh82vr1Te3HEGBxMTKSb1Nzw2nRnBe1a64ykrvWEvSqw6VVjQjBurNAtTTJzyjtH+wHWLIYJnfTmrTZt006HxOZZQwGg=
Received: from AS9PR06CA0319.eurprd06.prod.outlook.com (2603:10a6:20b:45b::12)
 by GV1PR02MB10837.eurprd02.prod.outlook.com (2603:10a6:150:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:36:08 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:45b:cafe::4e) by AS9PR06CA0319.outlook.office365.com
 (2603:10a6:20b:45b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 14:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:36:08 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 16:36:04 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 9CF232D94;
	Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 795E3305CBCB; Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Tue, 1 Sep 2026 16:35:59 +0200
Subject: [PATCH v3 6/8] iio: imu: inv_icm42607: Implement MREGx register
 access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-b4-inv_icm42370p-v3-6-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
In-Reply-To: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
	<joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8431;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=UvuNPv9ZfwU3jy+vPNZI4tVK+/qWMQB7sBDGCYvuCOs=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsia9uhK116uhTmbVxbeqJi1YIHoDI0rPROWzfx1WjTYu
 eGPsbbfio5SFgYxLgZZMUWWc0bbo/cn/9OdI+10CWYOKxPIEAYuTgGYSN8Phv/B4h2T/Svfyfen
 SitZ7t0UrnHY1rA6W1Djg+HRE9sq2oMZ/jvE7D08WcXbpkB2zZIj1h/4xE3PKr7KPRzXcYZlTe6
 +DH4A
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|GV1PR02MB10837:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ed0494-85d8-44b4-e84d-08df08365c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|1800799024|82310400026|23010399003|7416014|376014|10067099003|10063799003|11063799006|56012099006|22082099003|18002099003|13003099007|921020|3613699012;
X-Microsoft-Antispam-Message-Info:
	qY1+tKQPYnxqOuPXDgnT28PviwYX6rPwHpN27kPy+q/RFq0cRwzeFCpMk8NLk0HxF3NZzacFbg1ldJsupbecO0TcD1F17aDxk+OjldmwCSmkPMk1YyFQoX3ETEZU1QiZ+h80xbt9w2V6NutOr5utECedVU+kf4AZRuPcBXq47Ju8XvOMPijO9Mrsz9C6wQB7V9iJvICm4cO/0CuV17Fhqv9YLeAlLt5GIo8UEO2Mpqunvzb04I00/JdgxNDd8ItuC7lZjtVzc/cVDV0CGItvO04UNuxtuRrQoxZBTs+q3/wC2rnk9VlsPcGqGOiPDtMi/TEsXlUE/s9gWEi/eB3Ma6S7m3mVWPcVqQY1haXIBgh/UZLxgRUNi/tzk+MNdzARYmIVABcTKvGfgrvp5VeaF7g0dvq8MePl3T6GH/JDeF1q9GoNKXc7PudMgJkEevJcNUPgGuQt+Yr3cJ0PnXNguOgpR/BkoVhks9bQYEXh0U4nBxcn8q46NlyCVRsAvC2M0evh1LbBXQ0Vu/dEPvXYA6Vsk4OgHBQY6tkl0ggYR5+xkxgN7qJV/Mpz1vQKGNM16TdosFmwNxaFTAw8ABGVfp6EpZu3QW2a4OUF6ReSGwpW1VIo2vHf7IPcx+xhOzjoFd218VmV6t1moxsf5WV+XKQzDv7nRpSXTAm4wHwdFxRNmlq9Zm7Ht0dcBU5ZC0lJkRfMfq928nAU+PmQxjFqlhYPoD7xHC5wPcXtxe2FRz0=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(1800799024)(82310400026)(23010399003)(7416014)(376014)(10067099003)(10063799003)(11063799006)(56012099006)(22082099003)(18002099003)(13003099007)(921020)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X7YRf20tzjIc5RaEK5xSxDX/K7wI0QiBeX+7oHXSjY9qYKMOr9OzHBNzhqh/AyI0qtenuMi0z3QAyB1sQJ9ybhsu2v0ZYoG51dwuE/fv+160J5XsBipWBjcuHdcVsRKIPnT6fWS3i+hMM71t9OhLj2a4NXCkH54T0eblLCbt4ahuv8PuDvG5jbXqSAMdmTmTmUvRv2yyWR5vYtrjlSQC0So8XP0JCnjRpzmBwTjyxTmR2SfGecKF5tK2l0JBJhBGfEMLUfs7uozv7WYi/6zFNxwe33tdaXNf3pLnoEpPkdvD5iyKKqEF4J5fpiXTTMx0vLtrHS9EaTeaYEXyry9P6Jnvn2ViSZdWDoldOLkkFtne8Zr8V/i0lSLpB03KRunur8QvKeLMbv5O9Z5eMUxz/BhxDThvxh30ystWVqfApPyqyhU6X1O+LnsSVgphpt75
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:08.1378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ed0494-85d8-44b4-e84d-08df08365c6b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10837

The device supports indirect register access to different banks. A
specific routine needs to be followed when accessing the registers in
another bank as documented in the datasheet (section 13). This is
required for accessing registers configured via the user and
implementing buffer support.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Assisted-by: LLM
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
LLM was used to improve the mreg_check function to include the case
where the sensor is in a POWER OFF or LOW POWER mode to utilize the RC
oscillator for initiating the bank access.
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      |  29 ++++++
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 108 ++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index a183a8566617..a522850e0268 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -111,6 +111,13 @@ enum inv_icm42607_temp_filter_bw {
 	/* value 7 also corresponds to 4Hz */
 };
 
+enum inv_icm42607_mregs {
+	INV_ICM42607_MREG1,
+	INV_ICM42607_MREG2 = 0x28,
+	INV_ICM42607_MREG3 = 0x50,
+	INV_ICM42370_NB
+};
+
 /* Signed so that negative values can signify an invalid condition. */
 struct inv_icm42607_sensor_conf {
 	int mode;
@@ -170,6 +177,7 @@ struct inv_icm42607_sensor_state {
 
 /* Register Map for User Bank 0 */
 #define INV_ICM42607_REG_MCLK_RDY			0x00
+#define INV_ICM42607_MCLK_RDY_BIT			BIT(3)
 
 #define INV_ICM42607_REG_DEVICE_CONFIG			0x01
 #define INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE		BIT(2)
@@ -370,6 +378,24 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_WHOAMI				0x67
 #define INV_ICM42370P_WHOAMI				0x0D
 
+#define INV_ICM42607_REG_BLK_SEL_W			0x79
+#define INV_ICM42607_REG_MADDR_W			0x7A
+#define INV_ICM42607_REG_M_W				0x7B
+#define INV_ICM42607_REG_BLK_SEL_R			0x7C
+#define INV_ICM42607_REG_MADDR_R			0x7D
+#define INV_ICM42607_REG_M_R				0x7E
+
+/* User Bank MREG 1 registers */
+#define INV_ICM42607_REG_OFFSET_USER0			0x4E
+#define INV_ICM42607_REG_OFFSET_USER1			0x4F
+#define INV_ICM42607_REG_OFFSET_USER2			0x50
+#define INV_ICM42607_REG_OFFSET_USER3			0x51
+#define INV_ICM42607_REG_OFFSET_USER4			0x52
+#define INV_ICM42607_REG_OFFSET_USER5			0x53
+#define INV_ICM42607_REG_OFFSET_USER6			0x54
+#define INV_ICM42607_REG_OFFSET_USER7			0x55
+#define INV_ICM42607_REG_OFFSET_USER8			0x56
+
 /*
  * Timings as listed in section 3 of datasheet, all values listed in datasheet
  * in ms except temp startup time... setting all values in us and using
@@ -400,6 +426,9 @@ const struct iio_mount_matrix *
 inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
 			      const struct iio_chan_spec *chan);
 
+int inv_icm42607_mreg_read(struct inv_icm42607_state *st, u8 bank, u8 addr, u8 *val);
+int inv_icm42607_mreg_write(struct inv_icm42607_state *st, u8 bank, u8 addr, u8 val);
+
 int inv_icm42607_get_pwr_mgmt0(struct inv_icm42607_state *st,
 			       enum inv_icm42607_sensor_mode *gyro,
 			       enum inv_icm42607_sensor_mode *accel);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index e77d72e0f7bc..6e514b8682a0 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -31,6 +31,7 @@ static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
 	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
 	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
 	case INV_ICM42607_REG_WHOAMI:
+	case INV_ICM42607_REG_BLK_SEL_W ... INV_ICM42607_REG_M_R:
 		return true;
 	}
 
@@ -43,6 +44,7 @@ static bool inv_icm42607_is_writeable_reg(struct device *dev, unsigned int reg)
 	case INV_ICM42607_REG_DEVICE_CONFIG ... INV_ICM42607_REG_INT_CONFIG:
 	case INV_ICM42607_REG_PWR_MGMT0 ... INV_ICM42607_REG_INT_SOURCE4:
 	case INV_ICM42607_REG_INTF_CONFIG0 ... INV_ICM42607_REG_INTF_CONFIG1:
+	case INV_ICM42607_REG_BLK_SEL_W ... INV_ICM42607_REG_M_R:
 		return true;
 	}
 
@@ -59,6 +61,7 @@ static bool inv_icm42607_is_volatile_reg(struct device *dev, unsigned int reg)
 	case INV_ICM42607_REG_FIFO_LOST_PKT0 ... INV_ICM42607_REG_APEX_DATA3:
 	case INV_ICM42607_REG_INT_STATUS_DRDY:
 	case INV_ICM42607_REG_INT_STATUS ... INV_ICM42607_REG_FIFO_DATA:
+	case INV_ICM42607_REG_BLK_SEL_W ... INV_ICM42607_REG_M_R:
 		return true;
 	}
 
@@ -71,7 +74,7 @@ const struct regmap_config inv_icm42607_regmap_config = {
 	.writeable_reg = inv_icm42607_is_writeable_reg,
 	.readable_reg = inv_icm42607_is_readable_reg,
 	.volatile_reg = inv_icm42607_is_volatile_reg,
-	.max_register = INV_ICM42607_REG_WHOAMI,
+	.max_register = INV_ICM42607_REG_M_R,
 	.cache_type = REGCACHE_MAPLE,
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
@@ -96,7 +99,7 @@ static const struct inv_icm42607_conf inv_icm42607_default_conf = {
 static const struct inv_icm42607_conf inv_icm42370_default_conf = {
 	.gyro = { },
 	.accel = {
-		.mode = INV_ICM42607_SENSOR_MODE_OFF,
+		.mode = INV_ICM42607_SENSOR_MODE_LOW_POWER,
 		.fs = INV_ICM42607_ACCEL_FS_4G,
 		.odr = INV_ICM42607_ODR_100HZ,
 		.filter = INV_ICM42607_FILTER_BW_25HZ,
@@ -352,6 +355,107 @@ int inv_icm42607_set_sensor_conf(struct inv_icm42607_state *st,
 	}
 }
 
+static int inv_icm42607_mreg_check(struct inv_icm42607_state *st)
+{
+	struct regmap *map = st->map;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(map, INV_ICM42607_REG_MCLK_RDY, &val);
+	if (ret)
+		return ret;
+
+	if (val & INV_ICM42607_MCLK_RDY_BIT)
+		return 0;
+
+	/*
+	 * Clock isn't running: we're either in Sleep mode or Accel LP
+	 * mode with WUOSC. Force the RC oscillator on via IDLE, then
+	 * wait for MCLK_RDY.
+	 */
+	ret = regmap_set_bits(map, INV_ICM42607_REG_PWR_MGMT0,
+			       INV_ICM42607_PWR_MGMT0_IDLE);
+	if (ret)
+		return ret;
+
+	/*
+	 * After setting the IDLE bit to 1 in PWR_MGMT0 register, wait for anywhere between
+	 * 10us to 200us which are the ACCEL_STARTUP time and accelerometer transition time
+	 * from OFF respectively.
+	 */
+	return regmap_read_poll_timeout(map, INV_ICM42607_REG_MCLK_RDY, val,
+			val & INV_ICM42607_MCLK_RDY_BIT, 10, 200);
+}
+
+int inv_icm42607_mreg_write(struct inv_icm42607_state *st, const u8 bank,
+			    const u8 addr, const u8 val)
+{
+	int ret;
+
+	ret = inv_icm42607_mreg_check(st);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->map, INV_ICM42607_REG_BLK_SEL_W, bank);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->map, INV_ICM42607_REG_MADDR_W, addr);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->map, INV_ICM42607_REG_M_W, val);
+	if (ret)
+		return ret;
+
+	/*
+	 * As per the Datasheet Section 13 Accessing MREGx Registers,
+	 * there should be no read/writes to the device for 10us
+	 * after performing bank access.
+	 */
+	fsleep(10);
+	return regmap_write(st->map, INV_ICM42607_REG_BLK_SEL_W, 0x00);
+}
+
+int inv_icm42607_mreg_read(struct inv_icm42607_state *st, const u8 bank, const u8 addr, u8 *val)
+{
+	unsigned int read_val;
+	int ret;
+
+	ret = inv_icm42607_mreg_check(st);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->map, INV_ICM42607_REG_BLK_SEL_R, bank);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->map, INV_ICM42607_REG_MADDR_R, addr);
+	if (ret)
+		return ret;
+
+	/*
+	 * As per the Datasheet Section 13 Accessing MREGx Registers,
+	 * there should be no read/writes to the device for 10us
+	 * after performing bank access.
+	 */
+	fsleep(10);
+	ret = regmap_read(st->map, INV_ICM42607_REG_M_R, &read_val);
+	if (ret)
+		return ret;
+
+	*val = (u8)read_val;
+
+	/*
+	 * As per the Datasheet Section 13 Accessing MREGx Registers,
+	 * there should be no read/writes to the device for 10us
+	 * after performing bank access.
+	 */
+	fsleep(10);
+
+	return regmap_write(st->map, INV_ICM42607_REG_BLK_SEL_R, 0x00);
+}
+
 int inv_icm42607_read_sensor(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     s16 *val)

-- 
2.43.0

