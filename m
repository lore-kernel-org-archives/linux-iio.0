Received: from out-2z4y-a139.jellyfish.systems (out-2z4y-a139.jellyfish.systems [198.54.127.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D44419305
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193625; cv=none; b=R9P+NaB481hWnZBMJTC8u7kpXODl6u9/URb18GHpQoeF+zgcgaeA6eRIQxApWFyWGBzJ8EBb+Db+emLKmgHeDGGEiEp+FZRLcDhT0/ES43GzuMUg/rmDRKcoNW2k1wCClzA8lnWzIdKjgGOj/aOzHl0keTeQJy3Z3AJ6KYNwPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193625; c=relaxed/simple;
	bh=J8Zr2NgwqfdyKxmCz+NhIrRV/35jxbRPe0OXJTalUYA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=URXAiOh5d82MPuxQMkUWmXFcgVvt5LlAjW2f/Zy7fry4vnvl5r98CvIoMC3oIf/ZXNRq7571mc+U3jetaeXvEUxzQxN/p8n92tocwGRyscPBYOjmKrLHrdRBkru9YHdnfzS1hkwtA3FKd/aB5TXCodkTJZPCkkglMdhaNUpXZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=nHLWsnaJ; arc=none smtp.client-ip=198.54.127.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="nHLWsnaJ"
Received: from [192.168.1.106] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hYZBl3SPJz2xB0;
	Mon, 31 Aug 2026 16:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1788193615;
	bh=ltpBQcv0XzcU/cQV4/iIcH6lXi0I1q8OzRgtj3oQgco=;
	h=From:Subject:Date:To:Cc:From;
	b=nHLWsnaJJoFcRwAlwLl5D8n3ST3FiNV23ac+oQObjvmk3YpEqZL9yqxnV+Ftw4EBv
	 LaEtRM+rWwpblTqsCJAHdyP74tlrHJfVXptWb1IFDb9vrNkkbCu2prSDOVqOv/g4p6
	 abV585afN23+QE14iPvTDnOpX1At3TS0VAgE2CbSrt1kdjw0uCzHAJA+21WRRHb9rW
	 Br42b0m5jB37XD084PO0KHO0TB/19s6phkE0c+qvAi93U36GsMjrdWf1zvN6EvwcLm
	 KNm2XcNaLfrRAFh9WR97RM0iuUPPid6Y6oufw5QHQpOLvaKwpi71/7BlQIFo7hUXP6
	 HDu9HTjoP8fvQ==
From: Guru Das Srinagesh <linux@gurudas.dev>
Subject: [PATCH v3 0/3] Introduce in_range_incl() inclusive range check
 macro
Date: Mon, 31 Aug 2026 09:26:27 -0700
Message-Id: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0K6tgYGacWV9zAuSjuFGi2mhQZDu
 LstbHRhXL7Mn/dm4tEZ9OSUzcRhMN70NkK5y4jshG2RGhWZQA4sPxYVfRj7EBM1lrrtbOWdCqg
 kHKBBxhmJr0+H2kyr9nLd2I/NDeWQXGnRGT/07rV2Q5F2fxKhoDkVvNJc1QJrwHM7ulEJv1cYS
 IoE+NSwHxqIGs6Y5iVXijX6W7MsyxsGkSf6EwEAAA==
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
for the usage of the new API. Note that similar conversions in other
call sites are not drop-in replacements and have to be reviewed
carefully to ensure the behaviour of the check does not change.

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
Changes in v3:
- (Matthew) Go back to in_range() approach which was earlier incorrectly
  abandoned in v2 to avoid the overflow problem with v1's plain wrapper of
  in_range() with len = (max - min + 1)
- (Andy) Add Kunit test for in_range_inclusive() covering both u32 and
  u64 test cases. Tested with:
  ./tools/testing/kunit/kunit.py run --arch=x86_64 "in_range*"
- (Andy) Added return value kernel-doc description
- in_range_inclusive() deliberately does not add a BUILD_BUG_ON for
  @min > @max nor a signedness check in keeping with the in_range() example.
- AI assistance (Claude, sashiko using Claude CLI as backend) was used
  to improve precision in kernel-doc description, refining test cases
  and adding more test case classes.
- Rebased to v7.2
- Link to v2: https://patch.msgid.link/20260816-minmax-in-range-incl-v2-0-766f737dd6bf@gurudas.dev

Changes in v2:
- (Andrew) Rename in_range_incl() to in_range_inclusive()
- Wholly incorrect approach abandoning in_range()

Link to v1: https://patch.msgid.link/20260815-minmax-in-range-incl-v1-0-a75f7d9ae92e@gurudas.dev

To: Alex Lanzano <lanzano.alex@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org

---
Guru Das Srinagesh (3):
      minmax: Add in_range_inclusive() for inclusive range checks
      lib/tests: Add in_range_inclusive() KUnit test
      iio: imu: bmi270: Use in_range_inclusive() in bmi270_write_event_value()

 drivers/iio/imu/bmi270/bmi270_core.c |   6 +-
 include/linux/minmax.h               |  39 ++++++
 lib/Kconfig.debug                    |  18 +++
 lib/tests/Makefile                   |   1 +
 lib/tests/in_range_inclusive_kunit.c | 249 +++++++++++++++++++++++++++++++++++
 5 files changed, 310 insertions(+), 3 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260815-minmax-in-range-incl-a25c242be676

Best regards,
--  
Guru Das Srinagesh <linux@gurudas.dev>

