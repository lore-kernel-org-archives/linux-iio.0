Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5A37B032
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779659788; cv=none; b=rQz6c+VBfAAxO/B5ShMfAZnTY86aO1fBbNBcrK15bHlEo2sazLN71qNLeLG0yAhJBGv8OEorMAhToP5xjeH6mMY0kxmUCuHX2VyZzyxuTOa6sjqTtDPLrp+EcTiMt53UaP3Ddz0/RDBfx8eyN0L71r1jgDLI9qzlcjWUSaUkpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779659788; c=relaxed/simple;
	bh=ZjtjQ8HLOvTX1kreIR9PyPdk8M30Xcoy+KwL0MOzNYI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LRFIXJPFouspe+PWc/AfPqg/NxVbU2zRjMauKDDbVeJABDpToMry8Miq7IJw2/qL/8CxQW5NcdlWq/BCCEyo0lKDkrYCyUZF2ttQe/8NWc3io6gEmUBM8cGr9TKqvbsKHNIhJS3+WilmnFdS993S/4siyGFfAV1zioXirwLwgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjq3r60J; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjq3r60J"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso77486785e9.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779659785; x=1780264585; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5tQZEQs5yi4nrMOKCX6eMf4Mq1wrqi0TZphUi7s8UY=;
        b=qjq3r60J7FlFJuTUBCdKcS55kCX33yDfgOpIb9lyNFpmcHg/qtrRouWLsQpXvdBZcl
         /j+SEKVBLk0BuJJOSuila/HyV0MDOyMescTxM7Gkw1ij70iZDPNVs9bxfv7LQcv552gD
         8stXpR9ULkSV50Pncm+YzfRL4Z2sJ+tAFEMFtgk70dDZ6ERvhiEjLNgJAay19BSGsv7N
         D9CRnE/Z9E3OC7hcX9n3WxqKC/UJ5IKxcRl2HAJGJA8sXDEBLX+g+r5uaKZ4hLYpkbcF
         Rab+MMExCy7wuRML1n3hbngsWqvljV1c79QDN5yybfK2lc8QnJFGn/dYn4507uoCnpzp
         SpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779659785; x=1780264585;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5tQZEQs5yi4nrMOKCX6eMf4Mq1wrqi0TZphUi7s8UY=;
        b=pImi1qY/pccHxqq+R0kzXBdpuyLDivmqu7Yzh2k8Cx+dkBAzIgCObir+nYvGDjt9JO
         BqOSEfs3s1VlnzdCZKPPVQjDJvOemxaG0Fc/WS3hyxFPuEtBJ3k72T01KO5m4uE6dGCk
         9SifGHZg8nzdfL3pMNamIWddJMjTnj4U4seHaWDalIBvj7Ebgt/0nOsZho6E35kaxzls
         o5M5JIVsz0t3rULz2fY8YKWpAzNcm7SCbfKLpGb6tzSO5IO70xRiLdQiRwQO+wEligLy
         Q8gwaMX94/tpE9c4XUN8r8+bWuk56gadpA0Wh8U2h8zbBYPpQW5YxU6UbaGTiHucT8JO
         BpsA==
X-Gm-Message-State: AOJu0YzUrZwDnsXm07hGd0jenZmOCQX+nSg9BnkOdRE9fpgBUOHmxouq
	/RA1kmNBYN05fEvG9ET1oBPgmf4DkKE0MvahggTtn/O/gXrCi+/hlqOd
X-Gm-Gg: Acq92OHvYmjCSbox4aAp2qhUe74/vl2q76JsmDR6Z6if3uTnXiYvQ6HDIlRAl8Q11Vg
	Kmc7k79CSCuRBJytJ4CJ8GXDoTKWR3r+TZKHCCxpWaeq1cHwIYQz2lf3j/l6OSsu+6mdjKcmpro
	2wsAYe8iweb9U0KSROJGILn0f0w1vyfj/g1w+oWnnmW03Pl8jPn8CTz1Ks02NLTUGW0mymVDoxz
	bdbFc0iF/zT/N/c65o4lYgZ5+w8DgQgHnDOf3qJlv7FwnM5hOI6AmXd3+U0CQjlN/V/a2EbnvLx
	j6Ih/U1TGT+DBZEgR4HnFVVG+kPZEeAFj5nge7esr4PoQ3tYoG3qr5m3oI90m8MqeprQmpCetfK
	DxfjYhYFT+3Lvig/hnWQRw6vTROnd0lC6m1LsmPBeqVQesGh8zl5W3/2sbSR5qWs2dZezN1gngd
	+8FntRTQdAaO/sLJKLNI8lM5d3vBv6NKW9WScl5gqKxwRik+lG0aMs006Sh7tjRatl7P5m4Q==
X-Received: by 2002:a05:600c:3d96:b0:490:5429:1513 with SMTP id 5b1f17b1804b1-49054291bbamr116865515e9.6.1779659785202;
        Sun, 24 May 2026 14:56:25 -0700 (PDT)
Received: from [127.0.1.1] (213-225-2-150.nat.highway.a1.net. [213.225.2.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm300779285e9.7.2026.05.24.14.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 14:56:24 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/4] iio: light: add support for veml6031x00 ALS series
Date: Sun, 24 May 2026 23:53:54 +0200
Message-Id: <20260524-veml6031x00-v3-0-29165609b2b5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHJzE2oC/1XMywrCMBCF4VcpWRuZSeJIXfke4mJskzbQG4mES
 um7mxZddHkO/N8iog3eRnErFhFs8tGPQx76VIiq5aGx0td5CwXKIEIpk+07Ao0zgGQuDemagQy
 LXEzBOj/v2uOZd+vjewyfHU+4vT9H0cFJKEEado5JvZx19b3p2XfnauzF5iT1bwkuqI+t2tor6
 IqJkPHQruv6BXBLtOTiAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779659783; l=5134;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=ZjtjQ8HLOvTX1kreIR9PyPdk8M30Xcoy+KwL0MOzNYI=;
 b=KgOEIunjIfFvwylamDdqRhkCrlJUHtyVDvBnK87/AVWHC+6KhwZqsar9qbXhbIaPJ5sja1Xam
 V4AhIyLdG/iCWzN2TeEviAx5yKc7AxEfOTU+MF2c/xZgUR8D0R3HBSu
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

Changes in v3:
- Move veml6030 fixes to a separate patch stack.
- Use C99 initializers for i2c_device_id.
- Split driver code into multiple patches to ease its review.
- Rework locking to get rid of atomic increment/decrement ops.
- Fix error paths in pm_runtime operations.
- Use IIO_DEV_ACQUIRE_DIRECT_MODE for single read/write ops.
- Link to v2: https://lore.kernel.org/r/20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com

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
      dt-bindings: iio: light: veml6030: add veml6031x00 ALS series
      iio: light: add support for veml6031x00 ALS series
      iio: light: veml6031x00: add support for triggered buffers
      iio: light: veml6031x00: add support for events and trigger

 .../bindings/iio/light/vishay,veml6030.yaml        |   23 +-
 MAINTAINERS                                        |    6 +
 drivers/iio/light/Kconfig                          |   14 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/veml6031x00.c                    | 1197 ++++++++++++++++++++
 5 files changed, 1240 insertions(+), 1 deletion(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20241109-veml6031x00-aa9463da064a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

