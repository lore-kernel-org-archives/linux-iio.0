Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E33DCD98
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229104; cv=none; b=R7MTri45UqfTpUHMMvA7GFG6QyB9waQ08k4jVzCLVJHpGVWNaNjTgxFOanpiGc8W8jGI3EHZ1/mFC53sN2o2spBplt5TxiWkzc/6o6vFA1ZIqqUdbz5W1QNfxukicP6QWRzcihESROzdUCKXFb/yO9G52KOyMnsQtdhKFnU/vBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229104; c=relaxed/simple;
	bh=xtGiKjEnBQpQPUntP7CaatfwfFSBZpxu8M91vVnlSNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UDurq1SiIHd4Ni6nWy3k/oL8zuOdEqK/G7yGQAPVCgqiaUK52qlRF3bpaRbBLcSJ7hDKIVK1xIl+1vPWsizJ+XOgUIXjCzckWZaDhhPItARCyr0SZjxC5z4BODWNvyuYendMCxSi/G9zErzbwUqRqoAzfitUNUu4HAyQD0I8TeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFA/Mv8z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFA/Mv8z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48538c5956bso9359335e9.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773229102; x=1773833902; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V54kHQSlYQm1LF5g5xy9u1LvyxUv6rsWTsl/vLq0rrU=;
        b=YFA/Mv8zPgMhKIKkkqOtZ1Arczl26+uiu5XndIrDYRrspF9l+U0/hqM1HgxW9pLUJv
         iNoXffyQJ/9T4HepdCzm/wdgh9ZuP03qqgKyXUbr0aEywBXSXOsGfTy/WWQCsqN0wDIk
         eshupzR7oHMxDq4yiWvPmWX4tqKBxybSqD7o/qSp3kUPkOrgFO6/qZW87ixUA+IksBKa
         xZSdAHAPhy30QVKL5xHWqCEVJO2vAMC1UvtcIvQUXuAoO/QCwDCgCe9ld2D/a+rpSGVl
         GOql9XgPlRu1tmBxZAZUyOqVMvm4QVaNmwiSO38kf04FDWzmOD7JdAUwiwMp27/1Jxq4
         wKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773229102; x=1773833902;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V54kHQSlYQm1LF5g5xy9u1LvyxUv6rsWTsl/vLq0rrU=;
        b=aU2bIt4jx+VB92HMC8P+IUjJlX+SWF4ebt4Ht3wPckN/N0sDlCQciLZgEwyq0RC9AI
         y5V/EQ8unLszKvUeA7xvuWGLE005iA1Hy88KcN2jyTzrvHIhAymOJ1a2hsc6auJd5umu
         qHFTGc6Em342S0BW/SznCHqG3ROrwoYpvB48YqrkF1APwY478VcR2cXVmT6eKeowsGGj
         Ur90fz6gbT5byaEcrfFMwzseLVncJCMeS3P44inumB7qcSI9ASy4sH78Z4M1Agn9Py5R
         eyK5yB6NCdoHiuBGesPQhDc0UFUXOlsuMhqITZFKBAMdTNgW4V9hEVeCgighqmZIeHZD
         Z3Yg==
X-Gm-Message-State: AOJu0YwtqmgqLIPeSB1xnfc+t/JLTs+jSrTNEw/XFhhvtpuNyrDlBU/t
	dTBdJb3ZKAz1PngrSb1mSrW7wrt2JGZikqdd92iFmCXDQ5JDCSCTRtt0
X-Gm-Gg: ATEYQzw8EhxUGnuXRJxq+km5TBo4MUNsB+Vo8Jm8H4/ECxHU2v98ikSGKf4nWmzl4MZ
	gMVXTgu+5QYKu4q4ffodZrOA3802CUO5KUDkgUW1eWDqtttS7+H/jxVAn3Dcl7b362KpZcxrt9J
	dyqlIrV6Tj4sqEsuGCCZNCG9dBNnTw8zCyZ3F6kEd+9ww9vgz55ctJj64wtucXEVPayVhXPY9Zk
	jv33X39yCHSN59E7sKTFmfVVQb4xGjd0Z+HapUUut4bs0Is7UtRjIs60erDdFhtnlxywjYiFtiL
	0QWEdT6PXV/pMWbSvAS+DILPlELffua+bapn4X7MFR7XiSUxctjEjcIqtwbp/pphWgITBTxSGnz
	07JX9h+4lcw80edgdai0K8tAH+kG9CMdoVwCVqPnKx2LIh0YvSyjSYuIOaJ9PwbdHgest4h+gqw
	jiGL5uLWJTQyGaefXJ/eQ18tRU5A==
X-Received: by 2002:a05:600c:6808:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-4854b2916d5mr29289375e9.13.1773229101905;
        Wed, 11 Mar 2026 04:38:21 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6b7sm188681855e9.9.2026.03.11.04.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:38:21 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH 0/2] iio: light: vcnl4000: add regulator support
Date: Wed, 11 Mar 2026 13:38:01 +0200
Message-Id: <20260311-vcnl4000-regulators-v1-0-66b6038ce563@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgtJFRGvIg61Rg1IK6mKIN7d4
 viG/x9IrMIJuuIB5UuSxJBBZQF+dWFhI1M2WLQNVoTm8mGrEdEoL+fmjqjJjH6msXVInhvI5a4
 8y/1f++F9PxrthidlAAAA
X-Change-ID: 20260310-vcnl4000-regulators-bcf1b8a01ce6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>, 
 Raymond Hackley <raymondhackley@protonmail.com>
X-Mailer: b4 0.14.3

This patch series introduces support for voltage supply, I2C and cathode
regulators. This fixes an issue where if a regulator is shared between
the proximity sensor and some other device, and the other device is
powered off, the proximity sensor would be powered off as well.

One of the commits includes a Reported-by: tag without a Closes: tag -
the report was done outside of LKML.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Erikas Bitovtas (2):
      dt-bindings: iio: light: vcnl4000: add regulators
      iio: light: vcnl4000: add regulator support

 Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
 drivers/iio/light/vcnl4000.c                                     | 8 ++++++++
 2 files changed, 15 insertions(+)
---
base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
change-id: 20260310-vcnl4000-regulators-bcf1b8a01ce6

Best regards,
-- 
Erikas Bitovtas <xerikasxx@gmail.com>

