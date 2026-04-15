Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E449620;
	Wed, 15 Apr 2026 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246738; cv=none; b=MS3FnO3J9OjnqQK6LMf/NtBncxZjcF01E/rm6ZLg1UXfHNsCh/X9xPYfaiRGmftYDX8DY17HUh5dJrHrwCFHfD8DDEZBbUkV1eBpH6GAUqjsijjQDvsAoitEdQmQLHyj7GuScI1p/v4hH8ecdIT/wiUBY3F7fQbhunEcvttKgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246738; c=relaxed/simple;
	bh=E7ohc+5HI34LA90rb1Vi3xuwFJuUmdYszhbR3LGbazA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X8ljVhmHSOtKdeiZjRn4zDJ1bANT+bITJ11nArTNWVCSw7ukzWe6fSBLOwFV8Uq+cryVUL/rXlgEuWZD6e6cBmtuUXIJPd11Woqh4G18/IE59GPDLXREbkCCtFQUqctK7EvHOhHBLhJdPH6oHYrFerDNTrv3Wj3AEdXAiKqyDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elxq9m38; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elxq9m38"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD14AC19424;
	Wed, 15 Apr 2026 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776246737;
	bh=E7ohc+5HI34LA90rb1Vi3xuwFJuUmdYszhbR3LGbazA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=elxq9m38qbIayhZJjbr/wVbU095FNjgDiMpLjLfuJPC1rlXFGv1XwSs+PHJfbmCNY
	 iOJKUi2NEKIG9fCEIK0o34sv4Gz+rcUOW8ltd8ErOqRuPEG4mn8Z7qAcQh86m1z9HJ
	 GhR6IkXL/la7DUcZBNCKbU80ajDD/qU4wsX//iG/1kci9EPaVJeyHA0nlQAcRgzbiQ
	 DLZ7QbVD1WLxp+mr/DALwkdKZSCNVAGmucxN9yogZVA/HWHGzjXfWw9TfZ91Jscviq
	 D+E58DGbY7inl19USU8st8E29H7gBTSoY/S/EweJAROFOWEP5CjFdqLcXM/EEJQBUr
	 yfSCEu69oLtgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF01F41988;
	Wed, 15 Apr 2026 09:52:17 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v10 00/11] ADF41513/ADF41510 PLL frequency synthesizers
Date: Wed, 15 Apr 2026 10:51:43 +0100
Message-Id: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK9f32kC/33QTU7DMBAF4KtUXmPkmfFfWHEPxMLx2K0laFCCI
 lDVu+NUQg1ywnJG9me/dxFTGkuaxNPhIsY0l6kM5zqAejiIeArnY5KF60KgQgMASgbOGgyQLGW
 QPJY5jTKEGHxw2SufRL35MaZcvm7sy2udT2X6HMbv2yszLNv/vRmkksjZ90lljjY9h3N4G46Pc
 XgXCzjjHUHothGsSJ+wC57YuI4ahH4Rq0D5bYSWnxADOQgpa98geoWA3UZ0RbjvHVvnEcE1iFk
 hSNuIuXUSkwcMyBwaxK4Q2inWViRmbZG6eq6PDeLuCO7FcUuxKjF5F3pjugbxd4TUThxfEc+MG
 lyM2poG6VYI7sTpKgKEWbFylpz+g1yv1x/0IMDX4AIAAA==
X-Change-ID: 20251110-adf41513-iio-driver-aaca8a7f808e
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776246736; l=5612;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=E7ohc+5HI34LA90rb1Vi3xuwFJuUmdYszhbR3LGbazA=;
 b=IgqmOzVqrrLgfvLePdOLKXNnG3kb6nTCXP/yWc3PB3ojeUfCEHJdf11XoR+A4/PsSJbgh71zI
 O7pFF09XAQaCWJHzEfPXbZU3Ddf1o+uIo04n2HEm1HxSXB0Rw/N4QMG
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This patch series adds support for the Analog Devices ADF41513 and ADF41510
ultralow noise PLL frequency synthesizers. These devices are designed for
implementing local oscillators (LOs) in high-frequency applications.
The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
operates from 1 GHz to 10 GHz.

Key features supported by this driver:
- Integer-N and fractional-N operation modes
- High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
- 25-bit fixed modulus or 49-bit variable modulus fractional modes
- Digital lock detect functionality
- Phase resync capability for consistent output phase
- Load Enable vs Reference signal syncronization

The series includes:
1. PLL driver implementation
2. Device tree bindings documentation
3. IIO ABI documentation

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v10:
- Drop simple_strntoull() changes
- Create kstrtodec64() and kstrtoudec64() helpers. 
- Add IIO value format for 64-bit decimal values.
- PLL driver code implements new decimal format for frequency attr. 
- Link to v9: https://lore.kernel.org/r/20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com

Changes in v9:
- Expose simple_strntoull() in a safer prototype instead of new kstrntoull()
- Link to v8: https://lore.kernel.org/r/20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com

Changes in v8:
- Add new function kstrntoull() to lib/kstrtox.c and tests to lib/test-kstrtox.c.
- Drop custom iio u64 parser, replacing it for kstrntoull().
- Dedicated MAINTAINERS entry for drivers/iio/test/iio-test-fixpoint-parse.c.
- Link to v7: https://lore.kernel.org/r/20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com

Changes in v7:
- Addressed minor suggestions.
- frequency_resolution ABI for AD4350 removed in favor of generic one.
- Link to v6: https://lore.kernel.org/r/20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com

Changes in v6:
- Drop usage of simple_strtoull().
- Implement better overflow checks with iio_safe_strntou64().
- Link to v5: https://lore.kernel.org/r/20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com

Changes in v5:
- Drop local parsing of 64-bit plus fractional parts
- Add iio_str_to_fixpoint64() to iio core with parsing tests
- Add DT property dependency for adi,charge-pump-resistor-ohms
- Add local definition for ADF41513_HZ_PER_GHZ and drop units.h patch
- Link to v4: https://lore.kernel.org/r/20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com

Changes in v4:
- Proper usage of units.h macros
- Simplifications to DT property parsing
- Adjustments to return value handling
- Drop of simple DT property node example
- Link to v3: https://lore.kernel.org/r/20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com

Changes in v3:
- Use FIELD_MODIFY macro in driver implementation
- Drop refin_frequency iio attribute
- Drop muxout-select property from dt-bindings (and rename logic-level property)
- Use -mhz suffix in power-up frequency property
- Address documentation issues
- Link to v2: https://lore.kernel.org/r/20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com

Changes in v2:
- separate driver implementation from extra features and improve commit messages
- use macros from units.h
- explanation of custom parse function: adf41513_parse_uhz
- reorganize driver data structures
- drop clock framework support for now
- reorganize documentation
- Link to v1: https://lore.kernel.org/r/20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com

---
Rodrigo Alencar (11):
      dt-bindings: iio: frequency: add adf41513
      lib: kstrtox: add kstrtoudec64() and kstrtodec64()
      lib: test-kstrtox: tests for kstrtodec64() and kstrtoudec64()
      lib: math: div64: add div64_s64_rem()
      iio: core: add decimal value formatting into 64-bit value
      iio: test: iio-test-format: add test case for decimal format
      iio: frequency: adf41513: driver implementation
      iio: frequency: adf41513: handle LE synchronization feature
      iio: frequency: adf41513: features on frequency change
      docs: iio: add documentation for adf41513 driver
      Documentation: ABI: testing: add common ABI file for iio/frequency

 Documentation/ABI/testing/sysfs-bus-iio-frequency  |   11 +
 .../ABI/testing/sysfs-bus-iio-frequency-adf4350    |   10 -
 .../bindings/iio/frequency/adi,adf41513.yaml       |  215 ++++
 Documentation/iio/adf41513.rst                     |  199 ++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    9 +
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf41513.c                   | 1230 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   46 +-
 drivers/iio/test/iio-test-format.c                 |   97 +-
 include/linux/iio/types.h                          |   33 +
 include/linux/kstrtox.h                            |    3 +
 include/linux/math64.h                             |   18 +
 lib/kstrtox.c                                      |  105 ++
 lib/math/div64.c                                   |   15 +
 lib/test-kstrtox.c                                 |  156 +++
 17 files changed, 2118 insertions(+), 41 deletions(-)
---
base-commit: 0ccdcdc698b7ba52f2c9bc09bfdf9f020ca0e6e6
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


