Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1F341660
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548345; cv=none; b=AgkzXrMIHBKhgw4RJgpmyVNbZC7+soqzuhzPNeAoYi4GC4mSPwNvZQbn44GY7fFBaXc0fNeR/UjmGTEnzN+zpiKf7wFv/k06J3OL6veIkHtpUlRYWZ6bqWvpMoHiBNxd0S1AC04OmLcgy+jASFgLpgPXHnQFycdWljw+sGVDjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548345; c=relaxed/simple;
	bh=KMyrE2qkw1LechdF6qnRo6B24M8Q20QwW/OKpwQDK6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nMv2vn7oupB6J0yRJ3XaYWHycXZ70NMMC5VTnyNECPvZJRNWTxmw4ND3v4gHh9jU/hTUHdChJLzwATfCR50/BfVJewoO/daStlKHl+DQQ2HiYdAnLRSEOszSQO/jwXiVbgu9AB/Qwy67LMIhx4puplE0AAxDHMUzbwMryCA35s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE18AIz1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE18AIz1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad4d639db3so6071305ad.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774548340; x=1775153140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vpthkYpLj8cNSLC3RcPhKZj25oOTxi5kjVrmiX4JoLk=;
        b=dE18AIz1n+hymKGvf5qDZ6Y2abjXgntFM4KaDyXpVMzOE7p4y/wKbQkkyNcY6b2VDM
         OqP+VcKFyI1yNVjK45j5kuAbM7N1Vt7sV+lIkvpWx7r0upoeNTknmkZeV8R92blmkCq5
         qhHZ+tlXYEmLtmwnvAL14X16kRSjv/H5Cf8AD5+jB8js8nLX8W2pl35WD+ClR5lsn5zJ
         r+q/06ORbEEuZtGFJIV4gyeS5YlZ1tqVv5tYRpa9H0QOJ2OKLxveY1RVpTCy8v3I7Dy/
         I25ZzTA5n3N4xIGy20WJhDEIdKmgsAuvxmJP4tR8OknfIhJv8WmIbbgahf1cWIkLdycl
         Fzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548340; x=1775153140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpthkYpLj8cNSLC3RcPhKZj25oOTxi5kjVrmiX4JoLk=;
        b=Bv+5DPH7SPA6Ck6XJHAq6OSNdWfq7FvHi+LXG7En7WpCAgxZiSVNi5yFO/NaG/zM80
         6bn7DoLCKNVgva0WCDDdjmB535Rpmi+iLY5+mtcD3+N7rQq9KXBcjlc+5h8TgJgxrFlX
         4SpP8ScD5Jq8Nh0pp5MEt6iOzjTduLSfpc0Ym2P4A99gOtmApdlH7QhobDGjTlRDMqXL
         ykIUIWMJsXZteFbFuc3AgyyStyGbefS7GUymQIdk+92y6HEIfGI4XBWzet8gQQXrZ6L/
         fvHX3zgQ7IeHwHCtpAx+l4e5nzx29nxNrbmo+hw4ufrlZmhTAM7JmdtfI+EtktdgchlD
         yrpA==
X-Forwarded-Encrypted: i=1; AJvYcCXbw40VHzjk/afFDxPF3pvwgUfUO5aKKnuMKl/ULF70513OG5RO+3LgE3w+ulMrTm2/J6uKnwh0a9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6Gcg9VYnIACMbGaa0OljgpfMQQygixUB3l6EXJDlqm7AEgF7
	uKaZPmIG5fyMLG4wciGqwDdlD4x+G4LZD0263afRySgkQUS7nay9sfxNKkU32NZYgcM=
X-Gm-Gg: ATEYQzy4axLxGBQBnndVsxCNMLAkkce2OUv75K0Duj2yo2DsPbMJ0JV8cHyhA5grSiP
	GNWPi+zbKlmD7c7IG0lmwL8sqlW6C/ruBPpCpzbgOiXILdQsyfba8FsIZG+SM3HxIb3QMWvU4HO
	oKkSfisTrpJmkPyn+s/GKIQdm72my0vaYmHKL8vs7gSLgId1GmnJqyzFiorhSWOK6s0EVIpj0r9
	srxekFD5GpigPtJJDAYdRJF5E4IO5THPHceht5QOY1uP2jsrdyrKvBSqZ7I8A6MTHfabOnkZ4lg
	zpeS3QXkKFBSkBbH0n+f9fEzvYmlPk2pzxB4uyPTY4h167zquUp4s3o6gxNovXCqYEuNF7v5wAw
	jrOOwcToBW4Mj9G8QMLiS36fZHi6Ad8NJ4FyfB23uiVuTnql4jkZrb/ntbshlG1gDX1kKk4NGd1
	ct3By5F3SzV2qsnBoC+cz6a624ZK7cAwlaMDrfVoAYph5580VOq6HzDd+mi06yXiGXB1eQE+PzV
	ys=
X-Received: by 2002:a17:903:440f:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2b0b084f448mr92943465ad.0.1774548339551;
        Thu, 26 Mar 2026 11:05:39 -0700 (PDT)
Received: from debian.ari ([47.30.237.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7a17c5sm43823545ad.26.2026.03.26.11.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:05:38 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v6 0/4] iio: adc: ad799x: modernize resource management
Date: Thu, 26 Mar 2026 23:35:25 +0530
Message-Id: <20260326180529.19154-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the ad799x driver by converting resource 
management to the devm_ infrastructure. This results in cleaner 
probe error handling, the removal of the ad799x_remove() function, 
and improved code maintainability.

Key changes in this series include:
- Static allocation of the rx_buf using IIO_DECLARE_BUFFER_WITH_TS()
  to avoid dynamic memory leaks during scan mode updates.
- Caching of VCC and VREF regulator voltages during probe() to 
  optimize read_raw() performance and simplify power management logic.
- Migration of regulators and mutex initialization to device-managed 
  resources (devm).
- Removal of the manual ad799x_remove() function and all goto-based 
  error cleanup labels in ad799x_probe().

These changes ensure the teardown sequence is always correct, 
following the reverse order of allocation, and remove unnecessary 
boilerplate code from the driver.

Changes in v6:
- Addressed style feedback from Andy Shevchenko: used '(MICRO / MILLI)'
  for clearer unit conversion and refactored the optional VREF error
  path for better readability.
- Removed the phrase "Reading the regulator voltage via
  regulator_get_voltage() can be a slow operation" from the commit
  message of patch 3/4 as requested by Jonathan Cameron.
- Confirmed with maintainers that the devm_add_action_or_reset() pattern
  must remain to preserve PM functionality.

Changes in v5:
- Used devm_add_action_or_reset() for regulator disabling instead of
  devm_regulator_get_enable_read_voltage() as suggested by Jonathan 
  Cameron. This was necessary to preserve the regulator pointers (st->reg 
  and st->vref) required by the driver's suspend/resume power management 
  callbacks.
- Simplified voltage caching to use a single 'vref_uV' variable.
- Converted mutex_init() to devm_mutex_init().
- Resolved error path ordering issues by using devm_* exclusively, 
  allowing for the complete removal of the ad799x_remove() function.

Changes in v4:
- Simplified voltage caching to use a single 'vref_uV' variable as
suggested by David Lechner.
- Capitalized 'uV' in variable names as suggested by Andy Shevchenko.
- Removed redundant 'if (ret < 0)' check in read_raw() (dead check).
- Used devm_mutex_init() to replace manual mutex handling.
- Introduced a local 'dev' pointer in probe() to simplify function calls.
- Switched to IIO_DECLARE_BUFFER_WITH_TS() for the buffer declaration.
- Moved goto removals into the respective patches where devm conversion
occurs.

Changes in v3:
- Split the monolithic v2 patch into 4 logical commits as requested by
  Andy Shevchenko.

Changes in v2:
- Eliminated dynamic buffer allocation (feedback from David Lechner).
- Cached voltages to prevent devm/manual ordering hazards (feedback 
  from Jonathan Cameron).

Archit Anant (4):
  iio: adc: ad799x: use local device pointer in probe
  iio: adc: ad799x: use a static buffer for scan data
  iio: adc: ad799x: cache regulator voltages during probe
  iio: adc: ad799x: use devm_iio_device_register and drop remove()

 drivers/iio/adc/ad799x.c | 110 ++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 59 deletions(-)

-- 
2.39.5

