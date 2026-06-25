Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC827AC45
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364848; cv=none; b=R8lOnYo+RmP6GYiiVLlY86osKFriCNiItB94PdVnGUKNuXnjjdepbOfcwf9RXtT0SCktwGhpcONocMPy+rrnkUK4/8bXqwpFbTwAhtuyyicUj7wy5mGaAnzgVmjtY0LQb9nZwxYjEVW1hhYMDvs1AK4g7OxgN/fejnEJiq9WW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364848; c=relaxed/simple;
	bh=KOqZdKGtxoMMSfmaVYmRiK9HGme/5iASjAwyOCiE3Jc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FNbPK1YHSiLJM0Pab48TwTD5jDakn3UZvdaPb0wProGblhPtJkgxox/L582trIMG9nUdkVtX5Y977qdNQSjowALlL5ueZKP/zHRb8iwrzclkk1UE78ofWu57qbWT/B+g6tqpvWnXZGjtYD81GWfWZSHKbzerVkqBGONpjeizGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm3OKGS1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm3OKGS1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so17802155e9.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782364846; x=1782969646; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9EoHSz7iTnkdIVLi/rSr/vPJOyhbmNHXxKYUvpfn0w=;
        b=jm3OKGS13ECET38aLpTOTostb3LfBXV0/8EK+Hsx9qa3AV52GAyfQaL1QZxqczKnsI
         oJHX48f6cGDOdSvTcPP4tBCGMVfodN3C4pdoDPDck3Nf29WXiCFvhyVaO6KCukNqwn59
         S5kZTl4TBhWmTddeRSl5LqO6ua0mcsgpoTUDDy8aNzLYA2GnGSJcYkrqwx+EglBnbTZi
         nElGFxMjbXcvOhuXG3ZLmw3tD9l2P215yYuNqYOncFD/PbrMUy+oeV4XBcC4RuaW26N4
         wNvdKYzVolQiYznsx0E8RbI8ZGOysAb5WjVXq6kFqkk5CujzlLhPVA6lJq0k/hwU40CL
         RiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782364846; x=1782969646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9EoHSz7iTnkdIVLi/rSr/vPJOyhbmNHXxKYUvpfn0w=;
        b=qzHoWyf3zF15XlkfdDAadLDYYu1EPcfQ4db2jyS9Ro3CZHKK3puxm9VIbFAfhYgoxu
         1JlIoeFqY6GfAwtmx3PDW7LUhCItXkFpvMLFcGtoXf9krh7WAOggYc5BFImqhjJl7DzD
         DBxU9kCcBYrgGZ371UtOC48nNnrvA3l8IeUTwslz4fCZhSHGIcinbrNnX2TYwFc2+moD
         0glqldG3aMZCN05882pA7ldf8R6BZxFxI3pvlpv1U73aAqbk4ZAQVbIaB8cWtP6MOuWR
         WkpUk1XcDlVJHyf/y5j8CcPMBWiVBXBeISaMKiTTF7nKGa2zsJFp1tb+r1mGMc9K4x+/
         Y9Dw==
X-Gm-Message-State: AOJu0YzSTl2hqRQD9elywZ0K99bzkPCtQOzbTnbh/jRskv/QKqFsJQ8Z
	ClBEGKPw7JfujS/7YWBOGwjLuGkuyj9mR58mR9WpbeluKUgDHKKpF/ty
X-Gm-Gg: AfdE7cmBMHNKSdVi34y7BnceY30lEgcXDENCPZ+wQSADxPVTfzcdoy7ohE45dQZA91c
	pRE7eql3bEDrg04FIvmytUPzHzKiz2N3BzomHn4op5yTg+bIYIm5PbCo9Rx5fIme9SM163tOAGK
	OfN86k02IR+zy7A8OJ4pCB/G76HSt8Hxbk+d3DIWFMv8fuPI8F9P8qotlASLdu//Tmi+S7VanG0
	BrkslOUKCw9A+08HCbyD2XMZjWFEdVUJaj36tnTlKEIcoYdFs/GhTUJh7kBDqFltXPyfDoiEKAm
	ONWJFZGnm+oBWMV1q+fS349Mucd6SAArp+JUFrwLL1E2K0x13XYD5h0JRoQvXtnqCHCjMj7aoDX
	nqxtR7F6bj5pBF1xkreEqIpXto5XPtF422Ax6VIupmaKp49J31ojX6gl2jGRAZ3N4OnWmunNs9V
	CaIBhIX0yoPwf2S+b71zTzIVCnmJ/42820V4ocE6ngC63sZrG8Sy8U3oD2zvUjTuCNvn5o+HBIy
	Lv8UZtDlHW6UHMwjCt/cUDa3W/SPyCZQ97nAi6zOg/CYKe2EYlDMKIPd6/MolaXZbCFMzbIKP/I
	318iihcpYQ==
X-Received: by 2002:a05:600d:84ca:20b0:492:3fb1:e9b8 with SMTP id 5b1f17b1804b1-4926685bdb6mr6159595e9.12.1782364845610;
        Wed, 24 Jun 2026 22:20:45 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660a32ddsm24966165e9.1.2026.06.24.22.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 22:20:45 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/3] iio: light: al3xxx: add missing REGMAP_I2C to Kconfig
 entries
Date: Thu, 25 Jun 2026 07:20:42 +0200
Message-Id: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkE38tBXooPpWkthoRCC9Pek4
 8DMVMichDNMXYXEj2S5YgPdd+B2GzdG8Y2BFBllaMQgBe05lFLwcFcMsqH3qw5KWTJ6hBbeiZv
 1T+flfT/miZ8QZAAAAA==
X-Change-ID: 20260625-fix-al3xxx-kconfig-ddb1f00a2615
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782364844; l=792;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=KOqZdKGtxoMMSfmaVYmRiK9HGme/5iASjAwyOCiE3Jc=;
 b=ML2hodOuOeoYE05Rx8Qcv1eHNlGikCO6zpodkMrkPT8M3kf6zrFCPYot1NZqLbWid3BPwRBVG
 NqrE1Y0JnC1AOb7JwkuufVdh28FMV4iQebpQg4x38qDFydF7hvOJmTb
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series adds REGMAP_I2C support to three AL3xxx ambient light
sensors that were previously missing this dependency, causing build
failures.

I made a separate commit for each driver, to ensure a proper Fixes:
tag is appended for easy backporting. Let me know if you prefer
squashing!

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (3):
      iio: light: al3000a: add missing REGMAP_I2C to Kconfig
      iio: light: al3010: add missing REGMAP_I2C to Kconfig
      iio: light: al3320a: add missing REGMAP_I2C to Kconfig

 drivers/iio/light/Kconfig | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: 7667a80340e99fd45357d0c90ae05813b01bbfef
change-id: 20260625-fix-al3xxx-kconfig-ddb1f00a2615

Best regards,
-- 
Kind regards

CJD

