Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143525;
	b=4fSNARwxK6qVzXE78DboRdMiRDG9h9JRv7qDRrdgZ0krP9NNQ0tZQlU5U3OfMLJrSOAQ
	 K9nnmMwuJU6HHtWzNes+3XRd0JtknWa4046jT2IwQZ1qH31/Nxm91qKeo8SEOBYxitk4F
	 j8gS4A8ch1cx/hCYyCYz+fHWrQJO4JZpSrFWtD9igDh2YeY+aM6RSrEW60xIeEsnG++c+
	 9heuZNwtGtne3y8i9ARyo6vCzRLcQlIatqnia7mB3mb2ioemeK90SNpdDZJSD7qH2C/me
	 5tto82SLNLeNtLyoC/nR6xm0bwfCjLRMlCp58E1hx22uUrniZ0BrBw/KdFR4RDFbWIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143525;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=PCoHANnt4ozFp4dVRkXapIGxL+OwB2BSxkhEs5tpDFA=;
	b=KRnnsmVHLhBkL8nGw0ToPU6xEn2CiqDtmcrvkR2+gGwSI55V/EYs4sYT3ZY75PTFWJAd
	 PsyGTDQacAqYF+wCxySlAZphvcgpKH4ryjSb0w2IYmlbzSZt/XjK4aHtApnktTe5MPF6x
	 9c55YkZpOrfLKcNq6CKveTY7tAjKdrEqOuY0n6TK6P+1Z/n6G/GLcRiJsFsEtXhguQXuf
	 bfhg5ZKrx0b6Ag8RFJvraync8u8ush/+dMId5jFxTT9hDbj3lTBXyScr0i/JZtvMclzSw
	 xkTDgUMVeXBpjvzHNAIpwqTM4NJYUi8XG5hx8vsluOfShcj2pdhbZvaIHcON0QJLSNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=djCu+4Dk;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1F606A326;
	Fri, 20 Nov 2026 02:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B1F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=djCu+4Dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795143493;
	bh=PCoHANnt4ozFp4dVRkXapIGxL+OwB2BSxkhEs5tpDFA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=djCu+4DkM8d5FngHnYvYnMnewkrvi9+Yfpqpxiui0/FE1Zsf3SZ9ehxuxDZ+a8OGd
	 Tka3jd4u/YwD4DnafQZ/M4SQSTuKpH7WCSK4pgCVDuo2vIytxTILs5GLIe2uJICooU
	 1l6Y+d+s1f9/8jTCqI9JRWobW3Md3tqlJ2C0NkUk=
X-QQ-mid: zesmtpgz4t1795143486te6ef8ac8
X-QQ-Originating-IP: sGlIpOj26tPcbAOSTVx6aQ6mUiBk9EL+afXPC0Cz/y4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Nov 2026 10:57:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10726218846586734631
From: Siqi Chen <chensiqi@uniontech.com>
To: nish.malpani25@gmail.com,
	jic23@kernel.org
Cc: crofts@kernel.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: gyro: adxrs290: propagate chip ID read errors
Date: Fri, 20 Nov 2026 10:57:54 +0800
Message-Id: <20261120025754.4075038-1-chensiqi@uniontech.com>
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
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MWuij3vnURa5A6zHho1zuflw7NRAP7c08zXc8HD3nUrJTAHS+RbotJei
	/Dpt4U6tK9HbJ+y+ePeuOsaiQLsUDDtlhFZbeJMQ4XFFl3PbKL+MS8tyWt7l95s1t53+ptv
	p7o2Uvh/4xaQTI/dQy+s0icIcm57YjyN0dZaGtV97M7vQ0XaowwkAVLLL1WBQY5Jr5tA7XU
	aUnT1UKoQdOHol1iPUuBe+XI48NqnxJtmrReunfkZcX/E0S3Av2mpRkJmFhshR6insYH5Vv
	GumbBFFNbF9kCBrMDm5QxNq0Cq0Bp0CFb7vSMCaUYeNX2SPYIDdbf/LkYoN/ENu27jpoHCM
	nFZpWf6jFP+gXeIVZtrO1wXgF2I3wG7FpcGGXAdCw83xnWs/8ScAUJgOLKniYo44FaD1RPj
	M/zbYeoCSe2+FofJvXvZyvBDnrJKx1+Ibv6NkjxOW148Yxlt8UWa2qZvCQ+KPCBNAJoH2On
	HCpPVPZuwhpqrVFXftFvavR28gzH8Vw/mwpr6PVurLTHngvEqHJS2z5fXv6jvkKfjS8Hmvp
	KqhHayzFtkMm9/nH4NXxkh7Jc2uVv5Eyk62ZXuCDHInAU4hQDHSe+mF89NSj7ZbjL1/JTIz
	ivmmaoe/dUiqNDOzvEfluj3czqmbIuL4D5uGIdgVT5cVo2FTKhC+YelHwc62mweolVDHGY4
	XGLjm7cCtbv3G8MiRnNUP1PKPVOmLH7F3IfSGPqXZGe+bjh5sgvw8P7nmgq+lPgpqpXDyWm
	/H6e/PpGVNpUCgDqASsxIHCnajqKHBnKQXp7u8CQ/pbqihxo7LKOkLtD32SaYTPM4SWvJDm
	1lmRtDrLssP2m2W9c+Frjv3CdwcYaUH43y1hmHt1L0Ur2LicBjIQj/VLmzp8QjLDVRPM9l2
	t8wG8WjhpM4QUP2uAs6WzSbEYEg0kaIWR225EuiE9yLoBY2WSTyCQVnxffHxyCAtUEhHJEC
	GczGpMoyulL22dab0u3wbZFiOUXnMCDKnjLhDXNfER5pKIsFH8tRMMeODX4q4w3+qlQy4lS
	6ZkAncQS116XCVyAqGgsFht2KAKnxhy2M7I0Qn8ZJb/tdyasR33VrHqAKO7D1rPiXob4weG
	w==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

spi_w8r8() returns either an unsigned 8-bit value or a negative error.
The probe function stores its return value in a u8, truncating errors and
treating them as unexpected chip IDs. Consequently, an SPI transfer failure
is reported as -ENODEV instead of the actual error.

Store each result in an int and return negative errors before validating
the chip IDs.

Fixes: 2c8920fff145 ("iio: gyro: Add driver support for ADXRS290")
Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
---
Changes in v2:
- Reuse ret for chip ID reads instead of adding a separate variable.
- Log chip ID mismatches at info level.
- Move the OpenCode disclosure and testing information below the
  separator.

OpenCode was used to identify the issue and draft the code and changelog.

Compile-tested with CONFIG_ADXRS290=m using:

  make O=/tmp/opencode/linux-build-adxrs290 W=1 \
       drivers/iio/gyro/adxrs290.o

No hardware or SPI fault-injection testing was performed.

Link to v1:
https://lore.kernel.org/r/20261119030709.3792433-1-chensiqi@uniontech.com

 drivers/iio/gyro/adxrs290.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index b61cc81122a6..2e0bebf2ed26 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -622,21 +622,27 @@ static int adxrs290_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 
-	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
-	if (val != ADXRS290_ADI_ID) {
-		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);
+	ret = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "failed to read ADI ID\n");
+	if (ret != ADXRS290_ADI_ID) {
+		dev_info(&spi->dev, "Wrong ADI ID 0x%02x\n", ret);
 		return -ENODEV;
 	}
 
-	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_MEMS_ID));
-	if (val != ADXRS290_MEMS_ID) {
-		dev_err(&spi->dev, "Wrong MEMS ID 0x%02x\n", val);
+	ret = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_MEMS_ID));
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "failed to read MEMS ID\n");
+	if (ret != ADXRS290_MEMS_ID) {
+		dev_info(&spi->dev, "Wrong MEMS ID 0x%02x\n", ret);
 		return -ENODEV;
 	}
 
-	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_DEV_ID));
-	if (val != ADXRS290_DEV_ID) {
-		dev_err(&spi->dev, "Wrong DEV ID 0x%02x\n", val);
+	ret = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_DEV_ID));
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "failed to read DEV ID\n");
+	if (ret != ADXRS290_DEV_ID) {
+		dev_info(&spi->dev, "Wrong DEV ID 0x%02x\n", ret);
 		return -ENODEV;
 	}
 

base-commit: 903941a9b06ae445c70646ab061b604c2dea17d3
-- 
2.20.1
