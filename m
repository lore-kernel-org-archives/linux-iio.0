Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0088238171
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421358; cv=none; b=P3UF86igz0gwgTmOhSim4TQl6WYUcrpX8UB9mhYwpy7+kKEy7xt9epWJjCfpfBXX2ZHmuQTprGHz6M9Hsh7ExNVw33ZVVsyvAqmKN6lq2wZJgdUhkrt67KRQeebVIOHdJSKTDzp1K611ks60GcDt8KLnThUwJ0dhdumI6RIQJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421358; c=relaxed/simple;
	bh=K2VtNtOTg4JTqEJPz8l8V2BZEMJdfWdaxQdOL2bpO1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zf2vqTM6eOldnHAv09SI9V6yP0R0XJo+x4/D5S5Dc5ds7jqkeh0uYt1q1xw5HGTGMs6jTPdl7frWYubwbmyI59SJyXqUkiwhTvS3+GuILVFcEQRC1Gd7T20LQM0ak9A1Qh6zT1kUjicAM815g2zl4ag75zkHxUwpTZcfJxYmzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9qBKU2E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9qBKU2E"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c379e8ffso15152285ad.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781421356; x=1782026156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQfu2OUaGHpeNjGbW3RP4BXWwDLaOh41nK5inzTYXHU=;
        b=s9qBKU2Ex9PhEZ3lW/mUGqUS1UbNb16azEA/0RkWpJ281cGE0I8ixy39RqOqd8ZSov
         1WgmOj/e/tAzc9Mx/YHlihzv2hlXODDM92aEunIxlcxvJH3NDaKt2/eYylRKJOToCiLh
         TXl1uLji544/7qTc/qoMwHM2K1Mfg8g884TcVsAVk3pKw3Sr6HLHPtFYS+xZj4J2pLM1
         oOi+DmGHEnmfPEunoe3hnUg7SS/b/1twdaeMoI7YgGxld0oWcXMYD1iTQ4EvOVobbUus
         pQ2+OtcP5BsR2LhqiAdHsUNg+SVyC7HmGOw4GNK2qR4FTmRjP9YWn5Q6ijOSTssOjeBY
         rIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421356; x=1782026156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQfu2OUaGHpeNjGbW3RP4BXWwDLaOh41nK5inzTYXHU=;
        b=V2wmg0Lo4ovC4S0ISaUOpsra3s7E0rXatQ0AfdwmbpAdYFcHHhtvqq80+SrNTcIShL
         9FUWbrorShNaqSJF3N245EUqhA09uuUhz2SUgrcpsbsXy/6bM9X+buLvw/1NCeOjRwEg
         1hAS/xjZHYGP1AleMU8ZungfZMTiVLcc5H4vEXur/Jj6Orx03dguNU/m8884K7f8vNMc
         cf/aW6/XRN0gybgXaXu0VWpD24VvcXClq7K1qEcN2/TKUzOVOBjl1ozcN+K6YwyaWPyw
         Y6lqFElIlD/nF43aXS2ge2eUzTzSV4P6YOEeDF/LfvEmeHujWD62plqTKDfbmP0XFeiV
         5Icw==
X-Forwarded-Encrypted: i=1; AFNElJ8GiWPjy88X4TcQ4GhYTtPQMYNbO/dV0vwnFyssEYS+OJvN7TU8JokUiaKfpLW8Knl6QnFOBo61sKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgvRMVA50sTb18TC72k1KJcupPfJh4JsgY+ZtuewDvwtdJZXA
	1IoElBu1hZQ8oltDcJw9W8gCiX4Y6QV2e509F0ylYzkEUjLkt4xYIFuf
X-Gm-Gg: Acq92OHbX3URQeRh5gBX6Y0DLZ1Qvk4bQsrpP3njcV8WCLnaDMPYWvUwF0dkAh3DRAA
	yWxYOl9GQ6hPUrl+nEuVRRiWhlIYMikDGrKkZm39eZVJ0k5VqauVb8QhXKLADJslHoRPZ+jUJ46
	AN/4BmDk1l2iNkPbQlmwrajwJ1/7JMzgmt4e6N70oyBPR9mDVc8vZlFRxIg3ujmEhvdAcc3XFQm
	nLGJHTko+eKrE4rnvOM6KY+Yr6e3abvA6gvhnf8F1/2004GAZcXIf0R45C8Qjqo13jINtbCudJM
	8/0QFIwMMuIRNNENuTcXcEXTB8oVrtLTxqc7tGEOHTy/0AnHEVICLl16QJdHD1s3P1UvZFT42kb
	0KAQxVyE4OAxhROcHLmcoeP4f01ieiKhxk9yWoNmc31q5R0onWPMEPKDjd9UX0YNid6JvQlkMW4
	NSCr8RdnSB4WTfcFau/ONstlYoEuB+Nl78zGndt5z7hEMmwzNV6WEkXpPxKKTJ3ao=
X-Received: by 2002:a17:902:d48c:b0:2c1:ed61:36ab with SMTP id d9443c01a7336-2c6641e2cadmr66279985ad.19.1781421356211;
        Sun, 14 Jun 2026 00:15:56 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm65595295ad.46.2026.06.14.00.15.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 00:15:55 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v1 0/4] iio: Fix runtime PM leaks across multiple drivers
Date: Sun, 14 Jun 2026 12:45:45 +0530
Message-ID: <20260614071549.81920-1-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

While auditing the IIO subsystem, I noticed a recurring pattern in 
several drivers where early returns or error paths fail to drop their 
pm_runtime_get_sync() references. This permanently leaves the device 
active and prevents autosuspension.

This series provides four independent fixes for these imbalances across 
the kxsd9, mpu3050, mpl115, and gp2ap002 drivers.

Because these drivers are independent, these patches do not depend on 
each other and can be merged individually.

Best regards,
Biren Pandya


 drivers/iio/accel/kxsd9.c       |  5 +++--
 drivers/iio/gyro/mpu3050-core.c | 16 +++++++++++-----
 drivers/iio/light/gp2ap002.c    |  2 +-
 drivers/iio/pressure/mpl115.c   |  4 ++--
 4 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.50.1 (Apple Git-155)

