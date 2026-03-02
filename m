Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86A12E1E9
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456810; cv=none; b=CSEVLlvHw+oO9xd/Ba1F+4xI3zDz2wSCvXfCuVBeqKWipcxSp22cfCocoLtO/Oe5ezp5AOJJNTyCESb97pSNOiE1HvtVqSVec6Q97odKjNl6Kcg7iGVNTFQbVnNPG9VIgU1eVRjXgLSbTULsal2Zz/zrng2Fpz0hXSw6NCaJbMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456810; c=relaxed/simple;
	bh=Ld6MvIi6MtpwIUxJCjSytwy6J/ialoJ4KrLXi8H7gWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tZqUWe1CRzWIb4YznZGEpZk8x4XJodmAmK9PSbsptlMDYPAvIQiUNyBJouqFaqKrFXoBDS/8tIGw55XsS0luWbDdPRKiLLDG4i+EqoxAB1Zku/3/JIPnKzI7dvUA24RceUvkzf5b5MXsz0hpIbPCzmvmU6y5NGMu+1Rtv219NJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA1gc4wh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA1gc4wh"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so581276a91.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 05:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772456809; x=1773061609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg9A8B4NO2qDfBh1NkMwAlYZ5E04V3epme3nzddl+2c=;
        b=KA1gc4whHR4uzm1Ym/aPKSq2V57e/SOhCoAXPiloGlimFGyZcNo6FOMauWXZ5EtBdB
         HdVz9RlljKJM37NiZw22UCdVCdbScZ17M49Mg0dyKbcHuNUFWberuUwjjnxRyWSE7IGS
         3O4B9mKzhXSKu5ubArNZF4RwFOG6LY3JZrLA+1mbqZwxd8F+anRvqPK4iIjv19Eqi3Oj
         o6diHcz96JzZ5viuWNqhOEDYTGuU3A6JS4HC78pD6xJvZYYZoWdFqzNN5ztDx6n5WpS9
         aAT6wD5nMnd7iI/oT7YtlKeeidneTO5SKZqrpMtnyRD8C10iBTnUPFBrvSaT2MFlVZ6O
         3lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456809; x=1773061609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg9A8B4NO2qDfBh1NkMwAlYZ5E04V3epme3nzddl+2c=;
        b=k4DbS76HZcdcXT923RxYw7Lzx7paRBKNcI1VZJsPRB/9R3OXNfFeVpZ4kgMQPKYjbb
         BV42/bs3ZaAlKHLQG+N6JFdUbhSryg088y2VLvUuVB/Pe0IMfB8XkA9Em2PQi1diO1a3
         zlO01hGZdkPv1amw++vwFvTdJ9m61MsL8uFUHvubP/HF5txlkR6gCNYnvoIt39MEjU3I
         OpT8j4tR4PDPkSSDRzYbKdkhzPVvU2b+vg5/NruoHrxGObr1gqBJMxYD74uG+ECLORfL
         VPBGHsSMdr2GKumdg2QHEim2XwWSuIkxoYpVrWQgCAncbPNg7QO5WYAkZAgCJauVPHCJ
         tkGw==
X-Forwarded-Encrypted: i=1; AJvYcCUvAwaHMH/NakPLtAtvmDWI8m5izLcIkrTDKvBpJhwv5FWq8JWBoROIESkQAHwOhkn5TtViGfk8ck4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9RA525JIxrZv/Vq08PV09ze8lzbul46uOuvICi8f2GaOemFg+
	VSd0PCEjSA8zKCDJEKCZKWwkxNxjy01Nn58gLT3aZnMAXs3K4O3TPwWR
X-Gm-Gg: ATEYQzwrodzKp4I1V+EEaCSbzOvLsRk76QdG0v/hkBVgCFm8g42/YJ3wo19lWfWGltX
	4SSg3/v3+eV4MnWtdsFst7wWy56jF+1sFF8I7ejPsAbmJJl/sEqOkstZ1qoUziBBtxsRvWI7oHf
	pCFh6RdtBKXp0pY8TKZYJDtCIiQdooEQMygLnbmxh51P7DRQvVjHuf5cNq6S8jUg6KzUb7qWn44
	qur2yIWzEZzfgdbnHdIkXFp12FDKtdBifWFqY7gsVNYYoAp1/gDzoslWUAvwaS92micbWYvwOFD
	anrBVFQdS5utpsHefuHExiUX0C1Aao4AlVxql/97/Vr3L3FnWEjBWN2bNwEGCj57ZrCuYhr8zFN
	/iEdtMI4suZFMt+z6kTlQdVHOnr+aNRPvgeV4RnPqwQqgeq8zKOPE8bR3vn2ipMyDdLHgv2zrpc
	L7+0VEp4Vxy5TD3eX4W4AxlJfzOLDStnL7qEla4iYmJQ==
X-Received: by 2002:a17:90b:3b8d:b0:358:d80e:3831 with SMTP id 98e67ed59e1d1-35965c17f1dmr12711718a91.3.1772456808945;
        Mon, 02 Mar 2026 05:06:48 -0800 (PST)
Received: from debian.ari ([152.58.176.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3597b448e38sm7444585a91.5.2026.03.02.05.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:06:48 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 0/4] iio: adc: ad799x: modernize resource management
Date: Mon,  2 Mar 2026 18:36:28 +0530
Message-Id: <20260302130632.29144-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the ad799x driver by converting all resource
management to use the devm_ infrastructure, ultimately allowing for the
complete removal of the ad799x_remove() function and simplifying the
error paths in probe.

This series addresses the feedback from v2, where the changes were
squashed into a single patch, by splitting the logical steps into
individual, bisectable commits. It also incorporates feedback regarding
the safe ordering of regulator disablement and IIO device unregistration.

Changes in v3:
- Split the monolithic v2 patch into 4 logical commits as requested by
  Andy Shevchenko.

Changes in v2:
- Incorporated feedback from David Lechner to eliminate dynamic buffer
  allocation.
- Incorporated feedback from Jonathan Cameron regarding the ordering
  hazards of mixing devm and manual teardown, utilizing devm_add_action
  and voltage caching.

Archit Anant (4):
  iio: adc: ad799x: make rx_buf static and DMA-safe
  iio: adc: ad799x: cache regulator voltages during probe
  iio: adc: ad799x: use devm_add_action_or_reset for regulators
  iio: adc: ad799x: use devm_iio_device_register and drop remove

 drivers/iio/adc/ad799x.c | 86 ++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

-- 
2.39.5

