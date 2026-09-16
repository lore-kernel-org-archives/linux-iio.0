Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47544F0530;
	Wed, 16 Sep 2026 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557378; cv=none; b=AnlmtOR+V7eKxZlZuc/yTLuDCK+VmA5xgLG0n6epvKdKGvbZcUgUzr2u6dAkiZ0oupseUUzx1a99WhBEpKpYA4CHuwohQVWHvwGrvmeOevP9UbrkU6laKHIZD2hC0NXt9RbCoNbdfvZgv6+7Va4Rpfs22VccFR0SocWeikykWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557378; c=relaxed/simple;
	bh=Sy0TAtQPR0DePJv39WZgzsURvXS+UElzAQCEZlwOEfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iwHwgI2gksSTIcMgoI+MnsxSASKgQ1nr1A5LFEFWVsZqSLD6Sq3Ig40goNl/cmYnbiIXsV46A53z3Xe30SlUrfHB6WnLRXxUHzt/WGjISxthDMKRv8FtQnpQKqL+KY2D546Kcqub5CfVA0Rbwtx0xsQpzKYfnN4Ii6Xr4EXu15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TTAoIIfp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TTAoIIfp"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G6gRII1548638;
	Wed, 16 Sep 2026 07:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ku6j+
	AaC5z1sRLyffFSbyAz3ehG59A7Z/kBv/HBtLpQ=; b=TTAoIIfpMQxVeqOTLcUnO
	3METDU0I/3siHevYwRQ3x7oTsRJnP8z9h/43umlrz6bzvpBw6PD34cxfazn61P51
	+vcB6lgxmEQrvZl/xJFeFTq3zfnRyabZiA7ccmZwG1LX7GBbZ69HOf2hNuR+dbyM
	7or7uJlRKzcFQZvcN3puvTcXzLsrVIecB32NaxfydmLHn4ovlLhh6xNQ2ZkOgTLd
	Fu2WzqA3Poh0nQwWcZ4FdCG6dOKgIDNUFOFX0ZzKaJSfZW360QkftdEPh2hCkSBY
	RgGPjvHLTeu4RgmgB52G0pOb7F2n89q1z7uYrXPh/8n8TrRkKMTo3IT+7e0kBeyJ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gqj57hxga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBFbiT047178
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 16 Sep
 2026 07:15:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:37 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENE8004263;
	Wed, 16 Sep 2026 07:15:30 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:14:05 +0200
Subject: [PATCH v8 16/17] iio: adc: ad7768: Register GPIO auxiliary device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-16-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
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
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=2423;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=Sy0TAtQPR0DePJv39WZgzsURvXS+UElzAQCEZlwOEfE=;
 b=0UZvV4IiOPYmI/U4jXihFOjRQjtQLPyGOWBb7opAOMUMVC6pJDuqvBsJbBOksHDBdDBCzTeHJ
 5MhT3ONXxy/C1J9CCBzBGiNElhqIVUw0fUTqDEg4aqUKo4JH0WZMN5P
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX7rhyPLhLPq2u
 RJMqEvDscrExomlS8bUF6K2+yUHCl6DQTmQ6/eeA3yvUZFUHYsgU5yvGowXEhZXFxTAIcNiuMde
 ZsIXmPoNZCLgLPdcLTBenVbE3d1VQTagecCFRxxUYu4UqBrMRgki
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6aaa7a5a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=EUspDBNiAAAA:8
 a=gAnH3GRIAAAA:8 a=uS1bAgcam2TDL027Z10A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nszd99Ma5eBKBkdjgjNxk4OjO9SRHERE
X-Proofpoint-GUID: nszd99Ma5eBKBkdjgjNxk4OjO9SRHERE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfXymVK1heed5bL
 EnvnqAWVQn2kDpNr+T6lx5qzfGDgG2m/fdKaT446EeFi3Mk0twPlqKXUNCK9hFyXlMcYCtviIew
 MrXkkx4cpm+N8YxK2fGk8pEA756kt6hANKcL2tzW4bgRcat6XJ+2TlLSBh65cjuQrGwybYuKwaP
 iq7DyHOE5qJlxQvrd3o5xLnP245NeY64PTnqbFabJQ4F5PMhibldjq13iUZUGP/ElY9I8ZkHZ++
 k2tz3WAOXG72RRVuM8mYA7KLkcasPUq527dIR6ECbdtJfVwIINQaMKewWCTZ04jeGH5K0XZR98z
 /Hy4XhQ42C8NICo9/74XAcjEE6A7LOGsDZR+TrSMcupT0o3JbboKbgkfIG8bXBdFGBtnlnb+Cwp
 gP7ZN9taQXPr8UxZ7g7ywHOqJaWVzfx9RqhdNlH5a2P+u+XRvqPDtOyDf1ZDtJImGBZKhS9SQdf
 kWrMCGQdFaSGMKtuGXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Register an auxiliary device when the AD7768 is described as a GPIO
controller. This allows the GPIO driver to share the parent regmap and
runtime power-management state.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/Kconfig  |  1 +
 drivers/iio/adc/ad7768.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index c784bee0fd65..dea25315ed20 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -435,6 +435,7 @@ config AD7768
 	tristate "Analog Devices AD7768/AD7768-4 ADC driver"
 	depends on SPI
 	select REGULATOR
+	select AUXILIARY_BUS
 	select IIO_BUFFER
 	select IIO_BACKEND
 	select REGMAP
diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 33b1b124d4d1..1fb14907b2b7 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
@@ -1273,6 +1274,30 @@ static const struct iio_info ad7768_info = {
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
+	/*
+	 * Use the SPI bus number and chip select to derive a stable per-device
+	 * ID.
+	 */
+	id = (spi->controller->bus_num << 8) | spi_get_chipselect(spi, 0);
+	adev = __devm_auxiliary_device_create(dev, KBUILD_MODNAME, "gpio",
+					      NULL, id);
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
@@ -1830,6 +1855,10 @@ static int ad7768_probe(struct spi_device *spi)
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

