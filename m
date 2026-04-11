Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C519D065
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910951; cv=none; b=WI1ihleKmduC51weGKudyLsYPKfgrQ93SxuDfGCkAcmHh95lFVfTaNzm9LrzkUC6219GBfg5TlK1B4rJOQR1skSk5prXe4eTKG5P6bqBIP7hX7hXfB4QC9Y6b1ikpJrnjsiMF+/qgk4H+BSCsTti4GnriKVWGIrjYgLi5m5XCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910951; c=relaxed/simple;
	bh=4qyS8AXP226ng4M/DR7SLK72qDQ0z6wT8RLQ5Lpb7Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vb+ISfNpHd1dRCr/54JMCmS+JIKsLFKN9hhRpQOIaW3VpaKtE94SoNIUi7KbH0+R3+wTUDzsN+ct2V+4nErLoxY+PbtQ+USKzeRbaetaFpZjUUY7SlXW2KsRRWcSb1EdU0OZlXDZGkAMvWyHXfGHDJ4o/u03GFpxZ6Rhe6sxZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dap6qiuo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dap6qiuo"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so35871935e9.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775910948; x=1776515748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+q1XPaT9Ilg5jI8qJu180EK5Pt+3o6WGYBdxcSoMcaY=;
        b=dap6qiuofDiWH+Glj7/lPFQs6RgAimvpvBbt0bJmztBVaaG2PN9Al1aRk8aNnNob5c
         t7G4HhMNHuMU1VSI77AVPrXIc4zgEuRnmKbzTB7KaP9ihUeLOQeQtnjvPvKuB1qiJeiC
         /9uvW+FJPZL/hkp6LbkDeCQG+Nq3VRp9YquUmpeF/19DCUUMuIqlLLxRg5MW69+km+3m
         efZxifHjQ/hVrWpAkxsa51jlRN/iC+uyBa7N+RamnysLKTSQVppAiJDp7jA0PY7FYX12
         SsrYmUDQmowoLartb/D0BF6A5VnawbrGyxejQa7gn5HJAWs7wTi/orlT2gIbbp11yjDI
         n1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775910948; x=1776515748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q1XPaT9Ilg5jI8qJu180EK5Pt+3o6WGYBdxcSoMcaY=;
        b=UqC7SH2mYi1pEacrbSr3CHjLTwsD26BoFylRK2cBBAUeE70czpc6PmDdNrWQ2fKD9R
         0/wWgzFnYNwH8bijMtLwj66a6OyxTfnNMi4Ubd3UuKTVwIBctuPfuOl9TRG8aPHqy14l
         eEdk4CtZPBMLwaKrsv2lAOV7JOlj1idjmm18czxH1OfviScV12xgO4lh3XjVVB0i2Yhj
         ujkFAbnDwgul51xHgdiT95ATBoQA2sLqIdSPvwIvpQm0PppATUpCaktdE0XACwCVZaaa
         Rt5GuuQeNrQ9XBZIfhQF11GBFNM0P3Z5D7SeuM4BRqX3z+8tm6ZOLaXQnmLMQBrZAfAR
         rwsg==
X-Forwarded-Encrypted: i=1; AJvYcCU5eIbGNTmT9aS7b2v08qsPOhw7fCE5t6sK0z9SJkjte2i2V6aWXFmTnu03lAb7iSemHV2CcxSPFKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBT1TE7pgwi9eWonUsYUUodhN78fBRbqxa3XjxaIbSDBPS/x7n
	DJK1ncZhqyy9WAm3y6QPqfHuOZOXt2/sQTq+kEb8Ifh5SSTDXXPJl/fGN3NodhpA
X-Gm-Gg: AeBDietFLici62xXr2Qt6RjbsYX6jSbxJrnAQsfzqekDJ8SSWzcZvLL9QL25HD5eFET
	caAqySuZ730QKbL58rfDohgnBV79NTw9z8KtF7yTXSeQc40qcrp3lubsL1Iq1YdTz5EkXAwwqBF
	9My9Ccqx4J6GIaqv/Ymd0PBZOJ5t+M8bx21W8Ic0Fd3VpwnUvxrpqFPnea52qOHRy1+ShusYVFx
	rKzr9fMPqBx1pL0sT98IliEaPJMMjiwZlHc4pIKLOQ/YQoFM2agizDEmGv+/4MNA85H31N7MtcC
	7Pdmmd4/n31cMdlisYwBX4LOt0dfOyJbq2fF8R9mUk91BMJFdL9wvYYj3nqzjXKDhXQH1zqp+8C
	qRVOv5oUmonU1+ZymOgzEtTNAppI7/8g6AyNpJ0I4A1Z0PeVEGlSH8WUqW7qacMnT+cGh9qj4Pa
	a857bfrlWXZ25sqOrX5k1bwKR03+TqIdZBOj5h8kjFxNiGkhD1aQGoU3C8aVUvAGjYG0L/4gvK2
	fDgPZvd9mblpldcgjlD71dbVYg7jSZYfDPo5AhXrMoKSW0hEMuNR8UAswqwsL4dMu5CYA3PdSUV
	QPJ/i7gAjktKg/j/Rbt1GgvA13NxjMV2IB6x1thUT7F4n2BP5Mp/HTDgiSWzfOsDX8KhJzMMMEI
	=
X-Received: by 2002:a05:600c:5298:b0:488:c014:34da with SMTP id 5b1f17b1804b1-488d688687cmr96158745e9.26.1775910947430;
        Sat, 11 Apr 2026 05:35:47 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-246-182.bb.vodafone.cz. [86.49.246.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm103104385e9.5.2026.04.11.05.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:35:47 -0700 (PDT)
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
Subject: [PATCH v3 0/2] iio: frequency: ad9832: cleanups
Date: Sat, 11 Apr 2026 14:35:10 +0200
Message-Id: <20260411123512.84739-1-joshua.crofts1@gmail.com>
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

v2:
 - PATCH 1: removed redundant bits.h include as it
   is implied in bitops.h
 - PATCH 2: changed ull to u64 type
v3:
 - PATCH 2: remove rogue vim typo

Joshua Crofts (2):
  iio: frequency: ad9832: remove kernel.h proxy header.
  iio: frequency: ad9832: simplify bitwise math

 drivers/staging/iio/frequency/ad9832.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.34.1

