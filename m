Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748997;
	b=FLGluvco/00b5zW4e6o5WZvkMkkUshQyy/he4hEW7mGgDZRvMcbdKWsrChWWwFBseVA6
	 CKUMKLJ0/Qg7QmUamCLlVd7b2eI0f4Di1UdyN9nTYN1pcQFYFaKWxChFi7YpOFSZZxCLx
	 gkCksJTAEas10U0M2ZL69kJ58uXGMb/3F3MSa9IYoKSNJfi9dhYkboQW2ku751FWJIhw+
	 Gf8b5hHX3T+keSeSEx4mKaLk5LBRF2VfVRgBLL3WTmhLmfpGjtobzbVhfudp0i2DAj2ud
	 UWRYnlKg1lyBMUPpHH8k3V2FDtWlTbgGJfLMeOHB96keQNpz7MYXcHtpeYb3D2OomrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748997;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=pzKwktKnacM8oBEZe8j36P/EyUck1K/08RV+lcDRjEw=;
	b=aXN/5JV0Ut09hkIWbYkiLOMnR6tHh+cx5BMezT3Vpkk2m3+GvHobNpG850zX2gC0OwQY
	 8e7YbBr8TgzwgJTgUS7z80mE6tKI93l8PbASbYZQzN6oW2WKOMD3wcxjfwxLvrYmK2X3s
	 bPs7K5bJeFrEaCYVoPB5zPkEr2QKCQ4Z+0WZA8qPXUcFY6dpAdtCRx7M3K9mEDc1LLbFz
	 rZJwV+rN37W6t2K069b0Vnbk3Qbqz7nmrQIlAphgru81a6cwQCvgMYCk7YL2oiYhgCau5
	 z817vlAxXXoYl/2YEqG3YSj3/zCXGqTfu2MIa2RcIPQEqajN3lVZ6Iop5ONJQMBcb8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39891606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39891606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748925tb8e3ce6a
X-QQ-Originating-IP: hYapc6pTlieQxUn4wmngcc/nlN8LOz7NhvWsoT4R3Fw=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5945904841166326334
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/18] iio: accel: sca3300: support mount matrix
Date: Fri, 27 Nov 2026 11:08:08 +0800
Message-ID: <08B4ACC565EF2CAA+20261127030810.3150676-17-hexin@hexin.host>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127030810.3150676-1-hexin@hexin.host>
References: <20261127030810.3150676-1-hexin@hexin.host>
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
Feedback-ID: zesmtpip:hexin.host:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NBkE/PP8DpFYtyav2AnWpnidGVJ4swhsdxIDtXJvoymXyTvlA61qdgij
	gNrmS/3oaj6bGghMOLveJGH/E/YY0ErF4p3MFGtQXgO+r3eL/LYLujkgMvkguxd5qWnsvf+
	wWwStNqi+HGPepN0bzdIGQEw1HbGDRLwk/0oPmMdFEDJm9p71Y3S6ZTq+Eo780ajK4+lJlz
	frOKCvpJ3Ml7R1ivLHmiFS9qlC1Ci2+UpoaHehE2YxuToIgCITqHsMs7o38OnnZd3L/3uj0
	dU/WhCbDY2sxBo58Sfu5SKVkxhOzwv9Uq2PyVD7SjqgjOHiXHyCKw3kYdqYeAJIJRRdZLCb
	uW5twKQ2o1H5x3FoGq2nyZrkLXJ7C8U5kYJZ/wS4qRZf5ciJWpgiBzqN8dzqnFUUch2mCZG
	5efKj5n+KAA/G5hMkLO0IHYv/43ipLQDhQex76xuMu38QXeDWFR/IyLVmmMzM8FpPdkNs+F
	H9TyCfIeGkC6B5bTNoLsys2yKHhYblkwaKS/w0kHbBAS56fvhW4bzRxw0q/dw1yTALe/Xot
	Yam+mCGRDqT9xW4t1otO/eslOKDejxpVVcJQ6aB+uFrfmV5wFW4Sz4FRuscYUWVIZ0S65iM
	HJp/U8CRw8GHX9ADt68oC4QAUFyBKbkgPHAztsACof+x9nmnWVzrDMrU5NcSXzLr75mYdos
	99XoVCaGZ+oxZD8oYY9Efn1wdIiarbpvNjTGrSAmb4CyXKBaiARJAluV/qZ7qAcmkPhPnj5
	IQ/+iRq6gTkeNLIioM+hgWjQfnWqt8+qj1Qu/LygtXwrTs4WEUjkP0cAxEcK25aSXohqP2+
	Tz5aaJn+znyqiDI3IoPRc+xaCYtngJgiKkm5ekzzRod3RcmNMMBMLzP9Q8z+82BZ+vMV0iP
	GG9dv594AgAi3aolIdh8dp3HKWeS/YS8S2yOdg3CcehHaUhk5g4+Iw8sYqgChZENOWXDdYj
	N23iMmuPRL9DxLH3Vv1alJ06BdvZz+UxVRpzk6s71dra8TDc6H/OPSWQYuNjH+hLlJ0joJz
	k9/Oyjt2eZ90OswLjeDskHZtBqnUiOop3BtAOHi37bruAro7xDGijCTlMvECE=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/sca3300.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 67582cc..156b528 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -56,8 +56,18 @@ enum sca3300_scan_indexes {
 	SCA3300_SCAN_MAX
 };
 
+static const struct iio_mount_matrix *
+sca3300_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan);
+
+static const struct iio_chan_spec_ext_info sca3300_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, sca3300_get_mount_matrix),
+	{ }
+};
+
 #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
+	.ext_info = sca3300_ext_info,					\
 	.address = reg,							\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
@@ -191,8 +201,18 @@ struct sca3300_data {
 	const struct sca3300_chip_info *chip;
 	u8 txbuf[4] __aligned(IIO_DMA_MINALIGN);
 	u8 rxbuf[4];
+	struct iio_mount_matrix orientation;
 };
 
+static const struct iio_mount_matrix *
+sca3300_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct sca3300_data *sca_data = iio_priv(indio_dev);
+
+	return &sca_data->orientation;
+}
+
 static const struct sca3300_chip_info sca3300_chip_tbl[] = {
 	{
 		.name = "sca3300",
@@ -619,6 +639,10 @@ static int sca3300_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	sca_data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(&spi->dev, &sca_data->orientation);
+	if (ret)
+		return ret;
 	mutex_init(&sca_data->lock);
 	sca_data->spi = spi;
 
-- 
2.53.0

