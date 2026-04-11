Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486F1A5B9E
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910953; cv=none; b=J021Qj5Mj7eUiS+1R4RkcpU6FLT9G2PHwiNv+pku5+5pAcCs27h1e+ba5FZuoTNsTM6Vufggq1iUoPXYACTIIvCdVHaVUnj/OGuWXomYPua7MHzEFnF/YHsEuWPpkpPZ8gNuuBqCeqT8rOqUUcgk1sUVyCuIEZRWPZXdbhUI+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910953; c=relaxed/simple;
	bh=jglBWZpM6gb6r4jnk+50+pDuOMLGeUPfxSTArYCfDN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhXAGVQuJC7XTQQoHGrzZoSScV/NYu9/H6taSt2lH3kZpXRd7+V1ALmZ6OsFORAc1P9HN+e2TP9rTlhLt33KzqqfSi6jJt874wResp99jkbEVx/pzyjYBw4M4/viGhg1Rnyrg9nvSDweNTSwyHLOIlm3lE51acyQ9lLe3UIyEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=achp2KZJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="achp2KZJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso47639305e9.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775910950; x=1776515750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqmzVUPIgrnm/cJHXSiJKFWklEbsgCfd4TNnk6J9pOM=;
        b=achp2KZJyijBKbiuutZgo/lkSTOvJm/lufszociu6uZRUOEGQFH1w3gtU8RFJG7Ihu
         +PdoDSwJqJt77h2YhNr4vvaIB/MZgW1o2oZfIzEKJ1FXSA3u2Z4e9G0nwa47CgvfJIJ1
         EQTmkLbGWjNB9mHD6/wRTOrxiXc/Hj6Ej3nFyw1vP5GFTydTLI9hEM/D8AL9J+6MLg5o
         KpEiVAIuUzeIQrxDln27HwMlbEIFedE+E9v3Xv6r5vjEd0g7XpcOC5t3F2QKfWd3u+5w
         ehwZyVoxZd1B+v+CfxlXiT/Fypzu/GRt2N8rb2kTbOaeX0gWg0BCWBKTh0mtRU5I3Itg
         g1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775910950; x=1776515750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqmzVUPIgrnm/cJHXSiJKFWklEbsgCfd4TNnk6J9pOM=;
        b=ZxXckX+XlgptVroFCUwNOjGGaN+ek6NjjKwruob3ULJXz9vBTJcDwpIgLTOryiXTYW
         Qs6EQNooYFCxr8Jx1MJjNRFgaJ92A8lu9fWWb7BxLoZIVX8vJMSer53PZgtdQY0t1WPG
         Fxjb5T7sYWxB4UkVIWthVMyDLVnzxjGHgAHm3vuQ/iQudRZ+UFiMTuoKHjyZ+tIaL+Cm
         fS3enBbsujTm2ZfvDpVvPmrjYecv7++wgcJPbwwgZ13n2hlAL4cye5cm2AXb70C2kdqB
         9YdRMQQvvlIwogGHnCE6lhIVYZoD1KoCO15CRiiTSEGitQxjorcPpuB8oeBTu0AMcoDA
         FLGg==
X-Forwarded-Encrypted: i=1; AJvYcCWnFKyewhTKSl4/p5ecJIuZ+mpgRza+bCHwowwZjFuup4fMceHdY6ig6G64pTLDmBdZck2I71NzPDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSPbLNRNXk2vHBz9qfzNmSGDAj6FL9jmdrdvZUHhdKgTTUrf0
	G3surB7SfldCt00ZKa10QRWIm0fqAl4Zm0LNLw2lFb15CifCX5lct2r0
X-Gm-Gg: AeBDieuarszN+plUqR0eaZYE/5l/W2D4P18Wn6puWofXGstl69Rid47g0ieP25Xg4mJ
	BCFHpf3IBZhWbecGl+yHQLQM+2AZ8FIEM50xmj5K6hP2nVFl6Uww8xhhwHlNcOFPhswXC6EDwXD
	1sws8l8ASvMpJYXWSZwdr1wJTRyf5rY5oA1GC1OW7dsRwn2lsDCfiS3+0O7wQtusArrT3UdqDun
	cFJZlFux77AWD1MBuLuvwfBrgg84KncZVhc6egx94Fn9BGnOP6XF1E6lnoD0CFiANhsUKN1Xbah
	edra6YmX/myF+pS/CHlZu7G3NMPs5OuaOck57i972zHMZj09mK/t9h6vSBIfa2ctcAfUFYaDAWJ
	vnY31AKqq5lyV+cQHNkM01Jd+CKD9Bmkw4QEHa5KOV7KjYmfyDFRvmP7Y+34yLTsh1DZ5X0VxX8
	fEvFqAuYZSonD1ji7V8+ylQ4ZsoD1pav9d7P5SXOrHyWVY9uoy+wH+a/LouOzmZQTDGj3Lz4oD/
	clY9Cp+6LSF0AcNjJwlO02Br7DY4vdMI1nAYXGefnpL6Oo5dvOtWpogLs9MVs+3U/7hgXIvUVZF
	lPe2RTKmOm7h1f3RWP5TY6jmnOSUTDkIU5Vo9G1W3xj7jkoTucUnB0B3++Mz5fuvjlB8krzLS8T
	G7uhJNWPKvA==
X-Received: by 2002:a05:600c:5298:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488d68820abmr97898505e9.27.1775910950228;
        Sat, 11 Apr 2026 05:35:50 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-246-182.bb.vodafone.cz. [86.49.246.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm103104385e9.5.2026.04.11.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:35:50 -0700 (PDT)
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
Subject: [PATCH v3 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
Date: Sat, 11 Apr 2026 14:35:11 +0200
Message-Id: <20260411123512.84739-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411123512.84739-1-joshua.crofts1@gmail.com>
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove kernel.h proxy header and add bitops.h for
better dependency control and code clarity.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - removed redundant bits.h header

 drivers/staging/iio/frequency/ad9832.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b..8873a6d11e 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -8,11 +8,10 @@
 #include <asm/div64.h>
 
 #include <linux/bitfield.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-- 
2.34.1

