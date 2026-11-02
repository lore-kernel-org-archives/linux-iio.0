Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793608469;
	b=habUfwQJq38DyAf2SUNNi2j6m6XJVzQuyhWUdPwglyMTo1hDdA9QplXEFWhLJ2OeXVqS
	 nMHwdyi3kmChn3TVkw+iOrVtxDfqXPtGJzwUn5dEbG3mQ42WAmuSr+8ZseicBdcmpJ91y
	 VVYtsgwMu3vOg/0nReEy+oGzmm9+ci82piyoEU2ObBssV9RVzx7ByA8Y7XKoVdOVxDo7G
	 Y+1vy2ESCK276gDPxoyUJjpawISRZwCZIJRGpEHRaxDOM0YitskXgCvEcssm7/tiPt5Im
	 QC4waK9MPBudYZWWNIln3qTc4dm6M1uQz7C7UBs7ipTbNIMpm3N8tSQ66eTxypBeu/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608469;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=LWE8O2lXe+0oKd5nDL5rYg3UGfF5cUqyhrMXFgfjz+E=;
	b=NCftgUX2na5zAuT7ww8ThFPGOCj+dE/O3TbOb12I6y6HC0i7B1cdFeo5QsOtKbH2kQ33
	 Xd7oBZH7gp3fffh65NmOtWFxFvLmLGPtAplgB1ITkzX+x1C33BfHFLAvmglo1SleeOeq3
	 vYYmpxe+BGOL73scn/U+toUQSA5ohXuS/zrZ8BE9xtMcTER6YsIi/5JtIsCKv4FHLdUqc
	 FN8iILiv/MzVUh32d2S+fRs+4NGge1WpxVb2T9UDzJuM8PJwDR8K6ulpmnwRQTRjPBXIk
	 zO11KZ8SSaV/6eCxe6RxJ6efrGmokd1ng28oIh5GoeO4lHc2Qq5LRLQ+7CdFPDxu68Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLbpMFeb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7201606A327;
	Mon,  2 Nov 2026 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLbpMFeb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793608468;
	b=Kx8ozmwmeAp2UHpQso0V/4fymsk/aTGDrxQzRi+V9n+2RMnzFsZTWXf0puVPJ0ilYypX
	 810ndIfrqr/Hie6aGE8tSqls+5et974HH+zEVAA1x+QiZEa8k7nRc1B3sGZPOUJPKfvn1
	 AxqqYdtXRci6+gP6mRhtfPWYFRc4yybrLKyElhS1KGUKUAkvmJReM0WergphobqmWljrW
	 P1GsNqLqdy2fq6Ji58YRN9nyNp20zMD/myeDJUnTdl6osDHlZXbhWeMsN0qTYikTdgX3X
	 JVyoBMjgeVH4T/ZJ+8BTYG843cNJ6AdVhhkKL6Dd7KKO4T9odX9yyy4pDzR1KsXDtGA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793608468;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=LWE8O2lXe+0oKd5nDL5rYg3UGfF5cUqyhrMXFgfjz+E=;
	b=nAKjfCSHhb6Rq4+w1VUyNSZcEPXmuUJqM+MW4ILe4UVE6KZ1e22KYVQ2XRksJQBsnDbU
	 vwln2rCkMmbOK0XnAidszQHLLSa/9gK6aoV5nmyLHbQ5SwWhcBQQ2vu1W1tLwuSvSquUN
	 hukk7Y/JzmX/hjsw0QLzCUr2hvj6UHOU9EwZS1QleTDKVYNBoAQKO2e22BmLDVhwXcytG
	 Gh93rSAVyMxHvxyOfAxpvwo3vE9STiFDn5rx893Fe0HC7IxmJPa17zgnFtzj8ZRtHkwWH
	 VFXGxVPeZI4gYqYiIfarfkR9QxXBz2Yf3flC2YZzhD9MWngeZEtA98C0JB/3YJZiELQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0F1DC1F00919;
	Mon,  2 Nov 2026 08:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608468;
	bh=LWE8O2lXe+0oKd5nDL5rYg3UGfF5cUqyhrMXFgfjz+E=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=WLbpMFebnUiEnGQmKQnqiCDWez6ua5cZzCggSUKzf+yvl1nf9HNAN6ANEnQ7aDtka
	 hLowOWGStqY98HSjf8zRV/r4lKtJEMhCQO0PkmmzklhphMExOJT46U0OFtACgEN0vw
	 ROrQqdNuc4HSnY0/x6cK0YsH2C1cploGDA9Dh8/gSorRpbq1skJtDsZ/Rvwpp2y+dC
	 kYGTJamM/r4f6VW1C6U4XtfEc7w8+8+OrCJc+2CjPWgKomte82gH+I438AZtVKCb5H
	 GZ4uitoSWVcYlMqgVY6/XEy51EYjFmYxjhXjd2zuwFRvGvDv9U4vOLsx70XDVrZ12F
	 qK+Pv2ryvD0Uw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 630BB46420;
	Mon,  2 Nov 2026 08:34:27 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] iio: test: iio-test-format: char format test and
 overrun checks
Date: Mon, 02 Nov 2026 08:33:54 +0000
Message-Id: <20261102-iio-test-format-char-v2-0-926100689e62@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7Zh2EgVceQ/DotQpjBFK2ko0h
 Ltb8AAuX/L++wtEDsIRLsUCgWeJ4scMdCjA9mbsGOWeGUjRWSs6oYjHxDGh82EwCbMVsDK6dK2
 rDSkNeToFdvLes7fmx/HVPtimrbUZvcTkw2f/nfXm/bmYNWpksqQqVyuuyms3GHkerR+gWdf1C
 wRXamPKAAAA
X-Change-ID: 20261025-iio-test-format-char-8a17fbf9a201
To: Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793608466; l=1508;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=zOtnsvVKuqmWXFDwxhbutV/jvXsZEvAJ8P6C/sc77Tw=;
 b=bADJ50upmNxu7XNqALoxeIB0ZhnI0hWiY4moXOuXg/CZVKTgTi5tUJ9llY9HaVTY5nnIbKfTX
 JzQbMk7+ajiB4o3nKTN9cpShlW00RXpJL2dEHYV/Jd+T4urw0CbPsif
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

 drivers/iio/test/iio-test-format.c | 117 +++++++++++++++++++++++++++++++------
 1 file changed, 100 insertions(+), 17 deletions(-)
---
base-commit: d1425b382b9cc5bd19223fad8ba4a8af3dbe1305
change-id: 20261025-iio-test-format-char-8a17fbf9a201

Best regards,
--  
Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>


