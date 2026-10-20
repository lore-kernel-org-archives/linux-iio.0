Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499230;
	b=kl6VUav3SwKBXQt/STL8r2wIaVwC7ml79OAgZ1ZTH+yhpK1kdrieDhcKkP8R5xdQ8qC6
	 BuP8yKh/swr17TLYaJk3kid+BJecTYeo8bkW/NQk46IwmFGFUWqcE6uIKDqELcQ6jQ6TU
	 4/HWhbKTNNkz4ZE4KqEuV7dnw0GMynZj66aYxKsrpnmgHOZGTkIDKMcNJMidMjnCuK1Di
	 OYeAEk5zLqiTLQn0CJXJvssWdjer+cpxUU86ZfiiOslNszdpwMMpmc5Gxqzc2BMpK/Jiq
	 d0ThHy2Hz3qx4CoNFUJ3wXyZRR96utTV+1T5DoDV5NLXmN0tmH4PgX1wSrPJO17idkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499230;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=2d17GGzHzMhWkyC0c3Ho1xSbxyR/hxmcmyU3uzQTBus=;
	b=l1zJH3aoMZN81pt8OCFs2PsulrVBkyb+6JPiE9TejLj4LF3wAIj0GHhk+Z6DDDWjncD9
	 7GoZuGGZXa+POWpDzbt/bTVgwxA4pkboq77XHS7Ca2XUa3nDIiMp/mI7M42vIuRKORj19
	 buOp9+lpRDDnxKYtlqwFoMLZPJFvmH3nEhKsvetKIf1IcfPQmx6UaoRdQYpYVH3F6nlBt
	 09/kjfto2FdMPItdo5Br3JEzISC51plU3RBFEJwNPRgMaaUURyQzkKoo65LftX2u76DKL
	 JWnYfQ5x19TDcEiIqcaezzD58YWOcQbPRrpsRRh4oiZh0Zvqx60A4HbOoLHNjj7U0Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T/g2oOPq";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50C606A321;
	Tue, 20 Oct 2026 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/g2oOPq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792499230;
	b=PsLfQdGahbNHXiwnYUxqOYC/G+jP1i4zo58720B5c+yUwYILyHM50dNTIn93ASambdNM
	 TYbXsJpTJPWUqUvSYqbNEIRLL1foXnYe2OeM92Oz3uIp5ViPbky+sirWBGusO7ORVuuJH
	 5+7PIdPSznc4/xfVz8UEUhDLy/qSZJ9Gf+VFDbTHB6qVcj2eZVjJuAx16fNY56zbgjzIb
	 UloHK/pRdKDwhgJH1L0/rh1i9/xI742A56zXJT5oEZZMU66MFcfGtcaP+psSYX3uUUCYQ
	 6Us0cA0cHjxlbryFLmKyVuywyABK1gjDp3DDWFZHYY8db1AF12tUWAna8ZKKFocNIIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792499230;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=2d17GGzHzMhWkyC0c3Ho1xSbxyR/hxmcmyU3uzQTBus=;
	b=EaikBy9t1SgcxPbfkp7rXEaHo9EBksHMlbQzhDxhtC9uKTcUwcWh8C21FyijaNIqt0vP
	 bK1R79nxPGp/dYgr+UUVL++lIq1LlEWfNnwB1xQgo4M25nggyjnrkYiNde4bjed+n6CQ7
	 V4FVDSXMzNCIhUtMm2+9Gx05qFlkMws9xoLToiXaumJOLcRRAj4mUy6KUuHzqCboxjjvd
	 Z03ktBZQiD5baU1ZCMpU0lcIslcf4Mo43QbihJ4jX0VFCvUP4vccf4Xb55u+WDtipC/aN
	 JcPLyZhgaL7ZrpTZUCwlbnIIY7FnJr/YNlnifWGOVc8FKRwCuqr5Yvbtcep1r5mDWhA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C97CD1F000CB;
	Tue, 20 Oct 2026 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792499230;
	bh=2d17GGzHzMhWkyC0c3Ho1xSbxyR/hxmcmyU3uzQTBus=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=T/g2oOPq73/nWDbYNFAjpI3eWW0vdnpRAXOOVLjwbaUpjYxeofYDPxXKT6G/xhCzF
	 b00Ult+cnIRm458zuiXSpkZF2BA4XSlnpnLAiumL3H6W9BZiRV4hoF7Wlpn1R3MtGi
	 nKeWSnSNL9HFXrh90c9q45r88MnPUOwcK0W4mt/bCThc+yI9TR4ZyX6+n4LsuxrbzV
	 kOZ3Chi4WEO8XTZyKM3Xh9xgJmnc4Afp5yta+AqvniumrDBXewOZlRK1KbzsCbZVsy
	 lcIoVJL1dOna4CRhvpwqV/Fo/UfNWifDnDRgD4y2OI1VoEPOX7O5o27zsKtNFfP2Hf
	 nNqG1ub2UKx4w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2F48B43128;
	Tue, 20 Oct 2026 12:27:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH RFC v3 0/5] Add E notation support to kstrtodec64() and IIO
 sysfs writes
Date: Tue, 20 Oct 2026 09:26:58 -0300
Message-Id: <20261020-e-notation-v3-0-fd385c0fbf65@analog.com>
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
X-B4-Tracking: v=1; b=H4sIABJe12oC/22NQQ6CMBBFr0K6tmYGLBVXJiYewK1xUcoANUpNW
 4mGcHcLbiRx+SfvvRmYJ2fIs10yMEe98cZ2cWSrhOlWdQ1xU8XNUkhzBEBOvLNBhYhxqEFKIQs
 EEiwKD0e1ec2xMzsdD+zyPfpneSUdpsyEtcYH697zyx5n+F+9Rw5cCtzKsoZcI+xVp262WWt7n
 8t9+uNitnDT6FYbVZWCsMhqvXDHcfwAyTm+KPgAAAA=
X-Change-ID: 20261001-e-notation-0f07757910e5
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792499229; l=5078;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=rO6A838qBXP/TP6FSpqRUMdEQfQmKaVBJ5QyMvmAWck=;
 b=tsOWdwi6YeZX6vIAYMBwU6earWjWCZ/bZ2ivkq2rZZmtX9p17hRHVy89j+USMmE6SMvyaq+nz
 amj8XPg7VhDAuS8zBAuu/3DrKVilsI3kHvg0W8rtdrGzyISpAyCFowN
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
Rodrigo Alencar (5):
      lib: kstrtox: support E notation in kstrtoudec64() and kstrtodec64()
      lib: kstrtox: round to nearest, ties to even in kstrto[u]dec64()
      lib: test-kstrtox: add E notation tests for kstrto[u]dec64()
      iio: core: use kstrtodec64() to parse fixed-point values
      iio: test: add kunit tests for channel info writes

 MAINTAINERS                               |   1 +
 drivers/iio/iio_core.h                    |   3 +
 drivers/iio/industrialio-core.c           | 164 +++++++-------
 drivers/iio/test/Kconfig                  |  14 ++
 drivers/iio/test/Makefile                 |   1 +
 drivers/iio/test/iio-test-channel-write.c | 360 ++++++++++++++++++++++++++++++
 lib/kstrtox.c                             | 107 ++++++---
 lib/test-kstrtox.c                        | 119 ++++++++--
 8 files changed, 650 insertions(+), 119 deletions(-)
---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20261001-e-notation-0f07757910e5

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


