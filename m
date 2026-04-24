Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED08347C7
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018721; cv=none; b=eSh7xgHC1Q/s4q6Iqzp5Ec3m62iQX3RVYK6+dfYkylJD+XPgJisfiSFaZ5gWIehTxEoihB3zw/aYNBEH7rmqslFEfmrKXoWGFxEpiO7nBqZJ4/XorbF/ydDFiH+Gb03nymepfW53eNvIVqRR/d3AE/KBIiBLemMXOFP4CSFBSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018721; c=relaxed/simple;
	bh=XLw5ixrkoc3lhBgHleHt9M52aQ7Z7F8SMsJ3fnIk4XA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKLwA8sqxCsszSFLNneF9AHqrfJaHNpgX0R1PvCdLAxpnD8a0nAjbm2RxQHmj8jf0h1yl5m+Xn5FFEJWEp99dqYqaHBqqHSsN5wOcTELc53jqUfoogJdkmoZ6Fzwns6JxxJHntvQ7I4WE1/IB4MwEs84mbVjK9geNMHITwkCcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV+Dc+0K; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV+Dc+0K"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48a525dd2b5so4784165e9.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018719; x=1777623519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq2CPbb6w1adjueUqfSxZfct/DtrwXp3hbJcr6yIL+8=;
        b=cV+Dc+0KIrKgMfgPnen/POQRSknEjvPpD/Dm/oMWtiMuQ3HmYr3NmGSi/IHnk+Ye+5
         27aNuezVbWDykZqrTFJDL1XrEsDsLrUrYanAg+1OUJ4U60q3sznx9rd6qx1VPFWiqhiG
         kOOeP3ryJp2A91rOoES2ijKIeN97gvsG5zFmhh8+IE/L0By0rMjaoJqY47nOmL2HPma6
         3WV/5muSvvY/XAynIlgPcuSQCMML6TmzufUxUOTyA5DZS4A48YWKWl6DKCgVCFBJT5G6
         9MFKONiuLIhal5a0cwgKRzKRdYMC7qcVlvLGteU0pHk6BNJ3SiuslaGOmGxo464BB2TI
         0YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018719; x=1777623519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq2CPbb6w1adjueUqfSxZfct/DtrwXp3hbJcr6yIL+8=;
        b=RNUHsRSyUQvVswOdmIehgrm3ep5QmzeqJESaiMcOaqb7IxxFN0PFw8Bhk/hQoltutN
         X4KiO9W9vLfIGVvPxUJRxhdH2J9e0r3qRaKYieHAHjrL9tjMBcZbikUk0WFRcUXca20d
         VWem/cltLyYc+GVQT+lJi2ExB8s+D0SXwdEVovKEHaLw0KWvPC/ZDUGM5UDgi0IoTdi/
         XQu53wP+vngI+XHJXdWCawvAxF2ZaqNDKTjzNMdFadYuV3IdjUryBx3oMawkq/XyIM8L
         tKs7G1g4sB6+rYbyAqnTR84VkEyjOHREcPmAMZPycbvX0b2o04DkY3NFDxhdsb7QP4VH
         ywDw==
X-Forwarded-Encrypted: i=1; AFNElJ+rFreoB0SSHmvecpSDtCM3iQj/TckUNZMVTvJK3FWRZKhQq9ukIhjE6IQErfx1rQce2ltkN1+F9zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDCJZJY5J/5m9eV1Bw0RwMP2j6/2pk12/xWBMYmM1czUucr1F
	2R0EMBPXyWJC/5IPHrkQkEgnkvuv9oF2k6GCb0+7iKrIxbFfbKYKqES7EWwPAwxOAxM=
X-Gm-Gg: AeBDiestw81sayC67VSHI68mYV1zbVvbm4VMX6Xbek2hiXNR67qOok+SycDj1ji7WIw
	D93dLxnfhfg9A8otID56vubSbJRnSzAvvVQE0t6DnzE0qK9HyEZlU8ZoaF8pLylrmDFgSSEHsN0
	yGQORwfnYlm2nddBm7qnrGLal8MVASpcjlsz2vUt74CZfCGOeFqGLLyAIUgKctu2JS0lqNv6IcN
	74fRVU3K8wkV1mOHs1NsZWpktjkEiU33OftMdR93R7utTQhwotyAvSI5+p1WzRT+LDHy2vxVmQ6
	mrFrnZTOPFmgR/9LbjbFL0TiVo7ybA/UZtwJtuCtX7aHM+Lw82zAfv0d4aXFNJu445Mo1oYrRO3
	sTCCyVHdCLEod6w49PRiCKDQ1keQNSkURDQYdJufVCS7qlAGqcLUAg7aljPerEHOGWs6tvYMrLF
	jAzhQwTqZIVxB50rRVER910w9hEAEKcSm8kANWLPMgLk8VoNOnmVnhIW/y0mEjD5EZ1a796dr2Y
	O5nqbyChmfqJLzX/wfRWMSPX7JSPOS9dLNEFmmk912cUNmlCtO0wXp7phpmH3U=
X-Received: by 2002:a05:600c:4753:b0:489:1ca4:c999 with SMTP id 5b1f17b1804b1-4891ca4cecamr159653145e9.8.1777018718584;
        Fri, 24 Apr 2026 01:18:38 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc5e3f4sm315248565e9.2.2026.04.24.01.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:18:38 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ti-ads7138: explicitly include <linux/slab.h>
Date: Fri, 24 Apr 2026 12:18:10 +0400
Message-ID: <20260424081809.61841-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ti-ads7138.c uses kmalloc() and kfree(), which are provided by
linux/slab.h, but does not include that header directly.
The driver currently gets these declarations through linux/i2c.h.
Include linux/slab.h explicitly instead of relying on the transitive
include.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ti-ads7138.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
index ee5c1b8e3a8e..ba1e9af92c6e 100644
--- a/drivers/iio/adc/ti-ads7138.c
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/events.h>
-- 
2.52.0

