Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6225275B03
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787384221; cv=none; b=Ro+hwfeO+UKqRclFlsZCtvFCt/eW+/BmyJGiIFxmh0Hrg7ds+f78uGMy3nFmq2kK5VlPI+elwdOdFTZyd/uck9p9t2fmmDY4up+VZKpw/u/ivTESvNf+mgn+gpfYeTiDzTmJ4iHY8pe9wHrYwmpdId85eh+2Vd481iXqTck/zH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787384221; c=relaxed/simple;
	bh=JP/ICKziAlQRxyOXVD8jmCPTlqlx8SIwSwVOqiEsO+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G+NGIrf23TctWJXY+PqTw1h4sYgV7033i/fN2w5Do9kG3wCED9oynvZ+/RLxd5+/lxDtUNSGZ+QE4ya8lfIKgJtavzYqtKhroifSuM3gNJ0vTqcCt/Q5r7CP4hHVcS7LTpMd+wdI/R7zraHfRIkLq8fr7QJyYiTdW8J7UYEnU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he6/oqAn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he6/oqAn"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c214321dc32so352763966b.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787384218; x=1787989018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3gm2rqy+lf4IbusjJqM8ChRMey6WJ6UyvAI5pxVcqLk=;
        b=he6/oqAnFtn8PpUP5z28WedAiIJ52Ky4DTkS0NPhna7IrSK9Z2UTza8XEg+2kGoEt7
         xCbYuDvhXSkuii5WSZyJ/KDgihgywWT24xzd27+zVt6wXrPFnSxHQXJoy4T4pETl4J1j
         YHCMf0uZYvjQlBJfuFQZTyW7PHY/PGbdo2B1PRulERvLaJ5a6WrRsu5eGSt/kj+mFrMp
         hurYL/ezWIe4Zzj0A52motYZLYd7kWZFw5FsC5xEzki3fXBnQ+lEkL0RXWptRr0WpPC8
         fQKSxcJmZTePaVvLyj0FL8b3z1ErVz//TZSrWuzmBqE9IIOVB5+TsCcbyRIQuJilfvtw
         ICUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787384218; x=1787989018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3gm2rqy+lf4IbusjJqM8ChRMey6WJ6UyvAI5pxVcqLk=;
        b=e7QHMaie0DKQMGhl/XQrIqYZybrJAyQAx1LAYva38Kq5Tfyec5F64wlOSBIzbm0Xar
         r0zm3pOcom3UvzlIj5IwBrQyLo5yaK0C8yQg9r4OKmbi4jtanUaaA+0/7pPUiB+b0mNY
         b5ap9MKClXYHuOTA+OXnZxlNIPlvJRD92sfecrBULp6VyIARPtJrtqge24p02i7q4RbY
         J9AsbQkOxKfpgev/n29se+m2/eZmvtZdbt7xScFUscYUYHaGLEjh7Z268RMB8I4f2aFW
         +uEfTqV/TJLwF/I1tUIfGZhz0gwl/TrpxuuS3xH0pTPX/MfKWx0e4UI7BPwOrRNJBDXQ
         8hgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr19x164dklyMl0pi6fb8oezuQu12kf34rjZOiGH2g/q2BiK9CHTcu1hgSVB5neIDpz48g+kuxyOl8=@vger.kernel.org
X-Gm-Message-State: AFuF++lfk11WPiGpxgdTsD9R7i+Unmx53WavLmJEx1bHct5vl+NrCmzT
	Yk1ISzrphaEaxmXn6kmN5zSYAO9UEtYONOgfcD/2JJdpHjAQe4SoIJBN
X-Gm-Gg: AR+sD12rH6elRRW3u9ihW1LAbp++VXTAqPYhX0vhzd9gaQRM7ROdlpecbUjz7wU5uIv
	RtjISkva8qaz5nsKH0Qyeg4MclSnaGzr5AFajCOYXsCTJZAYl5hKRkQlVS/iCULwvHely3QGQmi
	Y497KdlAnYFGVeNWU/lYmHkffkxOpshwMiIW6i3SKBvMpFw50gHD1M+0jEVOdONbri0Sw/BVDt3
	5YE/TPrIyIQdMmftpaDPhm1ff9BfX+5ebDF79zAQz2jwQv/C9dFwF7M5XR3TCI+kNHX752NMk+v
	iLLLiB4AIv+8gmwMUW1vf2jzy4Etph3nbIcP51QHrZBajUfU1lI2dgN8eLepds/90FWvqvH/yUl
	nffn4fFm8s3FR2lV3VR6VYhbyfYy00PlTc/GNk8wL0aRHK1XVVmaK2/e38Pfit7ZtSzl5ehxuYr
	dPSyxpsdeGt1K2AEdXhXLOcqjZ96WTFTXXzA7VwPv1to3L5LBwne/WX+/92Le/lB0GP+SywIwKY
	8DdvDctUbKp6igf5/bXPBq7VzDHAGIyAUmyTNOKqTC2P2OKWBK6P91tlIn4wm5Yuc83j0wV2X1y
	atPKrsAUyYMU9gxJ+79EypBo81ydSj9AJQ7Me+r02ujDprV8ojjJdk0yBtCYIbCQTWybkjly78f
	xNgME7+zT
X-Received: by 2002:a17:907:97d5:b0:c19:45df:1856 with SMTP id a640c23a62f3a-c246a675873mr1190754066b.17.1787384217744;
        Sat, 22 Aug 2026 00:36:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b208sm187084966b.10.2026.08.22.00.36.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 00:36:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: iio: Correct ADXL380 filter descriptions
Date: Sat, 22 Aug 2026 09:36:53 +0200
Message-Id: <20260822073653.54545-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The high-pass attributes were described as low-pass filters and vice
versa. Correct all four descriptions.

Fixes: b6a097a9af00 ("docs: iio: add documentation for adxl380 driver")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/iio/adxl380.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
index 654d4c0e84a19..a1c249dc2e51c 100644
--- a/Documentation/iio/adxl380.rst
+++ b/Documentation/iio/adxl380.rst
@@ -39,13 +39,13 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
 +---------------------------------------------------+----------------------------------------------------------+
 | in_accel_scale                                    | Scale for the accelerometer channels.                    |
 +---------------------------------------------------+----------------------------------------------------------+
-| in_accel_filter_high_pass_3db_frequency           | Low pass filter bandwidth.                               |
+| in_accel_filter_high_pass_3db_frequency           | High pass filter bandwidth.                              |
 +---------------------------------------------------+----------------------------------------------------------+
-| in_accel_filter_high_pass_3db_frequency_available | Available low pass filter bandwidth configurations.      |
+| in_accel_filter_high_pass_3db_frequency_available | Available high pass filter bandwidth configurations.     |
 +---------------------------------------------------+----------------------------------------------------------+
-| in_accel_filter_low_pass_3db_frequency            | High pass filter bandwidth.                              |
+| in_accel_filter_low_pass_3db_frequency            | Low pass filter bandwidth.                               |
 +---------------------------------------------------+----------------------------------------------------------+
-| in_accel_filter_low_pass_3db_frequency_available  | Available high pass filter bandwidth configurations.     |
+| in_accel_filter_low_pass_3db_frequency_available  | Available low pass filter bandwidth configurations.      |
 +---------------------------------------------------+----------------------------------------------------------+
 | in_accel_x_calibbias                              | Calibration offset for the X-axis accelerometer channel. |
 +---------------------------------------------------+----------------------------------------------------------+
-- 
2.53.0

