Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F73D0926
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682145; cv=none; b=arMTrsdgw/ICmYfRyJmPB6fFPLki77AiYTA9bQatWSgAHferWWMqrdnKMCZa9Lis5TGkilcHBTrF5sxAepiccwPXui4GuR0AtP5tJhZS9WDiA4ryEewbK3gUU4CKTgyiMhHXtll23/n+VcjjhphQSR4hy5G9zIAu5hsgL5DSu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682145; c=relaxed/simple;
	bh=z4yW/nq/gH57s9LLzhEva3zX/HEYJchu5fAChxwzgK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etTh2lit7BdwV3gthdKH4nl2e2KsfbkFAyzfyMBtBkQoOWwadrDjvqLdjgpf4+3RpGR28v9477F86kj4qgw6lQ6hG2ZLQldNnGRey1YtEWKiI0Kn/C5hfMN4mZHvKeV7N/1b8I0FzPrOOQswepj8Ek7M2JRLqqdTsEcuIWcFhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLImUB94; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLImUB94"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c73fbdd9b53so582921a12.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682143; x=1774286943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOhJ/lwU9KDDpeFGn5q6vhHBhWgqXLc//w/UfmjlkgE=;
        b=aLImUB94Q/LF6hpVMvWZEmnpC1lHPB3pV+NeSU0eCS6z0rokmUAvpdBnyUevj+DEAl
         fhnNA0IldROgS+N11duLHFD+ydcyL/dWM6GStYcCI/tc6/ZL8PjempDEVdNOa4iuK6zR
         QalPWc/B50L3dYX/1VBQS9HsCKWV8aM01166tSY3qMaWdqMXBtbzvwPHySQ/I7rPKC+Q
         MjNeQ2moVuQ38UfL0WS1jRU3RBsahfR6K+FlEFbVTQo30UcZfVSl2bSxCkVkQeK8rpmx
         vbg5ZSdCeyL95wpr6sw5ZoRR6asDSR8bhyo6k7eJlFsZOLeYwcIOp7scupeKdyJ4g8VF
         Gtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682143; x=1774286943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BOhJ/lwU9KDDpeFGn5q6vhHBhWgqXLc//w/UfmjlkgE=;
        b=q/anT4uKxSYlpKRsqcWFkjr0BeojFHaCq2m+tOEJOEuj5SdUgeDd7jWKdOb9oOONrD
         gsEIS2SceJEJMVsG0AmdBo1tWW5VqQ4mAv/T747A0jriuhK1n4n29IyuXMhhtsT71FXZ
         uqwsGNggRnElVZBFWSBe9yC8hHrctaYTBPkorCeChUjcm7OTPF/7N6nWundcw41z9MAL
         hDGmqOR5Az51tvvyN323sWZ1MDl/Fayns/wl0Pczun/TDAWDGSiDSk6apCkATLH6oS9f
         hV/N/C329Z207c2DI5NESTZhYgz0fpCZKC8HP7daipz2NVwwz0CthtSChnI3fCcqumda
         2r5w==
X-Forwarded-Encrypted: i=1; AJvYcCW2kHKAF3HaD3ffbS5POB59MGZvGUsLiayIXCQzoG4IIWK1S3zBZR6Pj9vcJC3GvW9mseMYvN5wW6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNDquux5n907LRm73nJC8L403BUynqe1LmiHYowb5KWXBzIx5
	23+yuIxXyo+662I0+Ocret5407as1Ov1ARK7Uep+5li+LOPktEDDswuy4FK6YQ==
X-Gm-Gg: ATEYQzwgssRkd8vqHQpe/AaqVvwe6/XJO8ckVzXnIO4f+VMVf+lZcQEVc3Ot/+Yst0q
	dsEHTNycr8aTUoAVGzCMzwFUf7PesXE+oz1lHFgH0Ip5lD4omTfUI73MUUMyMf8vS8ZV0pijGg9
	tcOE7bhuuTADTUjGXymdc+l9vsrLWIrLmo02D//NqNX8ItXb6A/BpzPdNe2MOadCGf3aM7pycQw
	fa7ET5UC+WcGYzaYK0PE+hS4+KkrljCNmk131SpwNcLthoEw4vllLmGeyKZlLZlAanwJyYGx3f9
	ICNGkGsd9hI4IF/SQnSD/h3aOWS/8HOCkkPfrekFFPRXN+vKQ+fHgrR7hC8Q5IzUwkmgv7/AO0q
	ytRyWJawXYEtMuRf+J8E1e1GagDFN4F21tdfzuiHLjnxsNZfYYLjxpJ4vM8Ay0q0QJE/qgENWxn
	ravMeiAfaBcTIu4gnIM8RXb0bTwRy7XQGMISIen+iDssCi9ZpWTnsYW5s55e7B+aSvFEoktYsbv
	u0qzNGZC/KiZcU=
X-Received: by 2002:a05:6a21:7701:b0:398:951c:b5e with SMTP id adf61e73a8af0-398ecd1f963mr13054687637.46.1773682143365;
        Mon, 16 Mar 2026 10:29:03 -0700 (PDT)
Received: from atharv-HP-Pavilion-x360-2-in-1-Laptop-14-ek1xxx.. ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07341986sm14016183b3a.32.2026.03.16.10.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:29:01 -0700 (PDT)
From: Atharv Dubey <atharvd440@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Atharv Dubey <atharvd440@gmail.com>
Subject: [PATCH 07/11] iio: adc : at91 : replace deprecated iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Mar 2026 22:57:33 +0530
Message-ID: <20260316172735.11430-9-atharvd440@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316172735.11430-1-atharvd440@gmail.com>
References: <20260316172735.11430-1-atharvd440@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_timestamp() is deprecated. Replace it with
iio_push_to_buffers_with_ts(), which takes the buffer size as an
argument and helps avoid potential buffer overflows.

Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 920dd9ffd27a..840dc9000022 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -275,7 +275,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(idev, st->buffer, pf->timestamp);
+	iio_push_to_buffers_with_ts(idev, st->buffer, sizeof(st->buffer), pf->timestamp);
 
 	iio_trigger_notify_done(idev->trig);
 
-- 
2.43.0

