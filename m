Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626696;
	b=JUX2g15CLaDkstgAtKivSxlBj+xSW0f6SjPiKK/zsH9vNqbzZ0myhH0A++tkPTjCYmei
	 lvJ00RCVvE7j/xI3KtOkR0L9lTho8mCJGCUOsxUaB34elBqgolZrhDQa6RGRDBipQSydX
	 vkMGyUm0xDNdfWzEimFAtE5tkQyF8pz3Lgr0+8VZsIW2+7iAYmHd8v0kxb0tHZ5eWj63E
	 3AMEDq+FJQtagUrAQesihdbEPZbda/CGYdNOwyLKHdGAX1AWZnE9TvHB+KanEPYP4RhBT
	 RvL+SgP9FauzSTIOr4EUGXQN/eDFB9kP1V6qx/zhc3pOG1TmQauqC/R3G9Quuwp0ajw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626696;
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
	bh=Xq0/Hv6MQBFCONqOYVAgGXqEmU4W7t1RKgGBKefg7GU=;
	b=IygjCK/ehFtWXs1Ue9lm88UyvTSstA7cBA0qkEU61WwX7kWFXtbqsvVFp2bKpnqO7HaZ
	 AjNt43dpDai47l652zmwEakUW2ZhN5qtH4+zVkFq4RYXzhgOqHaHgs0nWu9x8sNortyNt
	 PrUIJ6HDlopcGVXMoQxl2kqXQoYQPkEnzX3ptbHRCvsPCuly/RjhKRRJA8P7gEYebMRzq
	 T8iSyrOX9XAx6w/hotjidj8xV0VLZMhY/o/FxANVG6c7fNUY2rBllQbV04X41oyanl2FA
	 fLhJZPhI93zZFrpRcp7WhMLauyRdNdxyZtQIUuO1vAlWavJLY9wc7u5BOwwtwNiwFBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q+KbLxlf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.40
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D202606A31E;
	Wed, 25 Nov 2026 17:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D202606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=q+KbLxlf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh4FjQFNe0LakgNkLiNk/Udc85ipr8q5B1nvbsoN3Dr3HCFz++fvucVP3i/pyB2Tp3VcJsWaIO2Nit8K4hvYMgcW0D6vZOUN/mLPlHZKgK2kg4jV07Liy3qlWp5uz8TY0av8DyzOdpREMdyig8+dCPVOAIboYwKkSiI5vIPDApgClHUdUAdgbVob5LIMFOeYHy00HrxcmE9L6Lfzyf6p4iVJsuDZJNyr1qmIMDifma+ZIpuc6GnquR9fuwJ7ULkjjRNdHrx9fZ9wy9l87FP93NhhSIXqUw1KNCio3R8whxFOWpaOiz81pFN/6wr/sz2YQVD7AzivhBNLnUyW8BkZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq0/Hv6MQBFCONqOYVAgGXqEmU4W7t1RKgGBKefg7GU=;
 b=EsTimOYpshvQ+STskYlNhjKEG/UKJ/WwXkF/ekMmGQGpEC2/cbY0MAQQoVcIh0sJERGf7GvskngAifJL8BD/rA4OAVaMS0js+4Mg90vc5tdg9NwhDLis5MxMPisZfoDYqomca7t0mvAQvGJY5BVoYOrW5ZeoDatoxzwbtN0i87GUwbebdg2lLrOPThGmJNrLmkzQqbum6Qtq5Pm9QWqQ/ioy8mFrJsSjM1jD5vAIWnfcjA7Skz0m9YHSgLZhadCOrfevm2G/0f9UeVuH5gYfQiaoj3RkMBlVZL/R3JA+q2gzy4nH3c5BPQdLJADj277dAL+WyL6GLOsIuLpPlUfW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq0/Hv6MQBFCONqOYVAgGXqEmU4W7t1RKgGBKefg7GU=;
 b=q+KbLxlfQ4dck4RjzPucFY1FWG2fHG1VDIMXcIAy+GrxTJAgqF5ejXYJ/433Hbm7kiBGdda/LSXRwGzDDEDfYY4FYU6XBBQoeinVGGm9HioH7eWC/ofWB2u6ovk5XjVzCIa28At6Rd502kXQvUDEs3DHoIqWXeBcIECfz/pwVjg=
Received: from MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::22)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 17:11:31 +0000
Received: from BY1PEPF00026966.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::40) by MW4P222CA0017.outlook.office365.com
 (2603:10b6:303:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:11:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026966.mail.protection.outlook.com (10.167.244.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:11:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:27 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:24 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v6 08/16] iio: adc: xilinx-xadc: Use guard() for mutex locking
Date: Wed, 25 Nov 2026 22:40:22 +0530
Message-ID: <20261125171045.1246381-9-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026966:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e35771-10fa-42cd-e57c-08df4b17263a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|6133799003|261009223027099003|22082099003|18002099003|10067099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	pgGwC/nX6RDbMiqD5BF56jSutBjr00FYtnarE2d8zRQ4T/+g4x0216Dr1i8kJnfFeE2mazBJ6LmzFtL257k2BVAmg3pyaqNbrMx5oLBLEYrbjqzOMR4cBxiH7m2Ghv8ltY05VIpDL5Q6NUCip9XiNIuOy732hAxUDthtHLL5acmc7irH8qgEnmyCMX9jidBS76xdCBKVZ+aeRCeYFyMdrcTKJ2C4FKQjj2629aueZeWwJksFZT14ECjIyiGjFj8ky6A0ho0SxzAn8pcZeRFKP3nQdyMyxoLGNLLni4MuUrmcx1dPhsZitGmZCHLSpC6/6Kd3xY5dWwZKRFv9fvBsHYj14oz/F4L2beSrSCXcXSZkp7FImQAlyzKW8sGx+AwvZZ4Ho+6hkcowX1GEPag1aqZv/xN7ZtqJrztwudbXjaP4XaqIfnMPseHtiXwuVKOSFfWkqYB7cmcwlTUBpgx+8Jufdc99M8kEmSg1+RCYaPWNVbrvvTe2UyJUjjoVHuMhqu12VZZwknBAecYUR1typqGPKf6dz7edLxTlwOn94CUCa6lkNwO1AbZ/Fk9z6+dRgnQIABsLj0ZQsyGx70rcZlFwHIkAOB6uvSySCoVh9DsjcLqn8hxW4D4vK6598/so5ZVG2xk7yaqMMR5i9Px/iaL7FQI454y8q90qgs8H2227J/i1Qbh02mjT8nVxEg+G7MrQJdmM2ucI2uvgZhUfDA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(6133799003)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/44ZbM0FJAILQ331tVN3f8d2ORYnERji7cRnwCNeDW5v3FMrq31mKuQa05MxQ1CuU9i/kTQvlTkkQoWMjl4YGXHPWvDs+j/aUepKJ3hqntrkd8AlegYo2Y/qbukkt8dzixIaQlnafVVf6JCEgBQEBqLCKG9BBrXxCLGMIP9Mdd3XWZKqCdB71qWFxN8AqAq6fPe/Kk4MhPgXJfHm4ALeRpqJ1LVLmZiUmyw87sNQO3aqVzTfHu68YxbAnIF9FFI8dPs9c75/IPojinnowmB6+I3bsqe4ZMsmcRxRrIICXEFJR3vkOgefzxS0mKgPKie2O5yEFCOEKuwuM4UC4ZaEKZaqHsQ/9/Ti4gzwfAWAghCbme4BuaNUarQMfYQquoVI6QM/pdyjLxv6j/aIRG6nzYUss2pfOqEFvQhaQk5KERYC3g1UqbwAqool/ThkuX3P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:30.6529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e35771-10fa-42cd-e57c-08df4b17263a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026966.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334

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
 drivers/iio/adc/xilinx-xadc-core.c   | 20 ++++++--------------
 drivers/iio/adc/xilinx-xadc-events.c | 23 ++++++++---------------
 drivers/iio/adc/xilinx-xadc.h        | 14 ++++----------
 3 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 2d36de97e8d4..99c83b49f32c 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -578,13 +578,9 @@ static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u
 
 static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
 {
-	int ret;
+	guard(mutex)(&xadc->mutex);
 
-	mutex_lock(&xadc->mutex);
-	ret = _xadc_update_adc_reg(xadc, reg, mask, val);
-	mutex_unlock(&xadc->mutex);
-
-	return ret;
+	return _xadc_update_adc_reg(xadc, reg, mask, val);
 }
 
 static unsigned long xadc_get_dclk_rate(struct xadc *xadc)
@@ -672,13 +668,12 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
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
@@ -688,7 +683,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 		}
 		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC, convst);
 		if (ret)
-			goto err_out;
+			return ret;
 	} else {
 		xadc->trigger = NULL;
 	}
@@ -703,10 +698,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
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
index 087c5c0bb0b2..4f412d60e3a5 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -99,22 +99,16 @@ static inline int _xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 v
 
 static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 {
-	int ret;
+	guard(mutex)(&xadc->mutex);
 
-	mutex_lock(&xadc->mutex);
-	ret = _xadc_read_adc_reg(xadc, reg, val);
-	mutex_unlock(&xadc->mutex);
-	return ret;
+	return _xadc_read_adc_reg(xadc, reg, val);
 }
 
 static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 {
-	int ret;
+	guard(mutex)(&xadc->mutex);
 
-	mutex_lock(&xadc->mutex);
-	ret = _xadc_write_adc_reg(xadc, reg, val);
-	mutex_unlock(&xadc->mutex);
-	return ret;
+	return _xadc_write_adc_reg(xadc, reg, val);
 }
 
 /* XADC hardmacro register definitions */
-- 
2.34.1

