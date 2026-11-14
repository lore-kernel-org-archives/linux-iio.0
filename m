Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794665401;
	b=mO9v6zSqefI5Lv23OYA+UGjZVCsW222cWc8yx/2ntQqwrNM3tP6PxqEGfjZp2DIn05ne
	 at+j8cCK75zHxsSicUVzFdbC88u47HRVFYCMfzlBsYthP6Ssqoc/sIQM8WuZPA2V8UHTk
	 zaMv2UgOcSrb6hCGM0Vk6xvfmVVJ3v5DhKr7T01JfmrWtlw3wU3SwomW6FwG3pDKScHyn
	 MC8ngLSqxsdNVkbgazB6LVIWXXmacQe9suXQT3VPb8Gjg3WIHxsJ5SUPn6DIHQnmGfHh9
	 jUeFilm2bfjEzQ1K7FZDm68gORopg160XDwD9ipHBXuIW6ZksjjjQBl+r0xOcYA40AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665401;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=vYFRq9ZxqRkW0vwnC0kdGr431NbPxhomC2G3Bn60508=;
	b=xcDBsOvSBDa475KqlGFOrky/kwiipORa3LeI4xR0FXXb1bFajH71bMAl2DXEsDWIdRuJ
	 DoeUJ3BkRjVnoacpLP7xc+72T0L8Csh2buL1PTdPM4AsbSp0R8YPwxhBNc/RTSWvbgQJv
	 mEWP2FukjbOKSFBPeiYy6gW0in9Add01drwkkogt1vDWYyfJCfXEoxpkDAB7gXOp3DbIS
	 AfQ0X4VRFrTP9PcxibQIWQzN3vIbrXcKCR2CdgC9pFqpq/sKLkspACdSQh/G9BaV/umiX
	 zwOtwFgLoeG7JyuGfcWKX6O/IABeeP/GAiP/WnZ0nMK3aLfcOtv4PCN0o5QSCRKkVVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHF0xDc5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5CE606A329;
	Sat, 14 Nov 2026 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHF0xDc5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794665400;
	b=0xnlKgZiN4fsgNcesv32JB6xbiIgPn8kz/PeR20IqYTK+LTW3tHmO3qv6KpHUP8S8NIb
	 IAF1lzdT9YeHuEuhM7fEUlusv3A7HQLtVT7nQhbVCXNeRJcHO/D6uzFBTA3QMyp7xEWFD
	 MegCFmpePMB4HS18wMwciR7SlVnhc5Iu7lb3qHLUe74zdG1t4fGGwcA000sSDBsLULBir
	 yd8vPlTEw52J5iwD9z85Yw/K+hbnZYL7++Xl+qmqEaOKEXFbWSLouRaFUu5bI01+YcLJq
	 7ruJIJFCKwa1AC3C8creTp85pEF9W7HKnkhXKEdFf1rL7F61yNX9tb2tYrBJpGJR32Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794665400;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=vYFRq9ZxqRkW0vwnC0kdGr431NbPxhomC2G3Bn60508=;
	b=OlCkMpzMg3kdBoiFxwuAEhOo1Jgxnm7pEhr0kmmP5WGE4GfGyJ+jq6oKqqmXuLis13u1
	 w+5R9/P78JqW9aXE5EC8CVFWKXZd64+fDo+wq049UajIUzLTfhhiWj3+2mxQx0QNDtbcJ
	 Rvp824DWgCmOYeVWOta33mXqhz9rUgLIiGNn7uJaWmB1IyoBSFFUf38j3jVw/BjKeSM0h
	 KuTHuqQvf4iS2sf4lqHEJNHsSu1C5FabhhT8qbogpAX8sAK6zKPsLb27vXSPsHLYzngPD
	 /9WlMn8EIm9ZYldfEy26M6eIHO7szFPRYM3+2R/Ust04njLFIcuxYcN84nItPHvAJBQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E50B91F000C4;
	Sat, 14 Nov 2026 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665400;
	bh=vYFRq9ZxqRkW0vwnC0kdGr431NbPxhomC2G3Bn60508=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=OHF0xDc5jZPj4fIQN/p3Twh5KhjAguuEaB5sOKkjXAM2xTMLRKQHsDT+0sSDTp/yx
	 ckPVq3yOWUXYZtrhqQxWyHShCwTvsKtITxFACOQhr61siz+07hm4CgYOwBn6pjb9jy
	 C0Tmj+WmxN5hd902nhr6IpH+DRYAirrxDD5ZqiYgaqD+VmEPbGqhKmMrJFYZuv+HM+
	 VE02kp1e9tpIU3B95x6XPfuhaj4gzRamSkV8qzoeWemhr2Dgysf1c1ij/z776g1Qrf
	 HZWoGf9RHkMTVU55dAwT2Y83l3UU9ehfVB5plD+N/vV+ODENPYVCc3/sIuKhjnQFLA
	 MspN9FgpbgyAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 622B449DE2;
	Sat, 14 Nov 2026 14:09:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v6 0/7] Add E notation support to kstrtodec64() and IIO
 sysfs writes
Date: Sat, 14 Nov 2026 14:09:52 +0000
Message-Id: <20261114-e-notation-v6-0-205ca9a1438a@analog.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALBr+GoC/23OS07EMBAE0KuMvMao2994VtwDsXD8mTGCGMUhA
 o1yd+xhQaywLKledd9ICXMKhZxPNzKHNZWUpxrUw4m4q50ugSZfM2HAFAIgDXTKi11qjUIEraU
 2CEGSCj7mENPXfez55TeXz/E1uKUttMY1lSXP3/drK7bev8MrUqBa4qDHCMohPNnJvuXLo8vvp
 C2vbGeRd5ZV64X1owxoeHQHy3eWQWd5tdHzQTqIY1TyYMXeqs6Kai1XyiqPwkt9sPLPVtxZ2X7
 mxgQphDUD6+y2bT/wv777pwEAAA==
X-Change-ID: 20261001-e-notation-0f07757910e5
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794665398; l=6300;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=qkglJAAoJMp6WutJnose8xK7lLSYHcC33wrXVsxjJLM=;
 b=gd825G2+uZY8TWcjDbGm+AdgntuWosrdx95Jk+oJiTFOxV6OUsgTX9FBrPehe+7n6/9k0zvQv
 S8u5vrKEl0cBttAnvddhM81mdey6CQgY2DH4XxqHxb3yB2JUm9qXQiW
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
Changes in v6:
- Rename skip_digits() to skip_and_count_digits().
- Add a negative value example to the rounding commit message.
- Link to v5: https://patch.msgid.link/20261102-e-notation-v5-0-d399e544a982@analog.com

Changes in v5:
- Allow for a negative scale in kstrto[u]dec64().
- Add more details to the documentation.
- Link to v4: https://patch.msgid.link/20261026-e-notation-v4-0-a366a6d14d57@analog.com

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

To: linux-kernel@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>

---
Rodrigo Alencar (7):
      lib: kstrtox: support E notation in kstrtoudec64() and kstrtodec64()
      lib: kstrtox: round to nearest, ties to even in kstrto[u]dec64()
      lib: kstrtox: allow a negative scale in kstrto[u]dec64()
      lib: test-kstrtox: add E notation tests for kstrto[u]dec64()
      iio: test: rescale: compare scales against the precision of the output
      iio: core: use kstrtodec64() to parse fixed-point values
      iio: test: add kunit tests for channel info writes

 MAINTAINERS                               |   1 +
 drivers/iio/iio_core.h                    |   3 +
 drivers/iio/industrialio-core.c           | 186 ++++++++-------
 drivers/iio/test/Kconfig                  |  14 ++
 drivers/iio/test/Makefile                 |   1 +
 drivers/iio/test/iio-test-channel-write.c | 360 ++++++++++++++++++++++++++++++
 drivers/iio/test/iio-test-rescale.c       |  60 ++---
 include/linux/kstrtox.h                   |   4 +-
 lib/kstrtox.c                             | 127 ++++++++---
 lib/test-kstrtox.c                        | 246 ++++++++++++++++++--
 10 files changed, 833 insertions(+), 169 deletions(-)
---
base-commit: 7c054db85b5a3ce4d5465cc5cc682cc44ae9eabd
change-id: 20261001-e-notation-0f07757910e5

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


