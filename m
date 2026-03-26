Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384C38734D
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543093; cv=none; b=MUML4y3gRjs+sXUBnJXpdaJkZqJ5fsGxjFcj22Ia8ZarGPApUdyYe//3zCjKHkU9eoqx0hTiK3KkyXbytLjVxTHi9sGWdGP8Pj3xgpuU5tMdfHVWhyFsEsbA28fStqHkWzwrcORVkRW/D5Qfd646X65xKm+hfmsIB5YnQ9kTxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543093; c=relaxed/simple;
	bh=gJi5eJfPbZOwrKwGfWtvogi2mRH4nUzmcJdMXEiFq4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFZUxAu2olDSbZu6D4UbCfcZsz3F5oB8Mk3bW/0outbxhYBV2CVVLVrQD85mQ20YTJBjGGfux9fdlPodBE+l96NPbfdvvbfDzRL9r/O38TeOd28+vItJKlqt8VjItAnXTzdUyJ+RyjRTsV+sZGPygeVsCReBn60EkA33nJRgmDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/0FYZk5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/0FYZk5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso12177375e9.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774543091; x=1775147891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bmiT/zLXH0XNbRo012mXxoY2S9iYTJ549SWUrsIQVqg=;
        b=K/0FYZk50/jKkvtybBmZeTfI0Jg55zE6VXmQtikH2tR01/t0tIDhmNdJCVv86rNjKc
         OFYu3t20Z/VJlrzImWxrVu2pKJfG2cCnVAFKabEbDqWDoeydJx3bVjO/WhIYfpRl2irh
         XHUMaeozn0sLWESSpMN0OLbTnde90edk4cR5ZGkukZVGO4lqOIpmDxTfH9eDZkeB+y5m
         rslTDPFxMizjsOGjVN8Cn/BNz6zDfAV542wiXdApMaWzYjaMqD2mJzS2/fwCv+K7uyCI
         cw5Uu2soP5vgyi0bV25J7984AJx0p7E9QyEES5rzI7Xn0mm6a1IXov4PYbT9iYCREhz7
         PN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543091; x=1775147891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmiT/zLXH0XNbRo012mXxoY2S9iYTJ549SWUrsIQVqg=;
        b=e92PdEhtMRoAhtQuB0jQY6PdfJsJkeUAc7Q75RSV87gW/S2rZAfJyKXoAF4vY8gQvL
         g6qDdHrrwk0p/AzGAQCRWa0ClDbRUpEnnM8JiOy6od8KWX1wI8wftx/Rl24xG0ZD6mTk
         x3Uk6OdG8Qgq1Q0OzaU/oV5b0FnWIvIMkX7jx05gaK/Eu+Q5sIvddZPDX3F+/k77s7wn
         GWR4YZuFuzKwuIPKMEKHkWZcosJnrUBzG3xa0dbmUDQvC23uHt7iO4DHFgN0IIJ+uty5
         mfIlTyTQNqiDwhO8Zw5QY7XKZEB9tucBmcOaKOSfIyTwKPybm3AbHUfMpc6W3/Vvb4BK
         XUVQ==
X-Gm-Message-State: AOJu0Yzop9NcaWMyVnsUTnZUNrhb9N4cigxYYUe1k+JQTMzfPXxlujQi
	GlblyxzTgEc1Q/wWFrJYRrJYa7J8SLOc0U9byxw45j1dgHxwFKzuhen+
X-Gm-Gg: ATEYQzxeVIvM/n2slgoukPxFFhfYAdl10AK7bOgx+XjfyYklojbqYo7FmaRBY9EmLrm
	aocxU0ncvYFo8UD5L6TYzOL2+OW/w0wY8VILBBDJrIl+/EajJOwpPVWKFKy5dHFJSE+b5ZcRY/q
	fF/s/MmdLGhyC9So+1kkPVfHE8TyFmY9LNpK77Rs5tVCx4hljh9yXUgrCGk1HOW4fn41uQRjQyu
	r4BDkQ96O5RUa09S87FXzfyxhQ2uQNiIvv3Re3ELjiGrs6WnZp/licvx/Gx+xTewRiYxnHKn3SN
	3Zwiq+HcbkmVbw1fG7GAQTo7L6E6vpsObKMHk1u4wUcpROIWEgRPm1U6AH0EL2fwMbJelVNY6Iz
	he/C6oIdXK9GD4KSftJ9S1wM9+reQVlfcUh74rRCehyTl9tsHy598DQQGYzn0w5l8+WiKBzQKtW
	7b/VM0NugBXu+yCy6Yb8V8HlRqIC30Zos8XXbhVDnsZqcHycdCI+qD
X-Received: by 2002:a05:600c:5296:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-4871605ceb5mr131644045e9.16.1774543090349;
        Thu, 26 Mar 2026 09:38:10 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eae727sm445325e9.2.2026.03.26.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:38:10 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2] iio: light: veml6070: fix veml6070_read() return value
Date: Thu, 26 Mar 2026 17:38:08 +0100
Message-ID: <20260326163808.21404-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veml6070_read() computes the sensor value in ret but
returns 0 instead of the actual result. This causes
veml6070_read_raw() to always report 0.

Return the computed value instead of 0.

Running make W=1 returns no errors. I was unable
to test the patch because I do not have the hardware.
Found by code inspection.

Fixes: fc38525135dd ("iio: light: veml6070: use guard to handle mutex")
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>

---

v2:
- Fix correct commit in Fixes tag
---
 drivers/iio/light/veml6070.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 6d4483c85f30..74d7246e5225 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = (msb << 8) | lsb;
-
-	return 0;
+	return (msb << 8) | lsb;
 }
 
 static const struct iio_chan_spec veml6070_channels[] = {
-- 
2.53.0

