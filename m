Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8144A708
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031951; cv=none; b=cnYsaF6I5kHEdH9Awmt+Zo6kNh+HkJgAceFdBK4SAfinXwHR6/MWmb7kn+oamU07q59w3Y1tfJlFism9PrdQy5oO0vizAHS3YKLfuU2/NqTfr63gtuUuBCCjPl7zHaijKf9/0JBUc5BJ233S4JFfjjL6qx8VjA57CXl2F4h2WsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031951; c=relaxed/simple;
	bh=2XIf2zfYO3IoU3eABkYodwdH1x5Y0NfwkpbkBroNnIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2GfOBiLeoufzq7+8wSu3DYNM4e61bFR3Xlfm2RVc4Z+CQWxoXpWUmLum6OeLG6oBBAw4m0somVPq0bMjVLz+yTuj4h79ip6GCkZ7FNI4Qw9dubbcKqZ6whYI9gg+t74F7wH0V089T49UEIGb967KqrcE9M1J2rdHRubGrPi29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BozY2Nax; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BozY2Nax"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2c90e383so696761b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784031935; x=1784636735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItGCzJLW6JEeGXBfKzcF2ZY989b2KQOyoFBWKsuqIT0=;
        b=BozY2Nax9hcstPXSQ4k18MwJGVwa+Z8TIzW9LEHzBEJ/ETC7Kdrq2wU859TA9zGODK
         XJqKgknkvNhVLY3MZnIDMRpNmyBdBsienSNp0MFc3m/XcsR5Xg5H5xv71dVXj/Z6i87o
         OI2Ip085U76SW5BQTvnP4aEcPrgye+x+We5Ze0QimaS26cdmeVMpzNInzkfW/PvBYtRP
         kFy88RdvmF+9E6lOnHHz/rDrZU+6WhTlnUVJVeoPXmJXNUzu94pxK8BQwb5fffoNS6t6
         /XhwHUF6w/KTEJFGpBIpzwD9SfGsZ0u8FR8AJcaej7kQt/cuGai2xAnACule00Icvo1t
         X4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031935; x=1784636735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ItGCzJLW6JEeGXBfKzcF2ZY989b2KQOyoFBWKsuqIT0=;
        b=qLSZldjn29EJRemyMsn3E7pOGyMN6L58tblEJJFDg1AmVG9JGuPT+Giq2tRaUZGjLn
         +nZzNgB8wEEZ2rkCjTQysg+gvEnZHwn5JZNjd2JWR+EfFeEu0jQ5hqot+Y1MCo2nyxLO
         20dhSyI8a7KdgXdTJITDvC0PwfC84tj/hD5ta8IgjeHzHD3gFvzeIkrIaTZK7DSqcPNi
         9oHyJCytERuhDU9oT9we0J7KuSLQraZqp2mUb18KuN5qtGgHps2y3kiru8eqRQIPxQL+
         sdkeyxGMn3SQYZHwvaS+q1x8TltD1ZfFaNaGcW1+bs6rYjdrhceqvA0Mjm/f8h73MDky
         sQQg==
X-Forwarded-Encrypted: i=1; AHgh+RqVSngNyI4/A/5XN8G9MBXvGfCgUfCQWTUDJK9///ivyWA8hIQTrSN5YYO8c59IKaD+wa9hL10PDLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvE950dFe66z4o0Ka0xypM1glKkiK1tgK6rV8e79m4t7UBcWGZ
	0ztDI6GC1HF9URvCs0CL8jIhi1FyIN9MDy6pYcTtQLib1soSgWRgridA
X-Gm-Gg: AfdE7clgBcVFd2vFeino/EFBEyq5nRDJVhglHMQqMdOcanrG3rhEkz9WGTrfeqiOi8P
	wy64tp56XCpDbDhY2/VyGvhmuGT8CXxxFj822KU9tkC7rzUWE+X5Su17ut3MCo2RKQ4psPuRRtv
	m3axpG9kutUYFEHUpgKKvOrZtnIjfp4Cet0U1pnzR6xvZTYDQ5+Ds3ojZugT/UUsFfOQ8+mrjtP
	Pxjn9bArGzOrwatw6abLZmvhLqicAjDhSHIxTkrnEX6JZUPJbC66y2p5EAAmC4hHkJ6Mgt8Sb94
	nptUBPeS3Z66/VHKzAPLfN81Bczn7H1LOoKVC46dKc1PtEJ6ceI5SoexcA0CY97SY47HPe9vlLw
	OO/nx94U2EgDiXBkC8/R5UkqqhH64erBrP2NKFCgCQeeYRkCAz+bMYqKY0tyl62wnOf74DBE4wa
	Ky/CjpVbWFd8jnJnCrbNi2wwxeCdu37qoYQnBnKUsvRRV6QOqO/jS8rw==
X-Received: by 2002:a05:6a20:d489:b0:3bd:1cfc:1b9b with SMTP id adf61e73a8af0-3c0f08f8997mr22365682637.10.1784031935272;
        Tue, 14 Jul 2026 05:25:35 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm96163178eec.1.2026.07.14.05.25.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:25:34 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH 2/3] iio: accel: kxsd9: modernize runtime PM in read_raw
Date: Tue, 14 Jul 2026 17:55:22 +0530
Message-ID: <20260714122520.3201-7-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714122520.3201-5-birenpandya@gmail.com>
References: <20260714122520.3201-5-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the legacy pm_runtime_get_sync() call with the modern
pm_runtime_resume_and_get() in kxsd9_read_raw().

If the resume fails, we now correctly abort the read instead of
carrying on and reading garbage data from the sleeping hardware.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/accel/kxsd9.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index b3acb20441d86..680d43135e617 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -164,13 +164,15 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val, int *val2, long mask)
 {
-	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	__be16 raw_val;
 	u16 nval;
+	int ret;
 
-	pm_runtime_get_sync(st->dev);
+	ret = pm_runtime_resume_and_get(st->dev);
+	if (ret < 0)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -199,6 +201,9 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 		*val2 = kxsd9_micro_scales[regval & KXSD9_CTRL_C_FS_MASK];
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
+	default:
+		ret = -EINVAL;
+		break;
 	}
 
 error_ret:
-- 
2.50.1 (Apple Git-155)

