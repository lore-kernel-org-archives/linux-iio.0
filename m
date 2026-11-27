Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748954;
	b=GjpTMyaRsrgh7VexRlhL0s0Ay4E0/TdeT5l3CwCpu7l3eh34oJYo9hzvYODdSOvdedWl
	 NTOpZs7esv6Z8E5DEJwd4LPHv7HzLMY9O9cNtsR+jVt9I5ng3oTAD3lM5WV+FQ7xHoEie
	 LAmNQJMtv9I8r5MvSrHDGha+9thAut6cwaoZ/dO5w4ln95sl1R+5iq066ZOfq3SQEO5Ij
	 P5H64+9SCQx+VHPwnZJsxDmUDBWftOGaFwdiT4zRLL0ochhuq018A1cT6CmXKmDXMhtUI
	 l0PK1Zd+jjS6/NjahVDfLIUSJXa0CdIzwQ4vcexp3fsHrYNZWFd01yEDPazEglR3JRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748954;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=1vDY2JqeAvvpBoaAARYk6XlzjD2e3mSuqlC/xAS9Ygk=;
	b=AGpdC5kikaFq7z6vqG3qw2OVugs1IZdxe7n+ao0QjONwCldHQThHZjArVOG8os6rmSid
	 u4vUhd15TqvX+Ty2fB5V2o+/IhTIOU0q31z33gxaeQ6gtStQG5n3WwYjuMMf9KlSbN8dt
	 pdLYL9SInKMp2SUV3XUBHwbzUq0PiXDlJUjZWBe6JxY+8ZpbruMauvNpRoX/2XhfnYO0E
	 +aHoZ8xx0R4VsvnE3mgvxtmgH6N7zOpwQ19GvGx3WsN5/YWOSWFI1hgdynkLpoECaxUZG
	 JyU2c06G0iOTI/CT+Yjv6GWMsqgJJWrCxsIrByyj/KH6e+ibMCGaKm1Yz03ONOGMzEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE8606A32A
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EE8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748896t99396766
X-QQ-Originating-IP: kmx/QsBgAE3PHKRc0YnezNDFgpJ9aloyT5rH/NCxMJg=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7660707397409459350
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/18] iio: accel: adxl355_core: support mount matrix
Date: Fri, 27 Nov 2026 11:07:54 +0800
Message-ID: <22D5F4C14A749294+20261127030810.3150676-3-hexin@hexin.host>
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
X-QQ-XMAILINFO: Muaq8BBEIoEkgTQ20m109QDKarp4JVUc/Y60CicfqG7Afb0A/a41Ke79
	QjoqHZVpdHjg7vw7NT/JicUqA3nlLLQEoJ5C0p5d5u9jSeB3SyJsoL1ZAEwnIPLVWZ24OyF
	q/l9RV1uSCnqTVuyUfkJ6IcXrguW388jJRdMrjBL169nDLwSbIGjs88kSgL5qEKpMpJUFvd
	v0DO68pHKa87qOeJRy7PEnkE6bYFPxDsyltN+gsFy/A/ogMwrsq/+/iiFsyToFu+1wF8h9h
	zHgyY57KpoSmkp9tdFDcB5KMCy3J5d0eX3Yw8F8OflHCEeM4bjQNg+lH5UVcHzc09FHrm2p
	NAqnbqMUgxEZJxgGZc3AbFE1ultpp1AuTCxBVB5inD3eDzJWLu8K9TkmZnF/Aa5SgWyYpG+
	A2S6NEeCp6o1P15Mg4VOUoMC85IoonIZlUbEMW/YmCCRj7KUD8GGT/0CayjAp0CrZcwFpCk
	OghHahREwuPdY4eJkCn2/vIIqveYbhtgjqd3QaatVkcUoUGXPt/2Y5embR9uM//IQmC1j4a
	vnf9e/zokLDP2429dF8f1kfXfEK3WZPEeedx7lz5vtjc4HNJB+IBRjBeThZAUwL0x2nQcvA
	jlBLLWQ/ZhlwdmRYJDX07W782LvA+C8ILTma60hIUZiu7ZEsPdUZ+3GHri11GW/34eXlZM1
	ci6D9Ore/7yQRf8obRj+2PxT8ZGpmF6QA6fUOS8VzBpoIlEpLbWxYxnkzs75gNyfW0FQ6im
	PrSB/VKdx0kK9k/uhsFuRjYKf2OAm8LMa/3Oy63j48ae6ookR7dVhWWAY7ZKYXu+6fOnI74
	v7vjAOXCV15ACijQUT/Yk4Eq4uSG/gDmEndhyD8JuIiFveQY5H+b8/izNftH12FPvkWFYUJ
	u3tEtleAPLOkzMoUiP0iOm3TIBEIQoBxuVz4/3iih86oJKvTXqV9ZzIlyMXOrAtIOJtB6UR
	UkRp7Znsalnj7dKG+FCZZKoQMJnS+76WMtwulUKgCkMEe21bXb654mhywfY9c9ZkqcyBiuv
	z03NerEwn8Ia1aMiuVHdPqkSJryQg=
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
 drivers/iio/accel/adxl355_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 080c9f6..00c24c2 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -235,6 +235,7 @@ struct adxl355_data {
 			aligned_s64 ts;
 		} buffer;
 	} __aligned(IIO_DMA_MINALIGN);
+	struct iio_mount_matrix orientation;
 };
 
 static int adxl355_set_op_mode(struct adxl355_data *data,
@@ -707,8 +708,23 @@ static irqreturn_t adxl355_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static const struct iio_mount_matrix *
+adxl355_core_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	struct adxl355_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info adxl355_core_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, adxl355_core_get_mount_matrix),
+	{ }
+};
+
 #define ADXL355_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
+	.ext_info = adxl355_core_ext_info,				\
 	.address = reg,							\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
@@ -792,6 +808,10 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(dev, &data->orientation);
+	if (ret)
+		return ret;
 	data->regmap = regmap;
 	data->dev = dev;
 	data->op_mode = ADXL355_STANDBY;
-- 
2.53.0

