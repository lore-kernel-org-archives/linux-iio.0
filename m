Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02C370AC8
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389143; cv=none; b=uhw2/qmuWM0JLhkSgaU7sfQtTuFnf2n1p2gOAcErxmf/nJnCnP8WKzsldDySGNjjneY+Eomgb2f4UyiFfrP7ySkC1hyNLpE/ZJMkTfJIFhT0eETeP2TI247NtaHUDsIc/b9Sri7aOPgoxYA+3DgXO4wgbMDoqfHGb+NZ5dpGgqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389143; c=relaxed/simple;
	bh=W779wj4mHSsllfXyzqDdo2yZBI6PkocPY2PxiztL+mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E4VyA0qJBesrc0umR4wT9qNmCHWcOv4gYV3MCG9G6Hsme5RTEesFid4LuRkaoohaFQbfmxE4PU87TYBQx1Stlc9QcxrpxerPiev3gwZQhymjzoefy1kqBjLTG8d6DxEhK2hPU3ModtGo1jBbiBaEA6YqgimiWpsuG6skMu3ZLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh6EYLUo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh6EYLUo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49557167508so1998385e9.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787389140; x=1787993940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWg7QwAg3+JgYt2P6ZQJVJ6LXE55gmzN7FLka57N1Pc=;
        b=Jh6EYLUoMDF2kytgYdHpirVTRqJeGqSBek6bLlnNfYOaK8xbjAePcUOlcLlCEdrG/O
         4yl4ylKvk2Ns0Xs4tVDls7jwLl/QVmhCidN4jNWlJ+UngHgm9l8h9INR3HlihovVLr/j
         MbnSWxxIwUyZMJNPupsxKaPT6MNLxrQB7YsGSC2j77jwU/9wzab3kfOcnX9dWZmA4bd/
         MYR6O/Q7E8f2cf3OTLOqmQB/3guJrdBjPePrfUYVcJwSvD8Z3RBV/fBrJeFodBSnc0Q5
         vCizSINdaTmwVrQKrX0KCw0b6xKQEYG7kdNPVfg4EbBUJ6LWgkoRiEVGMBmdy3yhZEQJ
         FTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389140; x=1787993940;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWg7QwAg3+JgYt2P6ZQJVJ6LXE55gmzN7FLka57N1Pc=;
        b=fyE2jvVLxg4poxh3gNKWAoYOFSKtgo98zUKjkMJISf/I0VIm8aN/b/kj5wcVHVSaLQ
         1tIi+9CCtvyG+W6+3vipQloejs6vGUc1gzWobCFz2aXWzFQfuXHR/qTLuPp3PhUJQIR4
         Pj89nAlVM1SgyLTjqKU2iJAzDU7SDFrMfFrpuPLZBm1XlMfp4D9edKuBOy1hChtxKavI
         J5S1BIWO1A3vZxY2QtI2237GXyB+flCLx+DJxHaGx2Pq2Dd6PEHJhQaLrzQZX2RGHgZ0
         Rf2c+lKIx3g5vY8zUEn8Qh5yrM0xBv6Z9/SA1bhs5bsGFmtQ/OUsPX3NIAQi8pr8Gmty
         NsMw==
X-Forwarded-Encrypted: i=1; AHgh+RqZWq5qu3FBQbI8vMxiAclAJfLyK6D2pDH5vBmPKC167IB7wL26jvzztIklK1DP04/Gw0EOlM+0vws=@vger.kernel.org
X-Gm-Message-State: AFuF++nYQ9nVt2F9FfPGH5OMJXj37ZVgsJCRwIsx81vcPxslpykw31Uq
	VLpDZ7X6cybdFs8KekdBP3HorMJMR1/wbZJgcFxnf1Wv3AjksYHdvsZ1
X-Gm-Gg: AR+sD12uBaReuvLeX5qMjr3z6BMyx0nH7Qto4g+oMIx3Cwq/P3J62dWdHcG9sC+qAI3
	m7zNRs4ojIb/37VGger5Le/RrZaQFPYB6+hBI3SgF413tzee90z7X1KXheC9tSAIqSAiy3cxefd
	JA2tk8UfHCSlXOcQnleDc3aIGJCczoTABR7kk6SeDKdffecJqNxGEHY5foTANajzQ8gDBGu2tbS
	FgDYakYGStqCuvkh98Yqz5Y/+9kwa1MHb1BW0iN99ycid0kV7HGfJcSlgw+7rFy66vWjAqOY1iA
	kCm/KrLqakDUyUoAVHL8ZjWABPGLGDacaVaGavTXMIwCwjb4xW9yrz/1qW1BIhBqPcZAnpEeBFD
	BJHqRs5E3b2pSc2X1OQeDW+7AFnld94s5Iqqnga/MSiaV0gCwPi7+YaBQVTWvMnVGmmXqrP18y0
	NoWR4Cb9Wb6/Be8FP0qjl5EY3R4uID8yN5Er97cC1T/FUGvpSOOilMioi6o+u1+6zQP97bhod/g
	4AhS+fCgNA=
X-Received: by 2002:a05:600c:46cb:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-499b82d2865mr143740845e9.3.1787389140327;
        Sat, 22 Aug 2026 01:59:00 -0700 (PDT)
Received: from fedora ([105.74.72.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c359b9fcsm13596635e9.9.2026.08.22.01.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:58:59 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v6 0/6] iio: dac: ad5504: bindings, cleanups, locking, and scale fixes
Date: Sat, 22 Aug 2026 04:56:47 -0400
Message-ID: <20260822085850.17527-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jonathan Cameron applied patches 2 (sort headers alphabetically) and 4
(introduce local dev pointer) from v3 directly to iio/testing. This
series rebases on top of that state and does not re-send those
patches.

This v6 series addresses one remaining item from the v5 review by
Andy Shevchenko:

* In ad5504_write_dac_powerdown(), move guard(mutex) to after
  kstrtobool() since input parsing does not touch shared state and
  does not need to be under the lock (Andy)

Testing:
No functional change from v5. This only narrows the critical section
in one sysfs write path. Re-verified on ARM64 Raspberry Pi 5 (BCM2712):
powerdown sysfs read/write and powerdown mode switching (20kohm_to_gnd,
three_state) verified on all four channels without errors.

Previous versions:
v5: https://lore.kernel.org/linux-iio/20260821102255.36705-1-0rayn.dev@gmail.com/
v4: https://lore.kernel.org/linux-iio/20260817211118.21833-1-0rayn.dev@gmail.com/
v3: https://lore.kernel.org/linux-iio/20260509142047.30302-1-0rayn.dev@gmail.com/
v2: https://lore.kernel.org/linux-iio/20260310174835.24209-1-0rayn.dev@gmail.com/
v1: https://lore.kernel.org/linux-iio/20260212181955.42724-1-0rayn.dev@gmail.com/

Thank you to Jonathan Cameron, David Lechner, Andy Shevchenko, Nuno Sá,
Krzysztof Kozlowski, Conor Dooley, Uwe Kleine-König, and Joshua Crofts
for the continued reviews.

Taha Ed-Dafili (6):
  dt-bindings: iio: dac: ad5504: add output-range and missing gpios
  iio: dac: ad5504: Align headers with IWYU principle
  iio: dac: ad5504: separate ACPI and DT paths
  iio: dac: ad5504: remove legacy platform data support
  iio: dac: ad5504: introduce local lock to protect state and spi
    transfers
  iio: dac: ad5504: support scale via output-range-microvolt property

 .../bindings/iio/dac/adi,ad5504.yaml          | 39 ++++++++-
 drivers/iio/dac/ad5504.c                      | 82 +++++++++++++++----
 include/linux/iio/dac/ad5504.h                | 15 ----
 3 files changed, 103 insertions(+), 33 deletions(-)
 delete mode 100644 include/linux/iio/dac/ad5504.h

-- 
2.55.0

