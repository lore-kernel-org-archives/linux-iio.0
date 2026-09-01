Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4BC33263B
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267953; cv=none; b=rlXYXVTKZ5II+8lmebmm8fSUKGwzKAdlCNmy+dgEFYKYjRafVV4aaX+s34qURatM+KAmu5rl8c8S5FVri38EKJUQO7GdXNMH/HDSn4af7p/mrhgWHRB7oc6g0dxeJlF+tLXaY2ZhEoZZOCtXRfoQNPHocjB6wJGuTvlyJ8ccxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267953; c=relaxed/simple;
	bh=N2HYWjqZfohHSs+fT5J6iHO3oKrW8M0GksAEW+smWkk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eoCfR9VwBzN42iLXXC4Q/phkdfsnne4WL8Rjkycv+xCpVjP9WH2xj2WStCTdIpFrsk0mpw+nze0+tQCWidDw7VMJKK36u3JD1mbzxVg24q6txGa31otT6PwxVNmqpmZTnryVITv7WKTh45OKhF1ey7zcgDNoO9D9GsAexeaJcGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGbV+Yua; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGbV+Yua"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso67280765e9.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267950; x=1788872750; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4epK11c+vqsOIzIYo0G8NdpYXNgFJ3OKsmA9xAfy+9k=;
        b=hGbV+YuaerLFL542w3kuaQeOviZ8oImZlgewFZuQgXjmFFlnmBmA82Vfye5uisKwGS
         ApK7Ukd5osSTFzvIU6kGYud9wdH7ooA7vGzMsRJaqzejCQacyaQhCMQuH2oVyNyhYYgh
         e0Rg5sMUpLdWLoGaz3YIz8XaM0JMdPWN7/pR/wX34NPJuQ36aOF896lJmuYV+tomeaZ4
         t25JsEYuoP2z7mIrIwXVbgM3w5SD0JxmX9HuDFKiTZxhYQS+XT8V6aToPltVDzYWbiup
         Lsya0kuj0rsFFUbo/sVlUJngY7EXqXlsR0BPckKX9rFl4cjFFo3wChE7NaN4HziL2ARI
         uJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267950; x=1788872750;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4epK11c+vqsOIzIYo0G8NdpYXNgFJ3OKsmA9xAfy+9k=;
        b=I1evrjdKQgTVfGPfxeP4XSL3h2Alt5kwAdbo+oKjlrXOolyv5zR7UtmH1zvfe1uTna
         EPrnOuC5vKrcmG9r+l2hPSxww/bIcOKj6lopDNax3GHn/jMcHIIVTELE18Is/Vttchs1
         +AOK2Gm/KdVw8GQdVO9eaCqiYP+/jlzpvFveoMA6VdhcsquQLpuEJuq4f14SRd7gTkoe
         GMWUca+AtqQYbeQXLqru/9GSvvjTmhh+vNS20aqlNwQR/7YOVOB2KnpAa/h+heAD7XN5
         a2ivquzIDZLZ0Vi20adsSeHwJ4zp46caLa9xBgUQgACf6CzChEgxfckQDJi5QaFotMES
         q3pA==
X-Gm-Message-State: AFuF++n+MGHaoU3KgCI7SVDT2IXtbNJ/QLy54bdS4p8HgwneC1FmH8gU
	+Df1T8MpN1M+sUyIsZoOY6OFizW7AvX4D2ARtySb6Iff9/7kWajxk1aA
X-Gm-Gg: AR+sD12Tpkuc4EVBgOU/lFGVdQS4dJmmwnoyhPekXG+JdGFOy9t2uEPqKbA7hN4fkzS
	7km1XWfbHCO6rajmMKoC7gxS0YCi8Hp3yT/2SCEYOjXr69eMqVHtNbA2v3J3YAlPOMnRqob+FWs
	yoIiTS8BbWwKHNZ2STinunQaZRsXRiDm5gx4qjlZBq8bB/RjxjYLBCWddDkRMcLVDQdUE4Lp2g8
	yNuutTswANGWtCKIGi0iewcdjxnbHG03n6M+PlZWdDotn0PCkG11wQ6KWwkhEuoCgyWqIi8kj0s
	O+ecCf5s7nJdjYpF5Nb6wqZPkUkGFQ8w0xmgFvKrALOnU5XbDptZXdoh7jvcwrxObUFmGK3+r8S
	EV6xzWrQYvQuTci2IZSIESGNPL5a14/wvDKqsoUPu9UKj2QsYrN9LQgDdQOMMqqHM52PlwgcHo+
	s3v4srrwqYzS0i5LqZ2CVcH6cR2DBBNjSv++O/XIn8UKLhFKVdbQMFiGsCMv97W8rC/Pdi4tomr
	X6S
X-Received: by 2002:a05:600c:a403:b0:49b:924e:9a28 with SMTP id 5b1f17b1804b1-49b924e9b14mr521865175e9.1.1788267949592;
        Tue, 01 Sep 2026 06:05:49 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:16d:f647:6bd8:c024:aa73:750e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce3e0desm70343395e9.11.2026.09.01.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:05:49 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v8 0/4] iio: light: add support for veml6031x00 ALS series
Date: Tue, 01 Sep 2026 15:05:45 +0200
Message-Id: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKnNlmoC/2XPQW6DMBCF4atEXpdqPDZj6Kr3qLIweCaxFEIEF
 UoUcfca1Ko4LJ+l7x/5qUYeIo/q4/BUA09xjP01jertoNqzv564iCFthYBWa6iLibsLgdF3gML
 72pIJHsh6lcRtYIn3tfZ1TPscx+9+eKzxSS+vvx2krDPpAgrrRTxhIyzh89T5eHlv+04tnQn/L
 EGpTW5xsQ5M64m01ztrNhZtbk2yWGsqCeoGm/LV2o01Orc2WSYrTkLLptrdLf9tBS635WqhciS
 NIQuvljZWY24pWccsxLZlrHfWbW2VW7f8t4HAIAgcZGvnef4BqLWfyg4CAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788267947; l=9501;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=N2HYWjqZfohHSs+fT5J6iHO3oKrW8M0GksAEW+smWkk=;
 b=GbIVxfQN1V/weVRU2jX2WEkz+9qqGOTLvdRU5r2J5F9KwdJH8G/bVbZKzOXqDhNE6FkZuB+sv
 oDbLalWn0VTAbi376d9rPUjOOtaffhjovf1geuU0NNcGBCa2Cp1eVUH
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

These ambient light sensors with I2C interface provide two light
channels (ALS and IR), high/low threshold alarms with configurable
persistence, and a data ready signal.

The devices covered by this driver have the same resolution, and they
share most of their functionality. These are the differences between
them (note that the x belongs to their names, and it is not a wildcard):

 - Device ID: accessible via two 8-bit registers, different values for
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

The datasheet specifies the scale and integration time for the ALS channel.
Although both settings also affect the measured IR value, no transfer
function, accuracy, or calibration is specified for converting the IR
output into a physical quantity. The IR channel is therefore intended only
as a qualitative indication of the infrared content of the incident light,
rather than as a precision measurement channel. Consequently, the driver
does not expose scale or integration time as IR-channel attributes.

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
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Changes in v8:
- [2/4] declare *dev = regmap_get_device() instead of calling it in
  dev_warn().
- [4/4] split regmap writable ranges to avoid holes (reserved registers).
- [4/4] Use is_power_of_2() and ilog2() instead of hweight8() and ffs().
- [4/4] Minor modifications suggested by Andy Shevchenko (direct return
  of devm_add_action_or_reset(), unsigned where required, split regval
  assignment).

- Link to v7: https://lore.kernel.org/r/20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com

Changes in v7:
- [2..4/4] Refactor probe() (extract IIO device initialization, more
  logical initialization order).
- [2/4] Drop pm_runtime_get_noresume() and pm_runtime_put_autosuspend()
  in the probe function and let the core handle it.
- [2/4] Rephrase unknwon ID info message.
- [2/4] Rephrase Commit message to make it independent of [3..4/4]
- [2/4] Trailing comma after last channel in iio_chan_spec.
- [2/4] Return -ENODATA if i2c_get_match_data() fails.
- [2/4] Use logical splits and local variables to make lines shorter.
- [2..4/4] Use regmap_assign_bits() instead of regmap_update_bits() where
  it makes sense.
- [4/4] Use pm_runtime_put_sync()
- [4/4] Explicitly include <linux/lockdep.h> for lockdep_assert_held().
- [4/4] Use helpers to refactor code without adding goto jumps within
  scoped guards.
- [4/4] Drop own trigger assignment.
- Link to v6: https://lore.kernel.org/r/20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com

Changes in v6:
- [1/4] Fix dt-binding title.
- [2/4] Update headers as indicated by Andy and Uwe.
- [2/4] Macro to get selector from gain registers.
- [2/4] Use pm_runtime_get_noresume() (no devres).
- [2/4] Drop <linux/mod_devicetable.h>
- [2/4] Use regmap_update_bits() to set power state.
- [3/4] Add scan info for the non-irq variant.
- [3/4] Fix lock acquisition (direct mode and then scale_lock).
- [3/4] Zero-initialize scan buffer.
- [4/4] Store timestamp before calling iio_trigger_poll_nested().
- [4/4] Move mutex_init and regfield_init before setup_irq().
- [4/4] Add lockdep_assert_held() to veml6031x00_interrupt().
- [4/4] Avoid register read if a spurious interrupt arrives when the
  device is powered down.
- Link to v5: https://lore.kernel.org/r/20260807-veml6031x00-v5-0-e60876fb3640@gmail.com

Changes in v5:
- [2/4] Explicit inclusion of some missing used headers.
- [2/4] Define CONF0 as volatile to account for AF_TRIG (reset by
  hardware).
- [2/4] Drop integration time and scale for IR channel.
- [2/4] Use unsigned int instead of int where no negative values are
  possible.
- [2/4] Write a helper to update the gain and use it where needed.
- [2/4] Move i2c_get_match() closer to the data allocation.
- [2/4] Move iio dev initialization out of the runtime pm region.
- [2/4] Lower log level for unknown ID part.
- [2/4] Redefine gains as _INT_MILLI.
- [2/4] Drop pointer to the device in the private structure.
- [2/4] Fix some coding-style issues.
- [4/4] Add second iio_chan_spec to avoid exposing dead sysfs attributes if no
  irq is available.
- [4/4] Refactor goto calls in functions with guard().
- [3/4] Use IIO_DECLARE_BUFFER_WITH_TS() instead of a custom structure.
- [4/4] Use format instead of deprecated sign for the scan type.
- Link to v4: https://lore.kernel.org/r/20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com

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

 .../bindings/iio/light/vishay,veml6030.yaml        |   13 +-
 MAINTAINERS                                        |    6 +
 drivers/iio/light/Kconfig                          |   14 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/veml6031x00.c                    | 1370 ++++++++++++++++++++
 5 files changed, 1403 insertions(+), 1 deletion(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20241109-veml6031x00-aa9463da064a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

