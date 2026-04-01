Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28336897F
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042674; cv=none; b=iY9pKBBR8C+JVBGtJvRGZQa1y0Unu+ysuyETWh85H+UoMhJLAEXP3H8tdpuXQQ/pEb89FEpLKnstFBcUm5mu3ji4/h0cpm811lj/wTA65Fqzi3Bg18EOt6Py/HbCkQy6YSpuFWX90UZA19D2V2usUf3LQFxRTd89efhSuCJRD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042674; c=relaxed/simple;
	bh=oEwCA2tnQWfFAs7tK5xXxB9IDV3+/is89SmJsoxUIl4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bodvNWqrCso16XrfcOJL1OSb2AjxqFIYEfguLbmKH3NGWlprKtowRtM2Ac5Q2ownEwsy77B7PdCHEY+a+XZGZEzjDFQkn+P4fkJVoMiM2cdgRkm0l1R+kEn8ZPj+SIbcU4OEsDSVG3d1Qi7IM5uG7aHg5PHapnwX9wLmMFKbmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpvZlJWU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpvZlJWU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so81057695e9.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775042671; x=1775647471; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EJa8y6F4tGfqoKl6GwBVtW9vR7kVeeLQKluVTUSukw=;
        b=QpvZlJWUoXPmUz2p+CWpCvYur1EGu8AVLI7jTu2+SBwtezKJkGLuFEXcxO30SN7xYy
         CnTgQo+A5Eo2YS/3nXwsiTogwfnHIX0DGp29N0nq+Cp+rXs4w0pyEry4QEOg57OSq0+W
         eLGUli1VvA9HMDS0L3jF6sSfOYj8thlccoamFukMlIltKu0P+pqhDezJ9PfWcDxxB86+
         pVBB7Y7LW1LBogHOg/nlbx9fDAnlFAGytTwJFbeuvhYoV5UWLtb/nkpEL7zv5w6SnUOj
         LtTjP1MrBBrO0hDX00HVe7wsAV6FgJCDpii/yQIqJQ2EoIvi/T9D7hqzYHNPSeXJ4+tw
         daSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775042671; x=1775647471;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EJa8y6F4tGfqoKl6GwBVtW9vR7kVeeLQKluVTUSukw=;
        b=cVVuttJnN1393TDcr4SWURb/R/pYkfl3AybZlaQdxoQhOH45GGzT6EhqXyJ+f0I93L
         88qB3t8AoqYXVFpdyj/GS8Wmxj/WwVE8VK2wxltbIXVMI5bUWbvhpTnNUaxZmMnv2eCr
         oBpP/Bd8V6lKhSS1J8YcjrRXQBySTdXVCSy9TpBA+jHIi1oePt7O3vmvp8WDmTXZowU2
         Vb7mzILj9jdX/wiMcA5tmUwqFj+4P3IXwWJwYGLOKtTXTesfOTn5qvHLLB84ZuAQMEpH
         Pf8xoHHDslAXY5WT9oQN+o1Po6DBjZzDgJNf5YCsUFITGQ307AAR+ZQb71A2O8edB/SG
         YAJA==
X-Gm-Message-State: AOJu0Yx8zD2CchfAOsbpLPfojbewF14xxScLORUx0ZgKTC32AuFVHHhW
	HlIFbpu/Ya7eETfgFaPLPpo+xejwgHRGPppH3GnvCidFXxThCdXVCkNHjvA5zQ==
X-Gm-Gg: ATEYQzyF8r4WRxpWVxjhNKiwtplC9DRDOtzMuksjqAemyHXwyh5czJ+wyVm8ywygAPp
	YsSjKhcK+dnwCjVv6Dyw0VizlQPMICwvs3ISYv4gr6hjNeG9IrkyJMA/JVEbubbufMMK3cJAD0X
	THusB8PjNwOhXBRztM2SL/tVXogWMYZfcNern1PBp/9gRRY0+l9Z16oTLV6D8SKhjfOGbGDLatM
	lbCMAmHIhrWgXCrjprLgwVlrlYjXfHEW1tKDyG7RgLbb2HNpg8ewI/6wgXf+J2+aT1AaYLJ7Tlx
	1BFKeo3H23MDRSD+ZAMUj7R/XoWyaCXbYTmM7QMpNSbfkPAJpXx0OPM2rYED0RlnLcSIVrLJnXa
	PRupkyfFkEZymNwQxFBDeHMSr6AEdKQa8Bz0VJjHj0STFwgwXFYdG3E68tFvELrU/r6yRjLjfV1
	OXz442/Zx4Dl9VWfw+jh5vpg==
X-Received: by 2002:a05:600c:a4a:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-4888355e52cmr53015825e9.5.1775042670662;
        Wed, 01 Apr 2026 04:24:30 -0700 (PDT)
Received: from [127.0.0.1] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887aacb99csm43450165e9.1.2026.04.01.04.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:24:30 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH 0/3] iio: light: vcnl4000: drop enum ID table and use
 device-managed register
Date: Wed, 01 Apr 2026 14:22:35 +0300
Message-Id: <20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPv/zGkC/x3MQQqAIBBA0avIrBsYLSS6SrQIG2ugLJQkCO+et
 HyL/19IHIUTDOqFyFmSnKFCNwrcNoeVUZZqMGQsdaQxu7B3RIRLPC/kcB9Ipu3Jau+876GGV2Q
 vzz8dp1I+gI+bS2QAAAA=
X-Change-ID: 20260401-vcnl4000-drop-enum-0238061fcff8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

This patch series drops the enum ID table for device enumeration and
instead adds pointers to chip ID structs directly. Necessary
information about the device is then taken from i2c_get_match_data()
call. This removes the association between enum ID table and struct
table and allows for easier addition and removal of new devices.

Along with that, an iio_device_register() call is replaced with its
device-managed counterpart, to ensure that device is unregistered
automatically.

No functional changes are intended.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Erikas Bitovtas (3):
      iio: light: vcnl4000: validate device by prod ID instead of table ID
      iio: light: vcnl4000: drop enum id table in favor of chip structs
      iio: light: vcnl4000: register an IIO device with a device-managed function

 drivers/iio/light/vcnl4000.c | 208 +++++++++++++++++++++----------------------
 1 file changed, 102 insertions(+), 106 deletions(-)
---
base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
change-id: 20260401-vcnl4000-drop-enum-0238061fcff8

Best regards,
-- 
Erikas Bitovtas <xerikasxx@gmail.com>

