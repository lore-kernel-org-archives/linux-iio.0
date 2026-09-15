Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB93AAF60
	for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459205; cv=none; b=SQDmT/i1XIxBVKwZ8Hd6yWLPuPrVVQ+0fWuaD2JGzfGVHkfsxdZSJlDpwPLOu+f25d6S9OSc42Td2o1ix+CnhSUxGcXnfOEu7dcxqt9GdIYWFDRhVUG77Rhosh3k6sSwQdoFoOWP4enwj5i6zKkFXTAf7D9ILA10wwXSlFmqXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459205; c=relaxed/simple;
	bh=GILNLQIt4Kvkzuaw/uizZLn8SlGgfvSI7pdRyWR4a7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9F35MvZDh3gu/LJ7egCO7tuXVLw5VS9jFqa0yPMT6QrfdpE5B7MK03qkoHpmec/Yh0xw8Yqx0VFde73w5XLLQEMaiIQD0LZ1WfRjXyIsi0MNJPJ+LRyso1qmJA4BHoQsIHBrgweavfvO9I9KiD5VAXkhljIGo9FEYvzpKdrIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXntUWX/; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXntUWX/"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so7837f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459201; x=1790064001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0lHkGbv3xQAD2AcFEaHFNC5cNK+7NTF1uSPhL3tTLDI=;
        b=eXntUWX/2NmuT3oyAmiXdtbNrFyaJd6PdR/1zXy2C7vDVNy5Vse7rOn0kNBA9pIb2u
         tUf6Sjq8I8VAD4sb8fLcJDwh6P+9+F87r8bUkVRMzEnHUX/GiiRE2uu6F0Y0dBrwKXTA
         njksgifG9qA4RLuTsrcP0ylgSRZ3LsIP2q94UDv1OJSx6zB1cu8YoknSPL6c+lIgz+Pn
         N8qNLs4js0ZLxy3oBVVfu9C2YKPg9Gu115xitO6rzN/r1ZJ+50xJJNey09CjudjdtW0V
         XD3nTioCTbgoRBl678as7e5NpnYVAVbNDqPavQ+WxZKZFds6u+0BaGa5D6WpfXSKqUaS
         8UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459201; x=1790064001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0lHkGbv3xQAD2AcFEaHFNC5cNK+7NTF1uSPhL3tTLDI=;
        b=FthU7X3mn0reerbnY70ZaJbhPYmgSqOKj1ngjwFrIS73W7nzzIY+lwjsufnf96Ew//
         1PK6ysvxQ8K3NH1tPzjIFo/JDpmMuy7hjSodIbNW13a1JNj3otMm3lA3UeI3X0VKSN/k
         h0xh/NkKcxi88iMImN0a2ucgHpo78fJ+QijfAITItWcqmTAkH8bl1ShuVpMvEqHs0ryN
         3tus0fUFpuAq7r0wVKsFkMkuMOQ1OFhE55mbMElkm2wtNiJPRrT4bWRzon63Pk4ptOOE
         LzJssrFhuYcfdtwYt07bi2c9Uplme7Bg1pB3zINEE3uO3jXRnGff7kW7h2beye+VfaLb
         5mMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkvGpvp6qVa5U/HUnmgshAJHojPbfngYC/1FoSRfMvtV3FPm5K+TSQvuvo8T3etwlySjUgG/SdaPQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l6DT9NxJCj1zTOAv9f9cZ6MSy1tLNb9XhnW06rLHtaHnECXLCO
	S5PwrjN9oGHxmTEtcLw7Ycioc5Z/IlrewGxG//l0Qls635MYv/hhTAwD
X-Gm-Gg: AYBFou0IyF6ciLOrkdv0p4K6WBI+4BL2sH4QT+wrD1X+BmYB0mpG6G5/4ihRs8kH6oh
	jj/H3fOxnHoTadZgd+uVFE/ZwxX4jpEmakS/c32q4pIbfWQ60Q6HPEjsvtTwIbG+NXl7anEfKEV
	TMeUGx8sosarjo4l7iaxDolvu/jQ+OhYmWll+Hu1rX0qRw/7fDnkHfZYQpIjBKbjF33rn2Iid90
	Guxp09jNrbKE4t5qYMmK7EavFBJszp32BXEfJlIdFwGcMmXPZpU7tkq8x8zjiGHzVrHrDQmB4vZ
	xM0Rjnv0wJjR7yXnD1cRmbhEeYRJlys9DWW5ke7lPjqCDXTAamV4HIZQrthtSgg867soVU0kNSF
	i0tTkIo1SuJKfm0e91DxxEeCT2yIX6RBjeIfvVOzPK45fwafuY9XMPtky2CjD5azM3u3Jy/vA5z
	KYcdf0SmBWHKwIe+co+cM0OJIcMk2i3mjnayXdMzaCKdQdXxPjAAVMnOHmjqTUiTLmH0dTlhNHF
	edK7Y0up4xv4xdQpFY=
X-Received: by 2002:a05:600c:4f4b:b0:49e:70b2:66ab with SMTP id 5b1f17b1804b1-49e82176603mr1629885e9.0.1789459200433;
        Tue, 15 Sep 2026 01:00:00 -0700 (PDT)
Received: from fedora ([154.182.99.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6bf4desm64112155e9.15.2026.09.15.00.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:00:00 -0700 (PDT)
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
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v7 0/3] staging: iio: adc: ad7816: Fix SPI operations race condition and DMA safety
Date: Tue, 15 Sep 2026 10:59:36 +0300
Message-ID: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses separate issues in the ad7816 driver regarding
race conditions and DMA safety across all SPI operations.

Changes in v7:

    Patch 2: Moved the mutex to the top of the ad7816_chip_info struct
    (right after the pointers) to prevent struct padding/holes, as
    pointed out by Andy Shevchenko. Also expanded the mutex to serialize
    ad7816_spi_write() to prevent race conditions.

    Patch 3: Dropped the dedicated rx_buf. Switched all spi_write() and
    spi_read() calls to use spi_write_then_read(..., NULL, 0) to safely
    handle DMA using an internal bounce buffer, avoiding cacheline sharing,
    as guided by Jonathan Cameron.

Changes in v6:

    Separated the alphabetical sorting of include headers into a dedicated
    precursor patch (Patch 1).

    Kept the mutex addition strictly focused on serializing the read
    operations without modifying the sizeof() argument (Patch 2).

    Moved the sizeof() argument fix to the DMA-safe buffer patch where
    it logically belongs (Patch 3).

Changes in v5:

    Split the changes into separate patches for bisectability.

    Replaced stack buffer with a dedicated rx_buf aligned with
    IIO_DMA_MINALIGN.

Abdelnasser Hussein (3):
  staging: iio: adc: ad7816: Sort headers alphabetically
  staging: iio: adc: ad7816: Serialize SPI operations
  staging: iio: adc: ad7816: Fix DMA safety issues in SPI transfers

 drivers/staging/iio/adc/ad7816.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
2.54.0

