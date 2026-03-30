Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE12362151
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894657; cv=none; b=GmogM/t41KWt9H1Bpzi4ws34G4NbDtterQ0XldElg2LZ0Yx1EnVJdh28NtoVgmwFYWWCCRW0ALAN1+dJno7djTM9Cxun4HZgK7N/2cC4qTntjY5jlCQ/oh+yFnSoSUIn3lEK0RpUqLBq96H2HKkM5UECa1o9Q4kGdLAjZk2qFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894657; c=relaxed/simple;
	bh=AlU6IL91eQc6saKlTde6Kc7sbTCIrF44nuCbfs7O7ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dybwj3tgtjr/3Euz6zXu/NKP3rGQu1ZYE1f3upZCTd7AaXqGJeNbOIYGHLqc3FtntMDJcSCyzhj5kWjx7ua9p7XCDnqby+Hr0fbiCWkqDkXOcPjdKwK1NYoWEGcDinEIEswgo+6/eU6rPMOycdaKMFoOCQtkbK29d1eOjgh0818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6sLtOIr; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6sLtOIr"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-829ac4670c4so3506233b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894655; x=1775499455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IaRbKZC73FTsla4hY9cp+JWbndJRE9fpoUHFyce6xE8=;
        b=q6sLtOIrOu+ZSNDw4Uj0gZgWBQxCncrWGitIa5XTtXuFqIsz8H21/Ji6BMb+kVOl9I
         BSxRYStjlzDnymEUbnpFx5q9JVkCu0Q9/4lqghoU6earlxDkEqHRFhO8h5BxemJEh36z
         NchSdchFIjdFjzysbd7pxJeFRz8tSqxdRbRZKc5Cu6rQ8iG7fRdICHC7mitxr4xHgLOC
         edgnjkhU1TKdcFZYNtIVHYZRs0qnpPRh3GPbGX+KzkqIFD3/Z74JsVApd2VOe6mdmM33
         ygWQi2X7SCRniNDUzVlDc8rPQjQ+BfSUilzIaPPvH5zl9P7p67/ErfbQt9CYfH2arJ+6
         OBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894655; x=1775499455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaRbKZC73FTsla4hY9cp+JWbndJRE9fpoUHFyce6xE8=;
        b=oucz5U89slvPS3VUyBZyBuPMXEPZ5nj51Ojrmbpy0XKWP/lgrbVQvthhO5jTTVlZmD
         nuJ4Btnl12Pi42n1G7fZ/vJR8t5kp3nZYrKsYsHSROyDJIlNOxtEdFUIa4WFAxPXqQUl
         lkzwakFmnPgAVllHE8dgh/1z/cggKOH+6R09udpiUuSGQ38XIzHhDYt80YaSRlPJX6qY
         iq0GBrP/AMy4ymHK/cULnJ1T2SgbFCqtLfDex9btsy8+xUCfsUuoYOzCYvYKCzrt0cru
         j79hpKfY3BKj4vhwfAINM9c791k4RaNMh5GpdX7se4jD2qiVh4t9GNsKniBMBZ5emJ5N
         MNuw==
X-Forwarded-Encrypted: i=1; AJvYcCUbG+J/f84x5+5DKJmqCNoNVp+wtx4cgS8R7bmUUwQQU46ZMhu32WmFdIkBqpQFOAfelIKC8eJc4Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3xtMBBEG4k1pssVxL4X/3qWYCYVnRdv0oVGohEfKrwG+DzxbM
	EF5uZ4aX5TlFHLsWAvA+Fbm7QI6QvDl3tlwH8cN0jl/dpmHt7qjj9YV1
X-Gm-Gg: ATEYQzz7rQ1fkFYY/oM1JzC10BdY8BbFYAKC8LX/oiNwD2hTRyvBorByovJe3LumRzS
	yCkklLX/2Lx4YIhmpyEq+ZBu+wTMMY/W4zmhKgmnIxwmMdJ866VtvcVl0PAk27eHwvWgOq8et1Z
	/nt1NOLthLw4Hm07NTo2SOLVSylwFZG4ArEUjnAHi5fJYc6lqeTdaNkpQjyTPjEUGRujmMLhMSs
	oVkVIa34RjGyb0hBiuLruly3DqfHWYncmJk10YIsfvQLLmsI/NByBlLgcXvm54V7w7MB7AHGX9m
	+7t0oldMph4Y5kejghsfaXyQIJ6UepeCkiJrPitkbPj690g8/wZ9abXocGtRLcB9Fb7qMBhgYlk
	Efs5ZV2fMwkHLI284WKZ3w1D2mMZZDx0kpEvII/Fxt/USPa5Hc6ksHpYoFOCWQhDtVnhC8nPj7D
	nITsCTmNMkXNJGJMWWCGANJScuc+Z8NH8/oND7qDtk9sTpRIkiAD0=
X-Received: by 2002:a05:6a00:ae0b:b0:82c:9c4f:da3 with SMTP id d2e1a72fcca58-82c9c4f11d2mr10974682b3a.31.1774894655321;
        Mon, 30 Mar 2026 11:17:35 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:545e:6508:42eb:3d78:89be:591b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d4d90sm10099966b3a.36.2026.03.30.11.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:17:34 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v3 0/4] staging: iio: adc: ad7816: code cleanups and modernization
Date: Tue, 31 Mar 2026 00:17:06 +0600
Message-Id: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- Added missing Signed-off-by tags and detailed patch descriptions to
  all commits as requested by the automated patch-bot.
- No functional changes since v2.

Changes in v2:
- Renamed sysfs callback functions (e.g., ad7816_show_mode to mode_show)
  to satisfy the requirements of modern IIO attribute macros.
- Fixed usage of sysfs_match_string() by removing the unnecessary 
  ARRAY_SIZE parameter.
- Fixed vertical alignment of function parameters to match open parenthesis.
- Replaced sprintf() with sysfs_emit() across all show attributes.

Md. Mahmudul Hasan Mabud (4):
  staging: iio: adc: ad7816: redefine mode constants to start from 0
  staging: iio: adc: ad7816: use sysfs_match_string() for mode selection
  staging: iio: adc: ad7816: replace sprintf() with sysfs_emit()
  staging: iio: adc: ad7816: use modern IIO attribute macros

 drivers/staging/iio/adc/ad7816.c | 111 +++++++++++++++----------------
 1 file changed, 53 insertions(+), 58 deletions(-)

-- 
2.34.1

