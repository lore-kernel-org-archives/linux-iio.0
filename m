Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A12D5A19
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844447; cv=none; b=MF6QMoyzu0BOzbtgqhpeGZOilyJrOze49LOG5CT2ZB/8VAz904eMNYGMH3lkjhRDx1P7PbAhW273i4SJ/Yy1ZZtKMyAaDxQquPSuqHo1xwofvKcO4kbk9O7L+8gm26TyPctHYxpYhtdUNpotMHJUBfH8n34TaH0mUPK2/jsiayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844447; c=relaxed/simple;
	bh=5Zbne/+G0KBmiR+daPaqeqOLblOVArj1Xpwb+MVVcEs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RAHuB5IVZwXWsFMNYc5kJl/iyEGH5n36P2ZYhHkmph72UagRQdgweo8DoG5vUQefATbckcAo5By/l7hB9rUtfKmYPEOIkYORaBRyA8W+FsuELytTSrYLRQyStG8udtOsCeDWS43BqCkkhdQvWsMMZr2bAYr3tky0cJoHrqMJ8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwMbt/DO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwMbt/DO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso11550665e9.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784844444; x=1785449244; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yYsoy7OO6+5JnWWKHsx7BZhflh0jG1QCJ1+YvZp8QJA=;
        b=CwMbt/DOxgrW/AdQZkFIof89iqtJlENjns8sWR3UWfuMoW2NlP2eFh+tMs8W1Ob5i6
         /RoDkq7C/hydzKOH8KfbQvRjpZM8sBw3qrfhqDxJ8OZ9QQDqBwUO56K6FJJgmbB7Fy0X
         a3JbyufEPdRwUvdqamVgFFzy2H78Z94xbGuEuDLV2IZ0fz1Pv/53A+cydvhQ4UT9yQjo
         xzG7WnhY9EdsO2+k5qdn9uSSZBI6aLB32Rz+91qEJChnpiyja5COTsAm7CPzb9JupgSS
         YfLVLOV8mm7QC9r1mWL8SSkjKMeISeYrdlKzVx7ahHXbE+BlNTATC489+wdQiO03DSxX
         jjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784844444; x=1785449244;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yYsoy7OO6+5JnWWKHsx7BZhflh0jG1QCJ1+YvZp8QJA=;
        b=GSpGpc2FzVPNZd4sXzGNwUCuANYGOCHY595Kiu0w6p0jjt5AgBq+KlPuQ7taGhXB6v
         dDBiyOSNE+BcZ3nakeIlQtfy/KY/o84BxkgWcnPYdDi4qRtsQ+FdQTwNQILQf4io8AvO
         3xy+mJYjoeRs1ivaFSRKonLlK0fC4yqH2iOoBM25M1Xz1THvDjGOWYxh+o0HH/+dTlwp
         J7LWlLcpDjVRp6wr8Hnnokuf8jatn0tnV0V+q3hm+JjCOfqTlvXEP2O3fDpmEyJJmR37
         R8fN/+nU68EX76Iy9IzWw/jF+GJrv2R8OCHApS9xV++1ACvU1rVbDp2O5svBl8PdX7WM
         weIg==
X-Gm-Message-State: AOJu0YxwfrwYSNZJZR6bdnIZHITxPpMN3Onz8jbVAo/Ip5vEKoI1xrts
	Juy0PVvJaa4MfqqDUX9aXSwTPEZlBtrlfVcEsnbcWsz6Et7v/1SjgNfK
X-Gm-Gg: AR+sD10XuskWGlXlW16lBz/ZU/yPDOVB4woJNwfIDaGETFebRRdiTurZP4uAAddFKaU
	AWEnysKvMU4WxcBOeB9nFqKfuSjqoj1bfDnJzfX5wJn+e3SYi1R6OzxqOXLtDza4cS6dMxpvs9A
	Yh4nSG3IX98CkY4/DS+UUu8KVKvVFV8bYuXKAY7NnHQ9MSpCbOmXOz1QyFxCKHLdeodijPSTYeX
	80ZBXDX9y8tBi66jIrzUVNNJy0Zc1VrazYmmBgoBwSUOUU2o4UQwSaVQ2itvbXMqg7UuSCa5SFH
	zoqM8kkmDTS9bsdDV60OnKdwRBxNVK1Grkm3yEyla6mwy+t5zgiBjsVdclD5L82Pi8bqEjlAyJL
	WJVMADsOgyOhwuPdxfmEIlp4Cn9GU/+bK9D9oBXGcyFbEYHniTVagQEhZ2CVb/ttBRF65uPg5z8
	qynVTUtNblwTehoIPNQzbxKFY4aozt9sg0jWf43w/QiwWdeJ2Gr3Ld7UYXf4+c4cXLy98sJP0ZW
	TA5gtdMrnIbTE+Ye+7mz3XJzni3t9hjBDIwaWlBsQpVvwZUak1y4+HsYthFwyhlMKY0niz+FhQH
	leTlfJLVws7DUSjh1WrGGkOZMCvIBmepIlThpJvgQUMd8jw1nUjIB882PBUyV7aFLXZl7oEYABU
	g503VEqaoAQW2528=
X-Received: by 2002:a05:600c:4ed1:b0:493:f5bf:4da4 with SMTP id 5b1f17b1804b1-49573d11690mr54779775e9.28.1784844444170;
        Thu, 23 Jul 2026 15:07:24 -0700 (PDT)
Received: from [192.168.1.187] (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe3687sm6935985e9.3.2026.07.23.15.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 15:07:23 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/2] iio: light: veml3328: minor cleanup fixes
Date: Fri, 24 Jul 2026 00:07:07 +0200
Message-Id: <20260724-veml3328-cleanup-v1-0-240ecf3e5097@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBP8gcyuEi3MphowCyUJpLsnL
 b/FewUSRsIEQ1MgYqZEZ6gQbQNut2FDRks1SC47rqViGQ+vlOyZ82jDfbEFzcx1Jxw3Amp2RVz
 p+Zfj9L4fYA5SCWIAAAA=
X-Change-ID: 20260723-veml3328-cleanup-de9b0761c091
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784844443; l=632;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=5Zbne/+G0KBmiR+daPaqeqOLblOVArj1Xpwb+MVVcEs=;
 b=NNoivuBoyLF7ThJ3hM+PY8lvoLaCHWtWddicEosPhYcHA3z3AW7qf/oitOQ9c2m0B5v4a0I20
 mfa81WeVf1iCe6+igKg7FPoEAHSGGd659KlW+krda9SXJwe18VmtYai
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This is a very small set of cleanup fixes for the VEML3328 driver.

Changes include:
- removing an extra blank line
- removing an unneeded i2c_set_clientdata() call

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (2):
      iio: light: veml3328: remove unused i2c_set_clientdata()
      iio: light: veml3328: remove extra blank line

 drivers/iio/light/veml3328.c | 2 --
 1 file changed, 2 deletions(-)
---
base-commit: 036d96ceec6d966339aea34d034420991e24cfac
change-id: 20260723-veml3328-cleanup-de9b0761c091

Best regards,
-- 
Kind regards,
Joshua Crofts

