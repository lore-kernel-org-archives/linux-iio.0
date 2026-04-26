Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303226CE05
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777238437; cv=none; b=E5IVNhw7lHUADWvcI/CnD3KbQiq8DV+mBbwMhAjaxXUhTFtQYVGXJ5JJDBOUy7sMUqvyDm/44jU8b7Z6i3lVa6jlRF4rOe4MEdOVFT9NjYFU4hDCt2ypj/o/mWQKP8qL/u4nCv+kPvbD53HhEEFD/Yokf21ZIALYOQ3KMstyzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777238437; c=relaxed/simple;
	bh=fgbTKLalBkEql65GxS47PppD+hlfkIgSpzoEh3QF/8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVCD6BAdYqgp+6q7SR1MbPpD2k12Levo/bNH7NczPb4szHPs6Htd1h/C31nvII6HPdtcpcMbGDzwjXLHxL29JX/HRyfLBJ/GQmFAlsu1+llNDjI7cjoxD21yYO9p4vDs2LJ10tbJiFinyhE/7HISyoblZ5CTQTfKWCibmk9AmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=tqkjmeBM; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="tqkjmeBM"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso5165418eec.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777238435; x=1777843235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+z5ks7FycyWyhSB2oeVofN0AVLQLkvT8Z6YFVDa6do=;
        b=tqkjmeBMnXlvF9wC6Olly7QLfTkbNdFCxKGXqvqOmbKcmxwsGx78LbrczMudHzNCF+
         qqYNVvlXKAl7Mohs7GhqJOEqbEbY6Puvs7sxBwA8vzszPPMPFhb3ia804+wS0+M6/jDd
         JwrRsn+gVUe7vkYE5uDPcbu+7j+ycux4I8I06xXs27mHiUE5LdZ+21nLnC4snotBJ/E7
         K+stiFqjdaKdsM7g1ek5e8tb0YWBrlO1UKZnkAUig3Ax4NiHcobXuguILInqhC4R/LRV
         /x1S20szfcX5mV3glST7WJSWpxitx99dIAuwota5XnXEBz8RI7CaqIQK6k/7eiNZuGGn
         atDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777238435; x=1777843235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D+z5ks7FycyWyhSB2oeVofN0AVLQLkvT8Z6YFVDa6do=;
        b=j1OxzNQOFb/DU51kXDDyBHnWacHagQ1zJqe4iO8aWVn6qyTk1DLNpmAmLHI3TVnSnU
         x8Ro786Pxic+99OYRoDdNpLTG6Eq0Z6VZW4DqN3uCRytVq35ejvoc6DHKhh8imgC/i2t
         efcuQiQkY0f3gulHsp/vt61q1gS8FBstibd9ZOVZIt3CHy0zYu+IPtAyP1SuKVSmTi3I
         xAN7qrKZfnQHAyZsxwuT7Vyo+gdW2leSaLuEoboXpMGRR/PS3qj9rM+bfnP/bCPV9HBP
         fkGN6GQVWRa2QXCN8ZiofqEqJFQN0UMp1SOo0vIbCZrsfHXdhJAivXvGVqk2iE79UBxs
         EhPw==
X-Forwarded-Encrypted: i=1; AFNElJ/e7DHli28kDvFBfbnX55yOtuPBCVuA4jQqz2b59jhugKCVaa3PjRwnIDiUPNomtLgty7GdToAGXjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZScasq9+CtmQsBEm5m8cVHXNv+BbXBHKxb1/wVA/truEWDwpD
	ROv74/xYj5NbD3q5YA2faq5v6b+jN7YD6MI+rY5wPuDzf9NUl55TsKlNiignb63Z/gk=
X-Gm-Gg: AeBDiesADbM2FCNTY5kLv57kAVl8RWn9O6Gv0hLa1BXUcA6w0813sdTYz0+FBkvARde
	3GMBfY/o454iZh1L7Oj7g8tBgdx2VTYTPJiZYLiTK6LCUqcL4szHBg50YjqdCnwSaEhTocsuNwa
	eYzKIb50kgwn4Ktgi+gP6X32aUNHyO73I0JyKbMyRO+o4UdW+Rs+KTq604sMwLvMhZlQgnPhlo0
	x1CfoyVuNPow6Kzoj67JV1KpqVZmdL4IQ9Fvj+odRf9kpPI9PzfRz9EIs2Wm6mys5blwZPgDeyS
	zDSy65nlPgShXp31zxpcpPmNuFNse/3GBriK69oTiu6LYfoCs4+k9WZJLHxp9PAJy6iNIpshIsC
	ZffJn7FmhP0VmuZEA2ywHJVMxRysnBEUuiFfZ2IkFw1uk/fP6yU+2ZFD4zmabGFiNZKDY4PCxvM
	NbDRrDGOmjdhqWnbRflJS+ud8LS9UhHiIjK6JEBU8vaw==
X-Received: by 2002:a05:7300:dc8e:b0:2d9:db50:c6ce with SMTP id 5a478bee46e88-2e42c348309mr15335715eec.3.1777238434861;
        Sun, 26 Apr 2026 14:20:34 -0700 (PDT)
Received: from eileen ([38.10.153.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm40799122eec.17.2026.04.26.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:20:34 -0700 (PDT)
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
Subject: [PATCH 3/3] iio: common: st_sensors: fix includes with IWYU
Date: Sun, 26 Apr 2026 18:18:02 -0300
Message-ID: <20260426211834.3318306-4-caiomorais@usp.br>
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
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 7 +++++--
 drivers/iio/common/st_sensors/st_sensors_spi.c | 9 +++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 7156302fe..04d106def 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -7,12 +7,15 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/kernel.h>
+#include <linux/linkage.h>
 #include <linux/module.h>
-#include <linux/iio/iio.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/iio.h>
+
 #include <linux/iio/common/st_sensors_i2c.h>
 
 #define ST_SENSORS_I2C_MULTIREAD	0x80
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 0da270139..884077d51 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -7,12 +7,17 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/linkage.h>
 #include <linux/module.h>
-#include <linux/iio/iio.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
 
 #include <linux/iio/common/st_sensors_spi.h>
 
-- 
2.54.0

