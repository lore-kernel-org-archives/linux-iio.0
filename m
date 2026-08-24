Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7464338DC7B
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602465; cv=none; b=SrHp9nUJa3wO+pdxaX0pEIx9xfnN/dDXA0/Tew6f+8ifqg2D8qAjsjrNRNyrTRBKE178SyU/rCPsZR/NzjG1II96IdZmsO2o7zMihUsndpm/IungTNXNRB9WoiRvZgDV1micJF6ikB8PV9/fL09/KILrUnOVAwUDPkEKxjYO+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602465; c=relaxed/simple;
	bh=m4oJxPscrxxq0i2z/68SeZy8svwkKCtvosHLYsFT6TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCHVH2NbmDKGYMKvtt11YH9Gxo/bk/JXPmEGcscZPkcyZVV71PQPOFaqR1eeePSisEgqqfEOgcgUc/xJ6uQjA9CHDDEq/VERVQwjxo5WsMEfhs/jEh7UM3eErplzm71H+In67rXxZMels23FgwyhXXt02a6Y6qVtePo0/fJvZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6yWh4Wu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6yWh4Wu"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aebd52488cso3732117e87.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602459; x=1788207259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EmhmgT8VKFfYQHk+qL1AZ/XS5DwXnr8XjJwyeM/eoq8=;
        b=i6yWh4WuqdCUe2M+nl6z1bi20P09S23LxM/Gkqli11poBHLY0gMBkMQQVJabQZaVB7
         hm6tk2qypkdBwl8JpnYtNwKEitCD32205I8ihgc+EFlQtCROOb3ADMZ6C6LYBrYEQrKf
         pwArXLivHGezB12jMeI9fHSuZHG5UvKFl1kp36SLmcuOQln4asMluWNI/p5r1vss7I0T
         Wmv6HXkBoczBLqhn5IBjxU7HTcnaT9GhXe+mWCnkybA88rupjMTUVUuLYh/I206W8zZE
         Ctejg+Rz6RXiuHfeGv+3EGW4h3SMPKPIj7tYfBL0xQDHRQic9ChHwNTB/U5XrzkA9EMo
         prTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602459; x=1788207259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EmhmgT8VKFfYQHk+qL1AZ/XS5DwXnr8XjJwyeM/eoq8=;
        b=jFD3TVUUnt9rqyu9ezzhCrgELizcrExKauzQ0j8yO4LSPTfMd47bTX++ymKLG4Q+iW
         dUqpRt+aIZhfc7a01/o3Lv+7JL3sqkaeYwXdBHoScjdzcwUcw2SwQiz2bjNnWENub6Iq
         Co/a9mmV9/BpVINjWjVARFDNDvVbP0C6VycRYGMgpUqW+8rvxKEH0mC5PxEVaJz2jOFx
         H7Puo2Pr6a0vuEYMNJYbw7Ny/RDieLtA6a/xltX0Zt9GPmiN0VkuGSwh2pSFA82QXuWo
         0YeztpGPuYysfgz32kYeSxb5IjaAHa52Vvc/81J6TeYC0lXSCeTupwxpYfF9HzlJDHQm
         4e5Q==
X-Gm-Message-State: AFuF++maWjARuTECm+R2XERC7ya9Yn5NZANZPzb+7lswFJtYhUDH6+Nm
	1Cpqz9zEt5kpMlYz3zStNJeEBz58gY4vh4xHbAjnUFLIKBx4BvAXKXlR
X-Gm-Gg: AR+sD11o8lQZorvLiFN14AKafiLZLmtMfYuP33marwOZnPO7m/PM+OESPUiRAOhaCYF
	F7r2Ndhh6nUD8GN8BZBXY5lmy+nkasisr82MifoAQlC3vvvVACZmwlchIM+oGtgS/Jk5oECppq7
	RYJJOtCO8TIXi01KS+2QqKezQGpsBkQ6F7wz/Btk7ktCizGGJ46U0xNd38lr7T2UPRQpS8PkBWw
	CHyggYGJU/AOZJ688PI3XUr/DWyp/BfrOOHvZJPa/PYorA7kgprSaMd+dUzgV2/TFhSJ918V+FU
	pdj3AaIs3PvhDg3bACQmjGPGhh8rgiZCa/Fo2j/myLwAPatYBiy7aux5wv+clBK082vsV3e6/J/
	tbb2QvoSzdgYKjesBNRxPavSuL+dHe7za38SiDHpsR0QLcswyc59cfzvfVf28bS+WtyBUuKCl3u
	N5t8oVyMZNu3kGWiH4PSIRQgrsqs5wBMUxgWDcOJf+phi6QB48PDSC3jCGsZPUcuM/mDVxurTJH
	YO0UR2lg3TMSZx6a1wd3xoGydXUysVAZkVSQZBMxl7wzuHMhPrLvThCp6Y=
X-Received: by 2002:a05:6512:2389:b0:5ae:cee7:52bf with SMTP id 2adb3069b0e04-5b48b67eed9mr5722292e87.9.1787602459341;
        Mon, 24 Aug 2026 13:14:19 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48ce0cd9csm1923620e87.71.2026.08.24.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:14:18 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v6 6/6] iio: pressure: dps310: check the lock markings with context analysis
Date: Mon, 24 Aug 2026 23:12:03 +0300
Message-ID: <20260824201203.396651-7-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824201203.396651-1-zoone.rupert@gmail.com>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__must_hold() markings added earlier in this series are only
documentation unless the file opts in, so switch the analysis on for
dps310.o.

Clean with clang 23.1.0 at W=1. It does run: dropping the lock around
dps310_fill_scan() fails the build rather than going quietly.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index bc0d11a20acc..4b1a05f7a0bd 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -3,6 +3,8 @@
 # Makefile for industrial I/O pressure drivers
 #
 
+CONTEXT_ANALYSIS_dps310.o := y
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ABP060MG) += abp060mg.o
 obj-$(CONFIG_ABP2030PA) += abp2030pa.o
-- 
2.43.0

