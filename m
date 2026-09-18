Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B304EB87A
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734342; cv=none; b=ilKcJ5UpKkD4u8ETpTqf2roR9xexyFOfyB5igmcEj1LPnzBsn37HA/KVQwwkfy14ilh9qyz+ul9zJldO/KHj7ECiIwlO10Cwhf0XqzfnBs7WlBBYcdcGhAogq0/sqb/5bN8N3nqrQekJOH4N6ah5fdgjNyNkQ8iiJEUMT6GCsV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734342; c=relaxed/simple;
	bh=LSoXDOkihoTe+1aeuwkzPsOIbGrXJATfUTeqR5S99lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGnt2oV6m0C0/Qurlq72wFYx/TxGK9VbeodgBdIATk+eeDuL4kO8nseiLYz514h+mptsIOs/1AkJKk0fs0hcbmrH3aj5xrz+RN9K8/DYjF5S8yRgJZhYiRWWF3dp3jeALwHSKFIiDJW6vLlroTZcZ1bwETOwNXlGWw9nE1Nz+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEL7xXN0; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEL7xXN0"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74e0c2e4dso656029e87.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734329; x=1790339129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pj32bFFZvi2cnsgj5gH1ddQyBwu2DGpSO+g4f8bX3TE=;
        b=AEL7xXN0UwJ6VFsT/iXOdPakeB/ZVEYtVslE3nC65clMSIVOou1AHTB8zFs1EBYiK2
         dK3ml1bdkqUuHp+WKF+1oj587l55/l7MRv0uHjlLMTrPdABBPAX9/Xk/4ex1as6G2p/I
         LEQIW1QNxX5PBAdsIUZkghWsOxT3c5lppTj+kWa0gCD0h68QKDmDGEdHRX8rhh1PVtrD
         XodjbwqxXfZzpugmekin5S8nuRif3wn4hZYSvN8URrxUGdowDTd8Md5NRd9KcW4mMtUJ
         GVjpPikp++JFQmR4fIC5w+p4T1lNVwnepZTpl1ytkjhhx9pYMHlaFDhqx4TrI1+L6N4l
         cK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734329; x=1790339129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pj32bFFZvi2cnsgj5gH1ddQyBwu2DGpSO+g4f8bX3TE=;
        b=rlZQhExZbUKAO/OPGBv0oh6TXsETU7wbFmUG9umcsmFs5Y31OTeTaJS+4hWbXWfDlZ
         RyVGOy6SRJLlw/uaZLOCgEGBTLQpH0PGLVPBuUH1CtvG7r1cd5eIAnCujtItVMBFbLCA
         INSfXZYUNuzfgwqURSWtzEArb1yuiITGhfKb0VYxyVe4gbRppDDu1MkuRwlU40vorc/H
         9xbBgqjIyCh8oOuD0sitQwVr4qc95knwRs/RrOC4yxYYataOjAmgwzmljkDkd504Vhcl
         Jcr0FAM7SrXa0blofR/v5mk89w9/XQ/juPWks4O2ZtLakkWcfUy7JSmVPEE7ikjfz1q/
         6TDQ==
X-Gm-Message-State: AFuF++lSQ7tYID5al0k92WcLPhCvfLS1fxnCKp3TU2EceCSpgzN6fJuI
	a4iARuHvCe2WXzjb84ErU7CS2pdJa2jiSZAS8OcEfWZAZBr+HCTN8+Y8
X-Gm-Gg: AYBFou12AeixuHi0fBgpbz2qDzI8DGC4fPcaS+SdCp0suwkA1AlbMbMoRZLxjogG+PU
	W749htrCs1ox/SDqpQhzQOMVPTg6t/zlJkOF8Mhj+DBJD31uWeZe0ZnzZQOdF1YCHIZB9LhtVvC
	p7Wg+7n8hAAjRHPokc3FJIx9NZee+Z/QDRu2br+NiuSUPTeKRWPFq3158I4IyLWXsWsmcgLf37N
	CCqmSa4xyxKnWlGvlMRtDYdWuXKcLROk9Bfgs0gjmkzNyR6LmuMCxX3EpmHH9Ce03EfUHeI/GJm
	ROzolHZw26p5HIMgGDIkhsXU+xVKsPCTEUj/xB2EY5IldBa/nIsxepZ1ix1vUwqD9cElOc3phde
	0LQujt2pHuDRTwvykkhdvWHHBSkQongwIXzz1Krdf0VV3lgxa57biJPshXBjwFejQ9bldkCrVf6
	hLBj1/pxxVHGLXK9fhFRuMPOJ2Q//0OyLlhNDXTj4Ilh+hGmkOC/7/AUvjmhWMRBCprTFJOsbzS
	f2nyy82Wj9eFmSyA4Cnni8sEjokqWeebPPJKm21/KS47LU5fsCOk+LZ+cTGUHNyuEs//A==
X-Received: by 2002:a05:6512:3c89:b0:5b8:bc5e:b584 with SMTP id 2adb3069b0e04-5b8c195dba5mr702953e87.60.1789734329260;
        Fri, 18 Sep 2026 05:25:29 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c270ea53sm398549e87.12.2026.09.18.05.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:25:28 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v7 10/10] iio: pressure: dps310: check the lock markings with context analysis
Date: Fri, 18 Sep 2026 15:25:17 +0300
Message-ID: <20260918122517.377565-11-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918122517.377565-1-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__must_hold() markings added earlier in this series are only
documentation unless the file opts in, so switch the analysis on for
dps310.o.

Clean with clang 23.1.0 and CONFIG_WARN_CONTEXT_ANALYSIS=y. It does run:
dropping the lock around dps310_fifo_drain() warns rather than going
quietly.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index bc0d11a20acc..4b1a05f7a0bd 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O pressure drivers
 #
 
+CONTEXT_ANALYSIS_dps310.o := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ABP060MG) += abp060mg.o
 obj-$(CONFIG_ABP2030PA) += abp2030pa.o
-- 
2.43.0

