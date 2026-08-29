Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A10282F15
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020770; cv=none; b=r1MRkUT8qIHDdx+uGduj4Ypvs6kEKch8DfgoG7xAZDJJydII7s0B2U0tpYzRgOOwYzoTjajayimR5EADILM+MWr3+rWSVQ48oF1u3H18wmdAebYubjR3emZmoJV6Fkvc3TbGp5woszkYsLt/emjuJTvdtzwvwlaGebBLrWJhRdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020770; c=relaxed/simple;
	bh=jW53cz7kjVnoXurd4I3ohM3xctyABDVxUF7y45R7I8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNoHhyu1yb5SsFjECC5IbQk/tbzUtmcAJuZf2XPN3EiKxAphFUxAlnunWYzAfmSA/Tpnw4jpAaD8I3joZvenF1e6wm8QvkhQuTn/uciDWGEI+dN/j1Ia1XUb7+HJ0XavFyM1WBqvk/2oeVVB1+3xX9wl1zsK/caDZKo/dt8dsPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW1BKHt/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW1BKHt/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b0dbfbf7bso13596815e9.2
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020767; x=1788625567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5xGBgSpjI6ilIuBwW9NQ1zMvUmD0ICcrq8TK/D9+gk=;
        b=PW1BKHt/BQIFdUZ0IEIgH2T+rDrVAiifzaCSL+Sr8BtlYQ58+QmLXsEPG4Cv0ht+jA
         Mvm+Crh/LSanbQxkb1hGNhMTaKPQp3jverAcALoWEVT6Vf/Un3ueUwYuuij8o7GxBQCm
         sijmQ5ZBKJfUcjB+/ao5tkpn7BYqEJdTU6niTrvpBRzbvR3P9i3vAku5uLShRLwKkyfz
         T2+/xKOplQoqnkq4V8Ypi9hWWDbKqFzM2v0x73aGcWj9a/jveQhrho/6oEvdGll/Mdn8
         uMkYK1hwZ1qb8nM3TcFfF5Koneq5R+dc781pUcYsSy7RMXAVth1bYDvkxfp1VtgNS06k
         OnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020767; x=1788625567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w5xGBgSpjI6ilIuBwW9NQ1zMvUmD0ICcrq8TK/D9+gk=;
        b=l7Eu7uCU/n1CNN2kbwBccmfIOfcYybvLB8Cn99DnGGuLT3aWBN8Wqm4n0uTDaLSM7K
         zY1Lg184aVHtekm5UWkirJhx02PX/bdq2QLB3kJcBKUTGej2MJ41XubyMYVByRKKejeI
         WXROkLZTgBpskeAlHP9PDoSh+u6OnDzRU/GmDF5srT+S0KzxvtZI5PJ/FFXr3EkAWwy1
         n0FpZIyajIRByCTKJxT3s7S0nrPwRD7j7oVe2RvzARCnVgr06lRw+ZnpXe1ACp/7MgNB
         8CVshyn7C1ulvkeqsX5u2w6F0T8FjtvPUs+3mBc/3eItfsPCIcMp2y/dYYy9i4Q+jTvv
         vkiQ==
X-Gm-Message-State: AFuF++mgfqpjGcZrphZOr6AtHmJF3pYfM5pEdUbq1PYLD7SJroA3Gote
	bXINXyHnlmOV6OM8eLG/oIEb881biYYMpbkRLKa+dvbb0rLBKQXhjTP2
X-Gm-Gg: AR+sD1108e6hRduwg5bYiWVUPw6w5vZ0OjwFMGWgwDPNYfGsgx9yZUW+apGZq6heOLi
	teiaSzZtBBh8Um2eG3AX8eEQUSs33n1iqQM1q23Wnja+jR6+PyiFv2AZpVhCgKlfIwSotSp1OEp
	fHACO8AVLHuFJt3+b1XjHAzCEvAlJaV83bFydfD/a1zt4vRMuEKouklCqtPMPVr9rLIC8XGVHtN
	m0qHBPeupxnRGsvN+5E1qt5OmG4whEG85HjBMHrgRefxY7rpwKCgtRcjlqYmlcLjjBzc8pNAdOP
	jVc0ZA3yP5bKprCa3xGyCA9mprhCgCvRXtQ8/7n8Yn3MxF/myT/7Lx8Dn/oU9halea+hEgjl6TM
	6gMSDP1x6MauEe6ThLucAkcUYIDX2CHQs1kVbWrRlrKeRtrKTEKxPjnu/JnLJYEsK0GsMVy09ko
	RZ/pdv4MRsF+VD8NJXEgPbxo+2VnIlAsUdmiJB1o93briR9rOlZg/6kUzGjd8KiLS0Gvr57WcGQ
	YNKDNVY1lankoHvOZ/ZXKJOfq5GeY0ihG2Mgxb8kHbdZovHDMrgOrUDyUmEutFsNazhKBRqvUaj
	L2et6xlyist0OQB8q8HtaD4GZZMY9VbacXM9AAJlWgjwHmFiCYeIfWFF+4bU2XaZyyYPh0D4wA7
	EuJDZ+bf/rUBLhIL5qgjBX/QH
X-Received: by 2002:a05:600c:3f0b:b0:49b:9105:cdaf with SMTP id 5b1f17b1804b1-49b91c30753mr238882735e9.8.1788020766759;
        Sat, 29 Aug 2026 09:26:06 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:06 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:25:59 +0200
Subject: [PATCH v2 02/11] iio: temperature: ltc2983: reorder headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-kernel-header-removal-v2-2-c67739d5dedf@gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
In-Reply-To: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=1026;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=jW53cz7kjVnoXurd4I3ohM3xctyABDVxUF7y45R7I8I=;
 b=vRKc/P6bsoTAgoKVduQrnTAL4h9aFwVkauDZfyddLxMN6RSmFItdItNOPs8U8rHKg+72G62rX
 eEKDnvXoETwCdvmQXYipeA9lkZM7KiPckvlDPXTAWmNTbBuIQWo9pGM
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Separate the IIO specific header and group unaligned.h with the other
generic <linux/*> headers.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/ltc2983.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 6efb5252a773..fe9eec3058d4 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -11,7 +11,6 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -19,9 +18,11 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/unaligned.h>
 
 #include <asm/byteorder.h>
-#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
 
 /* register map */
 #define LTC2983_STATUS_REG			0x0000

-- 
2.55.0

