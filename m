Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D903D0905;
	Fri, 20 Mar 2026 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024052; cv=none; b=ILo0K0Wg32iw5Ql32e8qaWTyxqqM+ytG/bvktdaQkwNGnVwG03go1rng6rY2jB9ChEGvNjX9d2wlyFv6WMfhZPFClniVf3gvYFSIg7ValPnnL7fdbV7yIDvm99g9Uphyf1sdqeSm4322+bvXqSDxxlaLu6XMZxY3iSDOlvLWsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024052; c=relaxed/simple;
	bh=7PGIryYli88ssy+n8crCjrycDy/14UXhmOzk3wM6AR0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QvhVLBudidMHuo4l9qTdF6bAE/M/NyVGX5pxNPJGhI8SFxf8Bu68S2x/s2z5Un09b9H2/bTjpzB5iIe1ZX6lrCZ+Z4MdAjHKg2sF9+WA4a6jjKRUh3r6CJZmB87ORf9ZEtvBELBQPGqa1bJi0GXvtX6917H9W7r9vxlIOTFvnuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIht41pc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIht41pc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D985C4CEF7;
	Fri, 20 Mar 2026 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774024052;
	bh=7PGIryYli88ssy+n8crCjrycDy/14UXhmOzk3wM6AR0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RIht41pc0fWi6hNhgyoNTcBLL/jU3FKeNIi//YZZgAnoeENlKsFHgtg2zA3jrmlaJ
	 hfe0ScJsquNbAdibs0J9Ovu3d6Jg18Xv8sDBF22g4/op1jVOK2npPlElxe6xOV4XXb
	 NxSukz+rILobSl/plmzGBby/JD4JT1aMJgyW5WfCGNV27JyiaDiSoBVPTLNAXkRzmF
	 +mmM+/WrhBKo0xk5hJ1FBcPN0+HlEHI+6kNeP/AP1m7ZX4dPC7AQlMZYP4Lm+aR2f1
	 lhbeqhhMV013N/CHqI1kcg00LAcp2ghgzHmU/5GGYC+dHZddxxDkGe7foYZy9L7vVX
	 VbZvHUAoRrBdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633D1109879B;
	Fri, 20 Mar 2026 16:27:32 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v9 0/9] ADF41513/ADF41510 PLL frequency synthesizers
Date: Fri, 20 Mar 2026 16:27:25 +0000
Message-Id: <20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG11vWkC/33QTU7DMBAF4KtUXmPkGf9NWHEPxMLxjFtL0KAER
 aCqd8ephFqUlOWzPJ8976QmGatM6ml3UqPMdarDsYXuYafyIR33oiu3rNCgBwCjExcHHqyuddA
 81llGnVJOlGIhQ6La5McopX5d1JfXlg91+hzG78sjMyyn/3szaKORC/ViCucgz+mY3ob9Yx7e1
 QLOeEUQum0EG9ILdoks+9jZFWJ/kWDA0DZil59YBhshSXG0QtwNAmEbcQ3hvo8cIiFCXCH+BkG
 7jfhLJ1kIMCFzWiHhBrF3ig0NycUFtF271+cVEq8I3lsnLsUaYUsx9d53K4SuiDV31qGGEDM6i
 Dm74P8g5/P5B0BN18eaAgAA
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774024051; l=5107;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=7PGIryYli88ssy+n8crCjrycDy/14UXhmOzk3wM6AR0=;
 b=vJyPzLkgVuaYdYsSmqSVbWXZDqDB3xMBz7fVKY1kSrVdHCnt9QWM0cvpnz0tHAsbpGyPzlZkR
 mI79zMXVa+cDaQFTZh8Kf5dtxAcB2uxN4mkTe/x+K9yD16UJcFr/mJn
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
Rodrigo Alencar (9):
      dt-bindings: iio: frequency: add adf41513
      lib: vsprintf: export simple_strntoull() in a safe prototype
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
 drivers/iio/industrialio-core.c                    |  165 ++-
 drivers/iio/test/Kconfig                           |   12 +
 drivers/iio/test/Makefile                          |    1 +
 drivers/iio/test/iio-test-fixpoint-parse.c         |  470 ++++++++
 include/linux/iio/iio.h                            |    2 +
 include/linux/kstrtox.h                            |    4 +
 lib/vsprintf.c                                     |   59 +-
 16 files changed, 2346 insertions(+), 69 deletions(-)
---
base-commit: ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


