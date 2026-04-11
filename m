Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF72175A93
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775897958; cv=none; b=CTPpvrO0h25qZ1aMovnlDm7oY7BJnuTSWD0F5vl2wUq47ecv3OrjMwEbJutbDiML2Jye8zYV+9k5CzBbuRV7EWTA9Ddz3mk8ZXTSF7FktHBpSNkUlR6QdqpE1NtT64bmXk0Ol/Do4TSSjECBINlBN7JLLBbLOFLvr5dU7r8nuNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775897958; c=relaxed/simple;
	bh=M2rvNeKl7obm3m7H8BnOy8LI0gbihauZRf0XJiGZU5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=obvckPI/pN02LK5+eV87A6zNcrxrZCZfc7ZOjowP4I5H6AoZUxzU3zSTnWhd1tcNSD64cTEFutVQdo2l/BUbmALyvEWgPmMm06FCuHPXba8uDvshmKRut97sO3U3d3RmclQA4z9uIcDOERnVthS1UoYBQxF/ErvUarN3HmmuDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXtITnn5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXtITnn5"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d17bb1c65so1850909f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 01:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775897955; x=1776502755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpn90LfwlQ2ld/4V5OOgTmgwzq8zjlzIpK3jFq7AUYs=;
        b=LXtITnn5LYLpsREK3boGGn71EasYYC5rO1ny765jSOOhx67Tj4EyCCw0doJkszh9d4
         b3LYlSxwZEOCcDqNttykH4MhbT1WJ3kp7mNSpfJaJSxJUY7HgKIO0DGz/EIlJMNl3TN2
         RUtgstUQtGGKL4TqEG63b3tM1/R+WUeaAuII8g50MIWBln6TKmw5zoViqQg3N1WR2kK1
         QOk3P7TGC2I6Tg8LwDt/mhoRx/NuBZXLh5ybxIwDsnGDVaNTh7QwUp+GWKJRogRwg09G
         AkKJL1yJ6eVrIi9yFywqu6JfXDfPGg7tYfPADcjVcS/qtM/M7tP3CSqD2aYjGRjZ1a5c
         vQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775897955; x=1776502755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpn90LfwlQ2ld/4V5OOgTmgwzq8zjlzIpK3jFq7AUYs=;
        b=K2P7gYJ+oq1pC7+I+R8kzDrziuiwfk4zlDHDD4ltD2zCXmrs87W1f21GBvy33Hp/41
         v5oyO6yXXVtSWmroq3ebOawJWafjsfhqF39r7TYaFQ7Fk8TUTlkIwmM28XaKrMSZD+DT
         CteW9Vtl/nVKM6ccH8PHMrH3PQ8YSL0bYkavi6rjnLdLiXJA52J2ddjcORARLLqnsxRp
         fOqWz105yw8q9xVURlOUaoRqzp3ZvyhA/pX9W2cI9wW/lLFgCT5++/VYp5hg2rO5w84O
         1K370DrfI2Uh3dVkogTsDVUMwdYw7tV5/sxAy0oHChHooxTl2lJl0PWmGpZQ1TsFblCg
         zwuw==
X-Forwarded-Encrypted: i=1; AJvYcCXJWX0ZUnhRuYST7ZdJLS0Cs5EcIMsGtaMtspCAaVB7lQY5VbeiNTAqE8gXr7XDnpK6Fy4ykrgPbfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydxluYx7ppWQIovt4TZWjqRkT4/E7TxdRHI6wasjNM5kmBzrnM
	Ljhzvj2zwOfgd3GCidMRG85eC0q7zsheEyRRHSxUbGBNapd+tWdcFPtN
X-Gm-Gg: AeBDietDo08VtXM674jk9zOjyOEkwVCX806/Azt6LifS5nJHD+MOVULDu52DpLcS6rx
	uSU90WEaEBVXjL5OhjXudOFTv7l4pJTpaqvYA+nQ7SMG5mOB5wp06ch9C7TEi45vH8xQRFZ1U+A
	hUpEh46ITJ7yRBYxZ8A7SRd2+7KijJ8r0fNnzu9vX7py8Nbnm18PfaUvIQon4F+xxACF0/4uBXG
	vmxnftfwWB1KbMDcjW2SzqAusRtpcmLGYwzDq71Dn8icfQJlhQl8jT/j8r+3BULMmXfqUBlWRfM
	gcXlbNdDag7eNPmnyQRzrx4gxC7PNPjDVXGEXdxPZSMUeFqGACQ1im/+WMsrRTqkvLohxujKJH5
	bNrDBnOjnvX2tqC5xTn/LDqNBroIFWa8WWBTSLiSnec+56mjNf8XkhxHo9bVUm6B9tIZ6mLMtwo
	pPEzknSKzAsFdwtM5bPwUc1fl5XJDFtg/gI6/dP4mBMHkIbHwbIGDsdGCw/O0UCSNtDNcnRZA2v
	+ZjC3STu/isBw3byX5p2oWHJVhHCL8yOHVaVaoEXFFtApmTPnk8aPnlo3sY+xQnYzCl3W6XIO4f
	gPeGfzpBxxfi4VOaUQbl5Hc4fLsMsQ==
X-Received: by 2002:a05:6000:200f:b0:43b:8806:be32 with SMTP id ffacd0b85a97d-43d642552f3mr9239453f8f.7.1775897955263;
        Sat, 11 Apr 2026 01:59:15 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-246-182.bb.vodafone.cz. [86.49.246.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm14483593f8f.4.2026.04.11.01.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:59:14 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [RESEND PATCH v2 0/2] iio: frequency: ad9832: cleanups
Date: Sat, 11 Apr 2026 10:58:46 +0200
Message-Id: <20260411085848.75381-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up issues in the AD9832 driver,
including proxy header removal and bit math
simplification.

Resent because of typo in linux-staging list
email.

v2:
 - PATCH 1: removed redundant bits.h include as it
   is implied in bitops.h
 - PATCH 2: changed ull to u64 type

Joshua Crofts (2):
  iio: frequency: ad9832: remove kernel.h proxy header.
  iio: frequency: ad9832: simplify bitwise math

 drivers/staging/iio/frequency/ad9832.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.34.1

