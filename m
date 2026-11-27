Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748953;
	b=TSkLScLYDgRld5hV6015F1xjxrrr3MGUB7dDaJxebWkL/nJCehZQDWIKsKq4V1jxua47
	 rCVa7JisLV4Q2QVcklxT41+Ne4ecAUHH7FLL3qTtIOK+9sxdI2wPPRZVd97nER/qJEsOH
	 vggWEjTF07KPGN7wJ/9Y5gHyzOHDWiU5+6szXBSiwnFyyOwD+zfVVJREPBRdSWdWre65J
	 g6QxKpTpsOCF//oeACx67d1I5xwxad7iUnBHHgXxJ0At2RntDjJ1Vu/aJAp8dBjZk3d/4
	 VMPpiUh8iHaKU1MmqxrX5bBmzssHAblM2/TdOcS7PUM+w/40snoYu0IJ57XsmUMSX7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748953;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=DB/5Dd9vHFJV8ko/ZyJt+NRYLbO5OR7cYMsv4soqGbc=;
	b=jWniPpH4StduLzd6zAGju9FJbUvuy2n+Xib0TS62uCyj67zly7+DYeUf+cqkqAckdQvp
	 240oPlFuvs4Amovn+qSaEyEwwAAmHmPEoaBibRdawhq9rbERcw6jJ1tDK6eMxIEkJG5Vf
	 MSjb+Aa+MKV08L6LKhWPR8RXLOVUEI8kHAE2n+uJX1EQ+GwoUbQuIYygYTmUbRTWWB86t
	 vI+5eMq3jQfIw/EMinx66F6lRnBfvT1pI3b05yw79BW9Qgr2+eMx1DD/wJCr6Xc8n2Fft
	 qLwHdKVAW0WiU88xH/3E2/zaq4BJJIGA4ZgNocst9EUE2UJSv8eLGYyydYKW3oeXKMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2D606A321
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A2D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748909t159079bc
X-QQ-Originating-IP: 3s0D8wJx25iDrOiPfxzlbMYe3ZURS7PpRQO1GsWOmfc=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1431452205348039948
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/18] iio: accel: da280: support mount matrix
Date: Fri, 27 Nov 2026 11:08:00 +0800
Message-ID: <966FFAD406C5B03B+20261127030810.3150676-9-hexin@hexin.host>
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
X-QQ-XMAILINFO: ND1mcvCvQRzZtva9fj0yUcOEDyVR87v5yD5yenvs7nTXFq4dWm0A93Zx
	9TBT1C2OlB6uHfr3HAg6ES2rm01VYJ+6o2YlWwGECDW9Mau5Fv7HShLdIveKjWm2o4hgSdq
	DVkG7/eGG2PjhU7QTa82n+YrZLdav+OYRvkjWvfmKlYHh0SuPOe7ON7d9DBjlwYWWtOuQax
	ugUgoYmWhCfmMcEh0USrBrApfP5K5UZdT3zO/fqS5sLT/mo8XAe/ckjsO8dAQSux2KDm6nx
	Dv3DUY3jMNqh/w9TjklBXXVjTTuf8lwjWUXsjmU+yxesO5vplbhP4BGyI/WHBG3CveX4XZr
	WspSPPus6nGJKJg1KdfcOXtyYCb3ljolwuKOYmE6ZwqDBW+K6Gf4BoMJR3VGRn+rrWJvt2D
	rCtnAl3rmfhMKsapNv6ULzfT4lr2e/jhemAW2kLM7litgyJNbs97495nYrSJGoqhmx+mS17
	9IHIQvzhK15dN/J8UodluUzVyQHFz6R0dt1kUEbEUyfgO/O5ykjIvKznqR83XRIn6Skafeg
	7Gg73U2tfb4ZOq0fqUFkNDGj5uvpJrjZKrYfYmkFBJ5ZCzj4jjYzXljycDwu8xm8W27JqEi
	+uM1JwihirTpI/71YpvKrn1oAdAfc0jG+O5hjdJfxGILTnc7xZPci0havfnC6H3YsA2fdgC
	Vc0G/vTcWALFmsnvj9QD4Oi15DkQV5BEFnzmYgvy8+NmlPYQurtvhQh7fYXObbkKLXMk84F
	jUUufrMWlkN5ylLwzQkDyrmgImxmmTQPvwEazQc5VXiCaM+3kMfc1RV/JjX0YJf6VxHL8wA
	eEemfmVG8hlg+KOiiYaFpUjx7t9TWbyG8imQnjCa/kDzNyHKBpCtFVApXn+IpJ1Ft7XCHTv
	w3Mf2wNU6Xu0/3Xo1WylQY6UMOBmTfySrfHaD588r9qa0NKqvI1mbuDuZuOW/KkHR0eGdYW
	CR/w4ARuSNr5jCmuj04d+Mu+Z9h6+8UkdP0e4+4Zl6u8V9WxEZtx86+T6738qYGocVNn4QX
	QZNhUsSuoRjPUXJXxizYny54zMWDicS4xGbte2ZrxiAAyTeK/MIedgJwlz+KLS/YucJgJ6A
	YA15Jc8WO3x
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/da280.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 15acbe1..e093eb2 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -30,8 +30,18 @@
 
 static const int da280_nscale = 2395019;
 
+static const struct iio_mount_matrix *
+da280_get_mount_matrix(const struct iio_dev *indio_dev,
+		       const struct iio_chan_spec *chan);
+
+static const struct iio_chan_spec_ext_info da280_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, da280_get_mount_matrix),
+	{ }
+};
+
 #define DA280_CHANNEL(reg, axis) {	\
 	.type = IIO_ACCEL,	\
+	.ext_info = da280_ext_info,\
 	.address = reg,	\
 	.modified = 1,	\
 	.channel2 = IIO_MOD_##axis,	\
@@ -52,8 +62,18 @@ struct da280_match_data {
 
 struct da280_data {
 	struct i2c_client *client;
+	struct iio_mount_matrix orientation;
 };
 
+static const struct iio_mount_matrix *
+da280_get_mount_matrix(const struct iio_dev *indio_dev,
+		       const struct iio_chan_spec *chan)
+{
+	struct da280_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
 static int da280_enable(struct i2c_client *client, bool enable)
 {
 	u8 data = enable ? DA280_MODE_ENABLE : DA280_MODE_DISABLE;
@@ -119,6 +139,10 @@ static int da280_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
 	data->client = client;
 
 	indio_dev->info = &da280_info;
-- 
2.53.0

