Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866957;
	b=u63TrR+dKaaSh/lgfEAziwYqz5s0SBOAHboSmXxJpafY1VHHHvHaZElGfptlYWBjvKFI
	 9STS3oUndZvaNJMU4998HTP9TwhxO1xAjupAh2SDJf6v8bheb62PJCghsK+HqjdGGcEPS
	 td2cuPVGZSlVu+k1ID+B4KVHudq++MLycm4wsMUMShGWcDEtO1c4jdhh7h39XnDb0xl+r
	 oqlHzYTUlBf3/V5auVjYB0UC58Bjgk/nNkxvcZn2X74im0ZpyXNxrHB+jP+yYl3IsRQ3m
	 9LRVv4oiT7CVhqk7f90BRIC3UHgItDzKCdDO+6pAlZQchEwHAlT+4XiWcrcQGJTes8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AhETqAy2XUV624v2uYTcVSsHVdyYQ/4qrBgHkFl1HuY=;
	b=URdTgeo/XN+Li2HX1oi5EGUugfkaBylU1OP4VhgDmF6TS8P2FgAQKjsH7YhXoBCp81vV
	 abju/eV+21mo7llR4lEDUORG3AKA43yV7Etyezv+gDdcDn4ItKwBzDyWTKRYW/tm9Tg2+
	 zbSbt97EcUosToOUQ/n3yB9SrLjh2zLGAR3J4M6V6rB3QTH73ynGiGLmPPwgdUJjco3LQ
	 4/lF6v9t0HThB9SKCvJ+sGilwttb7dZa36Lizn9td9pe9cc0hIcbn8Q6ZinIEaGASylgG
	 8kOgP6n2m9jqIZ7O55ibyQYxjQ5Mp78CKOCPi6W3bI2V3CkvJRcIHfehygQ28OoxtgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N7fuqdMi;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D44606A321
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15D44606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N7fuqdMi
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-385c497bf94so9969812eec.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866956; x=1796471756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhETqAy2XUV624v2uYTcVSsHVdyYQ/4qrBgHkFl1HuY=;
        b=N7fuqdMikzKrZVwpCswI3HmoWohZFsV2aPrtjtPm0AdT4Uybaq5hdbcvLwlfCBRRcp
         YF2Vh0a2s+E4Bwftn8sE0tKODGgGc/OZUShN0oc2kYwFy4tpiRBNAaijlBvLBNhx3tN9
         Y/AYJczdol4KdkgH4f9GAGqoDUORQQ+7L0IQLKEm7O6KpG1DnRO1q4PhuRRD5/yS3TdE
         uyR8ViWDzt4nSNn2wdTNQwdLs/W1c6AUefizpmtzsijaoOqAHdrLQTDKz+rwWD+a69Kf
         wU8/jc3pbD2j2IYf0NdJ1yH8BN5DD9Ozm8keb+nA06sgv1uEAPTxwVpwyGtY+wnNWeNg
         PMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866956; x=1796471756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AhETqAy2XUV624v2uYTcVSsHVdyYQ/4qrBgHkFl1HuY=;
        b=cuVQq0x/f3YSFd42EnQn48egpW1pZ0wgaBXiEUKedYBuAfelV2CjQ+cfvdjVI5Vw/g
         AAN4k+SGKkqTTXkr3eVm8ljVCp/vjRo26az7YR85Jm6Gd3PstdyGoPhEcizWE/xx1nX6
         QNv2oUEyZ46YHCE0770EKrWw5LsiO0eVpET0Dc6WyNVZjcEAnwRREZP+uMCEf5p8QHYQ
         PfITzoDXvnZYKGwLIvbuQkjfs9G9zkXwhD1C51i7w3H6URuw1p2j57AkAeXfhotME9y2
         qclRp84ALDXphdBdfNMNEd1LP0x9Bzqs31Pu7WLTYudxS/xdAaLZHRLtqEXfzFTiEHge
         219Q==
X-Forwarded-Encrypted: i=1; AL+hErED/izQsgWgy2Oybd0CJtNsMJaMZkR0S8z/k9WxC0Yu1XsCeJkzKmkLMwXtL/LCqK/Hb+Hp6w4Zqks=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rUoeykMe/UIaPbXtm5gxpDUotN+K9oZA+4BQ8l5gAQyzKBGbR
	UBPhEpeRG6evS7SlaEMHWFfjdvQd3zJpDOiENLUOYv8w1XWQRP3V7CGE
X-Gm-Gg: AZFdTZe/SVCrmz+EemF4+zQdUklpqdZCWlEHe+xraDx0j+RNsjHnxphndgTY18iAkGd
	N08CMwUvNWYblp0QWMiNaRovTVujcA0VFVCsyG9CZVxYWP7BuBuWMeyJvZ2B79LsVo4iHyQpe4A
	oQN66T5kENXTyqdNJNwnUKhivNSfmpEPsXTT6bdvHsNbvlZcenREWRYeOW1mcr3HmPkTpGadnrQ
	yyhFKVMbev9s7lOGm23/TZ5AkxU3ycyaYBo4aXXt7FZluDnKqMmcQoKWl7AMI6ZRyRdheQCeKz/
	Er2CQFAD4oAwa+qR3dqBL9wJRqTUsAO5V6vTz61dfQ5kVaX2Z1tRzMLrPqCr5Gx8LkV7PJRflpU
	bRgjEf/LkdBcd4Aei8USlAYmtpZ5lLvpwP34qmlTS/CK0yzVfPA0ueXUuV6ELbjgqz0y5kxm8eJ
	VtvHu3WcVms6x+6pbc5JkU1Mm8LUZ42GZIFD0RmwDSIVgAk4b4GKfvBcYD/HAAj8Kr9Cr6YAVvC
	G62qnxO6zZ7SmvaiPXXsatcXOl8RjByOYcUSRlV07lm1gY2id2odsXDxKtnOlBqPemdy8wBMJ9l
	8PZXb50I7di/oIo6jPQF31qnfiUKWsSLNFt6E+w+f6Ato7nwEVaR9EPf7pRUz10YU4JiQeudGVX
	Ufmc9eke6T/ZphvcHvH7Wnal3tFaM450eHBDJjPyMP6aWRARnBJ+mYg7Rf2PtxiiI0kSEccvaRn
	okn1r+mBSNl68XjvDu0a1jrQetNifyjAE1wtobDnAN1xLN1qIYFYyJiTxc5jRVMak=
X-Received: by 2002:a05:693c:805a:b0:376:a6d7:8f51 with SMTP id 5a478bee46e88-3856e63bbe9mr30775124eec.12.1795866956143;
        Sat, 28 Nov 2026 03:55:56 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm76783178eec.13.2026.11.28.03.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:55:55 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v3 2/6] iio: proximity: sx9324: fix proximity threshold writes
Date: Sat, 28 Nov 2026 17:24:50 +0530
Message-ID: <20261128115534.558478-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128115534.558478-1-kapoorarnav43@gmail.com>
References: <20261128115534.558478-1-kapoorarnav43@gmail.com>
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

sx9324_read_thresh() reports a PROX_THRESH register value r as r for
r <= 1 and as r * r / 2 otherwise, and the division rounds down for
odd r. sx9324_write_thresh() inverts that with int_sqrt(2 * val), which
is one register value too low when 2 * val == r * r - 1, so writing
back the threshold read from an odd register value lowers it by one:
setting the threshold to the value it already has changes it, for 127
of the 256 register values (3, 5, 7, ...).

Use int_sqrt(2 * val + 1), which gives the largest register value whose
threshold does not exceed val: for r > 1, in integer arithmetic,
r * r / 2 <= val is the same as r * r <= 2 * val + 1. The result only
differs from int_sqrt(2 * val) on those edges. Checked for every val
from 0 to 65535.

Also reject negative values. They are converted to unsigned int, and
2 * val wraps at 32 bits on both 32-bit and 64-bit architectures, so
e.g. INT_MIN is written as 0 and values just above INT_MIN as small
thresholds instead of being rejected.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 762c327063f9..3f2f15d237e9 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -622,16 +622,22 @@ static int sx9324_read_event_val(struct iio_dev *indio_dev,
 static int sx9324_write_thresh(struct sx_common_data *data,
 			       const struct iio_chan_spec *chan, int _val)
 {
-	unsigned int reg, val = _val;
+	unsigned int reg, val;
 
-	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
+	if (_val < 0)
+		return -EINVAL;
+
+	val = _val;
 
-	if (val >= 1)
-		val = int_sqrt(2 * val);
+	/* Inverse of read_thresh(), so that writing back a read value is a no-op */
+	if (val > 1)
+		val = int_sqrt(2 * val + 1);
 
 	if (val > 0xff)
 		return -EINVAL;
 
+	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
+
 	guard(mutex)(&data->mutex);
 
 	return regmap_write(data->regmap, reg, val);
-- 
2.53.0

