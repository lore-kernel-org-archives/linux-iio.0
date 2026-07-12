Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0FB3546EC
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783874549; cv=none; b=XNHeVK747wgqYFI7AQxZl7OIBRw2zZ5UOSJD5M7FPSM+dOHksbWCVV6cRLqquV1t1YX0GFZ2u0CDjvv7fbZqq7hNnea9oNi8T7FaU40j3wcI028AlYAFRxF1hWWqi9Dt52mwabmMlpNEyZ+5CLRyZ9FzK53VmFfUlRByTQtd5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783874549; c=relaxed/simple;
	bh=Vrn2cvHY0Z8lIXDHCB8nMlk5vQkUeOEd+5RMCPPeEsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHXyluNArDqQNhpQsIbNNwdxjKAhjXqsFErbKkNgqT7ki/8RMQRF2pY0aFbSz9IQeLHyg9R2Kf0rMuxL02CikG+ltXfOPwX98799CNY3XSLNFYHodYhyGn0OCLRcwOxFEIY/CSlt3G0Banzm4/5nSBYskuwjl1IIVxWbxPFjceg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9XUgqZa; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9XUgqZa"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-48751bd4abeso966488b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783874547; x=1784479347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bjbe2W2B2sOCg4eolTyHO9+I2nNjjhOXYuNovM6oF4s=;
        b=P9XUgqZa4zwho6EPpXMV5jXzK5aQbP0L3ZdLcpVFE5vBWFXb5Jz4rZwrZkBEIOm48U
         tIRE31jA0ESpfs9NDdeIo0dGw+soyGSHAtCEi8abMOjrYn6cBoy0MyvCu8wa8dYDf/cL
         MUTck+sjnJkF+PJzi1L+2pN0a3mKs45md+BO7vQb25uarOo8SeZ/n8bZ5R+UIiv7dl63
         X2lD1EHtx6H5bQ/aVbeqXthwEnBVgg4oTYRH+pNJtSxNJRHWocyyQ0RozgPLQGnaztGU
         1HX+VcA0bdYitQGY7U2Wciszww97DBJMLBFdzH409ZOGk/Xd23oOrIyI0d70RFgmRIoS
         KXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783874547; x=1784479347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjbe2W2B2sOCg4eolTyHO9+I2nNjjhOXYuNovM6oF4s=;
        b=SDQiN62h5DifcqYxKfwE94ceeC1iTFN/7oylaNTmsPy5G1YNQF/Ny2qTXAXhzh4fgL
         TXZlymE3MAz5lJAQ2ctTdeLb1IQ8TNaRSsMTWBbknB/uclk9MpHSgI9vSM9rW/PEHufJ
         JofSPrTIRxmpOT+bSzbxxrjvwIHVkKlW5Ts31zadfgr0zCAIWr6TUVBPYvTcuVNEHBEV
         jj0C5aHU7OUu+GevQqvgp5Uya1se7XQTqVcinLTEqQgC+DLbqIBhkksxRyeAzYltOnal
         GBn/1sug+Dw/FpOz1sZh3ihl8TrDm9NhN59Fq/XFQogNq1zVWCnwCcjTcvQr9xGDfuui
         2SIw==
X-Forwarded-Encrypted: i=1; AFNElJ+y3lFz6JN9yLOmoYm+c0AP8rgq+ywzesqqJAmQ1WdrsqZD0ZLaHCjb38g5+Z9ZnPLdT0IjFnSDJ74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8r45uh1pHlIxbBe6rnJLdDgvuq1PH4zys233Rcc2wH8CZpqw7
	dm2+KDWe/cKufeUD1W9GLd1Lig1sC6V9DW/lBroNm27vL6yAtedt+jpj
X-Gm-Gg: AfdE7cncZYoo/PkPyv/WNog+duDDjwdPTm900R5vE4kpIE77p6GcCIxfciNXVZLetWQ
	avP2KCIJpBBJmpja2Q24uoVUsEBB39BZJSi+TwrGTC3C3ameCi8UEeS+Ypstfnku3U4TlgdkoTe
	3uuBzrLGAjYR7O0PCB5tNczmMgP9GOvzHJtpVBtjQbKHRJBud/tIwYJROgBGsCVjDjjLMLi093m
	VWdsx6C0KgITYacmj2KCjraH2ROIDz7xBlutFmsnesKo36tTN7vPL9xEqbNKOSZ0Hgd6FXzPlMH
	NAug6nIoxWwHaHlPbjImun+chspdq+I/1u5poHuMhSDn9G9bHWjZk52ziyY5LqDaonMWSP925qf
	lFZBOb7RbJdPX2yPFciVICY4XV5HXJ2JQfpPaEWH0OZ27nyW/vlm9HVwYBZsFqP0lclZHDjtPO7
	J0sSjcZ3xu0L2nmceminH3Lniv3WuUFL8QExdp7VA8hXCkDfg=
X-Received: by 2002:a05:6808:1b99:b0:492:b433:a3ea with SMTP id 5614622812f47-4a42ac195e8mr4386280b6e.6.1783874547330;
        Sun, 12 Jul 2026 09:42:27 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1afbf92b1sm9767922b6e.10.2026.07.12.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:42:26 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Tomasz Duszynski <tduszyns@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: chemical: scd30: remove kernel.h header
Date: Sun, 12 Jul 2026 11:42:25 -0500
Message-ID: <20260712164225.358852-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel.h is no longer recommended for usage because it can cause longer
build times and pull in transient dependencies. In addition, it's not
being used by the SCD30 driver. Remove it.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/chemical/scd30_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index f85cdd8bd84f..40bbf26a667b 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -23,7 +23,6 @@
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
-- 
2.54.0

