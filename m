Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223A244665
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647033; cv=none; b=AHMFrup+bXc7j2mjhlH7WxTRI7yJXVeAXzZ2zoCMR8b7y1fOQfcDlI58Gm2WovkxYD1EskUSMlDStTgr7NQyYxofSe5jFArRn1WAmG+ZnauMjLHTdSLSURzRofxZcSDIx8NpcuoxdeOzqkpDEninBc3gKdSj4UUq0W9t6gXMeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647033; c=relaxed/simple;
	bh=KQ9ifxubGw3t6jtXoH0IfLlgMwKpuQ8vYfyn9qOFKb8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y2PQ6HdOMMt1TrkDIUEr6aOsgZYvXs5YdsmV9z/d5n380eTk6FxKss+qaDC1m9rVV0PgB24TsLhojU6dpJqEMxsVgUf3kHSDPHzIfUvqHiCyWQkIFl1s0xCMiz3wzOpgYp3AqGp1BfdXfEBS9oiFsc8DXhII4UGqzDFrD4VVAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si+p7Dus; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si+p7Dus"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-790992528f6so40596887b3.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 06:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770647032; x=1771251832; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKsGnQMxLXhyEu5Sx6xOkySlmfKndn8CBckTO+kUQjQ=;
        b=Si+p7Dus9imKj7ZqWlHjM09LXIwS3xn4PDdGtLax0Fa2Fm2PDnsXOFsPluEjuDbX/c
         JMvMq5ZCaEfUHmZS9BWmKrmzp6rgUhGlVcfIAAJPcC20oxiI6Ces9o4dTyk0CZRpjr+X
         qsv2fg/VoWKkkJyDs42dFwP482MEcjQ0jX1+wZXkk4JFAnwmd/k3J1Vt4GtLEdJQW+SZ
         RrcauPhIwCcUgswThgdNPVND+o3b51mODGxswnzbrB7+P1beJHQpnnQ07nGHup15kx42
         8lV0f6UIlFwLy8JFYyCx1Pry7bXfMTKvOHmWhaoFd31FunCqW35v4LB69EDvWIJ9QEjc
         Q5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770647032; x=1771251832;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKsGnQMxLXhyEu5Sx6xOkySlmfKndn8CBckTO+kUQjQ=;
        b=SVFcE4Mx87KRVBcIQAoQiUhAziMIn2SwYmbrZ/Lx3sjD2cdKEnF1zJw2cGmdtpk0iF
         jhzDAaJUM5kxlUmSiGdn27nQ/ykBXHO7LGvg/+XdbLHnRrMNXffhVcmnOUaOr7Iqv1dc
         l9LZEKMWwPrPw52sWtZRtjN2Jm1z4xoTQTXwfNvsTgZf438wKd5Nd1vHCr8LTi/eTIJ3
         m9EttRgyF82nhfw3lxvB90KCmg7qirIED5FUmDNsYqeebSG0eKlA32TxgXjCvCCAP0mh
         +liPDDyNGhT62hSi5saFbcRIFzXIgIOhcMHKpmtCtkOLBOyW9Oqx3eW6rG3lxTDSOO9P
         pdQw==
X-Gm-Message-State: AOJu0YxRihl86hMNYjrz+61b8IVirbRpN//HIiQuuOuajc3alZC0Pj7i
	kbQ7e0sYpSj+H4CCSSkppr4noScz0CZbs/znBMZbv7wMjkgJuZb4M4MM
X-Gm-Gg: AZuq6aJzA2ZD8hsaZXQl9vT14CBpKJUtPIWkykTTr8M4BYbMweYdbyfCsPfHYFnlzbc
	+OWsFUE6RiDmCBS4Z8IsnpYzH+nWvio9+NRhIJCEVNZwzs57krbNirogWkrD/fZGykWUZxmVqgE
	IUq4WZ1IslVtUerh8Ja6Y7bwPOKc8I69HvT2B5XQGuuNh6xveIFdMkj49TmRoITPO8Z12/Tw+9I
	N2I0bvGCSMX/eo0QYxzIDvcpRzs5k66dEkA8qfW6jS5uU2RPT53KSFqGf5oaFI4Z7R5g+aBfjhO
	TYbYY0wy/un9yIxfOxD3BcoDMzwZlxp80R4CaGwkto2PeEQxhzLPxqWzOtxyiSFVycmQXtkl4Rn
	g8gU4BkYN8+25OBQ/QcXWCUhMndmf51R10LMTK7c6LPJKHRBb8uVfdCKklgf+Nyx5l4F1YyHniD
	KhDgnlwtxE5VF0dA==
X-Received: by 2002:a05:690c:e352:b0:796:45d4:9e67 with SMTP id 00721157ae682-79645d4b021mr30943597b3.64.1770647032236;
        Mon, 09 Feb 2026 06:23:52 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a0467easm92497947b3.13.2026.02.09.06.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:23:51 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v2 0/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
Date: Mon, 09 Feb 2026 16:23:40 +0200
Message-Id: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDIwND3eRcYzMzCzPdtGTzRAtjC9M0w+QUJaDqgqLUtMwKsEnRsbW1AEi
 X8l5ZAAAA
X-Change-ID: 20260201-cm36686-fc7a8385f1cd
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

This patch series adds support for Capella cm36686 and cm36672p ambient
light and proximity sensors.

Capella cm36686 is a combined ambient light and proximity sensor with
adjustable integration time, interrupt and hysteresis support. It has
the slave address of 0x60. cm36672p is fully compatible with cm36686,
except that it is a proximity-only sensor.

Unfortunately, datasheets for these sensors are not publicly
available. This code is based on Android downstream kernels for devices
which did use these sensors and a previous submission for cm36672p to
mailing lists:
https://github.com/LineageOS/android_kernel_xiaomi_msm8992/blob/cm-14.1/drivers/iio/light/cm36686.c
https://github.com/shakalaca/ASUS_ZenFone_ZD551KL/blob/android-6.0/kernel/drivers/input/misc/cm36283.c
https://lore.kernel.org/linux-iio/1465462845-1571-1-git-send-email-capellamicro@gmail.com/

The following code has been tested on Asus ZenFone 2 Laser/Selfie, which
uses cm36686 as its ambient light and proximity sensor.

This is my first driver on Linux, so I appreciate all the feedback and
patience I receive.

Changes since v1:
- Add copyright information.
- Sort includes in alphabetical order.
- Add trailing commas.
- Remove blank spaces where unnecessary.
- Add a fallback for capella,cm36686 compatible.
- Make power supplies required.
- Add '-microamp' suffix for capella,proximity-led-current.
- Replace local caching and i2c_smbus calls with regmap API.
- Make interrupt optional.
- Add action or reset only after setup is done.
- Replace mutex_[un]lock calls with guard(mutex)
- Add comments on where mutex is used.
- Add comments on proximity register defaults.
- Remove default proximity sensor duty ratio and integration time. Those
  were taken from the testing device and had no real reason to be there.
- Replace dev_err_probe on device's part ID with a warning.
- Replace chip->supplies property with a single
  devm_regulator_bulk_get_enable call.
- Use individual structs instead of array-style device info
- Remove enums which are no longer used.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Erikas Bitovtas (2):
      dt-bindings: Add binding document for cm36686
      iio: light: Add support for Capella cm36686 and cm36672p sensors

 .../bindings/iio/light/capella,cm36686.yaml        |  97 +++
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/cm36686.c                        | 940 +++++++++++++++++++++
 4 files changed, 1049 insertions(+)
---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260201-cm36686-fc7a8385f1cd

Best regards,
-- 
Erikas Bitovtas <xerikasxx@gmail.com>

