Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DA30FF08
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257515; cv=none; b=Bmkz6EhZja4NjjOo0FbWkxwX0H6Wnvf1g4ZNpvglCElIOte/1XGnuMo5aqg70CX05s31Ti+IdOLE18/GlogAwKQ71NPn73lxa54SkWexcCdQZaCfAEHxgOMZySZxblQjCRqtyiqxooc41QOSlVbkV0tWNAStlia7b2fC+PtQ8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257515; c=relaxed/simple;
	bh=lN6fgVEzxvkD5FRzivriJpyJuNu3ZyEHniYxTYxqcWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c5kh75wfcIYQSz/46E3RRR3MnKTxo4yDycssvuntYC39eFD49hhq5Vy43GkIrcWhdVRo4XlJME3lNQoG4T+/2QsMzcSTBVQtLTnUWIwvJTE91hpmUVvv4C5GM9lRiMcFvrJ9Oc3pffODFafH981ENHKfhXyzkrOQyDePxUNdaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVM+SeBN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVM+SeBN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4905529b933so70919365e9.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780257513; x=1780862313; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pCSy1zfOvhUxuZ91rtZd8AGKLsxLUboDSZKK74r6V6c=;
        b=PVM+SeBN1lXdrZuoHecCJ41Kd7eb91Ypc6nXLQ4a94GppGPKR9a+iLpGgcFhxARP9V
         W2y8TQhR7gHF+sITbD7c9QAWR0xlF3Ix/kJt2oGE5iTkmF0hw/+h4yVYCanjmAyON8A8
         6hT9clBCTStoIgPQuCmo1cuTRpoF0iedWWvymdBclhaKe6Yhh/ptZzbzh1d7tTCBOAcU
         wvWG7CAvQ6ycJhkMH7AXxJ/Sn8ybJ2lGLmeBhMgODh+SFbpRgZxLMRUNaWTM60NQOe2g
         UzuH57JKzMpGtwZr0Jw9dK5YYYCNedkLrRVF9crPixRQFY0Ya4ehc/VYiAPViMWmQUsW
         idFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780257513; x=1780862313;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCSy1zfOvhUxuZ91rtZd8AGKLsxLUboDSZKK74r6V6c=;
        b=VSmSiNuT8O/5nLXoicUjB4K0zrEpsncoXwghex5BeCSrzRSVC7odlFkDlbt3lzN78b
         i4sUFD58OAgm8qDnNcl7cXzSVYWiFuIe6Tv6ER9JE9on6Fqva1mJELP1S8mDJwHRYTxT
         4ays8PHb0cEXEYQ+hfY87UEpVejnpmxVKcaiTz+t2SZuSFXphVjT/ojOecli7+KyBzVu
         LbzGZLeRFrheIoFej9y/tGBN58RPIR9YOJCdd+s7stGw/fBbRJFF1+wIKyoDfViPrteK
         J04aJU9fEvAQpm5PVabXEIXQgiKoZYBlkqFkPDsd5ggoXkX9gLrPEG9BBzAZc3y7rPhf
         KHeA==
X-Gm-Message-State: AOJu0YzV7/nOF6M7swZuxnB4hral5jH59lOrkxyo17ZM7GQpNGprC7MV
	E1i+gfEb8PQtwdLAWb65kF+YUg1LaIb0OJikUSgSqPSp5RoF9LZZoi0d
X-Gm-Gg: Acq92OGEZUqDnLoVNqZQW4GrTTvLLLa1I1yFZFAQshGxHHbePeMKtAejrT9a9bsdI+/
	ZQgBz412knK5E9IfNuqlwJqoqE7THkEfhGbTWgJo3Is6XcxnKTdJU6WQQ10Tr3KD6RPAJpkJDmC
	VzzDNiU3UJo6fbQfapiDZviyZZ68BvkEMPyjJ7qCzOkOD3FWMIvOrDxFl6LlBbRwLPUcBXB1K3G
	WdQjmz/aFgthM3d8c9we9ga/ABGPVbRk1XLVo6BVNqCoiU/iV1yUUBKuO43vYOGPfYEZAyZ+RrR
	wFZtNsB9pIJWE+/kTLK2zGcQ1Ip9REg9teRykffSkTSlNVKe1kWAVV4KmZU3rvpkKZ3Ykwd0yHd
	O0VsWK8R5+YneleJuNZl9ZfqgIhkFu9jdfaXxQzkPUFUPY6OfMtko11B2EBqsduBOzFLLhRVs4b
	EgzuBoGFGKdNA0j6xEGM64a24+0eWUrht3s/blAxxzexTVSccUig==
X-Received: by 2002:a05:600c:c098:b0:490:50ff:7943 with SMTP id 5b1f17b1804b1-490a2923a87mr128270125e9.5.1780257512741;
        Sun, 31 May 2026 12:58:32 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:152:df59:bc17:a305:8902:fb31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d7002e8sm220323775e9.15.2026.05.31.12.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 12:58:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v4 0/4] iio: light: add support for veml6031x00 ALS series
Date: Sun, 31 May 2026 21:58:20 +0200
Message-Id: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANySHGoC/2XMywrCMBCF4VcpWRuZmaQjdeV7iItpm9hAL9JKq
 Ejf3VQULC7Pge9/qsmNwU3qmD3V6GKYwtCnYXeZqhrpr06HOm1FQBYRCh1d1zIYnAG0SGHZ1AJ
 sRSVxG50P87t2vqTdhOk+jI93POL6fjrEm05EDdqK98JUeufr07WT0O6roVNrJ9LXMuRotpZWe
 wBTCTMK/lnzY8lurUmWCuScoSipzH/tsiwvXImqLx4BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780257511; l=5703;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=lN6fgVEzxvkD5FRzivriJpyJuNu3ZyEHniYxTYxqcWg=;
 b=Oc/M14tKcAM+r6bvkNzKFkk1WpkSPO2wvRpWWIMpy8PPazqwVQN6YJ9oxStpWHJt2hz+xDPAs
 foBgCZJ40PzDyzYllR61WA1QiVlGiE+QImzthEeCakJFhaYm/50Lt2c
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

Changes in v4:
- [1/4] Entry in alphabetical order for MAINTAINERS.
- [2/4] Fix style for device ID tables.
- [2/4] Add missing header mod_devicetable.h and move iio/sysfs.h to
  [4/4] for the persistence attribute.
- [2/4] Move IIO_DEV_ACQUIRE_DIRECT_MODE to [3/4] where buffers are
  added.
- [3/4] Use test_bit() to check the active scan mask.
- [2/4] Add mutex for operations on scattered register fields.
- [2/4] Add shutdown action after turning the device on.
- Link to v3: https://lore.kernel.org/r/20260524-veml6031x00-v3-0-29165609b2b5@gmail.com

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
 drivers/iio/light/veml6031x00.c                    | 1228 ++++++++++++++++++++
 5 files changed, 1271 insertions(+), 1 deletion(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20241109-veml6031x00-aa9463da064a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

