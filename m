Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062624C6EF7;
	Fri,  4 Sep 2026 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531376; cv=none; b=evI5QxRLYHS0v3mz2H3SZRO5LqzfeOqCTXEdXSrGH1ZCHxFrTtDdBvxp7ieMJVmSu9ulZGZHyXThDqnDWaOAGzwq4ROziJe6TChGNqyJ/Lipp/3qCQ8kh+LS7yqyA2/TcbMJZUd3RFRgx+rIdXmGUAVJW9vHrlF83E8fFP2X0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531376; c=relaxed/simple;
	bh=JHvuGW+/KX1PMkIqb86uhaAUY8k5Ty8luuZ4QUJ1Dn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ncReaIV7FBuawILpb1mjEkVIDT8O9HXLivX8dvPMYJBifG4sROjArF7Ssu8ursqbH/YwVkMmlPTD60w/F5mZQDTSrVW7xgagutOD5ERHZXyMCyckQZqDUpsRqm+B0OvGq1cADn1IARXDrY5TAftGmuPvA568tCr8T0KlKUJfTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h4gEYNyK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h4gEYNyK"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684DgPTP4068661;
	Fri, 4 Sep 2026 10:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LPNGV
	MKSjOLNnYXlf57qs2DL58DJicKbWsqhdvQd8PE=; b=h4gEYNyK9AuJ951XoemGK
	GfagufreCL52Fsc66qpB5bdt0IlOcbqJE49X2fcLB//TlYl47d0LUkgu/UlMtKDP
	/lwKn7UhHkhpVI4LkC8jkiUQhLn2SOAxiUazQNrGKFSTCZNgxkdqitMV9QFiS6Gm
	83VgH4BwR70Oe1HJEoyxJYKuhN214WjYCZWz/BRa2OgU0bmtb6rtvxAed656u8uP
	Q80lrTmX6b3BIypA/gw6CJfaHbSZ+tyxv/9gcpbreSOf2Zd74PSsi808bYjFfcC+
	+4iB23xBzB0i4uSrBAl8MZU2ZX9n8lGQyWIiAkYoUhk8yH9IE3s1S+l7J891dNtU
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gfxaw0d2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:15:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EFqb8036157
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:15:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:15:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:15:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:15:51 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dC026210;
	Fri, 4 Sep 2026 10:15:43 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:15:00 +0200
Subject: [PATCH v6 08/17] iio: adc: ad7768: Derive output data rates
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-8-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=8248;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=JHvuGW+/KX1PMkIqb86uhaAUY8k5Ty8luuZ4QUJ1Dn4=;
 b=BuZZkiJgZ+okF8HY8+XpPi9yRK/qPCUrN5m/z6bFmjxY/WTfFnjuoyTd64Sbk4V06YnT+paXG
 4D5qDFetKy3Chc9R6OvhBcwdzbbc1wFSiPGoOiATo/KNCjR1iAmQF2q
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=UNnt2ify c=1 sm=1 tr=0 ts=6a9ad299 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=8zL7B6ODU1ky_bk3ulwA:9 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX3VdJ+VAgYBBG
 3yzjumf0TDcbcvQnl3SJBzaLRmhYOqLRZHO+0YQYuoqe9FFy+8BZ3IZVLSlXMpJLOJrzhBmJi73
 PBIoKfFXjdu3ql+jADf7ELfGBtGvgT08k3gTSinYdiJtyGZqXI/A
X-Proofpoint-GUID: Ckk_mA4e6uUMj04hrRrfTdDGk82PIdNN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfXxmklX28Wy0k9
 LrZ5I3/Ozz9uL9VkD2bE+aHzkETgXQTgWVDakHscRudxtYz+cMfJ+krAkLiHjXGmTCSAKFMUtUH
 8ADbzqwuqHzFNzDhzNWyulm8QKB6rmNPmKZCHO5Az3E9B7xsRHBR0yEnS5BFbrsMx11d8ERsI8t
 CZjuwiRcc6avuWyK2jQ7Qiihh4JxZn8+W4kXgyUUdCUlr3dN68ZAUuRKz0YOf8tidsBWsv9VUhN
 BiPETGPxbW5giYkp/+rE8qZtOCg63xoSKHWo64y+k3eoWsMT/8gfwLvCXI5E9UbqalR6FgMN/Xk
 bJIZQhyNX1iD/QFGo/7tJ9deUPrylhoAW43sjwGyd5KEobPNDPapSEeaoq3NamRSGWJhile6Yar
 2x9IGSbMG1TVNrlQq/2x6nBgjN86QC/wj7lG1/WFa1Wf2BFEwjg+j6ijhtvqRTGrkVyINVOcSkr
 qpOlbATgSnxgteMhE+Q==
X-Proofpoint-ORIG-GUID: Ckk_mA4e6uUMj04hrRrfTdDGk82PIdNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

Derive valid output data rates from the master clock, power mode and
decimation ratio.

Replace the fixed x64 decimation and open-coded DCLK divider in
ad7768_configure_capture() with the derived default output rate and the
new decimation and clock-divider helpers. Select the maximum rate
supported by the configured data interface for the initial capture
configuration.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 149 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 126 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 71db57a2b9dd..2020156eb6b6 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -34,7 +35,6 @@
 #define   AD7768_CH_MODE_FILTER_TYPE_MSK		BIT(3)
 #define     AD7768_CH_MODE_FILTER_TYPE_WIDEBAND		0x0
 #define   AD7768_CH_MODE_DEC_RATE_MSK			GENMASK(2, 0)
-#define     AD7768_CH_MODE_DEC_RATE_64			0x1
 
 #define AD7768_REG_CH_MODE_SEL				0x03
 
@@ -97,9 +97,12 @@
 #define AD7768_SPI_REG_MASK				GENMASK(14, 8)
 #define AD7768_SPI_DATA_MASK				GENMASK(7, 0)
 
+#define AD7768_SAMPLE_SIZE				32
+#define AD7768_MAX_DCLK_DIV				8
 #define AD7768_MIN_MCLK_FREQ_HZ				(1150 * HZ_PER_KHZ)
 #define AD7768_MIN_XTAL_FREQ_HZ				(8 * HZ_PER_MHZ)
 #define AD7768_MAX_MCLK_FREQ_HZ				(34 * HZ_PER_MHZ)
+#define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
 
 enum ad7768_clock_source {
@@ -126,6 +129,16 @@ struct ad7768_precharge_config {
 	bool refbufn;
 };
 
+struct ad7768_freq_config {
+	unsigned int freq_hz;
+	unsigned int dec_rate;
+};
+
+struct ad7768_avail_freq {
+	unsigned int n_freqs;
+	struct ad7768_freq_config freq_cfg[AD7768_MAX_FREQ_PER_MODE];
+};
+
 struct ad7768_chip_info {
 	const char *name;
 	unsigned int num_channels;
@@ -142,6 +155,8 @@ struct ad7768_state {
 	unsigned int datalines;
 	enum ad7768_clock_source clock_source;
 	const struct ad7768_chip_info *chip_info;
+	struct ad7768_avail_freq avail_freq[ARRAY_SIZE(ad7768_power_modes)];
+	unsigned int ch_freq[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
 	unsigned int vref_uV[2];
 	unsigned int power_mode_idx;
@@ -149,6 +164,10 @@ struct ad7768_state {
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
 };
 
+static const unsigned int ad7768_dec_rate[AD7768_MAX_FREQ_PER_MODE] = {
+	32, 64, 128, 256, 512, 1024,
+};
+
 static const unsigned int ad7768_available_datalines[] = {
 	1, 2, 8,
 };
@@ -379,6 +398,68 @@ static int ad7768_set_power_mode(struct ad7768_state *st,
 	return 0;
 }
 
+static const struct ad7768_freq_config *
+ad7768_find_freq_config(const struct ad7768_state *st,
+			unsigned int mode_idx, unsigned int freq)
+{
+	const struct ad7768_avail_freq *avail_freq = &st->avail_freq[mode_idx];
+
+	for (unsigned int i = 0; i < avail_freq->n_freqs; i++) {
+		if (freq == avail_freq->freq_cfg[i].freq_hz)
+			return &avail_freq->freq_cfg[i];
+	}
+
+	return NULL;
+}
+
+static int ad7768_set_clk_divs(struct ad7768_state *st, unsigned int freq)
+{
+	const struct ad7768_freq_config *freq_cfg;
+	unsigned int mclk, dclk, dclk_div;
+	unsigned int chan_per_doutx;
+	unsigned int dclk_div_reg;
+
+	freq_cfg = ad7768_find_freq_config(st, st->power_mode_idx, freq);
+	if (!freq_cfg)
+		return -EINVAL;
+
+	mclk = clk_get_rate(st->mclk);
+	chan_per_doutx = st->chip_info->num_channels / st->datalines;
+	if (!chan_per_doutx)
+		return -EINVAL;
+
+	dclk = freq_cfg->freq_hz * AD7768_SAMPLE_SIZE * chan_per_doutx;
+	if (dclk > mclk)
+		return -EINVAL;
+
+	dclk_div = DIV_ROUND_CLOSEST(mclk, dclk);
+
+	/* Set the divider to the next-lowest supported power of two. */
+	dclk_div = rounddown_pow_of_two(min(dclk_div, AD7768_MAX_DCLK_DIV));
+
+	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);
+
+	return regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
+				  AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+				  FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
+					     dclk_div_reg));
+}
+
+static int ad7768_set_mode_decimation(struct ad7768_state *st,
+				      unsigned int freq, unsigned int mode)
+{
+	const struct ad7768_freq_config *freq_cfg;
+
+	freq_cfg = ad7768_find_freq_config(st, st->power_mode_idx, freq);
+	if (!freq_cfg)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(mode),
+				  AD7768_CH_MODE_DEC_RATE_MSK,
+				  FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
+					     freq_cfg->dec_rate));
+}
+
 static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
@@ -531,28 +612,58 @@ static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
 	return regmap_write(st->regmap, AD7768_REG_REFN_BUF, refbufn_val);
 }
 
+static void ad7768_set_available_sampling_freqs(struct ad7768_state *st)
+{
+	unsigned int n_power_modes = ARRAY_SIZE(ad7768_power_modes);
+	unsigned int mclk = clk_get_rate(st->mclk);
+
+	for (unsigned int mode_idx = 0; mode_idx < n_power_modes; mode_idx++) {
+		unsigned int dec = ARRAY_SIZE(ad7768_dec_rate);
+		struct ad7768_avail_freq *avail_freq;
+		unsigned int div;
+
+		avail_freq = &st->avail_freq[mode_idx];
+		div = ad7768_power_modes[mode_idx].mclk_div;
+		while (dec--) {
+			struct ad7768_freq_config *freq_cfg;
+
+			freq_cfg = &avail_freq->freq_cfg[avail_freq->n_freqs++];
+			freq_cfg->dec_rate = dec;
+			freq_cfg->freq_hz = mclk / (ad7768_dec_rate[dec] * div);
+		}
+	}
+
+	/* One DOUT line cannot carry the AD7768 fast-mode x32 output rate. */
+	if (st->datalines == 1 &&
+	    st->chip_info->num_channels == AD7768_MAX_CHANNEL)
+		st->avail_freq[n_power_modes - 1].n_freqs--;
+}
+
 static int ad7768_configure_capture(struct ad7768_state *st)
 {
-	unsigned int dclk_div_reg;
+	const struct ad7768_avail_freq *avail_freq;
+	unsigned int default_freq;
 	unsigned int mode_config;
-	unsigned int dclk_div;
 	int ret;
 
 	ret = ad7768_set_power_mode(st, ARRAY_SIZE(ad7768_power_modes) - 1);
 	if (ret)
 		return ret;
 
-	/*
-	 * Start with the wideband filter and a decimation rate of 64. This
-	 * supports every valid data-line configuration at the maximum MCLK.
-	 */
+	avail_freq = &st->avail_freq[st->power_mode_idx];
+	default_freq = avail_freq->freq_cfg[avail_freq->n_freqs - 1].freq_hz;
+	for (unsigned int channel = 0;
+	     channel < st->chip_info->num_channels; channel++)
+		st->ch_freq[channel] = default_freq;
+
+	ret = ad7768_set_mode_decimation(st, default_freq, 0);
+	if (ret)
+		return ret;
+
 	mode_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
-				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND) |
-		      FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
-				 AD7768_CH_MODE_DEC_RATE_64);
+				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND);
 	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
-				 AD7768_CH_MODE_FILTER_TYPE_MSK |
-				 AD7768_CH_MODE_DEC_RATE_MSK,
+				 AD7768_CH_MODE_FILTER_TYPE_MSK,
 				 mode_config);
 	if (ret)
 		return ret;
@@ -561,17 +672,7 @@ static int ad7768_configure_capture(struct ad7768_state *st)
 	if (ret)
 		return ret;
 
-	/*
-	 * DCLK(min) is ODR * channels per DOUTx * 32. With fast mode
-	 * (fMOD = MCLK / 4) and x64 decimation, this gives:
-	 * MCLK / DCLK = 8 * data lines / channels.
-	 */
-	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
-	dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV(dclk_div);
-	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
-				 AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
-				 FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
-					    dclk_div_reg));
+	ret = ad7768_set_clk_divs(st, default_freq);
 	if (ret)
 		return ret;
 
@@ -695,6 +796,8 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 				     "Invalid data-lines-number %d for %s\n",
 				     st->datalines, st->chip_info->name);
 
+	ad7768_set_available_sampling_freqs(st);
+
 	return ad7768_configure_capture(st);
 }
 

-- 
2.43.0

