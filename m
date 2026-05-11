Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705323B6363
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494322; cv=none; b=N7vz0+gB3GLfxLqv8tdAKf+myTlu0d4cqKFvvLqOWiF19/wrRee/TkZcl6TraPB8R8DPyHvUCuXCDp7FT0lf+pZX86XtEF8/MA2J8CaD0DFy40eY9gzeja3pGwH15nEZ78onTm+q8PsGQvPUqRUtJf22M6rPnec4hUHpGBGpk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494322; c=relaxed/simple;
	bh=AqGNq/GRlF2foyyUDkaLyparD06ULS+XaN7cqGr7uTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVUC+qvyhe8hyXQ1Qm+l+Q0iTk6K4wK8oVGbIZJ0Lafbh1kjkGgIeOy1PGahaSxxgy1djX0ilgnefqXqn6o2OvJxmFUUrLieJYyw/6UuaRvunvnrwuiQ6e1vYxykN0tn+jGKfQ6ES1ly2kcjZVh7Ai2fQUqpaRK3wOKdcupFhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFbkp1Jz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFbkp1Jz"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48962cd0864so3398655e9.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778494320; x=1779099120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPG4EaiCI87DBlaCTHV0Yb+wiFmXjnSOWW9fMV9J1hk=;
        b=JFbkp1JziNCRzowK645CoAPfE7OvulfyYwTLIE1F1w0s4y6Exrj5OmiczzDlkQiq5M
         SjXpPiEnkguxRiNQmPTJwZe6J8rq0zTPNal/ypXf5lY6ucvJvpkLDvvfBhjPo+0elC/E
         IJF8xFmPJkEC3QFVArmIzXhHO8RAUizMX9b1ZeC6J7UWP24i9YWBMG7cVQLVfVb4Cog7
         vhomHalaTSbdbdqPf3myfHJt0slSYM92dVTYezoBGJGUT50KJgo7ZKYZuevzJRtjF8IG
         RwwShb7+5tIjwmiJ0lHHN30PST1waaC+/AOiNU2wVWj5n6c8rA5Zrsn118wimBYyV5lh
         +5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494320; x=1779099120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPG4EaiCI87DBlaCTHV0Yb+wiFmXjnSOWW9fMV9J1hk=;
        b=UhyjiOVLpfF7eOSOmgdIHGUi4XyauHUQ2tOzOpPQsotLCj0brJomeJ6THnnG7IgfM0
         WBrh8Qo73Ik4d81S3XQ7qUMCgtef4QfTPYr8raBN+6RJtzrgzKZQkEEvp3EESMrvNWE6
         aRozpKX6JT2wIwiqYYUydd7r+Z3bD+UGNDqX2SkZbbC1E0uI1ejSdSDsTPPKyy9d2VLF
         h5UvbLB2O53harbMo4E4iXugdubRad75CnkGOZrs8PbuZc6FBPjS1Ok7lf5haHbq7jOR
         tYw1zjINJi6MsBZIJqKXScGDPy24an21Ec7D8VzXSQEiC4TvCMpul/cdXX0HvQTNp271
         gpeg==
X-Forwarded-Encrypted: i=1; AFNElJ88ikP+F2DcBlCrcbg13nTj44koCiACRK/xFMjThxqnJSEpDjecrnr/8pQC9hYYU6M6YwbuJoZY+Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpIDo9iF/wtnusgs41Ssoeqbjb3Od+Up/FFw4Ubi65tuIL6pv
	jFkigjCGEaKF+SjGfMghvmOyhEcjLEYPlZdGH7QX6Uv4H0uASTxDuYYd
X-Gm-Gg: Acq92OFjChF8W91rehcye2tShKt/flz/a4fwZric8sQU8hTjit5KX9AlMqXvxg599T2
	dm7fykXz0YhejUodm8kxssToFo26M4qGC0VSK9AkgBVaJoygpIUP3wii+6DTCMWkRyazcGvgIhV
	d7kbl0VDQ/WBx+eWAxON1wG/hEPzS4F40odDkUJtBGY0dR8nICj/omdLTc3JLWdCZtuARiAv3Ca
	6/pLryRL65ujf3J/J0hZa7UgTePA0A0Uwt0wK1uOyzX1r0AStePiKmnMBkb/0YDbvf5vRv5KLEG
	9Qwah8CqwVNaGWyyFz2B0qjD3CWDyaBXedlTg5o9vuN4Tx4o9laoP0qmWDyTwu5ab80drxHFA1Z
	EN/JXwfQGU/4wvi5iVD5p9JGw+2CuWOVX31JKqDeneARluO6krK1fhWGTV7Az7M0ZZgLHUvuCsJ
	nNRR+M757JNW4raK2dz3xjvcoVUY3x+7UM/+3QbgwP2PsW
X-Received: by 2002:a05:600c:8908:b0:488:93c5:4dc with SMTP id 5b1f17b1804b1-48e51f4fda1mr133136505e9.7.1778494319484;
        Mon, 11 May 2026 03:11:59 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6f9fc89asm186447285e9.0.2026.05.11.03.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:11:58 -0700 (PDT)
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
Subject: [PATCH v4] iio: adc: ad7192: replace usleep_range() with fsleep()
Date: Mon, 11 May 2026 07:55:44 +0500
Message-Id: <20260511025545.41631-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260510113921.50133-1-sozdayvek@gmail.com>
References: <20260510113921.50133-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7192 datasheet (Rev. A, page 34, RESET section) says:
"When a reset is initiated, the user must allow a period of
500 us before accessing any of the on-chip registers."

Use fsleep(500) instead of usleep_range(500, 1000). The 500 us
minimum stays the same; fsleep() picks the upper slack itself
(about +25% on a default config).

Add a code comment with the datasheet reference so the "why"
of the wait is visible at the call site.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v4:
- Move the datasheet citation into a code comment (per Andy)
- Add a blank line before the fsleep call (per Andy)
- Drop the "No functional change" claim — fsleep's upper bound is
  about +25%, narrower than the original usleep_range(500, 1000)

v3:
- Cite AD7192 datasheet for the 500 us minimum
- Add changelog (was missing in v2)

v2:
- Drop the redundant "Wait for at least 500us" comment

 drivers/iio/adc/ad7192.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8b1664f6b..ba27614c8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -576,7 +576,12 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
-	usleep_range(500, 1000); /* Wait for at least 500us */
+
+	/*
+	 * Per AD7192 datasheet (Rev. A, page 34, RESET section), allow
+	 * 500 us after a reset before accessing on-chip registers.
+	 */
+	fsleep(500);
 
 	/* write/read test for device presence */
 	ret = ad_sd_read_reg(&st->sd, AD7192_REG_ID, 1, &id);
-- 
2.43.0

