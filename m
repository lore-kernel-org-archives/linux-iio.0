Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866D33A9DE
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682084; cv=none; b=NuMox4l/r4Io+LH0qSc+Wnrpicw6a+KYlf6RnGkD9zWFKWWR/aJc/4b/MT06Z984uRxGHptPugxeq8MvHcwOpZgItx2wcDKmo1RHcBTqXC7OZSOUg+cZi3fQnDeOPRZjy+ZZZp3R/UPGS2ZORyRWNLpJ3fdxY+xJKFVE2NWhLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682084; c=relaxed/simple;
	bh=UH3kb4gt0+9ZpweWT40BehwDYP5y+PKMX0nK5W8Jvnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1pbODdP5oZFTxg4aCJOA2gZAXiTc6Tuk9H7aGaPPIxtSvYRwT5BghITJGFhYbbKqZxJggma6HqvfGvXy9fqDIQsIXcRi8DK8XIIAinCar3UZ8I77PwjeQiz+8wrisd1owddgd3Z2IE/pQL2ygDEV3Sye+fLKanJdywellvgAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ninh1NOG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ninh1NOG"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82a124f3a5bso2545972b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682081; x=1774286881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5vDax/ZtqQf5s3e6+BhsYeXroKNvJZuzGVQzpGYaig=;
        b=ninh1NOGYG2uJjA2X3kPT5Iqg3OWDZ4AUnSQtiKukHPtCPvcgNQCrm6jYZJG0Q+0W0
         qJgVST2QwIP8107jzBU4ZiwNlN4v5YIxC12yXvs2vP2BeGcNaAfPu7KbQRCV4x6mcg1H
         B6VsbH0S4yVAG4F0B1YHHmsqwGw3pzTbkiW6GSknQ9UOIaEE1orxCeQZYVcD2tg9/szJ
         8JGp81JzNptxW+4eB9AkdbggmWhKwvvgdwc0qNddbmILs2yAmMDF92Z67Q6OPL9huEwF
         e3yyjORDiKxQZIr8fNNNyBUEGBcPZJzCd9O+nvKq6litNMFz8P5q7agtIbTCqnvhuRC9
         wthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682081; x=1774286881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+5vDax/ZtqQf5s3e6+BhsYeXroKNvJZuzGVQzpGYaig=;
        b=Daig9H14n5kJY/wRDd6OF67a1bPdY6djxP0m3ZualiTjc789lcg5MzYtNMpw90xk/c
         lqRYyjgDzoaNP+4kljjSNOG8zOj8aRpDm/emhvH6cwzFIpC9rZTUmfwGENDz/pkJrFix
         0p1NTJjO5lX0dUCfFANofNOBQDDuIkP+eISw5DOEIFj+Nx0qaGZ6M+GmCw82URFqvENS
         wyujRgXEfbzkPkJXs5XW9Kdkwiyg4oxQ86XWkGBUbZty3/DIS1L4VdqC2W+P/LsOGQqu
         cERsLeCdwOyz7c56aQYrnN1sFJ/hFyk7nhbPqGaxPqDkDk56ffetF1zeTp5+oRMpMXmx
         6dng==
X-Forwarded-Encrypted: i=1; AJvYcCWs3XgtAqKD1Ci1UqqB27BEdbe7l71TIyKsVymX6nkYYinn0NnYZ6w5ncTn1M6dfc6w8fouElManhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS3BauY8/SyMxCUMUPM/ZaNEmaY6+ovLrALJNNsbCylzD1B8K6
	YMTAsPXmUodZt2MS3NdgvTF4JyU3Oj5CxfSrxEuNk4CYChyfDAJLcXcF
X-Gm-Gg: ATEYQzx+v1reeJUAuJmRhHWWa89Jmxxjj2hz/vGvX4DDZaySkbsSEHkJ784AhrwzL0+
	+idJBKGBLDvHlzwDtJqRaXj+gMB/PLKUQwGIW8JrDRW1QfeJH9JM1UJxD7mRR20zxrSSwvQRgi+
	C62C7+s4XOcOyf0imuHiUNLsP7axvKeW1VlCm7wMl3U46xAqfh3NOG87lwDqJexSrWAQ9JPSPlW
	cGUP9pqhZ+t3UXWPbONcp9yT1X+OJ0h7m7/Wqc6yZMZbQ5VixVUFkn6g+3D7Z8svrtz3EbZM+hj
	U/78SrtiL4q0wzMX255WMR00H2h1UrBsVxmd0TIzX/BAcrayoL0+6QEOcqxQr7ABHvAGJ+bFReK
	+HAYQVj0HqJPOT8TTmCOtUJ/3gv8U5W2ZfGZOpdOHzN/eqeNWkPpAD0a5B976jA9kWukslx8zly
	xX7+ssSZFjJM86T1tO+zuO2e6SASYFTPcdf85aiCzvWH2c6xW7v68fMk40gTzRyuke2kLVcdpzs
	7txAp0GcLij7u8=
X-Received: by 2002:a05:6a00:6c83:b0:824:a8a9:e08e with SMTP id d2e1a72fcca58-82a1971e570mr12324931b3a.14.1773682081004;
        Mon, 16 Mar 2026 10:28:01 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:28:00 -0700 (PDT)
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
Subject: [PATCH 00/11] iio: adc: replace deprecated iio_push_to_buffers_with_timestamp() 
Date: Mon, 16 Mar 2026 22:57:26 +0530
Message-ID: <20260316172735.11430-2-atharvd440@gmail.com>
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

Hello ,

The helper iio_push_to_buffers_with_timestamp() is deprecated in the IIO
subsystem. The recommended replacement is
iio_push_to_buffers_with_ts().

This patch series updates multiple ADC drivers to use the newer helper
API. No functional changes are intended; the patches only replace the
deprecated calls and adjust arguments where required.

The goal is to remove usage of the deprecated helper and keep the
drivers aligned with the current IIO buffer interface. 

Regards, 
Atharv  

---
Atharv Dubey (11):
  iio: ad_sigma_delta: replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: ad7766: replace deprecated iio_push_to_buffers_with_timestamp()
  iio: adc : ads7950 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : cc10001 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : ad7887 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : hx711 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : at91 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : ad799x : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : adc161s626 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : mt6360 : replace deprecated
    iio_push_to_buffers_with_timestamp()
  iio: adc : ad7944 : replace deprecated
    iio_push_to_buffers_with_timestamp()

 drivers/iio/adc/ad7766.c         |  4 ++--
 drivers/iio/adc/ad7887.c         |  4 ++--
 drivers/iio/adc/ad7944.c         | 10 ++++++----
 drivers/iio/adc/ad799x.c         |  5 +++--
 drivers/iio/adc/ad_sigma_delta.c |  6 +++---
 drivers/iio/adc/at91_adc.c       |  2 +-
 drivers/iio/adc/cc10001_adc.c    |  3 ++-
 drivers/iio/adc/hx711.c          |  5 +++--
 drivers/iio/adc/mt6360-adc.c     |  2 +-
 drivers/iio/adc/ti-adc161s626.c  |  5 +++--
 drivers/iio/adc/ti-ads7950.c     |  2 +-
 11 files changed, 27 insertions(+), 21 deletions(-)

-- 
2.43.0

