Received: from out-93wp-a38.jellyfish.systems (out-93wp-a38.jellyfish.systems [104.207.68.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC953C09EA
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786908409; cv=none; b=BMQV8fKXyS0tPCR6p0mMFZw6ncxGSXreaKjmI33q9migZuOcurooUDNFF/WAsPY97hKJmTScB+r3PkIAfAESKg1TpLvL843uiqe5RaD4eF8j8cJnq0Wx7xtkgmeJdvEcVLs6G5un205tjzMVEsuB9EQlUphLqXUF2ZBnXglPJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786908409; c=relaxed/simple;
	bh=pmNfO7S4o+vyLKPAK0hQNBamZkYQ7RpSRJyhmO6cXcw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k34kv88Ktetn4dqdZ30liD5w/r8lafhvZ69CateAJdihyWgM7u7hOZ4DHzXfnOLyXuTgqAGiC4EDdaEPlU+rb1TOyQm4GoYrqch450kCAfcsYm6a3cY1NcZVXHukf6S9bjpo4NMvUkaRKLNDzqBVgvt6Zc0r13FGwTxb6H7jo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=BR6bu7sL; arc=none smtp.client-ip=104.207.68.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="BR6bu7sL"
Received: from [192.168.1.104] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hNQtl0Cz9z2xBq;
	Sun, 16 Aug 2026 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1786908383;
	bh=K5Wpi7OfsN/t6yMjrY7LTuSpH1r9zWcZB8g8RlBHHgE=;
	h=From:Subject:Date:To:Cc:From;
	b=BR6bu7sLIFIuIZV3j04VqLIjjGSp+KGpOI/7ZP+i8ydp7eF5DpgW4NOd8oR5FDI7n
	 dzpad0JlY4YAq0H1d/gN2nQ4wPfwHElnqvn5vRfJbV/KpA4M0aLX2UpLvZ0e9F4ShJ
	 SMnVCWGcjU9sPE8oVPJWBeaxAcPRZfnp7M5T98uY3zcUcXlLkEyy78MRBrI4GxgTq3
	 UaJUymZHBhiYm9Nl5zmPi8LO/iFvVrBbDFjE4A1Pvx2myUSLH6lTFbo9Oo4NK6ALs8
	 Y+SrI64uLzcB5MLlj5+pKfh6/ZUGU6giJxVv4t4vY1u5jhGx1IBZUsdGLkEkvKmz++
	 cEm0pp/DrdjTA==
From: Guru Das Srinagesh <linux@gurudas.dev>
Subject: [PATCH v2 0/2] Introduce in_range_incl() inclusive range check
 macro
Date: Sun, 16 Aug 2026 12:26:19 -0700
Message-Id: <20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CMBCGr0Jm7RiYCIgr72FYlHaAMVJICw2Gc
 Hd5HMDll//xLeDZCXt4RAs4DuKltxvQJQLdKtswitkYKKYsvicpdmI7NaNYdGds9QcVpZpuVHG
 WZ7BNB8e1zMftqzzZT9Wb9bh/7Y1W/Ni77+ENyd77owgJxqjytM5NobggfjaTm4zyV8MBynVdf
 7rFXQrMAAAA
X-Change-ID: 20260815-minmax-in-range-incl-a25c242be676
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Gustavo Silva <gustavograzs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev

Extend the existing in_range() API to provide a user-friendly inclusive
range check and add one illustrative in-tree example of its use.

The in_range() API lends itself easily to callers who care about a
half-open range, but has no straightforward equivalent for callers that
want to check for an inclusive range. Such callers have to resort to
this pattern:

	in_range(val, start, (end - start + 1))

which is quite clunky and easy to mess up. Examples of such callers:

- fs/btrfs/extent-io-tree.c hand-computes the inclusive check by
  passing "state->end - state->start + 1" as in_range()'s len argument.
- drivers/md/dm-raid.c has its own file-local __within_range(v, min, max)
  helper, independently invented, with almost a dozen call sites in
  that one file.
- drivers/iio/imu/bmi270/bmi270_core.c has three "in_range(val, 0,
  MAX + 1)" checks in bmi270_write_event_value(), computing the +1 by
  hand for the same reason.

This series converts only bmi270_core.c as a first step, as an exemplar
for the usage of the new API.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
Changes in v2:
- (Andrew) Rename in_range_incl() to in_range_inclusive()
- (Sashiko) Use __UNIQUE_ID() to fix variable-shadowing bug introduced
  by choosing fixed tempval names ("__val", "__start", "__end"). The use
  of __UNIQUE_ID() is in line with other macros listed in minmax.h.
- (Sashiko) When @end is the type's max value, len overflows to 0, so
  in_range_inclusive(val, 0, UINT32_MAX) rejected every input.
- (Sashiko) Abandon idea of reusing in_range() to avoid integer
  promotion of the "+1" always routing sub-32-bit types to in_range64(),
  defeating the stated purpose of building on in_range().
- Solve both issues above with a simple, direct "val >= start && val <=
  end" instead: an in_range()-style (val-start)<=(end-start) trick was
  tried first, but that only works under forced-unsigned arithmetic
  (like in_range32()/in_range64() use); with typeof()'s original,
  possibly-signed type, it breaks silently instead.
- Verification: exhaustive sweep over all valid u8 (start, end, val)
  triples confirms in_range_inclusive() is correct (0 mismatches vs.
  2.8M for the abandoned approach). -O2 codegen checked on x86, x86_64,
  arm and arm64: branchless on all four, byte-identical to a raw
  comparison function on every target - no performance cost from the
  switch away from in_range().

Link to v1: https://patch.msgid.link/20260815-minmax-in-range-incl-v1-0-a75f7d9ae92e@gurudas.dev

To: Alex Lanzano <lanzano.alex@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org

---
Guru Das Srinagesh (2):
      minmax: Add in_range_inclusive() for inclusive range checks
      iio: imu: bmi270: Use in_range_inclusive() in bmi270_write_event_value()

 drivers/iio/imu/bmi270/bmi270_core.c |  6 +++---
 include/linux/minmax.h               | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260815-minmax-in-range-incl-a25c242be676

Best regards,
--  
Guru Das Srinagesh <linux@gurudas.dev>

