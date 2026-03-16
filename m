Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D73D0905
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682106; cv=none; b=FN7zVJIDM6y1KOjwbjcmtKkmARfcPNdV7eGChgq5VYHTcngejAUW85jGZ8y7YezkjmVbHAbLngpMMwiIETV08tr2eVwGR1jsP/RhSRT/t+jyg9muxQzjPXNwGssoXGZCJQl6zGkxl/KvwwDLPBZMxWnihXBHeHR5xJAsuXHpmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682106; c=relaxed/simple;
	bh=J3rsLfA1gl9b/Dj5KCNuxwkIb5keHkoc5PxB98AUe6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+qIZPmXRrrC+P8ppEclsWvEvUwK6KFPKcwvhBMJnmmQOY9pB/LOXLznpwoPM6x6hNHaWaphp4F29A/CxeN7mMxIfk+mlWB0hMYBhC+mLjn9s772QW3CynID2ksQcYQC6eFs4wCD+chVZaRedUJmB1v0EUHDI3mRr01pKhSwLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV3EfsHG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV3EfsHG"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829928e512aso2553492b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682105; x=1774286905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zymdn4nj5Um421IkOTRfhb779vZTg2I9Zh1Tvh1vqYA=;
        b=XV3EfsHGaNsUqdCNWewvLAI2fAINztfnDLxdtja7FBtoLfR/Pq6s+vB5q+remMaMti
         Fb1PbyvNxx7XFHsy2eLQYS07s1H4ru2uyh2xy4nyR+mdMsBBQfEThljaSBoQCEIlLvOj
         9bx4lYVGrn/hOC40vTO4UVqlThXBcdtwPjWjPWKOLGwU6QPYkSIv5uYrFh9aJPqSB8ev
         hiSbptL5eVt+CoEaJe2Hzftj5L9YDK3w5M6viPDvNIU6Y2Ao5pHAOIx8qz4oRK5ogk+g
         Xiq+Y6ScIxl68Zf41N37qJTcfDERNrnb72/Rb1kPlYS2jSPaGdSDOZoLb5YNdHcsblTR
         vqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682105; x=1774286905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zymdn4nj5Um421IkOTRfhb779vZTg2I9Zh1Tvh1vqYA=;
        b=fy8vqdNN7X0ZgXObUFb6qeI7VYtbusXghc9MeWCq7IWsiIlueQKw2Gkic0Uf7QIzw3
         vykZGy0RYeip1j8U3QrNCrDKj6m0RoM9O1/Zkak8+rj1zVV1x9BUc6GnHZ+pYgk64mWG
         OWngxGLSPtPf5fTcd9PxlkekApbthHPpSjA40qR3IBRMkEFmnPHH48KHw5dL3+Ndpy0I
         4AR4YpWweghH+j0Rj/JY5VudKzxiYUxIeck3z1y20IGlv7ahhPwtx+KghTou1sI6pj+4
         sH29UqwItGgMZ9x41Nzulqa+xag2UMcx+Dq7e9zMV6VfJFea/f4OEI5ZYuS9JUCgtcX+
         eF/A==
X-Forwarded-Encrypted: i=1; AJvYcCWNwp+WLWKDSUoKzucqNP572esxBgIdj2GsZqvYcXOkomYYOO32lMyzHc0mBsUpbMC0t8Ulfbs5U8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4gK76hKHN2H5cCbp6/WJs9+lo7NBp90NwIvRT0KZL9I46Md8l
	E99MulPUVdmlq8Wscj4To8qtFXx4X0olapr9F6ewMoeYEDNJtj9Er6dctJo36A==
X-Gm-Gg: ATEYQzzkiDnbIsYBwlpcjXuwzb7kKjI9W1TiJYB2sv2skJTjvg0rIYcgQetpOjhtSNg
	kjwPUvBem/Pjg9OMpTLVei6hqEAIo8VN8CiCCa8b+kIH7GNofQloiSYbyjuZ9jJ3E5ZMGPupNew
	1RZgHLkRfoEXPK1mxx3n00nh6P2BgM+mOQc1fQdIkqVQIT6wI7OlRLBdLsOzVY+VDsdVp92v43J
	0s0RmhKQmbo3oesR6CV9CnWf2e3vCTLsdxLO7HXbOsZ9IG7WFgi+QTtVHa6dpdRULAkRoEvrHc8
	azHQyA7tza7m29ueBbuDnZf+Tnr9TwofvSP2iib1r2FNCNLZEVl8fhWV1WObXs4oiAdDkjHwKWr
	Ft9Hjh57tOEowRLP0dyFw65WAYnJYdm+jU8095fozBv9V6wshF61U0SHh9N8dOSeHzJdHhsHLMu
	HYUInocJ053hS2DuaifJyrqybTQWSXogqMwJMzg7DF+Yc9MIZC42X4k9+qqXLSMCaY2uo5Gp/hw
	FY2
X-Received: by 2002:a05:6a00:2d97:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-82a196d8bd6mr11673159b3a.14.1773682105029;
        Mon, 16 Mar 2026 10:28:25 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:28:24 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 03/11] iio: adc : ads7950 : replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 22:57:29 +0530
Message-ID: <20260316172735.11430-5-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316172735.11430-1-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
iio_push_to_buffers_with_ts(), which takes the buffer size as an
argument and helps avoid potential buffer overflows.

Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index bbe1ce577789..a3f01ae5783f 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -313,7 +313,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
+	iio_push_to_buffers_with_ts(indio_dev, &st->rx_buf[2], sizeof(st->rx_buf)
 					   iio_get_time_ns(indio_dev));
 
 out:
-- 
2.43.0

