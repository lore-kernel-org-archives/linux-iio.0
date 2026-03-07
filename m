Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68918357A5E
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772884177; cv=none; b=IxibVuogn+DT3GksY/TLDinEjHi+FGIeV61k4G5IRARaHung9eeMa0OpV7VP/2xsUY5vCDzqdQ9NR7p1j4pbs6RBlanQEbjDEP6qEs/FR3n/ViMbaGVGDApR5QEpPjP9kjHJTdxOnx6jzV848zrcw2PDAHhGzZK4QdynisbDn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772884177; c=relaxed/simple;
	bh=OGeAUhwq2xHJ4TxgRpsGVuF3q8EujQIeYoZZhDQzPBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAIq00qffjjdt504ZwELdOPy1f3BhCHyihV4a9qDE77a9X/J6B71FKNfBrg1N6dxdce6MZs4i0/0iXynrS1H7S0IjgMbJBBWsoafqi9hvT7f4ddDYeR5di52jO+Ddn2RcBSTTVxWvfA+P/SsmimIcoQEURDEM3SxrW1kAQGO+Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTSDp060; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTSDp060"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7377119453so1783585a12.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 03:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772884175; x=1773488975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qzrJNZstjJ+lRuYkvhkBZ/2X1OkNUCbMuLvnWpwJBQ=;
        b=HTSDp060I5branEt+dFml6OGcX51UPZfVgkvvO3NQAHtSRpZg497fzjucOjEfVvwoE
         HyVmji/kPWcaM5ecsVxZPuAkNhhLGYUj02PTAc2HPNkbCOOBd8GPeu29b7pCGtSeVbSk
         vsZoXXsUNKjjW+PSPY0ig3UV4zFGXksupLR14kHnEUkCDOSsOrC+n/X7qdJorpc8uwGF
         JZFkGPdXWuVaP52TlqlwcJ129gIBfs2cb8D4l+ynVcye711tb4KoCKMHb1aVk7bRku1/
         +WlseEYjcVeTYIiLdME5TnFByz7Ydbzq5r/UYJGDuCzKwjpV/9yV5Q716qyRsfpCOpUv
         mEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772884175; x=1773488975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qzrJNZstjJ+lRuYkvhkBZ/2X1OkNUCbMuLvnWpwJBQ=;
        b=XM+zIfxvmMp7hJI0V3Y7xtuT8YaoNy/nG51L1W019RK1j8CncEES/FpYw1DlsdBMx8
         1PAH2YKw9/pUcXS3efossCz7ypM49RxdgscKuQu4WiT4f4jS6pHaEGTbZ9rCRDt4nAxT
         bWwJsu2KHDl/GwpBgTdgm1Kk7+lJVz1HLzU9PxCxz60QY4pvZCop4V2X7V0RPS0yNA60
         Ili0FeRVhK853bqU43CFrlyWRcoYCtEAYUYKHKO39PM/1vyn0KlFxxJwgYkI4nF69tvG
         55g6J6aXwQN2LDHfsAC4tUjdF5W9z63Ir2i+yEkSqhPlziz8gZUdGV9tfh/cmrHHPylI
         CTnA==
X-Gm-Message-State: AOJu0YxVtqBOYKJxlzXtTTnJtxQ6+zFnVE/pM8nXqfZWvoOPDHGg/aI/
	Ukt60yqVC7z80YS4LtmNxN4jKNZJmcbpyT2VOdF9JerTRe9L6NVBGd3i
X-Gm-Gg: ATEYQzw3aCXRlH3uZN5nE4T9ef60DKGylRhqzF5FYhRWqP6DKREH31+p+sGL3unZ6Zk
	HBGmL1pgotvIUMIGu6h9ERVac2vnuZ2s9bAuiR1q06sT3qhlI3QnAi6vWWNqRBtG3XPbUC+ezBm
	d1gzPtKWnTAZCrhstjvKToN+Yid1+pOxFWWU0cNSKm6X05lnKDR4bbMaEa5q6u6JsQjt/odMk+g
	xVbdq6uhp80FoHRIbUrmzihRAFKKHD+45eaArfocAZ3VgGpUQR0gGpBDuEhgY6he6rcgRczO010
	7Ui/Y1YSryQ8/GVg/eE8D2QKo+Hamin2aiOLImZLqlqi6Vg/qzgHSzdc2Wy1f4kXBCtFZnw5LC4
	lc9/vuOaRZNjDHHKUxMvsakiCVvcmoDcOXirknkpWsMtzejjP6R6Hv3IDfF6qYt4vjnqCiSsn2W
	gzs5yMWjU8BYYFKnDdx15/UTuyKrRQ0kelvDlsUe9fT6jeu7CLt2Hb00Me8ulRetainULuqmh4q
	T+lBk+H45JfMO9vGe4FQZWL
X-Received: by 2002:a05:6a21:7489:b0:394:f617:b401 with SMTP id adf61e73a8af0-39858fb2f02mr5200638637.4.1772884174666;
        Sat, 07 Mar 2026 03:49:34 -0800 (PST)
Received: from fedora ([103.215.156.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739dfbf4fesm4264696a12.0.2026.03.07.03.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 03:49:34 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v4 0/2] iio: accel: convert to guard(mutex)
Date: Sat,  7 Mar 2026 17:19:10 +0530
Message-ID: <20260307114912.58062-1-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts manual mutex_lock/mutex_unlock pairs to
guard(mutex) in two ADXL accelerometer drivers. Each conversion
also simplifies error handling by removing goto labels and
returning directly on error paths.

adxl355 was considered but dropped as guard(mutex) leads to
code duplication due to the STANDBY/MEASUREMENT op_mode pattern,
making it less readable than the original code.

Ref to v3: [PATCH v3 0/3] iio: accel: convert to guard(mutex)

Rajveer Chaudhari (2):
  iio: accel: adxl313: convert to guard(mutex)
  iio: accel: adxl372: convert to guard(mutex)

 drivers/iio/accel/adxl313_core.c | 11 ++++-------
 drivers/iio/accel/adxl372.c      | 13 +++++--------
 2 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.53.0

