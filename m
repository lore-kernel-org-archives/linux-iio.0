Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB27381B1F
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815723; cv=none; b=CNJynPazfUPVuyqZz3bFZg922C3AGDTHJEf0F6uC4NTGXuAmwjaMry0cUxSZ6VnLcqoaXsEMJYLlaIR16aHXkcgYlil6pyWxl4jmTJ6D/Sq73bWeD0Y8Yq5gl8bhOF1+bJtTqNgWkZU1eLEusuntvzmXxYZuP09hnrZYUEuqgyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815723; c=relaxed/simple;
	bh=WxRfsyEZRYxDHjtGXo4YWmG7XMdrD37sqEHH7ZWIcYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMs1jbVmt/BxrHpqsBG0M6VN159zCEIANC9Mi3igz5GYSsqKk6X1raXLBbSBmJsnNRfZoVifnxS94oIw67GsmKm5iQMY5Yk7VcLkJ3eG5dKZT6vzGabISkUsqOkoS4HHb9xJeWmGlm/E4MhJWCsu54A0C6A9LU8ChKFBgFDybrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncnkbQbp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncnkbQbp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66e6d9610d8so2726943a12.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815720; x=1776420520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwqkVEN1x6/hRKrMN3cHJmOvoK903oMVODNQt0I4fO0=;
        b=ncnkbQbpT3xkhyH1pXroHNBdWfcz41ezo5/K6dKgyOnEp/AYHiqIQTPMsEGQNrqvVK
         cfTyQTgE/9/j9glRjgsyUqyU6RXbpj8Z7ATZbgNEFSjexGWWE95cjosxX9YvVosEzdRr
         SN1y/oGxs730OA/7MiXu+p4fGilD/2ojYMyitdEqQP2RjznSYD4n43/aYYJw15VMh2q4
         nw9IEMhDHXBN9qW6okR8OhYmlPM+LnnUhZvRY/pj3lyfWZdCHfRTWNdSINKavVA4KYsa
         4Mv+wSNc8H2G2wmShfghpXFz43TMYvHBucyjHJimzfmSfkb5GsvJvw/RzlZOqjxhzpA8
         jZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815720; x=1776420520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CwqkVEN1x6/hRKrMN3cHJmOvoK903oMVODNQt0I4fO0=;
        b=EIWd1DU8NHu+AB8/LhdOu+Vf9YEagf/rc9gRJIHzaudgJJDDl49mRcGc8oQ7eO8qrd
         ykIGpIBdyhMTFupltsWp1KRmXZnD4Lnr47lwBc2U6bIiND+pDKGLS44E0IdZNcU6FRfQ
         iC8QEIniC6Cc+LwjQjABuj1v48GCdWcFjJEiiGoQQA9Cbb2wcF4mSmRA9m7aVVSXqXe9
         oAqoSGz0c/Jd0+W/6Q9mj6EtI5SE4Ai/WvyvI8ZCAilsDibkJZUqM1i5aWw4N2m8G711
         CTdpM/L8EdC3eBygreTnA+yaQuhu3xak6ZTPzTjwK9ByHdE63oDZC6/574Uh7wStlv7i
         TvYw==
X-Forwarded-Encrypted: i=1; AJvYcCVpjqOyrG9wZZELVMcRz1zswa4Rd4AinnUioPOKAhcHQmz7ou/zIWoeiaMa3UH0/VTRmM9ZK5qpMVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+P3gtt6jZTuo/zq3+O5uKPPH9WkhbyhcBzdqZIugi60i2XTbK
	GIUJuu5qk13qKIx83/xQ56gFMo7G+Gp2HNXAgvYxDnw5WOCzUfpn6f2l
X-Gm-Gg: AeBDiesicAlGqC2us28E05Aaxsvdc95h9gt74iPfwQa/7Yed3SJGsqPr+sIOqh10Zqs
	Q2RITQrH9fqz0RFrerMXmmI3NxT429auZNMJBr5yDclao7nv2XtR/nwM2kv3/jD9D7+yujcFs34
	ZoVKWMsivot2fom3fBLSA8m1P9JbXHbzPN9m7KSrLowLcieUgDRlJzfjSyPcjLIJvW9oQ15cG7n
	r5EA2ALdNjmrFs9ZFefNqKBmhmSbzq6XbRj3QgImf4yGvDhuTQ3+J0tXxynkt0wtFyFentngDCe
	9EJODW91q6KdDRrNHAbm79Rbd9S7bo0rAkP7TtMeXRPrJizKoAMjooilCg03A9wtn5ST5CsaZSg
	cEsNn2ECfusYZGvr/JXIjITDLGxdBQu72czi77hbiN0xh1vJ4a+7oxbObglW8NgZsudxPzcnbr4
	ZRxGLH9Xp4O2t3fRV69c8xJiWJPa5jgJJKzw4VCLR8v2kVxxrrOwsta2eDQE7nGyCi94ljAFgRy
	qdBuSE/a5aF5USY7BdVsH9P1atvx700FAnpNgZP1B24Ro3RJ/xFOkgY3qrAhAcoNClzBX2QkFfW
	Yq1B4mLxG3uhE7vxfQ7MnKUuqSIVvIwZay5eZUOWYRuLKRYXaQQ3uHSJ4DTVzqfnTMzm6iucL3D
	H35wEInqZuVjYuL1OZQ4=
X-Received: by 2002:a05:6402:a0db:b0:66e:5622:a2e with SMTP id 4fb4d7f45d1cf-670798f065bmr1077332a12.22.1775815720029;
        Fri, 10 Apr 2026 03:08:40 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (216.153.158.34.bc.googleusercontent.com. [34.158.153.216])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-670703f1340sm433488a12.10.2026.04.10.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:08:39 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
Date: Fri, 10 Apr 2026 10:08:31 +0000
Message-ID: <20260410100832.1388-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410100832.1388-1-joshua.crofts1@gmail.com>
References: <20260410100832.1388-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove kernel.h proxy header and add bitops.h for
better dependency control and code clarity.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b..1f6ece79b8 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -8,11 +8,11 @@
 #include <asm/div64.h>
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-- 
2.47.3

