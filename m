Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575328CF77;
	Thu, 28 May 2026 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980704; cv=none; b=eSIAXBNz8jv2jhA5wElvT0tmTZeA4eFWa26KnyBo9SmtQpF59NemXNIMGwZXZGEkHOWdCkZXg8I1h8wnutN5f6Y+L6+kgHAmiIdMvrfsvuE47Y+pQjZ235fGCkBJz/K2Ie9ncbgbHChbZNpG1CRj0BHARqq1XXz88gnIKtbxD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980704; c=relaxed/simple;
	bh=+iG76pos/4B5hfHm4dzwTjyiw4lo6xsWMEr6bIF/Gs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dg6QIjOJ6RWyscrVthg3gdI5ajvhX08BAzMsGsgaDxt7EUdRXtLyr043f4p6uNfthDScI3rCVs3M3QonDcHbEy5y/JevljLdq8XPIEmfhr4t8QVcU4gDuamH1PhsZ1pPRCTj968l+kwXSXFz4/rNf7uYxBtCHQL+0sjmPNVmRuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g2H2SOyC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g2H2SOyC"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SEeJIZ3916484;
	Thu, 28 May 2026 11:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gzitM
	u07b2oTFaTIsCct6rj6QLnJsT7PIvnP0vayh6A=; b=g2H2SOyCpwsQIpVzI8X7D
	yeuqFIoASM/axvjSc+F0mLakX4D10u7YHZGFNRBb5yKOvziZT5mPET+IDMjN2/+C
	CmtBS1kvi3XMq0yocFtCS9RYgKlt9imXvdDvkuHi7Gtswb9KDiKlGYbn0LVCSTux
	W8Yw5u4Avi9fPbK1tTjhkiK00dfiEhxO63bnk2tghUbNUKjcDPyptTOSuKg+i4k8
	/OfOh5EB8DA8crNFdt64sGvRR29QS97erOA/9hTS1IhTE4d3McVxuLCaKnnSAtFa
	PtKPWUJ0dLKu6lzMpDKHqBKxolevMUpuETnUtw0CwbPxw2l+u+EUwiQKp7PDESwK
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7xdk99g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:04:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64SF4rFi008969
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 May 2026 11:04:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 28 May 2026 11:04:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 28 May 2026 11:04:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 28 May 2026 11:04:53 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64SF4gUB021563;
	Thu, 28 May 2026 11:04:45 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 4/4] iio: adc: ltc2378: Enable triggered buffer data capture
Date: Thu, 28 May 2026 12:04:37 -0300
Message-ID: <dc235f0b036a9eb33b37b0970815a95c9da52414.1779976379.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1779976379.git.marcelo.schmitt@analog.com>
References: <cover.1779976379.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=VMPtWdPX c=1 sm=1 tr=0 ts=6a185997 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=wnqDGYsx2rMr_Dauq28A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1MiBTYWx0ZWRfX9iQ7bAG7lto9
 pGWPxLHSo3erDsrRQiOaPxvl17HybLUO5kUJ3JD3kzmjYYRJAewvBM2NgHDs1JUPtQEXjTWhVyN
 ul+VFluJmgAb+YzNJfw/J5FEWMryl+Ew7M/1cCOMHcPMbViDOT9ynWxaRjWPmr9nfdwpjhAn9hP
 wuQpzoVpKNP9LVNcwwDowaap051ypMGVwPUeY/9ZAQChfmBpjYnEaIi3rEtmzdDVc2lWtJ+bPPJ
 VUFxkxNBAV/jJgEjfZ8vSStWg/pYW1/mnxlBuDICGPA0E8YbOyW1fWiVo7btUGFBfOzUxkWGhHo
 oTk21WEZdobHceat+7u5PWmLn5uA6Z1eMBAptxzJHhR+q5KrtezUUSz810xTD3Hfk+RtxzwbSAZ
 3PLNRG35x82fUnHhVnyqvT6YwZ3jfYxQJc0sIINS6gOywH0jke/iWTZ/A4sgCgewneMFUZbDqxN
 +/CMkPJCD2H81ZqXiLw==
X-Proofpoint-GUID: V3kHvKmi2eVqjn68K0l4ZrIHsIGew4lu
X-Proofpoint-ORIG-GUID: V3kHvKmi2eVqjn68K0l4ZrIHsIGew4lu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280152

Enable users to run triggered data captures with LTC2378 and similar ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Initialize init scan_type according to buffer selection.
- Use IIO_CHAN_SOFT_TIMESTAMP directly on right hand of assignment.

 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ltc2378.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5f7038b5e731..65887c8f3171 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -945,6 +945,7 @@ config LTC2378
 	depends on GPIOLIB || PWM
 	select IIO_BUFFER
 	select LTC2378_OFFLOAD_BUFFER if SPI_OFFLOAD && PWM && IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices LTC2378-20 and
 	  similar analog to digital converters.
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index 6b01d8e96cc6..514645b847f0 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -18,8 +18,12 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/iio/types.h>
 
 #include "ltc2378.h"
@@ -278,6 +282,25 @@ static const struct iio_info ltc2378_iio_info = {
 	.read_avail = LTC2378_READ_AVAIL,
 };
 
+static irqreturn_t ltc2378_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ltc2378_convert_and_acquire(st);
+	if (ret < 0)
+		goto err_out;
+
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    pf->timestamp);
+
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int ltc2378_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -314,17 +337,27 @@ static int ltc2378_probe(struct spi_device *spi)
 	st->chans[0].type = IIO_VOLTAGE;
 	st->chans[0].info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 					  BIT(IIO_CHAN_INFO_SCALE);
+	st->chans[0].scan_index = 0;
 
 	struct iio_scan_type ltc2378_scan;
 
 	ret = ltc2378_offload_buffer_setup(indio_dev, spi);
 	if (ret == -ENODEV) {
 		/* SPI offloading is unavailable. Fall back to triggered buffer. */
-		dev_dbg(dev, "triggered data capture not supported\n");
 		ltc2378_scan.format = st->info->twos_comp ? IIO_SCAN_FORMAT_SIGNED_INT :
 							    IIO_SCAN_FORMAT_UNSIGNED_INT;
 		ltc2378_scan.realbits = st->info->resolution;
 		ltc2378_scan.storagebits = st->info->resolution > 16 ? 32 : 16;
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      &iio_pollfunc_store_time,
+						      &ltc2378_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
+
+		/* Add timestamp channel */
+		st->chans[num_iio_chans++] = IIO_CHAN_SOFT_TIMESTAMP(1);
 	} else if (ret) {
 		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
 	} else {
-- 
2.53.0

