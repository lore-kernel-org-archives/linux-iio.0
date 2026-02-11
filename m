Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08717B425;
	Wed, 11 Feb 2026 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797936; cv=none; b=gZ8gSJQNp/7IEsReApenyNqrl0Y0YH3NPIIdW91TZInzux9dKAL3diX2Sv6jzq5i3f+cdsx8TNtMrTJQflq3Y+zDU33/7bueY33JIqYoOEZNFV6QKWCKaHiLunUg5mWdRWqx249lwj1AZGkvzSeyHder3QRzAOjPcS18tPH439s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797936; c=relaxed/simple;
	bh=KU28+KNjSAvdEs0wkYjXMi36v7EBDxaD0UPE1krf15E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N318nuzD3vzS9NH8fdUkbRntFLS5TmWsoltxW6ALCAqfN8T3b1ldkP5kdfBNZ+5M455bKiZM3yn0f+FNAmWv6jDke3t69DPuUVagPSMZ12rnDSWdk95E/xq4Pm3YxmWwxzRvmxkdaTHnV+pD2GB6ajutB6iOPiyXu3o0PXyUq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WMWzzAro; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WMWzzAro"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B4oToC3223438;
	Wed, 11 Feb 2026 03:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Ry1i6YX+EzibDDRoXDQ0u7IlHEg
	WmIl6n3VsyPdj1Io=; b=WMWzzArovJ3hdD6fKnH8IGp5AChw3irshFywY0DyybB
	WCGKLwms/C+noQyTlE7eS4PWpg1tY882LXAP1+wuwi731Zqcjrq2GMEecb4Ne/Sv
	oKyD0JvFdE/ikpF5o4uVx4mK9+QBO2IVoBlYyGaVDl4Sw5HnxjNbYpKXca1j3uAB
	pLZ8gAK2bW1/GUyINXQOotpY51s3rZ+mVJoJFWbeHcKacbfHYO6e7M4Fbd9uJX7s
	kIMWOimm+UPGZboahB7zKhDdgxT7HAQEBUDSPEcBNEkKUfmRaxBEca5MsbDGnuPA
	QlUrLIBPOKxJgnmryTS5oY24SYb4gi4yJaGikkb24BQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c8crw9qxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 03:18:51 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61B8Io9w018438
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Feb 2026 03:18:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 11 Feb
 2026 03:18:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 11 Feb 2026 03:18:50 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61B8IeLU020013;
	Wed, 11 Feb 2026 03:18:42 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: dac: max5522: use devm_regulator_get_enable_read_voltage()
Date: Wed, 11 Feb 2026 10:18:27 +0200
Message-ID: <20260211081837.8169-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: NAR2J0IjPUA1H1P5owb2a1Z-jfmXP0FA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA2NiBTYWx0ZWRfX6qjCP+5Pxi85
 mnFqRsyY0PW7cD3fYwbcFEoyScYyM9kf3d8HCvUIo3HSbn/Pls0yt+W080rAqDxDpWk79Pgdp8V
 fPJnD60BwoqUmHpmIUpYPKuYN7GSmdewMrVgw8XItvlFwBVCe/Gmb2lTnlfjYbKVU8J/Mnar1Fm
 0rfnoC5t+mzxvVLh0pva2djdQjZHeJd/zVGmWmdP03BIn1VzkRn6XsSDxWUUacLIQPTloQvzaQm
 1IRoiDbQZ4bUQiWCC/Xby72VoCKmC+4nWsLCFahs8/40lj0jFdzq14oNJfFXwRiG7xjmqhsBF3C
 rsg2m4WNcZ+rCa35psKvlz3y3qzqaTvnPJXYOdS55W0mihrDVqoQ6OGDsXJHHMcykN+ZktYugLG
 BIsTZUmZpQHrYa1GZzOSDijNe50kevlzj07ANAmnIC+UTHVZ5b8CACIQ59b+WtvKWcGa5u3uBO0
 5tT3kpxs7YR3FX0n7Eg==
X-Authority-Analysis: v=2.4 cv=fPo0HJae c=1 sm=1 tr=0 ts=698c3b6b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=oLd2ivcZAzAyQPFMLHIA:9
X-Proofpoint-ORIG-GUID: NAR2J0IjPUA1H1P5owb2a1Z-jfmXP0FA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110066

Simplify probe by using devm_regulator_get_enable_read_voltage() to
get, enable and read the regulator voltage in a single call, caching
the value at probe time.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
 - use vref_mV naming convention
 - use (MICRO / MILLI) instead of 1000 for conversion
 drivers/iio/dac/max5522.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
index 1b8fe6b8d26e..459b333a84a0 100644
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
+	unsigned short vref_mV;
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

