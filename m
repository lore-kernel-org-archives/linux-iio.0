Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6673806DD
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022303; cv=none; b=StxBQaFgiBn23OdHckx4POmrdZLIHMDbpqjlVefobvADxY6NHCY/c6oWeR15UmCPBkghF56x27qElw7eYQ/fvHqfYoQK3QFlyGNQOyzekBXXeQW6JCIqS0XtqXMU1NFYMYCeWJWBAVByTwmYn5QkAgfGGOfRpWq9ZkoCe7mVIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022303; c=relaxed/simple;
	bh=3YzZMhV2Kq9lLtJSLI346uWkJqVEa6j+MtFmvDNeOqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpopOjdLJbc24+C7Z0Yui96iupOJoEV2ittM77GhWtje1Se0mXLQA5xnCxqhwBxzPwsDZHOOsM8MmbqXVWYdsacejpsK2zBKmVwkIDDbku3QBWQA77e9o/NnprgxsPkCK8pLxQKzJpfqDyCbAOSOD/8UhNUmc0rsqyJp5mA0juI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFf22cuf; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFf22cuf"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8623b1e7cb2so49422387b3.1
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022300; x=1789627100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKnrAbcjeOnk62ec4y5R13bg9Rx0FTj94sh3BmJh88o=;
        b=UFf22cuftVa9BulfSEJ1XmYo3xpz5sXwwzq9qkkDc2Yl4cTHGEg28jcuE8xPYRE2Hd
         Bi0ml8Y8DzEBEyFHN6Hbsp0pJd9ogtkAS9dSnA/M8hAVxtI4t56LxeYtaziYtEqHXLY+
         mXg/YZhs49AYBZGYadacIeMnqsGG7fWjW8qiqkfOtTZpTtsCGiq48qzKu9FesW6hPyb/
         ofvbKZQYgJ1Tgz7vztXXS+peEYnSIVvFJUl49TXiCfFQaE7FSrdByFUaJee0BgDl+cSi
         eSjkmmdGA8Tz7IFziqHJfKtrH7iR2MDV+b8zoy95k1ofkBkoDWGWtP6k3qCU9W7I+ZuN
         kjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022300; x=1789627100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKnrAbcjeOnk62ec4y5R13bg9Rx0FTj94sh3BmJh88o=;
        b=EPjHk+STyQC/7NhQioNvgLy+O6/9Ga4xA3ws/LOFuIZLOIxVTE59ozsnE18LvcC4nf
         kYnE3EvwoyK137+edjGJqJl7m+1Q06iNovOQVEo6VUMgFLSzMe8YsSNQCFc9MODvMHtt
         mAAXkYgKiM9FoModcyUTK/Lf8iKc0ct2rZrpruoC/vfTBK7TYYUJGsj2R81yBIr0l0L9
         wSrfN94rIg67Ui6sjtjaq2QGmNXpVNB9yio0Cd/blenT44mR/6AOBebrEX1nCZJXU9Y2
         ZaJlV5Uo/yaa94K+zXTQ07BM+/EprAngIM5YjG8YbdLID0nvM+wJi/rbkgGp57GHcpLF
         +XDA==
X-Forwarded-Encrypted: i=1; AKwUvBzO2nOVppuu5rVBOQEhR/Bo2W6gafsFLBSEXznB+ei2EqJihLNPFNCAnagMr8uHsJQ3hfz6EfMWU8E=@vger.kernel.org
X-Gm-Message-State: AFuF++kNqzDnKTWjISRB5KUQYRpYqFc31ihq8yr4uxjwAt08YG15ft9D
	R66INDV8YGPqcDFysjr0f9+3kFDIJmsfnCiyYbc8DtFDYlJwDkhmdPVP
X-Gm-Gg: AYBFou2LOzYMOOBm7NV7Pda4obQQHT3ZJVufO0An4lmlYqXmGJgi3Tbmj36ODe5ZtON
	Fjz6tGN67e6e9eH+c94stFWXcWl9McbdCQ6YC++3A5ag78MRd0LTAE+dEhbqo0WT7udvr33CzYE
	zTPxbPfp/WLrvynOgUru/CDXC8YPmSYjKD5pB9kDIbWaE1xjP0qSFajymSw63rp3LWIk6VVEzCX
	Q9R3uYvKg5TqocgH7e0od5WgDSZrlyAo9EY6ADPstaJP6nTeuHjCcnOpf5L+j7syUx+35ELkj6D
	BCuW0r3Mc+mPwd9tfn/LMFZS5qAJGC4OHPW2M72tMus3AE2Vl+0T41tbprrWepo7a5J1VwMRJdg
	io541I4ppgcWCSVs1GKUSv+ohEtSg9Qx+qy/D3ckc9CudkwHrPJGe1DbnrEaln0Lj5SmveUs8eo
	/HOdBTO7mFP9UV41mqa9Hp5cIaLqdRqPLay+Vf+akgUFsT4H56+UNcMg==
X-Received: by 2002:a05:690c:31a:b0:80d:964f:88fd with SMTP id 00721157ae682-871221a70cbmr173607087b3.5.1789022300655;
        Wed, 09 Sep 2026 23:38:20 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-873194f76e3sm105440077b3.5.2026.09.09.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:38:19 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: [PATCH v3 0/2] Add support for AS7343 multi-spectral sensor
Date: Wed,  9 Sep 2026 23:38:11 -0700
Message-ID: <20260910063813.56419-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds initial support for the AMS AS7343 14-channel
multi-spectral sensor.

The sensor has 14 optical channels (11 visible + NIR + clear +
flicker) in total. This initial driver supports reading raw counts
from all 12 spectral channels (11 visible + NIR) via sysfs and basic
power management.

Not yet supported:
- Configurable integration time and gain
- Interrupt support
- Clear (VIS) channel and flicker detection

Patch 1 adds device tree bindings.
Patch 2 adds the driver.

Testing was performed on a Raspberry Pi 4.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf

Changes in v3:
  - Fix gpio description and example in dt.
  - Only start measurements after suspend action has been registered.
  - Add a mutex and pm_runtime_resume_and_get before reading measurements.

Changes in v2:
  - Add the LDR, the interrupt pin, and the GPIO pin to the dt bindings.
  - Adjust the default gain to x256 and integration time to 50.1ms as
  recommended by the datasheet.
  - Use read_label instead of .extend
  - Remove all unused scan_index related constants.

Chang Yu (2):
  dt-bindings: iio: light: add as7343
  iio: light: add AS7343 multi-spectral sensor driver

 .../bindings/iio/light/ams,as7343.yaml        |  72 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/as7343.c                    | 397 ++++++++++++++++++
 5 files changed, 488 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
 create mode 100644 drivers/iio/light/as7343.c

-- 
2.55.0

