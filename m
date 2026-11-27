Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748954;
	b=jf6dPKAUZFHBNU9Rsx1wC1k9jAqvSHt/GoTg9X4HoQPnmGPF1niLZWR+HpO/rdTYoWsv
	 GnyqV7yjompIBUx7Tvrp3N5jAC3lAGgzZzneW7zJ2+KHB7T/fCFRKcx4jc8rZih37cXrb
	 OAwfBtoPmGFRxO1lwt07gLXdzmsyOI2/BLOOgktqJVZwufWz4iXklz6DrgOvNmd+i1SZ6
	 0R2VyZYAuQ2bg/g0Sp77pxLbAQgRN29HqbFH/jXevSuWzwUtuUrXjLXB6LeTCo52Trmih
	 wrbCF+QQCvWzm8Bk+uOmM9TISMauehRUs/G44ldQK1XWHJfug4ZvJ0vlQmssbV9q3Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748954;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=O3hFAMKdWRdThjfxZRX/BnUg07JkndamL/Mi7Od3xlM=;
	b=rLdre4BiocIk5VE6MCZgWhw9mfrZE0ATTVz3q/j4zPXH1vW9hIZmUUHaytqySFHCBpn1
	 7lMQMp/PCmtlkvnb9y/RjaaxTVbnlgWuiu5iBG8mKIVAD5GiT3zeX+Rcffw7i3eBaCQFL
	 rUSKGBZsLmqFcwcVHAnh45wpQZtrIBlSo4c5iZe4j6sSUPAR7i23j4jqM/xTXLjCDlUP6
	 zCymqSJbBc1cHOwiDoVVwrfy6S42+lTtmeouFdFnN69FU28XyY1/WPGaEhWD+OqtjNiRH
	 shQxFcnWyXpDiENtkZIrnFXsJR3O0b8RUroEWVidMJiu3QCTVwCflBU3pb2e5n2AHOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED3606A327
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DED3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748905t12a764d3
X-QQ-Originating-IP: y1T/doPrNGOrvUKkmpDQjoQBYfbeCvMp6qZ/fnZq27Q=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16690795467617198118
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/18] iio: accel: bma220_core: support mount matrix
Date: Fri, 27 Nov 2026 11:07:58 +0800
Message-ID: <971350673CE7806A+20261127030810.3150676-7-hexin@hexin.host>
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
X-QQ-XMAILINFO: MRiFTjyIbtS1Yi769LoyWUbD40+ZNigtIrDV6FZaSeC63pmTKaFFMnu0
	d0oDag/hxLZkhYRfCuxvyww4Nke1rWoiQYlWnyKK5NAQuCi6uKpRLljg2VsOGjzvG6pKuYV
	6cYTo5P8mGhL8iGpCBw+vH6KCGPlTpzlOWEDbRZIq84tVripH4sWx0UUYcL8PYcCteDLN7/
	8lPJBLCn1af6c3Ufh0Q2r0ZlHi+C1XPDUH78epSvv3E0zitybY00HLtfJFPEJtFT/dDjo0m
	gkkTFAMv0CXlh9KiKhtLaZ8mfrlKxSR42YpOhekrbb02iojRRWuCHl4RA+L7EnL7e+hE6Rh
	9yoAQ/wa/biWX3IJriLALoJjcALG9BktiudOdMqxLJ5TFgY1Kmws5yi1Al2AWL3xj15iAoI
	Yg3pQthhbMVkVdpoMzvkDAvmMhTVKRXxV+R/nqcJ+g2m54L4tjaowJ0WuYb1x/fXESAbVGa
	CT/IOUoQZj8T6yxGA0F+MZ0ZojQPai6mZ+O2Kkof36AD5+9f5Gl4FgrUhvi8HdQcQDgt8P4
	RHKOKJ0JRZJ7znTs8IAyGbMOvsI6r5hQngxfhEkKSszbl48lrKKSlRxK4i+gsCbiUwBIDYI
	pF8xazdYQ5KQf0StkaEVqDGU1tGQjSHtHKwaHXK2AF4hQ5a8A4c+iqwFR1YiapTpOgppmuQ
	KPmDuFJHVmbVcAfzJMX3vRAqLIdyL+0vSXM6zJWGqN1sYg1AOfXhpLFS+hGbjP1CyGji9/o
	zLzM0dGAKkMbfOurXmU53jEmJHLS0e5zY34m3IKUihqwYyXiqmE9tn3DZYIxH7YVg9BtRgW
	fj7RsCutVK8rCywC8GoMBw9In0xtfZG4GkdrXb4dz1M4E81jE0aa5kc9g04p8l2vVv9uKuy
	orcqK/aB3HZyyjQOEEctkn7eeTKPpFB9lxgAR1eUlDiEYKZ5Ahjfmpo2c5gGHftsFho3GI4
	yrPbsaBhADYpnhLfsdHyOOFYqPvStw21gv0ifKwzJ+haS7roMCSAbC8AHlpuY8mFpWfbErN
	q/ur5N75fpsz9wpwlGf3FJ1k1Z2LJtIJJ3rXWjNupsZU/stoaG
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/bma220_core.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index b83abfd..adb8484 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -94,8 +94,18 @@
 #define BMA220_COF_64Hz				0x4
 #define BMA220_COF_32Hz				0x5
 
+static const struct iio_mount_matrix *
+bma220_core_get_mount_matrix(const struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan);
+
+static const struct iio_chan_spec_ext_info bma220_core_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, bma220_core_get_mount_matrix),
+	{ }
+};
+
 #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
+	.ext_info = bma220_core_ext_info,				\
 	.address = reg,							\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
@@ -135,8 +145,18 @@ struct bma220_data {
 		/* Ensure timestamp is naturally aligned. */
 		aligned_s64 timestamp;
 	} scan __aligned(IIO_DMA_MINALIGN);
+	struct iio_mount_matrix orientation;
 };
 
+static const struct iio_mount_matrix *
+bma220_core_get_mount_matrix(const struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
 static const struct iio_chan_spec bma220_channels[] = {
 	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
 	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
@@ -508,6 +528,10 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(dev, &data->orientation);
+	if (ret)
+		return ret;
 	data->regmap = regmap;
 
 	ret = bma220_init(dev, data);
-- 
2.53.0

