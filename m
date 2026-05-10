Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66261A9FA4
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778418588; cv=none; b=FV74mOMaIQKPu5pjtOLEXlGJwEyugHfwFB4IpgYwZh2cnuWdf9jhEBMQ8WZbPYYxtu+hrE3C/kGcqrin/INpk140CkIznonKTu7VfsIUHvz3DDiMsF/oydVYXpy7ezCI1chjdtmwqeBzWYzAFkn9E5NhUFmspao0AZJ5gWMv+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778418588; c=relaxed/simple;
	bh=1hJ9JT73kJahzxCnMNQcAcKrMmhmlPCCc2bYmpv7+S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YiXMKDYmU9BYpTmqd2B7QpimUFafWsBaoCdri6Y5oaQM+cTYhfSVOzRoZzi1MnlgANE2yV9/VHEI3q59A+p+/N+t1fgblZyAbY2dQ4yr5iUgZ88MugafY5Z5Xg5CpyFjpziqywGrd263z6bY0WR9op12p+eyOT2hi72tIT+GvM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flSCXqce; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flSCXqce"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so4154975e9.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778418585; x=1779023385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBZYXPQio0MgpyOlRTNX3Y4T5hNULZU3s5a0B9w1m0E=;
        b=flSCXqce/Oz4cPNzGItpu5DDsPNGqeacjc1ehEtQ5G44DcBHA4qrWaI7QYZSrGxJ25
         7fmryRiiBn3b5D7K8v1I+ejJ16L0gNpyM5+Qwqa/64MP4dENFaHL1sVWXO1azcJZRBUT
         JuGWPHfW8atXrPwm7NO/VI/5jqpfHlGScWJ6YpKeRClrpXAXp3/vU/jJkCJUw/qdoUXc
         LifDkv88HdjHP+gVo/QB+DP2Zei8YlzSJ+0IQDchrxTcgWqS2TrZQ0xss8gkVrMdY8Ww
         hB+5GOL1iy7N0jYZe3GzDeYY8o/AyKI3HIpHk9AwJFFfP/0E0tOrn4mbcmGaMMQ1XZFw
         LBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778418585; x=1779023385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rBZYXPQio0MgpyOlRTNX3Y4T5hNULZU3s5a0B9w1m0E=;
        b=IF4nh9fJGANRiCJMCqa9cEe/Ci4AkIDMzyGa5TUpFzm2UqrusGsGpi+1wbUHr6tUNz
         xGQKRiR6jlzcXj2cYjL0Gmni273W6AbXCnBBe5xlIxNcxLGW+v46hPiE/yMs/3CqSEy6
         JqHgU4NGaEWsNXsZJBTsW3/7Aysmw88I16Ylj37cvJfyKqUC8qGemZFpgqk1NT6M3U6D
         osjGLpYU9KMDw+XwB7+eX+C9XwkABczAwfte9GzUjc5tZOCwR/86coEGXhTqQEwTD1xZ
         soJ37jf+59clT3moUaZ7ZCV3WIj3x8IWXpgIRypkcKLLGFMdszDqEhTxAqjQbJI4jsJq
         aIvA==
X-Forwarded-Encrypted: i=1; AFNElJ97K3nNz946uC4fBKciE/yviMP9eCBGqUFpVPgGXrZtb6yNjIyzJ7nfrinTA9WPN8KdWqCzxUsGyiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOg1A7QbaS7geCayLTODrFkR84OfYLjabmn8I6rbU0c3HC/p6
	ygF8fQgoxbwi2/NiMqyl+DzHdWM91i3uIftoTTOYmRIlPgvav5kyjNt4
X-Gm-Gg: Acq92OEjhG9rKNCp7HgansTj4wLCNbKWDsKyElpmUpJpbQzR7HI9G7YyNP5rVxh4agD
	qjO0C3k/kTcEMQ/c8M4K/VU9/iHET2mxCqGhmx1As1jV7RseoJ0kyzGrGrUmU62PRKRZwNEhbGa
	dI1X24uBzicO660ME34KS55I8i+4KNaVy8lLQlj623a9mq5gyEMMzkkaeEEi6t7lH/oaFrD8NYu
	KaPaZUip4V2yfU7D/JQkJMSgS9BLAOr/iULhhTtABz87dLRmclGKHSQ4d/RPBKooJj2mjaN7hvC
	6e0S5hg3rPLpBII3DqRIHI0AWw1M/Js4a/BBPN46N3dYw+quc8v2zpBY6FyxdBkHlsGtqSODEDD
	Li2ejbnzlg2GqPLPopouMjBmtNaQ402TUz7isNgfLA/QvhcaU98D/rvi4NnJJKxXgglRCB3msOT
	FKzm0lDSSnnbd0Y5FdMAOMTocAenL1+A+PTvkhBNQqLgkCnH5z3yFAiHg=
X-Received: by 2002:a05:600c:4ecb:b0:485:3bc7:a224 with SMTP id 5b1f17b1804b1-48e530fc6c6mr140481325e9.6.1778418585123;
        Sun, 10 May 2026 06:09:45 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8de046sm59045775e9.2.2026.05.10.06.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 06:09:44 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	alisa.roman@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: adc: ad7192: replace usleep_range() with fsleep()
Date: Sun, 10 May 2026 10:54:17 +0500
Message-Id: <20260510055417.37519-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260510052401.31057-1-sozdayvek@gmail.com>
References: <20260510052401.31057-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "at least 500us" wait after serial interface reset has no
specific upper bound. fsleep(500) expands to the same
usleep_range(500, 1000) internally.

Drop the trailing "/* Wait for at least 500us */" comment which
just restated the previous arguments.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8b1664f6b..6bd9cdaa6 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -576,7 +576,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
-	usleep_range(500, 1000); /* Wait for at least 500us */
+	fsleep(500);
 
 	/* write/read test for device presence */
 	ret = ad_sd_read_reg(&st->sd, AD7192_REG_ID, 1, &id);
-- 
2.43.0

