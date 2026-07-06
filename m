Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159C3B14C4
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337178; cv=none; b=bGoidqHB5gsBmIOqF0S+43ejqPjo3c54MuPT0lfeqNsmLL0KMEFtVjsHBlvvesB8olICdPbKsGlTWLEjloHFUah9Gdb3ChHn5VL3S2Q8QSm49W9Ft7jzAGLXgOlH3wYtOHvo/0b0UQrgLqwJ8D74jFQJwEFICqp3fpFoJyLsm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337178; c=relaxed/simple;
	bh=Yl/x8tO5eG3YRxb0z/rjorMfQJDaXGV7IO0qOxmTNwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqN0uLm165BoyNqjE1v9o64/c9mpNgE18dURwzgSNCdcdM1cIhU3OMCBdWxgBkGJyfCiq7Ww9+fWlIi1uFiFPkz6cf2KG9Y8V0lWszM6ZZbVkRoJMG0lRm2ceKLWw632iFObSX2Qm0d6/MCAI2p1R5l8sIRYRazO145/UqvpIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=st/kFUiW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="st/kFUiW"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aea9d606f0so2864633e87.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783337175; x=1783941975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nuCAtS7rF9EA4PsYf8vQBqiI1N5NmBEb6pRV9awELfA=;
        b=st/kFUiWI5pzdMekIjCfzCLNR8osj97DzA4sUA9H5za/sJPpG6/5rAXjNeQglr+WAi
         l/p3Y8K7bepetN7TQCVsbL87e/AQvlmwzz/PeOAtGJpI34tYf6Nlld5fuppxTDtS4OIM
         QqNnZBNvO8tlMeIbE1TPESIaNcKolurZB0ciE7rgfhCQDH6rXO7PbutaCb7lkjpabpfl
         M04mRVd2q0ZxWHIEODx/TEmm6CIJefXo/FmOO2fj/n4aCDp7W24IOjGyXiZ7/GrNlS8e
         aGmRqOu8stSCt+Ehn1wHdkS+TfmgJFfwRTVZ0Gl6BbuHKGaNFPOfcK+Mn+YbHMHRecgw
         vKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337175; x=1783941975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuCAtS7rF9EA4PsYf8vQBqiI1N5NmBEb6pRV9awELfA=;
        b=N/rRoZiiNYBIZ3uiRY0sBSGA0S9bo/rO3WXfXS+HvtKE4tQ30nI7k+RzzKfXEcuXSz
         4AkqwNP20MoGfdWMpTuFVvy5OFibl1dF+RHK7/pxULgvBdakMY0xVWk5jG4V9i9k3yE9
         ZrWGDg1/muJnICPkrne/IqQq6tMTY5FqNfqH2Mhfs6MWOOTIABnKNN2BCUVkgFBBV9V3
         JaeA3NLiZhUCIv2W/9GzQYlXkUmqaMwzVBxHEPxGZBlIrhXJEjYPWVxzJLvhokXFmma+
         skOKDhdsDaDj+QWS2gJ/iR3sWJS3ceisJ7SpEOJtCAwkcT5v4kIjBmtkbEv3I06/wJ8C
         uyDg==
X-Gm-Message-State: AOJu0YxOsRFaEtyMZt/UfFkoTuX3ANUak/wCIPexwgG9YUF8jH2ynnHP
	O5nBr3sBvtyD+VqlGLUBYDiIkkFg0IoOlTG+Kazg/QuuH7TiHxLVHUb0vBcR5tcnsMvjTg==
X-Gm-Gg: AfdE7clMPxNdpvkxa6N/0CJOWE49pZB9CRUJn3wOUtpeWIoFo3r39xfojgpghCPkOHg
	maMrBeanmGqKE2lZNJq0bZIDtiX+39tDpjhotHSWpVmsl1lEDAbPiGdgrYfC7+n1m90+3l2lLz+
	jo1DVlQ2qj5OOFTz0mUYnby8LeVzBRFxb04i1jtUgb2US32EtJM8JKnGTWtsBeR06FCBtpnOilu
	PWxuopNwkY6r++bPtLFk2ZON90v8y4TDqJncLvvqV1kuOwlv2w/hGovE0I+P8eHVLQP5AzIT1IX
	gIqTV8z18Ay2CTfnK1obexyG4KPKuon78LUwFLfgJTOgp2MN3ORIAT9wmR7HKq3lLpsiTkOWe7S
	fc7VRfxnFoUagTPxOo2uMJFPfsMIuFImX9bDnJy1RHFn9kvXq8IbphVKGO1M4JSOVd3J8i7RTrO
	fQZ34CUUbOr5muDl11Bf7SvUsIe0KeBG463h1Fm1kuE7lqOw==
X-Received: by 2002:a05:6512:1107:b0:5ae:c286:c54e with SMTP id 2adb3069b0e04-5aed50b4a18mr1932973e87.47.1783337175375;
        Mon, 06 Jul 2026 04:26:15 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed1377075sm2730755e87.28.2026.07.06.04.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:26:15 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: ti-ads1298: add ADS1298/ADS1299 driver
Date: Mon,  6 Jul 2026 14:26:12 +0300
Message-ID: <20260706112614.1262241-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADS1299 is an 8-channel, 24-bit SPI ADC from Texas Instruments
designed for EEG and biopotential measurement. It shares the same SPI
interface and register map as the ADS1298 ECG ADC family, differing in
PGA gain range (24x vs 12x) and internal reference voltage (always 2.4V).

This series adds ADS1299 support to the existing ti-ads1298 driver by
extending the channel configuration and adding the compatible string to
the device tree binding.

Changes in v2:
- Remove ads1299-4 and ads1299-6 variants; only ads1299 (8-channel)
  is supported. The -4 and -6 variants have not been tested on hardware
  and their channel-count difference is better handled at runtime via
  the ID register rather than separate compatibles.
- Remove second DT binding example (ads1299 node); one example is
  sufficient per binding documentation guidelines.
- Simplify vref-supply description; remove ADS1298 vs ADS1299 specifics
  that belong in the datasheet rather than the binding.

Md Shofiqul Islam (2):
  dt-bindings: iio: adc: ti,ads1298: add ADS1299 EEG ADC variants
  iio: adc: ti-ads1298: add ADS1299 EEG ADC family support

 .../bindings/iio/adc/ti,ads1298.yaml          | 15 ++--
 drivers/iio/adc/ti-ads1298.c                  | 84 ++++++++++++++-----
 2 files changed, 75 insertions(+), 24 deletions(-)

-- 
2.51.1

