Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748937;
	b=z6liOYCYIil0tzmFDZon64qnoQTVeETDBzM29m0VtsaTOMx90/JBXwSSWkaZnuVvgCtI
	 aYoHIKrVk3ffKeYHiyJmSDGssgbySmGSdOMSp1wsjigVh3dOuR+45YUpY+KzxSSZ65FAf
	 RV0uqJCU9EFdEsEWvBmQG9s6i1AyuFEd+m0whbzUqP2tZGAV5zQxRgwpoi++ni3cKd/cb
	 USssJWmxtlMzRGzbf3mK1u+WxkVau5/KSs32CB2iINkf1tXPbGbsJX7JSr6qkaZrqKaDk
	 pIAH152Ilf2VTlft022M5HRR6Kc6NrHSMr08lEq/HeVNLGyF+l2Wgqw4uqR6E90ZmRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748937;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=10eyJpAQvW/a4wHUh/uD1mg6vd7M0dREkanXAJqArw8=;
	b=hL08zoJ31qkZzeLlkChwxcKwcaSZcC2+pap0oXv+QXwSfRuXhcu3QQsnSO6f6JKemVg0
	 GAI9t8XhNW+IwDEYeKQJHP709LCaLwGxxNcbDKdYIoWWOkQA35OsPDjN4FtBm2yvdPtYj
	 EmV0HUiKQlRGYBcHXmlH7WpXtZdIHLMYNZe/QecAXV9LgXgNO6K55dwRAuceI9rDJrL15
	 9zpH+1JvknAAa8Z+hWYAv9cA3dmVq6L5FCmfYvGPwC0O0566At9biWqxAM8poWJpYxps3
	 p5kc98QMs2kOVM5afGx7udOy5VrBSYttrUs0efBlNFOdGT9JCtUvrft46m4zJzR5KYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A5A606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A5A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748894te7612fbe
X-QQ-Originating-IP: xjQ5CKCwVH4HkKKwwwUMmM+3KMaPFPvTzetNc9iQUWI=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9436805003848365847
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/18] iio: accel: adxl345_core: support mount matrix
Date: Fri, 27 Nov 2026 11:07:53 +0800
Message-ID: <AB3626537FF1BFE3+20261127030810.3150676-2-hexin@hexin.host>
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
X-QQ-XMAILINFO: NU60Kbs86PFjfu7Tnubq/RP253XQ8p43A3vRLyXLvsmeGqBvN2+iG6zr
	TW/7ViF7mmWVHYTP4xtYfThDeDpWs2cv83k0CsThAh39GO/oGVmdlss/rArjsH1XoYBP9y0
	O70TfRJtw/IGzvbhQ+lfyl6f5s8o5pTz1KcL6kvpUCQSDvsVbeebsSfSZIDLZoItAxTmCW4
	Q7yKLFvtk/NUuDXSRXH+GPWpEK6FbDwOsKNwrVqTByOrlpfQeT7dW8btAblhsGIJy62o+bw
	1VoTtA/S0w9TV2fElRFML5fvgsiFePK3bKdSJa7B0jQi5YNreOP18vwKRghr7YE4W7a0wVQ
	gFMKQM0IoDcgsB4mvicMgZs2CHW/covsPS2Em5kziw2810qqxgjIKMKBB5EzGJ+PLrQHIW7
	yWrJVxy9myOFX5LGdPSYwn3rXR4HcxGa2DMsIDLSSrM9uPBjVMHz7sI90Ff37KVzgav+EQB
	wt88kGEGCRNLrEf+ZRmX9HXhZunW6oFifvh26kK0pqFQjYntsj5ZrQ46X5KIoQ3WSobmu1A
	6EFlUW4ip5VZh6sb96axX+1fHp6Fe65YeDEyFP8bs2RXxDx8TVxTlE+aD2166U9SKYvyHdQ
	bewGAzKPMhoiyMWxXyyURFIUXBAGetGMKfsnXqLurLOuUubrznH73ANjuqky6uxIv3t6Qrh
	Rnj95xF3IeTPGkHMs2GgsG0bkor9LyJg6lLbhn0f/l6f56eAUigriFCBMbjOop5D/GIRAo+
	M3kOQLjq1K5EK1BPaqDZGDfsNXWHO3V3O2IKrw+Ze8yhTfc+dSgyknkGRbpDDqHurDR11o0
	3nSfha6jRCcu5OWeIsmgItzw+sWo8UquaJuyHzlygYdpuvneF1Xen26MkNF4Y+61QE1AU5F
	N4fQ8dbeZtLtBj6LNf4x+Z4KYqzNqEd8d4YddIsyEvWtl+cQiF8RtH0yb+9x9Hz+cDaPGs5
	+PrpGhZ15goBI26wjr/a7s5nZ7fhQqSXZKbMq6bN4TbVogJnKfieEFn16HjVP9mu8ptw=
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
 drivers/iio/accel/adxl345_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6c9080d..2a77b55 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -204,6 +204,7 @@ struct adxl345_state {
 	u32 tap_window_us;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
+	struct iio_mount_matrix orientation;
 };
 
 static const struct iio_event_spec adxl345_events[] = {
@@ -248,8 +249,23 @@ static const struct iio_event_spec adxl345_events[] = {
 	},
 };
 
+static const struct iio_mount_matrix *
+adxl345_core_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+
+	return &st->orientation;
+}
+
+static const struct iio_chan_spec_ext_info adxl345_core_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, adxl345_core_get_mount_matrix),
+	{ }
+};
+
 #define ADXL345_CHANNEL(index, reg, axis) {					\
 	.type = IIO_ACCEL,						\
+	.ext_info = adxl345_core_ext_info,				\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.address = (reg),						\
@@ -1902,6 +1918,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(dev, &st->orientation);
+	if (ret)
+		return ret;
 	st->regmap = regmap;
 	st->info = device_get_match_data(dev);
 	if (!st->info)
-- 
2.53.0

