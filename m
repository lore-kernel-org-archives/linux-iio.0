Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAAC3A6F03
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625142; cv=none; b=EvZyg+a6ZcsdBx78nI8k1c51LdASWQjfMMUmymCgjNfCNFKIwAkcHRv5gi/cJNjcy3Lard0T6XoCq3NWNT7Pc3eZ4eSdnrGL6mq71Y/dZom0SIEP6p9RarOxJ/uGdvnJMYQObusq54AuYuNsrFaZeGw+yWgvkw39zH/4s3pYuUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625142; c=relaxed/simple;
	bh=ND2HtCTQC52eoNszzlf2ntg7RmeZZ7jwrn6D3EdhVS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYsocLOZT9J5FfmjPFq6aHXx8GIG/5QQv9bZ9pSmd7EyNhGuNjH95j5ksFaxFfUt1QzD1unUHQiD1bKHhG2agOaKyEMUuRxFHAQ5TLx6eVCMniPG+xt6bg+3N51xCFPs0fSvFeizwLc7mgycYCvHhv1P2FbIR8ZNKdwcqPqkpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XefkX2el; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XefkX2el"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso69645845e9.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778625139; x=1779229939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6/kdt7V8DIKCNh3YMA+Wq12M5OeKEn3QJo7BlhEzSU=;
        b=XefkX2elF3XE0P/3ZHHuM2wwbbkrDITHcRRbJqwdNBb3dtDUkWY+IhETn1J6Vmd10M
         E1Z/V2HfvdXyguuDko3rMyUSQ3Fstf7ja36vWQNtggWHOV2SlcJ+zrQX4MoDLZ+2IPfI
         qO9eOpTWZtibZnRHPPYf3ocN6TF5v1KkuQeD9cL0XWHf97721Aho/FMOBJu/4uCwyD48
         NYH0AwCgBHcPUEaMcBy4o3sVSXltVK6+0tBdGgKK88JfDPP9maAHqG++xWt7SGffC+Bw
         qhgurib6GMucBH+eXQtJISpXVPOex/egfzpZN1jB2TOvcgj5W0GdIkLetp4zpACHGH2x
         VkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625139; x=1779229939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t6/kdt7V8DIKCNh3YMA+Wq12M5OeKEn3QJo7BlhEzSU=;
        b=fAsQwtcvuDUmo1WPWrvup6uRaNMV+H0KFVyii9TIOH6h/VlCr2KjPz4XEIFds6aNGy
         TiwkYFBxaLhzXMwSHjqtmakVp+KPngZUcZy4L7CUURWXufghYcRoOh93HHnexmAGjXtO
         MkOVw2MyqQYx/95ZqCSHzvLG4W2UWwojyYkJiX9+FOni5UMK/X1pIkkMXcASVIQPonin
         0cSQWEuxDqTJVXZZDIO1AmtDZJ8ahJiSr6gJOrF9tC75tiA5m7p4h6qeYtkfC1xFDgKr
         3/0EirwRXka5aa5/3Y9M8xpGkbCT2JBa72HbhAjG5hvFZyJwEgx8j6Xg3ChUyC0jIHwi
         Y9ww==
X-Forwarded-Encrypted: i=1; AFNElJ+rbWldZ2K3qMb/S0iZK62i4vw7v+0O1HietqFatd/hQZo8LVLGVNqH5zDHoNqfzd8sqLtc41ldp+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzawrrUyO+zabqeWUm2wX7vo1JSQyqZ9Cn0CqU0DPFrrrcCuE4W
	WXyzOM7deebf4p2HlX1Q4XIFJJFMDO5DU1yCh0zGlGkGbwJcGamwBqGG
X-Gm-Gg: Acq92OFecl919cfgZMEYJHuoUOX3mLoJ3lttHT5D8O4L0IQR4ENT+jjCYy3DL/mZSoD
	j23AoMoP05IcNkjfH0QESN/XSPdQKCbANYLjzWeIIBiu9HuROaLrJ6Gn1eLtgkEmasmKomdK+Ua
	6FFuAE3JIHH8H/ZbbjE8TWUqBcB1GaclVJxqc1u0eQTF8LAxh/ueevdgHi4sQws+cINWK8fTjxx
	iUhJtKbqKGF0oG7poeyV97aRIHTMqTaYDT8qtEFk2QgxQNsuhQNl7+MFvuIUQzOMcmmx1500v9i
	MxisK1zJwAhTqbgGz1mJaFY01iZJ5DYqVAMUXV0r8TDg4aXS707kgxlklZzJ2KkayPLyBas9W00
	Tlo1z2zZa10X+XT2kjbquGojHLy2d/qPbIzbB51u/sfRFXXAG29Q0s0vPvYQG//8qlXaStBjl2f
	su37P+uqqGj8lEaiNFd4Xdk3YFmMKb5Y2/KW5pCel2DDRk2xe88JOUUe8=
X-Received: by 2002:a05:600c:1f90:b0:48f:81ea:ebbb with SMTP id 5b1f17b1804b1-48fce99dc1cmr929805e9.6.1778625138873;
        Tue, 12 May 2026 15:32:18 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm47377375e9.1.2026.05.12.15.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:32:18 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 1/5] iio: light: tcs3472: sort headers alphabetically
Date: Wed, 13 May 2026 00:32:11 +0200
Message-ID: <20260512223215.25596-2-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512223215.25596-1-aldocontelk@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the #include directives in alphabetical order in preparation for
adding new headers in upcoming patches.

No functional change.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
 drivers/iio/light/tcs3472.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 12429a3261b3..9b0f64cd9c50 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -13,16 +13,16 @@
  * TODO: wait time
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/pm.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
 #include <linux/iio/trigger_consumer.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
 
 #define TCS3472_DRV_NAME "tcs3472"
-- 
2.54.0

