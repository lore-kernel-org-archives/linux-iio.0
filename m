Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002A1A9F83
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792368804; cv=none; b=FbzlpMQY5aBT2PZmeFBhNRp+lZwJVTN5sjfC2D+t7k4QXPFcSMuUoXTwx7MwCtG2FfbdLNRwAc0JRyNPncSo6KlemkS19tbliifNROUtC132GhTTmD0A2EmCS+ED1zBktEPV29824O6S9lp04w7s8T6CIXhkkeauqJI+uQuLcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792368804; c=relaxed/simple;
	bh=knf+1wF9ksJgxjHb4wumyiicX5OX4gIFh9hhKLR9xII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxuQ10fXKOqvPMCenhaVOuNSQkK3oicr9CZp0HMOidWAraP/R9TPuSTh2s/IEDxDrUZaIbaW/wR62o/bE+OyaTitOMv95wGipMzSeqPs9ocOPveThvwfiIRGYTq5XIZxnzZxrvYqomG9i0RrSdbjPBtJirfns36sIPW+FW8cEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkmkcQCJ; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkmkcQCJ"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3550c917fd3so1790547eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792368800; x=1792973600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fmCKVuEhcyinCJJCJLug0EcJL3YbcTgm8cMUgb76yLI=;
        b=QkmkcQCJyS6d41rPG9LU1Ov4luGbPAd1t6J+2phi29Bp1qSnz3VRJA7iAZi/Mn1sGv
         75GbsItHf9CPKicpXA/P6+BpfUz1NEyHmNPRzU19Qo++cmxu9L79kmgv9A20q7Igzx6X
         Hl7gGLNXxaBhwOB2uaKo5jCGMQNm03pD+XZdmwQdU57vgc1911BYoyeyEj2DKhhsK4QF
         YAezqfJNEMz2WZRFJKdGANP4dOVUx14w0je8wrPPb0DRXKr/5xh5AC0rQ431XxRs3TRn
         x/5R0qwPMcL3ivxyHx3RtBMe+wrNVaGd6N1MVgx5isvBSOvGuq2qkuvgGDStdpIdlSW7
         Igfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792368800; x=1792973600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fmCKVuEhcyinCJJCJLug0EcJL3YbcTgm8cMUgb76yLI=;
        b=nz86vr8zvGq2XbPFsizQy3vugQql/6bE+GgmEPoQQZuazuXB8sXTwkawzesUC6ShqR
         EtydqOO/kajEMHnDgUn8jmkLB/rTGw+M4xPGt0NiO80PJcc2H9rejPsHEtACpFZgDqXt
         86vl2mtPYCr34OAPZew0VNWF4tVQpnbyGpewxUA0sJcKWO91kPoqz8T5FxmzNW4ZxC/0
         sPZehxbF9T9wD8yT0RNT21h8fbQDTPmhVCXsQEmhDaQJmFbTfq/bZdwyoTnhtzNtKvte
         p5b6bvhFSOJUWQd5+hWAq9D1hwJ6HbkgsQhSFAzJ5nGcdWRStA2EkIHKIH4TdTq6oJU7
         3lfA==
X-Forwarded-Encrypted: i=1; AKwUvBynCT//6Nxzy7hxNRztzPeKeu2+inl9ESwtfGE5EL1qt44fxChLnMOUyCPCJ3z4gmfbTOAbE+qfbuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkEz7hmiWNPFmE3FdQV1Jkc76AkYiyq8iQBsrQI6xNlo6IC91J
	KXyBDECS6gOYY3LbgzbnibQpBI5/TpdQH39Htn1RDHgUX3xdrnOPR40t
X-Gm-Gg: AYBFou3aKFva6fqW4mHpVG5xIDCHGoP8+zRw1pbwEtURSU+ftg2/x/2u6IYlqZxMzXh
	IzmGnN1d+HGeDgsbg/dL1qMDRLywdULsULAZ7bu3lky4cEVa3KKA+S9zUerwA4xawmfrByS5UKc
	t3IPCKAHvPNlCiSW8USbZM0Va0wGTmB/MENgSYQT0or0ldvc0QD0V+Nw1/NkjLyP5ksE5e6HYAq
	kkKA1T5lpxFCOy/RQQTTXoDERpbeoWNhTHpjDXfFBAVc22XCbSQBTJeXZGtzRhC7Mgyv3B1g1L9
	FssTSD3XyMRtj0aWNHCEdprvie5RSsBUrIzx01y0fVJ9lTNnq59GohraG3IAyIT4zy8t9Q45Tqt
	XgAkIMUqNrQNlpfaDV0jIDum+lpJIlpESjualp1v/xeO4HdQ77CnDe4Gj9M9U59JMEXSo9wICTT
	KVfUxyQpIuiO2WCc6xZJvLu/rIBtanLp8bqmT6lxo6fLXJtqZ/0n8vG7F6qAy8g31OJEQommHPe
	2LQvNDwkXWFwsqvI5EKnmI=
X-Received: by 2002:a05:7300:7a9e:b0:361:1dd6:531b with SMTP id 5a478bee46e88-361a2052bebmr8300968eec.26.1792368800338;
        Sun, 18 Oct 2026 17:13:20 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:9a49:ae2e:1b25:b04a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082f7f6e0sm30631371eec.27.2026.10.18.17.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 17:13:19 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephan Costa Barros <stephanbrrs8@gmail.com>
Subject: [PATCH 0/2] iio: adc: add TI ADS1299
Date: Sun, 18 Oct 2026 21:12:45 -0300
Message-ID: <20261019001247.483005-1-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a driver for the TI ADS1299 family (ADS1299, ADS1299-6
and ADS1299-4): 24-bit, simultaneous-sampling biopotential front-ends
for EEG, on SPI.

This first version keeps to the generic IIO ABI: raw reads, the gain of
each channel's PGA through its scale, the sampling frequency, and a
kfifo buffer fed from the DRDY interrupt with a software timestamp.

The part has more, which I would like to add in follow-up series, each
with its own ABI discussion: SRB1 and SRB2 reference routing, the bias
drive amplifier, lead-off detection (through IIO_EV_TYPE_FAULT and
IIO_EV_DIR_FAULT_OPENWIRE), the internal test signal, the temperature
sensor and supply monitors, GPIO1 to GPIO4 as a gpiochip, the CLK pin
as a clock output, and daisy chains. The binding already describes the
hardware for those.

A question on structure. The driver started from ti-ads1298.c, and in
this subset the two are close. What differs here is the PGA gain table
(1 to 24 against 1 to 12 with 3), the data rates (no high-resolution
mode), the fixed 4.5 V internal reference, the ID register layout and
the 4 and 6 channel variants; above 0x14 the register maps also part
(MISC1 and MISC2 here, PACE, RESP and WCT on the ADS1298). Most of what
would follow, SRB1 and SRB2, the bias drive and lead-off on every
channel, is specific to the ADS1299, so I kept a separate driver. If you
would rather have the ADS1299 as a variant in ti-ads1298, I can rework
it that way.

Tested on a Raspberry Pi 4B running 6.18.50 (Raspberry Pi OS), with one
ADS1299 and DRDY on a GPIO edge interrupt, the driver built out of tree
from this patch:
- every value in in_voltage_scale_available and
  sampling_frequency_available written and read back, and values outside
  the lists refused;
- the internal DC test signal, routed through debugfs register access,
  read at gain 24 against shorted inputs: -0.08 % to -0.41 % from
  VREF / 2400 across the eight channels, as with the out-of-tree driver
  on the same board;
- a 10 s capture at 250 SPS: 2497 samples for 2497 DRDY interrupts, no
  gaps in the timestamps, and buffered values matching direct reads.
So on 6.18 the driver was run and tested as above; on the IIO tree below,
the same source, unchanged, was compiled but not run.

The series is based on the testing branch of Jonathan's IIO tree
(git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git).

Stephan Costa Barros (2):
  dt-bindings: iio: adc: add TI ADS1299
  iio: adc: ti-ads1299: add driver for TI ADS1299

 .../bindings/iio/adc/ti,ads1299.yaml          | 221 +++++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  14 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1299.c                  | 897 ++++++++++++++++++
 5 files changed, 1140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1299.yaml
 create mode 100644 drivers/iio/adc/ti-ads1299.c


base-commit: 19c5db3507633edc21b4172d99f573c2dfbf42b1
-- 
2.43.0

