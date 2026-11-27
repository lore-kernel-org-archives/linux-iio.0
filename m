Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748989;
	b=JCE1bVD7XtZJSq6w4aSfoLOTfPiukkFC4aoVcUWY1u4T3fe6IINTuQ/DGlfqCuc/B5jw
	 V1A0LVnJg7HBQAg6T46PKaoQMFmlzFnYTHEhbHOT/00RBNoyP0IVi2nkvCiCXqDhEHDa5
	 9N92BBtRYlkZTNrNB7OYEOtONz9L8EHdG4LECnWOLSMYIGaozGd5Mdx4rTp2zQ+Q2snLQ
	 x72aP6RRAgcOaIit2wYonDBOAm5uN3i53vs0yvaPgyfaDnbHAsxccKxNr2zKgizgje1SA
	 1ewZSgqGduevS7oup1msN1KQSeK/3zzbzxzC9p872GGjI+1e+Lnl48HO5SDoIOd5Wjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748989;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=2+lQfZNXb6LzzYOKmKq/0Mqo3bkUI1dnwJZdO9CV66U=;
	b=CUFuckCw368ew5a6s22q35vuFryJkqNAu6Fv3nLy8WNnQEAB15b6bNdA0z3jme3SojEJ
	 aqsTtxHT3gzG80jX8XuViTDOC54XVJe8bSTgs4hYQR93NV9s+dIvGjiXvNDQw7NRG2Kqk
	 xG/XhEGmWnHA3aWt/2Mhu9hiAAasRWwDF8tT9DEyv6+3INvy5eBlKid1ORqqbXmvaffYg
	 xkO9SFeQwURmV6T0lr+41d27wqnHe/b6PCepTo581JKgPERAuATaHLe/98ovrUoRRB8yo
	 j+PAXf2CHJG+u93ND81FyXNROV45Wj164T7ykgwxnVkz8Mk6cmA7W+MM3hFMuUg4Tuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.204.34.130
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411A606A323
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7411A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748914t0695891a
X-QQ-Originating-IP: d1nX1DrsDOvAKqJkPJfQOhT8L4opKObmAsNVbC4aJpA=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10115562110172198225
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/18] iio: accel: dmard09: support mount matrix
Date: Fri, 27 Nov 2026 11:08:03 +0800
Message-ID: <FB033DAC46059391+20261127030810.3150676-12-hexin@hexin.host>
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
X-QQ-XMAILINFO: NP3iUBCWMtGbgJRQyTQoZRJ3l0pXyeMm5T3G5QRdQ2edW8jM1Lie2xOQ
	KN/hAZ1s0Ja3zCsWvFWeXytHFsGPa9+9jS2XO1Y0+aa4nEGo+i5TCuY5BZuVQfmbQWxnfxa
	oCr753iosABRkRFn9kuOmpp6eY8IcjiA8Knn9cwbzoROm0OYBzVE062VZZx4jxnhk7UXPch
	5zISkfxAb401Pzgp+p2jeWU1Fy23kml7nBPjc6oCd0trsuCbtr6ILmiRWprnX7q9Cx2X7zw
	afyRXC5AW74qqsgOklGnzQKQLc9TudxSdqvRCurhloG44E3TQgVpQprIOmaakbADmttISfE
	lwrmbcLD24jdc0aHs5s3rXhCKwGBvoy+xqeVDiDCJcaDdqRdezVzGdDA9rSFi3hkFg0PMsg
	NmB6nR1RGK4kGKYyy7VwRd/O4lTdZBLWV+8IXVab6lyXXPPEiMVzI75VrNLY+IDQ6aQM2e7
	dahW5DEKlQihL1Wj2LpY5si/YIKbb2/xQBZ+VqAk3DXUKxZ4dQPxgzk5waqpD9Xo4m1Qguf
	7L9zBa89LKhiPhvWd6yvHBOuqZQW/PLne9F0gh1Up7LmYQCk6lM8kwuxwZh3kYVqfeb46VY
	53k4zq4WH3yUPlwRmH4jFE2MkUazDIaZ56TcssMVRK0KRCJS9eea7LSEunohxbYAeUIU1q1
	BCUxegjpl34tYDj+zTGLdSchu142WesBF6w1TfzDa2oCbPpUCS8DqpHUX4JY8DXOTW0dWVa
	OQc0UVq3De/juHQCIjIc3UnjMUaa3TcAnFWh1rNWMg/MYhdiw72kxrCygy1y3aiwSYVJBRO
	tSfIZzODWo2yHRkgHVHtWrI0R2u1qsVYRQmJWGfPr9B0LX018AYQ7fb81VkR5whYQA/zfOn
	LpqZQaqKRWSGhZchL8Rz7viRy6KLjTt0W4UUTPm6Y3cuxho+kxd78kMg5fLizvewvhAbYAK
	E4v8B7oROkoGnZEKVKGXJCRHh5UherLvxfyAMO3wcKIDe5tsuXPu82KC+Sj6ss4TEOtwmOt
	L0KEJ9/5Fv/oo8ubA7uWeTtvPABJg+VqyBzxCLqg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/dmard09.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index 6f0497a..c5fa74d 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -30,10 +30,26 @@
 
 struct dmard09_data {
 	struct i2c_client *client;
+	struct iio_mount_matrix orientation;
+};
+
+static const struct iio_mount_matrix *
+dmard09_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct dmard09_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info dmard09_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, dmard09_get_mount_matrix),
+	{ }
 };
 
 #define DMARD09_CHANNEL(_axis, offset) {			\
 	.type = IIO_ACCEL,					\
+	.ext_info = dmard09_ext_info,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 	.modified = 1,						\
@@ -106,6 +122,10 @@ static int dmard09_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
 	data->client = client;
 
 	ret = i2c_smbus_read_byte_data(data->client, DMARD09_REG_CHIPID);
-- 
2.53.0

