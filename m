Received: from out-2z4y-a139.jellyfish.systems (out-2z4y-a139.jellyfish.systems [198.54.127.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9BF2FE060
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786850242; cv=none; b=dA9iYl7Bkx17DcmBLWFaZYuTQrl6ZZQgCE/f/OcV6ZMqJMQ+DRu9v5lh60qXYvILkR824tCQrxYSzUTjRchhKPiV8Kn3BVQWiTttOvvy8WuZAgEt2rfp4V9ltAm32ABMULwwtHDfiJqsmClJTX5Wk44ezhhDel8Gr3P0JPBo/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786850242; c=relaxed/simple;
	bh=011kG421oIL9sH3Cst9njznNXXejH801keRmqi+xhOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Qi358f6HwsNJHv09844HO67/cK6EwGPXqGcoHo2GzGo9ohn4UhJ4A0JMMKguY/AS2aUc2S+KoJyQvlJ98Vynvy7Zk4AmD53eY9LlzWc0eQLzkB7i3+eQyTWoXEDu4GpatSF60Ddm9rZVfzwOM6X742dr5qig7eoQZ6MVxbKR2Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=IrXPYoha; arc=none smtp.client-ip=198.54.127.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="IrXPYoha"
Received: from [192.168.1.103] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hN1NT12ydz8sWk;
	Sun, 16 Aug 2026 03:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1786850233;
	bh=xUooQwx0sKHUN0lXcLaEQCKh52YSywd3izdMT+wLLpo=;
	h=From:Subject:Date:To:Cc:From;
	b=IrXPYoha7N48RDvc2dKHqfa7QbvydnYH8scGmROk7cbnIom1wTZ8QN+HcdmwfqakL
	 neHC3DlFUfgU7XXvgkfXZ6zL+Iu+RP+iS5++xgu0KT2poRi2OAfFEf32ZG8P7qpA5k
	 yqw/UT4lbi+KP9jSXa0BwtEaWR1wtzgpOfcOCjIzgC8d5bpd1Sq9JUlh5ESb/24LID
	 g4v5DqZp4JuxiObM0mvSlp7aOIEEkvKQT8e2MUsarcIitWDfuf8g2dLJzSu6jlPvEX
	 B1YbKvTEZkhRILtzkl+Y3HN9xPa/Cz8lVol51KXrdLgm1sMolIvp2QIOT1NItQJg6l
	 zVH4hoJXnvtng==
From: Guru Das Srinagesh <linux@gurudas.dev>
Subject: [PATCH 0/2] Introduce in_range_incl() inclusive range check macro
Date: Sat, 15 Aug 2026 20:17:08 -0700
Message-Id: <20260815-minmax-in-range-incl-v1-0-a75f7d9ae92e@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAyF4atI1g1o0LF4ldLFOEaN1FhmVATx7
 o66/Hi8f4fAXjhAlezgeZUgk0ZkrwRcb7VjlCYaKCWTvrMCR9HRbiiK/pnV/dBS4Sinmk1pIF7
 /nlvZ7uzn+zgs9cBuvlpwHCdA5j4zeAAAAA==
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
Guru Das Srinagesh (2):
      minmax: Add in_range_incl() for inclusive range checks
      iio: imu: bmi270: Use in_range_incl() in bmi270_write_event_value()

 drivers/iio/imu/bmi270/bmi270_core.c |  6 +++---
 include/linux/minmax.h               | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260815-minmax-in-range-incl-a25c242be676

Best regards,
--  
Guru Das Srinagesh <linux@gurudas.dev>

