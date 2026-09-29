Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756655D88E
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707776; cv=none; b=b0iJ8RHGoe+w5SOxhn+FK6gqlxl46L9w02hYPmkBFIxCeYT59H7JTYg+vsqN18XZzBXg9v0w0OC74TieZC1r/AsKr6XjVXjhiOGrvz/tB0rOa/am8KiZteiigZP+bDRYXv979HBUdQV9TJ4cexGzsoF1RadN7n9qKVZjjMs/9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707776; c=relaxed/simple;
	bh=7IbtXTxlmArJ+BFQWMkEj7Rrtt7najQ4NMwV2C1OO6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5v6SGbjrXhfIhwZljm4/UW0RH3CTMzeJD6TtgTFDyoCJE3+bC3K8qEoRgpOe6+rjrQt4aF1NL0AfuJx1yjXqSG8qyweq+330m7rZNmaax1znCtB9fw5vNU84xaC7YPikzyF77wtjlFyXTQT53xuv1OtWs1QJ5/R1h39DJCNX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdvvnDxQ; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdvvnDxQ"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso2235980f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790707772; x=1791312572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=njjB9DtfVySoR684665xgHbK33P3Y+Sqpm+bMczxzHk=;
        b=rdvvnDxQatRyWl3gyJmmL6g/sTbxuyle62EueDS9lLkIqaixMQgWrVi5G+0rWqofvq
         j1XFBGSvWTC3sYASdbeaF4g2XC8lERlgjxqZFb+8XDkUTe8te7WM69izDEPtd/5SkVxZ
         FIlGAykF1dTYHsmCM9hJL7XhhftsLAUzpnvYZmY3+n7Zv6N92AMdIgzIX8fCyNeO9lQi
         VFR8cvNP++A6iKex86GYdkYQAab7T5ufc6ss7/d2S69IK/U/LAjfO1t6crE3v8kQvcfY
         soiwnwdTR2I28nvtVMLH5QKhMa4ixItHlz7h0f5djcK2AoWQKDaGmfl+B0wNOXz8PHvT
         qyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707772; x=1791312572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=njjB9DtfVySoR684665xgHbK33P3Y+Sqpm+bMczxzHk=;
        b=DcuhrX/mzAhr4dFsdqykiDCPDxl3vIE7xB4R9hMAd/3LR3XZKSCskaPGUQkLjDzfZx
         a/JGCMJhu81lj98CNqq1QuwnuS63BEpf2bkPlBT9Y+Ub3vAJHghp/sU4RVV1x2RpFZ3a
         5eoODenRGE1o5sNRfwTWqZ4m6mamCgvI4MHWy5YKunK/NLFBHHMrjybDnIKHs9o9a9Ym
         kIILQNXbGaNRYtSuNM6WH1Y2srHXTfGjvnhWjhUJZev22al9Mh07uHVaE5Tp0IE4LFLo
         s/q5DliaBxLjSu5iBgP51qn4XDYRdlGfkVfd1Zbd8berjXzWKDPeTCXXcKtRjbS1krty
         QNDw==
X-Forwarded-Encrypted: i=1; AKwUvBxhAAX3yU3qlU76PZTcvK897liYAEoVneYu7JY5emq7Ghk3IFgnVxdohPW6ytHx2uZ2577ky4XPvjs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPQpcL4mWvhEfy9UTn3KtwtD40B569WDEdS9ARX36JZlQ9fw1g
	+Lb0gaSnxNEmVL4Tq2Dv1kARcjHUPv9Oql8yoDjbvDZNU6Wg0PHES9d3
X-Gm-Gg: AYBFou2Fd3oNrLMeopKkm2o9fF36fioHzJFsdK6sO4U9ECf2tSuTYe9PzznoFS7hth2
	FnzddALWx04/oRV7ltarmIeojM/kJtCL/mQ9xo2mYTprlBRhDnQKJ3JQPlOXzymdUSE9HVn8g/T
	5Yaol5myO4Q61C9D2igl/72KxCWohNzRRvt3VH0WwCNGxJA/9HwvcfwgeRp7y1vRbdJPOn/mpUi
	koCaOsesFNytWn7MDyK8mzeQPUc/iV5cpNxDoeI5zJZL9ul0vnq7jSd6w9lMpg3Mfuuo2CN7Mu8
	7VGs8Zf5ygVEkJg6M5iAUAorWCwKW0MAJcOnkworXgqeJvkw/pI+48R4v+5TXHk98BudUHff1p6
	bIAkpBvrdVgxumO/Tp8G/FtRkWNw3a8uORZZ3iFp0jilsHiJ7FSWSPraQCfXknsSH6PsKu32t3N
	vCSOeGNdhyGqADsSMqmCJ1jCPyI4ZOGQDg0/lgbhwQAJKwH7lE2l9yzEwTq8dANzo9tuwgjgSDJ
	aI1SA/xSv8IFQdHL1/GcAk8JawYGoU=
X-Received: by 2002:a05:6000:603:b0:488:823d:5060 with SMTP id ffacd0b85a97d-48afe9c2eaemr300741f8f.48.1790707771742;
        Tue, 29 Sep 2026 11:49:31 -0700 (PDT)
Received: from fedora ([154.182.121.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48afe6b8d1esm452569f8f.30.2026.09.29.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:49:31 -0700 (PDT)
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
	error27@gmail.com,
	narcisaanamaria12@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH 0/3] staging: iio: accel: adis16203: fix axis mapping and cleanups
Date: Tue, 29 Sep 2026 21:48:57 +0300
Message-ID: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series addresses a fundamental hardware mapping error in the
ADIS16203 driver and performs a few necessary cleanups.

The ADIS16203 is a single-axis inclinometer. The current driver mistakenly
exposes two separate axes (X and Y), leaving a FIXME comment on the Y-axis.
According to the datasheet, these are actually just two different output
formats for the same axis (0 to 360 degrees, and +/- 180 degrees).

This series removes the unsupported Y-axis, fixes the inclination naming,
adds a missing SPI device ID table to ensure proper module autoloading,
and cleans up the register macros to align with kernel coding style.

Best regards,
Abdelnasser Hussein

Abdelnasser Hussein (3):
  staging: iio: accel: adis16203: fix inclination naming and remove
    unsupported Y-axis
  staging: iio: accel: adis16203: add missing spi_device_id table
  staging: iio: accel: adis16203: clean up register definitions and drop
    redundant comments

 drivers/staging/iio/accel/adis16203.c | 108 ++++++--------------------
 1 file changed, 24 insertions(+), 84 deletions(-)

-- 
2.54.0

