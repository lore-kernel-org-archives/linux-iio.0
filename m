Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16BE3446AF
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973328; cv=none; b=QFa13Zlj1wZEq22Dui1en7rLUyvGfBbtmFmpzwaGzt/yTzXHTGwQ6YQ1Vy6BqD10ttpwihrIGjXbsv5Opb+QWOcVzW8Rhgvo2LvoIKOdePGF0b7gbdaBa9E/srOvEZVdvOQ0oLZoJbCtWDex5F0k/Xy3wfiZpWoYO66LQSuhAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973328; c=relaxed/simple;
	bh=GbI77GrkEw+EdAP5e947pwAORDnExo9gpvU3Fgjb6y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZAkdFmEBbx5IABDPQbV7BK8ypNDS3+3gYPG719tF83mzHV9TiH+qMbkN1vvGGWM73ZbrDU+28Xh+cuB4mFPv+3QPINxThYpPUtY8FxeVJuiVfsS9/v2PojMLV6zPrSpZNSCMKAcU3VtPN4vzUtutGgB57QU/qHKf2NP4V7nxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfjDzgwS; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfjDzgwS"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad79df972so6106276d50.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973327; x=1772578127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1hKEjBb/F+XiIzl3891wABD4RiRkcRdoBk1qKL/7/U=;
        b=HfjDzgwSCkCExfI+2MAa1BwGdy3w03d8SFy4sYEBt2kbWZ/8ZVajv1AFJCQppr8teN
         0AElERvyhxhasBP4po4jacDZ3KMA92Dskn2V7rFjbBbUfMIHi6EUjVudalBV/0mhX608
         OiM5YhrY7gvpPgzwhmzV0Jk/i8m1DFXbzqQzAZww5LI+h0pQBPsrjhsr1IRonb5lKUrS
         vBTP2RK7/6JN+lB0iMYLVZ4dTK2pmkebiavuHq3hu5YZXjQYKeLH0Lqb16KQFxl2xzET
         o4j5HNaIugCqbEkzl+lsx8Cx9cOQT9qrdrZW4jgs5X0rESVSQidDAZ6pmviezJaR67cL
         kjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973327; x=1772578127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1hKEjBb/F+XiIzl3891wABD4RiRkcRdoBk1qKL/7/U=;
        b=kGR1akCn68a/1pvbjg4DvEYY5DG9eB4+OOYzyUsyRJ738FRzbsTRhANjjLbflEZq3v
         uDXgSuxN9vZ7J85DzIM1bkCVE0gQHhem5N+j+BhaL69t2XxAr3fOGl6C/IhOVg0hesHc
         Oi0fZPmHRn7tHkLlkkPRL8kQspnrPRoz2eVPcgdl+QxB9Rp9+HQai/5PisrWE2/xLYXq
         dAc8brcnCNviwxTD/4WiOZmlrmXHTtTSiGNL0TyFMXQP7fCij0JQ4lnU8q8MpYIBQUKp
         98a6jdgTAVSgMjy36u/hV6o3OX43BHIEpC4LLp4s/VTUv39bKn0iE4OVJmepPizB+dMu
         OOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkdThzwdG+y2X5iLz4b7A37MlrVALqIqYXeXugOWXbJU7XgTkJEoshtIWenpYmcy+rHH773H8sip4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfI+hJn424y5aNlvp18UKL/CF4w5KHX7j2VlaKFfJquhOMPTvh
	WYJCzauAUrRHIbCS0xMsG6asUFTVcS0EZghbF5oDSNv2e6Warsv9WsaM
X-Gm-Gg: ATEYQzzRJmFLN3+pOeMcfsuZnYZdIUfBXfHkTqlAUEpoSyHeO0EW6F4n4TPQK237AMG
	X/5duwaPj67jrYKX3xMUQ32tH+jMuX9I+NYZXJ/fd0K30kC+qAItf5DtsXgNog8SN7AMdROuhiO
	pEgWN7caNU67g4lU4VtNlBSVlkLW7tpvxigYx1NZSRng7nSzGzh4uow4jffXiBpAN1BrWTYAZ6c
	mlXSPrfTl8YHvuUve0jvhhpsIHl6RGyrO+VW0aul9ErCpZ14IhmbPkpRGejdjPAqgbFcCW9356f
	GzL7zviuuHxD4XL/FgpQUi3dhxOzPHlbin3Ph5l4FnuBZdXnO3DZdeSj09B6FaC+FU+1ZyE6VwI
	VQtoE+AxEfKoAB9nGMfaNiEA+DWIvdq+6i2h8XBbW2mJB6qCX9DO4FtyHumdmSSt+4P67WpWYWK
	SSBH6nfygsdTJQFgqPFY+du3CVSjWXM3cdRJUB/Ipt7a+4VVyavuOZ3RYBVPJhPXM/TFhxKP8Xv
	7KacAsuggxUB465vbWsBfHP
X-Received: by 2002:a05:690c:67c4:b0:794:a165:1c3b with SMTP id 00721157ae682-798681fa0a2mr3013407b3.30.1771973326770;
        Tue, 24 Feb 2026 14:48:46 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd88efcsm48838757b3.24.2026.02.24.14.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:48:46 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linusw@kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v3 1/4] iio: gyro: mpu3050: Fix incorrect free_irq() variable
Date: Tue, 24 Feb 2026 16:48:15 -0600
Message-ID: <20260224224818.2452675-2-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224224818.2452675-1-ethantidmore06@gmail.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The handler for the IRQ part of this driver is mpu3050->trig but,
in the teardown free_irq() is called with handler mpu3050.

Use correct IRQ handler when calling free_irq().

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v3: 
- Remove unneeded code snippet.
v2:
- Patch added to series.

 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ee2fcd20545d..06162d886b59 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1261,7 +1261,7 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_disable(dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (mpu3050->irq)
-		free_irq(mpu3050->irq, mpu3050);
+		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_device_unregister(indio_dev);
 	mpu3050_power_down(mpu3050);
 }
-- 
2.53.0

