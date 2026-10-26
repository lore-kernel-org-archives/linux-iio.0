Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793015663;
	b=a7EwtGmc+9auw2uU0As7ie/r3EjAG8iSSAZi640ZqXaIpyYCybJvHfE3LFVvQIXl7dNd
	 qEsKv5CgaJ2787tX0R7sxpXtsNzcmIy9uBibBAUOXfFdujSRnP4akDeIzGLC9W7sYKI09
	 YXALygag0HmBOJw2qrG1tk8BNPdQsGnFKzb5pXNJZFAmnPF2+Lv47ywmVswVcu6fXxVO0
	 U59vL+OYWVRmtZ4DRD6JODsw17TBOMFJGNKPg1zKlp+95rNLQG1As0X/CAhYhVcvPGPtM
	 4af12ZeLAgh6Keh624sR5wVU6S93MDRY+za/lzwvbWGBH5S2JOa5amePePNMFcYeUbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015663;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=03o4LuzM9b+8MfDqyhzURuQfXaK2sC75x3C8q02Te1Y=;
	b=2UTV19ItXz0vTMR4fHsed60xy5wJdfidF2QejCml0SYtKUmurQZctwNjomcLu1ZwUmps
	 1Jz5A0p9Ln/oirSxh7dsRnRIaQ+xgMtENBjTgPF290zH0Hg9LEBDyrH/48e+epzzd+OGg
	 o3cOaxW0LrFgqxqkPtWiJnw5MKEvLjWMgvHOQmeQ4Sh7OYHMLPRGRB3/SzxzOG7fHiKG1
	 ak9cf02hiBulL/zJSemRC362Caaifp35tLmsYOMzMAp9lW2XuNekmuwYWVRBopIH841F0
	 fZ97Vw+7ybS96wRGMArRbZ/fHzIrWtlMjXKskkQlcsKDaMLl7QdA0mPHfNU+7GzTeWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOPu8qVG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E861606A31D;
	Mon, 26 Oct 2026 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOPu8qVG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793015663;
	b=OQl/yrrbIL7EjZVX9UCIsDTS9un24nEYbjDV1v95Em4inngmTlemV0tgvbwz5z8qoXhQ
	 +AZqydBM0Ad8Fp1Vgg+dK6uX8LKcIBPia1Ot7BrtvBaAEi+uv+AoUppOyR9X/JjvuRvdk
	 MOU6HVLasEXTr5Q9pPLem+e5BQL7o0r1QU9oVi9A4qihrVflqK9gTwNDJsVcZ8DBKvBT4
	 bJCBQhZLsjxurL27dQ3glb5U/+tkTpRa9TGO2oS+waibrggSqTCHxfjVcuHCsBMAsRn+h
	 3TeycAZiefcTE0SKuvMi3RX45W6IMRnTNhhzzA47GwbvjI8pl9xXoDjMaMlIzmW/tTw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793015663;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=03o4LuzM9b+8MfDqyhzURuQfXaK2sC75x3C8q02Te1Y=;
	b=f6JhQa1a0XOLiE3pFzO/F0CdKxXItHNKAkvfLrhDxk91P4Xk6tj4qTMG+WIM4Kmmn3qK
	 NML1nlafwcPT7w0bmBHQZorQcDS5mf5tpeJKbF9vwPMD9CrIrQg9wG1gKdWwZvZ2Xt4Ru
	 Rd9txhOsq8yy2IitQ9Q/rgUT1S0gDBog8zMrQqeCdnvrqHB1P3C7QjwQ/38301YdYvq5q
	 0giFVtMTRZnZrSkZonRLikUQJIrzqORwjd52uK4fK1Un+v4LIX3tgcFzEvKnJ7QgFncK5
	 3NyeJKWe5FtuHMre1aM6Xm/V5IKwqPp2IYPgyKCDVxEvbixyEf7rCxSJ8RENXlyTxiw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7A2221F031E0;
	Mon, 26 Oct 2026 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015663;
	bh=03o4LuzM9b+8MfDqyhzURuQfXaK2sC75x3C8q02Te1Y=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=TOPu8qVGmgoJchFmpdI9U8hiRa1MfUC3tGrngEwcRAWdRmH/YvistospsZ/Vk6Mjg
	 rFOxZN9ol7WP3e0j9Z/ZIQUNZd8/nhHROOUbHc6Vg3ldHtgOi3xA5/gQDhvZbMIaZv
	 Cdm/WH3A0eocAZ7Pb9Tq3nF0ZxwZVgWMl+5sQLlYhpICfP5+OPdSEJiUHJOtGa+UbV
	 4sheGjopuYtnCLzM0UKH4dJqlqD5ibaPVtSG9QPNFeJVGvtUiDdk9bEz8KE8fzbnWV
	 cBw/cHM9ifKfnXvprcob8fDr/acNUHcnBfONcoPkVFEK40vF4DybbxFFcA9/TAn5uQ
	 o1aokhS5067BA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D3E3C44CE6;
	Mon, 26 Oct 2026 11:54:20 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v4 0/6] Add E notation support to kstrtodec64() and IIO
 sysfs writes
Date: Mon, 26 Oct 2026 08:54:04 -0300
Message-Id: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFw/32oC/23NQQ6CMBQE0KuYrq35v7UUXHkP46KUX6hRaigSj
 eHuFtxAdDnJvJk3i9R5iuywebOOBh99aFPYbzfMNqatifsqZSZAZAiAnHgbetOnGgcHWitdIJB
 iCdw7cv45j53O3xwf5YVsPy1MjcbHPnSv+W3Aqfd3eEAOXCvMdekgswhH05prqHc23Ni0PIiFR
 bmyItlqb6pSERbS2R8rF1bAyspkXSVzZcGVLlMrO47jB6DnAWovAQAA
X-Change-ID: 20261001-e-notation-0f07757910e5
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793015661; l=5424;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=MzUNnvUOsEf0e+nMlQG4q993bvNyGHOW8ispdho+5LI=;
 b=jlIf8YVDEZBmr9FMhmuatoJcuYHWMIRGDqqzkNaAEtZGwBrJjHLX99kJa//JVgVILkm75bt9N
 ICvwY2rgiOoAx2/2trROpEi613Jg7x3TNTxx5fKOuFrNJI5WYp5RQS1
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
point arithmetic is involved. Overflow is reported as -ERANGE and a
malformed exponent ("1e", "1e+") as -EINVAL.

Digits beyond the resulting precision are now rounded to nearest, ties
to even, instead of truncated (new patch 2). This follows from the
second motivation: floating point values printed by userspace often end
just below the intended decimal value. "%.17g" of 0.3 gives
"0.29999999999999999", which truncation turns into 299999 at micro
precision instead of 300000. E notation makes this more visible, since
a negative exponent can drop integer digits: with truncation, "19e-1"
written to an integer attribute gives 1. Round-half-even is the IEEE 754
default, as used by strtod() and printf(), it is unbiased and symmetric
for negative values, and inputs that fit the precision (including values
read back from sysfs) are parsed exactly as before. The rounding is done
before the IIO core conversion, so IIO fixed-point writes change
behaviour only once.

This changes existing kstrtodec64() behaviour, so feedback is welcome on
whether it should stay in this series or be sent as a follow-up.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v4:
- Adjust iio-test-rescale.c to use kstrtodec64().
- Minor changes on making the patches more readable.
- Link to v3: https://patch.msgid.link/20261020-e-notation-v3-0-fd385c0fbf65@analog.com

Changes in v3:
- New patch: round to nearest, ties to even, instead of truncating.
- Amend kstrtox E notation tests and IIO channel write tests for rounding.
- Link to v2: https://patch.msgid.link/20261013-e-notation-v2-0-d4adb5e193fc@analog.com

Changes in v2:
- More test cases on test-kstrtox.c.
- Rework fallback logic when parsing integers.
- Add iio kunit test cases for iio_write_channel_info()
- Link to v1: https://patch.msgid.link/20261001-e-notation-v1-0-75187bf06c10@analog.com

---
Rodrigo Alencar (6):
      lib: kstrtox: support E notation in kstrtoudec64() and kstrtodec64()
      lib: kstrtox: round to nearest, ties to even in kstrto[u]dec64()
      lib: test-kstrtox: add E notation tests for kstrto[u]dec64()
      iio: test: rescale: compare scales against the precision of the output
      iio: core: use kstrtodec64() to parse fixed-point values
      iio: test: add kunit tests for channel info writes

 MAINTAINERS                               |   1 +
 drivers/iio/iio_core.h                    |   3 +
 drivers/iio/industrialio-core.c           | 171 +++++++-------
 drivers/iio/test/Kconfig                  |  14 ++
 drivers/iio/test/Makefile                 |   1 +
 drivers/iio/test/iio-test-channel-write.c | 360 ++++++++++++++++++++++++++++++
 drivers/iio/test/iio-test-rescale.c       |  59 ++---
 lib/kstrtox.c                             | 111 ++++++---
 lib/test-kstrtox.c                        | 120 ++++++++--
 9 files changed, 689 insertions(+), 151 deletions(-)
---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20261001-e-notation-0f07757910e5

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


