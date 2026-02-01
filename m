Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13049748F
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986524; cv=none; b=ogJGEUVgWHm5r2CLUc2hk3XCeD6sQd7F6k4YvWuKo3MLZblm2UXqHCvC9FKsePJN+pZoSziwp0k6DyVxN4YVrTy97a0m1/aAYIsGPcsNauWix6RkTM1sKvPqB82PPLcl/ItkGANMNQxBmWSCJzyROQJ3SmuftHySbnhpZF9ay3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986524; c=relaxed/simple;
	bh=k7zjM7Yri+i9wf7v5MYIn/Yc6Uw8czWgtbce4NHrzg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCv6StWVsqA9Kd/GwfMdz92T0TBP5+VQzvgHhxCgBe/q+niAIAvAlMdgbNvUMmnD2D8oaMTC2YAVNL785794/+qCuPtve5McGelt/RAA3ykli5nuD9GaGaYGIBWuJUAPoFKZJ92UC523cil1O0QzVaQrp4T0wXnkosNB8GZ498A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com; spf=pass smtp.mailfrom=dionne-riel.com; dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b=SaSMCAYs; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="SaSMCAYs"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88a35a00506so70872806d6.2
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 14:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1769986522; x=1770591322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LuqlQjBZbBfFSUm/DyeF40Ts9FpJt3wsGpC5Kh2/BP8=;
        b=SaSMCAYs9KHZEFl7HkEoPR0m2T5BnxXHu7/39XLtXg6ch10gP+WsZKXGuROM/kWa9/
         vCHXQ0A5nmTJwjI3ffcQ1W7dywqXAHMHpQ4ymJmDVQgoLhuH30WuRAGIJ5Regns5HMFM
         WWTdGQOOeo02WWF5X+5U9blDKLAVqJBG4pcCJxnLDWPgvSQnfNcXmimGDJOxw9bjSlZc
         bKDL3l2hwCr/ZeZCTjutYVBInOMiH9XjEOqlJySf+4ixaNgQfsThs+wAi9y0jh611r5h
         s8JG13e79XaRQIXYJOUPsZJcx+YyIaa2teMuGbS+zW4BQ4Lkd2u8Ukqiv4n5j9S1X2fu
         +ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769986522; x=1770591322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuqlQjBZbBfFSUm/DyeF40Ts9FpJt3wsGpC5Kh2/BP8=;
        b=qmq6PXPp1ajtsmOVkKh/cMoz0IYvE2GJl9+8m6uukOuFC5z24W7V6eNmCLX/QmID5n
         bQ2X19e7bcVPyHYjTU9Q4+QxlAHJ5uUGbrhuHKfHO1cZ8b0XzRFa0bVYlck7OxI9+uLF
         d3ptzn+8R0Xw82HnTF01BoKt/SF8gueAbqO8Cz/a3eollSaytPAtbeVNga7bf16rHrHM
         Ru4W9X/wPhyy01Eh20K4Mtzo92DQCeMFQ9I6tNI/rnVIYKrFXO8ABTQOE4zWkr5ThEYX
         4PJEEnhDA37ThKjgvaW2P7ZkTmXE17LtHRwHbZViz1FY9uad/hP94RItCwr5848lwvGL
         SAoA==
X-Forwarded-Encrypted: i=1; AJvYcCVPdhJ8pTCArk1ZOb0kbmEvjIa9ZyXQWzKpd6UPADB1wb0/zh7CynfhW0QYKLVzzC/WbD/E8zEDKUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7MWtnYzGD6XMlLQ7QtgPOWhTHlA9jeA0eImmEi821AFNEyRu
	y1bruPh+AZOolDBf8b3LM8E50w6LPSyEZBV1WxqjZL3S7wPY13i8pzPMJypDcw+xLppnb9Lf6O5
	FJhA=
X-Gm-Gg: AZuq6aJmSyaurf9fSTYmxjI8y58kaY8ZzGfs6PNUAa7Itkp2vqbXV0NgEGHDw8iHo30
	laU/X1xGVUelgrcwu68HPT5zLwCovLmqJVPNdjUsf6C0JkUkh9ZH6Zc8uNlKRxdmYAfHpcuOLC9
	4hlX7MfaAHhgVW+gwIlF89BuNMB7NtBsy+LZj/cP7t/XMogOdv0tM2T2oL9LRxINRC3nYND6XMz
	k3JU1z5jr9/11bCfRvTlw1zacBXNLUQrG4k96v1AQKN3PUn6D9sL9tmhn3r0GkTgh/NQOocc4Ej
	w1j1WppHlkvxL90X7c2fcVIirTJWqzjadR0bnWjHemm1bEno4PRMPVqkAzcjOdq+g9B4rD3vZdU
	p7KBHDjsY6wtvfZSlMBHGNTO0W7q9JdZpDT42NTr29MLZJJh02S05M0zHqRxHpWRVGeH/sCoyX8
	1lQeONnUrgYIlGr1rQoQaU4QrEoMkMv97ykdEF0aflgFOv1BwrSHwEo8harysSDFWUJA==
X-Received: by 2002:a05:6214:c23:b0:894:7884:899c with SMTP id 6a1803df08f44-894e9f91fc5mr140417436d6.14.1769986522022;
        Sun, 01 Feb 2026 14:55:22 -0800 (PST)
Received: from frankgrimes.elk-nominal.ts.net (135-23-195-66.cpe.pppoe.ca. [135.23.195.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375ce71sm102146966d6.45.2026.02.01.14.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 14:55:21 -0800 (PST)
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: imu: lsm6dsx: Support SMOCF05 ACPI ID
Date: Sun,  1 Feb 2026 17:54:48 -0500
Message-ID: <20260201225450.1649001-2-samuel@dionne-riel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds the alternative identifier for the LSM6DS3TR-C,
just like the windows driver allows.

(For brevity, the methodology and DSDT fragment are not repeated from
the first version's cover letter of these changes.)

I have not made any change related to Andy Shevchenko's comments, other
than the cleanup, as I am lacking the context to understand what would
need to be done.

I am still sending this v2, not ignoring the request, but to at least
progress getting the device in a working state.

Changes since v1:
 - Reworked getting the matrix as st_read_acpi_mount_matrix().
 - Cleaned-up internal trailing comma in st_lsm6dsx_i2c_acpi_match.

v1: https://lore.kernel.org/linux-iio/20251223025351.3099978-2-samuel@dionne-riel.com/

Samuel Dionne-Riel (2):
  iio: imu: lsm6dsx: Support SMOCF05 ACPI ID for LSM6DS3TR-C
  iio: imu: lsm6dsx: Add alternative ACPI mount matrix retrieval

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 ++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 3 ++-
 2 files changed, 10 insertions(+), 2 deletions(-)


base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
-- 
2.51.0

