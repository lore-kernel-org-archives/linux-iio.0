Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AC353EC0
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899121; cv=none; b=sI2E8gdSvNdEw9bTyofNWQcduqB9WwpRb+eRGYSFOTAaBnIbuhBaKJXmZWXKkwiP9xRQXzrTwoLP/BcWf0rqSy+IsVJ/xtQOwCiPjyh0lKA9BzyRHe4M+6JoDu/Yq38zxJQsxWALDqBIztQHnc/8FxnWaIEDLmKvbHSBXAxTJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899121; c=relaxed/simple;
	bh=LMl3MwNwdk8lr079qi38EPV0VgIgGMLtf2m58Py53CA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tEQo1SEYZUjyRP2C0/+A2I/97X6tHVD6Y8Bl2OGKxceIaE1QGmKxS7e/UKuprpMFwv9bnf9ZT97GBtViz1Htg7tgrbUCl96koT0KJcaGl7Wytklbw47zQYPJp2WFE/ioJuuFbx9885TyMtsnehFHWsbE9WTKhGDtx9D0aAaZZ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St16YRBs; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St16YRBs"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bfaa014978so328627e0c.3
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 23:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787899119; x=1788503919; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6nr4iuxsRFUzlJ07bpFXoYYtCZeiUT8HmrlrMlGcxIc=;
        b=St16YRBsYbPEaW5GAFK1h4D8aMmL+KjRh7Ea9cqNJVY1AxhT5woRtM6steyQ5PqBrI
         7TKBl5l0zOazWg7uhlAolW5jp4mouGF3IGrmS1AtMyFHUA3xmULWhr27HMrJvARqqVJH
         tyuuCumwbLiArxT+2kuSQz+FZDSyo4dpjssWrQ0vdfNtIPFp0ArvreA91nm2fSG+7U4L
         zrmhNUN01DmYPYOfO57npNw8D4+CGnlTjgPmwlUbdvYPZoTps67dKq4pJF/pNzvl7IRC
         uCPxt+46uqyYCVy+EjMZjCcILeNywejH9LFy0jKzOa0s16TForTLwt9OyiaxbQegjcEN
         GEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899119; x=1788503919;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6nr4iuxsRFUzlJ07bpFXoYYtCZeiUT8HmrlrMlGcxIc=;
        b=VkEo5QABJuduE78B2vc05L35UEzJSj2FH4vKWDUW8Y5ZWNAwdQqIJ2zaR06yYlcarc
         kqQANDxwfgojPAenKNrcqRHwfRuiZYrcSLebchmbrNtYoKY+v6/0nFEYMaBZQSR1fkJy
         q6V2vfvIy9pUi5hHePtfWGeWW4QPxr7uZxwY56McY70iuDEWPtaSDHLXAg4e9RHPjZz7
         hMcqGFs12UPU3fURgUT44ia2qYyner0QAkfb6+jWyJK4nAcb6nmqq9xCLabi5ot78TPq
         5IbDhBYeoQrsgNX9Ky5SfeoeSPeKZNRQRra/LQHDc82B0s7xl8t+qWG1UzGgz6rbJoZ6
         VWkA==
X-Forwarded-Encrypted: i=1; AHgh+RoRf3gWJufymRo0O7p0tWd9RHyKeUofwykZHbDfabfI7V7/s2WsSRrFrmuGTiYtzozd5ToXprz38FE=@vger.kernel.org
X-Gm-Message-State: AFuF++nFLBJbWM231c9iZKqLrPhD2LAthqfSDaIkK7LMDpukg7cFdh5i
	3yjaSTt36Tb3WdKyGK6IlYg7b2ZdWDoV7vc3mPyEQmC5GDTPz5f16rf2
X-Gm-Gg: AR+sD13zx9rAlP8lLPMT3F4Upmag8h5aS+RUE8LsR95WZMisV6zxxup3cjfDuVdqvf5
	/ftNNM4LSf1Pq+uaVhyrkcSlU1Nazc9byZd4lYKH27On+BgfuhgM6+d5g3ljFPaXDcAWKCeAGCa
	ivNh2gVj00Vn8kkvWTZTcDZxk9bxb4mbig/oAYGtT6S9YTtecMo3TRhW3u9Uj3c4ca9oMaRfjwJ
	BT19ddW+AurVy/ljOIHKJUhlVGd1qs6n2GTX5V34yE9VveiXztv3HnUiLeAgvYqYtEjPbDHA2S2
	MAzHfD3Bmle2UscbrxuwG82D143oivwOkbl7T5rGnHzCNQ0M1j8LGLwyrWFWxCp0ArLwUClLGRl
	7klDnAVFYcaUEpCuaN5XY7rLsyR4BMxbD4cw38sGWF+43UCmH8VLVq7tEtdF6Mg3oMZ5xSnn2pb
	0PtBeU4zgRChTNxM3f21BXgsX7AIvTHyYowXNdgULFv4gjoEt9JF2F1iTKB75feCZA
X-Received: by 2002:a05:6102:3ecf:b0:784:5883:9cc4 with SMTP id ada2fe7eead31-7859aab00d9mr1264019137.11.1787899118923;
        Thu, 27 Aug 2026 23:38:38 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e849d8494sm454195241.1.2026.08.27.23.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:38:38 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v4 00/10] iio: adc: Add TI ADS126X ADC family support
Date: Fri, 28 Aug 2026 01:38:15 -0500
Message-Id: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12QQQ6CMBBFr0K6tqYzpbR15T2Mi0KLNBHQVomGc
 HcLGjEu/8+8l/wZSXTBu0h22UiCG3z0fZdCvslI1Zju5Ki3KRNkKABQU2MjYPGgdVkAk4KJyji
 Sri/B1f6xmA7HlBsfb314LuIB5nZ2FKwA/DoGoIwqnVdSKcu4s/tTa/x5W/UtmR0D/nCoVg4Tl
 5dQIgeOojT/HF85xeTK8cTVSmsUVqLU+MtN7xHBXe/pC7fPkml6AWCPa6UjAQAA
X-Change-ID: 20251129-ads126x-fb6107505cae
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5912; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=LMl3MwNwdk8lr079qi38EPV0VgIgGMLtf2m58Py53CA=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkTdR5+l81U3hIgu7vG5FpmnL/ljm8t0p3zvzNfcI8zc
 hFKnVzdUcrCIMbFICumyNKesOjbo6i8t34HQu/DzGFlAhnCwMUpABPxFWNkuFvSoqGzj+FPw1rn
 T1p9t9T5eb1kTVhXsb+U+ney8sKqywz/i43rHgSreS962u7x4qBYjGC6g8D3P1O/bb9yJv3r/Sl
 FHAA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

This series introduces support for TI ADS1262 and ADS1263 ADCs [1].
These devices are very similar (if not the same), except ADS1263
includes a secondary auxiliary ADC.

I plan to add these features to the main driver soon:

  - Filters
  - Calibration (manual and automatic)
  - GPIO controller capabilities
  - Channel hot-reloading in buffer mode
  - SPI offload support (38400 SPS turns out to be too high for some
    systems)
  - Conversion delay support
  - The ti-ads1263-adc2 driver for ADC2

The auxiliary ADC operates almost completely independent of the main
ADC. The only consideration that has to be taken for interoperability is
when reading conversion data in direct mode (Datasheet 9.4.7.1), which
happens only in buffer mode, when multiple channels are enabled.

When reading data in direct mode, all SPI activity is forbidden between
the data-ready signal and the data retrieval. To achieve this a second
mutex called xfer_lock was introduced to block SPI activity on the
device.

This is one of the biggest drivers I've developed, so I hope the code
and the comments are self-explanatory. If not, please let me know so I
can clarify them.

As always, thanks for your reviews and help. Submitting upstream is
always a great learning experience :)

[1] https://www.ti.com/lit/ds/symlink/ads1263.pdf

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v4:
  dt-bindings
  -----------

  - Added excitation-current-chopping property to adc.yaml. I decided to
    go for *current* instead of *channel* because the current source is
    what's actually being swapped in-between conversions. IMO this is
    more accurate and also matches the terminology used in ad4170-4's
    datasheet.

  - Remove monitor channels from devicetree as their configuration is
    usually fixed

  - Allow ADS1263 parts to also specify #io-channel-cells = 1 and be
    fully compatible with ADS1262. (Sashiko)

  - In interrupt-names description, explain 'drdy' and 'doutdrdy' are
    two independent physical interrupts which output the same DRDY
    signal. (Sashiko)

  - Clarify the ground assumption on refp and refn regulators

  - In the example, describe vbias as an empty object instead of adding
    a redundant regulator-name.

  ti-ads1262
  ----------

  - Multi-channel buffered sampling is now done in PULSE mode to avoid
    missing interrupts due to latency

  - Monitor channels are defined statically, as opossed to parsing them
    from devicetree

  - Stop using devicetree 'reg' as the channel's scan_index because
    there might be "disabled" channels.

  - Setup power supplies before enabling the clock

  - Get the RESET GPIOD locally in ads1262_dev_reset() to avoid having
    to store the pointer to it

  - Only register regulators if the "regulator" node is present in
    firmware

  - Add .is_enabled() callback to refout (Sashiko)

  - Removed include <linux/mod_devicetable.h>

  - Restrict the available sample rates to those compatible with the FIR
    filter until other filters are supported

  - There's a few conditions that require the voltage magnitude of the
    power supplies. Instead of keeping track of each individually, get a
    handle to the regulator and get the voltage on demand.

  - Add fwnode_xlate callback to prepare for future ADC2 support

  - Added validate_scan_mask callback because the DRDY trigger is not
    supported when multiple channels are enabled (although it would not
    be the end of the world, the buffer would just fail to fill)

  Misc:
    - Renamed ads1262_dev_cmd() to ads1262_dev_send_cmd()
    - Removed __aligned(IIO_DMA_MIN_ALIGN) from rx[] buffer
    - Add ADS1262_SPI_XFER_SZ macro and a couple of static_assert()
    - Removed sign_extend32() because a simple cast is enough
    - Replaced regmap_read_bypassed() with plain regmap_read() in
      debugfs callback
    - Use -ENODEV instead of -ENXIO in some error paths
    - Added macro for internal/nominal clock rate
    - Reword dt-bindings patch for more clarity
    - Reword main driver patch for more clarity and some development
      details
    - Move register field values to macros instead of enums
    - Refactor ads1262_find_two()
    - Use regmap_test_bits() in regulator callbacks
    - Improve style of reg defaults table
    - Regulators are now registered only if there is a "regulators" node
      on the device

v3: https://patch.msgid.link/20260807-ads126x-v3-0-f89925d72792@gmail.com
v2: https://patch.msgid.link/20260628-ads126x-v2-0-4b1b231325ba@gmail.com
v1: https://patch.msgid.link/20260612-ads126x-v1-0-894c788d03ed@gmail.com

---
Kurt Borja (10):
      dt-bindings: adc: add excitation-current-chopping property
      dt-bindings: iio: adc: support the TI ADS126x ADC family
      iio: adc: add the ti-ads1262 driver
      iio: adc: ti-ads1262: support per-channel sampling frequency
      iio: adc: ti-ads1262: support per-channel reference and gain
      iio: adc: ti-ads1262: support input chopping
      iio: adc: ti-ads1262: support excitation currents
      iio: adc: ti-ads1262: support triggered buffer sampling
      iio: adc: ti-ads1262: support REFOUT and VBIAS regulators
      iio: adc: ti-ads1262: support common mode supplies

 Documentation/devicetree/bindings/iio/adc/adc.yaml |    8 +
 .../devicetree/bindings/iio/adc/ti,ads1262.yaml    |  376 ++++
 MAINTAINERS                                        |    7 +
 drivers/iio/adc/Kconfig                            |   14 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ti-ads1262.c                       | 2163 ++++++++++++++++++++
 6 files changed, 2569 insertions(+)
---
base-commit: 22359083a9e74d538ce383d5c0ee30cc20182187
change-id: 20251129-ads126x-fb6107505cae

-- 
Thanks, 
 ~ Kurt

