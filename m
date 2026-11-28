Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866974;
	b=PiObGJUb4lcYc8vlAQA3DkSL0YxzD49GXKkJjEBhrgu9I6AD0dpz+xY1/6iRpf1NQxNJ
	 sIHdpMaK5pAM973gWsjvjgvg9g3ebFPS0MEiipdRXq+HVTcs5jcE343oM1XkvrgoTPFM/
	 p51GPVqMidUXUJgKIjsJeNi2RMLKJ8dSEQdiOiHOoJB/b1mG96Bs607MD6gP4XdwSxU2j
	 NWFZcDI38sXQLsEaUYa8iLMFIwKqM9f39lGQYyMh1R+MXoWPZqJdb5Rw0142fVlgduOU/
	 F3GLq25acQHA4v4u2Pn1Pfszl7Wl3wD/MxQv3Z085HTZzdtQ0kT0iEhFBHalkIg6NNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wvDxQQy3o3ngnRt99tg8UKSHAaNZZywES+nrdGvSkRA=;
	b=mzz01aQljjjoSHxWei6YPmaUlD2u0qbKHTIFKx6sWdWDMbLVCZ7aFr+9WpxMAGs9ojku
	 PWTYnyM1sBMwiKmUStlbtFvdQiEYuLMtV9PchFUnowuMpUJmSPdOdN038MPAT9fpJ1E8s
	 sUIhslur9RfBrOKw3SqJ/aRiJB1e4+EoCuk+wGL3Rf/30hF5f/M8jjS+1HaP+ifZOq9UA
	 F+SYkgNYFcoZzbAK9GDQ9h4UbDUXWVB8g4w5sFb3sKo6I/gnkD34jCkKzynys9BUw8L/k
	 lP40lIi7vBfMoq89bWPIEJeSXAHOuqQ1XwfbPtWTywKmC3C2Q89VDzB+34yQ4xpwmTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0QJl4e2Y;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B930606A324
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B930606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0QJl4e2Y
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-386ab9ab619so12657679eec.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866973; x=1796471773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvDxQQy3o3ngnRt99tg8UKSHAaNZZywES+nrdGvSkRA=;
        b=0QJl4e2YIa94JgtdF0JYVURhoQ2iBuI9Y4fndUg0rRtJiNOT9PQN77RciZ0y7fF5VZ
         2QnLch9jWsw++LhrVBjFWtFHG0hZevj2VHoAmgZNJ1CcrcVg6BTuPeCx/tlzT2HejDyO
         CvjyoMVr/VwBlZ6JxPqYRXsTl220VY7tPj+7xQrCUJU/cIX7wsvRRE3p1QPclQylj076
         wSJsDh8dj1p6k4YgPdV0o1jiqYJGLVqacOp4PtZzNiRBu8HxvcdOMUIjOON6C5Wclnzg
         EvkAE1DjozusCyiH32nIqxplvoynO5WlHBIWfhmU8IxwV49O+5i9W8o8SNVynxnYgb/y
         MVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866973; x=1796471773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wvDxQQy3o3ngnRt99tg8UKSHAaNZZywES+nrdGvSkRA=;
        b=qFT8ygPfsx+1f/aIap7jeYT5hrlLSyVso+FTkCmopprCOOUGhHlamLB7qZYQQwj3KW
         VZuCClfF1AXEVSxXAtDTe6YqAKmq/jiKutIQG2J6rpYzdyqC6sbzeta07ofAM+8qhkva
         F56lsdvkuS2/ZIuuv7eOnLRJyguL738bWKy3oCkLP7s2ggABpwOJkXLZi99OMD8OAnKj
         jXk3TcZh7r3JR/S7bavM7iQdmj0CICnD5erbgNnBPAcDr8bR62mR/uFN78jo/0rkzbK7
         xwmocixsJMv+bcQifykJiihSum9Lh7mEEK2mjsTpWqM82IsBcUTlkWo7Ivly5RNQOYV9
         wgcA==
X-Forwarded-Encrypted: i=1; AL+hErGQlMgeSxZwG/KUsrAz1O++L4AdaZ0iRPHGfZBoLLe7EM3FSdyy9D0BgC270oB7YU3cSRz3a5YLEzs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eS960Tl3ZMbzJuKkyj2mNKKef3KUd6mVqq2clQZzH0q4+EhZQ
	dTPMxplY6JzILuCW9ZzAw0V1rPY3prxvecQwBKqHjvDC3BFXV4+t5SLR
X-Gm-Gg: AZFdTZe6px3BXak/cz0h7qtFZEzDhFk3nmOgl/qVCobW1NohKo4cai7UtprcrRKKe9V
	2EmyVaeXGlbCys/BA+qo5a4Qsq/ggAGmZvhtiQNgy7aQuvJhYDNnpm4aehDei1Ejmvql2eNizPM
	94wjqFx16RE9FoajEwG1WuEL5Pc2YFmVk9NjxcZ6TfXsBkSR0jpL4/MvRxGxQtbTyv9s0wToncj
	rK62bQ1rqVNqSIpFZBVnnKPaHqhF534W4wb98VpwRCXJ7toCgJTGtgoVO6795hzzSm4UcKRRSel
	oZMit5UXTMFfuS7oXrnN7hUAe+Vm0kg51nINidKr4k3SozHsZnyBjSZSYnYKAqGS/4jFPX2fDjV
	WCrQeYrcUEQ/9bsK70eN9AnrUn0c7183WmS0iJ6nARLClYiw/p0uTvtWbwEewaQApSEK0oleMms
	TmdJDWS3TV1LwspFlPYfv2HSSgzb/143VCVCqGgJisU/qfrAmRgjtdFn9t2z8wn3YzJw8aYTLJ/
	R6s+fmYF8kecLu5j57K4aJ8cQw1Gqn8ZO9XkuVh8bgkZv5dPZ9CtczB+pl4MguXRGo52E1NvJY0
	/ZbLD4q+5KVv9ntW+Oievq7wxB8E0sJ8+PWHUOYo8LtalN+pRDz1ymJcklRrPSNNEDYJW8SAQtB
	1jhTk/2C8LHC09IJ0LgDMmHTlm1Js6ifzoRHPV7LtORgb+I2/EKHwI24voy8mxHIcVmPRKZd4Y9
	cT2IbDJUC635+s2/e4e80+A4fIYQT39KzcxBDlByNjeA==
X-Received: by 2002:a05:7301:4301:b0:386:548e:e533 with SMTP id 5a478bee46e88-386548ee6c3mr25769199eec.18.1795866972719;
        Sat, 28 Nov 2026 03:56:12 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm76783178eec.13.2026.11.28.03.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:56:12 -0800 (PST)
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
Subject: [PATCH v3 5/6] iio: proximity: sx9360: fix proximity threshold writes
Date: Sat, 28 Nov 2026 17:24:53 +0530
Message-ID: <20261128115534.558478-6-kapoorarnav43@gmail.com>
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
index f89b18778f91..2d1525547ce9 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -525,10 +525,16 @@ static int sx9360_read_event_val(struct iio_dev *indio_dev,
 
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

