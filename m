Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.59.177.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795749008;
	b=fT9fKfefEAOvGHuUe0MjWBkt4Uerr4IbgjuiYP1LFSE47b27dE2q11JbZWfklFLtcqy4
	 7eX3ery8XWBtur5FZ0xk0BkHJ7rPyMD8MibnpOdeh+WWwbfjtnTOCPYyFAV3eUEJWvyxk
	 lVrYgm4VfaBzIADs1w5N4PusjXHSFh2BC6x09V6Goy+ctx/38SGGL6G7LM98l648GrnLS
	 UiVwxAtXjJIsivrKSh1Y5xhN+uws+u5wf5siwUNScRHi6jP6xsFuyeaPCxPCKZpBEX64v
	 YnyPpwr862hq7p0EfH2xjJ0zfcZ5vIZOPOSut/kts241AEml8XKVq0oAEUmvee30gNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749008;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=T21bMXOP/XqF4G3WPNDDne4CgKBFOUYQMgSHoXvUKCE=;
	b=5Ng0d3Yc6GL4iX9NUR/xScHCjecFL0h5HZExZqjHJxzUaG2ORcQFw+4febiR4Lb0Pg9g
	 zyh5tAuG0giEhYpxIFsBcyVCxc2r2YgsPyq8AhvBscIvgr/3SuN0+JuebuX8asBRi/sio
	 wPaujHCl8Eizc7NhaJpbEwta15htMyrL7t5G6CxXHcV4nq4nT9zcJ+wAltI5kV+Oed2f1
	 tK+h2ddCet4k+IF5l11W38Aej2tJvHEIcPmrU6zSw0ElZ3275tLSkWRzIlOMi2J+5hqL8
	 AQBKULZFNhDm6lqrw66rH3BG2V8pt2J13VshZt8a/yZFWeANwMB/Xy3BvYPXkQ+nRtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=52.59.177.22
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C7606A327
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A9C7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748927tae6097e6
X-QQ-Originating-IP: UVJYpaOV4S4aAKmGimtq/XJIuVHDIF2YDb0tonl+PVc=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12814583725387680564
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/18] iio: accel: stk8312: support mount matrix
Date: Fri, 27 Nov 2026 11:08:09 +0800
Message-ID: <23A6FEB6B49C0D2D+20261127030810.3150676-18-hexin@hexin.host>
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
X-QQ-XMAILINFO: My+ZGhrsVkq33Jrk6FWnkKFpoP7JdppLWomMCJrsPYGLN40QU2iUBf4e
	vHIQ6MuAnuXh3NPdNmBaDFEANnr18Q0WgdPxjWGZWTlOFeelZt/BbP/UjOlShINYQGqodBw
	aj192K5IDfLWv3PnXp+j9XaI1Mbeq9CNxqj3t7o51gLeWJlop5qIh6A0bSRoybwG6mVkiWR
	GYRT99PkouK0bJnjiL4ZINplAYXXRIb5O3br4pJv6N7I28HsLnYSY7V3ikXA/BpIRFqmvPk
	r2YMCqZ5E2zCANeq3aODr24Onu21h5vHKC81P0MTlrTuIf2+xR6PQl20xFjyNfF0d/zDTkk
	9JWJoFqsvsQf2h/NAitwzE96QMQCIQMClIj7Yoe5nbVJI20zUv3cNJH/GRne0UkLkJmxYtI
	Zb4brsiUTOvtPUjIjmMfw0oCdAjvx4Bz079uS7v0PkL8g4ydhyLl+HQUTTP3DPVM6taXGcB
	P2gWiQ4Z5edXzZqes7PwzBIpHQFfdnMKXchgui0XtehYMJ7IPNEqaJqMfmvfVXZg4um5NPA
	n9YhzDknAFiVPFVToSHXGvpRZqgKo+YHLl9btgQmxNV2DXHXwH2OTZMPzPCWotI6aMx/RTo
	HBS59wDQ6cGn9EnMkCR5EEiZQfMSl6J++ktkB/Y1i9AI76gcUG7r4UEQp91/OpzBbrXT9nH
	lwyXeHew1JphGp3XfHZTHVis4XKYK9UsLZ0EzfmlPdgOiOMRkN7yVEWHtLmh66yU0IsK1jK
	DlcrHicrQsJltA5Flu+urwbwsSzVNAEd/Ge0QVU3N7BG/20XfmvkidEWVya58h4SLaaRzK3
	jdeON8KIJtOkoiJmHP5Z8RoZ3wj9zW8MC7EdP/LvCwH1M4QvqiPqfLpNMzIjMu65RnGf6Wd
	A1Z2t5bkVD8SXFUwC3BlOE/unad4D2dfBUw2LNsOHIs5ZKi5CIiCZ8WaMTItaxvkmF1ZiDd
	P4pvm5vVrMk0y1HFpwDvcqCJVTPTNg9NustjN+P1B80q0mEny8R0RW0rruvKFR5QBso2FIX
	SHf+UrXekR29+zOi3WvtZc/iJCmB6rwPXFkv3MsxrQALxL9h+P2rCwGUoR2hWZUlQLYHrpo
	A==
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
 drivers/iio/accel/stk8312.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 50840c3..02ca605 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -78,8 +78,18 @@ static const struct {
 	{12, 500000}, {6, 250000}, {3, 125000}
 };
 
+static const struct iio_mount_matrix *
+stk8312_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan);
+
+static const struct iio_chan_spec_ext_info stk8312_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, stk8312_get_mount_matrix),
+	{ }
+};
+
 #define STK8312_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
+	.ext_info = stk8312_ext_info,					\
 	.address = reg,							\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
@@ -115,8 +125,18 @@ struct stk8312_data {
 		s8 chans[3];
 		aligned_s64 timestamp;
 	} scan;
+	struct iio_mount_matrix orientation;
 };
 
+static const struct iio_mount_matrix *
+stk8312_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct stk8312_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
 static IIO_CONST_ATTR(in_accel_scale_available, STK8312_SCALE_AVAIL);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("3.125 6.25 12.5 25 50 100 200 400");
@@ -516,6 +536,10 @@ static int stk8312_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
 	data->client = client;
 	i2c_set_clientdata(client, indio_dev);
 	mutex_init(&data->lock);
-- 
2.53.0

