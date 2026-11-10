Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287463;
	b=Tki/ZEuVtNfaIBL7vKG3FwET+gyWyOK/JXdS3oUD5KDkNTiirobe5nETCs7juwH1gOT4
	 tU4D5Q3b+t8IDrM/WYCMEF7bnsN11ZgxLVxu93t5u6vownkkfZA/fLCkLjQ+aZNdp08qp
	 Pf3pXMfjTM9tzi+I9weMeHbN5YKojy0KO4husMbkwEW9ShGrg6Lxl31jicmZpRKT4Nrzg
	 V1QChyE73xarYAkBHiTYmBx13trMbizy3tS5hrYECfF2FkOMXj5KvCec3XO7S5N8PZ7cJ
	 7D6pXTBN9TfcCvH+BqLEtI8/fnBPncijWwZvSv/E9C/RJxISQFXKI11tj7zDLIWW3Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287463;
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
	bh=GUDd04s/MiWOcmk3wrxpuhqgI+JEcaHgX4UXi+sjuy8=;
	b=5ZsoqN/zUtZguETXv0mNwt+lS9HSRhP7P9dAgVo3caHGnTVc45vYplvkY0RTG7KlhgRO
	 JB7psQ9kU3gaaB1TvX76yUJNoK2FM1ZrgIgNtoeS6Brf8tpzOMHXSJ9RT1NKWHI0li4qO
	 D2KOSm9q7le+/siXOYBHWuPBbwKyL95+mx9UtYkK2Ly9oA/pBEtt3Mo4wtjnBv/ghqEa0
	 3ZRDpULaGDEkeLGFLUKLpiT0sB+3hCwx5D1jvxqYYdMCfOvSzYS+G6/EF8ET5XN5MJ+Zu
	 XlG91HA/uN9Y1iaCplh75sg4Fc0ABko50eR8zFkJ1D1oETagiQDoEMQfxMDspX2KX2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=btjSFxF1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.5
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98139606A31C;
	Tue, 10 Nov 2026 05:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98139606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=btjSFxF1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpwLT38iQwb6FCy/k9R9VE+/DgKiWjzj0XLeU1OuD2tF/yJJ0kxlJ+9w6rL7PV6uqoUBG+WC0g+h8BFdzLG3QFtYxw1KyEuV/4EP76dNpPwSRrrWyMdRzLiR7SiBPuIJlGmKVfELFPPJe1423pEerbh0Hy5ghG2XNiWcOWr1Rx9UM/YQENKVPdeab5kx0GC9qdRiHeaLVomTF39TCRFkiBJCGrMpLB552O26HfQRAnUdfoV+Z0NQdXddYbh5e9UCgncgXdZw84UvV5BQTRdWZeIxi3L15DWK8QupwlglJljxss8RLCZVFCBgPeZOkWunPAEZQhYs8bcYTBrk7FJpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUDd04s/MiWOcmk3wrxpuhqgI+JEcaHgX4UXi+sjuy8=;
 b=LSQOfkdDmcpMpDm2gpIn5buEmpUqa3tg9BJxjRhvesyaEf6Qu98ENSYfmVEkd7yL0P9ooMb1w99xaCRgxVbnuG6akjcptBL8tcFK82egsx8GI49yrc4JFop7CqZythaogqNK2rs8AVWDfleMBiec5PixF/ob/aF6KXolWph2NT6md35Kw9uZURcZo+TU6xRV6cVYmbEJLEZtVIztu/bD+c8IFVbE+u6yftTI/NWkSIsjN9+z+FEkFSAISbqifzy+UhrmIjIzjHOTtxqkV2soPzH044qu8fK0DRRGfbu2gpDCCn9Oxl8xXTtUzp2ClseTBFdI1OyAYwDaT65sz/R7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUDd04s/MiWOcmk3wrxpuhqgI+JEcaHgX4UXi+sjuy8=;
 b=btjSFxF1ucYpaxK0yNRsJcztgBASVC0ho6r6kODgLvanJunftmQr6UWQRs7L5vcNp1K/TuNCUnqSUvkehIViZ2Qlkkxb22QIwMjsFCgdnqlvoRH7pxB7STjHOl7OGkUmLf8c7RFd8V/GGSpPnqsCnOb5caavwCJPt2dYkdwzfdg=
Received: from MN2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:208:23c::33)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 05:08:57 +0000
Received: from IA0PEPF0000003D.namprd03.prod.outlook.com
 (2603:10b6:208:23c:cafe::a1) by MN2PR18CA0028.outlook.office365.com
 (2603:10b6:208:23c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 05:08:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003D.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:08:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:56 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:55 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:08:52 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 07/16] iio: adc: xilinx-xadc: Use guard() for mutex locking
Date: Tue, 10 Nov 2026 10:31:52 +0530
Message-ID: <20261110050201.1850399-8-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003D:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f226b3e-fc7b-418c-2bab-08df3ee8b989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|11063799006|261009223027099003|261021121427099003|56012099006|261022105027099003|261021123027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	zVZpsZED1C0W31Nrk9hEXrU26WSPpIT7ft0Fjd5yH4bqbkgtYR+vVGCidZvK61mhqmUf1QBKdm+iG7bqGNPdnEFh0PhdJL8+umTHf+CWCK5/E9O7FEnE/kKROlFQG2o9AW1ABeTrOUQtteIcg81mEhOP7IBsftELpBhQOOllCbOnaevh0aB9XU6Wx9V8q/QgHjaAEc7vcW/bFl4j/Ku9i0h8ztAeaiqrQpFe+OFLV3AwRFUcbDrhe0Qb6b7157cchWxHGYlCHiOzJMA0UeJsUSbGBlWDWUNkuDUJlDyWA/m5VSt5aq1xNywfySxYa2aR+HTvjC/49yEJURzds2vdlcXN1jHYPSluENl7SWCnqOsUfdOiS8zkoGid5BEkLdfFKagQQ3gR6jufIYDTY+JrUAOH9cE3fMd503MyDgsKap4p/5r0novqU00QVYUPK8uK94OPlhWa7AkhnUaodXwur4uwCBtKNo08p5XAIzLUTpFFFvi/5uSPtZjCyx8OMvHH3yUmf476M+lu1GK7x//cm3Ds8kc6OIFxJRqb9XufTCwB0rOjm3JGRvkBiNOvTcYt1ifScGb2Q9ObuYd3SLqvqJyM5ITh9Rb6Iv56R8d8V+Z09x1GwP0zjS+ezN3iyeWggmNbbOPwMcH/CSTNJuf7w70lcb249CY3vfdmcxsGVkLnxJHwwicISzmL8mRauMn/UzZhAyD3JSalGo3yheMYkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(11063799006)(261009223027099003)(261021121427099003)(56012099006)(261022105027099003)(261021123027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sjG9kLGkOu6Y99zAYjvaSUduZvseJ2EJabqU+7E5AN5CvNAzMMgrNznJB/fDmdI87aSI16CUEFq55sVP+kR+iS1r55I0IixNl79w1Vcdn5NDylmFEu+wv7KstutHbmvfWXlZ32ws0lMk/1qhSIZ3QkxnsmkfBOm5VMmvl5xeTpdsUdyZAByKxV97GLQP+TUFGfr6I88tvBCESx56u5N/cfcueLuFYjIoWuw7zREhetBVMAOVrQGet65F9Nu8BlkYaea11k1d2ZHPAxCGYZKNsgjsIlh6YA5yVCKd1vKwscVSZ4TQrJIg8QzQcumnQ0h7rcx0hZEmT8N1gu1jSO8nBdqglrHm2DxZIrO67HK0i4XxXmTpWHtYDMRno618GFXlsizeF2jeaIuJ1HPDsSkQKwVzXBgUBMlwD1XTf2p4juHR9FBUhqiABVGyVTdXpvU4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:08:57.5658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f226b3e-fc7b-418c-2bab-08df3ee8b989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578

Use guard() helper for mutex handling instead of explicit
mutex_lock()/mutex_unlock() sequences.

This removes the need for explicit unlocks and the
error-path labels that only existed to release the mutex,
simplifying the control flow

No functional change intended

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c   | 15 +++++----------
 drivers/iio/adc/xilinx-xadc-events.c | 23 ++++++++---------------
 drivers/iio/adc/xilinx-xadc.h        |  6 ++----
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index ea874420b940..093a7172cc06 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -583,9 +583,8 @@ static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u1
 {
 	int ret;
 
-	mutex_lock(&xadc->mutex);
+	guard(mutex)(&xadc->mutex);
 	ret = _xadc_update_adc_reg(xadc, reg, mask, val);
-	mutex_unlock(&xadc->mutex);
 
 	return ret;
 }
@@ -675,13 +674,12 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 	unsigned int val;
 	int ret = 0;
 
-	mutex_lock(&xadc->mutex);
+	guard(mutex)(&xadc->mutex);
 
 	if (state) {
 		/* Only one of the two triggers can be active at a time. */
 		if (xadc->trigger != NULL) {
-			ret = -EBUSY;
-			goto err_out;
+			return -EBUSY;
 		} else {
 			xadc->trigger = trigger;
 			if (trigger == xadc->convst_trigger)
@@ -691,7 +689,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 		}
 		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC, convst);
 		if (ret)
-			goto err_out;
+			return ret;
 	} else {
 		xadc->trigger = NULL;
 	}
@@ -706,10 +704,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 		xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
 	}
 
-err_out:
-	mutex_unlock(&xadc->mutex);
-
-	return ret;
+	return 0;
 }
 
 static const struct iio_trigger_ops xadc_trigger_ops = {
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index f5b5aad6e313..f20614edd153 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -129,7 +129,7 @@ int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spe
 	u16 cfg, old_cfg;
 	int ret;
 
-	mutex_lock(&xadc->mutex);
+	guard(mutex)(&xadc->mutex);
 
 	if (state)
 		xadc->alarm_mask |= alarm;
@@ -140,7 +140,7 @@ int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spe
 
 	ret = _xadc_read_adc_reg(xadc, XADC_REG_CONF1, &cfg);
 	if (ret)
-		goto err_out;
+		return ret;
 
 	old_cfg = cfg;
 	cfg |= XADC_CONF1_ALARM_MASK;
@@ -148,12 +148,9 @@ int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spe
 	cfg &= ~((xadc->alarm_mask & 0x08) >> 3); /* ot */
 	cfg &= ~((xadc->alarm_mask & 0x07) << 1); /* temp, vccint, vccaux */
 	if (old_cfg != cfg)
-		ret = _xadc_write_adc_reg(xadc, XADC_REG_CONF1, cfg);
+		return _xadc_write_adc_reg(xadc, XADC_REG_CONF1, cfg);
 
-err_out:
-	mutex_unlock(&xadc->mutex);
-
-	return ret;
+	return 0;
 }
 
 int xadc_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
@@ -194,7 +191,7 @@ int xadc_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec
 	if (val < 0 || val > 0xffff)
 		return -EINVAL;
 
-	mutex_lock(&xadc->mutex);
+	guard(mutex)(&xadc->mutex);
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
@@ -204,7 +201,6 @@ int xadc_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec
 		xadc->temp_hysteresis = val;
 		break;
 	default:
-		mutex_unlock(&xadc->mutex);
 		return -EINVAL;
 	}
 
@@ -230,14 +226,11 @@ int xadc_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec
 		ret = _xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(offset + 4),
 					  xadc->threshold[offset + 4]);
 		if (ret)
-			goto out_unlock;
+			return ret;
 	}
 
 	if (info == IIO_EV_INFO_VALUE)
-		ret = _xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(offset), val);
+		return _xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(offset), val);
 
-out_unlock:
-	mutex_unlock(&xadc->mutex);
-
-	return ret;
+	return 0;
 }
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index f5bf2d08eedc..90fa3e77b1a5 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -101,9 +101,8 @@ static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *va
 {
 	int ret;
 
-	mutex_lock(&xadc->mutex);
+	guard(mutex)(&xadc->mutex);
 	ret = _xadc_read_adc_reg(xadc, reg, val);
-	mutex_unlock(&xadc->mutex);
 	return ret;
 }
 
@@ -111,9 +110,8 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 {
 	int ret;
 
-	mutex_lock(&xadc->mutex);
+	guard(mutex)(&xadc->mutex);
 	ret = _xadc_write_adc_reg(xadc, reg, val);
-	mutex_unlock(&xadc->mutex);
 	return ret;
 }
 
-- 
2.34.1

