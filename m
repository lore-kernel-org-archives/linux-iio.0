Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2F518155;
	Tue, 13 Oct 2026 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898615; cv=none; b=JYytk0BYYrSfFmAOa1E9V/8QKr0gjQqDpQMhsS5z8LVtdRHrKuf0/FEED9yYdIEtRjAvANtHbfRiocqwCp/XvMaUgnHGLi2bn/n68xaaAeDvd+pOXYsQ4tArQdMKlhLhE3t4B8HnlZq2UO6uSPpzhGKGA6d3bHi89pyxfHACgqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898615; c=relaxed/simple;
	bh=zmd0vd1IKyQXpMNynfIqSiL3fU/blbRNFLaY3BhWx8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dAYNoFIubekEYmLSf23AHPAOztBJ7tWyWqtVHV76Pd8Ymq9sAJ7xJg+i1oEZZ3UTaWAs1hvTrmulpOfcF6QUsVxdMTLjyMD5OZ4RSGzeckg24irWYZpqTDRhYc9ZS6cVGYVb88qPa3DF6CvqiWf4D8PYnXbzX1NnjySCyD5RQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxoZZikI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxoZZikI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A0C2C2BCF4;
	Tue, 13 Oct 2026 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791898615;
	bh=zmd0vd1IKyQXpMNynfIqSiL3fU/blbRNFLaY3BhWx8Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IxoZZikILToEvheRfbNvDgVwxMvHkrmBkdLg0FzI1aJgTT3Oo8Wz0xzlml6l8iOlX
	 81h/LuOhVZw+6XVScPoZCtRRApJ8LCfUTUeXAFHm3OTykw/0Ej3pb7YZKoaTDTuDng
	 Y2BcLi9vecZo42z7kyHtSsZHLqlThnBiF2Exch3P1UXU250o59NMO68BsvfXxDvBD3
	 TraSOlcMlNGG6wOv25k2m3d9cV9WgAmn5xrlnx313SShQCmXvPjJN8feDL2OYMTzqy
	 BTEGGwOt7K2co62E9RoLfPe5hsXgDEx7Ro5gxbS73JUxDLZmkeh9UuZvkX9Ul0DtBM
	 +VMNhTE58vDxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9356CC6B0F;
	Tue, 13 Oct 2026 13:36:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH RFC v2 0/4] Add E notation support to kstrtodec64() and IIO
 sysfs writes
Date: Tue, 13 Oct 2026 10:36:43 -0300
Message-Id: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOszzmoC/22NwQrCMBBEf6Xs2chuoI16EgQ/wKv0kMZtG7GJJ
 LEopf9uWq8eZ3jzZoLIwXKEQzFB4NFG610OclOA6bXrWNhbziBRVoRIgoXzSaeMCWxRqVLtCbm
 EPHgGbu17lV3hcj5B/Svjq7mzSYtmwXobkw+f9XKkFf5nH0mgUCXtVNNiZQiP2umH77bGD1DP8
 /wFEej6bLwAAAA=
X-Change-ID: 20261001-e-notation-0f07757910e5
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791898614; l=3835;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=zmd0vd1IKyQXpMNynfIqSiL3fU/blbRNFLaY3BhWx8Y=;
 b=Lw/nSDL5rmQeIQezT0geVjUI9QaKkCirsmtt7nkW6tXFDBFSO/LYvc0BygBgaDF72WC6m/BGW
 tt6ZBtrTd85DCfmzyMoeTYUq87ae+S2tJDrD53Zf5zAeQhL7OKS4Trv
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

This series lets kstrtoudec64() and kstrtodec64() accept numbers in E
notation (scientific notation), such as "2.7e9", "1.5E-3" or "1e+16".
It then moves the IIO core fixed-point parser over to kstrtodec64(), so
every IIO channel attribute written through iio_write_channel_info()
accepts that format as well.

There are two main motivations:

1. Shell usage of sysfs attributes

   Some IIO devices take values that are long to type and easy to get
   wrong in plain decimal. A frequency synthesizer or DDS might be
   programmed in the GHz range, and a scale might be a tiny fraction.
   With this series one can write:

     echo 2.7e9 > out_altvoltage0_frequency
     echo 1.5e-6 > in_voltage0_scale

   instead of counting zeros in "2700000000" or "0.0000015". It also
   works with shell tools that print in E notation by default, such as
   printf's %g conversion ("printf '%g' 2700000000" prints "2.7e+09")
   and awk, whose default output format ("%.6g") prints
   non-integral values like 1234567.5 as "1.23457e+06".

2. Userspace software that formats numbers automatically

   Many languages and libraries switch to E notation when converting
   floating point numbers to strings, without the caller asking for it:

   - Python: str() and repr() of a float use E notation for exponents
     below -4 or from 16 up, e.g. str(0.00001) == '1e-05' and
     str(1e16) == '1e+16'. Writing such a value straight to an attribute
     with open(...).write(str(value)) currently fails with -EINVAL.
     The same applies to NumPy scalars and to f-strings with the 'g'
     format spec (f"{2.7e9:g}" == '2.7e+09').
   - JavaScript/Node.js: Number.prototype.toString() uses E notation
     for magnitudes from 1e21 up or below 1e-6, e.g. String(1e-7)
     gives '1e-7'.
   - C/C++ applications and bindings that use printf("%g") or
     std::to_chars() with general formatting, as well as MATLAB/Octave
     and other numeric environments that print in a "short" form.

   Today these values have to be reformatted by the application, or are
   rejected by the kernel without warning. Accepting E notation in the
   kernel makes the IIO sysfs ABI more robust to this common
   behaviour.

The exponent is folded into the requested decimal scale, so no floating
point arithmetic is involved. Digits beyond the resulting precision are
truncated, matching the existing kstrtodec64() behaviour. Overflow is
reported as -ERANGE and a malformed exponent ("1e", "1e+") as -EINVAL.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v2:
- More test cases on test-kstrtox.c.
- Rework fallback logic when parsing integers.
- Add iio kunit test cases for iio_write_channel_info()
- Link to v1: https://patch.msgid.link/20261001-e-notation-v1-0-75187bf06c10@analog.com

---
Rodrigo Alencar (4):
      lib: kstrtox: support E notation in kstrtoudec64() and kstrtodec64()
      lib: test-kstrtox: add E notation tests for kstrto[u]dec64()
      iio: core: use kstrtodec64() to parse fixed-point values
      iio: test: add kunit tests for channel info writes

 MAINTAINERS                               |   1 +
 drivers/iio/iio_core.h                    |   3 +
 drivers/iio/industrialio-core.c           | 168 +++++++-------
 drivers/iio/test/Kconfig                  |  14 ++
 drivers/iio/test/Makefile                 |   1 +
 drivers/iio/test/iio-test-channel-write.c | 352 ++++++++++++++++++++++++++++++
 lib/kstrtox.c                             |  64 ++++--
 lib/test-kstrtox.c                        |  58 +++++
 8 files changed, 557 insertions(+), 104 deletions(-)
---
base-commit: a22dc7ebb21a6bd4c8b63bc2c1dd46a24945aae7
change-id: 20261001-e-notation-0f07757910e5

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


