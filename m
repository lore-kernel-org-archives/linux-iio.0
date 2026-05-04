Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E1347FC4
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886468; cv=none; b=nNw5LwDmpozB8/d46nwDsLWV3dqXNvRvRz4Ra+1/JT2AHgWbuQ1uTI3WrWhaevGKPfQbOku3HcS5NeXcKnM7/vIE4U9fxGuMBtSFHlykc/Y7ngfY6efnL+mA7AvoWG0P/cOneXHNecptuwqaKtNnP96l1QHbVKHCKNrhkSHW/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886468; c=relaxed/simple;
	bh=BnX504wY/5jbOBLNNdjC1wdvPax3nTDRleB/fm83Flk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYrZ9MBqzC1HEdRPHW8YcfWFq2O+nmw/PMAivicae4KH+UvOaQKYYIH3r3R7YrXBd+36F6DP14WGEKJxY5WUUKXsjDA3GtTugJHQ3KxdB1FTKhh1Ku3pgbrcWHgKKd1MBfrtV1lXT+xKe3xh4TgHpz5b9x2k/IgzbuahAljllHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kld+DlFg; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kld+DlFg"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1161008a12.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 02:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777886467; x=1778491267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fuuo/z2LhU5LQUkwEEphmvYVaLYefqtEf3mo5jJ8+1A=;
        b=kld+DlFgxcGF3V7n2Whk8bzyR8oljzOv61o64gq2KjXCbqhC5+RoauKkNgq6rTmRua
         jPl8A+GdZ7AGo8whkxYnscrgVWj3ARmaUFZu3Y0WnNKQWZhDjHs0C/OLXRs+6U2sBogt
         iRMaFk6jzkwKX715yXt/2zcrrghL66dymd1ceSolqo13XB9Tbp74ZF+pSlUoyYnN+yXu
         a4oOb+fOBoioyavrVgHBhIR1bHebG5hqrW1dh1FkzvLe6iFNnWXGv8p1OtXVfaht/3Ld
         vlu9cxtT1D0/o3IsCcMzPqDFNOCcCe6y+gOMoDs0CjVPSvknjjSx5oOb/89/CBznelgu
         UwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886467; x=1778491267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fuuo/z2LhU5LQUkwEEphmvYVaLYefqtEf3mo5jJ8+1A=;
        b=DkhfV84bFTVU87iT3cZ7l/P7zJ2DUSI7pZ9ZzLs+BErqGLCFHX5/1mTNF69Kdr+HN6
         OGNpFn/I//jOizLPlfICjlW0Ievn3FP100u/frcvJ58d73ohHxa93Q09t58Gyk0ShUf6
         5By4pfXylFaRigi3IDVs6raP6xWDKhx2/BXvuFWruJ+NxR+2l8DPmeRrX7OdZ3OY4vnT
         Eu0O/1CDS2OhxuNhMwNzioSDqMRjTl5dD4/q6GrcbtRELT/8tsqE7pqspCUabdhjxkRW
         vf7/HvWJbzxFK4DDPxATBjnLGpNv4Si2D5u6BXZxnC02g9nEAw+HdJFb4ZqvHNIDs5G+
         QKMg==
X-Gm-Message-State: AOJu0YyzXdbnd26NDv1CmcXguj0RE4/5Jp+g0O5Ynd5SzRw5PlbymrfJ
	w7ATAC6bzLIZSFKIrWOTOYnJttxZG6a65PmswkeAUS9JgQZCxeMBdW+YsEUdhw01itLQNA==
X-Gm-Gg: AeBDieuok04+yvJ84sLjjFT4P+ymL7iYhZiObdxow42cOkXt639sna7/y4w4b9Vvqv2
	sMUs5TSYM44PVTc0ptSrM47b0zBdZgw3pLCsu+3raNtnpKiXQ0yij6nN6LZunTYDGvoVRyho3rL
	mgDgBJAPQmdm2CVHcedUnCDewC1jzUyY+AVaVdQmO7vNqDtqGFVLBH7vO9+dkX/OAnZduQS8HfV
	QDZGnPPCownfyEg7AJUaPk46sqkXUEt4HXj0I/72jGm9yUh3dyHHjAjfzX8HkgKXk+cRe/nRn0R
	DY4JQ+NVqHqwOHflDEeInF11kchH8eHrLlcvQaIIw71XiJXQAxKFO1bdLTrQhyNGRdfIhGP9Dds
	UZthD91CHyqa2kW+pJcUKJGeN4IKjD4fQeT53eswvuaUv2dTzPKl6+Wb7Ter80opoFbdNKYj8kd
	gVuSv9jhmCnUIuZS+b6vDqcF8GfRN8qw==
X-Received: by 2002:a05:6a20:1e62:b0:3a8:9dd:75bb with SMTP id adf61e73a8af0-3a809dde19fmr4369375637.56.1777886466767;
        Mon, 04 May 2026 02:21:06 -0700 (PDT)
Received: from scootaloo ([101.179.98.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c802545908esm4163923a12.27.2026.05.04.02.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:21:06 -0700 (PDT)
From: Angus Gardner <angusg778@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Subject: [PATCH v2 0/3] staging: iio: ad9834: driver cleanup
Date: Mon,  4 May 2026 19:20:56 +1000
Message-ID: <20260504092059.1536094-1-angusg778@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: Split into a series of three patches as suggested by reviewer feedback.
    Also add a missing dev_err_probe() conversion for the SPI init error
    path pointed out by Joshua.

v1: https://lore.kernel.org/linux-staging/20260502021815.3953423-1-angusg778@gmail.com/

Angus Gardner (3):
  staging: iio: ad9834: simplify -ENOMEM return in probe
  staging: iio: ad9834: use dev_err_probe() in probe function
  staging: iio: ad9834: fix chip name typo in comments

 drivers/staging/iio/frequency/ad9834.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.51.0

