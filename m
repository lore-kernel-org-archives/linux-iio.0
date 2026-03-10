Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B362E9730
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164934; cv=none; b=d8UZ1BFZ9AU4spkSQnn8no2Aa6PQhLHz5RsFqQZtsp7hndfrfFiA8Q7Ai92eB7n9Hu7NAmoy/vWmXJC7QTaGTll80jTRcqbm6Cw6wiR+RUNgv92//SLgh4oCPGhI1BfPSxktsYjAxRgOQNw1rXc6fLSfRg5+WAd8nR3ZPOE2r0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164934; c=relaxed/simple;
	bh=rnH1lDDijdWio4hvMnW+OzLLpzrfOxd6aREo/7Qnkbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTP55AjqKzqNhJ+FBfS/6JNe5nL2HXuUgADvcY6MkEwFbcNtBerAtkaSQRArpbFo+fmNMAP9NuSMTYICbPbNRxDXl0NrfNryc6+5ZLYEetxPVGo8YU9UAJ0ESmXW45Q6AUowpYpzejavKs69oBzoBo1ZEtX6CorXXbRc2e4Cuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffyvomWA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffyvomWA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a8482fcso37816385e9.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 10:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164929; x=1773769729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG3aSGfDs+bX2W0OvTuhZZGpmjfGIX98rNhNH+D4xOM=;
        b=ffyvomWAqIs30b4tbEVvnBrxwwmZIUp1lpJ6FubjIWFE2TXRZsDgaVXLGrNRYAMr/Y
         dgYzqKE1BLhX9TuaR8p+r1Jg0L4rEcMUwAhOEiob3iUQH03y5N3G7D8E6yOd8fDruP0M
         GfeHb7WeFYXJKW47EYNYiVpd/gov0tL/c3eUgrWB3F0gMEefj4Rqro1LerIpSMVA9mrj
         CMNQJCXkW/dIk1BBMBh5Bsm4LierNVckg+/6othwisI8oxA3pHPuE1IYoY4INeSM+nSn
         BAVb4p6ZLOaXKfjpOYpDBwK1TlUyyH7A0/lG37MYMnZqUv/bUpTajVrZImZ+vfxiRyhS
         LZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164929; x=1773769729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hG3aSGfDs+bX2W0OvTuhZZGpmjfGIX98rNhNH+D4xOM=;
        b=Ahonp8WKGbKyLf2I4swcI9z/9WzZp2P1AgPNQWIMCZEcuwE6N8LxgpAcOGBeteOj0k
         wAQu+xrN+K8UlDpumRtPhpo6WZBXcvPSJJQmi9pFmIB/x/ufmVX5VBQGn825ABYA2Ruq
         Acm4O99SAmsxEQsRMsfQcnNhJISFz7//Ccmy4tujF0OqyDfry08bNBt/Rl7W6jzm15e5
         8SGxyvZ0GOasTt0pMXqcwjZcIxT1qrbf3r8994k5T5iOcCUJtNrLTEgqn4Oi7lesnL/z
         +k0MPLwHFACEiYxLwxd0LHyggWyE9xWJDPkQdB2rZG1eo6BrpyCp5vZiNoIgr8DU78jO
         /IPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW5QtxmAAD30eLogmrMHCHkAUuZ577bJc5C4sxN1VbDZwjoMY2DqoDHFu4r8noD31hgKESHybi3AY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4RVbpMA9XZCZ45AV53NnTo2MGI4P2AoXwDTO2iLUJ6SbGBhn
	vjvN3AWwE9uBrNzcZ/Uu6g+btL4S6dH5AyKG4DUsHmrUMM5o1b0OiaO9
X-Gm-Gg: ATEYQzyqlrIgT+YTwV0aALxF5qf7EKYqp7uwK5o5e0WXo57eJEnhf11GKTmJmcZuIR6
	B7TAeoeFfAwxNEPqDt5h6CHlzmDHQbr3ts8yfcBaixlZugSlt+tMhZYPJHPWezHUt7tfklebOul
	G/iFtynj0Nyum7OKPweyQN48dLpRiNw1bHPJhc5a1MSAg/FCaeXDK/lMvp7j+P7CCfw2c1cLIvk
	yhEs4pTRBC8ilc+OYP2ipZfLo+nnGVoVwIe28AYcH7/epvtjYwwYSY8XmUqtp7akrDFWd/ok0cH
	qPitnF65ONDW2kQYPTfzFpimWvf/kdB+kZYLFTBA1osp3lNPw4TasMg0d+sSaslvv6E3GoqzKeh
	xwBGXW9prNgiHgjPwfR2xK5Foal1AGm9FSXvmDq+EUWq8WKnJ4BM4w+tWKtj1s15/1UaJmrVysX
	2xM9WpkavcSV8xR7RQbP62aOg3Zy0kxJE5whFpK+8FTYhVdPCwbn283HmGuw==
X-Received: by 2002:a05:600c:138a:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-485269196ffmr291701295e9.5.1773164929303;
        Tue, 10 Mar 2026 10:48:49 -0700 (PDT)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae45786sm42986166f8f.32.2026.03.10.10.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:48:48 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v2 3/5] iio: dac: ad5504: Align headers with IWYU principle
Date: Tue, 10 Mar 2026 17:48:33 +0000
Message-ID: <20260310174835.24209-4-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310174835.24209-1-0rayn.dev@gmail.com>
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the header inclusions to follow the IWYU principle.

- Remove <linux/fs.h> and <linux/slab.h> as they are unused. The driver
relies on devm_ managed allocations, so slab is not required.

- Replace <linux/bitops.h> with <linux/bits.h> as only the BIT() and
GENMASK() macros are used.

- Add <linux/mod_devicetable.h> for struct spi_device_id.

- Add <linux/errno.h> and <linux/types.h> for error codes and data types.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 20a36e4a389e..e71218c44982 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -5,16 +5,17 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/fs.h>
+#include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.47.3

