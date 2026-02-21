Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F80F299927
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694778; cv=none; b=B56GCeBMQhutbKHFscB8kvoxz8vTTrDN1ddZzDFD7NxYyEPsMV0jyelT23xG8P4cK08+5P5AZ2pUJoiYH99tUz8redDJw/9bIxcMZCEBi59oIWR7nsPxN7oFlWPhTAP75lEDHEHxwoiaJ2HKcJOrUiYdya/ABjYEaqk5w+zSDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694778; c=relaxed/simple;
	bh=QtABQPMbV2k4DE51AkNC3ye41WCiMyUx1sRZn8Ga1Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEx8SoPQYc1XhQqcRNRJitVQFzkgfZFc8AYMeztc932q2AnywPFzDQx7VqnhaLF6/QypwxpCbpiArCchtU70LQmDIVHWS2PvUvUsuZXy786/R3ZrAGn3Jo2ViAoUkdJjwtoClSNkTFRKr/1eerjC6dKDLhWsTgN9PBHPNEpPJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRUEeiuY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRUEeiuY"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-896f9397ecdso33142176d6.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 09:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771694776; x=1772299576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9d8b+aW4k2VuxEEODPevuo3bXlPSxOhiTnMsGfL8Z8=;
        b=PRUEeiuYuNcyaSEU7S7rDjudup1P76TsNXUXXeA3hU4QFd26JXvBcM/9h8ZCEpWowI
         oZgzb9iQQn5Jj7OJw4jdmQ82h0FGEFMr7/NXAugFHD20jtRTLaheKaJvyJeoXZc8lZHF
         LR9I7n1MQBBgMaGaseneBVZw6JTVQyk0ORKKbOy4lWBk59dShh8dlEucXNppJoe+nACp
         iYkMvixiPaPhYoQ0DQlXqo2+FeXvjMOy4zdAqnFnDUur4U0prxCsu3t+oDJFYL1aVKrq
         WqrmdB6oIUYCVVyCf2LlWKTQQToXChxedZHqb8F5tnV5sxEEuhDwfGzYPqd/VsQj5NP6
         eAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771694776; x=1772299576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J9d8b+aW4k2VuxEEODPevuo3bXlPSxOhiTnMsGfL8Z8=;
        b=Tn2kuINzzfux8oRTKjjEssGCN4oOnRbQalS0FFgUHIvZMfDcVJdFNmGhbwYgP7Vtei
         0/vErAD7Dd3dvQrc4kRuuUhL0WS4R7YwozQB0z9jqgfMeHEHNs1i+a0o/xohr8dJtlDp
         44GYwAv/2PdouD9YOJ1p2lj3o7699TOSpYf7Kn5OOowO1KAy2zAqkM3pvetG5QI49ndD
         n1o1lQExgVi4392JFpfijyItwOI1t8zwwxpDCH90ZE+KSd38tqGC8t5KRJFW2FWiJw03
         5BbdAOr4LtovFfUMZ4MvI63+FhlN9vjj/ZqGojXoK+e4FBgnYvx69NR2JPiWxrc36fYX
         CTfg==
X-Gm-Message-State: AOJu0YxDsIosxaszbyujmJbSqOinqBinEimGmjO5gbLoPRbCGKdLhqji
	XYeOyxJC0qwLS5rekctQDZqGzivL+i4kRMdx9vuxgr8+Y9qzbrNXroTT
X-Gm-Gg: AZuq6aL0AVuFvNpfjiTeyri6pAfhE8joWtbIfLxrrTXEqlNPIz84t27nSd9uYjs5UEm
	lIq7nttua8upVxY4Gl1rResRxir53Mrl9uCH6JlQAgAnboWy1g7Zg6t2KQCFTkk369VCEqaIvvh
	vs2oObLJ670C/8bVUXv5+8a9D1Z3GamBLCk+zHGjNUExugZbEBUEAxZHm3GaFwMPRXqM2clBaBe
	eaPgG9PQ0Mb/DmA/KeEuPBs4WIGus92LbIwWtRiKmrHdh7qKmPnJaC7PmpiPRNdy9eJaLqJMcv4
	RQmmt/16pJ5DB3xtkhsGAQYbxROoUqyMjexriyfwJwKwXLyd+0Ar/p2oAg9tQfU+W1sy9E6tuic
	fr71DOGwrXEN3SQnFdqUZtAYmu5s0yW2pck0A0n1hLr5dU7HipMar8s4Gn7TAjaK20NJdDvKQfc
	W8sG/l3rvq8UBVdUy0Zp+rm86wHMeUGpjBP25YqOdqewbSYWzfS+4cb9WaZzsh5bKGXotmCuIN0
	ALeeqyY6TzGmqd3+F9X8uajtU/RTMDD
X-Received: by 2002:ad4:5d6e:0:b0:896:fdcf:731e with SMTP id 6a1803df08f44-89979c39a4fmr54206236d6.9.1771694775940;
        Sat, 21 Feb 2026 09:26:15 -0800 (PST)
Received: from Mac.home (bras-base-ktnron0818w-grc-05-142-198-109-43.dsl.bell.ca. [142.198.109.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d108c41sm231416885a.42.2026.02.21.09.26.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Feb 2026 09:26:14 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH 2/2] iio: pressure: mpl115: remove stale TODO comment
Date: Sat, 21 Feb 2026 12:26:01 -0500
Message-ID: <20260221172601.77818-2-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260221172601.77818-1-neelb2403@gmail.com>
References: <20260221172601.77818-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

System suspend/resume support has been added in the previous commit,
so remove the TODO comment that was requesting it.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/pressure/mpl115.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 29794ce53bc6..93f1388cbe27 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -3,8 +3,6 @@
  * mpl115.c - Support for Freescale MPL115A pressure/temperature sensor
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
- *
- * TODO: synchronization with system suspend
  */
 
 #include <linux/module.h>
-- 
2.44.0

