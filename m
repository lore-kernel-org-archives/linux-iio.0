Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA152CCCD;
	Thu,  1 Oct 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868967; cv=none; b=u2UYBP1Kvz3H5H41vTjS+O3gH4+IHihKoBf/xI1KrDZUIdR8AyKStE7AucAdLJ0V8kGXUER+pSjFEt2DqwUhhvBJydUhx0oUxdg0GJsDrTGplMyuQEOdqbvUjJQpWlcfEpHmiYiOMRzer3MQ1nTmyuqIW5fyi61Rq0Ot1/W9HZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868967; c=relaxed/simple;
	bh=hl5SNynqRKSEbsuJCrx+Ql4cWB3bAeMxxmKi0ACdAiY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CZTSyKHlC7e0/66JwVc+i26gbmzZdQerQKOJpkwS/fo0hn8A5KGIIwbu9Ujw/EFf51JXm9pJRpejDVKZz9YUp61YHzH5KhXvGvOWXBNt+B0M4jTCYofbZMJ0/t9BRmV9TH7CotwxmRDGrz7KzfpzZj0zAE8lDJOzeVOT+Q08Ta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGnxMJr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGnxMJr0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E5B7C2BCC7;
	Thu,  1 Oct 2026 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790868967;
	bh=hl5SNynqRKSEbsuJCrx+Ql4cWB3bAeMxxmKi0ACdAiY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RGnxMJr0n6iP7yYSHaIrEqjEHGozecV+CN/rh8mFNBuC6Xri+AnmAmhJXkrvhCzai
	 Pt9WX7cr+CsfsG4bVq/r6h4Lm34Af+lEj9DwkEBaKsthYDBQl6UJ1ZoZfII8kQy5Kh
	 QbJx7R0MZe2lTEL2nh0SZ7MZqMBuEz0UEOmnuwWP4DjXBjFDjJYfSAXMr3STMeJUXC
	 BwxkQEutGGyVtNRRp2FBbB7B1B8KbUhkVVgGAJw9FD98wvwdsf5IEMd+bPZjdDNNWA
	 MEolMnKQhhyxphNR25/KmAgKLcNHa/pv+GQjEiUoT2SJQJAUALOkz0e1tK/FwJeYSF
	 VvuwdSkbmiKig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38963CA5FD4;
	Thu,  1 Oct 2026 15:36:07 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH RFC 0/3] Add E notation support to kstrtodec64() and IIO
 sysfs writes
Date: Thu, 01 Oct 2026 12:34:55 -0300
Message-Id: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ99vmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwND3VTdvPySxBKgMl2DNANzc1NzS0ODVFMloIaCotS0zAqwYdFKQW7
 OSrEQweLSpKzU5BKQMUq1tQDcTrO9cwAAAA==
X-Change-ID: 20261001-e-notation-0f07757910e5
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790868966; l=3248;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=hl5SNynqRKSEbsuJCrx+Ql4cWB3bAeMxxmKi0ACdAiY=;
 b=ljHTM2iJc3dLa2XmllaihB4mzrVICVACtuuzkNTnaRsID5vnLNR4oeTGQW49tGe55O7h0US9W
 ZXOGyjuMjsZDPwbNPnSMbkotcnhX0WXklBMXmPG0PLFvF4KBTl1HOar
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
Rodrigo Alencar (3):
      lib: kstrtox: support E notation in kstrtoudec64() and kstrtodec64()
      lib: test-kstrtox: add E notation tests for kstrto[u]dec64()
      iio: core: use kstrtodec64() to parse fixed-point values

 drivers/iio/industrialio-core.c | 155 ++++++++++++++++++++--------------------
 lib/kstrtox.c                   |  64 +++++++++++------
 lib/test-kstrtox.c              |  52 ++++++++++++++
 3 files changed, 170 insertions(+), 101 deletions(-)
---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261001-e-notation-0f07757910e5

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


