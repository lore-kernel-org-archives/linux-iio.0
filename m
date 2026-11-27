Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748999;
	b=ZRgncibKoZKVm4+Ievi5HNUM9C+O2kEfGXFSUn7q6awe7gYR5NChWAGC5pDp4rdzqtjx
	 CpwH9LSPMmH8p7YNXmWprILIID8xSBiB0CdyhNhovQuIZfpPawy//bg+b9yS5Js6qC1RA
	 OaEXRVCqBghlWJtFjtP5DLeJKg0fNmfgz36i+AUhg5LcUUJLThL6sCJ7Jj6fsA7q2+V97
	 DDBiBJ2kcp4TjDOnGJTPo5MQthR9xAnEwSyh6F2YvEeM7sS/5Iy+QXfyXilgUAv+3OTPz
	 OrtGA9MA2jT0EVqab9WsOQgaDVo7/mnPtZ5VBkp3jy5DtSeEhRnYnvS3Ayx10SHQ6/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748999;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Br0NJuM+iwNMTK7hNpxdv91hTY39j368XoGBYY9tSRg=;
	b=PjyeXoOap9LSOffr1BigJ8fMfA6k1xD8mx9/JvXQBfAVvDT9dGQgga+5VwyBpFZxJAaR
	 7yoIKklBl8+wggwC+4HD636MTwGPc9igyIN4QJwRemV+FRSNs9LfPuQjMsiBk/fjmUiQ/
	 XdtB+M996chRy4S7qE4N6haU9bO5ym+eONkumyZ6d4xPIS5AtiPwawgElxmBERHs2Zxf2
	 T8y6XmGHfGTtJ4yo+XupWZ/w6sRGpizjL5WQdrsYESvyTi2RzX6E+eHMF+Prqqn7iKCQL
	 ZJM/dBnT46AvdCz9UMZlPC0x3irxcXHaGjbV7dPWDWmpzN9mM24N5GE3OWqhkkqYpXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9D606A32A
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A9D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748923t98557a26
X-QQ-Originating-IP: GnbZab8Fq8qPR4s+h0dm4bwK6gKhqBTNaP6PHgvwaRc=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3724851885726245133
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/18] iio: accel: mxc6255: support mount matrix
Date: Fri, 27 Nov 2026 11:08:07 +0800
Message-ID: <9B3F5050E5D3ADCC+20261127030810.3150676-16-hexin@hexin.host>
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
X-QQ-XMAILINFO: NcmC868q55ANvn7x0X962sS5b558ZUeJk0uNkzEAVSHDbJXAm26NV38f
	U6sSF5ZC3pRZ4Q6BTrGkcj/4bJ3HPt0OoQLUT9ywlpKadp9U3fyCtSeG6c+MAY9a/130f+w
	SMYGorJydmi50rUWPPgGIP8hpzXvyFPTXuTY7TnWPzcoK/MmNQ9orixQ+A6D86BMcQ2viJ9
	u6hK+A44MtDggzmK2bwUGezMmJt352YDvP2in6yvYZkDKZsLZ7DJ+ahFioWg7a21BVHOr6q
	jnGx0KCW31JGdvYOcJxfR2YIM/I+GlJ0EPVe/YOlA7PuTE3FPDll4en0PUyxhm5skrIfvFi
	knBMlsZBFspbGwjIvIBb5ZbgX/IWBxJmimUkJ6lBWLGaUEZPJ2vS8MKPXHREmi6L7Gznlz8
	HbiEUPB6S8wtPFlRQoN7WsCkr1ZdTbu/MSDjm93xBzRqnJj8b0Q6jz5As5yLFYX8ADEqaXf
	hnss586fchyX9fo+ZKxzIFpA2UPSLVAq9ouy5sHFG38lcyoljISmOHL169uNunRk/RXqpLO
	zH6btqRyU/KT+OyAoMF35peQXzc1jmzrcvqNHy/hG9xBUzcMTeE9NtksewCs4EgwyvF+OFx
	T0qkMqmtq9xBtAJr+lD+xuUNPNy2ewWuS7xWrJOau0Z7cl3Ias2GYriArhaC8gJsNp9QS4p
	hh/Ugf+WrvMcllYk+hD40S42k+x7OjinSxFKxdkWY84xopcwQREzzZtT/4FYpRnf/bmBNsA
	ZEqfh/2YOy9ObvCrnlX53uXY/73IBAUI7aw7uWnCZa7GYUh8jKuqomNtbNdD4023IEWWAwT
	hMyZs3KAYd51ML71CPnXNDD5bx2GFQ3xKT8UCIdpUSAoRqTmCfWCWCvY50WW7DjJNLoDZkU
	SVSouus4kKf5nVp0OD+AWnFgRBySI9bNDo6BwtgftEYfdLqawmp4HeTUpq53C3z1cnKEvSU
	sVzs4UWQFzwpq4Qz+ji0wIRiIw80DZnlZnZFoUOlpDyQ7UxYNGfj2PWiRAu469RK9QvmqDh
	Mv3O753GIVrVLqzKyfK19PZDkZtodhFA/NLhOdwqTd6hq94VxhqAzduWOtJXE=
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
 drivers/iio/accel/mxc6255.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index a9f41cf..4d5a229 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -42,6 +42,7 @@ enum mxc6255_axis {
 struct mxc6255_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
+	struct iio_mount_matrix orientation;
 };
 
 static int mxc6255_read_raw(struct iio_dev *indio_dev,
@@ -76,8 +77,23 @@ static const struct iio_info mxc6255_info = {
 	.read_raw	= mxc6255_read_raw,
 };
 
+static const struct iio_mount_matrix *
+mxc6255_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct mxc6255_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info mxc6255_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, mxc6255_get_mount_matrix),
+	{ }
+};
+
 #define MXC6255_CHANNEL(_axis, reg) {				\
 	.type = IIO_ACCEL,					\
+	.ext_info = mxc6255_ext_info,				\
 	.modified = 1,						\
 	.channel2 = IIO_MOD_##_axis,				\
 	.address = reg,						\
@@ -130,6 +146,10 @@ static int mxc6255_probe(struct i2c_client *client)
 	}
 
 	data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 	data->regmap = regmap;
-- 
2.53.0

