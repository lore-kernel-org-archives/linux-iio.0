Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.22.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748960;
	b=zFo+g4/HpFQEyYU6WuYVq4c6zQbdcEtPJxefM6th+2hsWoG+qWYZ20pDBykJEi97wcbr
	 hruA5O6QHymYM7AuBfPRIWOtUq3AaJnhe4Esvfz+LvpEYOR5eWkNuy9x5kQ/cFZfdg5ag
	 P+R2ijJMeaRUWkij6Xjt6gVxZTM5au5rmVTpQaLYNkaaQH2ZHuQs7Bgj71oCnxyERosiS
	 dTlGjwjy0eh1VebOEtK+gvPDJpVuBCx1q2itSpvYbVOyiShwhEGBy4Wk5BJdPITGr+D9v
	 nJgbNxNK/MesRAHcrWUTt9exjjqnB2VaNr7CVdGAfvl3DNn/Nb8xHyxPHIdv/Z+7/og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748960;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=k4030JRwbmT1KLdbn4MvzuJFfhGYUrnwL0leGxsaaqU=;
	b=f2JHXImGqVrBJYzhC5oC+CXKJu+4PQBjRXV/cyPiMHInT6WWCqImQfg7XT7N37c3Lyiu
	 +SlRv8T1yyGZaRvREdpx2MIu6oxmhdsFrkkHvFdgeN4rAUSqx+D4TlhGeh5CWYRhMBHzR
	 f7JIMCFNcAueKWvsIRE0gnpOI/gOQ3FcXTYqCpkOtRGwiUtUQiAQO/M+JznUk8nq0s//x
	 WuiACIBmXZCLvvAcAwScoiSaLaY8Fc21yJ3hh/TrkS93OBQH+j1Z0Jk5fKItZ3oCtvLxQ
	 vvPYztmQfQSQD+Hlq0/pJPgVXlkqXEuT7P1hBYrspseEyYU4xLfblIoPMQ8AhxXnADA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.207.22.56
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E35606A323
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95E35606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748900t39120d61
X-QQ-Originating-IP: bWsbXieL0PD/5/AOcAeZqB4eO0twYWWUEIP1LrKU8aA=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7649906138524751584
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/18] iio: accel: adxl372: support mount matrix
Date: Fri, 27 Nov 2026 11:07:56 +0800
Message-ID: <03B4FA8FEFFAF16B+20261127030810.3150676-5-hexin@hexin.host>
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
X-QQ-XMAILINFO: Mw3/skGyA4U5Dka1DvJQPZj4dCQxzfJONgvp91B62/dA/3a/YO1KRIg2
	+xBUtiDAJdwNlKaVk9bNlEXvXTEC31YN+5s6eAf7VxceYAOR2+5vzgaDf1rUqTHC58FPxwn
	uyih7w7L9Y3acJSeLKdVn1rL4TGy6GUTUlSN5xLnoOeMk3izaEXQ28UdSMPdpu5dnt+vxOH
	LIEa2HYmpuV4oBwaRlX5Sojil3f44xM8rLK2DRH7YEy0lCZNpHcju6ZzbEKyrHQiCLW+smD
	1wPxPSBnH5nT+JXvG8hY++MX4NOdCkP8/NqZzpeBIoAM2V/DVRI00nNPopyrzMPlwNhUyXT
	j81JGecUv4QmuXsu3fS6FysYcIQyBX5qfALkYbMeCWBsaQfdXUijFwn2Cb3SsG7Jj1YWHm/
	0ADbaehsqpnRJvIE4g6f8x9JZnxKZQZ+VPL3OK+Q9Qfw+Ww+qMdtbdrSfldhl5gF02J8T4S
	k7nhdRYcy3YAMfhHqIH61gCA9K4Tau3dqecVpTht3cDinP8at3y5i1Sqjh0vwIKZ5eJtg4d
	Am0Y1iiGA28b9lyVXgKqahFfmSbx+4AWudjp/nJn81hJOQb3djAOZtKn6BHVE3tPIsq8vu0
	b2e/tdLj3OoPkKUuzAAGO8Sr6uVWyxdC3fPOaDepD6xWyT2Z5aHKggzWH5hBW1agQkTfpG+
	qhsGiyuUkQNS67KddllIlRGI2FQov4zTs969gHK7l+UhZc8gydCXZo5p4M10Flw2/4OACwk
	Qhf/GE+c5kDWwZfr9o3zlqy9silNp8eE+bmmmrqJHfR9GLpo1hLL+lwe+gMc6aLqBIDVPAr
	Tcl+BYwHdDID/JJ6UGidJwuybe2B1HVUthAyjK2imNiyZy2JDugO1p0JZjDhfWsnP8SNJM5
	ag8fZY8i27QdEMZc7Q56CerZ1JPxTlxZi+8El3hCWmcBXPKYzyqP5JX8rqoCvOEJV1Uuzxd
	/8VkR0hVqm4GVcr+TlMyG/p5k3V8AfVfMGiWQseBqBm407xZYdMyauxDPoZJaAOhvD0bMk2
	Qh72wqaYxi6UC0E2sd8FGvGRj/H17dSyGdm/Bc9fPRqcqfmkKVYT32Azy4gYvydf9KfjGk8
	A==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/adxl372.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e375d06..1a02d26 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -315,8 +315,18 @@ static const struct iio_event_spec adxl372_events[] = {
 	},
 };
 
+static const struct iio_mount_matrix *
+adxl372_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan);
+
+static const struct iio_chan_spec_ext_info adxl372_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, adxl372_get_mount_matrix),
+	{ }
+};
+
 #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
+	.ext_info = adxl372_ext_info,					\
 	.address = reg,							\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
@@ -368,8 +378,18 @@ struct adxl372_state {
 	__be16				fifo_buf[ADXL372_FIFO_SIZE];
 	bool				peak_fifo_mode_en;
 	struct mutex			threshold_m; /* lock for threshold */
+	struct iio_mount_matrix orientation;
 };
 
+static const struct iio_mount_matrix *
+adxl372_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	return &st->orientation;
+}
+
 static const unsigned long adxl372_channel_masks[] = {
 	BIT(0), BIT(1), BIT(2),
 	BIT(0) | BIT(1),
@@ -1292,6 +1312,10 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(dev, &st->orientation);
+	if (ret)
+		return ret;
 	dev_set_drvdata(dev, indio_dev);
 
 	st->dev = dev;
-- 
2.53.0

