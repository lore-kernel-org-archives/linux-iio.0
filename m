Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690119;
	b=RvlYaKpebPi4U6hKQBTzBK9Dqm0gSx2ZK4TQa9cxGgfnvHwHIIWAxqN6J+CxALdYPrZW
	 q9M8ga0L5gs/UbEHgdXSUHyZccB0JR8SejQMZmzfk5PzRDggp+U1uSoZhBJTGOHSPnom+
	 y6tX/8LShYUhTZr9IJNuPoQx/1esUeBLr82yWileqtyeqpklV7qYsR2SOOlcX9o3kxmO8
	 z5VTGeUiKQAeP6FY8X52w0A0tMktWMG7C+uJ/HPR0mQlbFNJbOy9963a1/840Tglovmc3
	 iDrB+AA+DkMA4pjKxCaLnSz+1ZDlUxbyfk4iwQSBDoAAFZhFGcQkNXWhasxyplbcong==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=q0JMax0vQd34r8Jzb5i5IRxK+8bWWNqoR9qhYGl1CV0=;
	b=uGreCeU+PdvAdwDpPaAO4TiRoMAT9/o7ASamo3bKKlfHD9eCX+Tvo54AackKpb439c0U
	 XplfG8RCvOaQhN0B5G9qEkXX5tTgDFAaXksvDDJ7+XAhjkF36EnRe1vkS1Y8sg+nY3ibq
	 kDFVLPwv9YJ4NviAGMfu1o4/gVbJilkI1EZnQBW1AgnXyUQ2TcqRdm+Bygi0sEhgx169X
	 L8lLAq8AtLMnXvuTGEVa3XJD7zIMCZ6PNPsLgiz6v7czB18WnNvIwfN7xAGzXM87tGivF
	 XBruUSbO/q+ZAXv+3oL7DSD+1bXRfxh2q2tJPGz5Le6qGEIbGoLVGKK7I3Hcy3QXVjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WtWIng6q;
	arc=none smtp.remote-ip=209.85.167.69
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71232606A32A
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 10:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71232606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WtWIng6q
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5be48f8ead6so2263888e87.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 02:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795690117; x=1796294917; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q0JMax0vQd34r8Jzb5i5IRxK+8bWWNqoR9qhYGl1CV0=;
        b=WtWIng6qiA1bZhsEZv9EXNHqO8u216P83uzKrgyZ2VbAqGmboo1P+tVo9XyBaWi58H
         Dc3SgjZ5iLWhYqyd6i1dJtvi/LG5nqhjBXV/hsJZwWSm6mfFfrp3WLg8gkuBQfa938pK
         T+t3+mUVXo/JwfSZ8ogKRix/YTe17ItIwzKJ77EfbG/GW86PVLCfYdTl7Am3WUO9MlLh
         ToG1Jw/raINQur7OsRzW29cNMg81DFpRWxzejYarM6AVV1wbuObZIhMpzvkHD/C4cPsJ
         X0Waun97kjp7/H06Vw+yiuTTBcXa3sGI6jeFFjBH/QjDBGbGyyrPJRL6SDm0g6KZtr+J
         H4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690117; x=1796294917;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0JMax0vQd34r8Jzb5i5IRxK+8bWWNqoR9qhYGl1CV0=;
        b=gIXrr705LwJrI1qyTLUz317sb2/fz6nBY6Xllz5Q09v0Ha0D7YKcnseLvtCgZfqO3/
         49j8evD3OHfh/6jL4lO8l+Lf4bN+5sdyOrWFFK4k2eqcck2h4UjKPnIA4+GlzyJWeVG2
         mBqz1xWYoNyyPQ/NrczxhGXFp9iEc2Jn52D61UAhPlWy+h1bPbKuDrn+256cEHRJAPSJ
         7EkV3/oGQoFk63bI7sjRWGBz5abFHVMW3nke13U7UXXu3wpzj9TfABSFWmpYCrh/SBtL
         RiaASxyNjLZCiGqhmtIXgeiSlsdf8KUSKY+vHfyY8fey+vGHSf0r5x+RF2SFvAh05vrL
         dtRQ==
X-Gm-Message-State: APuU4Z9gKOMHC4jrqbde4d1/EbzLEPHJhh+TIH6gTi/mVKViSQSrLfs5
	FlcLQe9hSkdTyna0KaBP8FKd/Fa87o039WNed0pNHD9334DcTmLLYZVincH6R/k0MoWnhQx5ng2
	L5Mg85hV8mA==
X-Received: from lflu22.prod.google.com ([2002:ac2:43d6:0:b0:5c1:a392:10d])
 (user=dbalint job=prod-delivery.src-stubby-dispatcher) by 2002:ac2:4f09:0:b0:5c1:57d9:270c
 with SMTP id 2adb3069b0e04-5c1bc8743dcmr5885193e87.46.1795690117479; Thu, 26
 Nov 2026 02:48:37 -0800 (PST)
Date: Thu, 26 Nov 2026 10:47:55 +0000
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126104757.2860272-1-dbalint@google.com>
Subject: [PATCH v2 0/2] Introduce cros_ec power monitoring
From: Daniel Balint <dbalint@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, mfd@lists.linux.dev, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, mwojtas@google.com, 
	Daniel Balint <dbalint@google.com>
Content-Type: text/plain; charset="UTF-8"

This series adds the ChromeOS EC On-Device Power Monitoring
(cros_ec_pwrmon) driver to read onboard power-monitoring ADCs, such as
PAC194x, wired through the embedded controller (EC).

Several ChromeOS platforms are equipped with onboard ADCs connected to
the EC via I2C. The driver interfaces with the EC via the existing
EC_CMD_PWRMON host command API and EC_MKBP_EVENT_PWRMON events to manage
ADC accumulation and expose per-rail accumulated energy through IIO
energy channels and a triggered buffer. The driver is only loaded when
EC_FEATURE_PWRMON is advertised by the EC.

This is a borderline case between IIO and hwmon. IIO is used rather than
hwmon [1] because userspace queries all rails (up to 64) together as a
coherent frame -- for example, to compare per-rail drain contributions
across device-state transitions (such as screen on/off triggering a
snapshot) and to correlate fine-grained ODPM frames with other
timestamped system diagnostics for off-device per-process, per-rail
energy attribution, where relative deltas across channels are as
important as absolute values. Since a single EC latch and MKBP delivery
takes non-trivial bus time, latching per sysfs read across 64 files
would introduce significant inter-channel skid and redundant EC work.
While driver-side caching in hwmon could avoid per-read latching, hwmon
has neither an on-demand trigger ABI to force a fresh latch nor a
timestamp ABI to report the actual latch time (or expose whether a read
hit cached data or crossed a mid-sweep cache expiry), making IIO's
explicit trigger, latch timestamp, and single buffer read a cleaner fit.

Reference to detailed v1 discussion:
[1] https://lore.kernel.org/linux-iio/20261120091022.1459658-1-dbalint@google.com/

Changes in v2:
- Dropped v1 patch 1/3 ("platform/chrome: cros_ec: fix alignment of
  ec_params_pwrmon"), already applied to chrome-platform/for-next
  (346739bcdf65).
- Replaced custom multi-value energy_value sysfs attribute and its ABI
  doc with standard buffer-only IIO_ENERGY channels (.read_label, scale)
  and an IIO triggered buffer with IIO_CHAN_SOFT_TIMESTAMP
  (CLOCK_BOOTTIME); selected IIO_BUFFER and IIO_TRIGGERED_BUFFER in
  Kconfig.
- Replaced wait_queue_head_t with struct completion.
- Grouped per-channel state into struct cros_ec_pwrmon_chan, and used
  aligned_u64 scan buffer.
- Switched EC host commands from legacy cros_ec_cmd_xref_status() to
  cros_ec_cmd(), which manages msg buffers and cleanup automatically.
- Dropped redundant st->ec and st->msg fields, used local params/resp
  variables instead of casts.
- Added an event_size check in the MKBP notifier.
- Fixed signed/unsigned energy integration and channel counting for
  duplicate/out-of-range MKBP events; returned -EINVAL for missing
  channel labels.
- Switched probe error paths to dev_err_probe(), clamped channel count
  with min(), hardcoded indio_dev->name to "cros-ec-pwrmon", switched to
  devm_blocking_notifier_chain_register(), dropped direct
  <linux/mod_devicetable.h> include, and used named initializer with
  "{ }" sentinel in cros_ec_pwrmon_id[].
- Capitalized "Load" in the mfd patch subject.

Daniel Balint (2):
  iio: adc: add cros_ec_pwrmon driver
  mfd: cros_ec: Load cros_ec_pwrmon on supported ECs

 MAINTAINERS                      |   7 +
 drivers/iio/adc/Kconfig          |  13 ++
 drivers/iio/adc/Makefile         |   1 +
 drivers/iio/adc/cros_ec_pwrmon.c | 370 +++++++++++++++++++++++++++++++
 drivers/mfd/cros_ec_dev.c        |   9 +
 5 files changed, 400 insertions(+)
 create mode 100644 drivers/iio/adc/cros_ec_pwrmon.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.1.839.g22a8290db9-goog

