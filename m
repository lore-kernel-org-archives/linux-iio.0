Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3124CE699;
	Tue, 15 Sep 2026 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499638; cv=none; b=Y7Xlo+RsqD95XW9ylFzyRvB9krUW7YNu4/xQNNBtPnx+G+ISGULybd7pYzGdVGdScaBNU4vMvrs3KzpNsandtwXgJkbbpIH6DYyAkWI6/UnxKygXbBQSGdl3OcbFseSPM1rFAz3NWCFaUr6ExNBShKIk++fZEcGRuyRdcPsSlFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499638; c=relaxed/simple;
	bh=xuGhHB9OCTJKM/tSIrDKQ502qmmg4V4WbtyF9roXJPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mq1Pnftcarm8g3jwHSShYhOOKkqY/A/BeVFtQjBypyxVwokMw/fAmjnepc9Mz+spyzdcO2LBwYLPXIrp4xlseHDwWIN2QBZ+Xnujy/FAT569L5ri9Gdd/VLNYXZElnV955/jQKR6UrVBPM94qlKoEOIpoCSfkwTsrW6N8F1lj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kAqgDzMm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kAqgDzMm"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsLet1279385;
	Tue, 15 Sep 2026 15:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2BVTE
	GSCpu9awTgv6gc+5x7blOD3n6BEdht2nJgXRps=; b=kAqgDzMmh1aniJSobF2T1
	O9vGWc/nCn6cRQtKft3ZNnMfyE/RVNTI7MsKQCYn+S5tr2r34HQs842QNzUg23SP
	fAhaoZ/kxV8EBIP6AcasjWH9/9utGmBbrZqS/UhuZFnrhgBo1TEN2SYh88atofnQ
	duFve4Wg1Iy0emqBX0NmmZn4zb6SsVLivLYJw4kiCFKmD4QTM1H5OVhU0aPkLnHX
	d5+CCDS8m5FKSwdAMZJ4CqK9Z1PyKHxzgMhKNxzKRhGi8sGse/vluTN1JEmuWxn1
	bTwojq2VTVPdmr20aw4QoBGW9ca5mSNtbtNARNoQ8a2oKBGgEZKSPMoMZCf4+B9H
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c0u3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:13:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJDnnI019151
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:13:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 15 Sep
 2026 15:13:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:13:48 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJDX2I028139;
	Tue, 15 Sep 2026 15:13:35 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v2 05/15] iio: adc: ad4134: Serialize single-read operations
Date: Tue, 15 Sep 2026 16:13:27 -0300
Message-ID: <342e0983c0f458d1376fb69cc984cfd8421a1d56.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX0LFGG/MxMtqs
 Mly7BtgQCOYepWI3idB63V+0t/4HMEFOyPR06kenaYUsB0zIQofzrwG6MhwUSroF4vTbOaBNA6Z
 yLBo0iXf3MnZsuGhz02q14z9xZ5VO+2gG4yo4kzs8QieOGYnAh8V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX8MP7A/3RAqvJ
 nYPr7oiTVDan06mYVnFw18F313/DXf99302BtNVqygfUyclk0jhITjv1cITuZUP+im8sy3JxKqS
 A2kDHvmS2dXMmGOVEj5NDRaVXgmVeT8mHg+vWeuyAJ74BH2EnqR3FonSBoepUt8055n8nS1JuWT
 CfNhOUwFMHrJxyc+UvLHG8cTI2phs1YVT7E+flNcwuilXAQTsDlHZanMt1d2xQZNap1x16jqLKD
 ol/5ZE08ICWtge52f35gdtzm8NGgYeuCeHQec43ik2gnni3lbV6bdU30zLGepkKdFc6mxveSBED
 eY4Sh8YvaCTc+5HpH53OwPwbekSa1lwjqjArj0iEh5LkfIzCiEcIkOb6Vu5pAs8yRxa9UZT7xjE
 gh8bZhLvr+hRmiWXYeyp+5P42Urtv9RkyDSCJ7LSlIU8HVyqK9VWTSDdNQz7XWusWm3SASch7gD
 XZUfN1MgvQDpv3ckilg==
X-Proofpoint-GUID: 37IDbZQL-rmPWW-_TRFQUQMOUQbNCTNA
X-Proofpoint-ORIG-GUID: 37IDbZQL-rmPWW-_TRFQUQMOUQbNCTNA
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aa998ee cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=lQRJhboXyqThIMNCO80A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

Protect single-sample read operations from going wrong if two or more of
them run concurrently. Serialize the data read operation so to avoid
single-sample read requests disrupting each other.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Added {} to delimit scoped mutex usage context in single-sample read.
- Used pahole to reduce memory holes in ad4134_state struct.

 drivers/iio/adc/ad4134.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 7400bd145d8a..7773b7af349b 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -7,6 +7,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
@@ -15,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -98,6 +100,11 @@ struct ad4134_state {
 	struct regmap *regmap;
 	unsigned long sys_clk_hz;
 	struct gpio_desc *odr_gpio;
+	/*
+	 * Synchronize access to members the of driver state, and ensure
+	 * atomicity of consecutive register access operations.
+	 */
+	struct mutex lock;
 	int refin_mv;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -257,7 +264,9 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (info) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->lock);
+
 		gpiod_set_value_cansleep(st->odr_gpio, 1);
 		/*
 		 * For slave mode gated DCLK (data sheet page 11), the minimum
@@ -276,6 +285,7 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->refin_mv;
 		*val2 = AD4134_CHAN_PRECISION_BITS - 1;
@@ -444,6 +454,10 @@ static int ad4134_probe(struct spi_device *spi)
 
 	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
-- 
2.53.0

