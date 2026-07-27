Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147F3C0635
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178164; cv=none; b=tYax6/zd2Q0v4IKXwXsX1I5UFbHjvG7Tz6mtGv1hUw/NKhc7i5+SAfltrJSXa8GtNJpW9RebefSjcAvcS3HtYRc0cRFi8LJwojGRdxHnSZLZsURBUvPyt8o1G6gXdWH4X3AjnVjixRWj4TAaYQmRy/Pc4oD/MAV1rjYjvtNJFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178164; c=relaxed/simple;
	bh=aY+sYp6iAChM5C87AGmVQMFM6nI852Lmi+YugxFogXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCG0ACe3+33hQX0YaiVTJFYrcsQBzGaPl67yrEmL3NvL2wyqj8KScKxrZzgKlBq1EHlGuYbp1pEY7/qxOBy/nIfaOBcQUYSqCYt+ojyD/Qzpfkh8yUbIdctOY4SyuaZu9Z4JHAO+bfx9ilE1f920fIvDrRUFqQyEnLQUexLQa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh9B6Hyt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh9B6Hyt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce98cb8165so3043475ad.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178160; x=1785782960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOOQ0RbG+6Okt3l/2iuoRB6TOovgsF0/E+IS2qm6bW8=;
        b=dh9B6HytpP40vn5YZj+dqYY3QIwkUCZC29AffgnRUjoGkIWHTiwIkzghLnbhMh3xOE
         fHK4iXUuCAf23PoelqfxVZUgVSB0HUMlSTFEWvrnYwIj3E3PqtsH3cfQufA2WpBPIcrX
         JjvLdFPK79LvmSHVW8F+H1HjYotTnszokCJNgYbm+iwsPp8266JWOXUj0heWSqbpmLdp
         DrZuNOLezohAhDes8IQ71gBYy3r084FC+WEGEGN8WVvEcUdyT6uTBYHCUuwycc259CJx
         EdC5OuS5nUNxuCRFX2eWmt2HUdOWF8WyeXeR1pO8T5eroIb0SkvR0k2e5YLzJQ8z8sQM
         U10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178160; x=1785782960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FOOQ0RbG+6Okt3l/2iuoRB6TOovgsF0/E+IS2qm6bW8=;
        b=kwDnlGkRixnL06efPAXTAUHUGbiHwtTpdvRPbnuVPnpgU535Y5WfkGsSPZrB/Syi3o
         /YDnlW10QzWSM/3mxsVBx9Npdv8XUWBqV/oYeARLvs4oQHg/r98yrspa6AkuegnNXZFA
         02kKCnYH3RLSDDC0j/raC/5Cf4Bhz4RT8qA23j9R6V9IYhjCKU8bgqZA39xqQcmCODy7
         yo7ikJsMkuY4dmWttZiYS1mhMJUXg/0UiPmBGmoysGfvOU4RU2t1r7AwlKt0pjkyJ6yX
         Hf/ZLPuyX9ViuBdcFZD/e4NvS4uxCMYlBFi/x2JxT/NL0zpq3N8hnRZz5uGBXzVBme2B
         cjOA==
X-Forwarded-Encrypted: i=1; AHgh+RqI+gX7mGsVHNLdsqFrt5SLb46ZY8rMQzmnao2wlh4eqRpjFF0OlVI5//MFRSQiYkyTtr/6Mut6Ys8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CQ/SFdZh4eu6rbqPdwAhlARZoGtfQzrRzLEPiR/Z3irPQuur
	a4CMsdVyb+89ZyU4gkLMoapBGAfcEV6VxXKumuIvF+rvbTj0e3Q6mtaE
X-Gm-Gg: AR+sD10ri4kMncSPBMXaP5Owqbd/5yu+ui/Ra6sho57CT4LrltKVyEUQxwl98qzIycZ
	zJqa6mckaF+FHbVY2sXMqA/UnIcsgY3A5b2vUgqxcY4NI6jcm20ycgCxyrVC8V+JbNvLacL+1t1
	bxU/tx5wrzWRVTdlCa4oVOPdbp+0LWGARnJgdu7/Hmiaoho4zpn/pKbama4up+PJakGeAPg+R9X
	0iNYj7qZcP6SiraVS26ziNEjf3jltTUGT53tPw5hBPBzp/CblhzWcgqDIzihpJlI3SRFk4G4/LZ
	HnIp6FYr8u4hCEZsSSKUTEKoBtwV0RX9wHx1yiGN5wTjruMPx90k45/80Z/Yzu7MoPcoD1xF34e
	T2dVZcfIgWXRxGSxL6E1yqfA6fqCMAoVjDIc4Q66KVILLE0E7aZ1N0B+aM+x3SdmwwI/9RozP
X-Received: by 2002:a17:903:1acf:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2d00e883983mr5892545ad.30.1785178160609;
        Mon, 27 Jul 2026 11:49:20 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:20 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 7/9] iio: adc: rcar-gyroadc: remove rcar_gyroadc_set_power() helper
Date: Tue, 28 Jul 2026 03:47:44 +0900
Message-ID: <20260727184755.2055414-8-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcar_gyroadc_set_power() just calls pm_runtime_resume_and_get() or
pm_runtime_put_autosuspend() depending on its bool argument. Call them
directly and remove the helper.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iio/adc/rcar-gyroadc.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 3a17b3898bf6..d38cf3caeae0 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -159,16 +159,6 @@ static const struct iio_chan_spec rcar_gyroadc_iio_channels_3[] = {
 	RCAR_GYROADC_CHAN(7),
 };
 
-static int rcar_gyroadc_set_power(struct rcar_gyroadc *priv, bool on)
-{
-	struct device *dev = priv->dev;
-
-	if (on)
-		return pm_runtime_resume_and_get(dev);
-
-	return pm_runtime_put_autosuspend(dev);
-}
-
 static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 				 struct iio_chan_spec const *chan,
 				 int *val, int *val2, long mask)
@@ -200,7 +190,7 @@ static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
-		ret = rcar_gyroadc_set_power(priv, true);
+		ret = pm_runtime_resume_and_get(priv->dev);
 		if (ret < 0) {
 			iio_device_release_direct(indio_dev);
 			return ret;
@@ -209,7 +199,7 @@ static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 		*val = readl(priv->regs + datareg);
 		*val &= BIT(priv->sample_width) - 1;
 
-		ret = rcar_gyroadc_set_power(priv, false);
+		ret = pm_runtime_put_autosuspend(priv->dev);
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
-- 
2.43.0

