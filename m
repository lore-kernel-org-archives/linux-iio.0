Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015097;
	b=uZMVi992vJSB2t9N2jnfWyDxQASF7om9bwbA6fucmuqcdkfDcrTzodJz2VJIoaIOyBZM
	 UySOYC4w8UZU0Eg87BpCrb7BFR5WgnGQ465pqYUZ1SOWYmLA3b1qXhb//PSz/whxezWF4
	 xXGy7g5Xy0SoH2N7iIAd3et9Hsvu8j4jWttBZPtnoAsJJ8zcud0Sl6B3QhBUtAtpoQc6J
	 zpxoD6Rs3OW2rKUigRH7CRxNNK4lSvdhBAmfBmMA00WgJUDuB6d72eCZkQdPnTluiEIBm
	 xajLC4vJph8bnKjgL4k7E/nXbm5wGD++vBQFZLNBuMWeQxsbdUTONDJYyeLWXHFW62A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015097;
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
	bh=zAzYynMonwBOsqIyhLjLtvIhO4T9CvCDL8dJqdlXtdc=;
	b=QZVmHLFP9UWiBaOcLWA4KeQ8vXpyTIsMc8vktb4MhnLgwliXyA7KAvvP4JXxZYGgEKYg
	 dyOeGwgxjOArg1lxZdGTJCNkyeEV4pBbqbGKARdWBPKOakYSjln+kJHStW8Wn7qjAmBJ5
	 9ltdv8G1uk7/N3Wa7Z2CW6hAEbo8Q+fGt7j5uF20ruvAz4/bB3t2Z0Cr3v0rFrY3OjRqQ
	 J8JeFtRchZ/vKKEu6rlsxxeUmxE+XWh2FC+lPLPPSH9tNxp42Q2a9nrYSV5LZO1YMcPyM
	 2gN4xJP3pRopHRzChBP+u6exOJG0zR4yy1knnkwUmvWHot9Xltti32n20jduQw8OaBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=EqOWrSaK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.49
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF260A2623;
	Wed, 18 Nov 2026 15:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ABF260A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=EqOWrSaK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEXavrknczT4vOsf/qUZqa6V26PX4K5Yb0nUQLyDxj4YbhiyC/rOooKIE8AS7bxGGIcM6sx2AzbDOzGxDItg7cWwkSiL8GbHaeX8VI+JfM05f9WgZrCelntKfzo10G0eLXOJG3+QeAXNQNBy+9ZVlZSS4jV6aarpM+NHH/cps+xheZZ8AjRVrtNbq90EVjXh58DVmMyU7l9hSbh48UUZbEnGBwxUx9cWjaZu4x9GIcrQdRmZbJYKhJmthwwUEn529CZwaiGBmko9u9SaSYSEiEDezCjM6kOSaaIx8XeyEDH5pZ8eMbKpXrfx1B8NLg46J8ZCSCJgn6b7z3Gz4T/QCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAzYynMonwBOsqIyhLjLtvIhO4T9CvCDL8dJqdlXtdc=;
 b=Hj8jDiZprr2ERtpOnza7fEP17f9rm+ZY0ZbKbdZvi5DKkUxFSzSRDMZ1X00xsqq0aXFnePuGn/zUkbbUar/wEJx+heAM3w0CMnwWrLqma3k/WlMhmwtS+Go+Une36SXdyy7T4+hnZAiIuehj3VnH6huCpUzqaBBfS9VMsMZAp71qpTwJmnhrYESfeH+viLBuo7OA7i+ZPd4t7Lw9rXyxKwmnwFrZ1a0C6y9bMSLFoUJq9vuGYX+4az2g+z9gUzXgS+DmSKotLcuDRF9FEesVuBS3RHmjb9RjaqnzBZRlVTKwswVuzVd5VhXYVLJu+53EeZIi29EwPz+uN3DwVtqSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAzYynMonwBOsqIyhLjLtvIhO4T9CvCDL8dJqdlXtdc=;
 b=EqOWrSaKusxoJVlAe+ZNlTctkpNvOfAr+6vhQ93d66aGjM/f+yvdYoTGvvuv25d8lOLgWQ5E+vypiX6NSBapw5ZTs2XZeN/nywwGenLEEzdmxfVdKHAllBdCsz40a6tohfvQWv9R6wBMJvDlzYsL9Y4uxcJlmUkn0xaXf/L56LqR72vri0dgnVhCCCGO0c0l101VujPCjs1U6jZyH9Pba4GJy/M1Ywopns1UwUaAaBRNHQRMFMZMVmC2tX5LEHLomRXyfV2q6kyJ9PNECFdGM+LfdGw9Z5iTfWFUY3Ati5LaU4OWRIMnvW0/coFNW3fZXGu9Kum2ou8OYcoBHatm3Q==
Received: from MA4P292CA0012.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:2d::9) by
 AS4PR10MB5942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 15:18:09 +0000
Received: from MA3PEPF00000403.eurprd04.prod.outlook.com
 (2603:10a6:250:2d:cafe::27) by MA4P292CA0012.outlook.office365.com
 (2603:10a6:250:2d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:18:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MA3PEPF00000403.mail.protection.outlook.com (10.167.241.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:08 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:19:09 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:07 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:55 +0100
Subject: [PATCH v2 10/11] iio: adc: stm32-mdf: add dmic audio filter
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
Message-ID: <20261118-upstream_mdf_v2-v2-10-7939d3c3720a@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MA3PEPF00000403:EE_|AS4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef4df17-6098-49a0-016d-08df45872731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|18002099003|22082099003|6133799003|261009223027099003|921020|56012099006|11063799006|261102130727099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021135927099003|261021123027099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	A/TDbJwdrDHz4r4IL4/qQ4y9riAAI8wbj3RseUKjV2+ySCXUiFmz3XwawtCMcBSsGZwne82adGtw39Zdwl+eE//rp92KjTig70dMg2bM+z54Il6JJFOQbiNF03m4yLuMR7Nb79XXVeYS9dA23H4W9JHoQA3CpS/DJwXt9pl+qemg7JbE9Doih+n3Kd1SoHfytYqY6bTQbMdVLSzehhGdT7laXRzWNeCRxku4yj310ag9MzE9l/TMeVS45uczAfx/XH95CnmeeaLyouBuo613NM0z2YoQgJssm2k/dO8MO3uFc6f7eXaRHyDnv+9u000CF058AD1LisWJpKtQDXHkCzGR5tSd8sMrpuyKVvs19aR+BooHE07RFwWBuZmjBYMLfsVqJ2V5R6mYGMf2ZZ0galnelE6QQjRWh8MAh0scYugZ3peJ7qEKg9nBWHHKHe1aQQrpNquxDYzxDJwkQ8wTpMOpxT01uu18hjB2fn84+wnhSZazuF6Ynlst6nJ2rcnoLGO4a9Xv5rv0IMHJ9PTqZ6MpTMm+lmUHOiiQeZRrZ4yNLg+cD1jkrNkQNr4t4DkUl9/MTldU8vLuY2oSXss97bEaY4MIZLUlIBVJDa/VesHKRlKC8r9JIC/6BmPoG94T+cmBmLrd9NkB5NQlPPCgadnEhH2rRcsyYxWt3mdWkSO/1Hs9UL/LOTe2f1BbpXXtbXbFSrzqg7gzysBJIq81kDhZZijLO3b74OTpTHoTj4LjV+15KnJAYFQ9yxHkDYxm
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(921020)(56012099006)(11063799006)(261102130727099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021135927099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MWSJA1glwVTadI/bh7nRpoqvJWEMkwlqrlf5bJV1RV8wCNcUQbJC0vIvK9HIlCkKA61XRQsMcEH+Dhx15V90ZkXrjpowJ/sqXfPk9WeR4CMiemoOJ3OLtG7blFqpworP328wdiFx2P7y/twTvAFCMCGKlOqXDcIqnE385BXRF30dNRb394pAw3YGdteWS+1m+jxl0qmF1ukFYx0BLB7vFg1uyCC7h3q5uUBQzh1ad9vC33cP9dc8BmYnZhO1ecReQv1v1nRTNbJ/8xIpRAHDz904iFSq+SZkPm6eGK5pB/G1SDNW8pAsDqKSD2FZmEoHPVGBpPucaf12/MCWs5m67bRI+PmB/1UQRGz2tuaF9MGK8n22qHNu0mX7Xa6fzsiOXXsewTIg+/6mUQgE1mq/YExa2gpu2kkRvuBaGuDKPfroj7VtQFsE/WlW3luIbQZp
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:08.9133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef4df17-6098-49a0-016d-08df45872731
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000403.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5942

Extend the MDF filter driver to support digital microphones and provide
the interface required by an audio consumer.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-mdf-adc.c       | 164 +++++++++++++++++++++++++++++++++-
 include/linux/iio/adc/stm32-mdf-adc.h |  19 ++++
 2 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-adc.c
index 97099b4adffc..27c47bef71a4 100644
--- a/drivers/iio/adc/stm32-mdf-adc.c
+++ b/drivers/iio/adc/stm32-mdf-adc.c
@@ -9,6 +9,7 @@
 #include <linux/clk-provider.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/iio/adc/stm32-mdf-adc.h>
 #include <linux/iio/backend.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/hw-consumer.h>
@@ -1128,6 +1129,42 @@ static const struct iio_buffer_setup_ops stm32_mdf_buffer_setup_ops = {
 	.predisable = &stm32_mdf_adc_predisable,
 };
 
+/**
+ * stm32_mdf_get_sub_channels_nb() - Get the number of MDF sub-channels
+ * @indio_dev: MDF IIO device
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+unsigned int stm32_mdf_get_sub_channels_nb(struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+
+	if (MDF_IS_FILTER0(adc) && adc->mdf->nb_interleave)
+		return adc->mdf->nb_interleave;
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_get_sub_channels_nb);
+
+static ssize_t stm32_mdf_adc_audio_get_channels(struct iio_dev *indio_dev, uintptr_t priv,
+						const struct iio_chan_spec *chan, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", stm32_mdf_get_sub_channels_nb(indio_dev));
+}
+
+/*
+ * IIO channel extended info used by the audio device IIO channel consumer.
+ * sub_channels_nb: provides the number of audio channels associated to the IIO channel.
+ */
+static const struct iio_chan_spec_ext_info stm32_mdf_adc_audio_ext_info[] = {
+	{
+		.name = "sub_channels_nb",
+		.shared = IIO_SHARED_BY_TYPE,
+		.read = stm32_mdf_adc_audio_get_channels,
+	},
+	{},
+};
+
 static void stm32_mdf_dma_release(struct iio_dev *indio_dev)
 {
 	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
@@ -1240,6 +1277,9 @@ static int stm32_mdf_adc_chan_init_one(struct iio_dev *indio_dev, struct fwnode_
 		ch->scan_type.shift = 8;
 	}
 
+	if (adc->dev_data->type == STM32_MDF_AUDIO)
+		ch->ext_info = stm32_mdf_adc_audio_ext_info;
+
 	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	ch->scan_type.sign = 's';
 	ch->scan_type.realbits = STM32_MDF_DATA_RES;
@@ -1474,6 +1514,13 @@ static int stm32_mdf_adc_read_label(struct iio_dev *indio_dev, const struct iio_
 	return sysfs_emit(label, "%s\n", name);
 }
 
+static const struct iio_info stm32_mdf_info_audio = {
+	.hwfifo_set_watermark = stm32_mdf_set_watermark,
+	.write_raw = stm32_mdf_adc_write_raw,
+	.read_raw = stm32_mdf_adc_read_raw,
+	.read_label = stm32_mdf_adc_read_label,
+};
+
 static const struct iio_info stm32_mdf_info_adc = {
 	.hwfifo_set_watermark = stm32_mdf_set_watermark,
 	.write_raw = stm32_mdf_adc_write_raw,
@@ -1530,6 +1577,38 @@ static irqreturn_t stm32_mdf_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static int stm32_mdf_audio_init(struct device *dev, struct iio_dev *indio_dev)
+{
+	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
+	struct iio_chan_spec *ch;
+	int ret;
+
+	ch = devm_kzalloc(&indio_dev->dev, sizeof(*ch), GFP_KERNEL);
+	if (!ch)
+		return -ENOMEM;
+
+	adc->channels = devm_kzalloc(&indio_dev->dev, sizeof(*adc->channels), GFP_KERNEL);
+	if (!adc->channels)
+		return -ENOMEM;
+
+	ret = stm32_mdf_adc_chan_init(indio_dev, ch);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Channels init failed\n");
+
+	indio_dev->num_channels = 1;
+	indio_dev->channels = ch;
+
+	ret = stm32_mdf_dma_request(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get DMA\n");
+
+	ret =  stm32_mdf_adc_filter_set_mode(adc, true);
+	if (ret)
+		stm32_mdf_dma_release(indio_dev);
+
+	return ret;
+}
+
 static int stm32_mdf_adc_init(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
@@ -1599,11 +1678,77 @@ static const struct stm32_mdf_dev_data stm32h7_mdf_adc_data = {
 	.init = stm32_mdf_adc_init,
 };
 
+static const struct stm32_mdf_dev_data stm32_mdf_audio_data = {
+	.type = STM32_MDF_AUDIO,
+	.init = stm32_mdf_audio_init,
+};
+
+/**
+ * stm32_mdf_get_buff_cb() - register a callback that will be called when
+ *                           DMA transfer period is achieved.
+ *
+ * @iio_dev: Handle to IIO device.
+ * @cb: Pointer to callback function:
+ *      - data: pointer to data buffer
+ *      - size: size in byte of the data buffer
+ *      - private: pointer to consumer private structure.
+ * @private: Pointer to consumer private structure.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int stm32_mdf_get_buff_cb(struct iio_dev *iio_dev,
+			  int (*cb)(const void *data, size_t size, void *private), void *private)
+{
+	struct stm32_mdf_adc *adc;
+
+	if (!iio_dev)
+		return -EINVAL;
+	adc = iio_priv(iio_dev);
+
+	if (!adc)
+		return -EINVAL;
+
+	adc->cb = cb;
+	adc->cb_priv = private;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_get_buff_cb);
+
+/**
+ * stm32_mdf_release_buff_cb() - Unregister the buffer callback
+ *
+ * @iio_dev: Handle to IIO device.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int stm32_mdf_release_buff_cb(struct iio_dev *iio_dev)
+{
+	struct stm32_mdf_adc *adc;
+
+	if (!iio_dev)
+		return -EINVAL;
+	adc = iio_priv(iio_dev);
+
+	if (!adc)
+		return -EINVAL;
+
+	adc->cb = NULL;
+	adc->cb_priv = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_release_buff_cb);
+
 static const struct of_device_id stm32_mdf_adc_match[] = {
 	{
 		.compatible = "st,stm32mp25-mdf-adc",
 		.data = &stm32h7_mdf_adc_data,
 	},
+	{
+		.compatible = "st,stm32mp25-mdf-dmic",
+		.data = &stm32_mdf_audio_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, stm32_mdf_adc_match);
@@ -1788,6 +1933,7 @@ static int stm32_mdf_adc_parse_of(struct platform_device *pdev, struct stm32_mdf
 
 static int stm32_mdf_adc_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct stm32_mdf_adc *adc;
 	const struct stm32_mdf_dev_data *dev_data;
@@ -1830,7 +1976,10 @@ static int stm32_mdf_adc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	iio->info = &stm32_mdf_info_adc;
+	if (dev_data->type == STM32_MDF_AUDIO)
+		iio->info = &stm32_mdf_info_audio;
+	else
+		iio->info = &stm32_mdf_info_adc;
 	iio->name = dev_name(&pdev->dev);
 
 	adc->dev = dev;
@@ -1847,8 +1996,19 @@ static int stm32_mdf_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (dev_data->type == STM32_MDF_AUDIO) {
+		ret = of_platform_populate(node, NULL, NULL, dev);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "Failed to find an audio DAI\n");
+			goto err_unregister;
+		}
+	}
+
 	return 0;
 
+err_unregister:
+	if (!MDF_IS_INTERLEAVED_FILT_NOT_0(adc))
+		iio_device_unregister(iio);
 err_cleanup:
 	stm32_mdf_dma_release(iio);
 err_clean_list:
@@ -1862,6 +2022,8 @@ static void stm32_mdf_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct stm32_mdf_adc *adc = iio_priv(indio_dev);
 
+	if (adc->dev_data->type == STM32_MDF_AUDIO)
+		of_platform_depopulate(&pdev->dev);
 	if (!MDF_IS_INTERLEAVED_FILT_NOT_0(adc))
 		iio_device_unregister(indio_dev);
 	stm32_mdf_dma_release(indio_dev);
diff --git a/include/linux/iio/adc/stm32-mdf-adc.h b/include/linux/iio/adc/stm32-mdf-adc.h
new file mode 100644
index 000000000000..95e3f4afdb78
--- /dev/null
+++ b/include/linux/iio/adc/stm32-mdf-adc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * This file describe the STM32 MDF IIO driver API for audio part
+ *
+ * Copyright (C) 2023, STMicroelectronics.
+ * Author(s): Olivier Moysan <olivier.moysan@foss.st.com>.
+ */
+
+#ifndef STM32_MDF_ADC_H
+#define STM32_MDF_ADC_H
+
+#include <linux/iio/iio.h>
+
+int stm32_mdf_get_buff_cb(struct iio_dev *iio_dev,
+			  int (*cb)(const void *data, size_t size, void *private), void *private);
+int stm32_mdf_release_buff_cb(struct iio_dev *iio_dev);
+unsigned int stm32_mdf_get_sub_channels_nb(struct iio_dev *iio_dev);
+
+#endif

-- 
2.43.0

