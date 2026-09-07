Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510523F1056
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771244; cv=none; b=Wu+I9gPWGQC410l8lHO8FiP3DZDP3wHAotwKNzAk2abapWFblics5m51Pa3XfLXU14NjW8Jwuvdblm7XaHb2P4FtJio2hhyrk4eBLguyDNAD/ZOvTMeq4T1AJKdqfLs3rNL7+jr0Ia1ssKm64o1Np4jdmoeVp2cGO0QZ1KZNFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771244; c=relaxed/simple;
	bh=T6jPsbPIyqALI9NXr5wJckEJ9ruwlbMarPcMN3a0lwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BULw+3tx3JEFPKGMiamQtBSzU+GEyP7FndSB3CmJYNgHuN7a+s9S6pOBPapht4EunpDi5j7+gs89wLVUahrQFlBdvltn48QCwRksSDOxAlAxNdgGjVbtyFXNFGmkO3kp9L5HwAxZcFVp4e8Xk71iKF8spjNBd+sg/mqehinWGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYXSDory; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYXSDory"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4843f205a5bso1845274f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788771240; x=1789376040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xKjRQq+ijBRhac/KlHOQ6qKwFk2CUXwuQOECe/rqC+Y=;
        b=qYXSDory8vUVHGO7H9WArfmKJ/shitcRd73TtwHPOdqglPztH+GdoZUXbL4i8vONLN
         j2W5FucCwf0Ek2glggr5hhrPU93nOK0dIwECTR2rycHFD0cMdw2faoaq+Zj6VXu+BC1x
         8wb0zUwBS53XA+2iTLDaTbMaPKjBoaxmusUPxm+4bXUKwtqFnOr0a9bJPDG67aFEbZFL
         5u6RzC8zVdpZKNpDYOEQdXl7FhrxIctkuXcFcurIUO803qJ2/BzcHZTjHw0RJtPdUWwq
         /KndWAFcLG8jjckk5quf5lA4getHgaTeidDg8ZKnD+dJybidpStVmpazExxjOpmshKlq
         luUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788771240; x=1789376040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xKjRQq+ijBRhac/KlHOQ6qKwFk2CUXwuQOECe/rqC+Y=;
        b=NrDBnqMrOaeQ7WiDTEqGkZfwawdOb5lxcSQ87ZUzKNqFNx+LiI5HXTMm7p6YUuHGRE
         V+0iiyj3e1UKCHzKFm8dg36iluWdEx4LZnsq2xWTbwLq/W7h3L1f9D/1TrsUgGYGY+KT
         LonmaoUpvpoaE6NVTlFuSUpZ4fktDpgMWKwsjhTrYJ51fBN0vyHuEaLJYaan/qbXe3yn
         A3/ROI3AzpwVyeQf/V3ik0eTbC22aVXWbOS4KTy+yXIeGhRSa4N5Uy/0dbVWU0y5fmnn
         CFRkkSQsQUzRGibZeC6/Xr0SZnQ+CWMuQSYerbMyPcpOIGgj55tVHgFIMyQhQyeFfmJh
         jRzQ==
X-Gm-Message-State: AFuF++lsxpLg3QKTEfdHW9lcRlfUknFhB+XmZPX5ot+uYpBO0gLy4Egm
	UiGMxnZWCrQ0St0gvrTpo45rGBBiWdslC183yfSpDpHE85bM8xLcLCwg
X-Gm-Gg: AYBFou3K5EgOef6UYsOfqn8EAPLD+YA6HRyMNiPbmj0JcM6XDCHCRqWU8Htz6UC8JMG
	+qWQB/j+iDvbjRD9YPsxJ46lYpWLNt2+gHFH7g9YP8s6/4oV7+2A5kMnnKZ8pSRsXrtZu/xgYAH
	gn4Qy/2kUxak4NUgkYfUJTv/4S5IXHcKDbF6PDxFQfBDl2mGcjk4O2NVLIypv7NLjqyQOTE8GyA
	z6vIKthAYNUn+EeVoadBFyATXhc5JbdLVSEwleT96IP+jzZ4J4rDijhFr+hRvHRV2fQI/zef4hR
	nbS1vh8R4y3ZViVTyQ6W6tcgf/QF0UT+eLzjwjOkLaVSogFxNI3D0DyBAYoM5tNkPv2Wf1C8nyP
	p5yfNQYiDzkVgEOI2AbauZKfGuXJyDdVZ2k776rUKR9Au2wJYwyMETEzQwcUkgTHvsTJV2Ufj0z
	TEhRgQP4+YA4AVy7Kbsba+ogu1qZrqWPxoEi6KSO/BJZdntdb2sb3L1aJpVyGb/SGInA7ijurUV
	gSFCUauPAm8
X-Received: by 2002:a5d:5c82:0:b0:485:8a46:b3b5 with SMTP id ffacd0b85a97d-4858a46b479mr20151350f8f.29.1788771240203;
        Mon, 07 Sep 2026 01:54:00 -0700 (PDT)
Received: from localhost.localdomain ([165.51.77.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm25746158f8f.3.2026.09.07.01.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:53:59 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: temperature: tsys02d: Fix state desynchronization on resolution write error
Date: Mon,  7 Sep 2026 09:53:53 +0100
Message-ID: <20260907085353.54477-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tsys02d_write_raw(), dev_data->res_index is updated before checking
the return value of ms_sensors_write_resolution(). If the hardware I2C
write operation fails, dev_data->res_index remains updated with the
new index despite the physical sensor remaining in its previous state.

This leads to a state desynchronization where subsequent reads via
tsys02d_read_raw() return an incorrect sampling frequency.

Fix this by performing the I2C write first and updating dev_data->res_index
only if ms_sensors_write_resolution() succeeds.

Fixes: 53bf4d067d51 ("Add tsys02d meas-spec driver support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/temperature/tsys02d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 3ef72347456e..f50426beacdd 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -73,8 +73,9 @@ static int tsys02d_write_raw(struct iio_dev *indio_dev,
 		if (i < 0)
 			return -EINVAL;
 		mutex_lock(&dev_data->lock);
-		dev_data->res_index = i;
 		ret = ms_sensors_write_resolution(dev_data, i);
+		if (!ret)
+			dev_data->res_index = i;
 		mutex_unlock(&dev_data->lock);
 
 		return ret;
-- 
2.43.0

