Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13A3B27C7
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158085; cv=none; b=d8cs53xiGrCtLLj8ETFh3AXEnA38BxRxeKSAqm2QfojfN0re3AMZtONWd1oIb7+PO8lcUYXf72GinymVGQna5H21KaiEniEAgpOPr2A/hx8Wn+FVCI9HRuMVBGsDcc6zJ2I8u21DcCAcox47LSykIFqEDRWP28pSSOOfmPCDTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158085; c=relaxed/simple;
	bh=QMgAiSmytxMD9/iUsqOIoDAbly6L3sYZE7VyWoE8tRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAYfut7Ll1+zJbPuNiqTAj7b7wc4BjsLjG8siFDEKOJRKIK+OnVywbRfUFIS1pICAX37iCxc4jrqkQzdv3526G/mXUdLeHB6LUiWcHizX5cBZpiuIH+xNdJZVf3AhyRuIBYWQ3NtC34aFpSmzrCqMUD6rLtuL139JkJkZF9DYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJZ14oLs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJZ14oLs"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43eb05b1875so488551f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158079; x=1778762879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3zJ7Li+6pdLcYuv0jxwsmP2cj3UViCky+5RLrc5w5U=;
        b=mJZ14oLskocYTVtBJzOPugvUF3wGQxzaUHYJCHuBI3ceDMioxBS5kQomjusER9BRrt
         jhxPs4GqlvxUgmW3u4jPdka11rJ0qIzUWkVeNrC4bujbNS95ZoFieuNiGqjBlHG1P91C
         et15Qb1urcfsbWdRjwrQSJ/eKpue7MNyBHwhN5+ALTdcxFbn5tAz7ZBkxmEDbl7j5xTu
         aHrd7+ODv0/d70tSR78QYaloe8T9p9lLA4O1NY465XxeTQFTYLTmOdlEDCYW97os0KKs
         pNI7X6nzem1NhSqDYuZKykaOfMSd+CqFNx2cnJCO4zpj8WmSAUUIhAws+nCtuj5kIvVS
         ETfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158079; x=1778762879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3zJ7Li+6pdLcYuv0jxwsmP2cj3UViCky+5RLrc5w5U=;
        b=hz4CoDnxzC3LV/kDpk0qMhJptlzNe7CMehwM5Zas/LBwr8IKiDwnRFZD7xLgsMxVqo
         xOfNvYJwaVWZAv716rvuCUiZimgvFF/ubOQI1Ykd++QnBoPief1tAFZ0jgDlhULJZ+gX
         h+jabokcgVen591xgG/WMGsf7XttuBHXY64O8D5Xp7RjDFkeH6pdMTUrBIBXemB/wfzP
         3URYQlxsTEXSKSi71Zwvkqtw6lN3dEaqjo6hWaEzqL5mvnsrHZVMniIGWuGYc+gEw6nA
         NXtSmhGiT9XjQ+Keag+ZBwMNCRn/hbV4WIiEW1m4s8Lu4gBgij6MMllnl+DMX3j7L8r6
         LlMA==
X-Gm-Message-State: AOJu0YzcEdAiXpEeReJJosEFRjSxOUWtNbu10ASR5wZ30WWnAuTAShS3
	KVFpxmvKZsTVZ8EcXZRGUG549g20gjFlMdirjayRwpeL3K+5Sr1hNKJW
X-Gm-Gg: AeBDievQUKxRLQHlWyK6DvR3D9oMNijoTByg4suZZG1oMc0FqjrPijWy+yKsw4IAD/r
	ktiAIa4yqznnSg/FGxf7+ILKGmLg+akAggx4icj7bh+N9XFDIXmO5eLJVmjlVWr0FFqjo9StjGD
	UAP9OsiytLbvexf/czjGjtog4echjKo4DOrMDldbPwRVyC4F27MZzQ2AtKkDoODzprZrsTeYtfQ
	1l8TtGbMeooR5lkKeWDQSlSbpE4YBMqFyVtYEfjH7RUVAcnkgh2hIiCfOV+8h8gIi+aKQ9U3P9o
	at46ZFO/M4BJr1GBIiPhioOeMpug49BPQKxYG5bDfex/QFipR6EIxBsLsjgrWlX+b/TmxQ7k6xt
	LqQCB8vB9oyYFCnI2YvAivc4vUWvIOgji2qOohpolvhMykvexbkGMlMhcxWhkBO9qsCFI8ss4Xn
	/5cqC3ZiY9hlEcDTAnRTKlWOSAfmZdcRfKofKMh/5Wx+nrUD1NpshGpB5cL1nnXHgRb+5PGMh+a
	pa8Mobr4YKmTFW/wK07y7yjXV8y3A==
X-Received: by 2002:a05:600c:354b:b0:48a:554d:b9a2 with SMTP id 5b1f17b1804b1-48e51e0c7c9mr124411935e9.6.1778158079226;
        Thu, 07 May 2026 05:47:59 -0700 (PDT)
Received: from ai-node.taila4f726.ts.net (89-139-15-25.bb.netvision.net.il. [89.139.15.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b6e9bsm209228145e9.10.2026.05.07.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:47:58 -0700 (PDT)
From: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: add entry for MEMSIC MMC5983MA magnetometer driver
Date: Thu,  7 May 2026 12:47:24 +0000
Message-ID: <20260507124724.813043-4-vlad.kulikov.c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
References: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..b1d9d7b586a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17170,6 +17170,13 @@ F:	drivers/mtd/
 F:	include/linux/mtd/
 F:	include/uapi/mtd/
 
+MEMSIC MMC5983 MAGNETOMETER DRIVER
+M:	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
+F:	drivers/iio/magnetometer/mmc5983.c
+
 MEN A21 WATCHDOG DRIVER
 M:	Johannes Thumshirn <morbidrsa@gmail.com>
 L:	linux-watchdog@vger.kernel.org
-- 
2.43.0

