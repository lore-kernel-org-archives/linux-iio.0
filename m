Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267E2BD033
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778336557; cv=none; b=tw1XuxACBs5h6C/3m2Dt7Alscj3LBCiOTOqcwF7nXIaEVRMZuA63eJVynBPbGHtbROSAMpUI8SPsKy22j9DebvsU/+nrI1N2Shp+PFGDewMNQYgjOLtHxe3nloApvFYkLrva8yqeWGX0Os8/JT2hKHmmj23eaDYc7AKCVn2R3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778336557; c=relaxed/simple;
	bh=PDCyqrDp2cpLbVPkx9BU3X2g2fgR0bLaGYNic8cU7jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qbdG7Fr+C7LAeLZxYG+99BTEd4ThgEZPixdT5uKl09t/DT91sInSq2CbIh5bKnY8dLCuXr7vrfXzuYdQuB9daHQxhP9qEw2t88Bur5I9KCDfvwUuzlfjnLQj//H/6852phK91/O6+hgEifvgOhiRNMRMAq3cURqZDx08NF21+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spAxBN7m; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spAxBN7m"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1792200f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778336555; x=1778941355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jmvg0x6dnke6aX/zgSP8+qEtU0AMd7QFkbsuhFZV/2w=;
        b=spAxBN7mv0K3wkMBiAMhHIWrux5lHfD+4i037NDzDIR13zqnafvlh+YR3y+TJctIOF
         UtJht7surudSP5b+3/cwVEblZnft/l+DcULrXUg8O1ZCKeJ9R2YZ+QowBrr1Nb/AqOX8
         bLMnd71mFYCxEYuMa73m/iYvuYU7QG9HQBg3xIgdYi3vt0E8RKwnAwCWdr80ZuQMntRy
         87aFn0bTania+yxkrixgifACVIc+mnmJ4jKaQPWP11CVx8Eur4C6xTmqVUxOsaJMwayl
         2iktRsy3wfXAVPply5mEuIsqWUObQKKgSsZ+FwcZFqkWBKu/e/lmJqjefhbRG3rckjal
         uxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778336555; x=1778941355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jmvg0x6dnke6aX/zgSP8+qEtU0AMd7QFkbsuhFZV/2w=;
        b=b9Kf/jBYFM3f57xIG8t09rI514k3+92yBob9SxTtO792oFaoNQmrvGmR+CxlhrJDoh
         qHl0yy9LnDH8rKWhA8bTYuRNDzzFNujcl5QsU155YZWdsiPhe3dIbGGs2Wo5bKOhQZ17
         Ure0zlNWtqZRuyDobkwkpIEhTK98VdDFlRRhAldQFy5ZrEVFerPv7OS8CjP7mwCZI4YL
         PG2t/VlNWGOnbU/wdgMzW1ZoevK+Lp6fnuFw5+AIN3rCsgUOvI9142HzG8NUslSE1I47
         MnrZtpnaQNB7DU/m4QotNWLMZsO1wOxUz+IOLg0j4uey09aEraZ+xw4SAdw1cgjjAicw
         h9tw==
X-Forwarded-Encrypted: i=1; AFNElJ+mANKJ81Kbditwap3PUghOhV2WzE0HwEec8OUzYsDw5H1rTfETkixNEVT57OPtkPim8e0KOXITG60=@vger.kernel.org
X-Gm-Message-State: AOJu0YztB2mcF/dAHVAsnyssdRhn92h5k2oHgeTJEOzMu3d0pEmC3/A3
	DdgzfSGemO9ypT6KuuEG/f4ilarA/yNNcLIwxgMDw6Vbl3IfFaVt5DU6
X-Gm-Gg: Acq92OELQfjBTh+1+BwccVjluekxY2qn+4NhePFPxqRM4OxSWBQfFur3fqxy+0BilBb
	qSPlaiGqrVbtBajqMdV+iagjTyYbkCEYUfj9phH+Fm+yRuPFkCpkOSpBoBaPHwAbAe1qkCYIDRY
	22sXMD2HAHI81dt6PwgwFKb8inQKxSrLlngqN6rCu5vtPd3C8Hz4QqL3aO107i57P3sQwoLIW/n
	Hv9OcxkuwaDuLu5h2iSqTc71XTyjRzpk/3/Ac0Yq7mqtjZvlwKnX4pNceL7UQ7LZKCBU/++L/KO
	OUp7qqMF8l4bueVc0k7iZZbtVyc+Y7yNfl1vH1xiimxDx92/Qvh7+qUVtNRoqOc2C3qC9TetmXf
	HupxdT6rtWfyG5hNpZgZhS7RwFerbinogy6572P/FA8z+qMsn/KZ4NIlFyNSi5nijBbfsGwYr9N
	5vElsFdoB16r5QRPqA6oT3OXqqqYSj+ZbWzdupVPLf5KbJl9SF7Mej1+g13w==
X-Received: by 2002:a05:6000:2403:b0:441:2381:b630 with SMTP id ffacd0b85a97d-4515c575330mr26533311f8f.24.1778336554291;
        Sat, 09 May 2026 07:22:34 -0700 (PDT)
Received: from DB-07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45492271510sm15127763f8f.37.2026.05.09.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 07:22:33 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 0/5] iio: dac: ad5504: bindings, cleanups, and scale fixes
Date: Sat,  9 May 2026 15:20:38 +0100
Message-ID: <20260509142047.30302-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

First, I want to sincerely apologize for the long delay between v2 and v3.
I had to step away to focus on finishing my last year studies, but I am
back now to get this series over the finish line!

This v3 series addresses the feedbacks from the v2 review,
specifically focusing on strict DT validation, dropping unnecessary
driver code, and making sure the driver works perfectly at every
individual commit.

Testing & Hardware Proof:
The series has been physically verified on an ARM64 Raspberry Pi 5 using
a custom Device Tree overlay.

The AD5504 is a 12-bit DAC. The hardware scale outputs
now perfectly match the DT inputs:

Testing the 60V path (output-range-microvolt = <0 60000000>):
$ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
14.648437500  (60000mV / 4096)

Testing the 30V path (output-range-microvolt = <0 30000000>):
$ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
7.324218750   (30000mV / 4096)

Additionally, providing invalid DT configurations (e.g., 70V) successfully
triggers the strict bounds checking and cleanly aborts the probe with
-EINVAL.

Changes in v3:

* Dropped the patch adding GPIO control for /CLR and /LDAC. As pointed out
  by Nuno Sá, since the driver does not actively handle or toggle these
  pins, requesting them in the driver is dead code. They remain documented
  in the bindings.
* Combined the pdata removal, regulator _enable swap, and DT parsing into
  a single atomic commit (Patch 5) so the driver compiles and runs cleanly
  at every step of the git history.
* Restored the -ENODEV check for the regulator to maintain ACPI
  compatibility.
* Implemented strict min/max array bounds validation for the
  'output-range-microvolt' property.
* Included missing <linux/array_size.h>, <asm/byteorder.h>, and
  <linux/kstrtox.h> headers for full IWYU compliance.
* Reordered commits to group cleanups before functional changes.
* Dropped Suggested-by tags for standard review feedback.

Changes in v2:

* Replaced vendor-specific adi,output-range-volts with the standard
  output-range-microvolt property array.
* Replaced adi,output-range-gpios with standard range-sel-gpios.
* Split header updates into two patches: alphabetical sorting and IWYU
  compliance.
* Used MILLI and MICRO macros to replace hardcoded values.
* Introduced a local dev pointer to respect the 80-character limit and
  realigned function arguments.

Previous versions:
v2: https://lore.kernel.org/linux-iio/20260310174835.24209-1-0rayn.dev@gmail.com/
v1: https://lore.kernel.org/linux-iio/20260212181955.42724-1-0rayn.dev@gmail.com/
RFC: https://lore.kernel.org/linux-iio/20260210121032.4630-1-0rayn.dev@gmail.com/

Thank you to Jonathan Cameron, Krzysztof Kozlowski, Andy Shevchenko,
Nuno Sá, and David Lechner for the extensive reviews, schema guidance,
and C optimizations throughout this series.

Taha Ed-Dafili

Taha Ed-Dafili (5):
  dt-bindings: iio: dac: ad5504: add output-range and missing gpios
  iio: dac: ad5504: sort headers alphabetically
  iio: dac: ad5504: Align headers with IWYU principle
  iio: dac: ad5504: introduce local dev pointer
  iio: dac: ad5504: fix scale via output-range-microvolt

 .../bindings/iio/dac/adi,ad5504.yaml          | 39 +++++++++++-
 drivers/iio/dac/ad5504.c                      | 63 +++++++++++--------
 2 files changed, 74 insertions(+), 28 deletions(-)

-- 
2.47.3

