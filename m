Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BA2F12AC
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424572; cv=none; b=tnQPKE5iLgT8z/o/CCw6B+wPsorkZBeucx9MUKmoAPhinI8a9T5ji032oNyVEeMrte64PpvKjw0iqzrEGeZuKO4ZVJj6xU6UKATJSCASScL6KoMRS6GuMYHFTXF/ZIlKai5igkt3qc/iKPDlkj3d9O7tUahhSzZ0aT6sY746tXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424572; c=relaxed/simple;
	bh=nNMxTBc5fDicYoz2xcvYwtrUTa/XAdzjVSeQdkqOwIY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ko6vApthCH8WIbVZigg79Jxk4w1xh9IJSSFVT6A5vln2VMvf19kKtBkdUbGmT4z6TwqnCVTQi3O+QYNCInMHinjijeQZzqTZ00PUYxPrpELSF0SzGmIb8Jpg61463dos6FYAANM2/0ZcrEZbDNsOAPgogsHWWtn83yFCXBza1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MdjuYzMa; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MdjuYzMa"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e94c26f9e0so146431a34.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782424568; x=1783029368; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MorUFOvH/y5//XS82u27kOV/BbsfEPmaMl8nnIWDcaE=;
        b=MdjuYzMaUble3vCXQWbH8MwFb8MWimC8q64WoPnxG3zcdgRAbOKwmrnj4em/Q47MM8
         npNNCm0B6WvjoWEapeOFlPo0DWhCBGbD9dSetet0YPCMFOACW3TV0dSqXrPcipewgpkI
         zl80UJPxjJ2iq0Czh0OYoHVV3e128A3XQCNh+c6XOlK52hIwU+7+amtiHE4Mtad2zKxc
         BDTDMcz6Sf320wKNUHSlwCiSspLpoKuJX1zNMm+z05Hu5FUf461T6D8vejYFt/YgGAB/
         KB96ui4Zca4CM7B1gsF/HN6faySGCg7tYdVl0fxhqUBDaCvHMm9fxgQcqtTuncmQ8sDw
         ttYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424568; x=1783029368;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MorUFOvH/y5//XS82u27kOV/BbsfEPmaMl8nnIWDcaE=;
        b=lLTXLpcTuHv1In5+ghcltEySzV/Os2BooB1E3t6la8/TSkA73bRy1iUHFTpm2nmAoC
         B6SoMnTSAdMi+XadbX3GzNxBGWUX9l0wUTyh2nkHuWRO3HB3uT4mFn3Iduux/eDRwMUT
         8gLweWWkOfIEm3YOqiX6e1ALyK4GTXcgTOS1rdkxy6tq7xVzWMdgEBeds0SvOVLMZJOT
         4XCd7XSft3GTN998vshc+iJxr/XQUnEpuefjLSrj++0qMNWvknEjg9YW3weV4dXYVYFd
         JHWh5l9YFerzV4MiosUz1Q5vvLfQHQRw/N6lgY/ptptLhWeyL8VyR2dKJXRAN33uAUtb
         qO/w==
X-Forwarded-Encrypted: i=1; AFNElJ8UKW+IOqug/lSEDv+FviUZMG112upx2Se5zv7RM2eIyRbUt9sj1p6M7TCDBHSLXjdDAbHwIV30yy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXgx5c4yBOPp16ELHDMOuvKKFmcRXte6v92kRxYI5aYoo8tKs
	l7nXhM4RHwJA7gCvmzQBkeN60s5aYPT6ihft5aj5WVAJWi/SpwYcm3GooVUnuz1ouXA=
X-Gm-Gg: AfdE7cluhqQqr4BOlxKFnFHaFBbYDdYpIoxf/OXy2iSHvg8CsYiIZPn+K55SyJWdzS7
	Ydx7QeMpWakP4FhNm5agG0Czb8Z8ov462DRN4F86T7WzdtHGuGjEB39qx7guJOmfE5LU8TNahdl
	Gteyk/FFzCjxby+LaEjy1Ek6vMt6cvu6AVCcJWPGkqu+By52I9V6bhRInadQANuiLvMiIcAPks7
	00WtPp9aAejK4NgIv+Ia/YNvcwvrQa6cjY2zqh/AYt7QMgZivUwBfaJO/LoPugxyGbrm7G7LU65
	PumDQCFWDvreHGqayD1kcecxWeYK9AE426fk81pRbW6HWzojstkmwAjZ1u17rumL1YYZVmvIAsi
	dpXH5KxNpORPdDwJJhEGw2u7ryHlvBvGFN1RYqkHl2P0LTWvU5as96+SE332K3yI7e9crT2UKEH
	xbEW0gvMM6GG/HKTlwqg==
X-Received: by 2002:a05:6830:6d2c:b0:7e7:c1d:bf5b with SMTP id 46e09a7af769-7e99c24ef20mr4182941a34.24.1782424568258;
        Thu, 25 Jun 2026 14:56:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f1f0:2d9f:2f31:3426])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5e575csm206058a34.11.2026.06.25.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:56:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/8] iio: adc: new ti-ads112c14 driver
Date: Thu, 25 Jun 2026 16:55:02 -0500
Message-Id: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4V0bU07vIIr/8Ow6LSDjFFqWiQSw
 r9bYOtqcib33rOISIEpiku2iEATR/ZDAjhlwvZmuJNkl1iAgkqVupDMXhpn5cjpRA1g09MpbKC
 omzwvSKTqO1DH33321h4cP/ggO25bW6LnOPow795Jb7lDUenyv2LSUkmq0BnX1RYBr2jmJ2Ogs
 /Uv0a7r+gPPhywMzQAAAA==
X-Change-ID: 20260514-iio-adc-ti-ads122c14-d0b92479334e
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6186; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=nNMxTBc5fDicYoz2xcvYwtrUTa/XAdzjVSeQdkqOwIY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqPaO7t3aP8rSr2GvZYEiPM7JHa+RjmhwtGcMim
 TA4oICkqwqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaj2juwAKCRDCzCAB/wGP
 wE8aB/4m9s7mfif+beBlQhrqt41PtPqsACJEB/r2wDrFPVqp3T6+OMyOclHJM1JjWHjKUYLtSgT
 6BdtHugSXOKxtiWwWC9XF2TlMqh6SWkaapsFewYPRX6NwW7ab8udEuNfz/f56KPoi3a+db1EogG
 KCo1G7xkNpWeWlb/ratQITOLH7SA2tGekBnCl+Ol/ZvBg9u20piGxH+6OgRN8joik+9DNi67kE/
 tVptqAC+AtPS6acqKSEjaDO+JSTJF72ZLSrqYGifdqpdf00YQGUYv95fj9WWoLgm26Dr2uoGGOn
 iMSfTS5k3VIov2vsGCXvOZLSs758MInKJa91xUVNhSei1JNl
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This adds support for TI ADS112C14 and ADS122C14 ADC chips.

The closest thing we've seen to this in the kernel already is ads124s08.
However, that has a completely different register map and the DT
bindings are incomplete and the driver is extremely basic. So I've just
started from scratch here.

We've also had a similar submission recently for ADS1220 [1]. That chip
is in a similar situation to ads124s08 in that it has a different
register map (but the submitted DT bindings are better than the ones for
ads124s08, even if still a bit incomplete). And literally as I was
writing the previous sentence, another series [2]  was sent for yet
another similar family of chips (ADS1262). That one is even more complex
in the feature set than the ones I am working on. I was going to polish
up the driver a bit more before submitting it, but now it seems more
urgent to coordinate with the other two series to align on how we would
like to handle all of these.

[1]: https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@gmail.com/
[2]: https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed@gmail.com/

All of these chips have in common that they are designed for use with
RTDs and thermocouples and so they look very similar to each other in
terms of wiring and feature set, even if the register maps are
different. They are in the gray area where we could either keep them
separate because they are just different enough, or we could do like
we've done before with ad_sigma_delta and have a bit of an abstraction
layer for the register differences and otherwise try to share as much
code as possible. Normally, I would lean towards keeping them separate,
but in this case, I'm considering trying to share code because the
devicetree bindings for the inputs is complex and is going to be mostly
the same across all of these chips.

If we decide to go the route of sharing code, we could still merge this
series as-is and then do the refactoring to add the abstraction layer in
a follow-up series that also adds support for the first of the other
chips.

This series includes just basic support for reading single measurements
from the ADC and gain selection via the scale attribute. I plan to
follow this up with additional series to add support for buffered reads,
filtering/oversampling configuration, event support, gpio controller
support and perhaps a few other things that are slipping my mind right
now.

The most interesting part about this (that I alluded to above) is the
way channels are handled. These are multipling ADCs with differential
and single-ended inputs. But what sets them apart from other similar
chips is that since they are designed for use with RTDs, there can also
be a current output required to excite the RTD and this current output
might be different for different channels. So the way I conceptualized
the channels is that the devicetree specifies the conditions needed
to take a particular measurement rather than being purely a physical
channel.

This makes things more flexible, but does make the driver a bit more
complex. For example, knowing when the current output needs to be
enabled or disabled. For now, I have chosen a lazy-enable where they
are not turned on until the first measurement is taken that requires
them, but then they stay on until another measurement is taken that
doesn't require them. This can lead to some oddness with the diagnostic
channels that may be measuring something that indirectly requires the
current output (i.e. the external reference voltage when it is connected
to a resistor rather than a power supply). This means you need to take
a measurement that requires the current output to be enabled before the
diagnostic channels will give accurate readings.

I have also pushed a branch to [3] that contains the start of some
documentation for this driver that can give some more insight into how
the implementation works. It still needs some work and also documents
some things that haven't been implemented yet, so I haven't included it
in this series yet.

[3]: https://github.com/dlech/linux/blob/b4/iio-adc-ti-ads122c14/Documentation/iio/ads112c14.rst

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Added patches for adding properties to adc.yaml.
- Some of these are coming from: https://lore.kernel.org/linux-iio/20260622-new-channel-props-v2-0-aafd5369f253@gmail.com/
- For now, I have stuck with one channel per single-channel pin or
  diff-channels pin pair rather than some of the other ideas that were
  discussed. Handling burn out current enable will be handled in a later
  series. I'm leaning towards something like the _burnoutraw attribute
  that Jonathan suggested.
- See individual patches for details of changes (mostly renaming DT
  properties, fixing some driver bugs and style issues).
- Link to v1: https://patch.msgid.link/20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com

---
David Lechner (TI) (5):
      dt-bindings: iio: adc: add input-channel-rotation property
      dt-bindings: iio: adc: add ti,ads122c14
      iio: adc: add ti-ads112c14 driver
      iio: adc: ti-ads112c14: implement gain on internal short SYS_MON channel
      iio: adc: ti-ads112c14: add measurement channel support

Kurt Borja (3):
      dt-bindings: iio: adc: Add reference-sources property
      dt-bindings: iio: adc: Add excitation current sources properties
      dt-bindings: iio: adc: Add burn-out current properties

 Documentation/devicetree/bindings/iio/adc/adc.yaml |   41 +
 .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  |  205 ++++
 MAINTAINERS                                        |    7 +
 drivers/iio/adc/Kconfig                            |   12 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ti-ads112c14.c                     | 1186 ++++++++++++++++++++
 6 files changed, 1452 insertions(+)
---
base-commit: 948efecf22e49aa4bf55bb73ec79a0ddcfd38571
change-id: 20260514-iio-adc-ti-ads122c14-d0b92479334e

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

