Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966234A3A5
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899624; cv=none; b=mdpTgVluPCb1LTChepSM5gPeTYSaA4OmMwWpdqYFdj2BFQanq9+Ddpl2UVd4/lkLzL+PlqABCfK7Em29Qh4KaScxy2Usiu55oNzMuut4qgOF02b8GH0644cd5Hq9IGinZVd8ukkCmqeWagGOquSZj4mES9UsNFHYO+oxK70hQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899624; c=relaxed/simple;
	bh=K8zG1SI7+YTsZebXPqupWoBr7oXvGMdWH3jgL+k3oxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wxdm0cNhwgZ3+QhepCfVi8PoDG+Uo8FMTsemzWw/hnd1LH8LKjgUsOptFKLRyeUDq1dUMoHnGYEgtl5QN3qOorUTh/rSefWUJhrALIKgHa+YJJxsd/6zZVdFR+HicQPwkGFii9f+1jgA3gqXC/KvfamCi6SwvUU5RokyzyxsVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=hjdWS9C/; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="hjdWS9C/"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56dfd007d31so3735507e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776899620; x=1777504420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8R2AsGF0nPU7uDYBA8UzRWDTdsVtE0drsgFjXOcv3J4=;
        b=hjdWS9C/eZN3DJ+bEs2n9WvWYItOc7cfptIB2wBO78Om8nuy1TadsWKQVkq5m2rkCn
         Kj8SPtwdQCZl49hYOJGiFSxcVYFhYACJYVD81CQkJYjs1QVmcj1dCbRzfqKgQtTMvFGA
         KIkl956CPJ8FW0y9n+pz+lwzIuMhXcjdq6RQyGUr5t0r1wZ9KO2pGadUHmueFYqtP9gy
         Ea9EPQzExgNvXm4g6DciTSdO856wmJsr1LT1Muts3WLHtS1I9MU8liPGnSPVSXWieIhl
         Dg01vyHQvRF89gzH0SP6PyLc0VorErWu/SasLGfdlFX8YkKPqR/znMUeWik+WcldeR7+
         3dCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776899620; x=1777504420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R2AsGF0nPU7uDYBA8UzRWDTdsVtE0drsgFjXOcv3J4=;
        b=nv5PDzSlBNQykRVWhNQF8oHJExG4rx4CXemVSyIjsbxX7RdN3xAEkJS0O8NcUpKLmE
         0eWsMMSZvMprdBQM3BKQKPV3m/8lrqbAGxQIf1L7gnCNhScLDbV6EEZ23DsByttRttGo
         za+oLYe37fE8sRztk4mHZcVYzQdo4OmVPLoUFHGKKBwJ2mn2ZZmglbJo171ScbvsO9o0
         cXlMRwczL2lhJiGy3+3lK8cWaIgHg2HmiZSxEODWODtr34l9lc+8fUeN9CgvI6M6yDNE
         e73eqJNaVjc8DQbP8etn1LXqdt+H4gsXIDsqUdgSuOmsiFSYNi/bbQ6/BAzTB3zuSdLO
         GAFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AxKFrzbteAPMCTx4+Aii9HVBdXWGvzsvf9Z5leKpdFXzoHgff1NcCYxVxg19Czera/De8FOwPoJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0bURP5iFV1mYes99II/hesoRuSID5tOai/r+WlxDk1vqyC9v0
	LBVhIJLWBW8oVORynTjf+mpB4IOqJcurl65imt4z8NPnQchfDqbZFat40yyZe14heGo=
X-Gm-Gg: AeBDievC+z+uuhaTWgKCqw5hh4HM1lYacJg3LivDbIb6VSxsNmYZq5z7CRlqfCBr0f3
	v0SXtr1a9Vl4iRjsVyeaxqQUth6VBqpgKu87qnCTFmQZF4a0cvnrxYI6Gco2mXPNteLspISqEad
	sHLOiUlHgzXtQY1wLv3IrTjFOYEM86r1wfYWmXwSlrq9jA7DL3py/wPqaa2XouuP8fUzS08+d+x
	kQ1WSm4aCwhG+kXF5lm+DTXFqbDKTPXH8tAG49ixrIJNHYcg3heFyu+acGkUu5JzQd6Y4/hX/sD
	NIjIVt5r8FMFXccaquk0T2pLhBKplxsQZ1SMB12Yj483okTiZvBMW7dwEkWOWjpg319fOkelnmN
	8pNzyIWeKWljgDdPIHMBL97/fAu2951jSX8MTMiCYnGTiqfKgchQfZgEH2FIq4/m2bQpjhZWNOk
	KfvPPSpFSA2AAD6av8FrtoKClfHptwmg==
X-Received: by 2002:a05:6122:e253:b0:56a:fcbf:8aa4 with SMTP id 71dfb90a1353d-56fa5811e9fmr13477744e0c.2.1776899620430;
        Wed, 22 Apr 2026 16:13:40 -0700 (PDT)
Received: from sales-arch ([2804:7f0:d889:b103:1320:e321:eae6:2f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ea606sm10669834e0c.5.2026.04.22.16.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 16:13:40 -0700 (PDT)
From: rafasales@usp.br
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: "Rafael B. Sales" <rafasales@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 0/3] iio: light: ltr501: cleanups and modernizations
Date: Wed, 22 Apr 2026 20:12:54 -0300
Message-ID: <20260422231305.677778-1-rafasales@usp.br>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael B. Sales" <rafasales@usp.br>

This series cleans up the iio/light/ltr501.c driver by sorting header
includes according to the IWYU principles and simplifying locking
using automatic cleanup helpers.

Also replaces instances of `scnprintf()` with `sysfs_emit_at()`, as
the latter is PAGE_SIZE-aware.

Changes in v3:
- Added patch to replace `scnprintf()` with `sysfs_emit_at()`
- PATCH 1: reformatted headers and minimized include redundancy,
removed cleanup.h header
- PATCH 2: replaced some `scoped_guard()` instances with
{} + `guard()`, included cleanup.h header

Changes in v2:
- Added patch to sort header includes
- Fixed naming scheme for functions in commit message
- Reverted original lock boundaries
- Simplified returns

Rafael B. Sales (3):
  iio: light: ltr501: update header inclusions
  iio: light: ltr501: use automatic cleanup of locks
  iio: light: ltr501: use `sysfs_emit_at()` for showing scales

 drivers/iio/light/ltr501.c | 163 +++++++++++++++++++------------------
 1 file changed, 83 insertions(+), 80 deletions(-)

-- 
2.53.0

