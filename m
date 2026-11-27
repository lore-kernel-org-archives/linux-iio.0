Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795749006;
	b=G11k8+dvKQ5SFbw9D26mZeHW67Q6byZkvsr/g2WYV1MvrdWrKrS16Ob6Au9oOET83NsM
	 Dyv4ilB2mZsygfk9UfbqK0DMSERFGn89pifdVyh6lZCIcqhzzoIRhGlqLWxKGTxoqusDO
	 EiKGvCZpam3jpptdnlN64+HpdpNS0T1Ro9rmez/rkeYjwfeNj0VZaPQS+Pl0vyv9vCvu9
	 0l8QHtF7EbNTE/D22OTw1HH3xckRoOGtaylHmOw/DeHw8WrrdZe1Ly+bj+7h/V8NvNmYN
	 vrDh+wb9mP1YMCXzeeX1KczRW6Cyo73Seb4o69mUd+hBFAdm5RqB4L/EuuPgNjOPVyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749006;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=1hWozP/pTONtcbBiQHcR8yOpuqpQXTp7bn79+Qctjzk=;
	b=vEn/Es2B4lFayOSPUnFxC290gW6acTvJZh/MyhOmHRpi19eD3cLGSFgWuiMeXK9T20UD
	 QiaZULcDd+uQgkbNxkVh9qtAxisAR2spsjYWAph1wZMBS+/Lo1593Z3fQJL8n265Pywm4
	 eogqU/O07VJ/MejzDJGqDZHHBcl6ZC8YWSexWwsXDz77wz1iWgUl00Xj1dUJ/AYIFdGQi
	 eyVxXuJyYpUXeI5PyH7ScmnKn1HIE0P9jlTdeBuyIpD5QyJeiCLDDoVXOjz52/7MNngHy
	 ZBy9ss31l2rgnApJLa+5AXfWshSnwUmRYI5fKJZVu1rpA4pBez7EuxCMWD5peWkgB1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F46606A321
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43F46606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748921t31a6ed97
X-QQ-Originating-IP: uE5KC4cRuIzEnITWLrzZqK2tsz8N/UqPg88TD06i7WU=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2871138312109599710
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/18] iio: accel: msa311: support mount matrix
Date: Fri, 27 Nov 2026 11:08:06 +0800
Message-ID: <DD606A2410296BAD+20261127030810.3150676-15-hexin@hexin.host>
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
X-QQ-XMAILINFO: NlVgJxuVJf8So7O47JOFYtiYKQBSCxC7pzWw667fZisZ6oxkcKdhbi7u
	bjJEuagVKZEkLZ5tSuYKRVG4A0/qT/vFAF9ityE7Ro5xTSpqS5EwYgcVypliiq5LRUDiIRd
	eOIGhk8s7yFTwZ8dAG0lhtIECa9O4DgU4R21Bw4uGGfzenSBFGbmCybTKqIhoEygfpSaYUC
	Dc48zJxCVDla8DIu8u3dbghBwUCOwLmUGJLa9dDQ6vbyuqtc/1lgxLU0EsVmG3mAcsdfOVv
	UPLn/qFJzq2zlzoNIKpF+46BGFW+5BiRdl3XtOv7St8z5qWtqbdfo2++n7uXFyfdmSn1hCM
	vyyjxGGBAlWjHvoodPBjTB1emWB0h/WaEsijsUGNf7Vv6dXBVB0r2ymW1rSXddF+/JCfexl
	piRpw8Bu4CQjWcTg9BRLk80BQUM06Ho1LvNREIUJXEwAz22T9xFgKpLE7Zpj7tE3XK8Fn18
	YcqFRGBe3iajg7oFoPPsrQ6nqiXCSW2PzsuZ17UOXHWGEuzUIvefcpFINTQRIKcEtXkxxag
	57/zZD1hMlC/QFd+AafF7uaJ5NC/986u9ZdrXe6WT3XWta+7LeXDP+x2NvIt3SxRjLJPeLk
	hNGb3me8jQDp+EZsATsIBr09pOzGoARB622/QcZZa+C7MD3pcjOcrdh9qreDh97SAPQYk0u
	daB2bqec8haCbLCgz6rf1q1WgObZ+WblV76y/wtzgeSDUfYK8EoB8MeuQkh8d52bbAhKNqp
	qx11/bnsNMIQf7s4IUgy/Jpm1BKhYZZT4sNtIwdMLStusliz8IkaUIHIIiySX6yFCS0+3QJ
	48CIwfAhTJElwmruvVRBEVI9Zi+Setj1D4RyQOMeppOUN0rbSBQ1OBL4dSvzoJVI4N6flvd
	1Redu/M0sHzZKv1bxkn7RL6bFzQjRg6rg6jY8AypAuHKX6lxnECxzni96NsrU2fgkDP/kAo
	38TIEUaucs6OO4+qtXy8W3Zkn2SCT0+PkC/pWn0PTXUFqW4hfoXcW7QZVagmTgeFEd84Bpb
	LBqFhxe3NSMYhbofd51kLN2MQo5Q1dpqkai02YXIHVXZpPTIwek3PA5L3Be4U=
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
 drivers/iio/accel/msa311.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index caf9b1b..78b009f 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -361,6 +361,7 @@ struct msa311_priv {
 	char *chip_name;
 
 	struct iio_trigger *new_data_trig;
+	struct iio_mount_matrix orientation;
 };
 
 enum msa311_si {
@@ -370,8 +371,23 @@ enum msa311_si {
 	MSA311_SI_TIMESTAMP,
 };
 
+static const struct iio_mount_matrix *
+msa311_get_mount_matrix(const struct iio_dev *indio_dev,
+			const struct iio_chan_spec *chan)
+{
+	struct msa311_priv *msa311 = iio_priv(indio_dev);
+
+	return &msa311->orientation;
+}
+
+static const struct iio_chan_spec_ext_info msa311_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, msa311_get_mount_matrix),
+	{ }
+};
+
 #define MSA311_ACCEL_CHANNEL(axis) {                                        \
 	.type = IIO_ACCEL,                                                  \
+	.ext_info = msa311_ext_info,					    \
 	.modified = 1,                                                      \
 	.channel2 = IIO_MOD_##axis,                                         \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                       \
@@ -1149,6 +1165,10 @@ static int msa311_probe(struct i2c_client *i2c)
 		return -ENOMEM;
 
 	msa311 = iio_priv(indio_dev);
+
+	err = iio_read_mount_matrix(dev, &msa311->orientation);
+	if (err)
+		return err;
 	msa311->dev = dev;
 	i2c_set_clientdata(i2c, indio_dev);
 
-- 
2.53.0

