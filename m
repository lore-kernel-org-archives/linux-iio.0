Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792963143;
	b=Zi21K6yEyYvA+vgUxcMoUK81VELBvPLxmeHqQHqavG9pVJRK1/2ShtEef0omvYe3Rq1U
	 mCYMXOpCWz5Uj5bz/z38QiUD7t3BJgwKlx09kFofxMw/mjkHvzq7/QIc89bQt0PMpWdZ7
	 Mpf6rytC3O+CmzakyenSdJkIZ6umzg6S94WlB24mMoPBo/a5xaIasWQAWswvZ0aBJvuVc
	 09pNpvYnvzaLZn1rYHoeI4CShP3vJW9RCvxbBClFNp8Gtnhb3qbAFnQnLu45o4AzcMyhK
	 0tkAIHxb9kVqHxcnGGWhlJLJRPGMsBSoRbl97nLudpfCpI58buJnbHeZqdxT9E1UrUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FXGhUdMYFe84Q2exJIrjjzOzKvQUZFwJp2fh0+1LvJE=;
	b=UWU8ouX4HjBcDJdn+W8Zra6af4V5YZ+cW7TGjvwvMjnQKYvkqqtXApunRhvW/ifEWWW3
	 gfh1tEwujhMtZikcdFw0Xv5BIHGV3LaGGW3UGOhlV7jRv214QLa8o9vPEjSYgHzMdZ4b9
	 v5oVcpyFjRDQPPMmg1oR6SBen59zyVJ2XNL+4BIji0G+9jzZFeOOi/nm+KMNBjPpwBGKw
	 Xwgz/IgasPBSimIGjML9L32e7A4Mxzz9GTHuRsGr4SKHTdPZxJY1wr/geen5YClGzopqR
	 YcPfVf1v+tMGz8i3WMSNN+Hz2kgTus5lpuxud51h8vYKDX2o/V8sFjgQEuj6d5FM7VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qWvS9mht;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA658606A31E
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 21:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA658606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qWvS9mht
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so13652525e9.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792963141; x=1793567941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXGhUdMYFe84Q2exJIrjjzOzKvQUZFwJp2fh0+1LvJE=;
        b=qWvS9mhtmyvByJDIHURYFkr/5eqn7i7qDZO2PVNtr0S9vOYi2ETj1lu6AY5XwBDA+5
         o0qgEhlJtFSMQGxXaH/Pe4i40Y02+d+26euInPYWFKl2BMV1zwyjD6tN6q/Z8wy4AEZD
         aw1JLpK94Yu6U4N24cH4l+o8kAAtZAZjAeAAXWzbjxNyy2J2Z5mp9UHyyVT6e/Nk1EmQ
         pzRTvRmtjguPq8FCdDvMPX5ljOcyq78kjH8QysSH5v/yhNjm4qD8KhbnV45/jmwD3X6q
         zUNJNJdFA3BYNaRPdm2zUWgq0ECjb5TxMZ4bQK8MN9rRCBVjf4pYXkCBHP8WhTtq8lLJ
         D49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792963141; x=1793567941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXGhUdMYFe84Q2exJIrjjzOzKvQUZFwJp2fh0+1LvJE=;
        b=fGb3fCTTExc3HUqeMrKMOUhYfLzdZ+uzjjRQuYQ7ascyyTU3tD8QaYs3gMuip6mi6+
         GpoODES/T3WG8kKO67krwlC6wwMpWf1N9+2Q16DeYP/GyZMZwzlKi/BKhVFs8EjgoRG4
         ubmxj/4KzQ0kZs9ZDhFAsSzJIys/Sl0ZL6Ex/LS1bvAqk6E5DV8I0MzoVSjtgRFskOxJ
         ehC+Hz+Lrxb1h+g2Bla9N1zm5fhw/zrW6tZJSo9J3JexK5VMojKciZd4HgEM5PKR/vC1
         7Qbrkqam+mDiM37OZIr5HQ+C+4Azjm2GNETh2PopKvCFN6Q6kF/4fAT0xnWJs0PSX+wr
         ulFA==
X-Forwarded-Encrypted: i=1; AKwUvBwlFkV06SOv1+Wm3C+M+6YnOgDxY07oSYcOOqJ5m0n75QGM6n10BAkNLwL9cXtknW83GrhYHZBhZfQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPW6jSgKcl1wEbBAylgek4sueTv8HfEr4k9pCGqMJGAyjJanoB
	qH36oXuvlcRF3+5a9p6HCMV0dxLtbVTHWM1HBY9xJH9r0Ic+o0KBWWEc
X-Gm-Gg: AYBFou3R1eDGy9RbFN25EtmCA4T7Gg1WBpWzgRILfv0xhOWEvIMsN1ROQSZ8LkmnSUC
	bWpcHrBBa7ti2ALI0EajSw7AwgB9qMvL7tgVLfMCJsgKPx8Wm9V5pyP3XSdrKZk64uvW+3KSU5w
	kmLJl/g4ACzoQpRGOMFzDLUbnoo/Pt1yNDplBmig9vMybRVy4FZvIsJOYmDYFfUJXPhTL3j5xmA
	9H64Ll7vxsjEAEq3OMGjgnHK5yRrK3LXLPj92WfZ3yG/b7QmmJt+SxaXrgbZVRi4LaS6QviWPvU
	YxwgD0DlL0b9eYaZZpMEVyqtYOcLi4gty43ya2Mzdjxuv8DZhixuBfB4wZP/WAN7uu4sUUtRXr5
	CwKSypMkX8hj8wxpWGnm3n56llBVomtxth0ykE4i7meg25vwkta2bBhunCniS5IkRmjIy5q39rc
	XHmcINszS3NWuZp+uAWdPR8n+bvieWUE3Zeib+TfYJJjXclXHhndLKL5T7JioXUgNJYdQeN4g3/
	pknjfiHLkL1q4ap3LpQ3XW30QUhr6lR/5OTqseSTzr7ooeYsHku2j0GFKtpk9y3Sl1L0zKIYn3W
	XFW+LFaVTGs4aurb9+oP6swk1HK9nm5CwgLBQTfx
X-Received: by 2002:a05:600c:34c8:b0:4a1:d675:b031 with SMTP id 5b1f17b1804b1-4a35ac99ba8mr99928915e9.6.1792963140806;
        Sun, 25 Oct 2026 14:19:00 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm13228574f8f.18.2026.10.25.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:19:00 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: dac: mcp47feb02: reject out-of-range raw values
Date: Sun, 25 Oct 2026 21:18:56 +0000
Message-ID: <20261025211856.256491-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

mcp47feb02_write_raw() writes the user supplied raw value to the DAC
register without checking it against the chip resolution. The parts
are 8, 10 or 12 bit, and the bits above the resolution are not
implemented, so writing 300 to out_voltage0_raw on an 8-bit part sets
the output to code 44 instead of failing, and -1 is written as 0xffff.

The out-of-range value is also cached in dac_data, so it is written
back on resume and stored to EEPROM by store_eeprom.

Return -EINVAL for values outside [0, 2^resolution - 1].

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Found by LLM-assisted code inspection, reviewed and verified by hand.
Build tested with W=1 (=m and =y) only; no hardware was available for
runtime testing.

v2:
- Use GENMASK() for the upper bound so it is safe up to 32 bits (Andy)
- Drop the Assisted-by tag, removed from the docs in 1e035297ffda (Joshua)
- Move the testing note below the --- (Joshua)

v1: https://lore.kernel.org/all/20261024214423.865635-1-devnexen@gmail.com/
---
 drivers/iio/dac/mcp47feb02-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/mcp47feb02-core.c b/drivers/iio/dac/mcp47feb02-core.c
index 88bffbab0854..b5a2ac4a2e67 100644
--- a/drivers/iio/dac/mcp47feb02-core.c
+++ b/drivers/iio/dac/mcp47feb02-core.c
@@ -696,6 +696,9 @@ static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val > GENMASK(data->chip_features->resolution - 1, 0))
+			return -EINVAL;
+
 		ret = regmap_write(data->regmap, REG_ADDR(ch->address), val);
 		if (ret)
 			return ret;
-- 
2.55.0

