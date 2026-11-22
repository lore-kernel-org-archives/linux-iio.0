Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333647;
	b=YEl9qUOZXMc0idrt3p1G2EG46Xo2YLGrNzMF+C+s1py/lUWkNR+j2Io4CslgdO+TEJkV
	 4VvpG513zmzILl6Lomn+f5fDsKD3rbEl7zMOOraX7WPDyuLrCLsqZhXiKKIUvEi5SaoP9
	 9RKPYA0xpSA8wWdkQSVbIg6W1vjpbJtzTZQ/qAYtMYzQYxpDJW6eBt2QR2zWmJ1iSYGFp
	 blvcohcr5blXauK+xWX7UQjwLyrqWHoBA7MWnBPmkHDHyuNUZMbL2PlSSgcB0IZYcO8GD
	 fZpXqJck/hg0QVvpMMkJK+HnnQhOZukD1Ek8gzz2mU9+RN8vQJ76MYVBCmFLkL8ydTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6bsqUrSfHFWcb8bhzryBelIuZYwcZvusqpWZAUEkXww=;
	b=gcAVyGV6gbReeEeKCk64F8aozR5kwRrfkdY80QW3HYSsMrY5EIAK3loKLJ5OBD6/L9VI
	 5KNsKtm03TSdbVk6O3pg8tjAbwalVaVWEn/nz4wtWRjTW9gXQ8WCG+B/EPivQ65zHstFk
	 xx6pXGFOHuOllpfPYx0oNsYiw3uPOZkk68s83NLGELnc6bulFvZciu4oCVmPphLpxkiBn
	 O/Ece4c9vVyuEBc23PzzHQ84FS3bEol4e4+1usaMazg2IyW/zz+AvppApnfGzxlXsO52u
	 ZLnpSZdk7+b11qw+5RbQt+l6fsv3sziEXQ/N49VkXsFud2oNBgLVDqIO4bhzecs5+zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKtOvBup;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E56606A32A
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 07:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81E56606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aKtOvBup
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3869f03af6aso1112566eec.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 23:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795333647; x=1795938447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6bsqUrSfHFWcb8bhzryBelIuZYwcZvusqpWZAUEkXww=;
        b=aKtOvBupDpSGwcSbWc3pXf41naDGMsi8s8wIwLO8kHTSy7b5BeOsflbJmZbzO43vwT
         Wtnv3Gpnaonn4eWS+Rtalg4QXlpxARRu0L13keMdlHSF4W2fYHxGjOpCnkCoCM1p818W
         ldxeamLjnsf3J/bPxPZKX/DCiCQF3jyDqSWh++hccmSEHhbtLl1fzuS5nH7sIoJq+6+j
         cITi4HV7lXKUfhGM6xiuToXXTYfX9MeLd5VPaQumamh+4xtfJfqJssLMEtfYzQGCRJgZ
         i9O/wmAv0irpVL7VU0SQiUTUgjsKYvJh44MTipz+7WuS6bIv+h5Uuv8oFBDjGn4uWMhX
         +1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795333647; x=1795938447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6bsqUrSfHFWcb8bhzryBelIuZYwcZvusqpWZAUEkXww=;
        b=n6kd1EZHG9whq5psuwYuoje06Co5KJ9q/wZ89+twSKRAtyH00O2RBeJRkhYtT6Qdvq
         2dnCB8+V8efPdemE4iTQheJTRAr3NuU581bfiQMihUnCj9bB0uAbkJ2bcX27363JAhhr
         nlpSIJc3Gp0x39TSPZODn7jPh+xvDXJs3lIXE/yO5/cfSvaDS0oW0rdwPcd5XTfmV58V
         3OE6nXnp7/fEoimd9c6e3cDeC7EEE73zloqBuHpZQ6A8bmnEyKhL6jfuoNJ72tpRIWB6
         4403O/xF+n0q9AaKViJNe6RBlWxEpyD5nyM+BoSmHqSYgl02RecZIXi9yy67dNHvZDzj
         FnNg==
X-Forwarded-Encrypted: i=1; AL+hErFB88mYoaIJWiBUI8hj9nNKNFNXtL1ND5MxPXiIt2g0oZI41A4ZB3z82OsycYgtl1iFv4HaYvBuadY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xBOmWtkRlUniXZ5btopdrVZ4V4pTqUqUHUrypysMN8OR5rr0B
	r5xy++13XASK6/I0mQbx/DrAWtt1ZNr9YJCivXdJpwQDUoemWJsChahafJPfVv4ikWFnaQ==
X-Gm-Gg: AZFdTZdIi5cu1flW6sA/Qw+WrNz+AsjkW3bO7gA+kJvEn9p5GPwksL7tDCtnd1w/1i9
	x2olpEhYqXp2YSHpXhT4DBz/d/Dt4CMqhVTNdNs1LqzXWUuTM1ZlQL8Ssmhrng6th+WFu8h+xP+
	KoHR7aKudO38uxaU34OPpAz/qSIRzAA3TSrOFsIQvc15oWdMtyhUhlUoWFZtfgRqWiyEX5oyojG
	rvumoOjiutnsV4xgGuES1FQljh3d9xAFRrue4navy8vGjRaPgO3mU7/OnFUftPwE4z/v8AYTRzQ
	8aHgAHIHVChTDoVZg23e0w+nmdBCaLlKorB6IPD8r9cOYrCGacwjvqISgU+vcmhIg8toN8RMqs2
	thtaY+uwUTdRgSV0CSAJy9Z/o2V/Mvic0vb7LSMYdjpgMDaOV4bE3vY6/WGl1+80gOUEYx2Jb39
	48VV4FlKXo7qPXo07C6WWsf/Olch2mlHJYEYr6tT+X+SIUdtHYCW22TrAJYuitxnACUES9Ac18O
	PPIsEJN7HrdaTQBwnS52rUPb2q0YKFkBoEHct+xP4UPBdhkHTAXplThMJUXQGvRxiBCuTLeSTm+
	7LuUSo2fIHm4+6D4/tZSyxOkFh21o2Brve6XOxgETqDDr2LltTyDz18NK05Kz26OIuFMAwWw+Uc
	VbjbKSrwf6h5bWAfS4pu7vs2pWIYkqvlMw3sNyxXaMOq1vWYdUORkCd5n+fzJxEE0kmgsyYHC86
	A0Gmo7R0P3VkpnHv5CJ3EuLQxDzGoZlfZIINZE3KFe9wE=
X-Received: by 2002:a05:7300:e9c4:20b0:383:6f73:eb34 with SMTP id 5a478bee46e88-3856c6b00fdmr10030181eec.2.1795333646609;
        Sat, 21 Nov 2026 23:47:26 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm24898071eec.9.2026.11.21.23.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:47:26 -0800 (PST)
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
Subject: [PATCH v2 5/6] iio: proximity: sx9360: fix proximity threshold writes
Date: Sun, 22 Nov 2026 13:16:45 +0530
Message-ID: <20261122074649.239441-6-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122074649.239441-1-kapoorarnav43@gmail.com>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com>
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

sx9360_read_thresh() reports a PROX_THRESH register value r as r for
r <= 1 and as r * r / 2 otherwise, and the division rounds down for
odd r. sx9360_write_thresh() inverts that with int_sqrt(2 * val), which
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

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 9ba967a33c98..9a2796f67949 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -508,10 +508,16 @@ static int sx9360_read_event_val(struct iio_dev *indio_dev,
 
 static int sx9360_write_thresh(struct sx_common_data *data, int _val)
 {
-	unsigned int val = _val;
+	unsigned int val;
+
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
-- 
2.53.0

