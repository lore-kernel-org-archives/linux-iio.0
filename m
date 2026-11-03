Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793740631;
	b=3y9NFS4iKfEiY//ZY4TZVGj35KHqrYrAs/vFN+pYMkNHut08Dt8y6PtOwI6gv7yd2fU9
	 zLt5FfGXtGd2KEweBw/jckk1T31WUXcBR+jOcOffjdUWE6PCiU5+siX55yvOtEme+Flrx
	 z8dIhKdHpyMK6ZHUe9RkIhasxTmzttZaqahyf8SzdmrPRJ8M1Y2nvH1VJo1HTysG2dTkO
	 0UAI6Z3mRtPr11lBFmRMFT7fZ3r5Sx0gpYqnYEC7nfBX45nvDtbjosVuyASLlhspbU8rK
	 LnOFRxhuth+hn2Rpd85siAdTGFhHKw7fjGA79Wp96or3s1sMED1kaFOJEM57SqdyNkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740631;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=lJ7EyH8QCNMbHnLbIQ/Ja9GVidK+gB9ts/UACiFm1w8=;
	b=to7sRAJvQuHpNqd0ytLNy3bn+uGXm8lga1FTlWwkEM5rzvKKvpk/wisq7ZCoYaDw12Fq
	 J/k7zWR6BgGZ5JKg637L51TCUDD3zol+aATHMb9dkZTDl7wYuK3eoOdvAseFbS/pQTTy4
	 Z1f4dyydOwzIRwwHtN2CtOgNk+z3S7RfvwkBn2TZqifCypZsIZo2x+iFxH/rbNNXUtMdX
	 XUniZfIDHeKWGl69XEj48Xmur4kK1nVFIUFDD2/a/kDQTuS9pqAxiXothPNekNQgXOL6T
	 gJEBO5XX+AVBd/BGbU34xFqOXNAj9LDSbtkPk/YM/hitpeofV0DZwj+iuvrnuusfWWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFTWZROg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C092606A329;
	Tue,  3 Nov 2026 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFTWZROg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793740631;
	b=CeM71Kd7oIohRu/bWeDVp37XZ7oGe22Xy+xg7d5Jh+B1RygMjrBhkwt8Hz1+oqkeE2YF
	 /D8yp6oSmUs9VUGWmpKA7VlXfYUonsSCue7zBF1+TE4i6xdkv5lKGoVYGVhsK13TZ9dqI
	 Z1zlbCRYavaD0VCCBwuD2wWA2DH7C3LUM/HmPk9lSD1Rd8EqD/eVSAbd9UgWDIgaIEB2C
	 5UCqxiKXjyW26mNfFiYrmJBTpr5Fhb8e8CAB4RXxHjo27kLGIqNtZHL2nC+ldWL+mbm8R
	 itt/PEmaa3p93aZDnATddBC/BsHUrTTYGx5qWR47lHiF7lj3B4lj0jvj8IW8EN/7tSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793740631;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=lJ7EyH8QCNMbHnLbIQ/Ja9GVidK+gB9ts/UACiFm1w8=;
	b=KxghQHdgI1pcIy/lg7XuQePBI/aHvIGERvh0Zda9q2SY7NerFMY94pHWuaR93Oa49NgA
	 GgPY3ek9k3OSkoKh34L653Mtawm4CaOrWXU1dZb4cen01NqvHMdJzNIi0O9bJ4cK/vqUG
	 zGEbWMtbF8XvpZ5K6kh4L0sgAWH9Z6m4J/MHejAhaV30YzgwNHEnM5klsnYWo7TL/+jFh
	 n40j31WW6qXUBVxBwCPcjH0EjE4FJ2eqKd42wQvEm/Lsac1CkPXVbSWKu6HIYoLRlJWFh
	 +RBUJMIhEp5Y5C961cOft15a6IZJoBytwMAmNw399YhEqcGK0DIpMVCiWZ/H3zKy21g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 271141F000C1;
	Tue,  3 Nov 2026 21:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740631;
	bh=lJ7EyH8QCNMbHnLbIQ/Ja9GVidK+gB9ts/UACiFm1w8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=WFTWZROgskFHiykTrFmDUFh8CUAbPwkeas66KwY5E38IaezCd8fNKWOPG/JCS3kBs
	 AwN3d5BAOWMEC38LGOgG72x2iZKqXtgUj5UzFjq9uta9Cc2ZpAmxRHhCQWb/S7WwA2
	 xZxN8M7ERvr55aYXqpFoTnQ9YK2os/FSxPOiS6rxHIMuvEKe+XQ6+Z7et5lz4IaSnq
	 fduyhMuUCcXEp5lV9ZFJRLAhIXEvz0nbHu0fasWrh7w0AbetX+zV+49zp9X4BKc8BT
	 iLZxPC/aoYRANvdh10fO7SFLLOpSgXssgTNtyyYLJn5aAX8EUEAyfIWjRIEbahnARU
	 cQ5833I/DRV9g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7CA3746B30;
	Tue,  3 Nov 2026 21:17:09 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] iio: test: iio-test-format: char format test and
 overrun checks
Date: Tue, 03 Nov 2026 21:17:06 +0000
Message-Id: <20261103-iio-test-format-char-v3-0-d44074ecca70@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNOw7CMBAFrxK5ZpG9iHyouAeicMw6WUQwsk0Ei
 nJ37FBAgyifNG9mEoE8UxC7YhKeRg7srmlsVoUwvb52BHxKW6DEUkncArODSCGCdX7QERLloda
 qsq1tNEol0vXmyfJj0R6O7x3u7ZlMzK5M9Byi88+lO6rM/UmMChQQGpS1bSTV1b4bNF/Wxg0iJ
 0b8SJLlhwRBQpMzsqwbKvFbMs/zCxxz9gQPAQAA
X-Change-ID: 20261025-iio-test-format-char-8a17fbf9a201
To: Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793740628; l=1712;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=f06r8ldKJe+o50Na4aMFV/E3TQKjgDB9UYQu67IpN1I=;
 b=ALSTTMgDXcstqo24/MnKoJXUIlIleFQZ+HYJdtXcyAgwWanMhO160KaAVd1ApPfEnlAZtMIHZ
 up+WVal5iPNDFf0+Nv5pj5aZVnz7/mSCWXc1WROg/338HI8e3+6ajcN
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com

Add a KUnit test for IIO_VAL_CHAR formatting and, as suggested by
Andy, make IIO_TEST_FORMAT_EXPECT_EQ() check that iio_format_value()
does not write past the formatted string.

A NUL character is currently emitted as is, so the attribute reads
back as "\0\n". The test documents this behaviour; please let me
know if it should rather be rejected or handled differently.

These patches were written with the help of an LLM-based coding
assistant, which I used to draft the code and commit messages. I
reviewed and tested all changes myself.

Tested with KUnit on arm64 QEMU.

Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
Changes in v3:
- Reformat IIO_TEST_FORMAT_EXPECT_EQ() and use a local variable for
  the size (Andy)
- Link to v2: https://patch.msgid.link/20261102-iio-test-format-char-v2-0-926100689e62@gmail.com

Changes in v2:
- Drop the Assisted-by tag and describe the tool use here (Andy)
- New patch 1: poison the buffer and check that nothing is written
  past the string (Andy)
- Add special, non-printable, NUL and out-of-range cases (Andy)
- Link to v1: https://patch.msgid.link/20261025-iio-test-format-char-v1-1-e2c208f90e87@gmail.com

---
Raffaele Tranfaglia (2):
      iio: test: iio-test-format: check that nothing is written past the string
      iio: test: iio-test-format: add test case for char format

 drivers/iio/test/iio-test-format.c | 121 +++++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 18 deletions(-)
---
base-commit: d1425b382b9cc5bd19223fad8ba4a8af3dbe1305
change-id: 20261025-iio-test-format-char-8a17fbf9a201

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


