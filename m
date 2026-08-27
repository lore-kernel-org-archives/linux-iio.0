Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205893CBE74
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869420; cv=none; b=BQEr6yewfvNOY7Nnnd69qdvVpfW1DzWkb3LnzkG/1dqWZXRMRr/0LSKP5kECipK4ADlt6Mw5bRhcy/EGw5Kz6fJk4N94mct60+HBp7ThMKCKXJPyRGkDtUEoWLvmcU6dM1WuiioAypyuDvMN/k2mTC4xc45pqaiWR0OkS5tdjmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869420; c=relaxed/simple;
	bh=CU+3CeQeSyl84T7ssVpwO5RVy8FXiXJ4UIzbY7uzclI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TxrzhGZnLDZgGrWBWJr7MMBVBmdEZNIh7VbHgVsYD+ZgJDI9LNkkeyEOZtbyR640tRjDFh6FpikhX5VfQFNIQ5eQgL6TkTUYD1ezSO0cHYcLbSwkv8+1d9/2tbxkPBtf/aeCUSkkz3sHv4B5UnENWwaMG+pM+PIMcwjjIoIsshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=K4WKKXtT; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="K4WKKXtT"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-45837e52d8aso565012fac.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787869409; x=1788474209; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PI0Dlppjtb4LCn7FjqF+z6N5cgNpnCmywe6Jfjsp3Jo=;
        b=K4WKKXtT1ntfzQ+mcXo701LwlstwLHQv1B6YVHaWf7c7Mg7FJj81B6acYhzfKkXbF9
         gRb3OX+scBabPSjPDCAg+cgSFAGx1v/XhBoEpoqwCglBrzMzSppH9nWZMX4HVQN1omFh
         m5Qry/OzQ6jMHTMbhjFpt8yqwKInVfDBeEXrh16mjnnKxTUp9P0q7PD39rN9HuonZjw0
         URhmr7cPCtsivjRlWGWL4CTiy4pEFeobofKaHWj6MpYmIu/ZA0rSYF3Y5lqCC8vIztQk
         dSYzuXc7PD1tppmjIKnj3RlEt9Uv5UquLBsgCu+lRPja75bytLtnAAswBCHca7vLEKtc
         leiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869409; x=1788474209;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PI0Dlppjtb4LCn7FjqF+z6N5cgNpnCmywe6Jfjsp3Jo=;
        b=WgUsJ8HRseSnJLPJ/12e0UyAaq9vKIOcz1zfqN4SsW97fubRYOgTWX0R2qMr+cTO3v
         mfMrVRdMhkSfo5hgj0tnf+inDgAMry1qTazxPG/ZAWboMy1hLMsHHR5XkI92D1UjVQhj
         2I5qaxF1/VNr0AiaP93kYOlenB6oEBu2YVavb8WaQnzkBlI7DzpGOUj2f/aO0WZ8ojyz
         +rqRq7fzOZURo4U2xoWXVeIvS59E86pkOOiMpfc3ZbPK6sRAe3oKMEdE90ScMNCju2p2
         wfy/t4iJMFxI8nHUG+LQ98yHQ2aihuYf/KJ0xGw42+py9L/Nrbuz+5wah0paimn/4qXs
         T0Fg==
X-Forwarded-Encrypted: i=1; AHgh+RpoDS7FqqiIX+HEl0cXQDYO3iZCtCelDU/YwKEqxhbcp15FSk0Usm+o3uuq7OR58u8JakSn82Ne1jU=@vger.kernel.org
X-Gm-Message-State: AFuF++mrlHptgrPz1ztLU+cV0a1OaojPtgED6DolOLFWTZ55Tcw6mnlp
	pYCDk53Hgbnnx7JwrQuK40Kt7fwxc0NeD+03U8ULTASot9WSQr3o7Bzi4iEFpffLXZQ=
X-Gm-Gg: AR+sD12Pq89InOI4acSRif4fJgeL7iw3CqxG7gVy2fdV6I+l//DhfiiwGoSpInr0EVM
	kPrSHdPS4jXGpMoLnLYPmzGOjdkJfH66QPG4EdPKrmwLPHB49x5/FcKq6r3H9pgpjqwSjhAhsNN
	sqoFywKGtAKRz7DGaoC6Ej5loGn9cX4rr/B1DV6etJCpIhJBmsGdvGZH5//HoKJjuTAlk+2UvV0
	xHfRv5sbFTPlG/WCMSh5xEUepBkWJL361L21xTUkaz7p6Rxo1wJbhgX0czJIT/nq9NTF1+2Bbtx
	KAHte7vXrH7cMvS94tfb9LjKJjm0NQxGaTRlj3nfaGowlCbQXVmrklD1yrvyHmDPk5tVr4b5LUN
	o9wp1kPw7fOMuB3cjb5xmkmwvDNuyIowr4YQcYtUaxNlvRM3zud9dOe+yBRoyEPCgu+W0yZ55AW
	EWVg8aNmUJSgbZrmxyFn1HBF2HHDkXvEXEnqmWbkgLlEJ7jSETRJ52P/0XKzBnf5a+HQ==
X-Received: by 2002:a05:6871:5290:b0:43d:38f1:854e with SMTP id 586e51a60fabf-46837797c55mr3125358fac.16.1787869408936;
        Thu, 27 Aug 2026 15:23:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d288:6f77:e285:6925])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46736445d6csm3176880fac.2.2026.08.27.15.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:23:28 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v4 0/3] iio: adc: ti-ads112c14: continuous mode support
Date: Thu, 27 Aug 2026 17:22:52 -0500
Message-Id: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XQS07DMBAG4KtEXmPiR+qkXXEPxMKPSTuIxMV2I
 qoqd2eaIoGqLsrKGnnm+8c+swwJIbNddWYJZswYRyqap4r5gx33wDFQzZRQRrSq4YiR2+B5QTq
 ylMrLhvs4FhynOGU+xAA8BLnpRLtpjNgyoo4JevxaY17frnWe3Dv4crF/OhJ8TpRfrm3M2QwED
 wOWXUXzuU4wRLqtaYWaTkrcs4t2wFxiOq1vmOU6/L91Z8kF34ITrrVNL5R4cfb0gS7BMy2wZsz
 qj6vlg64iF5zUweoOut7fcfWvSz/2oKvJbQ2IoAUYb9yNuyzLN0MeMfvZAQAA
X-Change-ID: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2655; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=CU+3CeQeSyl84T7ssVpwO5RVy8FXiXJ4UIzbY7uzclI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqkLjE2IaUQwox4nreds1+rkunu6WcObYNk2kvs
 8uw7LRKdS2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapC4xAAKCRDCzCAB/wGP
 wGzsB/96A+pDbOFx4/6ayOJNugPVRF1VuPSwufBl8F6fw9uX5/32sMUZtPHyf/ftbAyhviV4lCx
 7vlORlT11Job8b6oEdKCOTBavv/wDZ0neQuJIxSaH5ufn4ZHNhaeX+e+EMt98foXCnAMH2yp7rR
 EhssY2tFvtFGhqV2mEWeh0GJySww7YqFe+ZjYMz8rvmhOcZE6zIpypPHk2Bmsnm+HqbZPF4HEgV
 cRe9EmekOPr1L1BhKIdX1eiJ4TfZSiNCFmzqvfbUzs0/JSUFkPDW6PV5KsQZynFXo6pNfU2clRP
 g0Ms2LYVdsRir/1gLGzFA38HBxipOS+SyQfN6tkG14DGCQep
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The TI ADS112C14 ADC has a continuous mode where it can trigger
conversions using its own clock and signals that data is ready using
the /DRDY line. This allows capturing data at higher rates since it
avoids the settling time between conversions. But it is limited to only
being able to sample one channel at a time.

Users will be able to select between continuous and single-shot mode
for buffered reads by selecting the trigger. If the "own" trigger from
the /DRDY interrupt is selected, continuous mode will be used. Or if
some other (software) trigger is selected, single-shot mode will be used
as was already implemented before this series.

Supporting open-drain /DRDY is deferred for future work. In simple cases
we have just done a `drive-open-drain` DT property for this, but on this
chip there is more than one pin (GPIO, FAULT interrupt) that could also
need to be open-drain and not all at the same time.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
Changes in v4:
- Check for the "interrupt-names" property instead of "interrupts" to
  detect the /DRDY interrupt so that it works on ACPI systems too.
- Add ads112c14_first_active_channel() helper instead of duplicating the
  find_first_bit() lookup.
- Use regmap_update_bits() with FIELD_PREP() instead of
  regmap_assign_bits() for the CONV_MODE field.
- Link to v3: https://patch.msgid.link/20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com

Changes in v3:
- Leave DRDY interrupt always enabled.
- Link to v2: https://patch.msgid.link/20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com

Changes in v2:
- Split out irq and poll code paths into separate functions.
- Split refactoring into separate patch.
- Use iio_validate_scan_mask_onehot().
- Just return immediately on error in buffer_predisable().
- Don't set default trigger.
- Code style improvements.
- Fixed null pointer dereference bug when no trigger.
- Link to v1: https://patch.msgid.link/20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com

---
David Lechner (TI) (3):
      iio: adc: ti-ads112c14: add DRDY interrupt support
      iio: adc: ti-ads112c14: create data read helper functions
      iio: adc: ti-ads112c14: add continuous mode support

 drivers/iio/adc/ti-ads112c14.c | 288 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 259 insertions(+), 29 deletions(-)
---
base-commit: 22359083a9e74d538ce383d5c0ee30cc20182187
change-id: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

