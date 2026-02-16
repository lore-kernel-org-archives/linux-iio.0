Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4212E9757;
	Mon, 16 Feb 2026 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247858; cv=none; b=HbSahDgzBYKVP+SFfzXNeVgtatTGWNvxpNeI+Ex5QchC+nMr0ElrX0DqQ5ms66BjvgFspfEmKYJc1ybaoP2MEKN3oEp6yd1rrEzygTttZSmH1LOkbGBKGviSq7fsxYE8MxthIKXqiP7tpNMLX+mU7bk9rDVm6cbhbfnm44tae88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247858; c=relaxed/simple;
	bh=E8IIdniVxg81lNGezkmdg55Ylt+LaZRQfyJm07rLK/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5yM2gjBI3e1PmkjqpXKGSYQLiKfWX3PBZlKziX/0Rj92l80h3ebMBhg+hPibalHQuaw7oIiMYvNPghBroYnTYKLJaLODDfq07SbZ4DBeWBYUuPOVtuVZ/bvet91vx9Rwhwnr5J+YAw+rI28OxxnyH2YZcMMnxrRaJmCrPHIN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1PcYWxSH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1PcYWxSH"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G727sL3569785;
	Mon, 16 Feb 2026 08:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=i7gL8wZHg6tPqFiz0PylElrKTFb
	EvAfpKa6ZO5ZaSNI=; b=1PcYWxSHvzuVSp/RecxUa5fD53TmmWLcZLr39zYKTL0
	OiolWWHo9rdFGi3el9f0teJ6iOJyzC3/osbMAxT9y44l+nG4HTmfm0cPUB4azNZl
	jRjDAue8TbzfOFQ3HjFC6oPfmctxHBlD6BqnI0Z6D/kf1fA/dVYxStdP2NCmGUKi
	NqDGkKHTbJTFPyqCmhX3mOMm9tcje0qUqIAymq0lBYQKVuNJ7UDRyu/7P2glJsev
	EvtBHVYDeO1imWx2FvjEPMpeV2xxLeWXySwuHNLENbOTKaWah1Jadzfm8iwVjJ8G
	KYnYhTsO2aGqbteLWnQak+KsaQsYKnZ/LrxUydkhMEQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cb88hmjxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 08:17:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GDHW0q004232
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 08:17:32 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Feb 2026 08:17:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Feb 2026 08:17:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 08:17:32 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GDHHT6011700;
	Mon, 16 Feb 2026 08:17:28 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3] iio: dac: max5522: simplify probe with devm_regulator_get_enable_read_voltage()
Date: Mon, 16 Feb 2026 15:17:05 +0200
Message-ID: <20260216131714.90508-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDExMSBTYWx0ZWRfX48MiZb8oKtXg
 kh31AWDTLfx2xbG4eC/hum5ONnKvdX10aWLMrfwUATJKbURQG4rR9Z5htbUmZJy8qo9sqKG7G8p
 wrqLu11D7YA4dPv+zX81JwPQCP6GAe2//KVZVYgcVrmaQidVFJKIoSLqOXaUuDaNGFFseGcDSEO
 2FVBxv06LL6xXNbjuFrIIOCbwSjp6vcmmqH/APSKP7LMXaTyGiHdMXWEmnZZC+520HFuGtfOhVk
 TjulQn6qbnX0kMs8X3LqTDrIuuHrbueg5ogJN2eZRDSO1FXzEGqlrgiEQaxt5xG1eT4NsDrntNs
 n6fyYDWjpWlvPHo93HUaXPh6cXRtacsDBMI19kyAn3KG0Nppb8AO7AkmvikhOZy6GMrVQI+NwGp
 TktGtlWatxnHbpMALC+85AjQGiFl5U+xmpnQb64nOjULwwzBa5axq41y0+cbRV0OxZrdUTIap4I
 kSnbAV9LX23GDZd63hQ==
X-Proofpoint-GUID: dTel_Og0rIJGSIXpZM_fJ81dlg6MwDUK
X-Authority-Analysis: v=2.4 cv=TeubdBQh c=1 sm=1 tr=0 ts=699318ed cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=oLd2ivcZAzAyQPFMLHIA:9
X-Proofpoint-ORIG-GUID: dTel_Og0rIJGSIXpZM_fJ81dlg6MwDUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160111

Simplify probe by using devm_regulator_get_enable_read_voltage() to
get, enable and read the regulator voltage in a single call, caching
the value at probe time.

The reference voltage for this DAC is a fixed hardware configuration
that is not expected to change at runtime, so reading it once during
probe and caching the millivolt value is sufficient.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
 - change vref_mV type from unsigned short to int to avoid potential
   precision loss
 - update commit message to clarify why caching voltage at probe is
   sufficient

 drivers/iio/dac/max5522.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
index 1b8fe6b8d26e..b52a9cc1da79 100644
--- a/drivers/iio/dac/max5522.c
+++ b/drivers/iio/dac/max5522.c
@@ -14,6 +14,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 
@@ -34,7 +35,7 @@ struct max5522_state {
 	struct regmap *regmap;
 	const struct max5522_chip_info *chip_info;
 	unsigned short dac_cache[2];
-	struct regulator *vrefin_reg;
+	int vref_mV;
 };
 
 #define MAX5522_CHANNEL(chan) {	\
@@ -79,17 +80,13 @@ static int max5522_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long info)
 {
 	struct max5522_state *state = iio_priv(indio_dev);
-	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		*val = state->dac_cache[chan->channel];
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = regulator_get_voltage(state->vrefin_reg);
-		if (ret < 0)
-			return -EINVAL;
-		*val = ret / 1000;
+		*val = state->vref_mV;
 		*val2 = 10;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	default:
@@ -147,16 +144,11 @@ static int max5522_spi_probe(struct spi_device *spi)
 	if (!state->chip_info)
 		return -EINVAL;
 
-	state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
-	if (IS_ERR(state->vrefin_reg))
-		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefin_reg),
-				     "Vrefin regulator not specified\n");
-
-	ret = regulator_enable(state->vrefin_reg);
-	if (ret) {
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vrefin");
+	if (ret < 0)
 		return dev_err_probe(&spi->dev, ret,
-				     "Failed to enable vref regulators\n");
-	}
+				     "Failed to get vrefin regulator\n");
+	state->vref_mV = ret / (MICRO / MILLI);
 
 	state->regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
 
-- 
2.43.0

