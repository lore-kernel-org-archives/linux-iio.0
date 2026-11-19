Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057706;
	b=2N2fm7xB6eU4woTCv/hODpBIR5sT7toKPS0uN7bHl0ewxuQ/g/lgBvMCvRqfNmhQ6zvL
	 9gKS8LqqrHfow7ndCx/PlGjQ17GmH/IYrrJtAwYklOnVSLn0raatiGa1iEnSc2Nii1Qvz
	 u3E8t/Uv4JcrYhIWjYDqIyhHreLDqxBs9HZEPv+6O7aOjQiG2KM9uceRGDxKndeukz1nN
	 V+SvfuEo+i9ND19K21seTgIyH5iatk9NnhYDn2hvahVK1OPcG6yqiKsnZQ9Wvf+UcD1Ry
	 oCa2DDaWe1UpcAxijqrPfqE0DDrxFooBqsMAoEOzgDpHQ6g1NnvM920JsO6Ejb055Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057706;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=KIdzZrFkpaTDr7W3gsDfnaswYebzCSotARH4SUhtoak=;
	b=X+YaVH4i+xogRfcPGxyVFC5jsi9IXQy5+cIQNQTtf2C25mUVKwO28pUSv3rZMY7OYYqF
	 CeJNvvY9M6ZeHjVjkgv67sjQaloS7W1LFlYha2RjTkAC+xFd3T77JgWUs/Q3uItZzv2FH
	 Voc6lbF8jVNK3D+SPjcsrWajtiYeWlh1fqOscR/E2CZlNCByIRjq5a7ff3mDLoutJd+Zg
	 zCY1lWS/zFwn37Ytf3DEbUg17o4qvbziy1aWWst1klYKRMfDpcryGlQrzwsSps9T1gmmT
	 IdzVTqB/qQLmStPu9lp+cNqWODYNwg1RxDM60IB+ICTPG7EmTfWbAOIGT9OQ0/+ggTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=czEh2g0K;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEF606A325;
	Thu, 19 Nov 2026 03:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FEF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=czEh2g0K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795057663;
	bh=KIdzZrFkpaTDr7W3gsDfnaswYebzCSotARH4SUhtoak=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=czEh2g0KxPPWhU1IONH0WebV/eeMkUBEfAPr4wjtRzyoXbHDQtRwChUyI/pXIVVXs
	 yhYaU1hAJOz1T8PGqRxu471FKAAdNyaKonEMG5+mByekoObuDBGDzV4Ala+PliwteX
	 8CDeXbsKM2vYRBK00+G5mcNrkFl7Xd730FlrniQ0=
X-QQ-mid: esmtpgz14t1795057646ta7893f9b
X-QQ-Originating-IP: 3DK/lMDE4yBtIJDJPi84ozyxWx0+You5dONeczytTXA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Nov 2026 11:07:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10885263091152778059
EX-QQ-RecipientCnt: 10
From: Siqi Chen <chensiqi@uniontech.com>
To: nish.malpani25@gmail.com,
	jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Siqi Chen <chensiqi@uniontech.com>
Subject: [PATCH] iio: gyro: adxrs290: propagate chip ID read errors
Date: Thu, 19 Nov 2026 11:07:09 +0800
Message-Id: <20261119030709.3792433-1-chensiqi@uniontech.com>
X-Mailer: git-send-email 2.20.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N4v3rtNxGsNSrpeeacze20N1apNksIHqCNAeAnVm4ULWVRrizZZ82Ljf
	OMMcZ1rvtHD6FjZlr4aFkrZWi9oLxu0cdHMX7JOyefYbAjtk3gC0FhYhoFVvYFUmpNGMWB+
	rYoEDdd7Y8Z057HdiURoBU3ANFhyi7ru4OW50yEsT+uGi61mClexK2wkwG8am81wsr7yMO0
	hsFwSYhWsQmMfyJQ4ui5jUP5d48hhJkD4KadIixl5MbdtZ1VdymCvI48Dd73Tt0NpYCrjRq
	nV8czKtToIJ94/3TeXJt5K3Bpw5lj4lDNNA2jWeWV3wCVSCXsgGxmbql8SuPnmScUcwYTq2
	WfpoqePdTaD0Mva19rI23gARL28tSn9kCVaVcfdVFKc7PZGx2W7qCtVJJuTnQCQdMDYGOjj
	pZj7hvasVqvdT0oXFxuYCWKylHe0rnk5P+0XyDlsDKaRZhFLGqZ+s35faw6wcjAZ7MI7Q8N
	fZNhMIvKBpeUoYF92y7MbIT3oxXRHzQ2vrAUK/kByp+FTaFoUySXKIbyAHOqsCZ7StY6UEO
	DCUXQ5lHRUPyR9vemskXZySXDDuN8/TnAWKIRBrkarftjapEYRQB4v9OUww5hVpEYpnv+8m
	DVgIliatWLPpzhtADRSiCWOPg7Ypg6O3B6TKUmiqDz02KSL2PcmaOGvrus9BeL0u+eT7WC4
	+S+PiyvQfwuE/GHRHLPne8tcougtdEcfg/ycniNggFpupEMPF6HHMoRQMpx3I6pQRn4QzPE
	2DnQTE89ClGYajOKd0NEuPav0YvckIeSjXldVxXj/YB3BZBZzNqUsEB8ECXjHJnfCkOF9x3
	Nal9EVTVzYh0JGQVuy7YP6OmBYzcodaht98JMQY+paNGjdRjUKE2dt55N89/kF+Y3ywXBZ3
	lXfh7q0625BLdK4o0VNuED/7Ny/4DFsMrd/DSIf6w/LWErCzs+c3eEWGBJF63RU0sjjBA2u
	ZFbPQUAuYu/uOjklM/p/Bik6SCCAyyrKtzOEHBUFY6tYqJ1iZtHMHAa4eJv8GAO5dFTMR6S
	adxaAXIS39PsKk/punprOIbkfOMugbXSeZLmkT3cPkkJv2kPnhGCTni4Lyox7B7qG2psFaL
	RScV52M0yyMscLOZ8mG9+Ya9PRgTh/cNg==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

spi_w8r8() returns either an unsigned 8-bit value or a negative error.
The probe function stores its return value in a u8, truncating errors and
treating them as unexpected chip IDs. Consequently, an SPI transfer failure
is reported as -ENODEV instead of the actual error.

Store each result in an int and return negative errors before validating
the chip IDs.

OpenCode was used to identify the issue and draft the code and changelog.

Compile-tested with CONFIG_ADXRS290=m using:

  make O=/tmp/opencode/linux-build-adxrs290 W=1 \
       drivers/iio/gyro/adxrs290.o

No hardware or SPI fault-injection testing was performed.

Fixes: 2c8920fff145 ("iio: gyro: Add driver support for ADXRS290")
Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
---
 drivers/iio/gyro/adxrs290.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index b61cc81122a6..eb3306215217 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -604,7 +604,7 @@ static int adxrs290_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct adxrs290_state *st;
 	u8 val, val2;
-	int ret;
+	int id, ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -622,21 +622,27 @@ static int adxrs290_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
-	if (val != ADXRS290_ADI_ID) {
-		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);
+	id = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
+	if (id < 0)
+		return dev_err_probe(&spi->dev, id, "failed to read ADI ID\n");
+	if (id != ADXRS290_ADI_ID) {
+		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", id);
 		return -ENODEV;
 	}
 
-	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_MEMS_ID));
-	if (val != ADXRS290_MEMS_ID) {
-		dev_err(&spi->dev, "Wrong MEMS ID 0x%02x\n", val);
+	id = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_MEMS_ID));
+	if (id < 0)
+		return dev_err_probe(&spi->dev, id, "failed to read MEMS ID\n");
+	if (id != ADXRS290_MEMS_ID) {
+		dev_err(&spi->dev, "Wrong MEMS ID 0x%02x\n", id);
 		return -ENODEV;
 	}
 
-	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_DEV_ID));
-	if (val != ADXRS290_DEV_ID) {
-		dev_err(&spi->dev, "Wrong DEV ID 0x%02x\n", val);
+	id = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_DEV_ID));
+	if (id < 0)
+		return dev_err_probe(&spi->dev, id, "failed to read DEV ID\n");
+	if (id != ADXRS290_DEV_ID) {
+		dev_err(&spi->dev, "Wrong DEV ID 0x%02x\n", id);
 		return -ENODEV;
 	}
 

base-commit: 903941a9b06ae445c70646ab061b604c2dea17d3
-- 
2.20.1

