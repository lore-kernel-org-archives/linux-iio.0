Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4F28751B;
	Sun, 14 Jun 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470613; cv=none; b=WCP5U8bUHC+KcGGj4sEXfOzBp8F6ikjm3+SMjAWOFXQvclxoUHbJj7S+3Gj9+i6rY3gvoZCVQa5fLTsNSf+6FjVo0sQWcIyAqTZXZjDGaGqsFTNX9S7FuAz9YU66VBISWyq4V7bgXoFK1rmSO2zXa2BIWWno31h/cCofbO2P2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470613; c=relaxed/simple;
	bh=pOBUDQ3EIq70FBYrbFPX3bGh/Ydeaxa7tj8ebyFy/To=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POVgJpMdB/asyqhgxV/QLdsoO642z3Kv4uzeMS/JDb3/EhRQERLFFEtUw5JLP9s4guUh+6od+Z497ufBlhzACtI7dEinvKXmhO12RraLrIvd6zhOFlW+9GEfTa7iG4ZYdhXZ/UKmNA3F2+Qk9ELXoOUuo3FlCQb3ltuQCmd1QwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZneq3VE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZneq3VE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675B01F000E9;
	Sun, 14 Jun 2026 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781470611;
	bh=kOpUjZxdPvUScW2Ukddlqqju+iyco1akLGq7vSPTMIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DZneq3VEquWDvhi8PSYbDdG6woReGOJmlSoQIK4bZgE8UQfkI4hbOXdyZlxRmWsdy
	 vVQ5l9Ecrst+3M4kX+zH9AmAkGeGLPZaB+1dxnFkQtJfZsreN9fPmevZrbp/S9gMh/
	 Biu680LY3Lk/wBZKQtWpQ5//ZaT/G6gqC9l2P/+9cy5kT+AmNzazrEnVhzKQGgrl2u
	 naMfIl5mXG8Epi0AZTbFprUe3DrZEerIvHD8fkYe4KlxOp7oK/ZxRoLBxhL1nwMLXu
	 Kcz1KYh4/HpAso/nnQLuE8YFQDCkwoLI9E8jSnSGizkoKcGwGC5ff6ScihUDwbtM4H
	 IWMfd+36hdLkg==
Date: Sun, 14 Jun 2026 21:56:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux@analog.com, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH v16 00/14] ADF41513/ADF41510 PLL frequency synthesizers
Message-ID: <20260614215638.0be28269@jic23-huawei>
In-Reply-To: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Jun 2026 10:58:54 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> This patch series adds support for the Analog Devices ADF41513 and ADF41510
> ultralow noise PLL frequency synthesizers. These devices are designed for
> implementing local oscillators (LOs) in high-frequency applications.
> The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
> operates from 1 GHz to 10 GHz.
> 
> Key features supported by this driver:
> - Integer-N and fractional-N operation modes
> - High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> - 25-bit fixed modulus or 49-bit variable modulus fractional modes
> - Digital lock detect functionality
> - Phase resync capability for consistent output phase
> - Load Enable vs Reference signal syncronization
> 
> The series includes:
> 1. PLL driver implementation
> 2. Device tree bindings documentation
> 3. IIO ABI documentation
> 4. Parsing utils for 64-bit decimal values
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Applied to the testing branch of iio.git

Thanks for your persistence with this.  On a particular plus I think this
is the largest series I've yet seen that Sashiko gave a clean bill of health
to (so not even any false positives!) 

Jonathan

> ---
> Changes in v16:
> - Incorporate Andy's series: https://lore.kernel.org/all/20260602203706.103449-1-andriy.shevchenko@linux.intel.com
> - Drop iio_val_s64_to_s32s() and iio_val_s64_from_s32s().
> - Add/change comments and minor changes.
> - Link to v15: https://lore.kernel.org/r/20260531-adf41513-iio-driver-v15-0-da09adf1c0dd@analog.com
> 
> Changes in v15:
> - Set bleed value when chaging mode.
> - Link to v14: https://lore.kernel.org/r/20260524-adf41513-iio-driver-v14-0-06824d9c15f4@analog.com
> 
> Changes in v14:
> - Review include headers.
> - Use named fields in spi device table.
> - Address relevant sashiko's feedback.
> - Minor tweaks to iio core changes.
> - Link to v13: https://lore.kernel.org/r/20260517-adf41513-iio-driver-v13-0-bb6e134a360f@analog.com
> 
> Changes in v13:
> - Introduce _parse_integer_limit_init()
> - Better support for 0 and larger scales in kstrtodec64()
> - Increase test scope for kstrtodec64()
> - Fix LSB_P1 check at startup when going for fixed modulus mode.
> - Clear phase adjust when setting phase (It turns out sashiko was correct).
> - Make sure Load Enable is not selected when powering up.
> - Address some minor comments.
> - Link to v12: https://lore.kernel.org/r/20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com
> 
> Changes in v12:
> - Contraint charge pump current.
> - Fix division-by-zero issues.
> - Address PM and sysfs powerdown conflicts.
> - Program proper phase resync value in clk divider mode.
> - Link to v11: https://lore.kernel.org/r/20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com
> 
> Changes in v11:
> - Cleanup ext info attribute read/write callbacks.
> - Adjust attribute names in the documentation.
> - Turn s64 compose macros into static inline functions.
> - Link to v10: https://lore.kernel.org/r/20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com
> 
> Changes in v10:
> - Drop simple_strntoull() changes
> - Create kstrtodec64() and kstrtoudec64() helpers. 
> - Add IIO value format for 64-bit decimal values.
> - PLL driver code implements new decimal format for frequency attr. 
> - Link to v9: https://lore.kernel.org/r/20260320-adf41513-iio-driver-v9-0-132f0d076374@analog.com
> 
> Changes in v9:
> - Expose simple_strntoull() in a safer prototype instead of new kstrntoull()
> - Link to v8: https://lore.kernel.org/r/20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com
> 
> Changes in v8:
> - Add new function kstrntoull() to lib/kstrtox.c and tests to lib/test-kstrtox.c.
> - Drop custom iio u64 parser, replacing it for kstrntoull().
> - Dedicated MAINTAINERS entry for drivers/iio/test/iio-test-fixpoint-parse.c.
> - Link to v7: https://lore.kernel.org/r/20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com
> 
> Changes in v7:
> - Addressed minor suggestions.
> - frequency_resolution ABI for AD4350 removed in favor of generic one.
> - Link to v6: https://lore.kernel.org/r/20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com
> 
> Changes in v6:
> - Drop usage of simple_strtoull().
> - Implement better overflow checks with iio_safe_strntou64().
> - Link to v5: https://lore.kernel.org/r/20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com
> 
> Changes in v5:
> - Drop local parsing of 64-bit plus fractional parts
> - Add iio_str_to_fixpoint64() to iio core with parsing tests
> - Add DT property dependency for adi,charge-pump-resistor-ohms
> - Add local definition for ADF41513_HZ_PER_GHZ and drop units.h patch
> - Link to v4: https://lore.kernel.org/r/20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com
> 
> Changes in v4:
> - Proper usage of units.h macros
> - Simplifications to DT property parsing
> - Adjustments to return value handling
> - Drop of simple DT property node example
> - Link to v3: https://lore.kernel.org/r/20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com
> 
> Changes in v3:
> - Use FIELD_MODIFY macro in driver implementation
> - Drop refin_frequency iio attribute
> - Drop muxout-select property from dt-bindings (and rename logic-level property)
> - Use -mhz suffix in power-up frequency property
> - Address documentation issues
> - Link to v2: https://lore.kernel.org/r/20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com
> 
> Changes in v2:
> - separate driver implementation from extra features and improve commit messages
> - use macros from units.h
> - explanation of custom parse function: adf41513_parse_uhz
> - reorganize driver data structures
> - drop clock framework support for now
> - reorganize documentation
> - Link to v1: https://lore.kernel.org/r/20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com
> 
> ---
> Andy Shevchenko (2):
>       lib: kstrtox: Make _parse_integer() take variadic arguments
>       lib: vsprintf: use _parse_integer() instead of _parse_integer_limit()
> 
> Rodrigo Alencar (12):
>       dt-bindings: iio: frequency: add adf41513
>       lib: kstrtox: add initial value to _parse_integer_limit()
>       lib: kstrtox: add kstrtoudec64() and kstrtodec64()
>       lib: test-kstrtox: tests for kstrtodec64() and kstrtoudec64()
>       lib: math: div64: add div64_s64_rem()
>       iio: core: add decimal value formatting into 64-bit value
>       iio: test: iio-test-format: add test case for decimal format
>       iio: frequency: adf41513: driver implementation
>       iio: frequency: adf41513: handle LE synchronization feature
>       iio: frequency: adf41513: features on frequency change
>       docs: iio: add documentation for adf41513 driver
>       Documentation: ABI: testing: add common ABI file for iio/frequency
> 
>  Documentation/ABI/testing/sysfs-bus-iio-frequency  |   11 +
>  .../ABI/testing/sysfs-bus-iio-frequency-adf4350    |   10 -
>  .../bindings/iio/frequency/adi,adf41513.yaml       |  227 ++++
>  Documentation/iio/adf41513.rst                     |  199 ++++
>  Documentation/iio/index.rst                        |    1 +
>  MAINTAINERS                                        |    9 +
>  drivers/iio/frequency/Kconfig                      |   10 +
>  drivers/iio/frequency/Makefile                     |    1 +
>  drivers/iio/frequency/adf41513.c                   | 1246 ++++++++++++++++++++
>  drivers/iio/industrialio-core.c                    |   49 +-
>  drivers/iio/test/iio-test-format.c                 |   97 +-
>  include/linux/iio/types.h                          |   20 +
>  include/linux/kstrtox.h                            |    3 +
>  include/linux/math64.h                             |   18 +
>  lib/kstrtox.c                                      |  114 +-
>  lib/kstrtox.h                                      |   17 +-
>  lib/math/div64.c                                   |   15 +
>  lib/test-kstrtox.c                                 |  182 +++
>  lib/vsprintf.c                                     |    2 +-
>  19 files changed, 2178 insertions(+), 53 deletions(-)
> ---
> base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> change-id: 20251110-adf41513-iio-driver-aaca8a7f808e
> 
> Best regards,

