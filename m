Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455A478841
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936781; cv=none; b=unjBr27YMVRC3yUVsWNQvIGrtzP8WNMbkn7Bj04CewEl+0/xyCp2i+zTHIsj0pe7440r0ENlNu2BGcmgBiMpOGOohhrzulAsYAxUHGyuJ8alllTEJiHygtyvt37a5euAtvIsUYng0TkeYwaZYfWhYmwcUfndKeSobAawTAlmMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936781; c=relaxed/simple;
	bh=HYodwXLgKJemsWjlWqYe0putlTEDSsZ3W5gad2+sPq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WirzMDrtEOTpFd14HI/bFbJ6955zZQLOJ5NOF7Tj12oiCp2IrU5CRpR1Mu2n/povkg7XO+/VUXY47EgLK7j2h2rDP5k/jHxWk/vwVNjYr9wRJMpT6HVIS+oZvj3S7H1lDDjNQDBlVOuUfj8umGDjNwCIFs33aLuxYL4ZfeEXz50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmvRRaK/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmvRRaK/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c16ac21acso6995061cf.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784936779; x=1785541579; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gI8goOI5GAfMgkrajbg39zO5GSoNhCTqBmbPaqQ9j9c=;
        b=SmvRRaK/28GqU1kbroWC7koNm0HmCD0ipEE2afH8MCbr/poSF7EhNIkWpRKMP1tH+y
         HXwXl2667mWvJi8Php0l6Spe9xZ9jfJo7HE57Ac3MruzigfYJ5TNgthyzNpemYE1mQbh
         SWT9irzi0a0ZEhCEmO0RqqnWMbPPJYycw7ATG0ZR2Avqc832fq0OPf4rKnJD4WXB0gdB
         JdHrEy8JP6geisyrNomuGpcvevWzgaV+4hUVtuITqWr4kNUHCBUXPYfgABp8vvhJDjNy
         8YeaAMnDkxztuu2r+RB1SYUmTf/nd8CfWG1IuF6ucqcOHj0eWJU+wH5aTbXxKLfCNg8d
         EJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936779; x=1785541579;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gI8goOI5GAfMgkrajbg39zO5GSoNhCTqBmbPaqQ9j9c=;
        b=geqcQWfJ44FJgtq8xHVLCFRueIW1ig6OWQn5QY6/+aCWBj3BqkD+5UFJvnZmOmYQJf
         A+DhFg7WnzxLsy4KokFZuXHqOYB419s/+yBA0ccMthWCarORco2eribZSK7hNNnXqLhr
         OMI1mphkgjnPJKlpSge7H4PLZPUiGP+li0gJIvl+JgnApnMBOjUTdnpcfLlPx2H4PhcC
         5XqmQIcbJqh4MH2xpUdS6uwrmtj9nrg8KWc8+Gi2/mb47n3rArRnxLwRJbB0d6W6Q04d
         I8klndyWn62rTRRmQ+oCcNf1zrOl3rWPV2UzP0bjdlNgfoS71GuUjMUElZKKrx8M00TU
         Hikg==
X-Gm-Message-State: AOJu0Yxk3XFOk3bp4nAygGlJD6615abszfejdUcgzwx77OM/stTOTBB8
	SFTSC7d7AIeQIVpy0N5MIPvrNqfNM+YErX2kFObJzsWlZrkYBOuYBsj5
X-Gm-Gg: AR+sD13UH0xJ753oqT8aa2soqme9AyOxxWzQ3mW+WrDTqySVnl3idi3rBiimoGd38UR
	ns06ySTMW4tmYC99gPCJp3qQZZvDid8F7Qi0uA6r2FR7Xba8fmdkEkgsnpvwDF91+6lXkHkrNvT
	9MBKfXonInRRJmm1lwqxO1Oad6eU9cjsm41s75InpvXg8uHpIZuEC053Za4T0BN0Xj1trRRF4zy
	PoDu8BZAaxvnnYork2HYcwZ/9F0EodkRw7K6n3TkIa/Jdb/kuL3qJOiI57itVjYNIL+shGPFNbM
	scKCYIZMwYY+qumUPaEc42NtwtOK1p1bvVNVkz7pahFChSJmpTUkRNAoMfqP+7ywBEYRTZ42MoW
	fVeNpiqpZWDNrdWZjp09J7WpNQap1A0X1BrBsM6SegSGuYO9/iNysv8OFkiiNvCMGu9BuPJbgfO
	uLvmY=
X-Received: by 2002:ac8:5e4b:0:b0:528:583:a6c6 with SMTP id d75a77b69052e-529a8382417mr5322591cf.6.1784936779469;
        Fri, 24 Jul 2026 16:46:19 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e871ef16sm8957836d6.48.2026.07.24.16.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:46:19 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Fri, 24 Jul 2026 23:46:01 +0000
Subject: [PATCH] iio: light: tsl2772: fix ALS calibscale readback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-tsl2772-calibscale-fix-v1-1-00a7789f4deb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDQAxFryJZNzAGdUqvIl1ojBoRKxNbBPHup
 u3mw/vw3gEmScXgkR2Q5KOmr8Uhv2XAY7MMgto5AwWqQqQCN5spRkJuZm3NV7DXHQNzQWV+78q
 eweU1id+/cP38s73bSXj71uA8L1pvVj16AAAA
X-Change-ID: 20260724-tsl2772-calibscale-fix-0cc42518d5fc
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuanshen Cao <alex.caoys@gmail.com>
X-Mailer: b4 0.15.2

The read_raw() implementation uses IIO_LIGHT to distinguish between the
ambient light and proximity channels when handling
IIO_CHAN_INFO_CALIBSCALE.

However, the ALS channel is registered as IIO_INTENSITY, while
write_raw() correctly writes to IIO_INTENSITY. As a result, reading
in_intensity0_calibscale incorrectly returns the proximity gain instead
of the ALS gain.

This causes the following user-visible behavior:
- Writing in_intensity0_calibscale appears to have no effect because the
  readback reports the proximity gain.
- Writing in_proximity0_calibscale causes both in_proximity0_calibscale
  and in_intensity0_calibscale to report the same value.

Fix this by checking for IIO_INTENSITY in read_raw(), matching the
channel definition and the existing write_raw() implementation.

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 drivers/iio/light/tsl2772.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 244f44379c36..2287585711c6 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1274,7 +1274,7 @@ static int tsl2772_read_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
-		if (chan->type == IIO_LIGHT)
+		if (chan->type == IIO_INTENSITY)
 			*val = tsl2772_als_gain[chip->settings.als_gain];
 		else
 			*val = tsl2772_prox_gain[chip->settings.prox_gain];

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260724-tsl2772-calibscale-fix-0cc42518d5fc

Best regards,
--  
Yuanshen Cao <alex.caoys@gmail.com>

