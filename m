Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554B398910
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566476; cv=none; b=WOWZneYG/Ah3knetk+f/vF9ToAJuNItlFtyRpPycJnsnFTyu902emXKFoE853ifGpsJyzXWWrtMEN2cXWHpg4nyn2dmz8i78384+fRMUcEwjIBsORYv4hv6DY3TcjHc39kohoAw674/2mFMW2RP8YCSiboFXS/LZOPPFEO1GtqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566476; c=relaxed/simple;
	bh=nWZD81zQ6BPIJbCOyQFiqLcHBpqVtk5Ct3NNJaaxfYE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YOhbzvoMJZacnePQyLp7v3J00zqIkqTPAJzzF9qJ7Ebnxm2mWjpDnGCmCJQPSUMDzTHxOzjTyhqIvUWkwNjyeblVeSRWMmVN8G/8Ct5X306lrZqQNfC5wvnv/VmQr1N7SEQKvsVD4Y0vBCW/ULDrK+WN+W919TY0tNyhnbExRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9OSeFKW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9OSeFKW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4980dc26022so14496935e9.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 13:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786566471; x=1787171271; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KmgDtMUV12yU2q/JT5qoX5gOYEFrUIeJrv8g2Ia2RyM=;
        b=M9OSeFKW8ELBacv9x7MB5WyCiqpgNoBkhBlEkAE2XpZPTDwPWPnfEAnpbQBoRWuDXl
         RAJ06eMG99Jj+Pq0UNAUvbU+VVnEHyNHCIraw/mUlCvrgRl/zMMOmAfGTYrOfmMlnalg
         yPu3eTiz2P39bkxgKWt6gIYfFUPQibdlHB2D5/Xw3XKxn/GPY2A5AMrD/Iaa0+/WnJBF
         QNU4BEPRQXQlD0QqcUunkSGH6NBmEC4M9khpmUaydMG5ZawmiYuUBfwbVcqvENedg0Fe
         NakyPzFWAXYqgMjMia7ohnFi2yrshc3NNThDyS9pZgQhLLScYJXIKAhv+Fti7wm+Zucv
         MKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566471; x=1787171271;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KmgDtMUV12yU2q/JT5qoX5gOYEFrUIeJrv8g2Ia2RyM=;
        b=GNpSjcuggV+/0dlWwZoVNy4JX6Kufz0RnXEfBvthWNTH0tjypdagKWl7a1bakRIyk5
         FV1s0hYs8EyIXZzEbckYX1FvKJ4vFyqzkAxS+Pu1nyvoEgx1aZ9+qybofp7d0MOH0ePd
         bcXCBx9Xe58J565PU8gtpQ9TDbpUSWUclwu+xLo6U1O/IUPCVCfnhSjo1Si95HxQ9R7n
         /vw/KcGFr17auZeP9FwH0SL42l2ejzPkFCEU6l5Eu5JtmMUCLc0rhqmK/mmmlnrVGZZ5
         uKHGKv0/utcZtnsWSemw+PrwGyW0VV+SQAC4gBAQfzbQiCfIBLn6wz0Ld570Ncq1fFvh
         Swqw==
X-Gm-Message-State: AOJu0YzclM8aHHuQwiMvM53esufAhEt3PQsI0ct00+I11jcMLsLu8BxY
	zyYK/MkpulkH1eh7KHhMXJF3kPlcm5AW7tNHu5M36+dbtPmysb1hoZZ1
X-Gm-Gg: AR+sD12JudyX0pomi87QyXqzPLxRSvdoGr6kMBGv2N8o8WilZZAPJsdpgUAVb31URXu
	FhsQwOvGIHjllUkWt81jsjH+VN/oQYZ+aXX3Gi5ZCNPFEzHsFrJ8IacNTHPNtZFDAbIpv94j6Vi
	ksxafO/IwfCfiKX4UrraUcoh76cdfaghhdorFOfnjhv3I4jjDqg9LlHWhKs9q5CXmsjFxfKv336
	upVgvv3vbvnfMATGnLGD0wCwsHxpfK+kiZVS8YvDueXdRFVnh0GUawNyhLkVk/QElqxpGUlDqVx
	kdfKAVIdRBYSvqP/005UKdkJe7ilSZyiCW466+MaL3RLhoUPO4r5FBrbHgGp1AKHLvncwNdXGqC
	0nN/XHttRa4m0yNXbfQX8EsSLwaoR+BTra2XmdCUf05k1Ojy/jTkRgxzXyKfSNAY9ta70JR3wWj
	nNNBFe0mRjhjzykbuV9luWC7T1dY8vuRobUckjCMOxgIU6x7hvT6kDjwlGWRfh3NqFBFru2nGRN
	kai
X-Received: by 2002:a05:600c:4e87:b0:499:79b9:e226 with SMTP id 5b1f17b1804b1-4998218496amr3918805e9.0.1786566471046;
        Wed, 12 Aug 2026 13:27:51 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:16f:15e0:179c:a67f:8487:260])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b03e70sm13911725e9.3.2026.08.12.13.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:27:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v6 0/4] iio: light: add support for veml6031x00 ALS series
Date: Wed, 12 Aug 2026 22:27:39 +0200
Message-Id: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADvXfGoC/2XNwW6DMAzG8Vepcl4mO04M7LT3qHYwkLSRSplgi
 lpVvPsC2jSyHj9Lv78favZT9LN6OzzU5FOc43jNg18OqjvL9eR17PNWBoxFhEYnP1wYCG8AWqS
 xTL0AW1FZfE4+xNtWO37kfY7z1zjdt3jC9frTMVx0EmrQVkIQNm3woX8/DRIvr904qLWTzK9lc
 EilNautgDphRsEnSztrbGkpW9MgO4amNa37b+3OEpbWZuvZhir0naf66a/7szVUpXWbhbri0BJ
 b2NtlWb4BSXgrKZYBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786566469; l=8032;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=nWZD81zQ6BPIJbCOyQFiqLcHBpqVtk5Ct3NNJaaxfYE=;
 b=0fesfpe/27HUfzsYgZu1aDD1kJHC7oeYZEqbyILdDAwN2cyXVSObDXA5v1eqryMIxqTUVFw/G
 d4Ea41YI9DvBOSXkr3aNyRwXNp7jREk8C6exSiK4qV+qcWnB7a/Q+Hu
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
 drivers/iio/light/veml6031x00.c                    | 1344 ++++++++++++++++++++
 5 files changed, 1377 insertions(+), 1 deletion(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20241109-veml6031x00-aa9463da064a

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

