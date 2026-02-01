Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5463287268
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769970831; cv=none; b=nDgosb0KeAb0/QJYFjxs597I9HPQBe6+xW/kVGzZyiCaFM0qx4cJKKIfxOMJKk7yUbTFC4WRre9NSxFwL5ZHx2IwWHaLSmkkO7z/eNKLlP2gIPY+I+EbyRcHfTcDJ0IRBpdWy+NMJU1CYaQLZ9uY8uJrH4tmoVkgKe841TWhAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769970831; c=relaxed/simple;
	bh=8s71L5/222QicynAznln9mN/6daQ6Flg3Ya1cwHbxeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGBoVtrlpli6np3BCX0PVQL0or0MJlxBk0K+5aW/LgJxrEngZ2uUqWRCkj41E3WefYsOr8cFqZ3TnSuoBXD1On6v57xs8R0Ns9ivV9RYRtTVP+hoKpXSBe6sU6tP/DDnIAUEjzjAa8XVyby3focUT91IdXbINTK7H69u3LNmu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO0w8p2x; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO0w8p2x"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43601e96f72so445715f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 10:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769970828; x=1770575628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=309CH24IybzBmjrd1Z1MDsc4bcv4TEJ+M8kIPobk7aI=;
        b=aO0w8p2x6GjluCr6aSD40DL5zwcJDUrdkJdxw51wvhJTPHfanUShb0xY3ef8A88bHF
         9nwpZDGBqR7iFStPYKtA/0AqcyiliaZ15JonrA6ftdvTbcJZZlcQYkBQos0dfv4B3Bmx
         GAA++ptTLMsfQLG8aVRApZBrBN75Ldd8jQuc+T6gV73CbumCywjSregyHD4028dmsNvF
         A27io7PtX94npGkKZV8PPoxXdQuVHrj5JhdEn8S0wjxwq2/z9Q8vuQLnb9xu27C8FzD7
         uAkqK0oB6Ifh3yty2jbH+3E9JDZcoTkiBPMwdlbbzWgxp7PYbayBCs1s4l4iHgViotul
         /d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769970828; x=1770575628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=309CH24IybzBmjrd1Z1MDsc4bcv4TEJ+M8kIPobk7aI=;
        b=t6jU3J1F0qcJjDYKs6nYkmHmFKusmv5mweC7eoU5mBhkxeRt1rr198twDT5mBPl28C
         ih3nf58TdvRu8HON8nDvQZkJCxp6hXARbUfTHZTJIZ2+jCVTMyhYcUpc/FrlEBufEQUY
         U0LN/0HUP1jaVqg0d3oEHSbiumFMbEN7HBoAnaNYugocHHWaOkvEakGn56l2oxKR8/GK
         Y+nbWEFtL2WBxLMY0mLyF5NYuZ47uHeMA0FmoIQTJGzUxBffFVtvg3v6ZSmJIKHbP/Ex
         KM5N7Ql9Tw3ske4ENOYxpckR2svJz/PVw1AMkvAYGuZA4/GijspWjs6y70c8OtQL/ssH
         p9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcdEloytWVDckXsUv5IKMtdGeiUa4lHqlq7HVrr0Erg5zYPqAiVQTAoTaKTJ0qDBh/3Cuosgvfaeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziNkUsxOa9TTwg5Mx6k5sR1Vh3/B4nLdU01IShsliGRLg2srVx
	/hT+B9ivUe3Mc7xAL4hdSJrODFg3QOevW5sndo/A6PVWIrp/ZLMKBOF8
X-Gm-Gg: AZuq6aLZ+4Z6M/5nQ4+KDXrNp/6VFMOtscKnbmmHQfwxDO+Cgs5M1kPZGn0iwIwrUHu
	iN0XPc/c1Pccd39J7XhxZQtGEbxKZPnvU9Cr8zQIvp42WEY3vtxAqzhiPHTwgZ9WXNvVwRrNfuj
	7lVdDVRoVxy9oR/PWS7RPYs2e/UAcnpGXTW+AgODT5h85VK0eM8uyP5VajVBDs3p5RP8uNlQPyN
	ye1H2N4AhVhk7N0MPMMXrONhTVtk4LxShgf4+Lw43JySawpzq6em/EZMnFb5cE+FKSM3lgpRboK
	IACW0kMEOtos2ksq0AiM+djzrOVUUoMbA4e5FKx0I6r1XsOFAmm4q4CI1K+5d+aLO/f64qvzgh0
	jQvIXSCW7SLLPMBhK3pH7QvyQOuALAqSmv8o/wNiuNE8q0rPg6u8kEaMpdiN+C5seCP0Azo7XG8
	RgyUACgR3KUKUEP0vipcZ3LogCmib1Mqro5UnHJAzPdXPzWQ==
X-Received: by 2002:a05:6000:2088:b0:435:b7ca:7521 with SMTP id ffacd0b85a97d-435f3a763dbmr13149181f8f.15.1769970828099;
        Sun, 01 Feb 2026 10:33:48 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edf62sm41400084f8f.13.2026.02.01.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:33:47 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	rdunlap@infradead.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v2 2/4] iio: core: Add IIO_EV_INFO_SCALE to event info
Date: Sun,  1 Feb 2026 13:33:11 -0500
Message-ID: <20260201183320.27023-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201183320.27023-1-0rayn.dev@gmail.com>
References: <20260201183320.27023-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While implementing event scaling for the ADXL345 to match
the IIO ABI documentation, I noticed that IIO_EV_INFO_SCALE
was missing from the internal enum iio_event_info.

Add the constant and the "scale" sysfs string
to allow drivers to expose these attributes correctly.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/linux/iio/types.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 06295cfc2da8..5096baf233f0 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -256,6 +256,7 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_TAP2_MIN_DELAY] = "tap2_min_delay",
 	[IIO_EV_INFO_RUNNING_PERIOD] = "runningperiod",
 	[IIO_EV_INFO_RUNNING_COUNT] = "runningcount",
+	[IIO_EV_INFO_SCALE] = "scale",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 34eebad12d2c..4e3099defc1d 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -21,6 +21,7 @@ enum iio_event_info {
 	IIO_EV_INFO_TAP2_MIN_DELAY,
 	IIO_EV_INFO_RUNNING_PERIOD,
 	IIO_EV_INFO_RUNNING_COUNT,
+	IIO_EV_INFO_SCALE,
 };
 
 #define IIO_VAL_INT 1
-- 
2.47.3

