Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FEB399348
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426643; cv=none; b=sViFJu/P/DIFH+xrPGU06/Axz+eMh2mO9Tp0zvQdsH5B9FDqkAGZ0dDfT0b9ohVbi96u1W+EozLT+bZJxLzUjrdYj9WHI/7lu1vtTRncYiKuTMBZ57+NeCHMardy1piOkbMz6ENO99p4bn0P+HpQNj+30Crhm1wB8fijCEt1jnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426643; c=relaxed/simple;
	bh=aJgdn5F7ANeEjjTFYMsP1NPGQ4jUf7yCUwGk2Db6mb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z59OKVW+Nsb8loM2el9Q+IDHJTftPC7GOlrJsOjcRJWEtZu6lTFmf1Dmb7ytJKX7wzB9JV/IFkhlaSnwU1TpAdNl02i4ajosez6+L1hEcyry0+PK+/qjevBQK1eW07v6xJnB8JIL0GA00X1RhJs7R8Z7z0lYJMUl6oSQWPEIHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso1960550a91.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 01:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781426642; x=1782031442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULKi6RzWMctHV9ntWRGNdDBkiKRrjvDnN3TtL1uPAE0=;
        b=pG1hH7cfLBJAnp5DwY5Ii8eezQhveoBWh9ijSYNftkePnDiEUUN3lZQWy0fwt6voVa
         YsrJ4e0PkSmMCF5LPUBeN2sL8W283FHwFFsSEc7t7Zjk4MuIBYNRFNJa8aQ0Rs5I0nfI
         CGrkQUCS/maG3jZ6ZnaA56szpgt45vHT1pM4sPxcS0Bey94omtV4UP6NYhL+lo8z7HKC
         BEjqOszcUCEigU+AbOBAj7sXHt4XXm+O5U38/XnDXh8aRPYFXq5gbGBUOOF7Y2uEwmK0
         xpP5gU4sDGhhcBpKZxLxRDvIREDdyjcek7apxgf3ueECjEaMYuoDsmTmvIiWY64AgRcu
         iQyw==
X-Forwarded-Encrypted: i=1; AFNElJ8RALtvMguHSI8YYHFeLf+sAVFddoVwFS9M6T26IK9ZHsElbfIOqJpAgNF1ohpBYnoufixi/MTzrM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08YvkhwHdQVveHbOOhxj/MU/Qwq72AO+mhikH98el1TUikVXF
	/LG2KpfZWK+OZybhBi9uaCjNDsSxwfpyQwdz46K8o0hGwYoXYEoBSO0C
X-Gm-Gg: Acq92OEUa3pnwtNGWD3DZoepnC+xXIDB+Pn8OKdCjSRIPN0t4Kx+6C2cmt8JXLi/jmH
	GFANxTZL/jqJzonHayn1ML3p8456zF8JkOtPxCtUEN2ILtw8vtE7jqJBUESO0LYk2vgCp8qRAAO
	eVIA8mu3c+Pz7ah2cIodfkzRVoL0e03QMZuE2ot9gWN0HBobtnCMSI5W++OCFMTazIyYb7nqOn7
	xx1PR0RSH9ZZkUJO0aQQm0vJctxKyVK2rmqyUOJFfTR3YZ09y0k/Z+KFoImbuuR7XRkzZfAn4xt
	8C+ZYfpWKAhsdFwsfDA545ENvSQcyDSLEuGKE83RhH6Cp0T1VQ70P2Hx51HoAogHqyuqdsRO92d
	g1COper3IBHt/0V2PWU2WA5ZRfxapNMnx/Z/mj7JlgQJ7f/hFb0zV+Ut4paIKpiU3lDd5tOlnbq
	SA4kDw7WeIiLkZOnBOASPBCqBgfzA/BDb6/CLcQJBCy6mozg5zRgGafbWkkpfLS9FFyj9d47GpK
	iX+tzcSnlPFJtTqQ3Ss1+1GC1bLC+LCUGoHJCBKYyyKAsIHsa0zLTvE+xkw6pFn6WvmUrJKoM+s
	TWSWcjOK6Q==
X-Received: by 2002:a17:90b:2dca:b0:366:10f1:3d86 with SMTP id 98e67ed59e1d1-37c2bd75872mr6655269a91.22.1781426641476;
        Sun, 14 Jun 2026 01:44:01 -0700 (PDT)
Received: from fedora ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd5dcsm7209056a91.9.2026.06.14.01.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:44:01 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH v4 0/2] iio: proximity: cleanup fixes for vl53l1x-i2c
Date: Sun, 14 Jun 2026 14:43:38 +0600
Message-ID: <20260614084349.25823-1-email@sirat.me>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds some cleanup fixes for the vl53l1x-i2c
proximity sensor driver.

- Sort register defines list
- Extract data-ready polling into a helper
- Fix regmap_read_poll_timeout() arguments alignment
- Add field definitions for BIT(0).

No functional changes.

---
Changes in v4:
- Remove blank line in commit message tag block
- Align regmap_read_poll_timeout arguments

Changes in v3:
- Use proper field definitions
- Split changes in two commits

Changes in v2:
- Rephrase commit message
- Remove cover letter

Link to v3: https://lore.kernel.org/linux-iio/20260611134245.30042-1-email@sirat.me/
Link to v2: https://lore.kernel.org/linux-iio/20260608124027.35879-1-email@sirat.me/
Link to v1: https://lore.kernel.org/linux-iio/20260608033218.26514-1-email@sirat.me/

Siratul Islam (2):
  iio: proximity: sort the register values for vl53l1x-i2c
  iio: proximity: cleanup fixes for vl53l1x-i2c

 drivers/iio/proximity/vl53l1x-i2c.c | 39 +++++++++++++++--------------
 1 file changed, 20 insertions(+), 19 deletions(-)

--
2.54.0

