Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E139CCFC
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110738; cv=none; b=MlMzpDuvdMZvu3d0IkbfO2QWqLeifBrTM7TTw8MR1FHlHt4s5/eSW4KPoTEq4HeAoEBaJgTZj5nKT82/ssd1XihbD8jHBDj0nQRxYEFwslOxylDMIZlR62BsA+MOkeZDGlrFVtZGy3AXNyPr60C0e2m7vyrqpK3PEBgeQLBXNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110738; c=relaxed/simple;
	bh=AodW2Lbpp99uxbv8Dj3RWl+h6a23AN2bo4vHAW9yr/s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tdr0yxE8y1CQ5ZW/wIEnvxmUIs0i1Pf8w6BGxPD+eIxujaIg5USkfuTkXnzkYNRqPJOg3ev58hfQt/L5NqmG5yivA07BpG1qW4jsdG62MsLjZGEwQ60ErlHU4dzzSLtiVjJ32I2ApkEIts32klMGkvIuvRSOtJTIrQcr4Kvmopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRSiT2OC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRSiT2OC"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47de008b020so1313316f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110731; x=1786715531; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rkYSrmKo4jkIJhTE4pxc7MbQ5739iflTHRR5TxSnvTo=;
        b=kRSiT2OCkXKdmF9rsUrVwpS6uHWmwKjPR+eJ1ndg+gr5gYqUUjZ4kCy8Bw/ZpiNxgP
         YusCj//y6L8z/VcbZyzbRAb+3yspm5j3BZnqpNSUb5iDFzz7T+57+p9R7Q8a6Vh5UNSu
         APFSChoLvHnc5L5+uh9acru18CHjjRNz1kCZhN8uuFaUSjnvZ9e8urczUOTIqtwA6zXv
         x+c0/n10Nw/aXu5B5+EaNH7DLGo+JfZn81+MSfKZmE66zHlxanR88afgFiNYFt60SyX1
         6JTFe1Q35Sr2ATxUSksoXUmRZeSWhiosfxJrEHp+XYEzEg+r+V7dePNnqofe0YW087a6
         D+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110731; x=1786715531;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rkYSrmKo4jkIJhTE4pxc7MbQ5739iflTHRR5TxSnvTo=;
        b=iOFAxOP1V9QRnb7gHvlN2A+gQcia50I1JtEZf2POARcb09pG12QQ1s8+8Msm6emEHe
         XXVjj/tzYWrlc2ZqglQ174sjCIMDRbsTOWCqEVmXjWucLWlDUMXH98YBI41u71cakoA5
         Tgjtmq0P7cfnVtKXWm/9BJ09pwusHI/wj98rikPkLLXhySBIuA54bTm3CZlfqt7diNoU
         KKfq838HmnoBm4Yi2YtFm+RTAD8NC3Qlmzxg17qrTRvdz0FWrU8muYI9nrx3DuuOz0eG
         vtpaX2fyw63zJ/SUm1Hi3+3ui30gDHGM8r8CSGJVgMwumv9JvgEunSMFqiygJyeKbkDh
         Nfgg==
X-Gm-Message-State: AOJu0Yw+JW34OoUt2/nTy25/pOyLqhSbhyV4r5+sRU9BT4/nyy+AV9/m
	YNMxX3cH8Wy0uIrBE+9eH3pSjhnVM/N6Ji47qXetmXdi0KGe/5iwJwDA
X-Gm-Gg: AR+sD12EfB+i8EDTBmfdHam505+x3/CAR8pdfMQD4NWpG8kzSnZUEsj+LA6CrVl+XGG
	qBZytDYxYYa6mEE2zj4rqkXftXtlcJtsx7BW6h0ZTS2BWAOV+DkHdrClU5CkDFVViQAr9NT9RnX
	w0CzHpUGydenaDRAKCK200uMT31auHz+isoRKB7TC6kWiG4gCw2BTVmOlS60Xs3r35H67TBxt0j
	ZHj4PDRkZVl98X00yWHSMkJxaYgtjbT614rYph7vKFf47DZ5GUCEbgtZxHC9+jc1TqV7rAPyWRq
	8zvfbs3vSf0t5C3RbXH4yJHm/4VjdoAX2bAPTi1dF0l/HKIygGlsW45wu79DZex9qLbuwrTsGIB
	trB1BBxcISMmvvVQKg7Qj85eSnvlDjiy4mxwuKJg/vkMkIReol3FhIHw3mYgYvuQ45jXx+jw6Se
	4Nb087DSy4COv42hqL6YreU4A+isgq7dbQc1UDK96bBkbFarTiikyl8+5pD7DAaLp0pVwi+YRbc
	QeQxoeHhwvLddv3
X-Received: by 2002:a05:6000:41ea:b0:47f:90f1:68c8 with SMTP id ffacd0b85a97d-47ff4ba89fcmr23786413f8f.1.1786110730983;
        Fri, 07 Aug 2026 06:52:10 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:13c:7c2e:7f0a:5759:2e0d:bf8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8b09sm6581333f8f.23.2026.08.07.06.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:52:10 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v5 0/4] iio: light: add support for veml6031x00 ALS series
Date: Fri, 07 Aug 2026 15:51:51 +0200
Message-Id: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPfidWoC/2XNwW7CMAzG8VdBOZPJdlJDd9p7IA5u60AkSlGLo
 iLUd1+KNolsx8/S7++nmXSMOpnPzdOMmuIUh2se1XZj2rNcT2pjl7chII8ItU3aXxgczgBWpPb
 sOgH2YrK4jRri/Kodjnmf43QfxscrnnC9/nSIi05CC9ZLCMLUBA3d16mXePloh96snUS/lqFCV
 1pa7Q5cK8wo+M+6N0u+tC5bqpErhrqhpvpr/Zt1WFqfrbIPu9C16vbF32VZvgFgWvGCWgEAAA=
 =
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786110728; l=7200;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=AodW2Lbpp99uxbv8Dj3RWl+h6a23AN2bo4vHAW9yr/s=;
 b=oaVBL5oAcAfvr1NVossMhPwG/+YtPX1yU8gC+YJBAGOkNlvLnIljZXi9G9vt3am7Q9csDj8Jf
 Pf7gR9rDfOWCcF++C5z3Q5gY0buRa8lXA+3OAzIJdBa0vowKH9Oz4xV
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
 drivers/iio/light/veml6031x00.c                    | 1321 ++++++++++++++++++++
 5 files changed, 1354 insertions(+), 1 deletion(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20241109-veml6031x00-aa9463da064a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

