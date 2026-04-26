Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB126CE05
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777238431; cv=none; b=oolDMsLLHSnmfbnsJMIlSMR/ov0+PhkWIszistJYY4GoHAn1jwrpo6/mwG+37rDP4q54sYMKVhGRhSCTnilclb0hYgKVsr9kWBpTtt0M4sxfxNnhGxyXnYxTHFiTma8nyWQN6mkA1b9oAc1taDmFtsUdTOPA0hVV5dQiojUbPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777238431; c=relaxed/simple;
	bh=mITXtLeOpwHSbJx8bn17Ts4j0FNZScs7VSAe0aHaLBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qkgmgz5VO+/FpeBQ9XuNCWvDs8Ub4uxst48nePovmVTgOfLBMnxDYEkKgjtTt2uu40mB8ELA7+6Znt/PsRm4YLY+0HZOeu69UNdWeqx58Tp7VkHu2trwembilgOUz+GuY8Xd08XGkXSn9yEa93q3vzC4HIWSF+Lu1NIxme+uFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=t+kq7qrZ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="t+kq7qrZ"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2d9916deb14so17090789eec.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777238429; x=1777843229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfWSJE8B9SaG22zzXfiANFyGJZzvbBnZnEiz23tVhwg=;
        b=t+kq7qrZmwtF6WjKQlX5ciO4SkljAqqcdTz0YToS1kEQwqWVAaEdjFf1MzUubz5R4C
         wSloKrk63fwlh2VeNX4xyE9nBAq6FdcENZYFkxnQgl46rJRZyEV4gQbLhJcyqz6+e1q7
         /tZr3VnV1CozzgVCXf7Oget5mY8GFii4VU6pTFoVsO0UDnPcKOcZssnmo24TmkIF2ElO
         TI+kA12Y3uakKZ26IzEqdC3td8XLNlshAYAMY6U607HJVNzyc+V1Gx0s9oKQ4ghZGrpN
         maaTVhNvy2jaAiDn00UTDhNqRJToOafA4TpInoZS98w/zi1QBgf3drFElBclD8C4GD/Z
         ShMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777238429; x=1777843229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfWSJE8B9SaG22zzXfiANFyGJZzvbBnZnEiz23tVhwg=;
        b=tBlHAzTWHVhu+9ZWDAp6SASzuvFF7mWfk49BjOw4PP0AjSAZWL9H9K8cKQpRM3whqA
         44zHV43BT9CXQOhw1Nkoph4zBpHR6laUqjddsRBB/osvdRybV9CistRJ4fP5bkfYKHDY
         HB8dx9JqzN+G3qsPB03s9R1j3EA/ZQOT4ezxgDPHaxQkuWhzUdX/vVTIASLh2tDhx4fK
         j+aMJ1gWCYCkK0go12g+s6X+qKr0cjv1lZpwkS8qBfpOH6quxxYsRRiaq4mXrVlT8zaA
         Jaag8dNW7lilHjx9bAXaQka0T7HxY5oAhWkyVAW+Eli/TG8+uA5PyRCF+0xVwdvR7imb
         zoAg==
X-Forwarded-Encrypted: i=1; AFNElJ+1akYajvM2HCR1grDRSoXiNoBKLfHWyrZDOnmqDLR+7XpXR3arm44S+vUwP09nBiV71ZN0lA1CBUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrt8r0ml7PPCzR5QaQR8pswLss0nFKUL8It4uFEEYVmnL1RNFo
	RcBdxS7ArxGxKHOjTC/9ag6Gfi6rvGvwJooahjyeW0aZ3aG1581M+/bd6v9KJKKZqZg=
X-Gm-Gg: AeBDievAguU/kqw/ORo7ldbtphcKvHsKWIzW1DyZXbNOpGNhnFgY6LbKiZNUN444pKf
	tIIQKrgxE+3Krv0KNBjv4qBvQWJXizs0iRy0Ks5+1L87jzQFuejod8Vi9+jGBWrKfu4LZYVgD2/
	VRbnshuIXV5aef+2JzwpqxP2FxSU97LvYXi426CmtZ7du2ec5jeIJ14Go9vHKu3rdB/SAsx64BO
	Xo65NBhAxCvzP38T7vxnbLroS0t9lSd5LA+ZQcryFMZJOyKO1GTnb3MIKBKmxk2Pc3V3VDvDF7V
	lOOmAZ7WLj0YdQVDlkUXohDIE4zli3te4qY9r4RZ7D2vtixrWebguDCp/a040r/6Jyri78dHmS9
	f/VgL9cZVB7ETMn2oxspWaexPTZ0rlwCTSHx/M/tm4+W0Wg8grC4habESEkNouup/oBaCZNdsTu
	msHOJFijraFNUSWgz8HOYV14FjhSLxWTg=
X-Received: by 2002:a05:7301:3d19:b0:2c5:50fe:c795 with SMTP id 5a478bee46e88-2e4875e15f2mr24952172eec.29.1777238429195;
        Sun, 26 Apr 2026 14:20:29 -0700 (PDT)
Received: from eileen ([38.10.153.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm40799122eec.17.2026.04.26.14.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:20:28 -0700 (PDT)
From: Caio Morais <caiomorais@usp.br>
X-Google-Original-From: Caio Morais
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	michal.simek@amd.com,
	nuno.sa@analog.com
Cc: Caio Morais <caiomorais@usp.br>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/3] iio: buffer: industrialio-triggered-buffer: fix includes with IWYU
Date: Sun, 26 Apr 2026 18:18:01 -0300
Message-ID: <20260426211834.3318306-3-caiomorais@usp.br>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260426211834.3318306-1-caiomorais@usp.br>
References: <20260426211834.3318306-1-caiomorais@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caio Morais <caiomorais@usp.br>

Signed-off-by: Caio Morais <caiomorais@usp.br>
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 9bf75dee7..a91d439d7 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -4,9 +4,11 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
-#include <linux/kernel.h>
-#include <linux/export.h>
+#include <linux/errno.h>
+#include <linux/linkage.h>
 #include <linux/module.h>
+#include <linux/stddef.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
-- 
2.54.0

