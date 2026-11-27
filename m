Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795749006;
	b=MA8oKxs1IkeRphp5MXlJVnoOsIwHQvL/gVWny/FwwgLbmiGfbiuXGwQJJi+4MPdlnvCo
	 PlKMkGH8LCIWfHhgK3zwRJI2ml2yHCyUgZu5VRw5O9ZG6q466SyZx1vTOeB/RH5rWYLUr
	 fpInovcg8yaW7Eo66EbfAGI/8Iq8G51dK/SZ2gd4UPQKaAZDm9ivwobG3byogLOuVXvNx
	 D3uLNP+yQOsWcDCpJpq1CbL2CNI0LyC6QEGJZ1gOqeMbz5GqKBcWdEllMzncwjSNTiyth
	 hAcX6NfKvJwamK0zNmqnJsGmysPe2s63l+yg8IynLsq4xAT9Zws++NTT2SADVI8cQKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749006;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=9mrS2ti8npgNyajCZJEfab5MIEhm5+cdF9VmQbnuskA=;
	b=IwLkYQQdz91XjYo6ahhe/M1KDBqzhHUcWh3CTxwX+p6wQ7THZjSkpJa6H1wL6EUapdOy
	 bNfZ9VOQXNTkPhRxdBgubwhZijZi9dTKwISYdxQqf2nesKRuI522ch5JkrWTC21/6ahD6
	 DHdPH+zdoDBZ2u0dJwnCcI3oQsn8Gb1aKAAFoeas/LGjc+tRP9hGmUOl3jVJC0VKFtCq6
	 k1yJuXJ+Q8B0ZTvAJc4UvVy7VnRLmMHW0eRE4ldtGRxGADFaFUip1ehAUkYGAFuOcC02+
	 7zB3liI+6MXFRW8ce9Fl88j3q+D4CC04eczK8aQVnPkt9V8zanbkqi5/cnMaVOO7xig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hexin.host;
	spf=pass smtp.mailfrom=hexin.host;
	arc=none smtp.remote-ip=54.254.200.92
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD4606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 03:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5BD4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hexin.host
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexin.host
X-QQ-mid: zesmtpip4t1795748929t4e5a9dc4
X-QQ-Originating-IP: QpS2wDsF/Xfw2at+ZUjWWwODuh3wM90zofa+MKpqLMc=
Received: from hx-KLVG-XX ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 11:08:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7309087312923373659
From: He Xin <hexin@hexin.host>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 18/18] iio: accel: stk8ba50: support mount matrix
Date: Fri, 27 Nov 2026 11:08:10 +0800
Message-ID: <29709CB0F177D550+20261127030810.3150676-19-hexin@hexin.host>
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
X-QQ-XMAILINFO: OQMFDz+zIsdeOPv2pDm+gZB/MY9mqbYgVyMdFslwQOzjTWkOv7vy55ji
	jp7apm0nzdccZDNt8Ek/PrSoSqz1t8APCIuRY8QPy57lvyf740xpL7ZZ+xmRPiuqgBEhF/c
	2JepzhsOp4T/pskMc+5dp8nyF28HnzE+YWk8RvLJb2HSw/QK3XXEZhydoq248DjIUqKmPX/
	qWpLzzYZ/D94JjQINH8sMrjNNtFEnqybbNKA++7BF/gXfozQmhOWIJCQQzB31sDKr+bMlOt
	L/JyfvRvokJf+14MoYsFZ38UHzVSQ+khNRp9nsJGEpMelEGsn2LTVmMebcCSYNJxn/c8wKt
	7KIUjMnMoim5V87Ki0VYtfPaAM/wvIf4+R5beoCMf79RZffXUBEd1LNainaNt5Ag8vS03MT
	lWqkYAq9bIxTZefBZ+Pr0lcM2O2l6ib/ILt9OkVgVarJAjWm319Q10SuN96UaecLJF1cUE8
	AwAsmEpSGe8EBkQ3CjdH55uDvE1NdSta/c9IWZdPxeZ+niKPzLsHT3EnD4iLVfhaDjVGtVC
	OZhcFyazl1Fpgdxl0QrSmHxUigitfk9wkXIs7MoUIRJu1qQGcjcc+IN8V1sTTozNt9QNidP
	obivLd11aOiTgBTybXFyroY6ncipGEQwMmH1ZFNusoyjZO7x0KHjxFGhjrlcQfQZKRSL+0I
	SgB3gn3BptlIuTEqjYWQ7YLm8ryGFMeO5LpAf6gbIjorI8Cfgbjk2PlaQTkc8xNG5b7hJbj
	HLFb+BErqI2ty8+my48Y61t9jte9E61rr14IImmqoikj5LYdq8I3+3JAF6NlKuCWA4SlSOs
	LcOJnSdHkxmm3lYd7Eiu5eRmn/7iWxuDXNyxv8CA23PxVygd5arbuVr7+mL8JBY+3HVcSH4
	p8HyHyJROBa6P1XFX3FHkEgSoS9WFXo7qaXZKjMl9BFKmRvmHENfDMESiCOYPyWA7sJDQi6
	eGzz+/S8k68UkFTYzzk15kyRX0go8tCQvsdQUl0wkcpvdSSDLTmXVIOFivZBcCbP/n26QIe
	e6nK7ZS0Hyz1JyKLGvSGaSeed+Jb+gP6k3aG9wsaEHw7flJCa1g+FXkuJe4cYKQ2tJfqYPK
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

The driver ignores the mount matrix described by the firmware (ACPI
_DSD "mount-matrix" or the devicetree property), so the orientation
reported to userspace is wrong whenever the sensor is not mounted
axis-aligned with the display.

Read the mount matrix at probe time and expose it through
IIO_MOUNT_MATRIX(), as several other accelerometer drivers already do.

Tested on a Phytium D3000M tablet (ACPI HID STK8BA50) where the
sensor is mounted rotated 180 degrees about the X axis: without the
patch in_accel_mount_matrix is absent, so iio-sensor-proxy has to
fall back to a udev/hwdb override; with it the matrix from _DSD is
reported and the orientation comes out correct.

Signed-off-by: He Xin <hexin@hexin.host>
---
 drivers/iio/accel/stk8ba50.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 6c1e286..c0fc5c5 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -102,10 +102,26 @@ struct stk8ba50_data {
 		s16 chans[3];
 		aligned_s64 timetamp;
 	} scan;
+	struct iio_mount_matrix orientation;
+};
+
+static const struct iio_mount_matrix *
+stk8ba50_get_mount_matrix(const struct iio_dev *indio_dev,
+			  const struct iio_chan_spec *chan)
+{
+	struct stk8ba50_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info stk8ba50_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, stk8ba50_get_mount_matrix),
+	{ }
 };
 
 #define STK8BA50_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
+	.ext_info = stk8ba50_ext_info,					\
 	.address = reg,							\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
@@ -395,6 +411,10 @@ static int stk8ba50_probe(struct i2c_client *client)
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

