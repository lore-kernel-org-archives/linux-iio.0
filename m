Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB993DC4D3
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901054; cv=none; b=Gaq5ErDtAKt23SS2NurtzSa8/iKa37TpxzYo5x4SUNY4zo5GeCQ0NXKlAciCBYfATAJTexEqhW4i9wv/BM1KvvyQ2zdNkw7icd62THPDGUiPpRSCuPyU18EpCTP0dpAomBKmufw0sJoMvB/vtlVuDkteJIFNJbCjgf2XTGF9Pbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901054; c=relaxed/simple;
	bh=hYDzKjnNqxYmY1OnMOzHzkHQhcAoDevwky7lPWZ82tM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bnxm1JHQon5T6uWjibSJrhCfHVern+pSlm+H4hXYvtXsDIKzLhhsWP2DBuMZ87+rS7HW6hKsPm5xiywXYIKOMaHTbRIHIBmMgp8oS7c4W8z1sp3/TbmAoMTho2zt58E/mTnqReEoYKpJYsJnqyoQLZ+BEAwVO3OjDkKyC1e0+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMsrKb0d; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMsrKb0d"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ecf499af9so6764797b3.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 00:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787901050; x=1788505850; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mfhcIqIfHWd8sNFxoHf1vs2muwYwCiSdxw0D5clLVA=;
        b=jMsrKb0d6hPuD2NtTKmwZIGLGWM+A2GPNM8bwtlNRRsq+P2j9EeTHePMla7SiM8nrn
         KCc7+/ZSk72RzNe/8xkqMLkp0M12MuunGMgenKWDC3hiMIh8cDX89+Ilqf+680um/0yl
         p+NnKNOVFUn/c4jKNJzL/Ct/AJsodN9HkeC69HA3uS4f24JGmQ47A+h6+Run2DWIfd6m
         CwBVHd0G70Bj1+63YblW+7w3xjHKOgI+ZZO02DxVVyzb2KD+qLbqicZMoqY1Hg5qJozt
         BbVqPEph8FBwKL3V5zRKtUKfp48wPI0k1JlWVasWRet7UzAQa9dNFMzpSxBqJOVmYIX6
         YDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787901050; x=1788505850;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8mfhcIqIfHWd8sNFxoHf1vs2muwYwCiSdxw0D5clLVA=;
        b=A44dMPpPPgkwFZwe73vNnMgESk5G7yOvDKr1avq/Vd3pvM2JJzirNfVPWaxbTKr2fn
         UAGWJHPhzciNZT0xD4ZcUfyaJhjNyyX7ia2Z9UxYaIxllQqjf2k7nkyb7pGOYOBgI8qs
         8HxRY99Yf622LIop84n0+2cR7A8QTeL5ZlZiv06ptqz0ZguZKIH2YHUImBAkuq4A/5mL
         NEJR2PpJxwu+pJt2ImM72XzRfac06lOYFiGmlt4RfUZ0z2b9mPrViNMXzDW57q4siIaC
         5aBKgC8fl7e1tANCr6vDmmleq/e1+Nenc3Q7VppOzVpNdXb5FelFsdU191gWSeJ2H9ER
         R9gw==
X-Forwarded-Encrypted: i=1; AHgh+RqfwOqNGk/ymwoIRkeVE/kixBDpqDPO2UqLts/ngRX+Z2XRJOR0e4qXQLc/f6f5ONPxJ7r+lqv6pY0=@vger.kernel.org
X-Gm-Message-State: AFuF++kBmlfwObL31YpnZudBAwF8oSjpfCq7unxkmNdIaSxIpU1UEe1u
	r6tQmV2804RRzYDKWWVVikPNxEjQd2MfkQhnKNWC1IEw+ev3JeJMYgQfjoDwYZT0Dx4=
X-Gm-Gg: AR+sD10ORUGoO4xEa4MJ38l7RCDISXbFxq9VFx2n2U5ZFMNK0M5wPgWMB3U9cMSncDb
	kXHD1vXbJrJB+3XeXakOlrpiVGZBzMTaJitXJYBIh+QjcJgKgQhubA748yyuKmXcQ47e+SqPsCl
	g6f13eEX3C+D+VqSfWo7SYsU25OPYkeq3+6NcMuwBNXVE3i1JZZ29QoYidUibN5+zosy4gKZ7Ai
	osQWKOKF/k5hL6KCXOH/0pLGQrY/cjSZM0LcmBjXMOOfgj2tB2J3Qw4hAp7pxRUjPjGaVfw9d40
	Oi8KSg/JKxOsCi5guJ3giTTALNj3SyMcHXFvdVooj7X5rW07hzLOG87Cfy/eFVOJ50XZTugKk+u
	eUTr4x4F92OlF+SExa8cvTLquzhtWQkLhpNRAbMt/bs9ZtiUMHAXyhdQu4oVcen9rHY1F+lhc1C
	WfZgdhIajHI9LxKmoO6pt9mMowk7i4aQ95zfesSRKwBGPg
X-Received: by 2002:a05:690c:e3c2:b0:816:b469:cd12 with SMTP id 00721157ae682-85d6743f652mr23133277b3.8.1787901050397;
        Fri, 28 Aug 2026 00:10:50 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e677606aesm2859147b3.45.2026.08.28.00.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:10:49 -0700 (PDT)
Date: Fri, 28 Aug 2026 00:10:47 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>, Andy Shevchenko <andy@kernel.org>
Cc: Anshul Dalal <anshulusr@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: light: ltr390: Remove stale TODOs
Message-ID: <apE0dwvpW6Yl8yzz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove stale TODOs from ltr390.c. All features have already been
implemented by Abhash Jha<abhashkumarjha123@gmail.com>'s patches:

Configurable gain and resoluion: commit 13fad2607dad ("iio: light:
ltr390: Add configurable gain and resolution") 

Suspend/resume support: commit 288ce72fb5fc ("iio: light: ltr390:
Suspend and Resume support")

Support for reading the ALS: commit 14e0d914a855 ("iio: light: ltr390:
Add ALS channel and support for gain and resolution")

Interrupt support: commit 7ca4b8957066 ("iio: light: ltr390: Interrupts
and threshold event support")

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---

Changes since v2:
  * Added commit hashes for each implemented feature.

 drivers/iio/light/ltr390.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index bc031f2c3141..f1bb066248e6 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -10,12 +10,6 @@
  *
  * Datasheet:
  *   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
- *
- * TODO:
- *   - Support for configurable gain and resolution
- *   - Sensor suspend/resume support
- *   - Add support for reading the ALS
- *   - Interrupt support
  */
 
 #include <linux/bitfield.h>
-- 
2.55.0

