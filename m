Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1BD3AAF5D
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 04:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787890741; cv=none; b=e+H5HhMYmVOAFJ3DDcLGLLLsDeSEYoJvJsHoPJpjvOhQMlBjQfDPyvFnw3kjmlzcRS3xn5Gjn91Z205jyL/V7WxwJ2XXi+q2mMUddtPyEf8FtI/pGwD45R8sf/WhagB4uEdRbf9IXucqnglE3BaC40bnaT4bq6R18wxzR/dBrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787890741; c=relaxed/simple;
	bh=j86OQDFxzsnUmkLPHGpPchrsoAKvG3d9PSwJppDgo3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QZhHG439F63V4AWVeRRbhegMvwA26XWwydX7z5PYO7r7HcX2OQKLz2lu0/1FocOL0BB/vCVQbUv2aqkz1vuEUpwjNYvpmFqZr/d9pfuVX6KuvsBZtM7Y3iGdmV5Wv3FGkepXuW3/1mMMpOiXLaND2+xMzI67P5NK2wc3bU2zytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL23KvXr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL23KvXr"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8588583a7c3so7523237b3.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 21:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787890737; x=1788495537; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ERMTQqT5F5rXKk3SlayPMFRLzf69YOJVKWPJxXCY8k=;
        b=NL23KvXreSFFnyiilKeoFrhP9ffzu6URKEXtJG4a9gaaOyJ1Y8deIu1V1/kjZTYOgU
         bQcP0pJCjiHlWTdrWoOMIiAmKgGslTykoB4AmO+CvL4EG7UFKixQuuMwmZABRLg452Qn
         3AZx1HgudAsl11+QrgvW7QtlZlwZFxIQ/DHymP3ckWaBBmmrcUf2xCqxOeb13QMU9ci1
         LLCU6MkZQGOgU2u49Geo5hCnAQn7lx5DgR7BeN/Yq9wQzElNCJ+dX6Oil5m/jKBM0DkF
         7jW3fYDHL5R+HoYcfOS9df4+4gW1vJKefUttiZ8c6KwC2BXabHb2D74XOGl+Ij5xKMFg
         ifBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787890737; x=1788495537;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ERMTQqT5F5rXKk3SlayPMFRLzf69YOJVKWPJxXCY8k=;
        b=kpT+I4Ht0fDs/flq/VEJ9NokYMDA7CoVYh8vv/BwXe2mXaqB6q3jaeg8c4FDnkDlnN
         lWhpIHvBA9Wb3b7FZeLJ0o7fQB68qFQ3FO7yQlJQAAahQ6XLJJapxyIBx/8C2R4zioq9
         te6/h2dihtNeP3dp2Gje+0IU+yZ5rfjCG+6Vf2PpxHKpYPcmwC9b9/CceCaQWFhvQ2k5
         zNAMQQX+PcdcQ/zgvJi53A6AxhXWxj5uVOGy89ktPizF9LuQ50rareQV/Tv2r8CH6BTN
         047/EvyDkI/uAA/XHOERNeXrYdOPUSnvkzDUWHyIg4la1Ra6OfCx3o/HxPG+rKL1ADoS
         O/DA==
X-Forwarded-Encrypted: i=1; AHgh+Rraj3hx9++l4QtO674nV41c/tSRg6NjAeUx2Q8XRAlLV4ezartX7adrDn76QGTG1DvfCgzdRAdJetU=@vger.kernel.org
X-Gm-Message-State: AFuF++nbvJktJlYHiqSZyaBnu5PYdBFOa1MQP89+Xfs6yEJsMX8uiDZm
	8NwG74z09yYAbEyaXGx3QVxrTleM/qetSGkqgycVw3AQgkq1EdC042+W
X-Gm-Gg: AR+sD10vxGgcLgZ+6gxOE04kKRDi8oS/1hUqBwujnX4T1UvNErQfUuT6x2JRYWhWPAa
	FsDJ7MpvQpqdVDVzPqJ6tjTCyzQOrpVXFkB5NyzML3+at/Ti2Nf9Duzzl778NL9WBXcPMx9a9w0
	4s9QDTYJzo8IA4bDBhQ6Yi0Yv+3D0zRGQuLWpG1g0vA5xn7sPRTjpndu+R5NWxdKQdkPjQYorgf
	je/z7QwH3QIFIEWXrImyUKN4snNWDH8eL4V6lXaB3li32ZVv7I2zdXejOhVrI/qO9YqJQ9/J4UW
	yBeWnKkzsuJwTaNfc2lBfgK5IUYUTf94JJnR0257v+Ml5Kgc02XY3S44t6Ei8ZaZmZP/ly+xZuG
	jW9d+RartvDjOArVjj1la39ulQNe/+LoxuFOOpxzXwr3LYKE1lb5WPEpfAiXutItLWEFG67Nhr7
	W9BZnwd2eRfKDjYr2AbdEZ3Ea6RnJhNvz4GMztgthpA9g=
X-Received: by 2002:a05:690e:262c:b0:66d:1210:422a with SMTP id 956f58d0204a3-66e4c6d46b4mr786092d50.26.1787890737488;
        Thu, 27 Aug 2026 21:18:57 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed163bcsm285033d50.16.2026.08.27.21.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 21:18:56 -0700 (PDT)
Date: Thu, 27 Aug 2026 21:18:54 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Chang Yu <marcus.yu.56@gmail.com>
Cc: Anshul Dalal <anshulusr@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: ltr390: Remove stale TODOs
Message-ID: <apEMLlURRBCmtBsZ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove stale TODOs from ltr390.c. All features have already been implemented by
Abhash Jha<abhashkumarjha123@gmail.com>'s patches.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
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

