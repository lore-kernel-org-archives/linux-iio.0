Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D83B9D8C
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789808134; cv=none; b=gfbK88WCOxGViswdqen17dVZIqXhZLnVtsCTN945GC6TCPmI8oG3KToTmIE37TkUSvW4hRuNtDqwpbSBjDm0j3t/en6EexAd8OMECWNqh7nFtiqcTuM2QUCRQLY8D7nMv14FE+VFu2l1LV0T23etbYh7L7CwYDVgMHVD2u/zXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789808134; c=relaxed/simple;
	bh=+/9iF8Q/HzoQ9AXsjS629ikGCqE2KrlWmQsyKxS+xbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwm+OK0Pgp53Fva2aLeZ3TWl+XUuWtJU+XruGuSKCcE47k+xUK0A7GN9rOIkuN/qwlJ7fnexXujVysRsXQezhVwtGiXswZXEXF4kGp7yRxaVhp6NbxEB0slHcdYlVq5JlyOs04wxIUQXeLByMhaV/6NPJxKRKTXVIobVJlSqHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH2MoHMe; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH2MoHMe"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so491875f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789808131; x=1790412931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=04kbXYpwvydfIV09e+Yw8RNCO3EBvkyuMvNNxaqIlHg=;
        b=VH2MoHMetwiOlpqCwK2s3xJEavhj4uHlDweasxc/cSzyUrVLM3F6PvEC81vU+NDDJd
         awA2+N0Y0HfM5sXMNWZMoPJA3zfvX/Ex2w+BX9ijehBS1+4rp0Tk+/YIpFcatCOvcSxx
         /YTf1WtWiF1yzA8xtb3d2bHfqIPDCRFSt2WMYVBokwbnEXkhDRM1um1CIPzBZjcHL6Eq
         UtADB22yYXGwEVvhEUIO7Nb2dHuu2xzZuxHbk3rTUEojPvM3xMsTOyLUYVYu7HIgZmd5
         jERBtgrAOv7WjdzwTgiWNq7J2EX9oJLf+AgvA+B+IZJyr9g/MkOZkGSuYYSmaK1GDKNE
         fKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789808131; x=1790412931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04kbXYpwvydfIV09e+Yw8RNCO3EBvkyuMvNNxaqIlHg=;
        b=r4/80KO6Q0ssuH6WgYQ3fCXYiZ7W1u5NfaLk/mAcuPDxrFuuW3M8vjdTnuyVmWVDUZ
         Yzgmychc//Q9rxXnwkyn6/nWgMGNt77X7SwvuoKbH6KPRKlbPA6fBH4qIWk1lDVrmXJx
         Y8dn5pw7u45Hbavy+GUv2UsaNxzQuiWS+p7YekSRxjH9TWIGVIbMkcQBPaBgWhkC8mTh
         jbIx6sHhijzULsfkzf+hh2rjZPLOxZin2omv7wE98ODVwcH/25xPpO7KN6xEsGspV9Gh
         wqPpebIa+FfZDhOwepBf0FDWLuvox0XKy0ocrelLJY/TKlk1htyd4A9ijpqrg0VMpbKT
         gy8A==
X-Forwarded-Encrypted: i=1; AKwUvByI+J5cwDfzVZsWcLL1vM81oSVt0l8RE0Tu4wxpcB3ToY8txp9UXlMn7FpBepooACovrCW7dqLljtU=@vger.kernel.org
X-Gm-Message-State: AFuF++kV2qUFqy/vc/4FvcArKgQWi0XSy7UBfVjLcyqCz+RPeucY7338
	JTEKOPqEzpbalQdfQFuzTmfyYxMHAa/dq4VdwfVSC7WweNC5oTfMKuLP
X-Gm-Gg: AYBFou1G56bJKnGFXPA6x2Uhoqv8PlLHGZJ7OBYFepfSzJH9OjJiZK8wv4OsOiopo93
	Dhy6/OYD5qgonTQ+ildHGkv3ZL3igB1pF0B1Fg8iVysCrCjl2zriNixBVYkmSl63wdE4v9dxToI
	6Qoh5ZXJayUOhD0TWq60fBOB9NglecePPGbj5OOpWosqP1gvIpqe/Jt1m2Cc2zuH7lGtGu/HqnT
	+YiM9dO0tOQaAE9a+me4vePv/rl+gm5QJv91rO7hgSkyoQvZl26Wv8yxUwAHhWWulY/wQOSGoQQ
	0VtZMtA47NVFL5fUstJ3vyjfs9sCj/SareQdtwtJiWQ/NgJpfCdf49frAxOVePvhM4/p+1vboNP
	n11BnLnHOtp+GW2iuSAi4NsA2O/+VLheiUG9eTLY8McQIMTL78/Slw/hoV1csnVB9+XhTNsQkCR
	+FFhd/exW/ACyaPPgzx3sTc/ON4meZbFXVo2wJYRtNtTcakKRtvbRxjCNrkJVkZO1/ekKQo5xIG
	FcXOYyh3Zv4X5mzEwPMtHg=
X-Received: by 2002:a05:6000:2688:b0:487:146f:7c88 with SMTP id ffacd0b85a97d-4871d98cdcfmr7778873f8f.4.1789808131054;
        Sat, 19 Sep 2026 01:55:31 -0700 (PDT)
Received: from fedora ([154.182.123.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724595289sm5574613f8f.29.2026.09.19.01.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:55:30 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH] staging: iio: adc: ad7816: Protect sysfs attributes with mutex
Date: Sat, 19 Sep 2026 11:55:13 +0300
Message-ID: <20260919085513.9173-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs store functions (ad7816_store_mode and ad7816_store_channel)
modify the device state and toggle GPIO pins. If accessed concurrently
by userspace during an ongoing SPI transfer, this could corrupt the
SPI transaction.

Add the existing chip->lock guard to these functions to serialize
access and prevent race conditions.

Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index f76f0215119a..d8f4b1f79e2a 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -143,6 +143,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
+	guard(mutex)(&chip->lock);
 	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
@@ -207,6 +208,7 @@ static ssize_t ad7816_store_channel(struct device *dev,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&chip->lock);
 	chip->channel_id = data;
 
 	return len;
-- 
2.54.0

