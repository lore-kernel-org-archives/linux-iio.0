Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420EA47AF6A
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161684; cv=none; b=qy92kCOM/Um4Zn0xhdDG7Qj4vRbCI5fPF5zeCIHE9Zxuqcp1fpQGNnjifdnL/zcj5SkE6U/DAQ8iBc94ucRd9sXt+fUH7MBCXf44+Bvf2X5kz/sOhTLYQUJ50aGvVuVidekAkxIaMZ6G42Ifh20cXvX5H/LqIAi+y7tQ1VBWS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161684; c=relaxed/simple;
	bh=uR9Z3Kd1DdLjQLugXepfRWORJuTo6E/tpSeDtpl+3q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghkwOmEz5b1yoj3MSD5PnbFFL9arA3q3Q1SuPAIbud4B69aBWf2fzni/kNK94HMi3QReWPT2Ik14SPMmx5G5+IXDh0uFX0m/FNeinfEeHhz0S0qNY+iiPkD6Cd6DrzVmTArWOHILl8m5PW3OgKBfhQ3FCsQc0Er62hWbzDVh+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq+KvfI5; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq+KvfI5"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351832so500182f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 04:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790161680; x=1790766480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EH3XZfcX8POgQQ7VhCMA6/ybLgk3CMK1ox0kamnJcns=;
        b=Vq+KvfI5kYYnYXL4vEVzd1EDmUgLpwZqmOq1U5AncuW7pvNrdS0b0vXCB5s8wUXq71
         j4tWmhYER4n1kGvxsz4IUCAS9rUMoLeWPZZVYnR8nBAE+7vVcSkRNVw5B4IzGcypVfNf
         8SOHsnaZEr5UB7dsfR3NUpAuVGAWoCec4WHr4iwxb7jCq5QCKqetrwj/XZXbHr+VbdNJ
         A2AgT85azoPCGRnw/98pqgmDwh4DXvQyiWv+goGHqMKtG83soTL/SlNbIFvvRiCeVzqn
         paCso9uRFnYJkkwjnnjeIjvYmc1irj6/hoLxaHA6KXi8uvpXM9t2meT2yjU8C+DGOeSN
         Smhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161680; x=1790766480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EH3XZfcX8POgQQ7VhCMA6/ybLgk3CMK1ox0kamnJcns=;
        b=DlXILltQZHnIOsIPSA6CI591P/sEIwkNXo6LxBoUjkRgQVnqoBjaVyGvLs0S8XN7mD
         r14ERvo+tJQySfhuC8yfER6EzL1vcHr1Te+SZK2Xyc9gkQVDF6PDQ1Zv3zMjfg5o3hK+
         yTdlTEzZ8drRCXnwQRw1/40dmD9zJd+wFmSYtIScBGW2b1CvPRPP1AsJFMeHoJ55f1ya
         dZamQVP+AfxmlKOPPvbaqXnGz3cU0hUAQ3jyFLE12dl08NpMuWA8hblB7YJtrDPCDo1M
         d22gdAZTIooBqr3etf9krRCOPgzkeNokQjvEtPTg+Kd1ceBCmVqGWu1q+4lvuOnlSJJm
         orwg==
X-Forwarded-Encrypted: i=1; AKwUvByXhUismBBVg4KksdOfzvGTcgmDsGJskg0wTcKdjyiH7SRRKShmHfI4YmPv812DkQVHoaLTGkzQkec=@vger.kernel.org
X-Gm-Message-State: AFuF++mqZqzdU5ata2xlMl2NmR6wyPRcJNk4+E8JmutWy68vVj3jEgEF
	/5j8MnE1vs2bqtCw4zCpX5Q4zlEbERmvLjl9oDlHjqJFPPvv2uVE3o7E
X-Gm-Gg: AYBFou0652uLYlRdVkjtuT7pXJlhGh47Xieq8cPA3I5o0hOhcxWsL3ChjkmPqhxRa7v
	S7WGDc5Hh1TeDnifKwXUp3bajuVacE2CKI3lRtHzlGwnmVMBx3+1392a/2UZSH7chkKI2pB7SyC
	4qjvJI154YDstVLG9bhzYl5HvTMgia19ackFGAwIbZdB7VESRDOIIubLAQdvqeqoLMsIpqG8TTT
	v1y039oeGsPuw5KXFusVm6r7LYYXsZ+qAQNtffCvSpFMJ0xxq9FwyQfPjppz7tuRMvBZKXB3e5J
	PzAylxY+DnCnIq0Mt92Dvxw/Ip3vEQRaFFrEYOafgGnneb7l11dJDOIuqka/GpFQfOPMshsBZSR
	brQLwDOgWM29fH1R3BhWKHkADI0lxwTLiJO2vUpfejF/q0GhHsaIjHHHa/vd8MyheW6LJv1SPEd
	rzjRuRrznf79JwlPOZlf/MgIvN0+QsUMaIwS/eBFLkjaaCA+XqukJG0t1kRDhbh/3A0rk3VcLcV
	bi319D1HHIbBUKrYnqGfA==
X-Received: by 2002:a05:6000:144d:b0:487:342:d142 with SMTP id ffacd0b85a97d-48867099f4cmr4203461f8f.44.1790161680282;
        Wed, 23 Sep 2026 04:08:00 -0700 (PDT)
Received: from fedora ([154.182.121.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682676c7sm5892418f8f.3.2026.09.23.04.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:07:59 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	error27@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v3] staging: iio: adc: ad7816: Protect sysfs attributes with mutex
Date: Wed, 23 Sep 2026 14:07:45 +0300
Message-ID: <20260923110745.3836-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs store functions modify driver state that is critical during
SPI transactions. ad7816_store_mode toggles hardware GPIO pins, while
ad7816_store_channel updates the internal software state
(chip->channel_id).

If these are modified concurrently by userspace while an SPI transfer
is in progress, it could corrupt the hardware transaction or cause the
driver to communicate with the wrong channel.

Add the existing chip->lock guard to these functions to serialize
access and prevent these race conditions.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
Changes in v3:
- Expanded commit message to accurately explain why ad7816_store_channel
  needs locking to protect internal state, as pointed out by Jonathan.

Changes in v2:
- Added a blank line after guard(mutex) statements as requested by Joshua.
- Added Fixes tag as requested by Dan.
- Collected Reviewed-by tag from Joshua.

 drivers/staging/iio/adc/ad7816.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index f76f0215119a..2a15d7598abb 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -143,6 +143,8 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
+	guard(mutex)(&chip->lock);
+
 	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
@@ -207,6 +209,8 @@ static ssize_t ad7816_store_channel(struct device *dev,
 		return -EINVAL;
 	}
 
+	guard(mutex)(&chip->lock);
+
 	chip->channel_id = data;
 
 	return len;
-- 
2.54.0

