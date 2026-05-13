Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86B18D658
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 04:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647812; cv=none; b=TCSTOuLBLBCHQaQ2YxS9l39JPk2pxbn8VDbwYaR6t57xh3aGkINnld1uUvjvW8WLhxf4TV35owCpc4yht/eRpxUuTSl1C5/+K1semydn5QMbQ/18CYwP2NH8BQEZCL3HRflzYMPIUH78oNdHswPqCCkXPxVisqdGna8I6EDDEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647812; c=relaxed/simple;
	bh=tgUlyJjbrsKtJEn1UZKio0glqU4Bcdo3vZkqYUogHaA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hh7VDzxvd/JwZyDD6QSEy4GRYqiXvORQNbt+0FkTCvxboY3VHvQctNoJpmAavYmvjTONJkk2ypFxB4YqttJyqvvRJkxAkUscv1l/9UzuDpcNluotGCLuoB4vd2O6tgns5iWhGya291wU2NadxSszbDLD/H+jCp2msl63lsrls5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShDgcx54; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShDgcx54"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so2771581b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 21:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778647811; x=1779252611; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhcAeUDFPuM5b+QyEqT1qFeyobx3xcRvN5AVcMGYpJE=;
        b=ShDgcx54d752ATu1T4x5zZDE0CCTByBNEGbLJLFFWsw8TcM5vZr4+TvUk4j1HtOJP7
         eKYS2B8jPgok4lE5Z0YcCYtxkXzUNcIOe/VT8ce/0PE2aMb/F9u8kYQS0IUCk+KGTQGz
         m2uYKiYXuqIpEEIazj0QxvjhKvQzB9oyyhERNIZh+FkPcpuL992FccN+YlTyNowScPE1
         I+RBefI2wlk3ZvXD3NDS0yJ/S7GWAZoBHU/QS8R4vHPai9ZuPQjuoJzP+u0LW65MZiFQ
         topfjgI5S1Yu2Ns6Ry8rcg/Tpjf/tRiGVhc9Fa2rdqwC2yqPA4k6s4JOlsW/R8LiXGwI
         VQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778647811; x=1779252611;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhcAeUDFPuM5b+QyEqT1qFeyobx3xcRvN5AVcMGYpJE=;
        b=anMC7BMlYko54XQwYg9LuYVrAGumeY8em0n8M1KC6cr20GCHaPtpR1VHdVSSve2XK1
         J6oIgu97V+bibaq3ad+xf9i+V5fNIa7M8OKH6LZnZ3g2XYme/DH4Tu+g9wB7we5IJ76m
         cQPpob+oog6QLq6nDDC4voFW6tC7V7RJ1Abhn/PCRa/9qRwsVLFWxVBJNL632UqYzMED
         Ui7bGUVI5xtMftIFxaY3B1bmTPvszpNlcRh+cU7qOMbGJKUIXQZ6bGSrK8iil8zMbmED
         xZSM2Cy/gjD1TrW2DiPkVzqc+9b2dV5u3inpZWIFbq0PGu5oSZMam+Jzqctyq5rSp3wX
         Ae+Q==
X-Gm-Message-State: AOJu0YwlCmkiyc4sGewouc45MDanKouXrVeAb+QxGWsobJuEFDggtZZR
	5h6gvKUOmuSp6NaMkpO7jmxLmndu4jNStC0oreBH4ELpCfbHJBIiH7hf
X-Gm-Gg: Acq92OHwMYbg8L9UOiqdzk6PttOpvtR0KwrlOijkFdtXHnig7JodQLj4MOsQKkgen0i
	yBv8XVawoJIzRk+v0Z1Q987b8BGPghwjmi0fX7hIvAXdiQGZq0yW8ejpqiFjExgDsCLLm6kDYp+
	lhhL7yaSouC3Js9nu0W/uz6Nb5jMN+YUFR64ej1xOo2wYHT/GrWF0mDK1M07oLUXZrShUwhWP2G
	89XNeHlF6JIHMHEORitz3+cR7InzpM2BPljIhF4PxXFhl8IMQs1ghzbheG2m7n+ghbfTNk/cCmy
	3L7aPuI4dMwm8sdV9A/gzq9kHl5i7OI0tuEIaIAXqf74/wAE5FxepEPDT4u1dmzXebhp2UyIk3K
	aPRo4f2Pt+ovlSoetLqSFZkYx4V2ZvOcU/aIXIqw+Q5TBbrGLKfTtg3iE+N4f1EMQWY5BLmGpe+
	3UVyEWv87YkrbK7U8KxXXBGmBpPsnizSajWymI
X-Received: by 2002:a05:6a00:4403:b0:837:6bb9:acb7 with SMTP id d2e1a72fcca58-83f03c496aemr1638691b3a.0.1778647810595;
        Tue, 12 May 2026 21:50:10 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965c30ddasm32311914b3a.21.2026.05.12.21.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:50:10 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] iio: light: add support for veml6031x00 ALS series
Date: Wed, 13 May 2026 17:49:40 +1300
Message-Id: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOQCBGoC/1XMywqDMBCF4VeRWTdlEkPArvoexcVUJzrgpSQSL
 JJ3byrddPkfON8BkYNwhFt1QOAkUdalhLlU0I20DKykLw0GjdUaG5V4nhzWekdURI11dU/oLEF
 5vAJ72U/t0ZYeJW5reJ940t/15xj35yStUFnynpx5evb9fZhJpmu3ztDmnD8yPoI3pgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778647803; l=4923;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=tgUlyJjbrsKtJEn1UZKio0glqU4Bcdo3vZkqYUogHaA=;
 b=rIk/cDRH4Eu/wfynMlGZz4CUMg3NrqGBNElLBkDCGsA4QpCWvYAildGD5cbEPDX2DJg/Kuunz
 6OMyp2aqnV1CJcvwZpIMi22WRRmxMHcL1kri6j6Ex+7tsAwA1xwW6Dz
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

These ambient light sensors with I2C interface provide two light
channels (ALS and IR), high/low threshold alarms with configurable
persistence, and a data ready signal.

The devices covered by this driver have the same resolution, and they
share most of their functionality. These are the differences between
them (note that the x belongs to their names, and it is not a wildcard):

 - Device ID: accessible via two 8-byte registers, different values for
   veml6031x00/veml6031x01 and veml60311x00/veml60311x01.
 - I2C address: same grouping, 0x29 and 0x10 I2C addresses.
 - AEC qualification: AEC-Q100 for veml6031x00/veml60311x00 and
   AEC-Q101 for veml6031x01/veml60311x01.

The alarms and the data ready signals share the interrupt pin, and an
interrupt status register must be accessed to identify the source. Such
multiplexing is not new in IIO, and I have followed existing examples
for it. The persistence setting (own attribute) to trigger the alarms
uses the pattern that has already been used for the veml6030.

The device configuration is in general documented in the datasheet and
the application note. There is an exception, though: the activation of
the "active force" mode that is required for the data ready signal must
be carried out in two steps even though the affected bits are located in
the same register: first ALS_AF (active force mode enable) must be set,
and then ALS_TRIG (active force trigger setting) must be enabled. I have
added a brief commentary in the code to explain this behavior, which has
been confirmed by the manufacturer.

The only functionality that has not been implemented yet is the x0.66
gain (and its x0.165 counterpart when PD_DIV=1), which makes the gts
helpers less usable due to the conversions required. It is indeed an
uncommon gain to use (there are x0.5 and x0.125 gains) with no known
use-case at the moment that justifies making adjustments to the gts
helpers or adding artificial conversions to make it work.

This driver has been tested with the four supported devices separately
as well as in pairs where the I2C addresses don't overlap.

I found a couple of issues in veml6030.c while programming this new
driver, which shares some functionality with the former, and I added to
the patch stack.

To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Rishi Gupta <gupt21@gmail.com>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Changes in v2:
- Add commit to fix bug in veml6030.c (channel type when pushing
  events) and remove dead code.
- Use gts helpers to simplify operations.
- Drop unused gain_idx.
- Build INT_MASK as an OR operation of the involved bits.
- Format arrays to follow the desired standard for IIO.
- Directly return function result as the last operation within another
  function instead of 'ret = x; if (ret) return ret; return 0;'.
- Fix some spacing (double space, tab for alignemnt in info struct).
- Use sizeof() for __le16 reg instead of 2.
- Return an error if the part ID could not be read.
- Spell out sd -> shutdown.
- Use devm_mutex_init() instead of mutex_init().
- Avoid using conditional guard, use claim/release instead.
- Access integration times from the global array to get and set the
  integration time instead of using a switch.
- Simplify read of available periods (persistence).
- Drop IRQF_TRIGGER_FALLING in the threaded irq request.
- Add regmap ranges.
- Link to v1: https://lore.kernel.org/r/20241126-veml6031x00-v1-0-4affa62bfefd@gmail.com

---
Javier Carrasco (4):
      iio: light: veml6030: remove unnecessary read of IT index
      iio: light: veml6030: fix channel type when pushing events
      dt-bindings: iio: light: veml6030: add veml6031x00 ALS series
      iio: light: add support for veml6031x00 ALS series

 .../bindings/iio/light/vishay,veml6030.yaml        |   23 +-
 MAINTAINERS                                        |    6 +
 drivers/iio/light/Kconfig                          |   14 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/veml6030.c                       |   14 +-
 drivers/iio/light/veml6031x00.c                    | 1193 ++++++++++++++++++++
 6 files changed, 1242 insertions(+), 9 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20241109-veml6031x00-aa9463da064a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

