Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D203CA4B2
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494494; cv=none; b=DrSYf2VXqumr1kMTN79WH6uzpNz3pC1XhNoEt1WA5+f5E8sgTP6xfuBsojdUHh4qCwieHJZcIjbY7SHlkN/ELymNwbrVWMPcVc0K8mj5Vxp+UTw+3/0fpTxxJuVyccXIkRa0seZ5PKpQkj44uXpXtDIImPuQkO67jNyLuIt8Kds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494494; c=relaxed/simple;
	bh=jGrChfvtc7f/qiQHk5nVLlFLvyEgoORGw6AmtBiHNAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxFA1jyJVxUIfZc0iYvqDAbaIKMo/iN8kwx9qvkVWOmO39gk37iFwg7/OHUp08QJ7X+rRWI/Xx185mSDKaKIZkig/gKNKHy1635a1/NXXslaEt/D3qwDhVvocPzVBG/i/D52zCjKGgyWRVY5cXddA+Fg7mzA+BSjDuZdslFCe8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKumFlzU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKumFlzU"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67c1e0229acso6241016a12.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778494491; x=1779099291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8k2aE2T7Fh7UhJGm491E7yjBw9Lt+zhjX2clD278X8=;
        b=AKumFlzU+zInT18b1fADrtac9F69NWoD+sGV+kyi45j23tTCtP4HwV8ffpUcratTjW
         MCjUBmTSyMq9ZxoMhu4LZ3nbyYAyZewPx6J7TnYJpGNZ0q1svpQjN0V2RgHV1WrV9lvu
         In0lKh6F0YOicg3WRtyMsxG8abUY+0NnCN3AHOgdPdxCJE/pQaPrQdtLSzO7OO+EUnDn
         vLYJUt0t/Jhk/YIfRZfnWqqN69xyppG4r9GVXZply2+ofPbQ8nUOt7P7jzxDS1TlKYXI
         G1h+TginIhfOBqs5Dloywks2684dtpYKdWqVh7NKdiwM268h6HPqLEXyTVbt9qR6e04P
         TXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494491; x=1779099291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8k2aE2T7Fh7UhJGm491E7yjBw9Lt+zhjX2clD278X8=;
        b=RseljsUJkmq68/DJpRaTtomsssGarG/W7UffKB4nXqfGuGo3SeCc/VjvT6G9XF35lm
         5RcsYRAGq5cspi0qIoWQew7n3dhEHsEeSma+HTO4PnN9/OXishkMoHw7K3tF+87Yk9uh
         8zValqD8CD9WlPUgHRyP5Zfi5wvy/45FpOP7XDUG52kmD1lG5ggLq/bYGWOYEY8WaHtk
         zZokRz+8tjWuZryW+O/o4cYbxAMWkDrrQnyYUNVs1uzb6ZqPMCe+p123zFI7zNpkYOFG
         vWDTp5To3RRG8XywEpuWV3oCFGGyjuAvi/fjD3JOLmMm4yE96tye/09yL2kiuCxQHCtH
         mViQ==
X-Gm-Message-State: AOJu0YzVi2j3+/rol0MMuFmwM0uBQ2BK7Dq6PgdwGJeTTMYn5LovV7lj
	rzt7jAdTvdg2vwL+Jdj8+9rzuz3NWG/k0bHgqxDDJR2g1BJ2T5qRs6qAVQzJbY2c
X-Gm-Gg: Acq92OHtdP9tuuf4EnZGPqTtgcMQSsFUJAxO1e7BZwWNKvUhVZcHxx2r0NTGynEt3Ho
	WWuY/WB9WHOyBiatbu9zX18N8rvHeZl4Q/06DyuT/VtJoPvvZsNR9rSXqZoB3Xbi9o6Ib7Z2TXt
	YRsQSqsj3Rsi7CZRglv3tMfqyz0wpaEOhMMGr2aWTI4J4ZGHItGiK8GhxKrBcsIzKpzF4Bc0tgP
	t6P9TlO2GE0QyYSNTk4VerKsTBAlDuXcqXcDJ7sGtO076atNPNAjO0ohbdZeLnGFPReO8PjgT8p
	+T+e8dOK89ivbQMQxmyE4ZmhasbqKv0dk0YFoVw5GyUI6kcP3U8GYd1LHEnMmCtniwWkfSeirNC
	Aza+Kd26i56o8uHPE+L5g49B2SbnA7VjbH41jpOgOqY28rKT+uyCqMwFzHRUt/rcxlpHeVh4of9
	gCa1cqATn9qpKLvftTgVC/dhKc6oI=
X-Received: by 2002:a17:907:960b:b0:bc4:f3eb:5a76 with SMTP id a640c23a62f3a-bc56df1364bmr1338565866b.44.1778494491214;
        Mon, 11 May 2026 03:14:51 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcc384b75b9sm328337666b.21.2026.05.11.03.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:14:50 -0700 (PDT)
Date: Mon, 11 May 2026 12:14:50 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [RFC 3/4] iio: light: add build support for APDS9999
Message-ID: <4bffb49a6b8a47037a08e728caab539fea6a88b8.1778491503.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
References: <cover.1778491503.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778491503.git.azpijr@gmail.com>

Add Kconfig entry and Makefile rule for the APDS9999 driver.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 drivers/iio/light/Kconfig  | 10 ++++++++++
 drivers/iio/light/Makefile |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index eff33e456c70..c7256ffb972d 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -119,6 +119,16 @@ config APDS9960
 	  To compile this driver as a module, choose M here: the
 	  module will be called apds9960
 
+config APDS9999
+	tristate "APDS9999 ambient light sensor"
+	depends on I2C
+	help
+	  Say Y here if you want to build support for the Broadcom APDS9999
+	  ambient light sensor (ALS/Lux).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called apds9999.
+
 config AS73211
 	tristate "AMS AS73211 XYZ color sensor and AMS AS7331 UV sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0048e0d5ca8..39e62dfc10c7 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_APDS9160)		+= apds9160.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
+obj-$(CONFIG_APDS9999)		+= apds9999.o
 obj-$(CONFIG_AS73211)		+= as73211.o
 obj-$(CONFIG_BH1745)		+= bh1745.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
