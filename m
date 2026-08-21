Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30433B14DE
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321162; cv=none; b=nGJNlLg9TmVPAti1X/trvAWS9kL3/+tZXoAEIolvHr0Sl6f97PM5tXVKBjiXDbKxKTwg2F/mZO9CRzRpyVdv2S7eL2U3nEb+USbY6skWGheaLMJYYfjAUjtjzGIVWZ1y5pQAc7jg5pSeF2ypUoSg1DCYbq5M1mszL1vVfOOvsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321162; c=relaxed/simple;
	bh=V6jkNLW1YYQmnfEWIbCubdp1d+GjElZh+NCHXfhN3+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1MgmGTyuSiKwGrnU2k+uLDHng1EUHX89uZOHfzSql5OtXh3RgM6GFcisw0oKClSmZEXeWwrOvuelpYU9V8lAn1nEJ3hWH97nc70Sh/DyZdv2wlxnDFazr7qCLVzrbqYzlrVlh+MbD0XLSA6VHIkd8w4mZWe3ttQ+1y7fc62pAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZFJezyY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZFJezyY"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f7872abb6so600323f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787321159; x=1787925959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wnt8C74O2IosrxYf9VWqCIzx4y+wBr1DyBqsAukCJ/4=;
        b=fZFJezyYUcu4NCWBez9Uo7+aLOFfc+U/e+QUZ9Gpl65yDecZdyQcjzt6MtL7x3dpVG
         HuyGClxjdSJMOmlBDAnKgjC/MIvryOBZjaW/z9Xjq6i0ca0/b15dXtfWNZiCwDTvTl0s
         5/RDt02fKlZId7AhPmDhHAHaE4RTzyPEqGAvtF1/sUf9ebz2myqjjYXNwZtuYPkkrqIR
         mIJ+vL8FbAQCTUwROp7bL9n7v6ODwzfaYTwBmjnuoVM5LXr8tNcN7DTs6wpRlVbj2Cjz
         1GGyiQx0U4FtMiAhiUVbW2s9yXm42AxDvcA6ug6ktHPu+8hB26cUiHbg80bCKXGlss+4
         OKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321159; x=1787925959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wnt8C74O2IosrxYf9VWqCIzx4y+wBr1DyBqsAukCJ/4=;
        b=SGIUczIwZzV0/S4V2q9LTNn2/8JYJaLP/xCTLe+IHnp+gdAzo7wi3dSe+pCaVEjELT
         8PVMeH0dI0+v6B2Y03birgIN/O0gjBCC0j5250HwIVG8z/7sXARUxu8stPgOsEFCiX9t
         sqH3teDj1VgSK2SfjmadEYfB/xB0A3p77WPRxgL5nmGhr+Fw6IpoICZxk7Zg8x/CjuX6
         vWp35olVnPa+omiVgZiB814jVkQosB3VuS3if6xlvTJS8eDWw6Ij6nYfrMSxmUo8n9KK
         H0G5I0QunjXiuff8pEyteFxsOrgYdZniyEUfezbS408Z0zt6KoQCfnwlv+4gSbV3Z/W/
         jpYw==
X-Forwarded-Encrypted: i=1; AHgh+RoVJ105fEM7oBak/Ts9g9zSSKw8xTlrY1G4vUEhRizIcrzexPEQ0oVxc8oVRu2SIM7lYDtjewY6JUA=@vger.kernel.org
X-Gm-Message-State: AFuF++mEhbxTo+3SRKaQVSPWYmqnoNhMPoV/NMX0Alba6o7a9GmrJcvW
	GkwWzklCXGSzk8DDrGBWbm916OO+VEdzrr8sx5umpB2SiCqbOzGrP/5C
X-Gm-Gg: AR+sD13R6EigzGqJc0qB0cAdmuwm3zhCGsVt4tleSDipA/KyNS0fzq0nb2xV5fgxLxK
	XXyDLfiT08yLDeu3ZEX3Z6Tblk/rvG8j63EcdDRkgzIWDcBIpEqo6A7Iq+QBtJK04uRDlIqtbRW
	PnMdu4Lerf9TbBUf4tZPgnIbPCjQyiMC/VYyLDpdwJlFc6Srr2Dv+Su6b9qZ4RNoHMQXBZZALMk
	GhJxXd7gEMH5ZxQwCXG9/Vy4SQdCggTZzIkexXvs3WGP7D/G5zugfSdOLAqQWyx6iEgHOAFe+NS
	OB2gbo+Uxsv3Ymr0XQCDvFsqqJNZXcSe+rHMuGwsY1WIsTlUvbyL0KJxowt3jWNw9L/FtUT640Y
	o0CHBwkHoCRWpuioCMV5gAG8Q0r7XLxFe0N19nfpaDyRosd3OioCrD7k8TLL9s76pJsueOENM8C
	bahx5K4O7vPuxfYi3AI70yVeL/78WYdACuvDxU1MVaLyAzOQZYmSX17Hc4KNt3ZjWnXzbbQfAAF
	C98L5m4xlGcyy2rfdVNDRZuMGnoyeCvE+o=
X-Received: by 2002:a5d:59c6:0:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-482c0ba3307mr10887916f8f.16.1787321158895;
        Fri, 21 Aug 2026 07:05:58 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:9816:5963:8c6d:ec64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm15106964f8f.26.2026.08.21.07.05.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 07:05:58 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: gyro: bmg160: use iio_push_to_buffers_with_ts()
Date: Fri, 21 Aug 2026 15:05:52 +0100
Message-ID: <20260821140553.80246-3-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260821140553.80246-1-grondon@gmail.com>
References: <20260821140553.80246-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/gyro/bmg160_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index d611341a0e2a..b007f46d3fd6 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -897,8 +897,8 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+				    sizeof(data->scan), pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.50.1 (Apple Git-155)

