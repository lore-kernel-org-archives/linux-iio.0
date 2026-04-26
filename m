Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555B1DE8BE
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236643; cv=none; b=r3ka1YQcT5OsGLh/L0P3lubkWNBtxirkFZf9NAi68vvdvvWB9duA4ZJWUd0Zsx+8XVDGjxH9MMoyF+9E6Gru2G4lf87tGaOGesxmm282zN9DGxwmgrWlwz/9bFm8YAm3F8+NiiFzbJl6qKauHzkzfYbmNRj8cUKuH/Lcsx5mLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236643; c=relaxed/simple;
	bh=S8COp5cvrjo0lKiTIgw3J0o4L4SnaSUb3SMdXelG/z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okdvnLDeijUMNHcwWFO5SoC/Z10rN+3VPHIl9XDeypgGqb3213D382NhZqE/lyo+DANF/tQ+D8J7hCeAKrO4/HcLtAh2gqFyiVwa7fa4Y29NJTlIRkHTdoUYsKec51TmWsA5JyqtiEkbZX+f8L3BTpsUpavXhpnoVL10VAETsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQnPLFBI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQnPLFBI"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de46b8e432so3740191a34.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777236641; x=1777841441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DUk8j10LOn+5jK3eG5TZh8pc0y7Efus/q8JN9vQKIsw=;
        b=BQnPLFBImLtI7Jtw3ZJnZMLTUW/QsgZ98XtWzZnwPAqUNKku7Mw13tJk7AqZV24uDS
         Zvr2yHjnDLPjlEJu5V6NEDVbtwbAIGQu/tV3zx87EiOTP1+unB7Z6YGGAT3Mv4E0ta/V
         MGLrd7elmvA17JiBYN8mqcjORNYIuIr2zK7gFtC5qQLD9CpP/5pAsNl6fLNhxrxYhXuy
         T/h8BWki0xgbYFUQohbr+d3n0RU/alsENPlJXJ3PJzCQ/yIEB1vgxdLbv/FJUaXylkqP
         B3T6RadHBWLzo0YrYXza2O48fwUpZVBjAFbjGlWU1VDy00j+4dwf8rrBxMo00rkTDnfK
         G6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777236641; x=1777841441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUk8j10LOn+5jK3eG5TZh8pc0y7Efus/q8JN9vQKIsw=;
        b=F0tG3cRU+aeZjXTysKR1xUmgfmsve9mw8XALJw6Zliesa6cctCJD4PGLIMGlHhaDp9
         Pvpne5bFKwqy8Ty2X/+YOtuKmnreXZ9sSn501UAfbeSe3FSDSmKBm7yhxsAx9ifCTgOa
         Rb+geq3ugPO6zAfInq01GKakTV5eRw93lLiVQZa2Q7weN96lRbMTvy6k7n/Ay1S+AnF7
         2NU+YJBgofVhJNiZPARwNjYWuBVHt7UQGFtJC2Y3a8M3yiqrfUfIyFe5CigraBUgTxy2
         Q9BDjGBYMjN1oBxgZuUvZr9UU5mMszNeyHYTqQ+fo1DAUHi0+hK1CeYfzo61ZpihBlyq
         xW8w==
X-Forwarded-Encrypted: i=1; AFNElJ8DtZzAjy9NMhH3ttIuq4ul4n53pyQNsJlT41B8yXmFdR0gjNDC2qD1mL62RkCpEQa5GfIL0PV9iXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXUIvUwcy/dn0Sjf1On0eoKBQng+NZEyXdmqE1yvP6NRUHoD0
	IdNSB/4tTZZEN/2X/ZfN1Q4LNkEjVsDM0H2Epdg+uus8XEWIV1uXylzo
X-Gm-Gg: AeBDieskTl85pyYQh3OO+u/oxpSMDMN3+zyBeE63ah9k6b8F4qj4QFXjefUGWnyyr77
	cdFyh+fGB0sNgOwdYAL91ep9/28HXUpg9ybAFmrmSdhU3ZayHubYh/HZr/C9Eyv3J2JR9MhKFWg
	b9xwGxXobYHd9uoPHE4UDwZ6BHcrX29iAPhDOfUqG5nYYZ+FDX70AKmdsB2dRvD1xo2PZdkqnDh
	uLQIpI9auAgyHPxRO2ncZBDV802Zqb/VSLpLaB94Wa7ZhvgfW9cxW/IpUXDkfZbVp8tpeu5j+Aj
	C0eXESac8JFgpgbxNixRSOPEnu0+arg/embBfwtTnTh+98ISjl05J0esTM0lGH/RUaVH5oBZQGs
	BVsgjIsdM9+QLvHkLO/NODkRgvSY+MWPVmt0KX2MkxuncKTJjI4pfn2PO7Me9Fb1bjgbtCOdusx
	rcsMa0v/miW/h4Ym/u+r4hfUOplTF0Q9j+WmdYss3HRwLOtNX7V4oJo5ZwO2PW+uzEOdpdWv9vI
	Z6WNU4=
X-Received: by 2002:a05:6830:8288:b0:7d7:f90c:5833 with SMTP id 46e09a7af769-7dc952831c8mr24682765a34.27.1777236641172;
        Sun, 26 Apr 2026 13:50:41 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc747f1aasm18754101a34.18.2026.04.26.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 13:50:40 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adt7316: Add error handling to adt7316_spi_probe()
Date: Sun, 26 Apr 2026 15:50:38 -0500
Message-ID: <20260426205039.125818-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the return values of the adt7316_spi_write() calls in
adt7316_spi_probe() are unchecked. Add error handling to return early
and pass on the error code if we receive an error from
adt7316_spi_write().

While at it, move all three adt7316_spi_write() calls inside a for loop
to condense the logic.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/staging/iio/addac/adt7316-spi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index f91325d11394..ffd1dae8d1b1 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -98,6 +98,7 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		.multi_read = adt7316_spi_multi_read,
 		.multi_write = adt7316_spi_multi_write,
 	};
+	int i, ret;
 
 	/* don't exceed max specified SPI CLK frequency */
 	if (spi_dev->max_speed_hz > ADT7316_SPI_MAX_FREQ_HZ) {
@@ -107,9 +108,12 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 	}
 
 	/* switch from default I2C protocol to SPI protocol */
-	adt7316_spi_write(spi_dev, 0, 0);
-	adt7316_spi_write(spi_dev, 0, 0);
-	adt7316_spi_write(spi_dev, 0, 0);
+	for (i = 0; i < 3; i++) {
+		ret = adt7316_spi_write(spi_dev, 0, 0);
+		/* Check for errors, if we get an error, return early */
+		if (ret < 0)
+			return ret;
+	}
 
 	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
 }
-- 
2.53.0

