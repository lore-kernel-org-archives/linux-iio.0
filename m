Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FB3AE6E4
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904841; cv=none; b=V58IdGyig7T0vbagtqa0iayFxbrlCwyU8ANJzCHKhVeHNuIJx1xqj5HmazO9l2AayvCGIe6EXS3ybSSZJ4ZwP2NPeB8crIhC0pSfxPKb65mFW3L6EzrOd1fqYFCyV8LBJnfEP6NsBuP85Rt83NO5dogX7zE0a84DuIg8d/shvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904841; c=relaxed/simple;
	bh=d6l+02HOG6dBou7Igto/xXG7YXvFDdwm/IWzpa4cwM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nVlQXLj94NUp9HUDGUSW1ZBf4AdXIbL4pcMqaJZklFFBQtDFEohy73h1jD816HBUhMV/SIDXwYKfbpWEhGcotn8ZTtWdEFubmTqtq2XaoagwTkZVpjuTEDomtBDWool09fzv/EAJpnW8Gjoqb8d1d2BOS3D2+jgAz0VDqZfP93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGhdJiun; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGhdJiun"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ecf499af9so7239917b3.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787904839; x=1788509639; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRjn9sqCurrAA+15m/FlRgC4mPrIiDCg2DZ2ej6eFxk=;
        b=dGhdJiundlN4ym6FA5W5tjAySdwoAdFZKNVyxXGEu4tB2a1GYyjXV+8TY/VI+BPyED
         cqLJWsXJABWso8mK+W5edqmiJnFN8reXHnwpOQGYjUIFlA18Y09aMvTKTNYfXw33QjlY
         yEGVUIzFRedAopWrSehjd94O72mjdrnZKKSTULOrxM36BEWqNewYVCMMeSyJ9mK4bu8N
         fLOnkWC2IH4TncwPgcJPWDo6opl/PnRmziYMbhomSVUcbn6gp8D4AZDvsZchTcUxGd0z
         7hxuB3PPU/BR9j72VxbNsXjv7vm2xzrHRSL3+wXJcTX/YUVjAqN1ojwkvABWgUQibLUm
         Mx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787904839; x=1788509639;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRjn9sqCurrAA+15m/FlRgC4mPrIiDCg2DZ2ej6eFxk=;
        b=ea01bn71CRsrNqMjZ50AswU8tVIP2g68OUI4EAy51GqW/M7SeMcO9xxpNxkMJz9i12
         xQ0j/McpPo4e05z3htKvURFFY2miptCAJLZapeXvPKHhq09992hVd/JHV6FuRNG2n8HM
         xyuJle5WQROE8+ippPCLeqoV829PZgC/+fEGj2T3xPicBNOU8ZMXqFNTwi5nvNwk7vFJ
         GjoIAQQLh5AwhZP7N8AQFR8cgEbNUOhLIqFzM02eZcFecycYke0BfQ2KAtjXISDFP3rP
         dQY9L1CiC+Q79Gd+uRyYYST2qJYKf+cobUdoofc1jjO32FC+OsfjWAAxiHA6lfKUfP/1
         ymCA==
X-Forwarded-Encrypted: i=1; AHgh+RqwLcGVKq+3DQNWi4EQqDHG2uOyKSaT7T4+4I2FGUu+v3PV0LQj5PRclDQwn6wxXhIGn9NRedED0lw=@vger.kernel.org
X-Gm-Message-State: AFuF++myWPQSZPFKmd74dcEv5WZGG4xOE80MTfvgRIk8fsBbWcsTuYEK
	xITgjoOr8LcrNcxV4f4IGTiTZhCngfShWMi3m9vME0Bu39rhun6a/Eps
X-Gm-Gg: AR+sD10oTQQjWQwpLEVjVkFiCGni1fhP0onaWutpirRUV782a1ZciRDfQ2iHMcph9TW
	u+3IWRq10eqPLqmSv075uCAijLk1ikrljeBesEv4SJNzoeo48nLlMofgVwYduSV/8mAso/1ZuK9
	KZizW1Xh3AELyXPLANNodB8OfVuCD2p0+vxWtMAh3gMaL23dOdMr+LbXBpv5w6nJMClyyCPVpvz
	JjVYOW7FO9cVdGb+qxu3djgVy87ydA2Y5GZQg/JfmIlJTILodPqV0WHEf4hqfvUy+atG5v3vDrF
	8xyKf7gUJzitPIRI97OnVuelmqIgm3E7lOGDdPP7ZOfivzfVKw2vX0VCOb6AcnHAiILxPo//96D
	A3dzsVDz4h/eWjGJKI2m+4st8S3qyCaZb+JGrQvfcg0ylRR8u4cNMgY0la5IFnH3d8iJRB+eAwK
	YGJ3TFVHE9m20U+1giJJXGLMV5sxfI2etp523WDBROVnoOWwPwQgEjQg==
X-Received: by 2002:a05:690c:6a0a:b0:809:ae5:1d2f with SMTP id 00721157ae682-85d6743fc80mr22309757b3.9.1787904838711;
        Fri, 28 Aug 2026 01:13:58 -0700 (PDT)
Received: from gmail.com ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5f7dfaf3sm3374987b3.22.2026.08.28.01.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:13:57 -0700 (PDT)
Date: Fri, 28 Aug 2026 01:13:54 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andy Shevchenko <andy@kernel.org>, Chang Yu <marcus.yu.56@gmail.com>
Cc: Anshul Dalal <anshulusr@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: light: ltr390: Remove stale TODOs
Message-ID: <apFDQhk9TUoLnEZt@gmail.com>
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

[1] Configurable gain and resolution
[2] Suspend/resume support
[3] Support for reading the ALS
[4] Interrupt support

Link: https://git.kernel.org/torvalds/c/13fad2607dad [1]
Link: https://git.kernel.org/torvalds/c/288ce72fb5fc [2]
Link: https://git.kernel.org/torvalds/c/14e0d914a855 [3]
Link: https://git.kernel.org/torvalds/c/7ca4b8957066 [4]

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---

Changes since v3:
  * Reformatted commit links.

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

