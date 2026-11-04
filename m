Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817319;
	b=YISSqQOpJ63ub3kkYiZJ2oOWkAuRc5GX7EltY/SYGS9RDB4hWFKhXsEHP07lGAK90Zv4
	 Td2sCv3kuTedstuyOZPTl7Q7llIsKEGzo0OpdHOHAObud4WqfoOciqApW1+/ebOuFX6az
	 BojTLJcJNCJOFbd4cTFhbbDSaSuMdE/VHIZV/m6ic0RnCEfd0pUOu+fcZwxkPy1JhMFzX
	 DEwY4lYh49FYKCHjQ9kN3YnDw0A8d0BYDUSEpv0Vo/ELorWnlx0m2xRjTLyiJ7Ji5Ebzm
	 NJiWRXlUJxMFRo4zPkaHZbHNjMOdtQbPbIRAKyoEjSjdgo7YtXm9B9OVwLqfz5rWvsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JcGDDVLFabrkV6b/q/P+th6iJ/MJURW7IlDAfrljWjc=;
	b=fHJ2HhhYbjVzVNp+ZL0JOsms9laPAO7RQqUtMQGCQCGaaKKOjpvXMCZMJZyHAjKCqyd8
	 3LCcg/Bj+4HJw08KGdEYWGoyfiN/+EiOn/YOJueodyi81qs22P1dN8Fpb9quELRX1Jdcp
	 SM2+2yfdXKuANMf2kkJNhJWFEqhUXkn1pTgyNlNdrIxIyWOPigxrkT12HIuL0tABbej82
	 y9pictGxunVJHOTSZGF7S4NO0XLclUBZq6n3oDhVVRsDtzeBXyjYMzA1EOmSe6w8pos/T
	 nuh/uOnPQpmRlbwV635+u99gtQglKOejvMhcQS5ZnwDadELVx823XKjd+foGx3/CCqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2bgpExK;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E7606D821
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 18:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B0E7606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2bgpExK
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so12956485e9.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 10:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817316; x=1794422116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JcGDDVLFabrkV6b/q/P+th6iJ/MJURW7IlDAfrljWjc=;
        b=u2bgpExKvb+SNLNVJWcB+8BYoZisdBATOrf2Vav8+GQNUXakxJcit4OcWIk/5Q09Ra
         K1MYw3BApB/beTooo2em3NZ2R/9aRH3oeol9QMBYi3P/ikabYXEzT2OYiW2JJWGxUpL0
         f6mgLw3yooteAOVuLmMc74kvxTURicgGn72Y+y+gKOMHqoXI6ikkHJGvcUyY6+cFKc5O
         mhPlpmwjSJTj37gNc8ctV8T8p3lVzsJnCiuzvo0zft5l/7qw04FzrBCAEoDqAp7VQ+ES
         QBXmVnw93jsiGMXzBuO/1yHNycMLf9KGAPFOgPns7mE8DGdWZTiASjnXC3CHDeG/+av4
         pCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817316; x=1794422116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JcGDDVLFabrkV6b/q/P+th6iJ/MJURW7IlDAfrljWjc=;
        b=QyN9D0jvwIZHtEB5RCbijBIC3ZTwQ3etC9CDUrdgLPC932U5W6RWSVV8+zEvBs1MRh
         3jrMeZBIhqYehC+OcVwOyO/6+xuNTD4kpqySzQQM9TBd9GNbB3BYPd2lz4ymAArQX9tI
         umTqfH4LW38E2OkcjdQWLkY6fzRDdQkmhkFH53DNS+1YgLmIXTYx393zLl5fAWYDbvpw
         11/57UGGE5idfb6zpgaiHUx4hcigMtm71vL+pihE9aNAE73+lIlOAuLtGDsIaXOm7Lx1
         WVHMqMg+RqMCsPbpY7JgjobaZYkGEHhaxX9QuDg6yMOFZfk7b2b+y43P6BFkL5Ap7DCD
         mifw==
X-Forwarded-Encrypted: i=1; AKwUvBwzKctWq90Iz1920y8lNLePzEyOWRPAzyX+/fKYULOXAAcifuQnvHALh/uqA/CMVljJnosSZJ7IVBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SIQLO5LhL84mqnfJ0BZvwQ8LWsMOimnuBJ89khMelPH/SadYH
	kMovXTJrY+CMROdzAIxui1XECAdPj/cziJ1VWwTq3g65FarTMfVlfLak
X-Gm-Gg: AYBFou3qOLzAW7hqeZGPaeHmUOx12/jgiPnQy/1YW9lxAu+Nc+9oCBJwa2RW79s4Nxp
	yk9h1ySxmh5Xd/b1E4UWfUofntqfrHU/RVXnvsi+HQL5tO1wuRgDTl2w/tLe2yglj1TZXhpj9PZ
	kTW41BX/yXrsgvkrALApcnR/HXM2lnuiXqMdf6iaMCXeyaloNyOVUSILNxLbXXchiCdVLHv5n0V
	X7byyMKbmBXMtyMQK6O4bsB5dAb6k/b92eZF/QViW1NiX9inYdUc8mqz16n8yRpXbZ4HCBtRuIn
	BYNthwkGqX7ntMEvmCdX3eqvF7XRa1qUZH4ecV8G857Mmx9VFdt4Qh7X7w70R1N91iD2R3I2QVu
	Ic+jkssEYoH5jWo2BkipeQcaNa6SUO7Mpuu7hcNFblb+tk2o5dqimEV0vWKqe1eP+ssmZbs8pMU
	B6frr/Q2akR5ncK9BdciR2rFu4ZHGfdBfdnLcCPlbbE3JJ58zvRs3uVzS/JXORZo6wpQx8ji5fW
	r01DaGrlaFowka4ksRfUA8GP2mOytm/mwSP6p+9OjZMS7fIMq9tI6wq9MFnGrw5fndbANIJpYkE
	yGS3ke9BUECVYZCZmFjyDnZIOyWxN12hRVEK4hluHrB1bi5fVsRlbSUYO78=
X-Received: by 2002:a05:600c:46cf:b0:4b0:b9ff:1e7c with SMTP id 5b1f17b1804b1-4b55e07e569mr5336135e9.15.1793817316624;
        Wed, 04 Nov 2026 10:35:16 -0800 (PST)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b432a883ffsm31404915e9.3.2026.11.04.10.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:35:16 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v4 2/2] staging: iio: addac: adt7316: replace kernel.h with explicit headers
Date: Wed,  4 Nov 2026 20:34:29 +0200
Message-ID: <20261104183429.20125-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104183429.20125-1-abdelnasserhussein11@gmail.com>
References: <20261104183429.20125-1-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the proxy header <linux/kernel.h> and replace it with direct
inclusions per the Include What You Use (IWYU) principle. Also remove
unused headers and keep the list alphabetically sorted.

Reviewed-by: Joshua Crofts <crofts@kernel.org>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 Headers added:
 - <linux/bits.h> for BIT()
 - <linux/err.h> for IS_ERR() and PTR_ERR()
 - <linux/errno.h> for error codes (-EIO, -EPERM, -EINVAL, -ENOMEM,
   -ENODEV)
 - <linux/kstrtox.h> for kstrtou8(), kstrtou16() and kstrtoint()
 - <linux/pm.h> for EXPORT_GPL_SIMPLE_DEV_PM_OPS()
 - <linux/string.h> for memcmp()
 - <linux/types.h> for u8, u16, bool and s64

Headers dropped:
 - <linux/i2c.h>, <linux/kernel.h>, <linux/list.h>, <linux/rtc.h>,
   <linux/slab.h> and <linux/workqueue.h>

Changes in v4:
 - Moved the list of added/dropped headers out of the commit message.

 drivers/staging/iio/addac/adt7316.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 515f1fdae46b..54d942cae586 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -5,18 +5,19 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/gpio/consumer.h>
-#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
-#include <linux/rtc.h>
-#include <linux/slab.h>
+#include <linux/pm.h>
+#include <linux/string.h>
 #include <linux/sysfs.h>
-#include <linux/workqueue.h>
+#include <linux/types.h>
 
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-- 
2.56.0

