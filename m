Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225111;
	b=28+qgoNtQ8iBMr7GV7R9a5qK+D2TzzLHbxON1ajx0h5iqunYckW+MFLyY+BK549p3GwW
	 2/O+qAZBpWsgAY2/Ex26BZA/YlmlCYvO2xwVRrJRcFPoSmNm0lrvo2hwFZrg64pqz0eNG
	 z0K0PGLSWi4BpW4eTpROV5hBk6Efc51pU3YaYZ6ilMA73wTryeNm0tnek5yp0H/4akH/B
	 Ibjm/gLjWzG61R6Cx/Y0pr6EoMj2NaSMI09KxfRRJ8EeOHLSgzSxFH6VwltzicFBzQQxe
	 /kyjzeoIIV9khuYdpwtAvrgq5hCb26iVag6Jf4Y9K36fIik1AwuPvmdie2HJcnBqQLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=06C5fk8vnWKJZkOtzBHieSCw1Q9gegELEx5Pde9/C0s=;
	b=xB6NTlDnatvbdTCxVdPhwImPd+Afe0VvMaDrJ2Oh0byNb4WEfXoACjcI8oB0LH8RWWT8
	 P/MGGNhsjepyO1SVfr4VQNy6/ahUGPYkrpa0omsj4Jw387fF+svqw1iqO9yfgInHb34SH
	 0F/j/gd7I7pauXAPRc2i60L+P+zwHAQNtPk1qdy+tlyESvLrqdmMaUUnFR3Y5p6QJNipF
	 6Q1qhMkhe2drZws/IU4rCVUnS7q0VSVyJDj5SEmQqQ77pPq8DrzhwFHq+G4Erzzli3X3t
	 cnsVpecwXsVsXPbHaGT4IJCUyVowVG/N19+KD61N23NqrfoVZVU6oLsedwC3yDnjHVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aLyscfUT;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073E606A31D
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 22:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3073E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aLyscfUT
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535a54bed9so2148732eec.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793225110; x=1793829910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06C5fk8vnWKJZkOtzBHieSCw1Q9gegELEx5Pde9/C0s=;
        b=aLyscfUT7ok5ZL1xxGdqpRKmcqVbB7NaZ6j2TiZqdpUneR/ERimlsXoaneDTf9qGWa
         Lt6C30VJOSy8iemD91MHmOrzanhRjOdBLzTi4yQNwxZopVWr5cbyLsGqUY+cYDZ+K4QE
         SfiuZFFcykE+5JqER9fuaX3BlgrEVTXE3poyvPStEBqn1JZiU4VX5HaukwyiRpREhY+p
         Qi19UkFwR/IaqQK6xRiPU5pP+YQw7IxEmUFfn5RHizroISX4t5m+Iy6D4Sex5Y9Utn4t
         gB2B+l7HLGeqGECMQ5HZs7q8JjSAbmFeCBhZRuSICZcyPnwNT69FOvityPfwEjyZKhJY
         EtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225110; x=1793829910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=06C5fk8vnWKJZkOtzBHieSCw1Q9gegELEx5Pde9/C0s=;
        b=g3SL1S/CTKlhgXcAyRtqJhJXWBzhrXHiwx8hmqxkpK+XyCRvW5Y+MSlV0HJDAr03Qh
         VSoP/+bm4J9vaxlntGhQ7IUl7gUXczJ8ydn+JK0v4RGsJBTi4Gmg4pgYTEAODRLUBUwo
         Ps2ttfnpdfimS/VJ6ixKHjbT0Znu1Ua3o/h/Rhp0/cM1mZp9TZzrjMTDRN4sus8AP4Z/
         PDL9/ys6iehSFKP7atOHAvBdWx4F1TIalZGMP4XxC8F7THFq+uZ20kI/w475iVjH+/+K
         ruMliUdaRIEjBAdktX4EiVLPplXN/INvnMLMh7iJrFWc/h81HxgtwEBjF/HuIhUKTA1N
         tLWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxahNIdT+5bqoi9RcIh8KeaEh8L+1RZWVsxfN0JUKcz5KK8zTiVsxXMUqro7y+iVN1pzXmwZpX+fBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxBqAhFRfG9nhXY0a8Fzp6nQK0/9CkLZFpLZM34rD/EoI/+vOA
	hvvGnuAokCqIMbgULP0uJX6ydIDlRrcTvPZ6Dmfc6e62WPUIFbSq7/PDttC5UpW/2WI0xA==
X-Gm-Gg: AYBFou0MffeZsZ5dCnqvL0uVK1XZ8ssZEiPlKW/su+SKStB4NgQEq385ibvJ1hqv+4u
	y5J7N94U7dTg3nQpmFkLReQaG0Flvq21huKDwvaTnCvAC3/gKQnra214n4z9tJo1KOh3xOFR9mh
	3ULScxAOAn3I8do/Zvm0Ut6/BQt1eLB1pjdoJYFFyCkzmh36pNO4ULJQiaWjqJThe1Nzh78cceW
	zfQ81O4xe01N+S6ObUP/PbOomCfWLDxYKsIB5/weAE1HPehTpuQeNHF3AFiTeZ6jYNmHJs4wzyR
	edL6uMHr8C06JAlAzGgpkAWNi8LQu0EpVf1EaNvvwgn559lcAjoLpTzNbdeBC42fV69pTOzhdyI
	b93/L7V6ptUW4CowFwCczEt5LOLi9ptcvWMFq7hqALgrWuvd4xNGjBBYwnO5Fbynd22hoHZaskd
	wEk9PSfrrtwbmwWSdutj/20DcrpEIv/JotMdrXvBL77hUC0b9aKAi9fOq3AiNMgpKDUMdbEGVUq
	2V0944iZv82uUbmPFzTJV7glCvnCJwpy31Ab2h22jnUyWfdcUit5Hq7JcrfTAIKRAIbmlR73ltZ
	K850K9Cx6LWnYA86+mQvLacDfZOUApe0hx4UAmmSzXO4mJnc4uOc50bjTrE+NQU5bYgi+uYCDPm
	RwHmFD80inyjxIDfWn/AumpbJ2frujT2naKXpe6mJ9E6iLYums7Ow1ZjCbCioxp36HS4gEUxSHs
	7UauZdiZxURURLciK7YYzXMBMN1PVGRLwl2Xkx2fDT3Q==
X-Received: by 2002:a05:7300:d589:b0:35e:a225:3ba6 with SMTP id 5a478bee46e88-36a203909ffmr4808793eec.13.1793225110116;
        Wed, 28 Oct 2026 15:05:10 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390a812sm9924429eec.14.2026.10.28.15.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:05:09 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v3 3/3] iio: proximity: sx9360: keep the IRQ balanced across suspend and resume
Date: Thu, 29 Oct 2026 03:34:39 +0530
Message-ID: <20261028220444.70121-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028220444.70121-1-kapoorarnav43@gmail.com>
References: <20261028220444.70121-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sx9360_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9360_resume() also
returns without enabling it on error. Without an interrupt line,
client->irq is 0 and both callbacks act on IRQ 0, which the driver
doesn't own.

Disable the interrupt only once the device is asleep, always enable it
in resume, and skip both when there is no interrupt.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index ed83d809ecf5..85b83d86a433 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -797,8 +797,6 @@ static int sx9360_suspend(struct device *dev)
 	unsigned int regval;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
 	ret = regmap_read(data->regmap, SX9360_REG_GNRL_CTRL0, &regval);
 	if (ret < 0)
@@ -809,23 +807,32 @@ static int sx9360_suspend(struct device *dev)
 
 
 	/* Disable all phases, send the device to sleep. */
-	return regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
+	ret = regmap_write(data->regmap, SX9360_REG_GNRL_CTRL0, 0);
+	if (ret)
+		return ret;
+
+	/* Only once nothing can fail, as resume isn't called on failure. */
+	if (data->client->irq)
+		disable_irq_nosync(data->client->irq);
+
+	return 0;
 }
 
 static int sx9360_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
 
-	scoped_guard(mutex, &data->mutex) {
-		int ret = regmap_update_bits(data->regmap,
-					     SX9360_REG_GNRL_CTRL0,
-					     SX9360_REG_GNRL_CTRL0_PHEN_MASK,
-					     data->suspend_ctrl);
-		if (ret)
-			return ret;
-	}
-	enable_irq(data->client->irq);
-	return 0;
+	scoped_guard(mutex, &data->mutex)
+		ret = regmap_update_bits(data->regmap, SX9360_REG_GNRL_CTRL0,
+					 SX9360_REG_GNRL_CTRL0_PHEN_MASK,
+					 data->suspend_ctrl);
+
+	/* Balance the suspend even if the device couldn't be woken up. */
+	if (data->client->irq)
+		enable_irq(data->client->irq);
+
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);
-- 
2.53.0

