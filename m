Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E29211A09
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673188; cv=none; b=nTOxchgnnJCe3xSypz1A+Lf85LmtO14AMAK/ccjvouh0IEyKxW2Q9iGisSm91nyWmqM7AT5IXwLRLb0NMkoewP5f1Gg+UWpRzWhEvr+P9PGdUQ9WOiruHB9Bf2wmqITl6tEcW0irCwtfKudH6mQBJOsbXziRT3gAk9rz9lCL0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673188; c=relaxed/simple;
	bh=SuM+0HC7hGWwJTXikbJW5wAJ2RsorksevrifGcg2M1E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kDGlT1aXg0wFJJYdD9iiVOKTJW12ry3v2f2xFyyI0XXij1wfK/ae/NTRyveeNMofo+egUWpwDWuvrpi1MMKal8/SWKWk1HCB04evMYzaTcFGau2dxMEkQPotzN2l1e7O3G4+KGkxF+3SZm+FQSlJBCVAojdWkPGzJz51DaYtg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=i9359lsR; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="i9359lsR"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-47c918c62b4so6042599b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673185; x=1780277985; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugzb2uhvCgbHvggVe5Xy5Mt/HBvzlMq1ELLD59c9p5s=;
        b=i9359lsRkgE5mpSaPxADS1ZbRSnJmU6VSOsK1AEH/YxCpxFOQKsuqZe+uGimaDNnOe
         tUOzXOTpEzRWb0GZ+jHWqgSbmUWO95Hg2q5tmWdS/eylqn7yPL5QiX0PAq99zdioVpbs
         JX9jjIAGYlfUq6SgOEC2oSmM4jLrWbfrX53EHyyd58y7P8fQVU5Y2CUkRgawWtLpZvd6
         QaZ6D+9Hs8E/mK53tb2fmSnwKgt6BgLcIbOM7kgk4AzPxz4r2HA2rHm1huAe96jXOE+d
         QuYaMicBp7D0otbBCyyc0Kyx2lgKMZa1TDIlDTSi0bnNeEYi/JcE0oANlsutdH+vskw3
         RyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673185; x=1780277985;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugzb2uhvCgbHvggVe5Xy5Mt/HBvzlMq1ELLD59c9p5s=;
        b=Saoe+sh9vcsvEuNpR4gKQF1wXY+nFlHwwqJAeFxbMNeiq9q9UM/MG47TX5vawQ+umQ
         w0t3nLWjlaJXy11vw6IU6QN87qq+grtZOmfIVmc/f8Few40Fdnx/Yq0o37tDh3k13gND
         m9bHQ3Ld3hp/CBTzJ+nGmxtfJbvl6HxlKrcaUYs1gURv29EW6+MkTmIfebScgvhQRKdN
         ytes74ol3ATSjzQB3c9TmKmYajL0gPN0OI5vaNQEzrksHjo8WWEbfZzNs3KDAAFPmlEb
         jYRwCL7iZE55XnYSWAJxbceU3KNQ1mGBSFtOu0ztA5frntFtSJiXMrXhYvC4jgo3Sazx
         Wwuw==
X-Gm-Message-State: AOJu0Yxjdy1wmT6DlWiKTU3TfThROO3v0n3mVBuLtq33Qrd/idVbjFuC
	oUU1huBGfxveJLImaQsl/I70FUrVjpYFMJitMPcPcsRi9JnkW2suKsvZ9LryX8EdCAk=
X-Gm-Gg: Acq92OHqbrysbs4XKCkSRjODu/GPPtdrefyG/YEYxAgdsQRaKrtm3RjKjwaNIy6yBaW
	5GvUUWYclFb8I9t9ODucjO1dzyuN+edonHMt80Yd9WhRcxpaOoBSs3w6jYQkB/iI/AQp7ox2AkK
	TesP+lTQ0r0sIFyNSLJiN37ZmJyoU8Ha4V0/e+K1Fuo5cVFxK0q3t4/R7qNuvMBX0RdZHPGe5B2
	MrFP5APlfjztduHVac+/5/OhKQnqXrKrHiIekoZad+27MEnVvoByKVm3F1fjTqrUj9is94Y0Mip
	tlTJqECLL4/GtkTpgHstC5EaSohUJDUzzUIyGEwFFlajHfjfw2Phi/Sjo6DghRfMiR8IQvz73eO
	ZM9LmI+YxqpYk/8S8Qyi9rjV2/ruc2VkaZCPrVXxCoBJ1QYIfbmh/EVPL6OWK9oK9CsO2UufP/r
	rWGY/WemEUa+FVTAjC3YETBlboNJjVXxofUrF36nk=
X-Received: by 2002:a05:6808:6d91:b0:482:6617:d48c with SMTP id 5614622812f47-4854a3fa3ecmr7151437b6e.25.1779673184828;
        Sun, 24 May 2026 18:39:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm6250206a34.0.2026.05.24.18.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:39:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/9] iio: timestamp declaration cleanup
Date: Sun, 24 May 2026 20:38:32 -0500
Message-Id: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7ZhOEwFdeQ/Doq2DjAFK2kIkh
 LsLeACXL3n//QUiB+EIt2yBwJNE8f0G+pSBa0z/YpTnxqCVztWFChTxmKTjmEw3oGvZ9OOAxFz
 qWpVkCgXbdghcy+foPqofx9G+2aU9thuNxOTDfBxPtHv/PiZChTnV9qpKR+SKuzVzKzbw2fkOq
 nVdvxzXaOTPAAAA
X-Change-ID: 20260517-iio-timestamp-cleanup-1ee82f081a70
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=SuM+0HC7hGWwJTXikbJW5wAJ2RsorksevrifGcg2M1E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqE6gdwg4bNuqtGlue/M8kGDelpLpEt8ocyZess
 h3XIm/Xy7KJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCahOoHQAKCRDCzCAB/wGP
 wCjwB/0d574jaJgFsVylSeUV+cUbUscg33m5FcKKHwaNx155nm1c9St0Sx1qnegu8MScNk7qlwA
 IZrN6rt/OLuCilqv0tZ+d1G6OCOddqTXnSLNEqVwi2QcSqspOnK3p8s4LEmU2hfDTma2HoLK07a
 8uSQMkAKzKpihnbPSkv3DYVtXrwxkJS+s07b+b5m6RHgvNbI9hkAvvuSQ7yMGTv4bIiqSAjKf3W
 qEkUeE59f1oEoAAMCxzXop6HfJqY98nUdiw/+3H4Fiyw4fLZjpNQio3yNnqF29RH6WhY9cmozex
 MpuyplJC3Mf1xx9foHj3P6/L2IeIXEPXOysM7TmEc4r56XXQ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

While looking around the code, I noticed that there are a lot of places
were we are manually filling all of the fields of an IIO timestamp.

This is error-prone (as seen in the first patch) and more verbose than
it needs to be.

Thanks to Andy's patch, we can just make the macro a compound literal
so it can be used directly in assignments and initializers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Include Andy's compound literal patch.
- Drop explicity compound literal in later patches.
- Link to v1: https://patch.msgid.link/20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com

---
Andy Shevchenko (1):
      iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be compound literal

David Lechner (8):
      iio: common: scmi_sensors: simplify timestamp channel definition
      iio: adc: dln2-adc: simplify timestamp channel definition
      iio: adc: at91_adc: simplify timestamp channel definition
      iio: adc: cc10001_adc: simplify timestamp channel definition
      iio: adc: stm32-adc: simplify timestamp channel definition
      iio: common: cros_ec_sensors: simplify timestamp channel definition
      iio: light: cros_ec_light_prox: simplify timestamp channel definition
      iio: pressure: cros_ec_baro: simplify timestamp channel definition

 drivers/iio/adc/ad7606.c                              |  2 +-
 drivers/iio/adc/at91_adc.c                            | 12 +++---------
 drivers/iio/adc/cc10001_adc.c                         | 10 ++--------
 drivers/iio/adc/dln2-adc.c                            | 12 +-----------
 drivers/iio/adc/max11410.c                            |  2 +-
 drivers/iio/adc/stm32-adc.c                           | 10 +---------
 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c |  8 +-------
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c  |  8 +-------
 drivers/iio/common/scmi_sensors/scmi_iio.c            | 13 +------------
 drivers/iio/light/cros_ec_light_prox.c                |  8 +-------
 drivers/iio/pressure/cros_ec_baro.c                   |  8 +-------
 include/linux/iio/iio.h                               |  6 +++---
 12 files changed, 17 insertions(+), 82 deletions(-)
---
base-commit: e1a29334a9c043defe7a9363fa76d399d3fdfbec
change-id: 20260517-iio-timestamp-cleanup-1ee82f081a70

Best regards,
--  
David Lechner <dlechner@baylibre.com>

