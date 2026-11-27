Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748998;
	b=PTyRAcjGAQKWgRr8JTzhlhTUeziuwOeR3sK1MipRdVGSF8Ob+3xWtI4vnL7WNj22/22o
	 p8z1IXBvB/P4OwsUv+905VhcaR0ZQdhxeOYlq5Oi9nGC4EsX5C1lJn2dOnOdxxq+uRdOI
	 gHwCu7W8YKJ1ObnN83tFYZbnvNENzyQUJ3mzMm4tbPQtd/xo583qPdkC/MBbBH/JoC8J7
	 Vul4MSeJsR7h8LNpyw1kls1k+52TJqS0+pimfytnvfwus0C0YLirKOm0WTIMyQVvSnzrI
	 quvV20bLA1v7WDxXcC1a4cXNvWIj097/g6Yxu6RPzYmotIBmTa8g8BGyx5S7DumJubA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748998;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=dzbNSIhByZurj0v24XUeAIbeJl39iDz8rDFwiAIyuiw=;
	b=BRNOLUAMkv6kd9Y6E8zS8wYn4YslHub9HWWGvCyFSGn5cdd/xJqOqJwMxiLsvHA/4ISu
	 ZZRSQXh+i04L86jfLkSQ0mdFfOHFZomAC6eoePAlxRm3JIRsGhzo/kbFMNeX+SeKR4F8m
	 80LDGRkDTfCJ2tH9aOT/w2yQS+1GjPV+SFs+i1h9h2w/at7Srr+Nt5aMAWNPuPHq8abX1
	 JgWnNQCHPK8brRXnhWnSw1NOnlq7Hk16xn08Y7Q+9aNVryzMx2OTr4nUPevW8xQ/9Gx7X
	 18i4FFfS8QqtKZbgmPuViohC4tUhc9rm908hLaVrLrr1+Cnqd3FgvNA7DU3lq9VKMkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F867606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F867606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748913t22da6c77
X-QQ-Originating-IP: OCa/Vv4SbBy9F9LzT1kDdLFCybaM6sM2dmk4hYMNd0w=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14122866134665162352
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/18] iio: accel: dmard06: support mount matrix
Date: Fri, 27 Nov 2026 11:08:02 +0800
Message-ID: <2472E5A128DADB63+20261127030810.3150676-11-hexin@hexin.host>
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
X-QQ-XMAILINFO: MVocNrGTvdgh2zD/I0lKSA3Fr/hn4trINlC78F/AF4Ge0A/ncRA46Jxo
	yJTTck9ApOP3ftWbi3FaSHOlcEhS7g9qpIRw2Icsaj/6412tlJPDd66PA8txLv1+GxohCkU
	d3tcoHNnzPvAXmN70NXtzAzlYHt8F9sBiDPInxjUwYod2W8KRBoLqthPAjKUsBHlKmPdemH
	i8svwk7s1SpxWqMxKipBLtqJCPNmy7ozSIPQ5PbVwixxyMl7VEFRXXGXyka99dVj9y96GOp
	FTu4mPwcx9Boxt3UA0DOGK+dKmpqgNZxgCvRqGML1lp82ZTh6eE0hh6DSSszin7CZXUWJBE
	kfuK+8pm7ycFyDW/Hhq+Zs5sdPguUvVgJq9+twPSOHMSs1Efsg+pd8UMFMumU4+wgbK6y++
	eVQza53HLsyaqYEX5ln7zmfSxvQfm3KqEAFlZ8MukmjUg5G7iGrfJzmAP380WiavtkiWOL6
	5lGEi+rskKxGva0efIY3aemy6MF2G/2pOrUda9TzVuVxNFtheIEGlbMm0hOecw+28RUdV1N
	/ECbv+XL+/6A6PGAe4Wjj4XcDwwHT8fSPRhFHQZ3Xpval/tZdhxWZsqthbnM2aOMPgC8OQ1
	yp0n26UG6z7bxBBhW/Z/hlr07XdkasFbyt3eq+Dtpoqn4pcJR5Uk5W9NilRu/mhbTZeQ7E1
	DAwA78zuFGzOZCKTI1qoXLArMDq+/wOwVBJEToFokxIBZAEkB3UNgP466VvA+hqnGMhvSEr
	6GSTzLIrK76n5Sf23ITZwbO7uQhhtnwn2Sh6PDsA5SVyRSUkVm2EH3GmbPKpoEsRw0XSabJ
	l8Az2IjFAiXpD+XH1bdUQWyxrOn1xHCAwo0rnQqfgkiQZvvJvfW5kUZQMBmRvNLWg2Y0AlY
	KG/XIgZFpDmNWCKblZlzOTyzloGOQZWJKujElp2jLaScwfGo18ZvQmm4KdpuYW/Dks4J895
	WWWV5d97khjG4MkbRTd6k1xyD0J91wE44dInXkdOAVQ0LFBRUaifjf3ijXe5L0AOPsMzy4V
	gDGTCz5UyfZGG8TfAQgbxDGPfkk1Aige2mABys/tPjfFtXne9eMoWrzqs2wQM=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/dmard06.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
index 82816fa..24dbf51 100644
--- a/drivers/iio/accel/dmard06.c
+++ b/drivers/iio/accel/dmard06.c
@@ -35,8 +35,18 @@
 #define DMARD06_MODE_POWERDOWN		0x00
 
 /* Device channels */
+static const struct iio_mount_matrix *
+dmard06_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan);
+
+static const struct iio_chan_spec_ext_info dmard06_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, dmard06_get_mount_matrix),
+	{ }
+};
+
 #define DMARD06_ACCEL_CHANNEL(_axis, _reg) {			\
 	.type = IIO_ACCEL,					\
+	.ext_info = dmard06_ext_info,				\
 	.address = _reg,					\
 	.channel2 = IIO_MOD_##_axis,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -54,8 +64,18 @@
 struct dmard06_data {
 	struct i2c_client *client;
 	u8 chip_id;
+	struct iio_mount_matrix orientation;
 };
 
+static const struct iio_mount_matrix *
+dmard06_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct dmard06_data *dmard06 = iio_priv(indio_dev);
+
+	return &dmard06->orientation;
+}
+
 static const struct iio_chan_spec dmard06_channels[] = {
 	DMARD06_ACCEL_CHANNEL(X, DMARD06_XOUT_REG),
 	DMARD06_ACCEL_CHANNEL(Y, DMARD06_YOUT_REG),
@@ -140,6 +160,10 @@ static int dmard06_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	dmard06 = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(&client->dev, &dmard06->orientation);
+	if (ret)
+		return ret;
 	dmard06->client = client;
 
 	ret = i2c_smbus_read_byte_data(dmard06->client, DMARD06_CHIP_ID_REG);
-- 
2.53.0

