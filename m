Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835743E07C
	for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219543; cv=none; b=Ik5aADnYbDosZSENI37rJvQlp1zHHXqxeZ4jOXs6YL5HfrbjHbYRziiM6xQgVw7fTm15XNaS0pF17x0Jrtfufng92NCMrEplnUnxxnQz/HZYLCk3xz8AGlUtg30mgcamKQ6uJy3+8kdDBnIaCR/RwnXtNjyvHL9bDZaGA7tPDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219543; c=relaxed/simple;
	bh=ra+nBxwYJ9Dt1/cxvZ0GNQZEo/hQ3YnP/tmoVkrBeEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xo0aAQpp7Hd6h9I0tEIKtUBPYCJnekl+O4goymEKnnKaNK5tTsfHblkihm5QBPw43mwwomO7Gg238c6b22NtWYpNy488PtNeWUO6Y2ICu9hrZF5u53bAdYM59P5pse0b2QmUb5CVJaSG92fw2/TKcGyhZ11rzZWL1b2YEAjAEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAQoPF2/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAQoPF2/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49ccfae359fso13665405e9.3
        for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789219540; x=1789824340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kW/Q8SPmIwY6gpgjSddoHsXSzmBQy2ZAVo1h1jIxSwM=;
        b=oAQoPF2/kB+ldjz8uIYnip6ys/PR6wNJKBtf2TSW/z60pfHQ1gcE9o/udeh/qkmL9V
         lPNPZORklPTKfyztj9EwJ3KOC65kIn7q3TqQj+rsXFyLnQli87s0NCmjyD/4LYZpX3j8
         Dl/Wq8iW5r7K2ktJzudxr2We1fmEw9yAt9o+Vgj8IUXaFBv1unkuzMPqQ2FY9Sp/1fH5
         dF6Mb5RH9zOxfEm4rQMvzrPoQf9brS1c6VZS9DheOrelBgmK/KAr0XLXecL5RapGx969
         e77GDThipwSKg/LnB58iM/PkG/uENsf1+GeZ2XLj/UsunhirA7wui+05zJ1xH/qvQ6kM
         TllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789219540; x=1789824340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kW/Q8SPmIwY6gpgjSddoHsXSzmBQy2ZAVo1h1jIxSwM=;
        b=l5+oEnzB8DBTqfkLPaeIpC0+bqeVJYeNNSMSW7Ra9mYzflfkBXK1VT2VKWH3l6aY5b
         VJOzKpovlbjvr2sixC1mz8Ex4vUxkMYbUIrxmiiA6ucxEa9TE0qArG7vizKqlyNDRISh
         5BlQRbGAInnTwYvs0k/4R3ge7PYzRzveRD1xNmR5KTK2Di1OsCfbSSovWLQU0eLELm4r
         rC0bxurtk9mGHChJjTRj0ydy6esIokQ7AnAGkfwG3HGwje+qzBcKLTn5PqlEqAVIgXW3
         7jFuTnnAhBNzSF5jjlt89zgJiPPGigmF/9iJYtGRjNvCTAkKpHacukAIRjRZqkh2ovSV
         Hqbg==
X-Forwarded-Encrypted: i=1; AKwUvBxHpZCnKrZ34pJ/ManqFsg/7RWCvonBLBta9MfGdCzOaumbZkC5SWcoyCTLGudWbhSVuTks0FawmRE=@vger.kernel.org
X-Gm-Message-State: AFuF++kmS530z9KZBvaHZkR1xRCpyE9DisIH+dfAF2Nr58j0LKXwNedB
	aiZyTuf1sVP5eAToXLLddosjHnqRtmfyZF+/YU1/ty3k5DJFKj9yQxtu95OkzA==
X-Gm-Gg: AYBFou2plEvQzPWYb0jXl2KpYOK5JXzh1coomAtQLQGpMryzNMIrvYa7EeVlX1S/KFC
	XyAg7KsgsF2bmJtuhikpiMq7kuxbUimRSRJRIOX8Zif6KiraU54We6ap7RHAxExHLpfKc3cAYJa
	1IGR2W9YczuxFyIhrUveJQSoNCVFOwJcEl5lshsHBTAmjapblo2xHn9cTDUTASSq5AG+uQMCj24
	yXYOx2kOl5WopIGWPuzVI0IqZ7piD0kEPSBeRPuWC0uNtSI70Ojfrbl+kaRousJ3+Vvm1mduUB6
	96mHsGfCtUCjAwrGZDlU6o6hJ835BTy6jOU5Y89dvhgGXmcDTxMQkneA4UAvTUPbv2JsVPjLaDT
	R7GnJbZWN0dDxlYD/dMnv0GJeBgq/aovrKzPNpJs3JEyJ65mjVlFtv5W6Z6s0yOroht5JHQcH+W
	XFuTmHRz5bxn2Gpwxqz9+gX2KtgXEszrHfzZzj0+ZgMerksgZwPgJREkU38Ee8CaBreNtZDOOQU
	w7N7wMApv9eozJseQ==
X-Received: by 2002:a05:600c:4714:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49e61988ce5mr95438225e9.12.1789219540215;
        Sat, 12 Sep 2026 06:25:40 -0700 (PDT)
Received: from fedora ([154.182.88.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee8bsm12684503f8f.15.2026.09.12.06.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:25:39 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v6 0/3] staging: iio: adc: ad7816: Fix SPI read race condition and DMA safety
Date: Sat, 12 Sep 2026 16:25:14 +0300
Message-ID: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two separate issues in the ad7816 driver:
1. A race condition during SPI reads where multiple threads could
   disrupt the GPIO state.
2. A DMA safety issue caused by using a stack-allocated buffer for
   SPI transfers.

Changes in v6:
- Separated the alphabetical sorting of include headers into a dedicated
  precursor patch (Patch 1).
- Kept the mutex addition strictly focused on serializing the read
  operations without modifying the sizeof() argument (Patch 2).
- Moved the sizeof() argument fix to the DMA-safe buffer patch where
  it logically belongs (Patch 3).

Changes in v5:
- Split the changes into separate patches for bisectability.
- Replaced stack buffer with a dedicated rx_buf aligned with
  IIO_DMA_MINALIGN.
Abdelnasser Hussein (3):
  staging: iio: adc: ad7816: Sort headers alphabetically
  staging: iio: adc: ad7816: Serialize SPI read operations
  staging: iio: adc: ad7816: Use DMA-safe buffer for SPI read

 drivers/staging/iio/adc/ad7816.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.54.0

