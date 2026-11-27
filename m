Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748945;
	b=quQLXZWpli7bRBa/tHKBTXBmbX+H6HV+zvATgTBy4TaLJWI7TcilghddRWNUwHPA562X
	 wuPD9zP4V3uH0eTaS7VVRCDqOCrCQadpSDybxLM4QhB6LQdpHxXKDNjsMMqJbGMoe7pwT
	 wcJYvmNh5GX2eRmzUb/dyEz1i0sdDFobLPd9q5Kby70BN67lEzfrXy3ecqAQ6mGgNJIDU
	 YgUVilJUULb7aeuo9vyE2wJBhdB2WvkEe61k7xU7QlT5Rss3OBtlxCDH3UdkSPJAjfTJP
	 LN0LOSdYx3XaXfV8f37vFGszw3F3qj0HINIbdNuOPtB24DAjuaqznLN+bX/iEBaNLYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748945;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=UZ6wx4UcG7ECkDiy+guzRebyAKtowdx9zKVnincx37M=;
	b=J1G89ODb1vcoHB4easTJrEzqHERmzK8YJGB6WA5WOKV7dSX6kq94GjRS4ND+CYRtCiUS
	 iBlShca8EMNGWuTR1A6Q0S+F3V6hOPj5DEk6hEtmJVcJl1nQ0JrQSAwo7niW3nRpg2JtX
	 /qEYYhYfvPa6/cUK41frMo2xNv5AyVxYClEosWqr1/uFZukuP0mfniYWBfmIH+qzYyzDO
	 8Tj6CanC/GfdIIf97DuW1lHzkPBR2f4OnE9EF5mbzdU7A0MtkQPiWpWP3VLzn2487oyms
	 2bQZ0qsq1ZHxVZBSMkGtU2S3kpQUgbSGlbdxU6HuiOAigD+bXnZWha6EXGn4A6TkMBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3F606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03D3F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748898t2dd818bc
X-QQ-Originating-IP: p/gdFbJySZNqSrSyNwlINDTiPVeHbqNCO80SBgimSMA=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18169503715838854702
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/18] iio: accel: adxl367: support mount matrix
Date: Fri, 27 Nov 2026 11:07:55 +0800
Message-ID: <B5C54C3E55145C33+20261127030810.3150676-4-hexin@hexin.host>
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
X-QQ-XMAILINFO: MpO6L0LObisWaiHLz7Ugrpq5BPHEt4cI2BjpHUcAcMEfIXiBhbVRSD7w
	3Hf++Ex6CYxzS2HLU5PvWpewqwPFhOOuZfvITx5PEsUlh6tnzo1elk7KGo/0X1VWoR6AfHk
	/xghEZvV1YoatEzdmxqNOJWLDTwKL5MbV6dGJJGlbN70AANG5ReRSs+/x4sRCVzTYMLXNQT
	zLWR7mywngJTiEb9oEWkhKV+ebzxOuxqZcqRsQJWqhZyn0u3F5SDGi8RlVJXbyEsmqXixl3
	MWi+fm+UCDrGLKiOahFeSYJrYGSoDjzvg1hvEUF6fD53qCRzUy2anYcJzGAKrE5pozmj95I
	MRCMIiadx3GWF4kGFToQqhAIRIgdIxAtOOBP310QDRnv1s6tXHZKfZ1k31HCtiNo3gagmj5
	WfWYcknTA+crz/wjD/yavU3n2cixfXeFb7Xv8/NbCKnbDszu9AsHPoCRVOHUM0IfryWd5Bm
	G/hJUwaFjs6dxFwcnCoGFpW+cSyq6p/JhXOjNLObI2WGyTHMbGnprXOKooAROvMtw8wWFPC
	8C2G3HAaEhstm3on+u+sn6ny7jZyPLDnFmqgVS549U27CT97QePN3glbseCrQW8hOIk1CqJ
	QpNZHDZ1QK/Zy1vILW0VJSRk4siWrBCb284lKnGpP09hgHuLDKmXKFljT2AFMYab4KOdo04
	ngwfJ6/WuWc83MVnQ4x7aUYq6vP8UASJMnG6dpoOo1l1hHyeedUmflJc07n7vzAFNYH25oO
	cTePvjaD7PADrfmysvuAXltPI46z2tJvESna81W1rtYSjRCzbRvi5s9ncB/Klt0dp8VgWOk
	K0qlCb/lAmxW6JRY3e0mtNxoKRIhHf+5WHRJgx5W4IdFCihDjCEvV2Q4kQ5kGHb45l0SDIz
	bcMBRbt1R4wxhXFES1zOghj24ib4DnmvXRHn8SAzP0hxaEfLHTdFam0xW1GyAQvR9yhRgR2
	hLDzij9f5Usq6TnzGrSDyAirpAY9R1b0qqtTQu9LhHBtE1+tuQJDsYKVWkLRwVw4FYVQiae
	SFjKKMmwEmowksNkd4Y8bbgnwS927/i8hiMEhZOA==
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
 drivers/iio/accel/adxl367.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 4ff1c7a..e370a46 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -181,6 +181,7 @@ struct adxl367_state {
 	u8		act_threshold_buf[2];
 	u8		inact_time_buf[2];
 	u8		status_buf[3];
+	struct iio_mount_matrix orientation;
 };
 
 static const unsigned int adxl367_threshold_h_reg_tbl[] = {
@@ -1328,8 +1329,23 @@ static const struct iio_event_spec adxl367_events[] = {
 	},
 };
 
+static const struct iio_mount_matrix *
+adxl367_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct adxl367_state *st = iio_priv(indio_dev);
+
+	return &st->orientation;
+}
+
+static const struct iio_chan_spec_ext_info adxl367_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, adxl367_get_mount_matrix),
+	{ }
+};
+
 #define ADXL367_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
+	.ext_info = adxl367_ext_info,					\
 	.address = (reg),						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
@@ -1439,6 +1455,10 @@ int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(dev, &st->orientation);
+	if (ret)
+		return ret;
 	st->dev = dev;
 	st->regmap = regmap;
 	st->context = context;
-- 
2.53.0

