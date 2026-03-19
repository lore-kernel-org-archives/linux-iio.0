Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF33CD8D8
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921552; cv=none; b=SSg8a30xsim+g2Bf5lVBzT7t6+78weHvu99ZL6Fbh2Kzwx6LajKyPQop8V2mUwVm0vFTtTQtNsMao+Q6wDbkowcX8ohR8AxJAkTWwPDRleIkwVxDHtG4vfkmEe1rRyuFrPtrugPwSsYoXi5IPWVgza1NlvRbCyqF2zCJBwLLru0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921552; c=relaxed/simple;
	bh=1E4pd2YlmrhsMWoBYpF9Kx2qDHKMBYeRsjxeemOUgUs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t8XuNaP+a3Mg+mxXF+XJsL0rjCGpAFJUVaXN5f7QKREpVB+tpL+7ZgICR0sW+jFQfD0WSxOCtFucqfiEQyUc8TQspMCOd+x942gJUQYaVAH6+adB+eahYEEzm4kX13Di4vP4xZJ2yj3irfAVlUgfwgptk6wHfDJbUH2uENQma00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/ju+rrn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/ju+rrn"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-667cc4ec065so1010538a12.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773921547; x=1774526347; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAgP3WIG5lWDJY/O2OUHFGAnFa87nCTWJrnk0yHPluI=;
        b=C/ju+rrn+3ZRpWK5U7+UOtxDkEUI6N7ZTUOGO9KzRKyAfBNwGncXU9LwRat4TkLdrW
         KGU3FRJgpcB/gp6BlbU841r9iZK9R5NOrDhTqG0lURWXqQCOZzMcqmjytj44f3aooFCv
         DWdtK6h+7r8bPBC8ndl7mfXPaDPSGZOdUlZxSPeF3YyaTDs9VsrAexITvPczr6OM3nJE
         HFom6rrxCXvk4nZbcLlct0mJ5DWoffDC7DFjGE9OwrPc7C1XfBpaETo1dlV9u8yHhOHE
         bU8k5sTTvph8sU8RxX57LUktnCyCKAm7SSHv63zl1Tw8rhWUVXhMEi5rZj97vs49pgQr
         +IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921547; x=1774526347;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAgP3WIG5lWDJY/O2OUHFGAnFa87nCTWJrnk0yHPluI=;
        b=s4AFlY00MthdtY1oSQrrY+8rb3XFYz8xIfMBVnqOisTPcRRjSgUWR/4CVEu43ywTWl
         4//B6rtn2qKGRg7P9ZqknsFDo6abNJrjTeLLmP0Gw3U1ABwR08O7WrJAvlMslodg/ZHs
         h7xuJHg0o0++hFebLIxN0P7WUWZGoOIPHUbNLqYBoJwsywOLfij9ZhlS5CM3RD4milW5
         iM0yWO9NsLeJTsO1R1sYzTLyimXmRRf4UD7Wei+C437vMKefl7QgQKGC6/LtpOhVY8eG
         tj0yuRUNAgVRRFqj6WssEiH9wA3ym01WEu4YvBbKrPxuwNd53XB4SsF5DWPcBaHFejzq
         ympg==
X-Gm-Message-State: AOJu0Yz+df5o72pJopytOM1NMKwwT3GDIozEPuOd0GovMTglawT7403s
	J+AXO43gPndAXg+Gd9QrT1+KO6qPlHifCmFUkjb5Dm0CPAbuMsT/jjwY
X-Gm-Gg: ATEYQzxCm1Kw2E9vmK6sdTQVbnWGGDkAyYg4/ybY7rUwo/cleSBy2jkziGecwKpiDnQ
	PjDJDXMjykiVdmBBlT4UU0vVKq3E2hx9VlJHJFrYGur8c1B2TO021YXnmCqlnrS/2tEuwn0L56V
	UH3M7nVW4BZI+AGsrbZSOou31e+MqPXfZS7RWVQKLc/jT2TGF0VKxYZV2CqF5I5WmZxupad94dm
	7qGoLDLLBzn0/eD8yiSYXys08RR6km9WAW51srDnqcf5DuyLDF0ecDuBmFSZa8aO+UvCV2nIk9t
	VAnN2jnCwI9LQvZ24XN6EPdoDLjgv1sOtbiU614zEPtthEq0Zws4djibeQDiPgIa7YOt2bB7+xw
	MB/iC/JPHGcKAGWvSaI23HqGtAa+aZQnJ223kr520sugHW/jrlNO3YYzVLmtLS9hRAh78Es//ER
	U464OpgZimrfnnMnlLw9/2q70ffg==
X-Received: by 2002:a17:907:60d5:b0:b97:b379:b3fa with SMTP id a640c23a62f3a-b97f4aa62dfmr468806566b.39.1773921546437;
        Thu, 19 Mar 2026 04:59:06 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm461399166b.42.2026.03.19.04.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:59:05 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v5 0/8] iio: light: vcnl4000: add regulator support
Date: Thu, 19 Mar 2026 13:58:38 +0200
Message-Id: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTWrEMAwF4KsMXtdF/q3pqvcoXViKkjFkkmK3p
 mXI3asZKIQhyyfe+3RVjWvhpl5PV1W5l1bWRUJ4Oik652ViXQbJyoKN4AzoTsvsAUBXnr7n/LX
 WppFGgymDIY5Klp+Vx/JzV98/JJ9Lk97v/Uk3t+u/Zw69bjToGFEaiThE9zZdcpmfab2om9ft3
 rDHhhXD4sCIhBhSfjTc3vDHhhPDkc8+DQ7iS3w0/N6Ix4YXIwU/kuU8Bo97Y9u2P0e2b9iCAQA
 A
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
      iio: light: vcnl4000: replace mutex_init with devm_mutex_init
      iio: light: vcnl4000: remove error messages for trigger and irq
      iio: light: vcnl4000: use variables for I2C client and device instances
      iio: light: vcnl4000: remove redundant check for proximity-near-level
      iio: light: vcnl4000: add support for regulators

 .../bindings/iio/light/vishay,vcnl4000.yaml        |  7 ++
 drivers/iio/light/vcnl4000.c                       | 90 ++++++++++++----------
 2 files changed, 56 insertions(+), 41 deletions(-)
---
base-commit: 8e42d2514a7e8eb8d740d0ba82339dd6c0b6463f
change-id: 20260310-vcnl4000-regulators-bcf1b8a01ce6

Best regards,
-- 
Erikas Bitovtas <xerikasxx@gmail.com>

