Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2744B690
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519815; cv=none; b=lB4jJnz6FzEiUDI3auCEbGeC1UANRQdLOESQC8NSTXVc39SYo5hhCpEx3XOQNItX/m83nxLoQGR5+wAIZsNYJ4LMOH+EjiPWMxbB0pCuLEx3nI98TK3iKk2ZpROfKJC+pA0UkcWAlu+LrOCixqlvsLODLPzL/dWa0jSN28Vt4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519815; c=relaxed/simple;
	bh=WUw7HzC7HT0SiJ5sq+m6FFTz9WBuN+DXbno1ydbDFVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzZ9GfhqEnbz053FWxJzcmf/TaxrltydmoTXkqzgz3HJ/4sTzUDCkkAT3vrfYkSX2Oa2exa8XFYA3dldjhk/8pcbOG+dZNIPWMhOImZ2gtuJCfYdh/7mHCpj6l02USneKKATut9WHYpmnhgC4ZHUf2usUzoffJgOhF7q81blSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl9rpw+S; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl9rpw+S"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3664df32e91so3096450a91.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519814; x=1779124614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8s3TDISmVQuo9bxYz97mXO+HYQNSwXZyKwpDpkJyLM=;
        b=Vl9rpw+SNyZJBdt+X2yRPJLUPbNmdX1lPNi0SGM0SOts1whPnz1e+1SBkNEtKzbB5g
         fnFa9e1Pubhlj3KVy2WyTpv4B9iDMn5blRsSQ2cTTecsSvqFk0feMXDlANx0EzxqarxQ
         rcR6cKdtm2HDHYQLFjO2OPw+gNjTfeam1emYfjhORf24nt/Q3PYoBtP3KKQ5PRvF+xSH
         qeULmUl280QmGg9QPWR2FkxEB8EGaqiV4GmU3XrGiNm72gEfvcTTRjB+UFx7elbPk2Hm
         D8miqQ/d1Gco3pukGYwXqWQYZ4YFzF9i49pGc8k8ETIZgHU3AFUVEVCfbu53ZYnXiRfT
         m8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519814; x=1779124614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x8s3TDISmVQuo9bxYz97mXO+HYQNSwXZyKwpDpkJyLM=;
        b=WTg8d5b+81WU8depz3c2pUv7Uc7mFsOnXJzSnc9G4x67nvI+3gAjpnY1hRqUM1hlrB
         mT+PWTgfKEcRmg26NVUqaddOYPTg9xflSbwDVfuvoCyUFXaljBz0X1QXuyVrS8XUVCx/
         f8/HQ2bdYYbR5DQbQVOt8k/hSh5H242DVoVLblrDFELK7YjWpu0onwbtCKhxiuI7WMFs
         ikNSg7qBHv7y5EpRmvwHUFRDkBzzi/ED8w4GqgNusqvfSpMk+4PgbuB/E215jeQfi+A5
         0BP1z/SQAhQ47WJbvy5isIwl7PVoMuSHSZ88ugzdSt54HZe5j5g5TkuBU9xdjVxUQAax
         Nghw==
X-Forwarded-Encrypted: i=1; AFNElJ/rdxOD22Tyx0F54fTsQyi2kuWKM4GrhWQxW/w00gA0a5uQV/61QN0pG0Zhh/KE/9c3bE8Yfaui4uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGBD7XtBIWZc/yoNR/b5Gbpk97JwW8p/XOnfWTIW4ChqI5PsP
	V1wtHE6eQ0iFHbPGvYxh5NpCW6cNThdYI6RoSh71TZsWXOALRFP/jueO
X-Gm-Gg: Acq92OGDaraHBa8BOVdnJ62th0b0O1fOKttgsfj5XfvXp7re1xi3XVMqxGT774gLpvw
	/0+eacn2BVAtP5a+PxSwXs3BrHZzsG08RStGyYvu7cOHYO1CvUzfKPsi+KWe7blQDA95f4WKBps
	s3iHuRO8Gvk37k7woGsLVcuZNHNQNhVa2OjUEWDombvbgMyFO883mP+7UVfE899pbRIP598l2YY
	93d/h2X7PDsrPdCvlgdT/VnZjDovawUV3ijQNpf/IEasv02vxQKrD/WMu0rkeUyGCKbZ8yJws/M
	dT2cOpONynUZlOPKrhL/SmpSXKFB05R+kBElDFtFaZ9SRkDk7BnPqNaz+bkaRxqDcxu+CNweU7L
	Y9P9MmMoFXdvfP4bdEXcaflY6pK9Rxm7Y88owyiOwCcAV2LYRCg1LbSBYrjZZR81DCKKwYgaBFU
	zLamuVtkeick//uHfyj2F+bm8eltrXahZcpdKRtciP2aRpA55P
X-Received: by 2002:a17:90b:54cb:b0:366:5c38:fd61 with SMTP id 98e67ed59e1d1-367d46cf57bmr10944567a91.12.1778519812395;
        Mon, 11 May 2026 10:16:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d660b9d7sm8315004a91.17.2026.05.11.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:16:52 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	linux-iio@vger.kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] MAINTAINERS: Update Analog Devices IIO drivers entry
Date: Mon, 11 May 2026 22:46:42 +0530
Message-Id: <20260511171643.3173872-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511171643.3173872-1-sanjayembedded@gmail.com>
References: <20260511171643.3173872-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Lars-Peter Clausen is currently busy and is therefore removed from the
ANALOG DEVICES INC IIO DRIVERS entry, with input from Jonathan.

Add Analog Devices mailing list as contact and Nuno Sá as maintainer
for the ANALOG DEVICES INC IIO DRIVERS entry for coverage support.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aa9c989973f..887019830334 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1861,8 +1861,9 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
 ANALOG DEVICES INC IIO DRIVERS
-M:	Lars-Peter Clausen <lars@metafoo.de>
+M:	Nuno Sá <nuno.sa@analog.com>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
+L:	linux@analog.com
 S:	Supported
 W:	http://wiki.analog.com/
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.34.1

