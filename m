Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE977081F
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053167; cv=none; b=BhYlS8DouUEn/PcJshEovF02Zw8FubeffaF7SLwWCMjKt2+EwF6BJnBpqugc3abYImi6cN7VolnFDariFrsVt3k4PiE2s5yeALj1DpVLhGM305yGA+tcMspTQi81V+td9e5BW4i8XC8zS6zz8Z4gyvfxURxKL9cJjLByFTJtISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053167; c=relaxed/simple;
	bh=FdyryvHBRJRdXkbxxxQYCw1+fYxLNFr2YAcxT1gXUdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOylAbmeDZEHA8FWSPoNWfu+Q5dxOTPh5RC0ReQrr+67uVIlqCjbc3LRbPUi4CMBW2ywwz5s9eBQLcCcO6nyqDQjLf+HtOLz0PvGp3TEg976CAbQQPfvFw4SsFmxzqypYM/GEaw0Cqo0/CMlduOZlKhnyg2llvJpIDOObx32mMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO0e59sr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO0e59sr"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829865a8471so4217191b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053166; x=1773657966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yybFQJY+DL7gT4gvHW2qlJIYJBMjkCJpoPt3qP+YSBE=;
        b=QO0e59sr7Xg0EmiZifKRGDRXUg7/FJSkVhSX1F1tMirUiyr61tOgpfj2VrNb1wkI7J
         SX3Cj1Y+jdWvsczHcZBmbB0MmXou0wtkaar1eI8/vSDTu402VeAsVqA2dde5x3hhqS0R
         Pld0xSdUbV48EvSbhQxPt9oBk1YZZs07LZEXEvCpz0AiL8RTOCjmJd9a+0RYrw5cV/KN
         dtZ7sMh9rvb3mfbVqUhkk5Tndx+s5J5s3VuifAKHszUB07PFNfGBpMoWgKRJv7f4I53Z
         /z6AwwTEX+a/1U6jj76H6NBpvbvSK7syzHzGGDrppa1FU2MfT2oK5/7357ouwvBZk3AA
         gAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053166; x=1773657966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yybFQJY+DL7gT4gvHW2qlJIYJBMjkCJpoPt3qP+YSBE=;
        b=MLJdpMboTmS6Cun4ZE2oQoWD9gIL7tEzWWt+dNxrLX47PbAwvJ6RWQBiTpsCUwfUFw
         BiV+gufL4vr6EODC0tkNt+VmjTbVwfmX0/bpuje/yl8DO3wbhBMMG2wrsYkeuTq3jzRE
         M1/SW5nybJvKqEChJiDTe7g84vx2ELtf7R9TSfT5Yl/cbwDrCSdN2IBh4irYff7AmX63
         s7wTVfjaM0kXOH2JA8ZhfdWAPe1utBs/iLqhXC5+73bJIWXhiO7xah2DVlzjbnGeVBy2
         xaPvyo8OfIRHcoCtan1/33pdKQncEyfME5WcW2ipC9WJozATvtbbilFErmimSgGmzhN8
         vSuA==
X-Forwarded-Encrypted: i=1; AJvYcCXwZCtvlHR/FkhOpebzZNv3q3X7IPOOuC01d6+w4pksNZqf5W/+d2VwPPOFmVpLaX1JMjKnjIP/EXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLnA0CCc8bpf/d8l01NwoMAYzpJfloMvjtfBRmYhkUeZ6vFmg
	ZPq2DHhDCWACbR8L97bJDKGVFINCA+AH4i73hxoeUTKw4b+PXBVqYMPW
X-Gm-Gg: ATEYQzwV15SyKW/hiObelon65Cqpl1jI2+YZ55/kJv0tziIxWz8vjWJKKdVZu+FD3WK
	eBg9qufGpz3ojdn2t40Qpmn1qhb11GS7xcfIPFXPe4FawmFXFSGlpmPoJcRHuxeG5MIry8I28kx
	t7eJ3TIvjMpf+9ePQbthvRd2HyS0nqxgAgrxwnhU4j7aVc93d385lXMepYCeeNcMx5bsC1GYiue
	O/lyNpPzxqM+ZbunI4TZ+AJIO0foUjxikOk9IYn3V++MhlKcLTTpB5vReTa+3q5dgU6DjsnGLUO
	+I+U/DOHzG5W2ajBOMVpECqRIPndGeOsCOAH5sxT1MuYHylE5bzmi2rIEywM5OPJdq4qirDws0E
	Ed7KQkLTuVnL2E7xx0eja9N0H34Sw2rOwdcfdFqvZWWTwi0zNFlMn0VmO2GeACuiT0x5UCCJ7V2
	dud06FsEIAfs9AAvXm/DiqELS8JevyYo3DEyA=
X-Received: by 2002:a05:6a00:cd0:b0:81f:3957:2772 with SMTP id d2e1a72fcca58-829a2d6e484mr10728781b3a.3.1773053165761;
        Mon, 09 Mar 2026 03:46:05 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:2ea1:a1a7:f2aa:545b:3c1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657445sm10276143b3a.17.2026.03.09.03.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:46:05 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v3 4/6] iio: cdc: fix spelling mistakes in comments
Date: Mon,  9 Mar 2026 16:15:11 +0530
Message-ID: <20260309104513.40359-5-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309104513.40359-1-i.shihao.999@gmail.com>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix incorrect spelling in comments

- becaue -> because
- reenable -> re-enable
- irq's -> IRQs

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/cdc/ad7150.c | 2 +-
 drivers/iio/cdc/ad7746.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 427d32e398b3..eaa65c4c026a 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -306,7 +306,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
						dir);
		if (ret)
			goto error_ret;
-		/* reenable any irq's we disabled whilst changing mode */
+		/* re-enable any IRQs we disabled while changing mode */
		enable_irq(chip->interrupts[0]);
		enable_irq(chip->interrupts[1]);
	}
diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
index 8a306d55c72a..cb97e3c978d8 100644
--- a/drivers/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -606,7 +606,7 @@ static int ad7746_read_channel(struct iio_dev *indio_dev,
		return ret;

	/*
-	 * Offset applied internally becaue the _offset userspace interface is
+	 * Offset applied internally because the _offset userspace interface is
	 * needed for the CAP DACs which apply a controllable offset.
	 */
	*val = get_unaligned_be24(data) - 0x800000;
--
2.53.0
