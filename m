Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165686331
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771206905; cv=none; b=AK0Elj2M0w4e60AbjWgBgLRqx0CFhUZvAYTbWOwe9KkejqRTWHz68may+3i74Vk7BOQ+vdu6FT5TDsYRHzyZDibawn01dIDT65QzWinOr1smu4JsuFedfyoqEmT3Q48T4qbkAuUEzqv/b2M9XPC9r8hX2TqqSXyQpY8BLZ3/ASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771206905; c=relaxed/simple;
	bh=MIUGqPePZ9ghwnLiULfydxARprAgEyhyDBwQ1JHTanE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZsdsI7ujUvBCCvhQPEaYQtJ8H9Gv9+GFARTT3vNJADiAAeyWavzV+aFoZbibqHCdpFp/FoBGc5ynia32F+5FIL8bhhL38tJ2ZpnlrUYShgriHjc2F1SHIKWJ/kaQkYqlDaApjgqJXTuirPRR1zaLQ4QffecrWqQqgJxQRwtjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMekQwdo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMekQwdo"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8954ae375efso49137756d6.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 17:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771206903; x=1771811703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRL+Jp0MwxQkAw7dlGSVMZYDv/CZQfbOrbRj11Z8Oig=;
        b=KMekQwdoTruoDGQ+n4AJ0nwj5Cikq3o9I5s2q9arcIvxRH3x5cNWiXqysFgavAWpID
         AztoIW7OfbUhsNM2SPO/bfEcb3E9q5uKnfWuhdCMWbImsWfODiPlh1epv1fI7+nDhVWK
         miMhb5Sal9oKa43RtSpTe+GSJHTohCKI6nt62QZ8n61UFOfwyCGjAJuVmuINVgr5nGW6
         l47x02UkUNzFoSBjug1VCiiOYRwD0dsqIxfSA9TmycrTe7ENil6ZfNlOPIIU42CcT+n/
         Y5xsOvXnAnhT/X07T7361RyEni3E+nE2COhk0d9RmVLcb9+OOIEZ93t0+i6BBlH4drPo
         O4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771206903; x=1771811703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WRL+Jp0MwxQkAw7dlGSVMZYDv/CZQfbOrbRj11Z8Oig=;
        b=fQf5vYj+vp8P6wWY4LDFfvO/DQM+BRjMDHYKxs1IgOmsmvt9Ptye1eBAZhdjYsNeNb
         TKslZLflpUjvOmZfAIsSV9i6ZBNt1QciaVBk4wqV02Tlc1ZyS8rGN7kp4f3alkaanmQ1
         m3K4DbFgUywH0g3CTYQTySo65vc6m6XtfUTt5kWAzFjKPUwEpgUsCOjPapDI6iQYPoEW
         go0zUdlYuwLxGVOIGzcvmqkJfmFQVQ714HnCA2mkMOb/vwkXycCgaeRCCfI5j6NGi5rd
         cU6boKuSD5nUdE7gIj5aMJxF6MoEMEUiLAZTI6w+Mqu8mh5D2+6Dsno7g40qgwLegbmG
         GzPw==
X-Forwarded-Encrypted: i=1; AJvYcCXECIgtHk5t3WduG/Q214GL2t1pw1YffoWogw7i2Y0BC5Mp0YZZlEShry8YCigagfgrLssRiQwgMxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4aZznHZjqr47yve5P/qQ86NJBbd85tWXiORB3rqQM7Zy4wcLe
	Wld8Rvce+rYItoJUV9acVNI86NwCyk9HspkqRRoOaeUH4SJ+XqP9czoM
X-Gm-Gg: AZuq6aLr/ZzaOw5Gfdtf7+gxfEbQOZMTdAZTFadC47EhqWHv39gKehu8KMzpX+2QjYi
	Plh2T0MDrjvDSgB9J1da4V6ngKhNbAg7S11zfoH67lhcW4kKJCFqsokfsIJRUxAXgUsl/16wrQA
	UAk9SeZv7ByoRtxa9hPDrzRm3bnhDy48/QDe16ExP0fVyZqf1dKw/3GzSEuJT3FyhIgVO27aPUJ
	Cpj3CabhWsfUMNInPGBWt49Rr6XrtCMssZtOsuKgiKHmb2YpuBErpS2nKMKgD4ogASX0tuEoQo6
	+pJGMj8zhhmEq57XfZKqMdHjbqfFUMjdNumNqnsR37HlpWACdmeV2SJGWgHlDnTgdWVqAaMN9nM
	DK+ECRsv1hZanM6xb5KrqOfSbX6zFBOtIzgyIhy5+Ge9+nYB5wesVDUURnhSXu7SUysGlhoqZ8h
	A/79BOvmrFIWO/h3VMtMmHcTYY0n+S4lTGvcQluIAMiA==
X-Received: by 2002:a05:6214:f2f:b0:895:496f:1a71 with SMTP id 6a1803df08f44-8973f3270admr101765856d6.28.1771206902724;
        Sun, 15 Feb 2026 17:55:02 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506849fbb9dsm126926161cf.15.2026.02.15.17.55.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Feb 2026 17:55:02 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v7 2/3] iio: magnetometer: bmc150_magn: replace msleep with fsleep
Date: Sun, 15 Feb 2026 20:54:53 -0500
Message-ID: <20260216015454.61836-3-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260216015454.61836-1-neelb2403@gmail.com>
References: <20260216015454.61836-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace msleep(5) with fsleep(5 * USEC_PER_MSEC) to allow the kernel
to select the most appropriate delay mechanism based on duration.
Using USEC_PER_MSEC makes the unit conversion explicit.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index ff6196c86e6b..e7f8d118242b 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -683,7 +683,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	 * 3ms power-on time according to datasheet, let's better
 	 * be safe than sorry and set this delay to 5ms.
 	 */
-	msleep(5);
+	fsleep(5 * USEC_PER_MSEC);
 
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
 					 false);
-- 
2.44.0

