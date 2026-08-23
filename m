Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567043B14A7
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523920; cv=none; b=T1+DMiAvRD2TcAXOM5E6RTMDjnmYJuYQ2MZa3gVu0xXBC5xmT4DGu6+37SpiD0d72/KT/EEnK1Dw8ToJXNxPmMNPHQrevIDzctskPdVNnpaW+fs++jpixA63QLGlBQTzMzQ79zw/dtlefCGIMSuyPEpNBN4R2i51jw6EhsZQiJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523920; c=relaxed/simple;
	bh=zPbl522A87RBBXfid6jSRrxEty3ijfh7LPb5mCD7nIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C940o7UaGr8AvQv0n5vqanUPwyBEser1IdpBq/b58hnyjrHOf3A/0DYCqAswLnGioZnN7Izvyh7DSrEfvv7m3/8q+PUrT8yiWpo6A7S93LmOZJydvK0KHxuxTJWetj6v/B2JdHfCMOEITpyoX6fYJnaCd7MlUOjdrdY24U9r1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esgy0+ZQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esgy0+ZQ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3785925a91.0
        for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787523918; x=1788128718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ExUtGNj1FKQ16DMbtZN1/vtaJkb2XpxnhtfBJnLYyYM=;
        b=esgy0+ZQP/t+qDfkcFVOOzQ6KavH46zIWURakeUuWr/9R1y+0PciQH/IN8aH8kCkij
         ni/oSKnE1Qey6mhuodkxd+dVfGndObQT4+hOu/VLcR5oSTatpTzDmR9Svc9u654rN+8M
         1s5mXC5NC/wncIpdwFzzLLT6Jy6Lswav13a7Jc6GrdPmRkBS27p8b9LjQxhCLgqxPgke
         drROLyidA3EHnHPpCd7BOlau/hHUvlr9q+Sp6YQI9cW9RGdvtGejbJmBU5uU70jVnEBS
         hNkGwtOCkiWYagADNk7RjLaB7dwrQZW3y4tfGHheeY+sBEbE5ZRmZrbNWiQAjfBoXWyo
         jj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787523918; x=1788128718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ExUtGNj1FKQ16DMbtZN1/vtaJkb2XpxnhtfBJnLYyYM=;
        b=OISlU/wOemxWGgZhKCFizyDGW5J5fDXtbRZL3By/lVrlIHdf+gzkdFQzQQI3mTZI+r
         UgtARzlFaSO40So2ljzz6itf/RStLHPnl8RcZluh9O6b0+cUcqA0xziINWIl4EZgYAHK
         PFoROTqXKg9xoEi51VJ0OgsTaK995zK0QVdvrQJ6Tkubce4ONWPsuAxwKDR4cDajjAwg
         ZnXcHbDwKJeNjpGxZDY5xb8F8h3ApbMzxtbHUN7fJMn92+8rD3OEe9P0TWnLr4dQXhUs
         +RFy/TcmQmkEK2RVBXDlaRH9cnHTJ3Q1Rf8uctdl00sPpdEIHWbmcPwx3y/q63y0ED4p
         Uvlw==
X-Forwarded-Encrypted: i=1; AHgh+RpM1xK+AyeHPArwIwTfkbGEjcYhyI9n7hfpGgCgqQJqLSs+2Prx3WX2SgJdeiWJLe/o9xT/BXCPAUs=@vger.kernel.org
X-Gm-Message-State: AFuF++mxQ6YRBvT7KJEXMth7NAZ07V17YaN7QNHEJCFC2NBphtkJSPDh
	CzxQN8J3Gk+/iut1BkZfZRTdMdJQJlmBEcbn+73hP73L2Omhyl4AIfIj
X-Gm-Gg: AR+sD111dK573m8yjNfhljoDSsQNmDLj8NTbhk/1TlaMArWxoMFvzecH8VpBe2fAbIk
	3OgrKZQoQKPqXq70CPd58Q6pr7YgtMvDn3XlOUEjrY3ZlwR2rmMFE5ZZqopC858SxVhXdFGvCsh
	Fq2eFLUpx2Tv9XkHYtgYIg7XeCuoKmTBXWoRxQfVULmBNmMzfl2TZVb5RwgwLAIrO7RFJJTgygq
	tDzmgycd9+tonNAs37ANFN24L7rWe7Bg3jwalVAAq7V4TGBSP50BhijMExrEcwHcqQ1KLmcdaAj
	fNkXOCTMCVRM413qAL6c0RtUduN0BynTbyWSKIlrRrcBLPPffBt01HkklUQ88F1Q1XkeD9KK/Gy
	GbC93rogzzP+WTCiNOn1gxWNJ5qS3aoNJJ7xmo8bgcEqvsJ73Qg/PsyTL4wzSFFt3Etyi7dsrXb
	pUSHdRiUU1nc4OSFoL+O4Sg3vf2ZAGGrUGzdDe4UQBAuPcHARaKKtHq87ELTdMkCmjsU/6dHugb
	zD7fcJGWj7T+C3Mw0JYSMPLAfbDEVYr/7KbdpZM4JjvCQ==
X-Received: by 2002:a17:90b:390f:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-395c2f29705mr36385924a91.0.1787523918490;
        Sun, 23 Aug 2026 15:25:18 -0700 (PDT)
Received: from ubuntu-vm.. (c-73-189-122-63.hsd1.ca.comcast.net. [73.189.122.63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f920e0ddsm18183574eec.24.2026.08.23.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 15:25:18 -0700 (PDT)
From: Rishab Madhugiri <rishab.madhugiri@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rishab Madhugiri <rishab.madhugiri@gmail.com>
Subject: [PATCH] iio: core: Avoid BUG() on invalid clock types
Date: Sun, 23 Aug 2026 22:25:02 +0000
Message-ID: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated use of BUG() in default switch cases of
iio_get_time_ns() and current_timestamp_clock_show() with
WARN_ONCE() and return correct fallback or error codes.

Signed-off-by: Rishab Madhugiri <rishab.madhugiri@gmail.com>
---
 drivers/iio/industrialio-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 767a7794624a..c0411a29fe3f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -341,7 +341,8 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 	case CLOCK_TAI:
 		return ktime_get_clocktai_ns();
 	default:
-		BUG();
+		WARN_ONCE(1, "Invalid clock type selected for IIO device\n");
+		return 0;
 	}
 }
 EXPORT_SYMBOL(iio_get_time_ns);
@@ -1518,7 +1519,8 @@ static ssize_t current_timestamp_clock_show(struct device *dev,
 	case CLOCK_TAI:
 		break;
 	default:
-		BUG();
+		WARN_ONCE(1, "Invalid clock type selected for IIO device\n");
+		return -EINVAL;
 	}
 
 	return sysfs_emit(buf, "%s\n", clock_names[clk]);
-- 
2.43.0

