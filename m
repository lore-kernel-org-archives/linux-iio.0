Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748985;
	b=pu8i7zMcZJndFyENRikRGT/UR2mrnmbNHsleSktXmhbU0bL5wYgn99rQJ6ReoQrZac27
	 MHULvF+0u4StNdjnhOTwlnt8f47j6J3uFoBz4jz4JMrh7/aEl0mPw+SDLQzzTMEKaMhC3
	 M/imXwldTXDHotSy9rx0CFwAicj1IXPCnYaVFRZ9R9sYVAlI4hGFXNWPgMgI26GmU+Dbd
	 mkgIJ3uyCzKWXK7aqmalNycWT6jiMZRtrU7yHHVzLMFcxPR7I2id6Gqiau5y0fKdKcCPl
	 81PI7a+ZGtkfZlyqt7MhjvUnQ2BQ4g3xskU1kTBvi9mD4EkqKG2xyvR/Er4Re0QH6pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748985;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=PLZ8BZvpHiupbTya4USPGg86HeihgYdk6E5SfVXEJDA=;
	b=UHgKXUxhDK3bzsonginiOANuKQHkAwzlMBO/kcQAINq/zNfEcpCF1giJ9nWM2eVDpB6V
	 0DzbHXwYYeWqi07CMvLzS+fkA+7GS4qMY6qF/KrzLvxgpJIy16gm0OBBCGlfaMvJkBMAL
	 J2MROkxJAu8/+OLUxxhJUXg2CcRbsYrq0vWQbZYJDo2+MhQjtozbc8Y8jqIpcFVFko1n2
	 P2ZnyBWRI1sNcrMW983VBJy7oayNHfvtcNZhYNRH2596HLbHUVy5gweupl9IY9behvQzF
	 SqNEM685bxuHvjcxLSi3frICogW6X65lDqE57xrtdzSx+Lr+qMpqa8iERtLv6lmYVOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703EC606A327
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 703EC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748916tff561309
X-QQ-Originating-IP: e055lsoyOl9DJ7hzTjNdBlotAAGWerqKm3yaboeLH70=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8126916822772834824
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/18] iio: accel: dmard10: support mount matrix
Date: Fri, 27 Nov 2026 11:08:04 +0800
Message-ID: <887CE0A8E3B55FAF+20261127030810.3150676-13-hexin@hexin.host>
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
X-QQ-XMAILINFO: NlVgJxuVJf8So7O47JOFYtjiW5iUEWaA2daZHBzxE+zj1fmSFEWoWwWm
	hJD8zuecZ9BHp9YROv/wU6anHhEDopebNjCdOLcwhyLFuTHsVyJPcqm/1wUpj7ge3+uonNk
	yfDOBlt173Fax/Oit9XpzjSBzDsM3Qoi5jBDvRkQAJohoPCpa7+kTrSuSZyLlcnpPEvb0Gc
	WO27naudX691fKjZGpUX3+YVVWjrGxUD9SChvPwovmD9c2mnak/JFdB8yZrkbBvVXqIxjSJ
	JEv3jjmpKVTjPXcDJn0MqYrmKY8ihhHDL+hij3uMB63EE6uqajPZdsn7uiPnBaYGlyA3FxQ
	cMmESmUO8fFsiLm3pI9Tcqvv3X7NdwseQiVr4Q9Rj1jnRRj66yqy6XmMAkPts2jCxt5I9CT
	FhML+OCu6Kq+GVjQ4Lu7RaypP26Ehcz51DDzYyNob3u55rRXOQomuUAktLTjdzrSQ+nxVgG
	RV7S4NnDcmiq1bhHWoRv5FIVooN18KF0gFebYRfkvq857EC23ubP3TsIH3ZdTvb5vt4f112
	qdHMh7tJbtVF38Te+nHkIe1o6D6rrXE2DZdOd7ewU1EgFMUrUECeXS0bc4m0HIqN/yjsggV
	y1DIrYh/v7aG1wRCdsANCmWDU7/crZPu3kk3ER36g1G7H/brC/yP6PUlBEaCOESda4qCeHV
	60kFi6znmWCLTlxwISdr7Egw96ruG4IzCvn9fkRi9p24Yz96Bp3vSvi1II7OkQ6CU2SAca9
	TCqNDSEx2uWFyGt3chCOrtCTPCIZg7KokMfwIEiQ9nauK76qbguUCTzx2ru5SeAXArz2XRN
	LFx7ZsfIbQAywW6E0Us92yvUdIl42bouoFqOp+Lk/PD7/i4BuDnl/T9T/SjQGuzpCohceZU
	u9FK4dA5LCGl2t7n8h92v1YIug//Ki9g0Sh2/m9L6DILD8k3lWCFtYvF9S4S5+K9o3Y7Ew5
	5ZzqB2wKP80YdML2CX+Oh6s63ofPjoX4SN5oyCXjQxASgqxkThGpjIN+vHiFjkPD15xQR/D
	8aVCJHVK8xYf3ypsRKBkhwX7UX0pwkXUvS/os3cEIH2zvhdJnzCv5+IOUePhk=
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
 drivers/iio/accel/dmard10.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index 8ba00fd..11674a8 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -51,8 +51,18 @@
 
 static const int dmard10_nscale = 76640625;
 
+static const struct iio_mount_matrix *
+dmard10_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan);
+
+static const struct iio_chan_spec_ext_info dmard10_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, dmard10_get_mount_matrix),
+	{ }
+};
+
 #define DMARD10_CHANNEL(reg, axis) {	\
 	.type = IIO_ACCEL,	\
+	.ext_info = dmard10_ext_info,\
 	.address = reg,	\
 	.modified = 1,	\
 	.channel2 = IIO_MOD_##axis,	\
@@ -68,8 +78,18 @@ static const struct iio_chan_spec dmard10_channels[] = {
 
 struct dmard10_data {
 	struct i2c_client *client;
+	struct iio_mount_matrix orientation;
 };
 
+static const struct iio_mount_matrix *
+dmard10_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct dmard10_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
 /* Init sequence taken from the android driver */
 static int dmard10_reset(struct i2c_client *client)
 {
@@ -195,6 +215,10 @@ static int dmard10_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
 	data->client = client;
 
 	indio_dev->info = &dmard10_info;
-- 
2.53.0

