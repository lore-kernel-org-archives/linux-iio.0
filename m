Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357318;
	b=UBBo3zfx9Z9oNdr2u58GrNDODlimFU1ZJ6xrecV4+uxkPBthpmSydDdoSbXSlpEG4qqI
	 TGgaNM1HMlP/b/7F1GmOUn90ujdLdmjYpDBAUD1XUt/UsDCtL/8S6m2Fe/tmVsIY6WGOR
	 ANmqbgVikuO9hTtFmSJOvO3ob+NPOwFRm+rVqu2HsZkdBR7MIq0FIwoaezRBbfD4GadeE
	 hgUAiggmKdDJCnxkM3JauDfqAbs/KN3+sdH8AOdYMnFm6ldgLOyJmKOS87W6Zt8cJ4UE2
	 gtvYwm/VxlQt3EJ8aSGiiJFFmyxXHKYAsc9s2izHmFk7siBEI7CcWkaG7BpBekm2seg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M1z9/DW1dCHbs+qEJtXcl5om+PqlKumxC7fOSdG5ZB4=;
	b=rulnTrkdLWPbWz7MVKUCAk3JHNp7L4FpqCHe0dTdzq61k8Ud81C74HIZ2I8dcVOLojpQ
	 Pvb2VLTfTbtYw8zmHAu5gsAJhCBviE0Kcr4Yl76MZZfy3mDaalbjJuaN5ZhRCm29NAOKv
	 SnlOaX/rVIZpOm3Lh3bFoIAr31Z7wUvOGtsCH6pz23sxsoAHlODf3rqpjI4no16dQhYF5
	 clDg0ffqpUYGLJSnI1wtzxTrEpamKbHXGhqzmaLjXLUHy/2wb5d/t2ZW0cTygYPOjAIhE
	 bUEOHelC5dt9FHlnbRsLw9r14BENA7FkPapYoBlbcLgSDLKtRAluLZio8m1pmoy92DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbOYjEda;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B77606A320
	for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 10:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B77606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbOYjEda
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e00eee27dso296780f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2026 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357317; x=1793962117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1z9/DW1dCHbs+qEJtXcl5om+PqlKumxC7fOSdG5ZB4=;
        b=vbOYjEdaBbyMdhIQakogxXUu3241PunB6JUFa0Iqc5AMpqkWSzGmMI1+SaDwdNQ/KE
         GFGm5ZGi42VCa2omb+54oZ1wviKjP3pPFPQhXs6Yo8L6OR3LMa6vz7Q61bdJ8bpJ/2Mn
         zQIuP/M/uZr5JEgiBMAnIiGenKZn6IGlmY113mpeiaHyTR0uOkSWO8tH8k/wCQdNd1Zy
         XM9iQNqcJ//mx5gcxgMREeeEI6KMlPzWVMyCmQCNBTRl9JUwGHB4/UHBWmd9qPp36Iai
         pBa/Q8DmJ0NtzyyqpP44dkXUOuHNhxWfMSTUuYJ1GDAYJj3/WHZmNsOKy99OUgsohD6O
         7NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357317; x=1793962117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1z9/DW1dCHbs+qEJtXcl5om+PqlKumxC7fOSdG5ZB4=;
        b=CpKQNLWNOlKS0X4iE2KmvK6WKou5zIRohozwP30EsrgZeJvzK1SvzGreR/uMtTyGIN
         uQNCrOxDJZianv6q5LjTeLnKU9VPqhxheUaHL1tX1D9IxFMEcDhbkh6FAgFbRU5UI8fh
         /RY8VqaHyj8VHyGPZLnwFNHD966+8j2dehzPn3N+EqM5taCD7bUkM9Jcb3YgIvXXIY9P
         I4zbBxWF/0R8ZqDNxtJ/NvSvujxbt9s3TqmEQq1fvXLobc6c8pbYFL3LgVAAg+LgXXK7
         viXSgV9oIRw2oIFaYqy0XsHnzFIr4qp/CGt1Z8+BPcV9rbLVe3bYFTvlrHyX7eHAsTVL
         F9Dg==
X-Forwarded-Encrypted: i=1; AKwUvBxH0sjgU/kFq8TOOLRESORrfVMABR6WCHdM4CPj8hxDXDqLaZhTuXw48zeaFNtHt7JulMGHZz5NVjo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKT88Tnmpli00vN0J9oU5FO/l23J4UVvnk+pb9an2Lki0eqlBu
	45J2qDSVaAP+2Sctwk4xgMwOGmU5fH4+kXJ2yly/xn0NKzRbRe3IcarP
X-Gm-Gg: AYBFou3jqJ5cpiadcD7j/HoQzOazqUyMqsZRzHfcUckEyRNQr2h/cFmZI8RyOjstJrt
	3CAfwEFVTNFD49z1VPaJUIYFIjpRpoQ5qeHxbi561bc4lYo95iFfSpB2AV6d1uImSuK4moe37za
	tezy7T/Uw0etUGWoVwrMuGlXzatav0pnACGWIm+ec34OAbo1ypidZKYpzF5hb4q1/utO8SpdmM8
	OgPyDsl4g30bD16KWIZjfypICDKyUcZhgj3+Zkl4pdcu/O0hg5psuX+fa7MsL41BcUErXZ6O0cw
	cuHZqls2Bmjh47LbKMveQPKMcbHNb1hfgEVjC3AwEPXrEFwr8ickWHAWbDa/7xU6zso/YMoVokt
	aScHeTrnBgD10MM01TBzwfnh5T3fbvIDCbo6mKSMkQs3JhMljCNn0ePd/MeLxgT89txg48d/cld
	VHQ4Y2/Q5fbPwfLaxa7BD3B2eANMpTuBFSEkLLzuvRI9JRstXLWFJWpyCxAKYScdT8y58aWVRlF
	aqTRg0LRCJkW92jelstSp31TRktjosyoNBzn/oZpMLiO4p7TVyhv7yQpwaegENtcZaeuJVlE83A
	9u9CUuGzG+M8Udc+iKg2u3Cmm1Rp8DLjeJ666WMzU9HNjn0UTNKSdfVd6IPj
X-Received: by 2002:a05:6000:4020:b0:48e:791:1cb with SMTP id ffacd0b85a97d-48e6e4f502dmr4669993f8f.35.1793357316844;
        Fri, 30 Oct 2026 03:48:36 -0700 (PDT)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71bae25dsm2240473f8f.59.2026.10.30.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:48:36 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v2 2/2] staging: iio: addac: adt7316: explicitly include missing headers and sort
Date: Fri, 30 Oct 2026 12:47:45 +0200
Message-ID: <20261030104745.16693-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030104745.16693-1-abdelnasserhussein11@gmail.com>
References: <20261030104745.16693-1-abdelnasserhussein11@gmail.com>
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

Explicitly include <linux/err.h>, <linux/errno.h>, <linux/pm.h>,
<linux/string.h>, and <linux/types.h> for error handling, error codes,
EXPORT_GPL_SIMPLE_DEV_PM_OPS(), memcmp(), and fixed-width types. Drop
unused headers and sort the remaining headers alphabetically.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index d4b759ef637c..54d942cae586 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -5,23 +5,24 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/workqueue.h>
-#include <linux/device.h>
-#include <linux/bits.h>
 #include <linux/kstrtox.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/i2c.h>
-#include <linux/rtc.h>
 #include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+
 #include "adt7316.h"
 
 /*
-- 
2.56.0

