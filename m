Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904153;
	b=IDR6Eb9KnJzeYNuIuvI6ka0DdTRE8X5HXBzo6QgNRVzhNVi+obyKYfc4R4EcRKUA8mqh
	 XJKkK4b07+jJKMEFJOj4KdzKoot7cDkdpHkCNlvhVvJ5+Cgum5DVM9xnV1kgupwG9TN6w
	 l9+mrDgNSgGAFga4G9pjG+xNwEJraC9T9wpMFbH5EBQ/WNqcdMO21Z0cAQDa/lVchvyoS
	 nPsIyzJYdnxjN0vp5jtMFCId/6+K4dDMz/2upSS9+gPveWXqCWQEJLA3Lg7VBne1QfIKv
	 lmxs/LrbSX6eFjsgf6DbkH5uF64niSN2eU01ZAs3bN1VchFKsjaQEUeusxssvzn0bZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6oO12UtU+mARzb/f/lHQkDV3mWLu+MrESDSJBwclKIw=;
	b=3iOSH89/DAMplzMWrj/MHgky/RS2MI45rGvU2+nbJkxt6ke28CKwyXP/gwOHE2AJGxYo
	 x1rL/FTo7r8TXJs80g+wiAPsUvvmbJ75X5VbiHOXCMzrE3l8/BdDGe9jt2WTSfTJNjr+0
	 BO7zgjJwah2j//zm7yKHl2jtC/TdeOHRr0fH/dOA+RhbUbnljvQ4n7PklGi5juTndlvzm
	 Ndk8j/0FMZLeNOsUMoBqSGZDF/vIhtdWDcEeoOOVkKtk+HX8g53DBsOwAA/Ey7qGcAeHv
	 PHpmUWVz9gw7CS35RGFdsnJ2Jv79GJTNHZ3qiHtr1a3TrXoDSVXWHk0V0XsakuzbrSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nB+Uumtt;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436D606A89D
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 08:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0436D606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nB+Uumtt
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso381639b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794904150; x=1795508950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oO12UtU+mARzb/f/lHQkDV3mWLu+MrESDSJBwclKIw=;
        b=nB+Uumtt8XY1eeIvqfgultY8e61E/Fz76yEglyiAPOuohIePvWCG6l3BUHRbvJeQYE
         1AwlTYTRH8aa/s1WxPBtb8A7L7kbOkb2re0TgO0c/6F3p0ZqXhcqrfA6zqUugFKnCR4I
         bJHIB+2nLROeqXWnVuFrFGUx4/6xLJXtxZ6XYyOCrBeqBMWD8+O3b67+vKoX1pyYTW5o
         KPbt3ZQQQoAKNVzwmEXP3PMpxg/4lflWbSeXPNTQKeOgyf/LEiYm0JM9+DHDnbRgs67W
         uPNOytV565o2Yg/irsmo3MOwBpI6cPX4qyRq780Yczzh1dBjRQFxivuH63AXISa0+3Nh
         y/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904150; x=1795508950;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6oO12UtU+mARzb/f/lHQkDV3mWLu+MrESDSJBwclKIw=;
        b=ux6nwiaii8dVbD/SJFh/3Nh2YnxE9Gr/4z48HjUt5Nv69+CqDj+f/dcHmNi5mhTQTy
         094aM9RegvVVEmd9pC9+vkwK0U4Cm/KCareFgQ49+S5Fh7dTf7gTPhtt4sZobt0eZzUg
         TTqO1VMDEa5eaA9NSF8gBr8HO2sJXualSfOodHnPAQAHOrrHEy8WZXiZix1vdStMiZ2X
         ktinEppBDLLOZFqGoYtXxtoXEcqVl8KpRYsLO6Enu/xJKvry1nxa3ihuZ5wh7UL+TZTz
         HlRRK4kwgZjPpJ6stS6UVpJp79cQqovfhH3cgLQIpMv+DKvQ763vJVF4SgIgcs/h0M1u
         PMHw==
X-Forwarded-Encrypted: i=1; AL+hErE8iNmzLRmq4n0bXz+2y7t8PzkwHvIVNbVPHEYEdswdBCFuBwEKLdRX6V79NiuQ9KtcjoQUQETC/Ts=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MrZvxTsXD+pk8P5c1lOjJhdcoKWLX2CyoRgbO0FugegJ4C2sJ
	O/IzqlZDzvbqhCBN1OlU8AoS6TctNhVa0gcvzAnL+ODMJTsCYSUc51qd
X-Gm-Gg: AYBFou3kv+YRVRQiy7/fDg/xwQp4+WtMBeWp7E6YE26SDVzKJwqW7alref5KWesgwy4
	IH0W5Sqs5qFksdar4va38AUM+HXTsqPo/Num+bOhue0QCB7GBAgkeyyluLhkan8cBSolLPZ45HP
	W5pnzcOrbaWe52kpWcVHajKobr1sFFXdBEzwMwOmNmbi2jPk2XXpeMRXXeVdHNv9kHbg/Y/dvYJ
	9Dr2/pVkZY+qYeICYAAOsTfvEuoj8tDCiRsAAWvrW16eXAwKeBByfpix+yKcoj4QMBFYw3/v5S/
	ck584aFYHsyq6guip4x38N7FlXqoL1HiAD87AkBXD5Wf5pYoc2qCoggd8jzTMgjRFQ1yfVHkPII
	niiKTJ3A7gWFx7EXMCSWGJj11hzklVgDnB8a07uj2myEVLdYlDFmu1BfQ8a2Ke1jcZpTPqt/jH/
	/9uRcw0frHMdrYIUJCQJZhQOYSCpVEwr17XpxOA27VsgoG3I9B2Y7KMPWQoZEx8AdsQ/5baqRfm
	9QGs/ERxBbJkrdwB9RPNv0WPBM5fiNWs5PEX0Xr1X1jhBE11PiTyshl2Hw8b6F22b7VZqLXj44a
	LZTpvTIdpO8CTdAg9uPXZv+dr7NAGmbdIR3Me9xn0hSL50cG5cjB7OkRWKZy1qCPd+WWqU8KPXp
	QIH5hJ9l0SAbWZdw=
X-Received: by 2002:a05:6a20:431f:b0:3e2:3de2:5947 with SMTP id adf61e73a8af0-3fd2d7d033cmr1617615637.16.1794904150073;
        Tue, 17 Nov 2026 00:29:10 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18a2191sm5422907a12.21.2026.11.17.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:29:09 -0800 (PST)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chernyakin.victor.j@outlook.com,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v5 0/3] iio: adc: Add Nuvoton MA35D1 EADC support
Date: Tue, 17 Nov 2026 16:28:29 +0800
Message-Id: <20261117082832.1551574-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

This series adds IIO support for the Enhanced Analog-to-Digital
Converter (EADC) found on Nuvoton MA35D1 SoCs.

The EADC provides eight external analog inputs which may be used as
single-ended inputs or as four fixed differential pairs: 0-4, 1-5,
2-6 and 3-7. The VBAT input is internally connected and needs no
devicetree description. It is not supported by this initial driver.

The initial driver supports direct conversion and triggered buffered
capture using sample module 0. Although the hardware provides multiple
sample modules, this version uses only sample module 0 and therefore
supports one active voltage channel per buffered scan.

The series also fixes the common ADC channel validation to reject
configurations specifying both single-channel and diff-channels. The
corresponding redundant constraints are removed from the MA35D1 binding.

A reset control is required to put the EADC into a known state at
probe and resume, and to recover from power-up failures without
clearing ADCEN while the start-up sequence is still in progress.

The series is based on Linux v7.4-rc1.

Changes in v5:
- Fix the common adc.yaml channel validation by replacing the existing
  anyOf constraint with an explicit reg requirement and a mutual-exclusion
  constraint for single-channel and diff-channels, as suggested by
  Rob Herring.
- Remove redundant channel-level validation constraints from the
  MA35D1 binding.
- Require a reset control in the binding and driver to reset the EADC
  during probe and resume and to recover from power-up failures.
- Clarify that the VBAT input is internally connected and needs no
  devicetree description.
- Do not specify the internal reference voltage in the vref-supply
  description.
- Use folded YAML scalars for prose descriptions.
- Reorganize register definitions so register addresses, fields and
  values are grouped together.
- Describe the individual INTSRC0 sample-module interrupt-enable bits
  explicitly instead of treating them as a single field.
- Add paired ADC interrupt enable and disable helpers and simplify the
  conversion error paths.
- Document the ordering used when aborting a timed-out conversion.
- Correct the comment describing PDREF.
- Remove the trivial differential sign-extension helper.
- Validate the effective scan mask in update_scan_mode() so callback
  buffers and merged masks cannot request multiple voltage channels.
  Commit the selected channel only after validation.
- Wait for PWRM.PWUPRDY after enabling the ADC.
- Use a full module reset to recover from power-up failures instead of
  clearing ADCEN before PWUPRDY is set. Preserve the original error and
  report any reset failure.
- Read DAT0 during timeout recovery to discard an unread result and
  clear stale VALID and OV flags.
- Reset the whole EADC module at the start of hardware initialization
  in both probe and resume, replacing the control-circuit reset and the
  register-by-register clearing of inherited interrupt, compare and
  trigger configuration. This also removes the access to the
  non-existent SCTL8 register.
- Split single-ended and differential channel parsing into separate
  helpers.
- Initialize local channel-tracking bitmaps directly using = { } instead
  of separate bitmap_zero() calls, as suggested by Victor Chernyakin.
- Remove the unnecessary raw variable in the triggered capture path
  and read the conversion result directly into scan.channel.
- Rework suspend and resume hardware handling around scoped mutex
  locking.
- Remove the buffer predisable callback. Every conversion path already
  leaves the ADC interrupt disabled and ADIF0 cleared, and the callback
  could access EADC registers while the clock was gated after a failed
  resume.
- Make repeated suspend handling safe after an unsuccessful resume and
  avoid unbalanced clock disable operations.
- Only call iio_device_suspend_triggering() and
  iio_device_resume_triggering() while the buffer is enabled.
  pollfunc->irq is not initialized until the pollfunc is first attached
  to a trigger, so calling them unconditionally, as v4 did, could pass
  an uninitialized IRQ number to disable_irq() and enable_irq().
- Drop the redundant clk_enabled flag pointed out by Andy Shevchenko;
  the suspended flag already tracks whether the clock is gated.
- Add a comment explaining why the EADC register map is left uncached.
- Describe the readable, writable and precious EADC registers in the
  regmap configuration.
- Apply the requested structure layout, variable scope, formatting and
  control-flow cleanups, including the if/else chain in init_vref().
- Drop the unused linux/io.h and linux/iio/trigger.h includes.
- Require at least one external channel child node.

Changes in v4:
- Use the common ADC diff-channels property to describe differential
  inputs and keep reg as the logical channel index.
- Restrict differential inputs to the four hardware-supported pairs.
- Restrict channel child nodes to the ADC properties supported by the
  MA35D1 EADC.
- Prevent single-channel and diff-channels from being specified
  together.
- Document that each single-ended input and differential input pair
  may be described only once.
- Remove interrupt-names and simplify the interrupt descriptions.
- Update the binding example to demonstrate separation of the logical
  channel index from the physical ADC inputs.
- Update channel parsing to match the revised binding semantics.
- Store physical ADC inputs in the IIO channel/channel2 fields and use
  address for the logical DT channel index.
- Reject duplicate physical single-ended inputs and differential input
  pairs.
- Use the physical positive input when programming the sample-module
  channel selection and the logical index for firmware-node channel
  translation.
- Use interrupt index 0 instead of looking up ADINT0 by name.
- Add the standard one-hot scan-mask validation callback.
- Use iio_for_each_active_channel() when selecting the buffered
  channel.
- Use a fixed scan structure for the single-channel buffered layout.
- Limit conversion results to the 12-bit ADC data width.
- Always report -ETIMEDOUT when a conversion times out.
- Make timeout recovery best effort so interrupt disable, control reset,
  IRQ synchronization and stale status cleanup are all attempted even
  if an earlier recovery step fails.
- Use devm_regulator_get_enable_read_voltage() for the optional
  external reference supply.
- Rework clock management to explicitly balance prepare/enable state
  across probe, suspend, resume, error paths and driver teardown.
- Improve suspend and resume error-path handling.
- Remove the redundant explicit REGCACHE_NONE setting.
- Split interrupt status read failures from interrupt-source checks and
  handle failures when clearing the interrupt status.
- Use symbolic definitions for the ADC resolution and differential
  scale width.
- Use cleanup guards for mutex handling in buffered capture and keep
  trigger notification outside the locked section.
- Use more specific error codes for channel capacity, duplicate channel
  definitions and out-of-range physical inputs.
- Apply the requested regmap, control-flow and coding-style cleanups.

Changes in v3:
- Document all four ADINT0 through ADINT3 hardware interrupt outputs
  and add interrupt-names.
- Document ADINT3 as the shared conversion and result-compare interrupt
  output.
- Remove the redundant minItems/maxItems constraints from the fixed
  interrupts items list.
- Rework the channel binding for the fixed differential pairs and use
  single-channel for single-ended inputs.
- Add #io-channel-cells so the EADC can be referenced by DT IIO
  consumers, and define the cell as the logical channel index.
- Add firmware-node channel translation so sparse or reordered channel
  child nodes are mapped by their logical channel index.
- Restrict unsupported generic ADC channel properties including bipolar,
  common-mode-channel, settling-time-us and oversampling-ratio.
- Explicitly configure INTPOS for end-of-conversion interrupt
  generation.
- Explicitly configure the ADINT0 sample-module source and clear unused
  sample-module routing.
- Reset the EADC control circuits during hardware initialization and
  clear inherited ADC interrupt enables, result-compare interrupt
  enables and sample-module trigger sources.
- Add timeout recovery using the EADC control-circuit reset, followed by
  IRQ synchronization and stale status/completion cleanup.
- Use iio_push_to_buffers_with_ts() for triggered buffered capture.
- Avoid mixing cleanup guards with goto paths in the trigger handler.
- Add ARCH_MA35 || COMPILE_TEST and HAS_IOMEM Kconfig dependencies.
- Drop redundant linux/bitops.h and linux/mod_devicetable.h includes.
- Use direct regmap helpers, explicit REGCACHE_NONE and
  regmap_assign_bits() where appropriate.
- Use fixed-width register offsets and kernel time/unit helpers.
- Use size_add() for channel array allocation.
- Request ADINT0 by interrupt name.
- Improve system suspend and resume handling.
- Address review comments from Jonathan Cameron, Rob Herring,
  Andy Shevchenko, Uwe Kleine-König and automated review/testing.

Changes in v2:
- Reworked the driver to use regmap.
- Added optional external reference supply support and IIO scale
  reporting.
- Added optional reset handling.
- Added externally triggered buffered capture.
- Added signed differential conversion handling.
- Added fixed differential-pair validation.
- Added system sleep support.
- Added optional DMA properties to the binding.

Patch 1 fixes the common ADC channel property validation.
Patch 2 adds the MA35D1 EADC devicetree binding.
Patch 3 adds the MA35D1 EADC IIO driver.

Chi-Wen Weng (3):
  dt-bindings: iio: adc: Fix channel property validation
  dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
  iio: adc: Add Nuvoton MA35D1 EADC driver

 .../devicetree/bindings/iio/adc/adc.yaml      |   17 +-
 .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml |  174 +++
 drivers/iio/adc/Kconfig                       |   14 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ma35d1_eadc.c                 | 1036 +++++++++++++++++
 5 files changed, 1232 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
 create mode 100644 drivers/iio/adc/ma35d1_eadc.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.25.1

