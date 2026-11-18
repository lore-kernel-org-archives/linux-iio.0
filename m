Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015095;
	b=r0zsQEE8k7R8q6KZoXDAEnZFdTnzqttbk6I/qr7U08fOxFtLaKHl4EOIEK5rdoGQZKh1
	 wjpa1aC9LDvlE4wuZQqvY0xqjVSeoUUAzwvpShEp9lJwYMUhfG7X4m2woegBC/6QRJMDn
	 3uFqKSngpU4im7hPaq22B8pb+OKRPrqoCzpxzDdOo5j/eH6aG26vDJ0j+cPiacX8Yh8dv
	 kbl62APtUhROkjfK/11IdMOlwnrmHd/z76hdhFz96WTDNmFFW8X80P7/zYquYa0KSOL0R
	 2+crdk63Dc5Rk2IDYsb0FIS6XaoQjo56mnR/0fJ+UMfhx/HlIZzNb7Mny6Hhweli/3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015095;
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
	bh=7uVQ7qqfJ/7RyrM2bKIbbkMHCXj9eIKqWisz8mKJsyw=;
	b=vZ7K2r+nmwE3l+slMTCpAm8sZTKGuOWsC6tY1cRrXIcBLMRdUqBBakSk042eHh4Gb5Q4
	 sP2mxmtFgnaSSdFc+1Hs7UDE5pjEkLzhw9xwq1srplKD3IYKaki+ALtKRIs3+3Nc+9y6F
	 1kBCMI0d1gAmMwB5MmoFLY3A+l3YjkdkyeR72w/tjhWTotZwk7B0kjCHf6zBN42BLew9R
	 2//nhrS6WCco6ayT5M9N+aGpo6IfBC/vIUcagWZr95RrKquGDsQyjCpSQbeDnwGbJHTUg
	 9eIlkgmg57y9bpCHjxpUhWG8Xi91LUBOysNs/Nxe7wv2YTyUg8GCXoNijBiVjOgR1gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="PQ/QDH99";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.11
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBC60A2612;
	Wed, 18 Nov 2026 15:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63FBC60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=PQ/QDH99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2EJ4kWRj8DMJikgyyaNDRaHLozRI7YObzOuYbbV7ITkLZIybweS2SSv6ll/VQm2wz1QIlOG+P+u3506TKLjvHnLfOlEaYWTdXJsqealKtiudw3gLKR++RY95P/btPJNnmwziNpueFSnDJxcmDPUEKNeOWK+OC07a7ZAm+TFUGE3wjDZURxo8eYSKEcF/o7M6jpjPyrVnjk14+iXRsyEJKHE45KZAWZwkrK03SqViP01DeCpHroTHdtATllqqa6dujqlVDhFYKOAtdUMOfoWIRP/c3SqxWmTfBnC/VGpXTpspYYiWUOojTxJgoqdkQpyaRmY2jYwjQR8pJuQj76fAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uVQ7qqfJ/7RyrM2bKIbbkMHCXj9eIKqWisz8mKJsyw=;
 b=wLlLEfoEvtV4yogY/I+IsCd4dnwWPhHJFTp1ePcDZBnjtmWSmZe3IN7f3LAP4wXylijZeFVRc3etOP//14G5YsSX9MZdML9qP4lKAdP3m0Uh3MlbfovSYx7IXufd0jZ22yv26yCDx60T3J9c5yXXsLDj6T3MD0YYnR2Bnk3EFCl5P1PFIIiS0+luV8AAfKIiZnLp25IwRWbpEWM7lW4MisSfiNhLDNiUz5+9G/j8AZAGmR6bFsBqQySo5j75qd1dkMdcQeXz9UskQ50EcsJmuo96mVaTDmxFENVJrDUWRcuiSg9LQQLDFNiSTNicNH7gNO/R2521aX02Vn0vPx5POg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uVQ7qqfJ/7RyrM2bKIbbkMHCXj9eIKqWisz8mKJsyw=;
 b=PQ/QDH99jXBKehQCwkZ3yjFdnfXUBdP5T2aqsgg31Qrc4+4kjzer+w1W/kVSJSPG7z9yAGiQUnqoPLeWWy99wIcYgvJew9tQRwz0ytGLQEqb5sUvMj8biZp9a1pojaxMJgdCdCZ4RcVQBTlTaSkRwvG4VK+yfnZFuY1OVIe6duUu4jGnlkCSbKjKeogts+C74CQ3y11nCKiASglIUb6ukAaj3rzWee6HFF2tzI2dUF1Ne9Ba/lE0yS4jvXxSSxi9B22bpfJDGWeqO2IBjWmdf8wmTcO8MHIy2kasdeXEcey4n6xbcvvjepUkNtAHCRJJ+YaZTQURF9kvTnK/qAM8Zw==
Received: from DB8PR06CA0062.eurprd06.prod.outlook.com (2603:10a6:10:120::36)
 by DU0PR10MB6250.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 15:18:08 +0000
Received: from MA3PEPF00000409.eurprd04.prod.outlook.com
 (2603:10a6:10:120:cafe::6b) by DB8PR06CA0062.outlook.office365.com
 (2603:10a6:10:120::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 18
 Nov 2026 15:18:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MA3PEPF00000409.mail.protection.outlook.com (10.167.241.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:07 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:19:08 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:06 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:53 +0100
Subject: [PATCH v2 08/11] iio: adc: stm32-mdf: add dma buffered acquisition
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
Message-ID: <20261118-upstream_mdf_v2-v2-8-7939d3c3720a@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MA3PEPF00000409:EE_|DU0PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9f05b1-7120-4080-0d64-08df45872639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|921020|10067099003|11063799006|56012099006|261022075727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003|261022105027099003|261026121527099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4Qxy09djiP/aj4wxfbqEWT4QSu0U8oSw0wZZuUqgmz+pEWp8sWqkuCIpAk6VUDhVK9hdtxFSPc4+CySDMyEVu4XhTRhzaVM4dIK98pgzMbZsV9+n+AzthjV92cCX3d6uKHcyaXvOqfgvFxu4Z+LYcuh0XqTopVxFgUseYNkfSk9FVXPrRKEnET1m9S+KtkSnBFWjZwvYpvg39XO5tNnQVWgXyuypOrz0fBzZVhCG9aw8NtZg7RiKDmVJ+YXYDEWmOeuiPQjeBpCzGmJG5hEXxQARh0/fG8Ndhx5xZR3aBZ1wtI3l4gVBUhPSVKyHsdvaaEbnc0ffrUBjIgKoVmPMXceHEYdR9KYDi2NQ+fkp4dJsNm4ulrwNiRjC1mAckx5HrNupKg5o27gF+xucBDaiWypHuPHpn4QPVpzwnUQ6TJ0U+wbQ0Zk3vKdhn/R2tbAQuo9Jl2x2iPZSGQu0R037FUGUULy/ugmYwtUuGcKathr5YovDu9MgLmV9e3tYAchmIohIeXcBc6sNvIJGvHo2UwjBIXZ6dtsyv0/CGuvbyi+3Pih+/rCIMJjwwsKFpUyHsVGysPQnR+nHeXO3y3N099N/6Q7qm3k+7Ws2mjRLlw+lSdjUHyk1T9cCfmK3ZcPgoIVuujpBgO2ITUb+iWJUbWrRc9pAtGbKl8HKU4EiUs2WWiOANBAtLmdZkWN/7/PBJzbhdEOcJj2lepOLsT0MFrb+FAdksZ6tHgERqAd488ed5FxedHH2gp5JedL6lB2Q
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hq7nV/uX4vVVi6Eo/b/NQXeG972/hI0cv8RpNO2brRld9aIMa4MVxBxUjOjjUuwSnILnI3TlA0SRr6kodRPnhXYD93XXcN+ySNONBfITIHsH0KORhisQtJV1JhKxJOk6JbknQHrPz2mIczLHW2nAnUUCxtxFZwwsttI9QoqxYeFtndu9bqWzrl861Zc6VSbIu5WzKgIwiX5L0TWhtILEBe2LWMJEDT12yEewh1VU05uoVq0vHFaemXqhfdHQQkrQW9dgcIxj0evCVoNbRYQgugzOmqU+744FVusvsG48yt1Zoq9upLHe9z05QACrWBDoX/pPoq8wjID5twMjtBLmpfA3OcTNWGEcdoF9Qv/qhyJEHZHLfyAKyd/o3cmBt+uV3FyDBGHeH7wEdY8lr41nLaMUCOaiy8Ql6EGkTKUbIvb+m+Ecmzz/o71A3UWSCA+G
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:07.2976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9f05b1-7120-4080-0d64-08df45872639
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000409.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6250

Add optional cyclic DMA acquisition with buffer enable and disable
operations. Push completed DMA scans to the IIO buffer or deliver periods
to a registered consumer callback.

Add the buffer watermark callback to size a cyclic DMA buffer with two
periods. Limit the requested watermark to the available buffer capacity
and reject invalid scan sizes.

Set up analog IIO buffers when DMA is available, retaining direct-only
operation without DMA. Keep internal TRGO triggering for synchronized
and interleaved acquisition.

Stop active buffers during system suspend and restore their configuration
and acquisition on resume. External timer trigger support follows in a
separate commit.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/Kconfig         |   1 +
 drivers/iio/adc/stm32-mdf-adc.c | 315 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 315 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index c3e9885af22d..f9fce54f8627 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1760,6 +1760,7 @@ config STM32_MDF_ADC
 	select STM32_MDF_CORE
 	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
+	select IIO_TRIGGERED_BUFFER
 	select IIO_BACKEND
 	help
 	  Select this option to support ADCSigma delta modulator for
diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-adc.c
index 7361ce6182be..046ca3943a39 100644
--- a/drivers/iio/adc/stm32-mdf-adc.c
+++ b/drivers/iio/adc/stm32-mdf-adc.c
@@ -823,6 +823,243 @@ static void stm32_mdf_adc_stop_conv(struct iio_dev *indio_dev)
 	stm32_mdf_sitf_stop(adc->sitf);
 }
 
+static unsigned int stm32_mdf_adc_dma_residue(struct stm32_mdf_adc *adc)
+{
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(adc->dma_chan, adc->dma_chan->cookie, &state);
+	if (status == DMA_IN_PROGRESS) {
+		/* Residue is size in bytes from end of buffer */
+		unsigned int i = adc->buf_sz - state.residue;
+		unsigned int size;
+
+		/* Return available bytes */
+		if (i >= adc->bufi)
+			size = i - adc->bufi;
+		else
+			size = adc->buf_sz + i - adc->bufi;
+
+		return size;
+	}
+
+	return 0;
+}
+
+static void stm32_mdf_adc_dma_buffer_done(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int available = stm32_mdf_adc_dma_residue(adc);
+	size_t old_pos;
+
+	dev_dbg(&indio_dev->dev, "pos = %d, available = %d\n", adc->bufi, available);
+	old_pos = adc->bufi;
+
+	while (available >= indio_dev->scan_bytes) {
+		s32 *buffer = (s32 *)&adc->rx_buf[adc->bufi];
+
+		adc->bufi += indio_dev->scan_bytes;
+		if (adc->bufi >= adc->buf_sz) {
+			if (adc->cb)
+				adc->cb(&adc->rx_buf[old_pos], adc->buf_sz - old_pos, adc->cb_priv);
+			adc->bufi = 0;
+			old_pos = 0;
+		}
+		if (adc->dev_data->type == STM32_MDF_IIO)
+			iio_push_to_buffers(indio_dev, buffer);
+		available -= indio_dev->scan_bytes;
+	}
+	if (adc->cb)
+		adc->cb(&adc->rx_buf[old_pos], adc->bufi - old_pos, adc->cb_priv);
+}
+
+static int stm32_mdf_adc_dma_start(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct dma_slave_config config = {
+		.src_addr = (dma_addr_t)adc->phys_addr + MDF_DFLTDR_REG,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+
+	if (!adc->dma_chan)
+		return -EINVAL;
+
+	if (!indio_dev->scan_bytes || !adc->buf_sz ||
+	    (adc->buf_sz / 2) % indio_dev->scan_bytes)
+		return -EINVAL;
+
+	dev_dbg(&indio_dev->dev, "size=%d watermark=%d\n", adc->buf_sz, adc->buf_sz / 2);
+
+	ret = dmaengine_slave_config(adc->dma_chan, &config);
+	if (ret)
+		return ret;
+
+	/* Prepare a DMA cyclic transaction */
+	desc = dmaengine_prep_dma_cyclic(adc->dma_chan, adc->dma_buf,
+					 adc->buf_sz, adc->buf_sz / 2,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!desc)
+		return -EBUSY;
+
+	desc->callback = stm32_mdf_adc_dma_buffer_done;
+	desc->callback_param = indio_dev;
+
+	ret = dma_submit_error(dmaengine_submit(desc));
+	if (ret)
+		goto err_stop_dma;
+
+	/* Issue pending DMA requests */
+	dma_async_issue_pending(adc->dma_chan);
+
+	/* Enable regular DMA transfer*/
+	ret = regmap_set_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_DMAEN);
+	if (ret < 0)
+		goto err_stop_dma;
+
+	return 0;
+
+err_stop_dma:
+	dmaengine_terminate_sync(adc->dma_chan);
+
+	return ret;
+}
+
+static void stm32_mdf_adc_dma_stop(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	if (!adc->dma_chan)
+		return;
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_DMAEN);
+
+	dmaengine_terminate_sync(adc->dma_chan);
+}
+
+static int stm32_mdf_adc_postenable(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int i = 0;
+	int ret;
+
+	/* Reset adc buffer index */
+	adc->bufi = 0;
+
+	while (i < indio_dev->num_channels && adc->channels[i].backend) {
+		ret = iio_backend_enable(adc->channels[i].backend);
+		if (ret < 0) {
+			while (i > 0)
+				iio_backend_disable(adc->channels[--i].backend);
+
+			return ret;
+		}
+		i++;
+	}
+
+	ret = stm32_mdf_adc_start_mdf(indio_dev);
+	if (ret < 0)
+		goto err_start;
+
+	stm32_mdf_adc_filter_set_mode(adc, true);
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTISR_REG,
+			  MDF_DFLTISR_DOVRF_MASK | MDF_DFLTISR_SATF_MASK);
+
+	regmap_set_bits(adc->regmap, MDF_DFLTIER_REG,
+			MDF_DFLTIER_DOVRIE_MASK | MDF_DFLTIER_SATIE_MASK);
+
+	ret = stm32_mdf_adc_dma_start(indio_dev);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Can't start DMA\n");
+		goto err_dma;
+	}
+
+	ret = stm32_mdf_adc_start_conv(indio_dev);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Can't start conversion\n");
+		goto err_conv;
+	}
+
+	return 0;
+
+err_conv:
+	stm32_mdf_adc_dma_stop(indio_dev);
+err_dma:
+	stm32_mdf_adc_stop_mdf(indio_dev);
+err_start:
+	i = 0;
+	while (i < indio_dev->num_channels && adc->channels[i].backend) {
+		iio_backend_disable(adc->channels[i].backend);
+		i++;
+	}
+
+	return ret;
+}
+
+static int stm32_mdf_adc_predisable(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int i = 0;
+
+	stm32_mdf_adc_stop_conv(indio_dev);
+
+	stm32_mdf_adc_dma_stop(indio_dev);
+
+	regmap_clear_bits(adc->regmap, MDF_DFLTIER_REG,
+			  MDF_DFLTIER_DOVRIE_MASK | MDF_DFLTIER_SATIE_MASK);
+
+	stm32_mdf_adc_stop_mdf(indio_dev);
+
+	while (i < indio_dev->num_channels && adc->channels[i].backend) {
+		iio_backend_disable(adc->channels[i].backend);
+		i++;
+	}
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops stm32_mdf_buffer_setup_ops = {
+	.postenable = &stm32_mdf_adc_postenable,
+	.predisable = &stm32_mdf_adc_predisable,
+};
+
+static void stm32_mdf_dma_release(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	if (adc && adc->dma_chan) {
+		dma_free_coherent(adc->dma_chan->device->dev,
+				  MDF_DMA_BUFFER_SIZE, adc->rx_buf, adc->dma_buf);
+		dma_release_channel(adc->dma_chan);
+	}
+}
+
+static int stm32_mdf_dma_request(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct dma_chan *dma_chan;
+
+	dma_chan = dma_request_chan(dev, "rx");
+	if (IS_ERR(dma_chan))
+		return PTR_ERR(dma_chan) ? PTR_ERR(dma_chan) : -ENODEV;
+	adc->dma_chan = dma_chan;
+
+	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
+					 MDF_DMA_BUFFER_SIZE, &adc->dma_buf, GFP_KERNEL);
+	if (!adc->rx_buf) {
+		dma_release_channel(adc->dma_chan);
+		return -ENOMEM;
+	}
+
+	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+	indio_dev->setup_ops = &stm32_mdf_buffer_setup_ops;
+
+	return 0;
+}
+
 static int stm32_mdf_channel_parse_of(struct iio_dev *indio_dev, struct fwnode_handle *node,
 				      struct iio_chan_spec *ch)
 {
@@ -932,6 +1169,27 @@ static int stm32_mdf_adc_chan_init(struct iio_dev *indio_dev, struct iio_chan_sp
 	return chan_idx;
 }
 
+static int stm32_mdf_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	unsigned int scan_bytes = indio_dev->scan_bytes;
+	unsigned int watermark;
+
+	/*
+	 * DMA cyclic transfers are used, buffer is split into two periods.
+	 * There should be :
+	 * - always one buffer (period) DMA is working on
+	 * - one buffer (period) driver pushed to ASoC side.
+	 */
+	if (!val || !scan_bytes || scan_bytes > MDF_DMA_BUFFER_SIZE / 2)
+		return -EINVAL;
+
+	watermark = min(val, MDF_DMA_BUFFER_SIZE / (2 * scan_bytes));
+	adc->buf_sz = 2 * watermark * scan_bytes;
+
+	return 0;
+}
+
 static int stm32_mdf_adc_single_conv(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan, int *res)
 {
@@ -1115,6 +1373,7 @@ static int stm32_mdf_adc_read_label(struct iio_dev *indio_dev, const struct iio_
 }
 
 static const struct iio_info stm32_mdf_info_adc = {
+	.hwfifo_set_watermark = stm32_mdf_set_watermark,
 	.write_raw = stm32_mdf_adc_write_raw,
 	.read_raw = stm32_mdf_adc_read_raw,
 	.read_label = stm32_mdf_adc_read_label,
@@ -1208,6 +1467,24 @@ static int stm32_mdf_adc_init(struct device *dev, struct iio_dev *indio_dev)
 
 	init_completion(&adc->completion);
 
+	/* Optionally request DMA */
+	ret = stm32_mdf_dma_request(dev, indio_dev);
+	if (ret) {
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret, "DMA channel request failed with\n");
+
+		dev_dbg(dev, "No DMA support\n");
+		return 0;
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time, NULL,
+					      &stm32_mdf_buffer_setup_ops);
+	if (ret) {
+		stm32_mdf_dma_release(indio_dev);
+		return dev_err_probe(dev, ret, "Buffer setup failed\n");
+	}
+
 	return 0;
 }
 
@@ -1460,12 +1737,14 @@ static int stm32_mdf_adc_probe(struct platform_device *pdev)
 		ret = iio_device_register(iio);
 		if (ret < 0) {
 			dev_err_probe(dev, ret, "Failed to register IIO device: %d\n", ret);
-			goto err_clean_list;
+			goto err_cleanup;
 		}
 	}
 
 	return 0;
 
+err_cleanup:
+	stm32_mdf_dma_release(iio);
 err_clean_list:
 	list_del(&adc->entry);
 
@@ -1479,14 +1758,48 @@ static void stm32_mdf_adc_remove(struct platform_device *pdev)
 
 	if (!MDF_IS_INTERLEAVED_FILT_NOT_0(adc))
 		iio_device_unregister(indio_dev);
+	stm32_mdf_dma_release(indio_dev);
 
 	list_del(&adc->entry);
 }
 
+static int stm32_mdf_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (iio_buffer_enabled(indio_dev))
+		ret = stm32_mdf_adc_predisable(indio_dev);
+
+	regcache_cache_only(adc->regmap, true);
+	regcache_mark_dirty(adc->regmap);
+
+	return ret;
+}
+
+static int stm32_mdf_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	regcache_cache_only(adc->regmap, false);
+	ret = regcache_sync(adc->regmap);
+
+	if (!ret && iio_buffer_enabled(indio_dev))
+		ret = stm32_mdf_adc_postenable(indio_dev);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(stm32_mdf_adc_pm_ops, stm32_mdf_adc_suspend, stm32_mdf_adc_resume);
+
 static struct platform_driver stm32_mdf_adc_driver = {
 	.driver = {
 		.name = "stm32-mdf-adc",
 		.of_match_table = stm32_mdf_adc_match,
+		.pm = &stm32_mdf_adc_pm_ops,
 	},
 	.probe = stm32_mdf_adc_probe,
 	.remove = stm32_mdf_adc_remove,

-- 
2.43.0

