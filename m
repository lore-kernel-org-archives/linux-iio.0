Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87283EBF3A
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151106; cv=none; b=YKz6UgCrYpCr7P1L8TvdV786blojOKrglnoM/kNDBB+kIgUhCVUrwBTzblnjIazLG3ZxA1TLEvYsSOrZtD1f+sZOC5+Kyx1XJqYX1xgbwzXB0G0csE2IsF/fIR7fK8FcfwF2PdjzCjF8DmH/MUjqmKDdmK0lXYEEZcXoKICdue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151106; c=relaxed/simple;
	bh=4RX+5PH8WeeYPQv0WBCHMQIaa+7h6d+yF/TSD97MpMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZ2ebPAgq1JK0SfnLdSdGUVmKsDsrQpocAVAp4uhdZf7U2htKXqQwifsgbfU28z5VwzA4bvvHkLxdzacrLatAclzipgc4IUI47hLQVb5La3ijmGtZVFMqpokb4hJaElNdy4kJiFXobBwyHx2xw0LuNyFTmk54E2RvLxjkhW/v8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mukH4eVe; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mukH4eVe"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a40502e63bso593032e87.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151091; x=1778755891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/M5ZgrtKgTScI/gmhZFEDD5eqoAVkXQ5qhKnAhsz5g=;
        b=mukH4eVeXPPZZRRA2fNso1PyKtEMlCgy8zP4bf0JwBFBuUobFqWmrxl2U28w07zji8
         bPOZC4ZbgT1n76DqDqlRIcG3RKi02b9WTXsVHTuKddOclkCvOBkxPb36L6Z5BtseLiR2
         TYgFBMlHfewzXLLkSdoK6+TWHAv6lqUlc+ahAoejm3hhbPeLz8SxPkIhhg/dKX2R2Beq
         L1I9YSy0lI5k3qZ9GEqvU7vwIIaNqrv16VYjWTRTs09e1y0Nxc/RUjZbCenSaJ2QzGZM
         wwMQrzArnuOL9r15nM0kpl6IQdl78m1lJYflIKP5Q8zX6620PaS7jbn2fjuVhkhjXQRL
         n4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151091; x=1778755891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/M5ZgrtKgTScI/gmhZFEDD5eqoAVkXQ5qhKnAhsz5g=;
        b=tKLqiWT4GakkJWfJjwzduks6LbYJQZ2zEysZONTXc09HT+BTiPoTIWHJReawitV+g4
         DI4lJnnEfEqbwb6SC9ifeUZ/gXwFUVtZL+ljf6ZoeJKb0UvhkMKyAS5a1xd+O9RsBiTr
         D1nEu6WMFSxiDva/rvwhDaA4xmTDreODfbq/Owknea8kXCD3brWZv/puzOaHgvJ0Fw0G
         IB4ORhUszxzq3FCp1QgYrdanqUZEsDI/Nmo3C9BTgZPUl3FVNYGZqGnL2J4Mh+ukoOub
         E19ZIBaF3GhWsejYiAwVr8Ul15ZQbX97h33z+BCb2wKGNv0PvI/BDMsBUDvJY8VXxAOJ
         UMpg==
X-Gm-Message-State: AOJu0Yz+2DIeR1Fo6lvE3yRmc69eqsvAXaIjsG5bkf2IM7+8X5qVSLWw
	L6VTxu/TCfqpVvJaPSSwU06nKn2d0Ra4ctciMWOv6iGlPwOyoz4rrxoaRZ0pQ7Pg
X-Gm-Gg: AeBDieuATXONeqVGrgVJqeyrX8b4D40aeBfmXa7OZ8KBxLS6WMZ8jJSUM4wSf4ynqa8
	tyzS6ozfAmZ3c7FNnYIFenBYFfdXEQXVOJDgGPzb8/FoqL4ndMyMGqqfU/YxJDtsJ/G/Ufu1gsH
	/zWQtny9U/50G8q6L86UXC0iEImIRckY514LhtYtCDWegXh/FvdIZ3zRjE902cEYPIje+/3VbfG
	okO11coS8mbkVlvG8C9VInBOboX8S/y7p1opMMhUhxgHjosVifnW46AjzTIV/qUfOjUCtFP4Phe
	MVr/mHpa8Yl2yj9p0t07NviKEJsUtuTiMRbe5FxHjAF1l6lwJ3nvT9ZhfAhRJjubj8TBYWndc8+
	SWC3DJ0jwUGdu1t7UoyD/+8pK43dXXrFjLyup9OlICEYwSY00UMNHqYHb+P2C35PmgxxTcJPouP
	pppaF7Zev4wuiTjqCV4yzrRnJmmZLXjnwSMqY3hwn8wJPeciYtHiYoPirFhNGn0Rpeq7QTLAs76
	ks=
X-Received: by 2002:a05:6512:3b2b:b0:5a8:9f6f:3212 with SMTP id 2adb3069b0e04-5a89f6f3324mr504346e87.34.1778151091229;
        Thu, 07 May 2026 03:51:31 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5530224e87.65.2026.05.07.03.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:51:30 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mike.looijmans@topic.nl
Subject: [PATCH v2 0/3] iio: adc: ti-ads1298: Three driver cleanups
Date: Thu,  7 May 2026 13:51:25 +0300
Message-ID: <20260507105129.25639-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three small cleanups to the TI ADS1298 medical ECG ADC driver.

Changes since v1:
- Patch 3/3: Per Mike Looijmans' suggestion, instead of writing only
  the RESERVED bit to CONFIG2 (which equals the reset default), remove
  the write entirely. Added Suggested-by tag.

Patches 1/3 and 2/3 are unchanged from v1.

Md Shofiqul Islam (3):
  iio: adc: ti-ads1298: Add parentheses around macro parameter
  iio: adc: ti-ads1298: Fix incorrect timeout comment
  iio: adc: ti-ads1298: Remove unnecessary CONFIG2 write during init

 drivers/iio/adc/ti-ads1298.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

-- 
2.54.0.windows.1

