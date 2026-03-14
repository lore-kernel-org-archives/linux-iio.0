Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643F376BDC
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504402; cv=none; b=ZdL8d6Ck/I1m4YfMUrPFvnDWXHl4iCiPuHDUGRQnlGJwFqZalMxQX4KU8gvnFQj3B7SrQxbTKOqknQFWiwxQ3yqlNjaLvYASM1/mOVyMWXSOPciQ0XgjUyqPhYIKmbeicMAnoUOvyD4+r2ZNPA16XNff8w2sK3bdRXKmSbpp9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504402; c=relaxed/simple;
	bh=yU/EQoZ1q596/CHvlN7YkhPccRT6mfDqWPXqpjdWn3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dnbN9vUrFjjbbosGtDrtIxL3dSEcgtZ/CaYPciCl2DEezHEoa41gtzohQV1qGH2fs2CK2/C2/I6V+Zu13QncRu6YrXmtCiOMba3P66LQdSY3jcD06OvCyFTLuZFx5NOguc+NbweyXQcUU7efoGorBcYbOO5C/zBE/Ofdi62H95U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InXjng05; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InXjng05"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8f97c626aaso503954166b.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773504400; x=1774109200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfIqfSEipe7Ni8DeiT4tR7mdwm129F2XmqEhRhL601Q=;
        b=InXjng0533pGZC0bIiIint9lnnbG1fMbU1aF903clZ1IZtJLoHiVnlpsnTD6K9OShJ
         MurP1C4iTWA0fH9V62ufxriT2ZXUia4Np18Y+kFI1crWlflGO5xcHjoQr4HH6z4NCjBO
         VWj6TVhJczYETTy2zn92ZQdU2lHwpPgKzw5mmIS3bP7cqOYjTR6Rg0Aa7ywBmBhaZFiq
         xVO7wXdcR4gYC1tx6sajqCubD9I9u/9VG9+9rvWXaCsmpR4uamyxdnN/dOwvn3uYDnK4
         q+1tF/QD33bwvBV/hlbk2Qn2Y5sLrZYS9Wpa9HHng1uca5I3x3TSP7JGMqin0kjka0pv
         MRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773504400; x=1774109200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfIqfSEipe7Ni8DeiT4tR7mdwm129F2XmqEhRhL601Q=;
        b=hBQS6bBBD15O4d4UTiGzhA+SCBHA39KyNK1IoDeuhSfS43jZiydMfnLexkwFDPp/yp
         +yyqMaU62Rw3mLwY47rA7A2xPS9kOyDQv3VGbiXO8xm6Pcvkhhk0fMsn/BEE5JinuxJw
         lEoBfXBsTDnCJqOj8lwi9Q1k3LI+q8WOiHjLk1rj6e0A3XlNDOgktnOfpgC4cyrc3ebJ
         nzH7lGenGE7VAdgCQ1PTQ8JKPW0WLahF6lSsakYiWt6th+LmkFk/+ss/wKK+9zHKkxqa
         XirfqRVhhZBt8kac3oJN58YrNWwXiGjyB7fuUChie42UwO5AhYKtfobAwXBEgz08U2Ky
         J5Aw==
X-Gm-Message-State: AOJu0Yx+e7eq9cnpC6LSoviAb9+kYt4lDSTqYC5y5AMwVwB60Ccf2cVm
	vmRaYqzBT7jwtz1J9mIg1tB03b9ZYNaLL02Qw8pJ8pDgX2d2eydP7TJejrarNfjr
X-Gm-Gg: ATEYQzy1xO8igF3f6uci9P2WUmdwFWSd957mF/7qNQoLTCBWEHKrtKKfuE9VFJDRbpK
	HKJUqITooZhAes7q6ojPnSWF6p3a+QaFsn0T9jhwAvmu54hSgHwqykydcAZHMZI4dSREv24Tv0h
	iGR4/xY0Ph6a0RVxeqDS64DtrVdldPZtzOr4KQLDBWcN0x8Cq/AJmbMtXeZaMjH5hx7P9dCriwW
	oxkIZm+4pUuO0B2egEmdEMj6RSxqO3sQ1u4uEzXhJb7OvIY4n9aDdhQOR4GjDq9oFgCq6sSj91C
	UCPB/jXqNZTA6GNP/asWfBJED9ut0mcrl0YKMNZae7qkE1LRamEOrH6lRnAwPhxbugjAF1Eak+F
	lv8U/T4r7aMQZFkN9M9heqiXpSFz7UPAIcyRzrmgqjMzU2MhgJ105pMdQrvg8Ypf7jj56XGK6Vs
	9HeLiKknb55wDkqyKUAihd8be6WA==
X-Received: by 2002:a17:907:7253:b0:b97:554:f100 with SMTP id a640c23a62f3a-b97650f31c6mr423401666b.20.1773504399716;
        Sat, 14 Mar 2026 09:06:39 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b978b8625d3sm151722366b.52.2026.03.14.09.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:06:39 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sat, 14 Mar 2026 18:06:31 +0200
Subject: [PATCH v3 2/6] iio: light: vcnl4000: sort includes by their name
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-vcnl4000-regulators-v3-2-3c4a48d30676@gmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
In-Reply-To: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Sort include headers by file name for better readability.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 5e03c3d8874b..939ff2d65105 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -18,12 +18,12 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/pm_runtime.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>

-- 
2.53.0

