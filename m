Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7C476061
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714905; cv=none; b=Qd6qqQAbpfHa2SU57nREvOMr2uHFARlCVogOBvcFEnWXtxnNmJIribcVDNq/8bTqaC+MJYQyhlJhtJBm0wbaxib4slq0OguuIktwcXeofwsnlxHQmMsz0gU9rrbnUxLK3PC0djvYaqEFN3w1fCMsCUSIrdS+JcTvC18PyVnBNyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714905; c=relaxed/simple;
	bh=gFgCDtaDhkHUy5zlzen5RjHhMrQ/5qm6YfwQtHm+KaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpRep08+y6WIIq5TGnRHzagkgaL9dwqkjCoaa5HDQnHXdqTaoNEANos8cesUVVWkZnQ+JdxRkwiEUz79/UQjCloE36bVxzxuh5qpKRdjIBkmUvfF/YbmEIVlSFNYG3o4tiBXW4U0jB/RxSE/snkDfu+T/YSmj2I5EkeoLKETr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5f7i46n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5f7i46n"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf50c6f235so12554565ad.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714903; x=1787319703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AW/kAhpxk6iwgmshFSjwEkP45x3FFpydZgKHFvSyQTQ=;
        b=r5f7i46ngDcdZiNETABSXzFfZwTfRROE5Nv2iIOw3tOMZ+6x4A4N5Xf9DUdqFIAxkY
         b9ONMZcrSfkZmI1eb4w04SAYaKFiluv99bJ+3LSD3tyMZf0At/LtXNww1wxv+jybLywE
         cSamRgB01lrVWWm60MOq6+5PY0Thds/+fYrZx2A8osAPKkkqCACQtTl97VPEYrwE0YX/
         fdCgDC9KCSdIUa9OmS2Kbh/d+lx2SuBjdxWVRILpfGmDpuvlZLGGCxyO3JM8v1HgWlyG
         GH68BK25zHGXnUY1pyNt9SBmhNwFWY4i9oKl/JCTRr4Q4xTFzPx/sqfvVoWTeQZj4QF7
         jizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714903; x=1787319703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AW/kAhpxk6iwgmshFSjwEkP45x3FFpydZgKHFvSyQTQ=;
        b=EiIhD4p3G0LdMVyaha/pN7iGzF3P3aXkdohsUDBOP961Zr4ygJQ4yA0KLyCZ3cgbcj
         8GWrSSdHP8zg1J3ZmZGWdeDxw35QQMZjIfpkLqVnfeOeHDwEHqXlWopOuM2pyrZAr0D7
         nOUvQOCSr48VKJgkrDJriOBF66Ej1AG/4t47HsOsU6rb6BZR92TBwDYd76PYgxvnm0qX
         DRdg1XeVq8e2S0/XbbEhlfsbWgxzWzbCKCS+xVNk3AjBpaZBCdl461/LkcfFucRfUmj7
         LfwFcHNhzGIuZHS6Gi97HrGkvKlBBH8mm0/im4PuBSp400asuQzz0iP3th+anDXV6ocv
         MrVg==
X-Gm-Message-State: AOJu0YwGvIeYcsnA/JMD2wCcVQdbcTGyUYIEmEL7YB1LkLucv9EDj42Q
	rpC5yf8mwU3dLREmAT8MxH/i3nVD/aM/NoaJajGZVTp2yLemWo6imuo6
X-Gm-Gg: AR+sD13pWki/vENF2PHDy2sBpS9FnRP1233jG4PlPvoBBA6MscfjrmEO3fF7RIRQvgO
	AAnBC7a1tDwo9O9clHJqL1VNSkzjAsDhPcxm7fe7hQEtXF/2cT6ICaXzJDiW9rvUIyIRxuvmMk9
	Z4p1Zn3kWVXgpdZYeKWgzChBGN1ZNISpB8/sCzay16+q1qWZTCmBe7ZmSbgsy4FY9PjPNY2gsML
	d8xYSGV3CdTdqyqZ5satEGKic6FcvlTUSFe3Wq7eY7mZ7BglwoxXUBTP9fTNCCKIeWUlr1Otfpb
	+s6c95uRmIsU5P680272EAXlJT0noKA4Y9Q4xFkhlBJGEe3MuHsV0U4lWHyObVseKJWc5T8prfp
	Z0hacIzBOeXGQtIloDpIljrehoygMsCbaJyfwWTGVTg4TeUvuYFXaIQcXH8soaUGriRtreOfjIJ
	st78TlslzgDcb1zHAf4O3Xd7sadO2rtWeHYh6U5yu651nrntSqiCl102k2eJCejlzS5CxZaPJAn
	XzOTBRY
X-Received: by 2002:a17:903:37c7:b0:2c7:f2c6:89e0 with SMTP id d9443c01a7336-2d3b08053b6mr72682355ad.4.1786714903174;
        Fri, 14 Aug 2026 06:41:43 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae7c067asm10269255ad.28.2026.08.14.06.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:41:42 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] counter: rz-mtu3-cnt: Balance runtime PM on enable failure
Date: Fri, 14 Aug 2026 21:41:38 +0800
Message-ID: <20260814134138.1388045-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rz_mtu3_count_enable_write() used pm_runtime_get_sync() without checking
its return value before initializing a counter.  A failed runtime resume
was therefore ignored and the callback continued with the device
unavailable.

Use pm_runtime_resume_and_get() and return a failed resume to the Counter
core.  Keep the matching put when shared-channel initialization fails after
a successful resume, and leave the cached enable state unchanged.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/counter/rz-mtu3-cnt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index 7bfb6979193ce..a8ba8ebed236d 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -504,9 +504,14 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		goto exit;
 
 	if (enable) {
-		pm_runtime_get_sync(counter->parent);
+		ret = pm_runtime_resume_and_get(counter->parent);
+		if (ret < 0)
+			goto exit;
+
 		ret = rz_mtu3_initialize_counter(counter, count->id);
-		if (ret == 0)
+		if (ret)
+			pm_runtime_put(counter->parent);
+		else
 			priv->count_is_enabled[count->id] = true;
 	} else {
 		rz_mtu3_terminate_counter(counter, count->id);
-- 
2.51.0

