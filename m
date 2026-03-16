Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC683CFF5C
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681592; cv=none; b=qc9/J2NwqdwU1wdOEl6Pp/n8Bi7HdFVrR+cp0Mwe1DRlOvE+BStLCoK5ailM0r1gTBIopjycefAu5tKx+vueiozFMOYCNR3NwVj0pYiwhRCJ+bcJn/PcVTNmz6L7v3XnWc9+0y9RFQkYxSUz+BvGALYQf2LyiWOHz1NjDdwcFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681592; c=relaxed/simple;
	bh=OOhWhIBktKoAtdZER1V9ZuKqMI9/xmuvVzeYZnJq6n4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Melr4DYtjYnWjtfnA71fnptU/ci/4DWIRAm3EDpW34OxYB9watwaWrdbHEILr107ZPiKi9SHNqsex9gVLa6cJb7j3oNyvYz+gRtwqBm2lY7q5s8cjB5EFLbAENztV2NgX2dzmOMjRMeIBpPNIFUZgaNMtDrjRVh2cFKP+xkMbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vr4HZzbP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr4HZzbP"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-666f646f5cfso745960a12.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681589; x=1774286389; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ui4W/qmHAPpyDEXnX4wSdjce55+fYM+nlh/b/oydIMw=;
        b=Vr4HZzbPRIhBCSXdcedBYQcXcnXvLcYpInye5TgPFvzjh1Cz7l5+Hyc2QW7qbYzkuH
         kMjUhKZhe68ocfqRXvRQ/Qhw17+wZSO4S8HOhIcuUncz1hY5OLLa3BveQnBZaMg4Fi6c
         VKgZsDv+sIGexmf7tDndmT3b2Y9G6Vo7yuNpqaMV9Evjbl2mRO8h5Fe19hWNkcM3+oOu
         tWPwl24oV+DyG0D7AgsKoCFwGwaxF3HOgnoAw4/Hck0ddbxpnnHnCyVzh4osI6gsQ7ba
         ri6olGIiazlE8ttTsa7HBoVK9QnaRW25FqzsTm4Lzz3g3wrYDwJZbjf9giv2iWxBc4/c
         I5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681589; x=1774286389;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ui4W/qmHAPpyDEXnX4wSdjce55+fYM+nlh/b/oydIMw=;
        b=VPJzkRrqAZo391kslUKGkIAYQcKrhIkndJaKXoPCXYKaZLfSQi+6jmzPcNMO//MTqH
         Tzk/6Z0ibcqkPX00jNoizDA0NwRkgx04DxNpCxL1u/Z+mgKomy4lyiA1u68Y0MAi/mF8
         tqbfRp01ueMl80LXnDCsFNvVjS1dfuDAIeT7AeuU1aSPcy4liuUd9Dir+j7RN5/r7mj/
         HUfKqGy6oArGOQ6CbXSg0bl47lLL3YgjcVg+p+5NlfD14xwSmE1Q9DNhiJA5G2ua1QE+
         utIX2EtK5Ib0g1aEk6bf3QkuBGb2v43Wx2aPlOl5tSh9uZUISV7Yy60FMBtL11aoZDIl
         l1Cg==
X-Gm-Message-State: AOJu0Yx3PEfy+zpuik5hN128ry2wUJwO8m2gTkbnAatQyyMCJiAgmURv
	rfTJBpdxCdFg5YPX4RHvOpX1C+V0h1jtGkv4RtQoDT+p94KSsxgwmQV3
X-Gm-Gg: ATEYQzwIQLXdliyiepmmBz0OvDcus4btFPG5fPRRmc7u9px41KtngI2cU/TnWdqV4up
	/JH0CAwb01S6pV/9Vhd+V8MwU/DsZzMmesULS1Csmawua9CTURscI1BmQ68xcaFYWYW/Ye+xiSh
	OVpZ/MgnIybVEldUS+VDGWWkUKmYyZXX7ZT5KvNK4tf4MEEkkddYKOd56d39yxyKuarfeLDfjA9
	M4kWXbgc1PW11bomOPfeN3RUcGKpvp3YF062owqwBCortFtNVqzunfgx3CUHMP5MYQ8VmkDKcyr
	IUG8ri38vQGmK8Te7nl+fLTet6oihaJ7XOenRozWEBOl1jzCdLnsXuqJYd9Okq6d7/OhBfWhGWJ
	Q8Ne3w6dpH5hR7aKsIZFLI/L+hgv44GqQiSHnNgD4hVn3Ryx8VkP9Epsz712Z/imM3/DPuKvJSO
	XIrE32aygSLygGbdqHtLoznk1Kjg==
X-Received: by 2002:a17:907:86a5:b0:b96:e79f:194c with SMTP id a640c23a62f3a-b97d6e51416mr31543466b.31.1773681589204;
        Mon, 16 Mar 2026 10:19:49 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97846174cfsm505940266b.22.2026.03.16.10.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:19:48 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v4 0/7] iio: light: vcnl4000: add regulator support
Date: Mon, 16 Mar 2026 19:19:44 +0200
Message-Id: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NywrCMBAF0F+RrI1MHo3Flf8hLpJ02gb6kESDU
 vrvTgtCkS7vcO+ZiSWMARO7HCYWMYcUxoGCPh6Yb+3QIA8VZSZBGlACePZDpwGAR2xenX2OMXH
 na+FKC8KjYbR8RKzDe1Vvd8ptSNT7rE+yWK4/T+x6WXDgxjhqlB4Lo65Nb0N38mPPFi/LrSH3D
 UmGdBU6550rSvtvqK2h9w1FhvLa6rJSYM5ma8zz/AVwnkZ4PgEAAA==
X-Change-ID: 20260310-vcnl4000-regulators-bcf1b8a01ce6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>, 
 Raymond Hackley <raymondhackley@protonmail.com>
X-Mailer: b4 0.14.3

This patch series introduces support for voltage supply, I2C and cathode
regulators. This fixes an issue where if a regulator is shared between
the proximity sensor and some other device, and the other device is
powered off, the proximity sensor would be powered off as well.

One of the commits includes a Reported-by: tag without a Closes: tag -
the report was done outside of LKML.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Changes in v4:
- Reworded device tree bindings commit into imperative mood and
  clarified where do supplies come from.
- Moved data->chip_spec->set_power_state() calls from init functions to
  probe.
- Removed explicit less than 0 checks for ret where unnecessary.
- Moved the patch that adds regulators to the end of the series.
- Added an explanation for removing duplicate prints in probe.
- Fixed indentation for devm_regulator_bulk_get_enable() and i2c_smbus
  writes in vcnl4200_init().
- Removed a redundant check for "proximity-near-level" device property.
- Link to v3: https://lore.kernel.org/r/20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com

Changes in v3:
- Added a more detailed description for supplies in the dt-bindings commit.
- Separated sorting includes into a commit of its own.
- Replaced all occurrences of mutex_init with its device-managed
  counterpart.
- Moved client->dev variable declaration into a commit for adding
  regulators.
- Removed redundant dev_err messages in probe function.
- Replaced all direct usages of client->dev and data->client into usages
  by variable.
- Link to v2: https://lore.kernel.org/r/20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com

Changes in v2:
- Removed double quotes in includes.
- Reordered includes alphabetically.
- Enabled regulators before the mutex is initialized.
- Replaced direct usage of &client->dev with a variable.
- Link to v1: https://lore.kernel.org/r/20260311-vcnl4000-regulators-v1-0-66b6038ce563@gmail.com

---
Erikas Bitovtas (7):
      dt-bindings: iio: light: vcnl4000: add regulators
      iio: light: vcnl4000: sort includes by their name
      iio: light: vcnl4000: move power enablement from init to probe
      iio: light: vcnl4000: replace mutex_init with devm_mutex_init
      iio: light: vcnl4000: remove error messages for trigger and irq
      iio: light: vcnl4000: use variables for I2C client and device instances
      iio: light: vcnl4000: add support for regulators

 .../bindings/iio/light/vishay,vcnl4000.yaml        |  7 ++
 drivers/iio/light/vcnl4000.c                       | 90 ++++++++++++----------
 2 files changed, 56 insertions(+), 41 deletions(-)
---
base-commit: 6e03baeeb160e6cfd72f2c39f26c50bcd925c7a0
change-id: 20260310-vcnl4000-regulators-bcf1b8a01ce6

Best regards,
-- 
Erikas Bitovtas <xerikasxx@gmail.com>

