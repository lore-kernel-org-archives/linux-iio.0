Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B27286409
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421362; cv=none; b=kG95cPXVWh7xe3nD+DAK16zcnm73kuNCKlIR23sw8MZe9Hp18JPpqoquLzGlqshzdG3XAQuhHw2mkGWXUndnK7RSt5eJjS5od6VLYmJMCIE+SdbPRMU+pdRZ5ZSUXKhaYtDisKClVdglUvHQ53HN4t5f7wlHcl6ho7PDfCGSGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421362; c=relaxed/simple;
	bh=HSFVueNEH5xg1DfWVSw6O7NeC929r2+Y5blCLJlbKKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLnlf6c7vEBqsEZeIMjilPl9zZUNUl0Zp7YGbOIzKtpFTbxfJ4CIPAY8KVzeYj70bNdMyW6P1yzsap9mk2C+9kB9XN/l8jwTCxIrGs2PljqyBw0XE1etAZffAde3kkfMQ0Aiv8kAGbJeh5VwiFkWzqS3nXH8jJT1j7djASmNLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNFL62KN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNFL62KN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf20f6be6bso16965505ad.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781421361; x=1782026161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWgMQVrY+dz9rsihfRCMQ6mLj8tg7gjE/NKN6bh8RUs=;
        b=FNFL62KNnTM9YGGFC9J74n9mAJl+Z/ztpgtQaA5h42NFLaUWvtOK8rS724d+TQBmD5
         d/1mFA/WJj/NKh6fs+alXDtkdCnvxccXd5FAJ9+zYk3HL6V+Sub1/SGUwUWg7pE137zR
         YIr1yZh1M4caeAD5ij0Uv6vvObDcrRVKvBQkuLIbG8TXAhZwvo+t50VWxOcwgE8WQ5g9
         OdCTueg25JVK+FEibxgI+ZKf6NL/8FwYhNhlsY5Bh9YGn1zK9nJktPIc0oYcUSAiZ55r
         g2TiV86jL19PUnr9fAOeTljtKF3i7Mcn51vyP5elHA3vyhuh5OOiKYBqk8SihBi5wxTT
         vU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421361; x=1782026161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HWgMQVrY+dz9rsihfRCMQ6mLj8tg7gjE/NKN6bh8RUs=;
        b=bbFQVzMkDHOCpPBs0es4re5uqznf4URoSmsooLmogBioHpmzZFuzuDX4PDhxuVtrfs
         l2AwM88FvrLjNMjx8Hei/i7/YMB4I3uYLLcncenB1/q27eSmcMizOkVPm/q01jylVtFC
         gqCjkROAOMvUg0w+fSmN0boFa/ptj70ERHXEPddlN6CXXfv93PbS1UZgsapCCcDuO2Dh
         iUh8XDprsl6mYRK9XMLh8kSn8nzmbbbfAoESKAskuCvIXwf72WDtSB/ZueoZT1ZvjvDn
         L6wLDCYjmB88ooZLHnUdnysrEyeRghgVX1v3hwuDnpHfBRAMp55hLi010RqMeFR8b+zW
         rnbA==
X-Forwarded-Encrypted: i=1; AFNElJ++DynggO6uJDMVDdFaT+TrfylsmWIbao0fdTEKsruGBX1GWGGnacP6PjLPyLHt4JC1BQBzjnMD2gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTc2eHKL0jpp6K46CAIHi5KunF9hg89mErLwt4BwBFYvjxjDE
	svpi6GIV3qhWRTicFSANdZKXw9apboZAulTPlrswwLv/WIlNp/Tc2XGn
X-Gm-Gg: Acq92OFwzh+hYSNAmdfntk65ONHdf6JdAoUK9jg69rYu77XMSw4yGc+uMDupav5MPWz
	2g5VPRjITRqfuX6tTW0qre97THD4TIsiJqiFNk9uo377EDzjZ06mklQCmGCnGtOpGDPPsyvDt/i
	uv9B8wtnos5BBusTIJKqf+Z7KGqVVBsQ1qbdM/w9q93OLFLuT/sgl81mp+djE7y0PpnNs5LT9i/
	4NeRAhSmjpvy/xugF7LyneXwNkwphfX388LtuY6yaj8EAPAVo250iv9y3uKCTTUsmjcLe6rl+Kf
	Kp5X54HK28oq34vU4TlASlcp77hDxcuSVmnCIJ2ot+Q/EtuP4Tv+FLwYw49+5jANrKFJixhOqDO
	MDeslQoYXa9PCP8rwx+2Z6nzqYX9KGu4UI87n282ZSOrJiIj6teL1nZnaahwpuKXEydsPH1LNVp
	CWBK2u8Z8H79NHWiPwwc4LLL8u5+vc7G5uUjaHzwXSoeJA0S61v5Hc
X-Received: by 2002:a17:903:fa5:b0:2c0:ab82:6b99 with SMTP id d9443c01a7336-2c41216faa0mr110114895ad.33.1781421360944;
        Sun, 14 Jun 2026 00:16:00 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm65595295ad.46.2026.06.14.00.15.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 00:15:59 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v1 1/4] iio: accel: kxsd9: fix runtime PM imbalance on write_raw() error
Date: Sun, 14 Jun 2026 12:45:46 +0530
Message-ID: <20260614071549.81920-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260614071549.81920-1-birenpandya@gmail.com>
References: <20260614071549.81920-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kxsd9_write_raw() takes a runtime PM reference with pm_runtime_get_sync()
but returns -EINVAL directly when a scale with a non-zero integer part is
requested, skipping the matching pm_runtime_put_autosuspend(). This leaks
a runtime PM usage-counter reference on every such write, after which the
device can no longer autosuspend.

Set the error code and fall through to the existing put instead of
returning early.

Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
---
 drivers/iio/accel/kxsd9.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24a..7ac885d94d7f 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -147,8 +147,9 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 	if (mask == IIO_CHAN_INFO_SCALE) {
 		/* Check no integer component */
 		if (val)
-			return -EINVAL;
-		ret = kxsd9_write_scale(indio_dev, val2);
+			ret = -EINVAL;
+		else
+			ret = kxsd9_write_scale(indio_dev, val2);
 	}
 
 	pm_runtime_put_autosuspend(st->dev);
-- 
2.50.1 (Apple Git-155)

