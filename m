Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D1382F21;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416954; cv=none; b=XCjXu3BX23oicXuun/Q/yj3pCtXsuzsOrOAd8znsu2GQnvCwUDNyDOqDYZ2hsdAS3uKnXUzSVKFvgfPobJ7T8OqWw0e5IUiy53rSvkgYvnCVqIpGEZ0JauUnDHeoKAlpSUILPK34kTLf+y43HptGawwQ4Aq6O1Uc6nBIFEq1ed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416954; c=relaxed/simple;
	bh=ZoKC/bUaafMWVMHvUxytQmmqw+TQmxqRml503sPRXe8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uWc+bdjSe7T5a/aiRFcfnt4VV3pTnT+hPTNK1XP1hSK2U/y69V4vC78urJ17RDf9SER49dNZV/12keWKF5LUh1iZz9kF5gCcS4lDVBpXt8hVgxD8ZzaubXopJ6jTpEcUHRZWcBzVUkP1S4DA6WQf9W691kZ6xEN+KUd47lnFwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3l7DSOX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3l7DSOX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19E38C2BCC9;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778416954;
	bh=ZoKC/bUaafMWVMHvUxytQmmqw+TQmxqRml503sPRXe8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=W3l7DSOX1ZnpA2plZRX6ymgHVYS4g04ny/X+gmLO/UqPIdzzthGZIw4ZbT4LVg7I2
	 MxHhOcfbHnTFOT96bMGRfJIt5rAtNoZ3t1dd435kSqiUBdOgznVJi0VLU8SQnATnhU
	 nV+Z6ubJ+R+DsbHngBBe+VIJUktpQa5mx9N/fzSP4mh+eJfHj80goCefOpwTzzgNke
	 8h/j2f/3d3wG/H5oaBc9Br2PAfNkrl4fg2UG8soySnoEyeodzy9LYWsEWi6MliU9Bq
	 LPjJ/jiBhl34p8cWCh9HL8mde6oPsuZ6zIFqaWV0Ui8I7SdQ2AeXRqPKRiv2P78RVu
	 eLiHhpy0Hdxcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067B6CD342F;
	Sun, 10 May 2026 12:42:34 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v12 00/11] ADF41513/ADF41510 PLL frequency synthesizers
Date: Sun, 10 May 2026 13:42:18 +0100
Message-Id: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACp9AGoC/33SzU7DMAwA4FeZeqbIdv458R6IQxonWyRYUYsq0
 LR3J62EWpSWo634S+z41oxxyHFsnk63ZohTHnN/LQHSw6kJF389xzZzSTQEpBARWs9JokLR5ty
 3POQpDq33wVtvkgUbm1L5McSUvxb25bXElzx+9sP3csuEc/Z/b8IWWuJkuwiJg47P/urf+vNj6
 N+bGZxoRQjdPkIF6SI5bwUr40SFiF9EA4LdR8T8EsEoDPqYpK0QuUFQ7yOyINx1hrWxRGgqRG0
 QEvuIWmYSokXyxOwrRG8QcTBYXZCQpCbhyrkuVIhZETpqx8yDhcjCGt8p5SrEroiAg3ZsQSwzS
 TQhSK0qxG0QOmjHFQQFJWAwWhhZIQirUsoPtg3m/0kaQWpWUtX/g7gyCg7GgsvWdiY6F1K0if4
 w9/v9B9FhcB1uAwAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778416952; l=6178;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ZoKC/bUaafMWVMHvUxytQmmqw+TQmxqRml503sPRXe8=;
 b=eZtdzGN33h65s/Ra5G4ZpFXppCJ4XGJBL0ftcZjGV/7CtA+EES6K8LMDxkO+MYjdN8eYxfyhM
 IWdFmEo3rFRB9+9VmazeGzdJ9xipPk9e+zjn0/D5sGSjaX4YneNwc4y
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
Changes in v12:
- Contraint charge pump current.
- Fix division-by-zero issues.
- Address PM and sysfs powerdown conflicts.
- Program proper phase resync value in clk divider mode.
- Link to v11: https://lore.kernel.org/r/20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com

Changes in v11:
- Cleanup ext info attribute read/write callbacks.
- Adjust attribute names in the documentation.
- Turn s64 compose macros into static inline functions.
- Link to v10: https://lore.kernel.org/r/20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com

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
 .../bindings/iio/frequency/adi,adf41513.yaml       |  227 ++++
 Documentation/iio/adf41513.rst                     |  199 ++++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |    9 +
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf41513.c                   | 1231 ++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   46 +-
 drivers/iio/test/iio-test-format.c                 |   97 +-
 include/linux/iio/types.h                          |   28 +
 include/linux/kstrtox.h                            |    3 +
 include/linux/math64.h                             |   18 +
 lib/kstrtox.c                                      |  107 ++
 lib/math/div64.c                                   |   15 +
 lib/test-kstrtox.c                                 |  156 +++
 17 files changed, 2128 insertions(+), 41 deletions(-)
---
base-commit: 39b80c5c9830d12d2d6531059001301c4265322a
change-id: 20251110-adf41513-iio-driver-aaca8a7f808e

Best regards,
-- 
Rodrigo Alencar <rodrigo.alencar@analog.com>


