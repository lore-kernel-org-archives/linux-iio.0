Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015100;
	b=1VXbdq8qKo752gM6i+AyijNvziP6bll6LJ+Ybo1e3wY7PSD+HDPxOcL4uhS9cwH9UOZ/
	 mihZRnFW0b+S8GJaBB5zxeosgZiV+4gaiU+jw/ykmBhEpnzrsQt5Lt8e/RpdpQgKfUcW6
	 +NnQn2koInxaN+w+nEdG8js5b1GS1PNocvfrG0tmBjatL1KKNiPXnGLj/WkF8QY13pPzw
	 tuQiR8JBxs4c+MAvqb85TBWed4WTEY+JfNBDBn4h/j4ztstUcvA/qGAI2ymRqfy/uXfZA
	 sv2vmhmqzKfi2Kafwc+5itThtY9ZjIzGXWot6ffcbupH8Nap0u5tPqZ9M0uNrGWOk+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015100;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xs5AuDgdgAppthIFP1A2EtcvvBqfNAfjw2cM9M95uZE=;
	b=AWiJXwiVlNTv2ebFFVLHxE7dupLFaeWyLUbWe5jco48EtTDFJORLg8dHcSgGyGeTbSpG
	 E67+60dbk/CPLehXGZPyCqGhI6Br+POBjpRW2rK3m+bKf4AV3ru+o+rsGfyNd9OARDjVL
	 XGpKlFouWD7Ndrfhs2bsrVtzrRdDigETPCp7qUKIeV/Llmwn/PTUt1xVffTubPQT9CPA9
	 tT8syA5nUAIjDSc3YZhdyvMTyE+NYmiuiGzDqvnDvIHL9zFDPpsfNEQq0wtBnUHfjPq3G
	 jBVIgq8DmMDANVtKHBbURdcmAnVzE6gkJI3AceGhGQRiGDMypV8hGqAxKCUmdf7Suwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Ac3LDLGs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.3
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6960A5BC7;
	Wed, 18 Nov 2026 15:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FC6960A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Ac3LDLGs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntwBZNoL34XfU6uG7M4kFGe6RdnGtdV8TArmDBGFOMzkuign9AWSp+2U3b7YpE7TM8jvSBwBf4nESQTSUe3qGpx9KM5kmJe9ip6My3eYUogiR4gLCPHm9EqHTpXMzuBGWWhpvhVoIKBUhTCrR9pB29StppI5rPe5asVc3EekAnVTR/rpZS7G6cZJD+/ewdOVVTBMEvnIIVB5I4kg04fzEWgLb8362fFKnAWlhOF2tMMeQ307joENwEliBKDWeihiHQDgpY2mDqHPqVVpEfYEgtH2qZ+KKbl2rGgYtS4i91Ec9cxM29PR0YtdiwkdpDUtZwn0WmpmB+eito6SAL9GxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs5AuDgdgAppthIFP1A2EtcvvBqfNAfjw2cM9M95uZE=;
 b=S6V9Q8ZG4FD2boYMkOIb6OKbWsgF6gnhb4sSiVpTickEsP8fJAMmVjOPWeHFnM2aDQw05Mm/Vla7COL/qQRT+oMGIinHs+dxfVjoaBvPjnZKd/b9/l82CrgPv8BQdyNUbTvtiFyhPvJkzXNblA9MLx/3YEqL4Lbn3wiQx7oJ5LY7blez0Ie+zAHlP4cGimMtAXYKoSwalfbBuPWr+ijUK3Yq6KuNJbbBrAREHAb0ZwvzsXhaKxMzZA8hiHBIchYlgTgSsneBTricAp647hWGG22OzZWQ2J1/0CrtXc9a0/+3IAxQNlKkEiU/83jVHFpUyqwcD0sfdW9OOLqDWne/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs5AuDgdgAppthIFP1A2EtcvvBqfNAfjw2cM9M95uZE=;
 b=Ac3LDLGsFAYBT2jdTazciBzMsxbfCzhk0EY92qYszvmG+BoKKGeUpzMwlK9qspckyEBLw1GqO5mClMvR0ye8ioy9klunlrsIO4lr6edlD7jbDigMa05FDKBoyKsX8RnllcXp+w79ComJyztADC47EH9TQUGdNZNDKLNCiRLkcA5hZmGa2aWhG1PiQMLFi7nNqJCMqQmzEFKLfqosrZw3Wo3rMnOvFhvUaYFdUbrhxRxRFhqH7Y+rAIr9f7ac4hPmEs/F0HWG5QMLFIJ9iWsz2rO6jVcFZ1YWouQx49pMMmt63YSIaRa/Ufu8fIzuWQPgqI9TpZoZOuZybXyAzV6/pQ==
Received: from DU6P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::21)
 by AM8PR10MB4065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Wed, 18 Nov
 2026 15:18:13 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::4c) by DU6P191CA0004.outlook.office365.com
 (2603:10a6:10:540::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:18:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:13 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:18:50 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:05 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:52 +0100
Subject: [PATCH v2 07/11] iio: adc: stm32-mdf: add direct iio conversion
 support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261118-upstream_mdf_v2-v2-7-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
In-Reply-To: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, "Arnaud
 Pouliquen" <arnaud.pouliquen@foss.st.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-sound@vger.kernel.org>, "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AM8PR10MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b9a662-9746-4ed9-a156-08df458729f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|18092099006|18002099003|22082099003|6133799003|921020|11063799006|56012099006|10067099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	KVZzfekzzgseAbnFGdoS6uvrCNmU3AucZiigDwkLyGe3OzdjfPI5gISNaiAGUX7srXGso6dhM8e9qcnjlk3FFLYXk2IgkOPLUAOOSbv44WAbYn5Fc+J+oF3vb3/f0HnrT0m6mw4CWSkBwvU52MMWNTk0VcIKYacmOR9eKZHHA0x0F8gZEjzV33bD5KHAa/BFiO08Hk27fXpZxYTlRRE3O5N8TDCcNQJjuPEbUhSRmoOd7V6P0D2dPxS+HfL2oZlZXuUqU8ca8cVTpHszu36O2hkTU5kdmuAYFnXfrCGzkh+ic3ZdHYljr40Vb8fo3P6GzjoQn43MljBGjRmIq1iceImUlYuZ/7hGAhOW4Y1zQVxUZ7919obknb4B8QloW6FIP4FmXi2INpEn8/5PraFyahY3lRPWefLRgXPuwVYREW4PYhqCqUopcrrCXoVdvTQx91SoSiqqU9tqfJK/nGVeRaKCovW5zWz25VqcPC/co8D2rmftD7CilgujIvC7On9eAibKgcpY877wKaDTTP8D9mCKSkWfF5ftKdwb6BLgBmSF/t8QqIUJ/waO/8VQQOMZcwQOaA6mICwlwY3zEKVPBEUMJLEUmFcHx5IiM2gGf4kXLG3bRZlwK0vm0GLJMhA/EknxdtgCAoKT2Obx9b3JcSfbxe9ToDi48QsMWy1Zp6ZGfS0PKc3Ig1nKBCkqkV69aT0gksg4QuFBLkv7+0E/nPJpEKHofm1dCX9Jm2GK2805wKYTzc4wB8T97zKRhGCa
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(18092099006)(18002099003)(22082099003)(6133799003)(921020)(11063799006)(56012099006)(10067099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DBjSDK51nqhw/P+/NyoH0sYePGvTyVl5LezIL87oRN8jswzAe9lPdsvjW5Fqj15tqEf4+saeHFSxTyFth98h2XBEbolZcUkCsMDu+/zmU57ewcA4FIjP5hYbS37UjRIyab1Gdm8NU5HrH2On1mFMqsYs/W9YAuWDLH1djTIWSr4bZlGXGGusyBPSnZMHXBoKKgRTcUYJBLWtBpQWEOwXl2T1rXUByAXDuu2uuCM20O3Z8sH98oYpX4IN/40V6yNoD8VU+9LY+gqYEPGI+4U9Cc8dUp2QQtE0ieFJMMGUXKBVGaudBQkass7JmNE7VSzDr9qAOvMG27jCx1WkiNltNW0RgRnFX6uOd+oeH1Y5niPzKPjB1JLgWYB49OCtZNNqBwqm/GFg5cDCZy4Wky9dDXK8xak0HbK3M4MGCjCBKRsPKhHoH12ZVsFmcy7yjPEt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:13.5663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b9a662-9746-4ed9-a156-08df458729f5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4065

Add single-conversion acquisition and the IIO accessors for raw samples,
scale, offset, sampling frequency and channel labels. Obtain analog scale
and offset information from the associated IIO backend.

Coordinate the MDF core, serial interface and digital filters when starting
and stopping conversions.

Initialize channel and analog IIO backends.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-mdf-adc.c | 585 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 583 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-adc.c
index eae7a4fa1485..7361ce6182be 100644
--- a/drivers/iio/adc/stm32-mdf-adc.c
+++ b/drivers/iio/adc/stm32-mdf-adc.c
@@ -329,6 +329,79 @@ static struct stm32_mdf_adc *stm32_mdf_get_filter_by_handle(struct stm32_mdf *md
 	return NULL;
 }
 
+static int stm32_mdf_adc_start_filter(struct stm32_mdf_adc *adc)
+{
+	struct stm32_mdf_adc *adc_inter;
+	struct stm32_mdf *mdf = adc->mdf;
+	u32 val;
+
+	if (MDF_IS_FILTER0(adc))
+		list_for_each_entry(adc_inter, &mdf->filter_list, entry)
+			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
+				stm32_mdf_adc_start_filter(adc_inter);
+
+	/* Check filter status. Bypass cache to access volatile MDF_DFLTCR_ACTIVE bit */
+	regcache_cache_bypass(adc->regmap, true);
+	regmap_read(adc->regmap, MDF_DFLTCR_REG, &val);
+	regcache_cache_bypass(adc->regmap, false);
+	if (val & MDF_DFLTCR_ACTIVE) {
+		dev_err(adc->dev, "Filter [%d] is already running\n", adc->fl_id);
+		return -EBUSY;
+	}
+
+	return regmap_set_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_DFLTEN);
+}
+
+static void stm32_mdf_adc_stop_filter(struct stm32_mdf_adc *adc)
+{
+	struct stm32_mdf_adc *adc_inter;
+	struct stm32_mdf *mdf = adc->mdf;
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_DFLTEN);
+
+	if (MDF_IS_FILTER0(adc))
+		list_for_each_entry(adc_inter, &mdf->filter_list, entry)
+			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
+				stm32_mdf_adc_stop_filter(adc_inter);
+}
+
+static int stm32_mdf_adc_filter_set_mode(struct stm32_mdf_adc *adc, bool cont)
+{
+	struct stm32_mdf_adc *adc_inter;
+	u32 mode;
+
+	if (MDF_IS_FILTER0(adc)) {
+		list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry) {
+			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
+				stm32_mdf_adc_filter_set_mode(adc_inter, cont);
+		}
+	}
+
+	if (adc->synced || MDF_IS_INTERLEAVED_FILT(adc)) {
+		if (cont)
+			mode = STM32_MDF_ACQ_MODE_SYNC_CONT;
+		else
+			mode = STM32_MDF_ACQ_MODE_SYNC_SINGLE_SHOT;
+	} else {
+		if (cont)
+			mode = STM32_MDF_ACQ_MODE_ASYNC_CONT;
+		else
+			/*
+			 * The expected mode would be STM32_MDF_ACQ_MODE_ASYNC_SINGLE_SHOT here.
+			 * However, there is an instability depending on "bus/kernel clock ratio"
+			 * in this mode.
+			 * Use STM32_MDF_ACQ_MODE_SYNC_SINGLE_SHOT mode along with TRGO trigger,
+			 * as a workaround.
+			 */
+			mode = STM32_MDF_ACQ_MODE_SYNC_SINGLE_SHOT;
+	}
+
+	dev_dbg(adc->dev, "Set mode [0x%x] on filter [%d]\n", mode, adc->fl_id);
+
+	return regmap_update_bits(adc->regmap, MDF_DFLTCR_REG,
+				 MDF_DFLTCR_ACQMOD_MASK, FIELD_PREP(MDF_DFLTCR_ACQMOD_MASK, mode));
+}
+
 static int stm32_mdf_adc_compute_scale(struct device *dev, unsigned int decim,
 				       unsigned int order, unsigned int data_size)
 {
@@ -606,7 +679,7 @@ static int stm32_mdf_adc_check_clock_config(struct stm32_mdf_adc *adc, unsigned
 	return ret;
 }
 
-static int __maybe_unused mdf_adc_set_samp_freq(struct iio_dev *indio_dev)
+static int mdf_adc_set_samp_freq(struct iio_dev *indio_dev)
 {
 	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
 	struct device *dev = &indio_dev->dev;
@@ -675,6 +748,483 @@ static int __maybe_unused mdf_adc_set_samp_freq(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static int stm32_mdf_adc_start_mdf(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = clk_prepare_enable(adc->sitf->sck);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to enable clock %s\n",
+			__clk_get_name(adc->sitf->sck));
+		return ret;
+	}
+
+	ret = mdf_adc_set_samp_freq(indio_dev);
+	if (ret < 0)
+		goto err;
+
+	ret = stm32_mdf_core_start_mdf(adc->mdf);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+
+err:
+	clk_disable_unprepare(adc->sitf->sck);
+
+	return ret;
+}
+
+static void stm32_mdf_adc_stop_mdf(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	stm32_mdf_core_stop_mdf(adc->mdf);
+
+	clk_disable_unprepare(adc->sitf->sck);
+}
+
+static int stm32_mdf_adc_start_conv(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = stm32_mdf_sitf_start(adc->sitf);
+	if (ret < 0)
+		return ret;
+
+	ret = stm32_mdf_adc_start_filter(adc);
+	if (ret < 0)
+		goto stop_sitf;
+
+	if (adc->trgo) {
+		ret = stm32_mdf_core_trigger(adc->mdf);
+		if (ret < 0)
+			goto stop_filter;
+	}
+
+	return 0;
+
+stop_filter:
+	stm32_mdf_adc_stop_filter(adc);
+stop_sitf:
+	stm32_mdf_sitf_stop(adc->sitf);
+
+	return ret;
+}
+
+static void stm32_mdf_adc_stop_conv(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	stm32_mdf_adc_stop_filter(adc);
+
+	stm32_mdf_sitf_stop(adc->sitf);
+}
+
+static int stm32_mdf_channel_parse_of(struct iio_dev *indio_dev, struct fwnode_handle *node,
+				      struct iio_chan_spec *ch)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct iio_backend *backend;
+	const char *label = fwnode_get_name(node);
+	int ret;
+	u32 stu = 0;
+
+	ret = fwnode_property_read_u32(node, "reg", &ch->channel);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to read channel index: [%d]\n", ret);
+		return ret;
+	}
+
+	if (fwnode_property_present(node, "label")) {
+		/* label is optional */
+		ret = fwnode_property_read_string(node, "label", &label);
+		if (ret < 0) {
+			dev_err(&indio_dev->dev,
+				" Error parsing 'label' for idx %d\n", ch->channel);
+			return ret;
+		}
+	}
+	adc->channels[ch->scan_index].channel_name = label;
+
+	/* settling-time-us is optional */
+	if (fwnode_property_present(node, "settling-time-us")) {
+		/*
+		 * The settling time is relevant only for the first channel. In case of interleaved
+		 * channels, the settling time of the first configured channel, is applied to other
+		 * channels.
+		 */
+		if (!ch->scan_index) {
+			ret = fwnode_property_read_u32(node, "settling-time-us", &stu);
+			if (ret < 0) {
+				dev_err(&indio_dev->dev, "Failed to read settling time: [%d]\n",
+					ret);
+				return ret;
+			}
+
+			adc->stu = stu;
+		}
+	}
+
+	if (adc->dev_data->type == STM32_MDF_IIO) {
+		backend = devm_iio_backend_fwnode_get(&indio_dev->dev, NULL, node);
+		if (IS_ERR(backend))
+			return dev_err_probe(&indio_dev->dev, PTR_ERR(backend),
+					     "Failed to get backend\n");
+		adc->channels[ch->scan_index].backend = backend;
+	}
+
+	return ret;
+}
+
+static int stm32_mdf_adc_chan_init_one(struct iio_dev *indio_dev, struct fwnode_handle *node,
+				       struct iio_chan_spec *ch, int idx)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ch->type = IIO_VOLTAGE;
+	ch->indexed = 1;
+	ch->scan_index = idx;
+
+	ret = stm32_mdf_channel_parse_of(indio_dev, node, ch);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Failed to parse channel [%d]\n", idx);
+		return ret;
+	}
+
+	if (adc->dev_data->type == STM32_MDF_IIO) {
+		ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
+					 BIT(IIO_CHAN_INFO_OFFSET);
+		ch->scan_type.shift = 8;
+	}
+
+	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	ch->scan_type.sign = 's';
+	ch->scan_type.realbits = STM32_MDF_DATA_RES;
+	ch->scan_type.storagebits = 32;
+
+	return 0;
+}
+
+static int stm32_mdf_adc_chan_init(struct iio_dev *indio_dev, struct iio_chan_spec *channels)
+{
+	struct fwnode_handle *child;
+	int chan_idx = 0, ret;
+
+	device_for_each_child_node(indio_dev->dev.parent, child) {
+		/* Skip the child nodes with a compatible. (e.g. DAI node for audio) */
+		if (fwnode_property_present(child, "compatible"))
+			continue;
+
+		ret = stm32_mdf_adc_chan_init_one(indio_dev, child, &channels[chan_idx], chan_idx);
+		if (ret < 0) {
+			fwnode_handle_put(child);
+			return dev_err_probe(&indio_dev->dev, ret, "Channels [%d] init failed\n",
+					     chan_idx);
+		}
+
+		chan_idx++;
+	}
+
+	return chan_idx;
+}
+
+static int stm32_mdf_adc_single_conv(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan, int *res)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	long timeout;
+	bool save_trgo = adc->trgo;
+	int ret;
+
+	reinit_completion(&adc->completion);
+
+	ret = stm32_mdf_adc_start_mdf(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_set_bits(adc->regmap, MDF_DFLTIER_REG, MDF_DFLTIER_FTHIE_MASK);
+	if (ret < 0)
+		goto err_conv;
+
+	stm32_mdf_adc_filter_set_mode(adc, false);
+
+	/* Force trgo as a workaround for STM32_MDF_ACQ_MODE_ASYNC_SINGLE_SHOT mode */
+	adc->trgo = true;
+
+	ret = stm32_mdf_adc_start_conv(indio_dev);
+	if (ret < 0) {
+		regmap_update_bits(adc->regmap, MDF_DFLTIER_REG, MDF_DFLTIER_FTHIE_MASK, 0);
+		goto err_conv;
+	}
+
+	timeout = wait_for_completion_interruptible_timeout(&adc->completion, STM32_MDF_TIMEOUT_MS);
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTIER_REG, MDF_DFLTIER_FTHIE_MASK);
+
+	if (timeout == 0) {
+		dev_err(&indio_dev->dev, "Timeout reached on channel [%d]", chan->channel);
+		ret = -ETIMEDOUT;
+		goto stop_conv;
+	} else if (timeout < 0) {
+		ret = timeout;
+		goto stop_conv;
+	} else {
+		ret = IIO_VAL_INT;
+	}
+
+	if (MDF_IS_INTERLEAVED_FILT(adc))
+		*res = adc->buffer[chan->channel];
+	else
+		*res = adc->buffer[0];
+
+stop_conv:
+	stm32_mdf_adc_stop_conv(indio_dev);
+
+err_conv:
+	adc->trgo = save_trgo;
+
+	stm32_mdf_adc_stop_mdf(indio_dev);
+
+	return ret;
+}
+
+static int stm32_mdf_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				   int val, int val2, long mask)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ || !val)
+		return -EINVAL;
+
+	{
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		/* Set requested_sample_freq right now, as used by mdf_adc_set_samp_freq() */
+		adc->requested_sample_freq = val;
+
+		if (adc->dev_data->type == STM32_MDF_IIO) {
+			ret = stm32_mdf_core_lock_kclk_rate(adc->mdf);
+			if (!ret) {
+				ret = mdf_adc_set_samp_freq(indio_dev);
+
+				stm32_mdf_core_unlock_kclk_rate(adc->mdf);
+			}
+		}
+	}
+
+	if (ret)
+		adc->requested_sample_freq = 0;
+
+	return ret;
+}
+
+static int stm32_mdf_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				  int *val, int *val2, long mask)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int idx = chan->scan_index;
+	int max = BIT(STM32_MDF_DATA_RES - 1) - 1;
+	int scale, offset;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		if (adc->channels[idx].backend) {
+			ret = iio_backend_enable(adc->channels[idx].backend);
+			if (ret)
+				return ret;
+		}
+
+		ret = stm32_mdf_adc_single_conv(indio_dev, chan, val);
+
+		if (adc->channels[idx].backend)
+			iio_backend_disable(adc->channels[idx].backend);
+
+		return ret ? ret : IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adc->sample_freq;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Vconv = (raw>>shift + offset) * scale.
+		 * scale = Vref * k / 2^res (denominator is managed through FRACTIONAL_LOG2 type)
+		 * k correspond to the ratio between max resolution and actual filter maximum
+		 * k = max / dflt_max
+		 * max = 2^(res - 1) - 1
+		 * max_dflt = D^N * gain_lin * gain_rsflt
+		 * scale = Vref * max / dflt_max
+		 */
+		if (adc->channels[idx].backend) {
+			ret = iio_backend_read_scale(adc->channels[idx].backend, chan,
+						     &scale, NULL);
+			if (ret < 0)
+				return ret;
+
+			*val = div_u64((u64)scale * max, adc->dflt_max);
+
+			*val2 = chan->scan_type.realbits;
+			if (chan->differential)
+				*val *= 2;
+		} else {
+			return -EPERM;
+		}
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_OFFSET:
+		if (adc->channels[idx].backend) {
+			ret = iio_backend_read_offset(adc->channels[idx].backend, chan,
+						      &offset, NULL);
+			if (ret < 0)
+				return ret;
+
+			*val = offset;
+			if (!chan->differential)
+				*val += adc->dflt_max;
+		} else {
+			return -EPERM;
+		}
+
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int stm32_mdf_adc_read_label(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				    char *label)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	const char *name = adc->channels[chan->scan_index].channel_name;
+
+	return sysfs_emit(label, "%s\n", name);
+}
+
+static const struct iio_info stm32_mdf_info_adc = {
+	.write_raw = stm32_mdf_adc_write_raw,
+	.read_raw = stm32_mdf_adc_read_raw,
+	.read_label = stm32_mdf_adc_read_label,
+};
+
+static irqreturn_t stm32_mdf_irq(int irq, void *arg)
+{
+	struct iio_dev *indio_dev = arg;
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev), *adc_inter;
+	struct regmap *regmap = adc->regmap;
+	u32 *ptr = adc->buffer;
+	u32 isr, ier, flags;
+
+	regmap_read(regmap, MDF_DFLTISR_REG, &isr);
+	regmap_read(regmap, MDF_DFLTIER_REG, &ier);
+
+	flags = isr & ier;
+	if (!flags)
+		return IRQ_NONE;
+
+	if (flags & MDF_DFLTISR_FTHF_MASK) {
+		/* Reading the data register clear the IRQ status */
+		regmap_read(regmap, MDF_DFLTDR_REG, ptr++);
+
+		if (MDF_IS_FILTER0(adc))
+			list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry)
+				if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
+					regmap_read(regmap, MDF_DFLTDR_REG, ptr++);
+
+		complete(&adc->completion);
+	}
+
+	if (flags & MDF_DFLTISR_DOVRF_MASK) {
+		dev_warn(&indio_dev->dev, "Data overflow detected\n");
+		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_DOVRF_MASK);
+	}
+
+	if (flags & MDF_DFLTISR_RFOVRF_MASK) {
+		dev_warn(&indio_dev->dev, "Reshape filter overrun detected\n");
+		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_RFOVRF_MASK);
+	}
+
+	if (flags & MDF_DFLTISR_SATF_MASK) {
+		dev_warn(&indio_dev->dev, "Saturation detected\n");
+		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_SATF_MASK);
+
+		/* Notify only once */
+		regmap_clear_bits(adc->regmap, MDF_DFLTIER_REG, MDF_DFLTIER_SATIE_MASK);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int stm32_mdf_adc_init(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct iio_chan_spec *ch = NULL;
+	unsigned int num_ch;
+	int ret;
+
+	num_ch = device_get_child_node_count(indio_dev->dev.parent);
+	if (num_ch) {
+		/* Filter0 may have several channels in interleaved mode */
+		if (num_ch > 1) {
+			if (!MDF_IS_FILTER0(adc)) {
+				dev_err(dev, "Too many channels for filter [%d]\n", adc->fl_id);
+				return -EINVAL;
+			} else if (num_ch != adc->mdf->nb_interleave) {
+				dev_err(dev, "Unexpected channels number for filter0: [%d]\n",
+					num_ch);
+				return -EINVAL;
+			}
+		}
+
+		ch = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*ch), GFP_KERNEL);
+		if (!ch)
+			return -ENOMEM;
+
+		adc->channels = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*adc->channels),
+					     GFP_KERNEL);
+		if (!adc->channels)
+			return -ENOMEM;
+
+		ret = stm32_mdf_adc_chan_init(indio_dev, ch);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Channels init failed\n");
+	}
+
+	indio_dev->num_channels = num_ch;
+	indio_dev->channels = ch;
+
+	init_completion(&adc->completion);
+
+	return 0;
+}
+
+static const struct stm32_mdf_dev_data stm32h7_mdf_adc_data = {
+	.type = STM32_MDF_IIO,
+	.init = stm32_mdf_adc_init,
+};
+
+static const struct of_device_id stm32_mdf_adc_match[] = {
+	{
+		.compatible = "st,stm32mp25-mdf-adc",
+		.data = &stm32h7_mdf_adc_data,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, stm32_mdf_adc_match);
+
 static int stm32_mdf_get_sitf(struct device *dev, struct stm32_mdf_adc *adc,
 			      struct fwnode_handle *sitf_node)
 {
@@ -857,11 +1407,13 @@ static int stm32_mdf_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct stm32_mdf_adc *adc;
+	const struct stm32_mdf_dev_data *dev_data;
 	struct iio_dev *iio;
 	struct resource *res;
 	void __iomem *base;
-	int ret;
+	int ret, irq;
 
+	dev_data = device_get_match_data(dev);
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!iio) {
 		dev_err(dev, "Failed to allocate IIO device\n");
@@ -883,13 +1435,41 @@ static int stm32_mdf_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->regmap))
 		return dev_err_probe(dev, PTR_ERR(adc->regmap), "Failed to init regmap\n");
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+	ret = devm_request_irq(dev, irq, stm32_mdf_irq, 0, pdev->name, iio);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+
 	ret = stm32_mdf_adc_parse_of(pdev, adc);
 	if (ret < 0)
 		return ret;
 
+	iio->info = &stm32_mdf_info_adc;
+	iio->name = dev_name(&pdev->dev);
+
 	adc->dev = dev;
+	adc->dev_data = dev_data;
+	ret = dev_data->init(dev, iio);
+	if (ret < 0)
+		goto err_clean_list;
+
+	if (!MDF_IS_INTERLEAVED_FILT_NOT_0(adc)) {
+		ret = iio_device_register(iio);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "Failed to register IIO device: %d\n", ret);
+			goto err_clean_list;
+		}
+	}
 
 	return 0;
+
+err_clean_list:
+	list_del(&adc->entry);
+
+	return ret;
 }
 
 static void stm32_mdf_adc_remove(struct platform_device *pdev)
@@ -906,6 +1486,7 @@ static void stm32_mdf_adc_remove(struct platform_device *pdev)
 static struct platform_driver stm32_mdf_adc_driver = {
 	.driver = {
 		.name = "stm32-mdf-adc",
+		.of_match_table = stm32_mdf_adc_match,
 	},
 	.probe = stm32_mdf_adc_probe,
 	.remove = stm32_mdf_adc_remove,

-- 
2.43.0

