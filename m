Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4437FF5A;
	Fri, 28 Aug 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931124; cv=none; b=cIiDmNSDeCbLa9bvuMUd1NjPhI1l9bjhNCwb12GLLn3zkL/WtUMZQyub+dxYJE4CHobSvrUrhEKUu+RbEZPbn2QPc69IyjpF10I5feBZt6tlpCoyuzUEP0ELmvR6O/38vPu8rKuiru5AbCYXY+35dOV6CFxBigvsNkiw0CwUpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931124; c=relaxed/simple;
	bh=ywzzWonKoGfdqANxtzvHh/+8FDFyv8wOgH7XJ21Jxbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dlIHrJvxx6snKmmbB71QDWDXS34bwWlvIv+WACp7M9RJW+pYDno7YPH2QvabHvavO9NCl/cQjN/1jXadPY5vZBAs3/2XOGOPqxqT5CIAadtfzaKTKxrMfIi0cqzhOdUGrkLYXre9RJuuKKz7CgDeIs2e4fTY1g88i235BcCCAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ak9lIpwy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ak9lIpwy"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVgLH1142281;
	Fri, 28 Aug 2026 11:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cGaC6
	KWNucSHpHC6GYQ3aQxoexWBl9slIVVgZKHN1XU=; b=ak9lIpwyBSMxL7S0aANXa
	y/8gwM5/o2vDmzsUkENCtYmXYoESfKCPHLZhwXK5Q3+qO8ssqSzYP5mROMuXNpSZ
	OQ+Sw1nHdaZ6JaLLLPGKcyhGc2eFNK7VdBu3XGktxgeADksdvVuk0ijkvHsAFVwi
	vWc+fDC0/omigOg0Fr/aN85BiY9nFOHAkwHnsSpIIWvXLAD9NnKkyFm8Fp9sacT0
	iCFKS9SD3UCdkeNrn07xV+cYjOjQigx/8wahO3v14W26kCnn/O9rLqzogeOBFwUX
	aPekD7rcAfd6E6vV7FudT2dkksrgP9j35CTCA3Ei00VRUT3vLnyB6EHNyjOxmsEs
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gaj3cqj9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVqKY013265
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:52 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 28 Aug
 2026 11:31:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:51 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3v031424;
	Fri, 28 Aug 2026 11:31:46 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:39 +0200
Subject: [PATCH v5 16/20] iio: adc: ad7768: Register GPIO auxiliary device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-16-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=3105;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ywzzWonKoGfdqANxtzvHh/+8FDFyv8wOgH7XJ21Jxbs=;
 b=9F/0K2wmGh2dxS4vnZE5QLhAJXN7MWdZ6SZIlcW3vxWfjkJAGgeFCY2yR4fWZOJZfEDjUw3uW
 b5Jta4dm/yqB6+5XGGCay9s6yI3fnDXw2US0ZRd8oeGGTfgaiCzlh8T
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3q7BOM771mjghathnFY_M6hxYXzZwSPn
X-Authority-Analysis: v=2.4 cv=erHvCIpX c=1 sm=1 tr=0 ts=6a91a9e9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=31WsVb4KJGHhfLeZpBIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3q7BOM771mjghathnFY_M6hxYXzZwSPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfXzFe8kzxhHkx9
 gihsjpi0OmUdttMeIQ6ZAoDJewsiwRyS2mt1iqpv8TT9eE9depGSQmCovA0GpNbOAT+jLNXEZOV
 UBO+LznCnKjAdyURgK3jtrsrbF1YxKsReu10vNXrAG0FTFR778Vo19J3fdWf8VOwEwtVf68R+hF
 cvVbeaZ5dXPwrGvRqsiOK/wyykqTIeM6kKc2vYpIk8FCX6BWflqtm8xMSkA7tElr46o9S50YRLV
 7uaIUrrJ56gSgl+0VirK2oUiYj37fCd5eJazKtSam4kVwZ+kXn5oouWUD4djc56K+Pdz7eyXaOH
 VdYzDfz3FYxlsWPC92drkvR+OkhmOSY2YcpqKvbaKoCeZDZ/Rw3EhNdS3wosjifZ6mGJj5bX3F7
 JAu9/h4OUuwsox+jVQLjrVqojXBgBQwBPxiUz9FU/yJsNbZbW4fwTC5OWFb1o1yS+G5kNllca4e
 GGDEw8TxBgGhIy4OjFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX/rMsNkvujgnL
 qi4TXSugbB8IpjgPlLD7HCOWXCc9lmdtHLIE/okqVj0DQUcQe4w3/5Xs1WY7UEP6EeGloostYcJ
 Xk3gkSU7v6rsUTrnO/rM64vOHiHNLoyUBtjZwwQSoNpVYoxpABPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Register an auxiliary device when the AD7768 is described as a GPIO
controller. This allows the GPIO driver to share the parent regmap and
runtime power-management state.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/Kconfig  |  1 +
 drivers/iio/adc/ad7768.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a16f36f9502c..68334793c9ba 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -433,6 +433,7 @@ config AD7768
 	tristate "Analog Devices AD7768/AD7768-4 ADC driver"
 	depends on SPI
 	select REGULATOR
+	select AUXILIARY_BUS
 	select IIO_BUFFER
 	select IIO_BACKEND
 	select REGMAP
diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 5e93d4632f17..71d91ac6eec5 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
@@ -117,6 +118,7 @@
 #define AD7768_MAX_MCLK_FREQ_HZ				(34 * HZ_PER_MHZ)
 #define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
+#define AD7768_NUM_GPIOS				5
 #define AD7768_NUM_CHANNEL_MODES			2
 #define AD7768_CALIB_REG_MSK				GENMASK(23, 0)
 #define AD7768_WIDEBAND_SETTLING_SAMPLES		68
@@ -186,6 +188,7 @@ struct ad7768_state {
 	struct mutex lock;
 	struct clk *mclk;
 	unsigned int datalines;
+	unsigned long gpio_valid_mask;
 	enum ad7768_clock_source clock_source;
 	unsigned int power_mode_idx;
 	const struct ad7768_chip_info *chip_info;
@@ -1234,6 +1237,34 @@ static const struct iio_info ad7768_info = {
 	.update_scan_mode = ad7768_update_scan_mode,
 };
 
+static int ad7768_gpio_adev_init(struct ad7768_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct auxiliary_device *adev;
+	int id;
+
+	if (!device_property_read_bool(dev, "gpio-controller"))
+		return 0;
+
+	st->gpio_valid_mask = GENMASK(AD7768_NUM_GPIOS - 1, 0);
+	if (st->clock_source != AD7768_CLOCK_SOURCE_MCLK)
+		st->gpio_valid_mask &= ~BIT(4);
+
+	/*
+	 * Use the SPI bus number and chip select to derive a stable per-device
+	 * ID.
+	 */
+	id = (spi->controller->bus_num << 8) | spi_get_chipselect(spi, 0);
+	adev = __devm_auxiliary_device_create(dev, KBUILD_MODNAME, "gpio",
+					      &st->gpio_valid_mask, id);
+	if (!adev)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to create GPIO auxiliary device\n");
+
+	return 0;
+}
+
 static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
 					      struct ad7768_precharge_config *precharge_cfg)
 {
@@ -1772,6 +1803,10 @@ static int ad7768_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret,
 				     "Failed to register VCM regulator\n");
 
+	ret = ad7768_gpio_adev_init(st);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.43.0

