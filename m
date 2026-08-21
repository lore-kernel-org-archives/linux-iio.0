Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B954D2EFE;
	Fri, 21 Aug 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321334; cv=none; b=nW4C/rqAkPbrdzo6VYdS3GBWcOr993j30+IYsd1wrtfV3DA+MlT+M1rKKDjUiIlTD3eHTd2MuChsz0bny931wsbZ1O+emibctxhdWTIZLkB5utdPXfunU4FAX/D8AXeXwGY2JHylUGVPZaoJwyMKp9VeyKZW4gPHhE6yZzdgjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321334; c=relaxed/simple;
	bh=ZymO/Vtz6KLtQ+shBQPjosSDpjpie2N3ZyEUGaNPxTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GegVwNWUyvy3rx1wITYS8972V89/+R9QTdzHKoNKYygUlOeL5ZexaG2F3FWHR7dozogL38ijDvSGw0zzgPPrdbm/kq3e8gVCtViFt6uC7+gtBbboot/Cm1J6Bs+ECDHsoUXK7QWZBbDR9w5mHa65q1UZ/PLg21Sys+Vp2NEaDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BJcinRr2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BJcinRr2"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCpfK82651167;
	Fri, 21 Aug 2026 10:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=edjnW
	tKvzqrrryFgvFS7J1KBqVvFFCoIk7Gq871BrjM=; b=BJcinRr2RvQl9OlM9mT8u
	qXn2ENkjf1aEh/JuTWDJp/HUY/UfgtXkEjA0bRW93UwZivP5hdsLjVGX1VQOf9J9
	aZP4bwMJrUnOqH+Iorb4zE8sW3ew7C9+D+8jHZuh6FSJ/Ht2bPojJ8I6xlXhCmym
	r65DfCYoSj/4t3rBN51by4CHSYdl59DZawT7AsJDECR0SZF06y6g9LtGbekJX2yy
	av4y6xxNCchs0YjQxoyUmNWyK8ytM/5IlXc/6wJpJZiKZOEGs9qDWfwxEHv72sEa
	V7lsSg5ICLusdsmaMa+DUxBvvfHeHQg5RsmecNb43ATVN4IC7We1hCeq7v57kM8v
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g4yepyvkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:08:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LE8fol033055
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 10:08:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 21 Aug
 2026 10:08:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 10:08:40 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LE7Kkt024319;
	Fri, 21 Aug 2026 10:08:30 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 21 Aug 2026 16:07:03 +0200
Subject: [PATCH v4 10/14] iio: adc: ad7768: Register GPIO auxiliary device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-ad7768-driver-v4-10-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
In-Reply-To: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787321240; l=3031;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ZymO/Vtz6KLtQ+shBQPjosSDpjpie2N3ZyEUGaNPxTE=;
 b=t/NJuMiQwlaBj2qlLvZ2d8fM5evyZrTSRNkbtLCZiTOHmmihe98QZMCiJJJecO7T+Ura5KlrD
 h3WZg+s5XIxC2RBF+1r3BfzXpnHqbQQEq5v0kgPiybsEuCdSauf53kW
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4fZ_EQ2bpmwlXuTSOw-9bM4P-5DDGJYk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX8sseZGDOYHKX
 7huSX2GJQhxpOdBtELSd23fJAWPt4gbryyFEW32UdJKnlB14NAh+kI4COqjZOifrhI2rS7pFkf9
 cgyW0INe6r406m1s+hWAkKBM/54X8+pbnSlh388l4N7yl2lIU9Ls
X-Authority-Analysis: v=2.4 cv=NLHlPU6g c=1 sm=1 tr=0 ts=6a885bea cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=kQnUbRfMuyK_Mtn_XBwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX+5a6z23Pyslh
 sCf18i/5BhLUWiwLHJT1+ztlPAbpzTc6cVTYheUlCZIGMr3++sGReorhwip0l3LDFODPB6Sj+eH
 xKh3WKKs5vRfOKDIOwLNCGxFmCTg892QR23mghm1cylWLjGZhNBugtI/4Kxs/u6cW6KhBvOouEx
 /LXQZaubgyY/MOPd7Kq9mYd54pDKI2k4h8xlN3iYIomaOytoXw3pyV440vIboI7sLawAC0p+/pj
 vwyrWDL34iVm+IXqi4iRF3QjKh6LbdfkxGX9M6p1tiCYAuyXnUvJz8GftbqpKhGOsDA6GiZrc1y
 whnYkaWgVsePEI8T9QSixESe/OD7i4rMK23TV7E17UpamNfK1KHq8AmeHa5t1dHxG5FUA+CGgV9
 mEtznFLFhrbz8syefEF8clLWCPqQofmPdZo8HMvC52T6R/srgnxAkGQJV6V7ulfnEwCwb7SQsv+
 /taL+U3FQWZYkg/ZXZw==
X-Proofpoint-GUID: 4fZ_EQ2bpmwlXuTSOw-9bM4P-5DDGJYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210109

Register an auxiliary device when the AD7768 is described as a GPIO
controller. This allows the GPIO driver to share the parent regmap and
runtime power-management state.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/Kconfig  |  1 +
 drivers/iio/adc/ad7768.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
index 97f84a6da63e..3f9306d54952 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
@@ -121,6 +122,7 @@
 #define AD7768_MAX_MCLK_FREQ_HZ			(34 * HZ_PER_MHZ)
 #define MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL			8
+#define AD7768_NUM_GPIOS			5
 #define AD7768_NUM_CHANNEL_MODES		2
 #define AD7768_CALIB_REG_MSK			GENMASK(23, 0)
 #define AD7768_WIDEBAND_SETTLING_SAMPLES	68
@@ -191,6 +193,7 @@ struct ad7768_state {
 	struct mutex lock;
 	struct clk *mclk;
 	unsigned int datalines;
+	unsigned long gpio_valid_mask;
 	enum ad7768_clock_source clock_source;
 	unsigned int power_mode_idx;
 	const struct ad7768_chip_info *chip_info;
@@ -1262,6 +1265,31 @@ static void ad7768_set_available_sampl_freq(struct ad7768_state *st)
 	}
 }
 
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
+	/* Use the SPI bus number and chip select to derive a stable per-device ID. */
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
 static int ad7768_set_filter_mode(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan,
 				  unsigned int mode)
@@ -1754,6 +1782,10 @@ static int ad7768_probe(struct spi_device *spi)
 
 	indio_dev->setup_ops = &ad7768_buffer_ops;
 
+	ret = ad7768_gpio_adev_init(st);
+	if (ret)
+		return ret;
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return ret;

-- 
2.43.0

