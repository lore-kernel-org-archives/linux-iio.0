Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA754415F2B
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020780; cv=none; b=WhunEe6Ug9XpkUamEX39ifXNIT894USXcSxHD3bVqg3i7ZtDFDAkxneWv1Jxn5o/Gf2s/qcYMfqeopLwkuDis25SPrqHqly3MQt07MJOeYuAthxtrfQ/Zz4hb4Pxyn4yBjxMTTqA3MviIxuVNDv2h3t2lYNdCbj9hG4IjUkWgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020780; c=relaxed/simple;
	bh=c1kpDXLLAzdZm5rs2ETbE/7TO3I2DSL19IHJCzFyRZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNNsYklXdQIp37kZEq+NrPeeiKKb52NQ84SkOFNWXY5adOqeFTXXbURvovnefMHL7BXhX0UF381jM98Hn/+fSv2NkukXfrnAXJ+6QrYl7vZ7kfkUEhsc8+1Nr/pOCHcd7rdVvPSmuGmr/+V31zI3PvZaaswh6kmrKdN3YWs6R18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0YC6sMp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0YC6sMp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso25761575e9.3
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020772; x=1788625572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKzkLe41uuu5Pw2n4p3dvsG3NzOD2toE69Y9PiVCR9A=;
        b=S0YC6sMpzBdU7UHM1by4zSSpewAj8A7Gr1P9qcHz9x8JKl7dmX8K2wQhDmRiP3TwF4
         /dmcCW8YKeT1e+iSMT7yWqqU7foERwjkSesOe07arMb0MBh6A32V2VAWKApNeI3pCJ3f
         6hsKfKNenoIWAnaTRaBrRw6nowFWhgto8Ryy5PS30D23OvlSVjWopyTnMKGXQ4rU3aeQ
         2JSgu6OCkdXHpLbeDubaxputpespsQlOFifLYC4mJFtVutLsUKF36DExwrXsLb/RakOI
         OBysi4c27dLCMrtiyLntTQuUSs3RhhqdqMMk9hmQGoKjhYW6vnIGNXzG3Difd6pE0q17
         6VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020772; x=1788625572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKzkLe41uuu5Pw2n4p3dvsG3NzOD2toE69Y9PiVCR9A=;
        b=ixebs2zTEg+dTPW7vbfNc6pQBwYet+XZagzTH3mgfGlsuJvy1iTjJ2OMsGfdlB/Og7
         SijcPolyBbIHFdjk+OHyd1uT5WHnPw7Haz7UzVn7QBM84B0yZcsp0udZBC3R5STO1mM9
         bch2+L1hLJjtP0FkvIUdRgRcIOL9uiJouPChztIxtUFbZg/oi85PJNDr6YRE+Yp2yepD
         98Zt6A/3NqzQrUKMbMEEJgsqwlDwznPO+alwDKc8IzyfeeQAiuwjf0G76y+eXjgdFRaj
         E2yYstNBoWyaWvPvSB0NUAFX2I3bfAuTGA9p/BIRKYy2jgzeDhQ7TY04mXjM2wjFSK/q
         crpg==
X-Gm-Message-State: AFuF++n3ovt8S8g+TFjtoRKQEKgxXVg2U7ObJoZHrD9IFeli2wNKRUsJ
	/Ohs6N7rHtoeKr6y1HMXMDks9W2yMNkPpdyJUP6RbzHYMV0J88nhOMSL
X-Gm-Gg: AR+sD13mLRha5ennHJ162Z6PIVZ21Zqqu+yuwYs0EIa/+aUb4XzETK+6xPzhWoPQH8u
	NZGeZRI83FsugYi3xn6csWgEFHaAymfZ43y4bGmJpacWG4FK4gjCobz94p8ZprcocsmZrFGQNQd
	3YdA3QFZlFBaaNm7AbEup8CWJT2xB73JHFv/653IYRefnD7fcWdc0vLk7a3HNGA4Kb9nZN6h9EF
	nwwY84KQmSQ1/NZwUqvQVzRGVcNlqbnPQrQ6Sh/nS5uhqPD0bPtRb6CAGeQ46q2kZLO4BL7d7RZ
	4/wdRlg42qMZOzo8x8o8OPARMiPuSYeyKWnKDbgBZUqrwktG6s5NfCBqnC+BDmL08FUUy+1z5bG
	cqmiZB4NMfBxsH6FsJgtkRzSPVUlp8mbk6K0ZwiVoAsXEOw+760kW2Q46KhRr3/8iLZy6DXgadK
	+Pre6aBsBIRmUm/ltepxEWU86+eEppRCccRWPrS94G316EM5V8H6b+L/WzQ0lQ4+b0Hz4GUFp8E
	7rqnoPAct76cRWMrF9gp9jtU0bvS/KR9sxwzzM6z3PmzoxLQgdQTwXFpYuyPLDqvH1hlSS9LRnO
	bD2HqHZhuElcPcRSbQjuezoWfCLltZFjv0bHQsk+xoHMkWYCRc1Ahdy85zvUFHgexNleJ6zsW1r
	LODWvnvRI2B6Qv0ahxiiJLipR
X-Received: by 2002:a05:600c:c08b:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49b92027118mr191307805e9.6.1788020772133;
        Sat, 29 Aug 2026 09:26:12 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:11 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:26:07 +0200
Subject: [PATCH v2 10/11] iio: temperature: tsys02d: reorder headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-kernel-header-removal-v2-10-c67739d5dedf@gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
In-Reply-To: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=842;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=c1kpDXLLAzdZm5rs2ETbE/7TO3I2DSL19IHJCzFyRZI=;
 b=Qbo2EHJhgVjsqlTOD0GebUJhrQ2Z/B+kP8zaH/E8LxPElE3Keuts078okjbj5a2ottrf1gd0H
 jAtKiZ+f5F7DJvZmRYsYbR1WwiIZ3oAoXTI9jEHuLYZONxiBntoX0ES
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically and group the IIO specific headers
separately.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/tsys02d.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 3ef72347456e..377e27b45fdd 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -10,11 +10,12 @@
  *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
  */
 
-#include <linux/init.h>
 #include <linux/device.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/stat.h>
 #include <linux/module.h>
+#include <linux/stat.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 

-- 
2.55.0

