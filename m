Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230247799E
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684465; cv=none; b=aH7qaXoc3Hv87Z+oDPnToH0j583/imvxnLd3CZb/W+Lh12hnZD6gJFu0CBOEjzIWcyBc1FCHW1vbNFaXkXWlU0FGYkAxF1XPvH+d0Zey1DgJmh9xpLhZlScq8nXsYRFCyA1HzDY9b+wGyc0henCcwvpfb0buC/mCeKBbH3UbE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684465; c=relaxed/simple;
	bh=ZUBkWHDNNvICnLU9GU27LlsMgHqEabh4B/qNR53L8kI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwRMURRwXlW8jy9jhd+kYHD9+pvwSW6P7sVkp9xcEH9NvoyS61GT6rxTV4cDJfiRJKOTSHpmzUdJ/m3njpqAgNaSqwkikOLHuCnDQDepqTJ3qQlThh1Op7kRyABF12Aya2HzQge09oVVTHXmJfgsxNppQzQIBUS5DCnL+4JuRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/u+nY2s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/u+nY2s"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso6188755e9.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778684462; x=1779289262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IyKod4Q239zP2cEeM8E4uNjyl2/tK22/naTotBTyYKk=;
        b=k/u+nY2s4RLUVItpngEYXRBn7YNgl5FgIWM7CPLPXp0qPpL2jqZuamrMeO1VqLS98M
         8XJ9YQQFkYeCQXF+PklPYff4k4cUIaVXaX4CG11jloo5l6fmiVoA9z8o2myvFYqgx+4w
         S5zo5b34qpPqJf2141lKmRLy/a7bn2zlU94u2c3aPt2j9YWAyp9Cg7RT8LKIoQ+FK5KT
         SaKEVye5CLZ/aqwtrQGJJ/fpc9Y1YcBVpyzN6StVDg6FJRTFR/3qhjRW0MDjzzLoyptW
         uAfLaYAuhhmPT9iBK88c5g0gDbfMutWX7o+U01oUxSY6iegEJBNNN1ZWRHJG0yNAtV48
         Mccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778684462; x=1779289262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyKod4Q239zP2cEeM8E4uNjyl2/tK22/naTotBTyYKk=;
        b=QxMsPYQUQr0fdV3aFUA4Y+ZC7QmBAu8yOeruHsRsW4B1ng3269a4FqO5jxMRsaqnp3
         mDmfr0yQBc8JC6UnedODRpBbc6feMm7/EWf7cgSFzA5LrS8V09BU1ZQy4YkQfgxzGzCB
         zX2y7eIRfrtsEQ+OxjAmuKG8rSMu8A8+8N/ZGSW6d6tsNV6ZgK3xIM/fyAd+husb04Qq
         eA4+7coviSfhNaJNZg6vb5qgPsZn0gNklzjk5atdAadDYDhTjEcl7nWSu7AEu+4urJ0E
         sMEo5snJ4kQs4Wf4rXP55iZkAPDX7LjUVCDSlglaZ+Qr08TZtkKDMwXq49R9jkei3d+s
         9v4Q==
X-Forwarded-Encrypted: i=1; AFNElJ83WLnrwU4d6uXw1IJjCZGPBUG2BB1NmAgWqWRXkjb/AhxFsjhigKh+Kr++/GmACBDVgH899Kis5WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpuOLKpC72GVSWob1R/pa4WOImJogZLGHIOdApEDBqqTNxZz+
	Y8LgFL7BCaestw7YD2PtfKbf4IdknhDq9EDYeN9e7tMSzOOnJ4udIHXKRgfslKN2u2c=
X-Gm-Gg: Acq92OFu0ifWuzpEAeqCtHRlaSLCytkjxmfZ2bbVjNahKPnzThJkKTiWRx40bMkauW6
	C6VXl1a4e4Zp4c/ESC5SOPNxM+2BVcU99eI4ynq+vbkzQbEeRj/ThYAh76J7zMGTAqIq56apK0z
	x5scJ1ynxTgb9URk183qOXoZH4/qeVJbH+7TWY0ElJzixHE/eIsUs7xy7CwUEK+hxdM5l19trg1
	W5rVh5xs9/ESKOOjKs6LbosRwCsxSsBPG/f8uRTgHGr6aLdV2eah+J6Uh+BBduFYWdRC4XHV12c
	Cfm2a2o8KHcOOSE5VmceqvWme/ApY3PtI6bxiXtMWScCQuK4bP9mSDNaPMwVh4YFlNvjB2YGMsE
	hXBFHvyEX/AWRBgYmqNUztxFj1WA4qb3BiqvvDTbq8yU3PPKBd8i0LrGX6rGWOBXA8Yh/tZF0/0
	Z+VH6YGtuMmnP5iktqeT916ZG2sGArXIAZFoHRPbMGfiXX
X-Received: by 2002:a05:600c:4685:b0:48a:52ce:a4d3 with SMTP id 5b1f17b1804b1-48fc9a53344mr25375055e9.8.1778684461850;
        Wed, 13 May 2026 08:01:01 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce066eeasm48822885e9.7.2026.05.13.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:01:01 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: lars@metafoo.de,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: ad7768-1: GPIO reset path delays do not match the datasheet
Date: Wed, 13 May 2026 20:00:42 +0500
Message-Id: <20260513150042.10939-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Reading drivers/iio/adc/ad7768-1.c I noticed the GPIO reset path
uses two bare fsleep() calls that seem to disagree with the AD7768-1
datasheet (Rev. B). I do not have AD7768-1 hardware to test this,
so I am reporting it rather than sending a patch -- maybe someone
with a board can verify and fix.

Code (drivers/iio/adc/ad7768-1.c, around lines 1249-1252):

    if (st->gpio_reset) {
        fsleep(10);
        gpiod_set_value_cansleep(st->gpio_reset, 0);
        fsleep(200);
    }

Compared with the datasheet (AD7768-1 Rev. B, page 6, Table 1
"Specifications", ADC RESET section):

    Reset Low Pulse Width        minimum 100 us
    ADC Start-Up Time After Reset           17 ms
                                  (Reset rising edge to first DRDY,
                                   PIN mode, decimate by 8)

So the in-tree code:
  - holds the RESET pin low for ~10 us, where the datasheet
    requires a minimum of 100 us;
  - waits ~200 us after deasserting RESET before issuing SPI
    traffic / set_mode, where the datasheet specifies 17 ms from
    the reset rising edge to the first DRDY.

The neighbouring SPI-reset branch already cites the datasheet
(page 70), which is why this jumped out.

If anyone with an AD7768-1 board can confirm whether the chip
actually needs the datasheet-spec timing (or whether something
else makes the shorter waits fine in practice), this looks worth
a follow-up patch -- something like:

    if (st->gpio_reset) {
        /* RESET low pulse width: datasheet Rev. B, page 6,
         * Table 1, min 100 us. */
        fsleep(100);
        gpiod_set_value_cansleep(st->gpio_reset, 0);
        /* ADC start-up time after reset: datasheet Rev. B,
         * page 6, Table 1, 17 ms (reset rising edge to first
         * DRDY, PIN mode, decimate by 8). */
        msleep(17);
    }

I am happy to send the patch myself if someone with hardware
confirms it does not regress -- I would rather not submit an
untested timing change blind.

Stepan
