Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEB3D75D2
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164930; cv=none; b=V1fKDLnPl+2tFbFPcpG9NH92MM4z+93sR1q4TMy6Tl0LqmlScqgIWQ+c32upno6xwaxdOPCSoen8XW2KMAdR6TVUSvAHGqOCwJfGaLhsLJlpOHoKgjiL71XWTPsu0EDJKlqcg/Noh1orASH/4G12pmPBZ89eIPo/o+GNn4BnkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164930; c=relaxed/simple;
	bh=04UJ9uO0ADy8N6057D8nFiQ/NIMCKApqnGi41YmNbpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kxm7b8RNwfDzkhP2O2q/iRfaewSZf7amCrdolXseu/eOOQRr/bE9w07C7FK4+/T2WB18oabVhvpUKIHD7ZsWZN6DiA380WJakpmcDVNLVy/29zshRFUCqa/xBiOPTX+D+MYNKIEn3UYThfhnZJQzidt6gHfG5Cr948EN87ButtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYUR1/EF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYUR1/EF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b9b190easo6641277f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164927; x=1773769727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6LuG3NPimfXkyOGf802SE8didLWs7WuYqKmvVqraAs=;
        b=dYUR1/EFyCSDdVdlEYqmgl8zTRuMIqWIVOQLmr75VCNXLBRmbZO1swTM1gsQRJHGSZ
         Eb7vBGfmEeIz1GT3w938n+mQl4TytkY6hHlVCRlK1dzCsPS4AulQtuCtCRXZIrGPWN4k
         9rCQq5V54KiGrdBVQGzAClaCY3gcHsLdeZfF24uKr9ivr9Vt1JGRQk0eRVeD7RNL0nJO
         p85jzg+8i66oiF6zuGCveyh6poCpzfgTHAQXuIUWqS0QvxGasoerz1gPjRChTCRt6KxS
         6GkpYbnwjUuaX7JUDmfT+rXTcnnZqyU8ZINJsmqaorSrErBjbpcQcshiXiHQwbe4r1jY
         kyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164927; x=1773769727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6LuG3NPimfXkyOGf802SE8didLWs7WuYqKmvVqraAs=;
        b=JKv/xO3QAtJPS63Myom0wf1cuAO59NLLAP7wyWrL9ns7OO3qhx2bJsj4XHlZ/CwYpO
         J607JVSCor4l/aNFk3IqiyVoZYe7AtElbWZCK51LXFob4a8XStp+fdcfrOUt2k7yE/k1
         5L7SSmcEYjrAt0d5n3B7G9+ouat2TLanpCQpBv1gcUsmKDqgxXG7LyQADmHhA/M5znwE
         UPu+R8bxICiD2uwILctNbJqiSNvl1Wz2ni/PeMJOKrzoQAW4qxTAnca6GnZy1LalhXHN
         OKlGfEHawcac12tNzegKmcQgP4UKhLP/20Gk0YUGlhK6E1DW83R9/igetsqb23mL6UD7
         WeQA==
X-Forwarded-Encrypted: i=1; AJvYcCWmf7+p7YODVkmATfxaC/vrV4o2fWcbTzMTL/9J2YnD4Drd1o1UKNQ0pl3t010MeokNKOqTaKgO53k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lrjdcI2/sMANfx+ViZN8VmoNKeLbVRG3jSI8zDESS99hvnUU
	W7Vnt5d90gm8J5gZzhkHzVMnSrJi7wTLtNWhU5foP+0PWfVjgU0Rb6Ld
X-Gm-Gg: ATEYQzzymj4Mx057h4P5iK7dyJwm6XgtxGZvIUfrbKH2y3dBKi1YrRcy7Z9QF4Faunh
	CjatOuaAATalRXTeOUFXGPzsgFoWai5yimngD1AMK7jIiRUDuBG/Myr2NY2Jez0egEv/OhUn8M4
	yi+VZ7zLWejbYMdTAhAt0VgMGDnm+sU0gVp0lD3c2C08+RZUeah/pj/Hb8wQxpweqgfxk/7xs+q
	KR8LIY7RY8tKQxQyhtvqVFBrJZQptAALuEh2RMV9qlrwHoVaWZcmXskXPakKsDgL+sPDIO6MKMN
	4yt2rBGziySEGzp9FwDdscCodRfTfl+yPJ8/QlWbEiZqV6oO/+XTjYBhgSZG1gS4bzz6KYZqGq1
	6iKvTccsp6QXe0NeQ4Xhf+DSruIHgF054oKzUcKRLS1zP6ZfPyOxxAPw8Zltr9YW6CVl839NSov
	VrmyAOTIZgYn8izWV4NWU7Cw+kGUFkXBd4Sl4q5JLsAbJeMyAFxq+/bbhw0w==
X-Received: by 2002:a05:6000:144b:b0:439:b522:37f6 with SMTP id ffacd0b85a97d-439da6694e9mr30091410f8f.35.1773164927204;
        Tue, 10 Mar 2026 10:48:47 -0700 (PDT)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae45786sm42986166f8f.32.2026.03.10.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:48:46 -0700 (PDT)
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
Subject: [PATCH v2 2/5] iio: dac: ad5504: sort headers alphabetically
Date: Tue, 10 Mar 2026 17:48:32 +0000
Message-ID: <20260310174835.24209-3-0rayn.dev@gmail.com>
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

Rearrange the include headers in alphabetical order to follow the
standard kernel coding style. This is a preparatory cleanup with
no functional changes.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 355bcb6a8ba0..20a36e4a389e 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -5,16 +5,16 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/fs.h>
+#include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/regulator/consumer.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.47.3

