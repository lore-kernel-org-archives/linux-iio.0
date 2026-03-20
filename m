Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F63D4102
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025146; cv=none; b=Z9HxaZ9+M4vZuWfh1o6pPYbKR5jqyfkM2BNQGfmEvrYOSlJMW4m6VQTAN9PlfawYL1+cs/LKcMhmJ7xoVSrVKmmYzJ4gsYakqWOq+WrQw73iddNfHFFYViCB9lk3YCilOvFg/kczNGFFEdvaZKyLA+yW/JqCIidDeTjfSO3SFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025146; c=relaxed/simple;
	bh=ln7S5W6Uf/xuAne/wiJa+l0b61/Ti+nERWCBB1m2EuY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NVpcC8yYb1R6wl+I5tSbftqIC5rgANjf8Igv55Pnr/Id8BQhc/3+mEZWtzSoL2ZvEfHnAapMIgJWV9x6kGokx1nZpSBOfXwEpDCB0/49cf1J3xsiqU4CfEJQmHV7Voi0o0fX+ubbwJCZD2Fbn9nLYYDnGEaIFrFraFDuwZwOjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StnmV3E2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StnmV3E2"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b93698bb57aso439543066b.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025143; x=1774629943; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APS5boRfm0PmBR504YJDOGG69WFYNxRuX26D7Uz2WEc=;
        b=StnmV3E2Dd7DSLQWAV6l914/BiWkPGYzMp/tgyhbw2OCXGYjVwBOBlXIsAdRZ8SvJE
         C/8gsgZgqxUnAsIXRJkSEnL6etxfLKrsNTNR/rSu3L1BC3O3IFPfZTJyUmqcLWX4pK8T
         qRNzsLdTWsfr1anO7MUs8mY1lmhSjy4RVJ6z2tDUNBGyLqrN9VWndjljUCMjI69HKhil
         FXk73B/lZ4Io+ltW1G7lFqhYNKMAgH79CPtamthMKjzLrTdYtRzmn3FD7gK+v79bccdT
         u7nJDzphZCgCsFz3VziEkHQZKl+3WjS4QIOcFZlz3U1BiXgwSqKloHUzXXkNJrcs9pBC
         JOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025143; x=1774629943;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APS5boRfm0PmBR504YJDOGG69WFYNxRuX26D7Uz2WEc=;
        b=bw/dnFHty1b2cBRNKxJrO839LoHxK7OHFnC7pQydQyWCR0oyIe6k4FcAMU81YhlFPr
         cuJ23KXMPyIeg6U8FbAQiqmRl4VWxesLfOH4hBk94ymT30XGorMz1NnT0yB33uyjbIUo
         MqNytTdiZ9U+ALSIHWFkzbnVcohOZEv7lYywVTsT++Ixum0kH4dkH/KU4vLOmyp0zrR3
         Cjz/ieRBiWcKGj6xTX+4VgdYZ2XB9UJfLsnzj/q+wFxTY6f5XAWst81XKvGPp5XIlRfo
         EPeZxLFMB9xRFWH710sqTqSAHLFvIK3/gTLUFhZD77i4szkK0JzgiY8F/sEDnk+U8sw6
         h9lA==
X-Gm-Message-State: AOJu0YxDLKxMNGi8XbhdlTKNrKCObCIfvFFCznL+Zgewjx5cSflM7PQF
	N5pdSzWKb9NzJtfLc9hIXmbHPPcEdO80DLx8q6f1tXXwZyBySGDKhNN4
X-Gm-Gg: ATEYQzzyR6Q2KVtjk1J/fZ1FiLM3DScR1ycyEoQN+VVDZApD8Lv9YPS7Cp0BpNaetKI
	e23jawr2kneIWtm2n2dayDwcGrbvAxAfy9QgQpCq7UgVOZSsL+wdI9UvsupSWLAxlsj9Gdj2NYJ
	g6VVRWAVUDgN1DeVtGogLsQakaxJNsg/Z9MxhgvPpYlufT8a2ledSlZ5L1uBZ73VCrY+XuAqSY8
	5FB2r29GLfJvWUl/AD4JhqwJ7qszotkmL+lDgbDdqSzfdLmNb7Jb3RFNLOFxDdb88SYTjgF9L/8
	75tqu6nes8QMHAXlKGkCHftvRg22EJJ2Da5Fydj2i6mYhXFb8D+VLsLF4wo+q9/LwoES7G6QAXf
	4ANOjEzoZLUwtb2EbeUb8Qqhjpr9u1gGiAOpZOIkJefum4NHOAHqKNErClqNCXFCYKZtLisl3F2
	eWHvNvcP7CdH6nfmlFLZJL/KFHmQ==
X-Received: by 2002:a17:907:398c:b0:b97:a4b1:51b4 with SMTP id a640c23a62f3a-b982f59564cmr236548466b.17.1774025143256;
        Fri, 20 Mar 2026 09:45:43 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335f1747sm176730466b.33.2026.03.20.09.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:45:42 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v6 0/8] iio: light: vcnl4000: add regulator support
Date: Fri, 20 Mar 2026 18:45:35 +0200
Message-Id: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTWrDMBAF4KsErasw+o2aVe5RupDksSNw7CC1o
 iX47p0ECsJo+Yb3vnmwgjlhYefDg2WsqaR1oWDfDixe/TIhTwNlJkFaUAJ4jcusAYBnnL5n/7X
 mwkMcRXAeRETLaHnPOKafl/rxSfmaCvV+X0+qeF7/PdH1quDArQ3UcBGNVZfp5tN8jOuNPb0qW
 0P2DUmGDAOGEEMwzu8N1Rq6bygyVNReu0GBPdm9oVvD9g1NhjN6jBL9aHTYG6Y13vuGIcODNIN
 SSjowrbFt2x/lV57gxgEAAA==
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
the report was done outside in a Matrix channel. A link to access the
report requires sign-in, therefore it was left out.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Changes in v6:
- Added descriptions to the regulators in the binding.
- Fixed the dt_binding_check bug in the example.
- Link to v5: https://lore.kernel.org/r/20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com

Changes in v5:
- Renamed vddio-supply to vio-supply.
- Added parentheses to function calls in a variable usage commit message.
- Moved the redundant "proximity-near-level" check removal into its own
  patch.
- Link to v4: https://lore.kernel.org/r/20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com

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
Erikas Bitovtas (8):
      dt-bindings: iio: light: vcnl4000: add regulators
      iio: light: vcnl4000: sort includes by their name
      iio: light: vcnl4000: move power enablement from init to probe
      iio: light: vcnl4000: replace mutex_init() with devm_mutex_init()
      iio: light: vcnl4000: remove error messages for trigger and irq
      iio: light: vcnl4000: use variables for I2C client and device instances
      iio: light: vcnl4000: remove redundant check for proximity-near-level
      iio: light: vcnl4000: add support for regulators

 .../bindings/iio/light/vishay,vcnl4000.yaml        | 14 ++++
 drivers/iio/light/vcnl4000.c                       | 90 ++++++++++++----------
 2 files changed, 63 insertions(+), 41 deletions(-)
---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260310-vcnl4000-regulators-bcf1b8a01ce6

Best regards,
-- 
Erikas Bitovtas <xerikasxx@gmail.com>

