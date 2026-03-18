Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E03AEF31
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826187; cv=none; b=SCZD3cv3Yz+ECIhqAFEJO3YrvSbGbm3X3wcbtjQz6zzLWoWgjA2a35ELMiMIvAz5Cojnxc8LPnHWcu5oQ9OYwW56ChNLrwedSE2ZvZStXcvpu6raKqonw0Ag83KBbfOM3svyEQUICJ74p+CS+P1Y4Ff+5sjacD927Ok+OaphxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826187; c=relaxed/simple;
	bh=CA5m6SYfyIsIbGsRbjRvyNxo6rAd15nxhWSBlPRhfLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JgNmYkctPzE4Qf+zRwwL3Ntl+LJ3HWzNl0WNvLuxtHzWjliVxyakrwhJ12wYU3BtRrPsvMDQeQ++DAWACoWcukyRXTfSlBrlSMQSMFYHJmhMlaXMg044dcNwnX3AVJZ/YICIAyAnOM30l2ZfnPeguN6xYbRWhLY0NP+cGab1faA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4A5ta6v; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4A5ta6v"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad9516a653so28668075ad.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773826181; x=1774430981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGRmyA6PexR8hguL2jzNLvuRfItP4aUuu4yOyqxpTZQ=;
        b=I4A5ta6vA/P6FFYV66t90J9is8ja5y3mSXxuKzt+VQdis2Kr82vEyVH129OJGiLimu
         Du2mWzp2ld9l5FAYeC+9lkmV8ZZSXv6gUSx5f7kRjYAzd4odVFNmSvMpbd6D26f/Ln6H
         MKxrDMAY5wL5hY3qCDNjuX2ib2jQcMDgDqGNiePuil8AsQVSSiDO23DmaVkcnPonjr07
         /0ZfcJO+y/V34gAVDIiBeQKX6kU8OgYZZ1g4foGz8bk/g/0xsk1KL00g3ENfY5OmcTc5
         /3hT9tQ6MUTXpZWTy7f7DWY6Xe5zAFdKaXX1KTJphsWsXzpQrvgxnVfDt/+GPRfCgXcu
         xGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826181; x=1774430981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGRmyA6PexR8hguL2jzNLvuRfItP4aUuu4yOyqxpTZQ=;
        b=LabPSI2n6MF7X/Mk046OAXggCGFUfW9RJIxSJOQWc1e8zHG7L/dbvpd0bkyf3GR7W8
         4inEP9y0u36ZIiBP2bNTGipMINof7y5sWk8UUVG9BxzhKIjCtMYCx8zKXe4xaa9c8xno
         dvAN859moR04kM7aqxlkAN/HTYUC7Nt7dlQjZMs8PWbaNPtS8BJjvhHIhCTOA9ruRw+d
         Nc0QbuNLNLDv3PZwgWya6JAMjgeYIaQ2cQf81WKP+PhcApoJszsEszDqQd8wOFDfnw5L
         we1NBboMZFFZGkI59SpR/AidWp9H4JD2+7uNIkUPCGUcGHTKiuo3TWOnatvkP/6DWHn1
         UPfA==
X-Forwarded-Encrypted: i=1; AJvYcCVC2HCXTiM7IwdRn/rR67Zjg4LPvlRzsTNnLi7qkbG3PhTb3keGW8JPVL96qUrBpAf6sRik4nAiJ4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqyUWrL238PCyPxIawFbgnzVJTm2acgOf8VQEvGf6F3dEwJmx
	Spsf8QadkRpJPOvAtbE3XmxynfAoliUz6PzH5I157XhayMfQWTtS4izP
X-Gm-Gg: ATEYQzxv4Lmhdy9nWhab7LjGUeUD2+OajCTpieuFzt0alHivvtfRCrBtEdwCDcwUWaH
	BPaeSvztZXMp0O5CqhJkDH7x6/TJotYuHb/SN77qkcUqD/HUfke/DjdXiSGAAQe9/qmNXiVev9s
	paO4JqDYZqw6hNts4cA6g8SKgPsInuvHMfrQY06N0qmXoYSLKWN6Cdnwt36QRkTQZGgWtcf7l8e
	ougjEyjgHRQI9kQVFcZ5XFQjXawZUSLuX0yEXzDYbfIZUWRyomDv/5TByAEW4GqledUBnHemI+f
	ZJwjo5eq6lkzJfYbhIZ+u0OUS3RoMPyPAPWtBlT5AWoi1fCm5FxIZZoqOPzx+h4fReyJHFxQeJc
	vb+u1zL+s8JhAV8DNTuFzOkDIcJG+1gzPX0JCGXfXtHWKE+fkdpgrPzY4MhTfPkRG9IYjSHSlAB
	5YQoIOtU3tbllhsJzVTZS52zi9KvC84CdxG0sM3q50+wCyXV4mRrlKErwYCr8XnW7c6M4BknZr
X-Received: by 2002:a17:903:3886:b0:2b0:4c8b:7d33 with SMTP id d9443c01a7336-2b06e41b9bbmr32324985ad.51.1773826181095;
        Wed, 18 Mar 2026 02:29:41 -0700 (PDT)
Received: from debian.ari ([152.58.182.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e616351sm21168315ad.67.2026.03.18.02.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:29:40 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 0/4] iio: adc: ad799x: modernize resource management
Date: Wed, 18 Mar 2026 14:57:11 +0530
Message-Id: <20260318092715.42538-1-architanant5@gmail.com>
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

 drivers/iio/adc/ad799x.c | 106 ++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 57 deletions(-)

-- 
2.39.5

