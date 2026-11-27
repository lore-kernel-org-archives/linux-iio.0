Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.22.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748959;
	b=c+mbCtIvqm9USvKRnpBkqgVdpWZx59hTX6zSdlN/LvXVXrlB+QzIGADOLtskdLt1bQvV
	 PCEp+B1mbzW8INzgtDvGMDn6GRZgp6dD+EhfCnKTc/Q7exYI4TQPJPhfeKsDthsiLLojm
	 Rrj7sIFr5OXTkcgfOV+VIw1soKfzAyPU8i4tEnw+OWD6o1iLMjFE54aBRt3TBhClQA8vJ
	 RaFMN2R9do79Dp7Yd3XJR3l6pMri0/SuNQjPRrbXa51WlW1lsbiDYKvaiiZ095pUqJhBQ
	 Kh2Zw+ki4GgqF10PUdVBtJyovUvFfc5v4lxhcQ4Jpg3KJ9Pf9eFk8fZ6Ub5nBGqVq9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748959;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=SGrQcW+oqdamym/ycLPq1Fvss4eYkJUcb8AltfBp0Sk=;
	b=NVrE7jbKHvaRWwzLuSdqveXduduDyN3JFY8Sb2DwNc4S73vhVhCijkZKK70LD/qiitCp
	 BgrdQQix0SD2fThuQNGSN4BrHbuNrZaz0pKxDzrWMQC4fepykWhs6l+PA5VDhJiVightB
	 RSVcx6D8+vE1n5VHYa/jRHDsPCjrP2b+IkkryUPStVOzUKYLtnimwiSRUEIeLrIYPJhut
	 N6H4fyYZDk4qWbuUKHddHB8xQEBNXU0Se1Hbe31tdtAYZoj7e42wUshiAj2FIFyreLmZ3
	 3seUUfc7x7V1dCvCuQiUCmnVk8C73DWVTi19XEmO+2FxgMtMOSuU/AtxFOR/oADs9fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.207.22.56
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F02606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43F02606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748903tc09191b8
X-QQ-Originating-IP: kr5twJdcRFnOcLGTvC9ttqu5BDHZr6lAyG2ejcMke2w=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18021858121498967761
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/18] iio: accel: adxl380: support mount matrix
Date: Fri, 27 Nov 2026 11:07:57 +0800
Message-ID: <86E87733857A8C1A+20261127030810.3150676-6-hexin@hexin.host>
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
X-QQ-XMAILINFO: OCnNLGxuhE2ofUvFmuP+eKwuC4Di0W3xbJbTUY/InfrJdFwqlEbSWGz3
	ebf0jZ0arkp487tw4zZfathQLFJewsmXvKAC1bxgCMulnyacUngUmIsPVzo8Apo9RptQxer
	Ny63D5fZ7Rk1ubhnn5uMJoNXQKRjDcelhGTUIUodnvzZpmcm1FIIl8JYjJ5cgPi0HHGjBuP
	0lecZeELSXzuvM449elXIjxCQiD1G5UCpphc271wzdV13oftgwksQ4sAVYGfA5JAjBTWslx
	JgZsq4Ph1rJPNnlLAZ/bWOA2WoHlF0+Bm9nkYqSMswStNOqsAbySjAzy6pcHT1AhzOtz52v
	frBRRhx3fuEX2EZfL4bDkghlhxt2nDxIL9WdyeVYjfOKiZu4ibwTmzxXdAoJFBdcmkBZ/6P
	6SuC8vkJu8vofg8p1cXLsH5Jzz55cmTkVOCxduVxfu9IfBjNGQNKFY8IUoDetFM3Kl7gsow
	7lD9LkLKYaKl0lcS25xEbHMbLA/WSep+swYv+AcbPJ6TPzBBqnV01dEb6eCWI9o6mf6rSCo
	OYlX3oWmBE079AkltnUu7cFCXPCeuTYSaCwJT7NFRVcnMKjy6V1D0Mx4dGXuZQvuQRMtCAx
	+9/KDg2UKrFod0jAh4mkVfQ+l71AqOj9ssRbc4ZdhYgqt5y8jGaD4xmR9kX1tCxBU6fk8vD
	iaU3JxQTwyTzyXd8Me4x+rLuyl+Dfc2dE4dLYp/Ah7fpSAMylnMbipCs4mxfbtvqMb6nWv2
	51tXKZDBThp+/G6nqYR+aCGvgpmQ/FhF9vLQrMyL2O3g8fSwL96tKhR+JJaGHUsKHPsZDxy
	CyTds0igUDTApz6gUYg9JGWLPnrhdD+rLlBPMfpcyt1ufKKAGaYI/Aj3oryj7wwWIX9lBoF
	eb/UvUuVl5DZV7yvsVd5cMCv6f5IMkEMLUszqAsW1inmlzXsH2p7Z+P4PbaMidJrtKFEk50
	9v4i+9r9/fGl0xmVcHpFfmV3Eh6U+fnjoBHU6hizRh85WeD3cxzWPJnAz+y65Kt5sjxqy9x
	XDfh6Zyg0l05ziy3SEGaWeAleLs/kOng/haFFZkA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/adxl380.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 7dca552..f5fd9c6 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -224,6 +224,7 @@ struct adxl380_state {
 	int hpf_tbl[7][2];
 
 	__be16 fifo_buf[ADXL380_FIFO_SAMPLES] __aligned(IIO_DMA_MINALIGN);
+	struct iio_mount_matrix orientation;
 };
 
 bool adxl380_readable_noinc_reg(struct device *dev, unsigned int reg)
@@ -1769,8 +1770,23 @@ static const struct iio_event_spec adxl380_events[] = {
 	},
 };
 
+static const struct iio_mount_matrix *
+adxl380_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+
+	return &st->orientation;
+}
+
+static const struct iio_chan_spec_ext_info adxl380_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, adxl380_get_mount_matrix),
+	{ }
+};
+
 #define ADXL380_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
+	.ext_info = adxl380_ext_info,					\
 	.address = reg,							\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
@@ -1962,6 +1978,10 @@ int adxl380_probe(struct device *dev, struct regmap *regmap,
 
 	st = iio_priv(indio_dev);
 
+	ret = iio_read_mount_matrix(dev, &st->orientation);
+	if (ret)
+		return ret;
+
 	st->dev = dev;
 	st->regmap = regmap;
 	st->chip_info = chip_info;
-- 
2.53.0

