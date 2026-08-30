Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F073BED7A
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788109821; cv=none; b=gxB2nWpDRdiQYyxfcUbps3ejfUGkUiAPoKeMHLUPobS2oe6rZBqos1vueqTkTo5r5E4+2xDMGzJG48Sj9W90Hfech10/FTuzpou17yV9DtDWd+2zsW1i3Le+F+ifTnz9rAsH6Ja+/i5V/eNUeHbqZ2Maq42tctF/8303dSQCkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788109821; c=relaxed/simple;
	bh=N0Wz03t8OH8ZGlAavGHko236gzmCzIVjxaLhAbD+UYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIe2s1IWv7Ce+kUsFxUJ/4umeYfRrVmT1cPTJ5fAb1FfJyQ2Wq8SVyQQ2TFYZK0qt04QVexMkLV9DecdEPxUbzTXg4Gvl09UIgZ8MWHwbC32LfMLdT4cUHU7R/b9Sfu1zAWJ4J0vFotiIqFJMCRFH1xv3wsppsSJs2yxf7NyvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDczzemD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDczzemD"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2499141a91.2
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788109820; x=1788714620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DSXd07nmgAz6SThzdSSun0e/bFs1/0gaIblRruN5ApQ=;
        b=XDczzemDI8Q7T/ApymBR2tnf3jdTPR0jT1BQkUjmJLEfZqtE5oSq1Z2vkrFT7xh06W
         YVlsB+WWY0ftCNFzseYKtl3Lrd+4VtWkcnMd5EzFZ+LoQdxWyoRFKr7MNWar+PlmGORE
         +R33xsjBiTp/rwXaA6/JZvI87h7zWjMTs4Su2uejFu2b3Zqh8UW2MboVouQMEBFYXhjq
         H2V61LSLXfiE9ef+LbpwSwt/8sToV49+X0y6aN7J6jt353ef6fYRQ7c4p6T1ebbkS2a1
         b2TZTzd/gmorJdF9mBKsMgzmH8G1cuT3U5/wxDasIAStzu8u3Wqq0pnFqOzP4B/7iNwk
         +yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788109820; x=1788714620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DSXd07nmgAz6SThzdSSun0e/bFs1/0gaIblRruN5ApQ=;
        b=S18fBp5qe22iKkKt9eo6RbGOdDqckLQ5ON/QQEWUfITs/nnQcDJlFVQk68XJiCy/ZC
         hYnO/5JttjRkLg/7aXkWgVyNVD6dj+ILWaGYj91c17DucLECjGybfSzmTzRqPxKXQ8Uv
         yCJe+wYaK8OzFGhQF96YaxDJP2Pw4qTF9LBXzufBZVDOpte90PNdscPZJcn/uGGozZqn
         6B8CTvPd1xAS5rk1OK2bdDm+6rZqHiNYaqKTqXxtsX0PqTacK7QeqWHIX6cG0HLojFYq
         drPGrxnFByX+q/Jdi0nfKAel0ILPi34biOOVqRlh0AsnumX8KGPX6WSlK8hFzuIVRp6P
         vkNg==
X-Forwarded-Encrypted: i=1; AKwUvBxLbc9FVfCgmFj0n9Fer1/Tle7u2r33tF/wy2mlA9psTRqLCWV84aoKA7JY8Hm4nd1mqm3oLgRiLms=@vger.kernel.org
X-Gm-Message-State: AFuF++kcvPEBzfyvsMTVeMT+YOhn/Ihig4Xfj8PFsEq1b1IQV2Nu44Lu
	MjLk3yLV7pannY9xc0Ddn0nZn7CiiLWJCbRe8C6NMTs3mmQP+RCl/TBb
X-Gm-Gg: AYBFou355TfYt71n1BOz2/BhpXhcJrsivoVEpMgCkw/rgEUEU2YLyw6ptw+dABw66dh
	LEuWiRWKld3HRZRElW94HS/xa95YFDjoPZgRYQcSScBVK9rxigHGDaltxggSS4cAmNxDMURA/Hf
	Xd6FjjDHE7qef1XPdvvN3n64+xc+XZXYtMffdmdSNPZZe57myq/dQRYlBxfZaLb8iZencumvmKs
	wDQd4n74OK7O21gNNCRktb9mYqSUS8+aF7bXYwbgVYX19g2LTJbKk6FVDEQLoPCyU82flnItWHJ
	kK+yR4fNcyR0IqjDKybgbLLGM1OPmU9DmOUbKNpTGyy9E4cXpHkjdjPA0msONKjRuoz5wl2niE5
	ekap9rmmi1i/O+T2nembSYwd6yDLKg1TzAXhFP1Bc0dpMkQ9+ukxVL+AiA3M1+9EQfd5Gbvo+Vs
	ZzeQ+Znw4Jx4gBlnvCbcLqtIk8vqBM+Z4EPug+5aDOEG0GI20HZ9mBNW3fhQ==
X-Received: by 2002:a17:90b:5284:b0:396:4dfb:5890 with SMTP id 98e67ed59e1d1-396d0e5bbc0mr35517294a91.2.1788109819698;
        Sun, 30 Aug 2026 10:10:19 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:88d5:45ce:40e:490f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm17047101a91.6.2026.08.30.10.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 10:10:19 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v2 2/5] iio: adc: bcm_iproc_adc: fix include dependencies
Date: Sun, 30 Aug 2026 22:39:15 +0530
Message-ID: <20260830170919.470974-3-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830170919.470974-1-mdshahid03@gmail.com>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Add the headers required directly by the driver for completion and
mutex APIs.

Remove the unused `linux/io.h` header now that register access is
handled through regmap APIs.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index e46e3761993a..2b59819c4ca4 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -4,11 +4,12 @@
  */
 
 #include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-- 
2.43.0

