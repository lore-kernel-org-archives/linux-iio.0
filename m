Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57269335543;
	Tue,  3 Mar 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544445; cv=none; b=hNEEv2oZPt8H4zonKoMfQQnFjw4cuHKTrxCFnSdigoDwxnuZxsEVT3q/47PfL9ODmy7+n0yn8QI2mntLbFXuoHFqoVtY/Oz8Ljkw8yfpMLc31wEw1DQ03Duy9IiSIzNiwVZjZRIu65lD+YXgbMhJ//xVktj1U2PAYE/eQPX3EVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544445; c=relaxed/simple;
	bh=oQ18lU+cSsDbl0sd4Y3oXZBV21JoGiUMKeTFizDUe2g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HxziD/iEmbnOAr/ADuxec1KrJMsaiOqVuHd/9urQocbiOVWacCJaUB3r4b7cjhuOAnR4ju7zTzc1c8CtVXqOu4CR+mb49k2BEIbUh0atl48ossTUpYc12vvk8iqdEud+oMraHADNjPVt6MWvhmbRVCyLBDqj5kwGvKlzNhoS4xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgQ592a7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgQ592a7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED4C9C116C6;
	Tue,  3 Mar 2026 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772544445;
	bh=oQ18lU+cSsDbl0sd4Y3oXZBV21JoGiUMKeTFizDUe2g=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TgQ592a7uqv9pP0Sj8erTpQHPIK0y7RL8DOZIvZvRAK4Eav+j7YOdwpIvpRK0lX5Z
	 1+0j2sCSzTFFGSL9zK8mOh/TkeTOHDdjwb9DAgGgN8aGo6QlXdGgnsG19WKZcbNV36
	 41IR70KBslfdg4tRPDfEqCc5ipvq9YZUk+bBaGs+SUTlHO6zwnDoM0AgHvaoG2/p5f
	 eS1v3N1/7Qk97XqQ/dAz7/hYQ5K05tL27nJ2nDwehgm6uiUVzqIuTMmKRW/uyVnq0c
	 jJRAG5m8szZ9+WfSH4Jw4Z3Q4YYLDOidYI2EzkLqYnNAllJCsWux+6Obz7b7FuEzo8
	 wG3yk5FZeE6qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5536EC143E;
	Tue,  3 Mar 2026 13:27:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v8 00/10] ADF41513/ADF41510 PLL frequency synthesizers
Date: Tue, 03 Mar 2026 13:27:05 +0000
Message-Id: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKrhpmkC/33Q3U7EIBAF4FfZcC2GGcpPvfI9jBdTGHZJtDXUN
 JpN313axGxNu14eAt8w5ypGLplH8XS6isJTHvPQ1+AfTiJcqD+zzLFmgQoNAChJMTVgQMucBxl
 LnrhIokCeXPLKs6gvPwqn/LWqL681X/L4OZTvdcgEy+n/3gRSSYzJd6xSDJafqae34fwYhnexg
 BPeEIT2GMGKdIwteR2Na/UO0b+IVaD8MaKXn+gI2gFxavwOaTYI2GOkqUjsOhet84jgdojZIKi
 PEbN2EtgDEsZIO8RuEH2nWFuRkBqLuq33urBD3A3Be+u4pVjFUXtHnTHtH2Se5x+YJMCsVQIAA
 A==
X-Change-ID: 20251110-adf41513-iio-driver-aaca8a7f808e
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772544443; l=5006;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=oQ18lU+cSsDbl0sd4Y3oXZBV21JoGiUMKeTFizDUe2g=;
 b=Nu0gUpvI9dy6EOiGvFx5y6+ECQ0ztHV/IMxMPiTW85CcXwxZKJXxRrmTZDYa0aoOs2UL/He5e
 R+2JF9CyWjnDRUArPWPx2L10dQEcZmHNgRHGVMi5WABh4MlcKOxlpeJ
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
Rodrigo Alencar (10):
      dt-bindings: iio: frequency: add adf41513
      lib: kstrtox: add kstrntoull() helper
      lib: test-kstrtox: add tests for kstrntoull()
      iio: core: add fixed point parsing with 64-bit parts
      iio: test: add kunit test for fixed-point parsing
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
 MAINTAINERS                                        |   15 +
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf41513.c                   | 1240 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |  167 ++-
 drivers/iio/test/Kconfig                           |   12 +
 drivers/iio/test/Makefile                          |    1 +
 drivers/iio/test/iio-test-fixpoint-parse.c         |  470 ++++++++
 include/linux/iio/iio.h                            |    2 +
 include/linux/kstrtox.h                            |    3 +
 lib/kstrtox.c                                      |   47 +-
 lib/test-kstrtox.c                                 |  121 ++
 17 files changed, 2461 insertions(+), 64 deletions(-)
---
base-commit: cce8de7f9744a210a4441ca8a667a9950515eea7
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


