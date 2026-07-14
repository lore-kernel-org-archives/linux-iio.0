Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334734750D
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028719; cv=none; b=Nrb7ABKiCVNk54a+b7CI+rcEeamLiauSuG/Aky0y5qkjT5PlBGWua+yAlqRIdzXWECZ1yNm6++fXjgZsbCP1k5OXrZ6xmCq6d7jivQG1l/+3dlNzreCkHDZFSAUJFLEpLshe2KZrfosDTYz4v9Jy9XXwSJBo7b0Ne5yOJeuFfHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028719; c=relaxed/simple;
	bh=ztaah7FswqrBKYufRFLu9xEbQVZRkHu40mWNK3sBTbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7ep9TRFnMCX1IMjOPD38x3GaUalQw0jK8XDZWJUgQqLmci6pVWsYK79JIFz8Rvs91Bw1rB8ZLVhoN5Ee0Jrh7avEe8nEeNfnQMBBe7qcgReNFExXmfGT5oofhCAV+Dx95NMoHCbSrbM+Lf3qe4xhvhM9cCXCpuDlbw11bqgKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYdyPkWC; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYdyPkWC"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca913a601fbso2883640a12.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 04:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028718; x=1784633518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVTvsPo5yWPdElSCJe1QICilasV5G2rwHI+ghLjXid4=;
        b=QYdyPkWCfU+VkIUOvccwunwakrCONF2LwAWXiUaMSFOvySe+VZAZrYcNIigmaiPq5f
         +gPkiaE+kbqQezOJZEIR2lFJm5OOlrIjrYjNkG3HuU985zpVpA0aBCiOyIZbdVoAWlkt
         ZH6401kNEWuRdwRFL3TRocP7awRlB61R4TD0vFg0jxNLkImZPTggeHQt4j4BiuehHQ3i
         S7YPfWetgnkTRhKxNLRDZuqL9GlzoSuCfY4nysJa7jssjjmraqfofogLuVoG7nyAeYfz
         wdCpV/w2m+cI3LxrU3vvehiT8d2lXdBp/GjQlgVCXoPnMOild04KmeBnNjjJyswYkVwc
         9C8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028718; x=1784633518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QVTvsPo5yWPdElSCJe1QICilasV5G2rwHI+ghLjXid4=;
        b=OI0cSC8o0JESFheTj7ZehuLiqpZpj3a/sMLO9x6KBDm4B5ltAtDnPfWNYkfGxhvvo3
         d0P5tgLUHLI9BCjzYifcVjuDhaWpsGRejsfv0W4peGiCLUyBNCFgyVLWinvPxHjaCFbE
         Jm1tSMEVvNZMIBRUCHVL0nz7rPehtps1DWEzyojkFlLEulRr6cROTEzqEoCPqcMMBw4N
         oBcIeDYkXo9Z7I1rTh1D/v9BMPCc5eINsy6Wly+cG+os1pXP740qxyYHFNRHkTIoq+oE
         dMRVwonxW8eeGA0XOqjJyzKbGWKvWEZvR/e8/Q/nIlG2GT6QkOO8NM4wwlHhd5rrOBxH
         3LXw==
X-Forwarded-Encrypted: i=1; AHgh+RqY3L9/xlfI3GUOR92+LVtkE34gNAux8T2TifZ1uUAX54eMDvja/MBTj/ygxd6BvJIsgiFxq+BuO8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxXnI23SryfHLNc5kjo/a5v+TYvz0Spnq63UGf87gSbL0P+iOQ
	eXJnepfn14VnHLrGPs5KYlmyxobfObNkcLFNHl/5QWo4jk0nOq5tZsY=
X-Gm-Gg: AfdE7clGqmM1/dP+ALuFviNazViZPlNZi8qP6oxpYtxw5zxF+ECloc7r6mPe7Sgay6t
	TC6Bw8xdlvTksO3X2xh5Eq2GXrdPaVwcizA/NwQdaSJSLu4QtR0Me2qz+MhFn946UApeOSsqejy
	6+GIL5ps8WcBXaUSSWZQsJA4cvX1Sw4TPiCDZLTQuM/+NwgnH9SAMzjkODQrdpmbKLuHGdRFVoX
	65q1+0xHcE1s4V7vj+pZYxQGBuWCXfzkVhI1sysUURGLsevUiapUir5vMY++UjKX7bGkbvX0itv
	fFA2JYz8Yg1UgPh0+DjJe5Wz/NSpn2Hryw8+vJyD7/oU2D8nbqCQelMSVmjGLl2+tCl1anAedGp
	GI4eG7eYi2MTGvmvEg1+bcWH/pugDKrEaYVbR5q9P3j7XRncHDfB62v/ESsDNadZca31DctW3yL
	RhQUwjfv9YcUu/Qk4SHLyQhJrnoGA73WhSV1BP6YFMcACfRZk1oXaj
X-Received: by 2002:a05:6a21:7a8b:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3c357395a06mr2281496637.20.1784028717926;
        Tue, 14 Jul 2026 04:31:57 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm95357368eec.1.2026.07.14.04.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:31:57 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v3 4/4] iio: light: opt4001: Fix reversed GENMASK() arguments in fault count mask
Date: Tue, 14 Jul 2026 17:01:34 +0530
Message-Id: <20260714113134.3445-5-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260714113134.3445-1-nikhilgtr@gmail.com>
References: <20260714113134.3445-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(h, l) requires h >= l, but OPT4001_CTRL_FAULT_COUNT is defined
as GENMASK(0, 1). The define is currently unused so there is no
functional impact, but fix it before anyone builds on it, and add the
_MASK suffix for consistency with the neighbouring definitions.

Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index bb4be6384e4c..731eb8d7326a 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -39,7 +39,7 @@
 #define OPT4001_CTRL_OPER_MODE_MASK      GENMASK(5, 4)
 #define OPT4001_CTRL_LATCH_MASK          GENMASK(3, 3)
 #define OPT4001_CTRL_INT_POL_MASK        GENMASK(2, 2)
-#define OPT4001_CTRL_FAULT_COUNT         GENMASK(0, 1)
+#define OPT4001_CTRL_FAULT_COUNT_MASK    GENMASK(1, 0)
 
 /* OPT4001 constants */
 #define OPT4001_DEVICE_ID_VAL            0x121
-- 
2.39.5

