Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592013B19DC
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180882; cv=none; b=Lxe2VrZ9LkJcvfNtSiHxDcMf92wJ9S9KEqqBZaqZgvFPXatN6G8tNXJWqk6zda5+SJNvfdxcyefxYTqBUfBKqPsL4m5EDb2RpneMl2eT24GudZqU0hqi85JOBnVc/IGt/qMHVEZ4ZQCqpKiz1ylIUhZEL3G+Wpk/Jxq2FG5cUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180882; c=relaxed/simple;
	bh=X+/aFnZEPNa2izsThX1y/4psXjTYxE4Bm6cA/BRfIvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKoLctcYTJr61rHPKDyuUSG6Y2PAXJtPVmS0KF+Cd9rok2Czw1csMznMHd9dFXj2BHodg+p4NosB23zwlkLu/w4TgAXRRABVD9bMRvgNr36PWhDyV46JxhYJr31PknMcTmztO6I/jfKcXnhA1B15QUUWZ1sEQ/bw3MkrUbJwjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isLcHoSw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isLcHoSw"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe62837baso668812f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778180879; x=1778785679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JoY+P4DBLU4L5gIGwkHhE2nWnhJKohlK54TK3iQ7gI8=;
        b=isLcHoSwzkOVgoc7lBRq9q2Rba7DdIRoFuq3gpgGg5TJ5buQITNagjzKMvv+oYFowh
         KVFaw8rEr1MvsUbFR0m3yXlEfDO3dqtIXoto7loXJxMT5k7HdW/hYY/jIj8YZagNTR5Q
         bE3aFffXu8NTmRDnYxSkBhqwwFgph8U18GeamFoX7jyGKtUPuskOm+ROhxgavuyi1G0a
         M2QkbCAH0jrrs7DgqcOkbpf4jebVa6QVYEN06X/6RNwr3mxgiS5s5UV04sANEEe1Us7x
         3cBGn8bDxzY++97WKR+jTG4Mn4LBEdL9WWDDmzctctMIyFBKDDNAYTdfLmrvuCQ0oYJj
         siqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778180879; x=1778785679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoY+P4DBLU4L5gIGwkHhE2nWnhJKohlK54TK3iQ7gI8=;
        b=Ks1kvjaIKX9y+gRA5QNlNhG0RalFy4z/AYO9FFXDGrJSmUO6oHuMa+lA0+xTVJVs+0
         AcNm+Q7hJOxREZ6ZajTj13m++JkBI4cgOKHbGGPmtrH6wje6xC2KddMa1ThbRoCXDow7
         CQLLGz9OoOyln8x40Uizz3pN0AyxcJCLVScR9395Dz5s9Uxcs3ud6JYL74qy2r8kGXGV
         AUzYJVyO/LneOQ/AKK5iIdMiHBKgZpxDa8GORlO0mh1k7J85ol5pn7zpPZP1Up7e7jOf
         WTVOxMgEA4elHuPu8cgY12rD8QS219dNk35hB81vyg/gHZ5T1GKCvjKkVzlkiYMEZU26
         9/zg==
X-Gm-Message-State: AOJu0Yws7J+G7aRBPGxomFG5Hr4QeIBSQ9u/sxjwv8B1Pry3Ty15vdae
	j4vUcM4Mh1RRfjxhjW8S8SytpD6Pd7ic1s4JBJRj5bp4zSTsAjqwiE99
X-Gm-Gg: Acq92OEjd7qnFx1pv2zI2neMlpRXBEB0xZGeS/N7MuiO/j1Uy8vWuA0UJB5wflu2Snp
	zxcx5e9FzisjDfHdjOR1kqjH+e9j+hP1O8g3zpnq/7VpRQ8RMq0e2iIDlahUuu35j3LWvYzjlcf
	j6ug8++r1qQzIQHCI8MbZXGVDgS2j/i52DHByiFPrmw78nvYh/so/6d49SiTbsuXqO1Sc3Tn9Dp
	B7vUco2cNdyhajxiudfWnYyspv2NaRlDqFnnsZdq0kFPkOJRRxgiDLebT4h+NH9VvlyFzycyAxh
	f08e0ZeDTgFT54xSKmfyiXcGOCuLofgK5zej2BcDN5OuoBuj9HrkJY2gifJTHDtLmn11/KO7Ahs
	GN/BTDiVzv4afbvuLKA5S3cA8SyJpUnZCV2mtBhuWofADlIicNjWZRYi88X4/+0etv3k2B4GwFj
	SuqS5jPaSOLWLqodDtZmaQlGXIk1/A89JQXU4IxYI=
X-Received: by 2002:a05:6000:2f87:b0:43d:67f4:91aa with SMTP id ffacd0b85a97d-4515dc80aabmr13813485f8f.40.1778180878583;
        Thu, 07 May 2026 12:07:58 -0700 (PDT)
Received: from localhost.localdomain ([196.235.195.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4541282048dsm1083749f8f.5.2026.05.07.12.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:07:58 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>
Subject: [PATCH v2] iio: adc: viperboard: Fix error handling in vprbrd_iio_read_raw
Date: Thu,  7 May 2026 20:07:51 +0100
Message-ID: <20260507190751.28352-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver proceeds to the reception phase even if the preceding
transmission fails.

This uses a goto error label for an early bail out and ensures the mutex is
properly unlocked in case of failure.

Fixes: ffd8a6e7a778 ("iio: adc: Add viperboard adc driver")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
---
Changes in v2:
  - Add "adc" to the patch title.
  - Move dev_err() out of the mutex critical section.
  - Include Reviewed-by tags from Joshua and Maxwell.

 drivers/iio/adc/viperboard_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 9bb0b83c8f67..f7ce3effd730 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -70,8 +70,10 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev,
 			VPRBRD_USB_TYPE_OUT, 0x0000, 0x0000, admsg,
 			sizeof(struct vprbrd_adc_msg), VPRBRD_USB_TIMEOUT_MS);
 		if (ret != sizeof(struct vprbrd_adc_msg)) {
-			dev_err(&iio_dev->dev, "usb send error on adc read\n");
 			error = -EREMOTEIO;
+			mutex_unlock(&vb->lock);
+			dev_err(&iio_dev->dev, "usb send error on adc read\n");
+			goto error;
 		}
 
 		ret = usb_control_msg(vb->usb_dev,
-- 
2.43.0

