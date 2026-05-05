Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB529342C9E
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015883; cv=none; b=eigkxeyv5C8MPhLr8KdBeU10/0/Tw4KqTkXNOpw1jEQPNgLeqPvHpm+qMoxiRmSPmMvqWjbWdZHqZowWz4eeYP6k65JqKKp0J914lg96ks0/5uaLHVIpOa1+xfJQuabHFxPQLY14/cfZdjF0Xun7qRsnLJ5p31Ksj5JuH87gL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015883; c=relaxed/simple;
	bh=VEcdxzzi9yplyyh7NCGprIszz7mcuEis4Lw82RB5vAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iv+7bZbmVlbgk9SdFzZpu4m/OKy1SYIuErihRaCqpMonyyTgVo7az6Wzv2WX11Sj5dGbOkeLd1x64hAHNRd7m+rSXZW63J3KiK/uQaCx4BnUDr5wEqC1W9Ar0Kd8VSNu/D7a7beQjAavFL5KGZFxU21n/SZEL8twWwcWvMzmCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeHhZMFN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeHhZMFN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9358dd7f79so886634766b.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778015880; x=1778620680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKNijxWnze6H5T07M4/b0rxDZCAT7fT0zRMCMUE5bMQ=;
        b=TeHhZMFNL/PhnhUlxX9lmrJo2qyDnTS3YPTxk7JVvJ9krN6J04QzaZp4zXEZxq2msF
         tpbSNnXMKB23a88tsiKJN6NP1hxavqtI6GNBm0R2lsQjJtHMBhL7WX4A8K/WCAnxX6QU
         d3chq27Ygv+ikRufvc9wnhZNBQiX4oNahHI/7ResHiN8XQtuZT/FLPdtFnDY+tedSgGq
         IwLZswakfAYkZiFz2xPnRpdpJptRCymzU61mhA6sNulXzEiZlqp3r/Us+7Q/m59v3R+x
         otDNo+SlRsfY7DfD7ILOPSJjH7NFMTmBLfIXNSYJyTLDNhZx8d9+dmfbqA6yuwsPTgxB
         qegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778015880; x=1778620680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKNijxWnze6H5T07M4/b0rxDZCAT7fT0zRMCMUE5bMQ=;
        b=s46Uu70XY4cnlzbXh4nyUA4aOqBsK/laGV64QmmbZbMRXHjYifNUchHOwRtS3SLFN8
         KhTiFnMba+ThtqEVGXL5cf5D7x0iOzs9KVNult8pC2HhMNNn8lykuxVPd315VqSFM+Lz
         ODZ+M7vRtOEmy+J02l/9vdtyEX8FG+29vvw+bZd6gacnmomUxX0yO77AmEK+VooDTfi2
         znbGsAjZl0mIUO2Pc+77BnEHI/IB6/SK9QxF/x++V1h0pm2R4dh8OcbKnzjodJYJAVEc
         DAkiLfVe0V/QXp4o6FGnMG0pX5fk5vxhCcmGruVI80HtAXZ817KY2K5/f9943G59Qmu8
         YezQ==
X-Gm-Message-State: AOJu0YzFAqsus7mA8w6ZFxpP9gHSHAzmxJ2RtJVCHyyrmmIP5h2SURMz
	bLvCNZGzv9Yy157PLHsOzdBYHdE8W3Q04y4hA2BP+YcFeBPdcnGDI9X2
X-Gm-Gg: AeBDiev3UyvnsijpVGRbaZBSwvs7wX24ddK2vEliw3J4KRYjrLbZp8f52CcDL6Dx3cT
	ttFkOoGU3Pa8ylNAM43wyRoqRTCKRDTMQsonZHMNXm7D0qqcyzDSBh5S1yNSKTNCVIzS+i7CrB4
	EgtE/WzuM6k2rbFXW97BXgnUCQBtSkUfXSdxtu3MZKADD3/ucIVJlUQ+C3Z3gufCRUPG8jDsy5J
	Jb4TiPkcVuT2t7smz7OlUIlopIP8IrdrBNtSgXOfAWZ39iogdRkxIuZpHfqfBljdaQH/COaZkcv
	ljPwkBLxUuZ1Cz2IuKYup0q0hrYlctKCE0r51OnagFHzhruzgTRq1bPk1oo8KAb2QaBUcbfinhs
	yx5TEMHWh0DU76qOEcGF9AKCM8Fu87obFRnTFstKJMj6oSSf1QbaNsxbWr4+tmUkKwNVCSHgr4A
	l8Dze0iC9kvt7Ibea+9afgYLJcp585wCPDtIzFrK9oTjt9GxR+
X-Received: by 2002:a17:906:4787:b0:bb9:36dd:cd3d with SMTP id a640c23a62f3a-bc56ae2ca84mr10973566b.4.1778015879800;
        Tue, 05 May 2026 14:17:59 -0700 (PDT)
Received: from localhost.localdomain ([196.235.155.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc55b590924sm7879566b.21.2026.05.05.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:17:57 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: viperboard: Fix error handling in vprbrd_iio_read_raw
Date: Tue,  5 May 2026 22:17:50 +0100
Message-ID: <20260505211751.102563-1-salah.triki@gmail.com>
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
---
 drivers/iio/adc/viperboard_adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 9bb0b83c8f67..14d018b5aa33 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -72,6 +72,8 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev,
 		if (ret != sizeof(struct vprbrd_adc_msg)) {
 			dev_err(&iio_dev->dev, "usb send error on adc read\n");
 			error = -EREMOTEIO;
+			mutex_unlock(&vb->lock);
+			goto error;
 		}
 
 		ret = usb_control_msg(vb->usb_dev,
-- 
2.43.0

