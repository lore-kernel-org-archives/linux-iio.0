Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23CD3F7AB5
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831922; cv=none; b=Kf90OjgO+zdH0JEGsm7BOYoVYj/clIDsiTP/dp+OweOj1nbFT/VYvPvOYF5kZRBoGY4YNAHJhwyCDEvm6BeCnC4arS7w5C2af0ItVM2V1CsaNlJBGcovLZwCHRzmU/ygp9kHuQhbmu2uRWctyvyso+h78DEM1VQhgNctEXTc8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831922; c=relaxed/simple;
	bh=0BPD+9vjFSgd3h65DskY/GMiR76jSb75S9E/lfiLFRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EETHr6RA+b7VDzdd5HymytIVMObW8OrMCffp2SJoYnskICUcNfdMIfcN3MwToNAppKjaCPfqBW/m6BMZUfiMPcNKkmKsrsmLvmJfXR1ISlgkEtWk7sjsye8QPTJEka89tfDBJh8WkVqp6OMp2XtT3hU04HKX8zEGgiG6dDuHKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqiQOqUZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqiQOqUZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso3646012a91.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778831920; x=1779436720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2RAe37c0Y+mS2qQ9ryuy+Bjx4murGSjLzlq4yUfzjU=;
        b=sqiQOqUZt4W/w8b38r+A8VFw+bAeidEnSjTS99O9bJ83X//CaF7tb5p0GWDdV8NS8l
         OPMXaCkvBocRe/cpvgiiYs160Jxr+z6Pr/GJ8LZkcPEFF167XCsAQSBVe5K0vv7YtatN
         4KNuY7Bp4iCD4aEwjKkjyX7Lkzf6nfauMiDcCFOcu1qYyOnOWlg2U73uij+zpkqsQJly
         9sNtjhUdrZ+yV64tYEUU8/V4KHainugmzRBEzUB6/puyQ0f4Uf94pcyfxMFKCXsVPbII
         7AAjgEPehz1MvFoHOYPhACMyvPHlluJsimj84ewIphwxtRn0rV+YreskTbDHhwBQ2i7y
         mqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778831920; x=1779436720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D2RAe37c0Y+mS2qQ9ryuy+Bjx4murGSjLzlq4yUfzjU=;
        b=siLmFEXglY4QWmVPDfBx0G2Ur+zXbWy8GovOPcOqsvhK/WoAcE8ZUuoNWapEo79QC/
         nDBbALWSkq7b+SK6OXdR5/4PKaCn4m1f3x0HhthZjkzD/IOJ/H9NNdC6sSAkYx7d/WoW
         bcp3hHUBY6T2qZ1uHQWbm+lUJFBrBkqkhpMo/eRGOYB+ypVz5doxs97JSNn4cJx3KonT
         dlyVfOcg1elG8VLoTv7pvLlWXVccJip0rnq5hfTmLRwASjMVxpowagUHthOg7BbzahRg
         efaq2Lc/ltio/8xoMa/QqxMCR8HF69NhvEUlIpic5epQQs3sR8qxiWp/CKff0MubWQ30
         mi/A==
X-Forwarded-Encrypted: i=1; AFNElJ8nt/WhUylwHeCIqFN7vJUmxzuz8Yd8pBM+5Ywqcp5IbBwGhFCE10lk5xgOqlgz1nO90D+e4FOk/jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXSc/fQhyB96VB2GTgoew5yyvUt81zVBwL4x0b32aoVDSP0iLk
	OHMFeiSXw1WHBbrQ4y9Ei0g5SimxhF5lDFL64VW6pzOuDslBtAxeYpcY
X-Gm-Gg: Acq92OFXH9YbdyBGDrI4gCV/HMZiqYiCBI2dOpTcrCjFzZrloaXvKUSM7EEjTSp1ViA
	AzdOAsp40uofHBYbLfYGb6Bn0GnqDQEaVYTn5h6iRQ4hnGyHxwyt0AnItocYsd7oledSANCBpwU
	bLhXIWLuFfJVHKeYrdRWrAKEFiJyG8na2sYZJoRQeqTUSlAXv0EEs0HSr7UA72I8eFTIOY3muHD
	tgtHl8ZfCI6uLQNProP52D/UDz1Y8uTDCMK1EnmoyoRqCMXR23GcDUEuvecnrqPFx0bsAxDhkzP
	GFyIp58skRx7c2mdEKswbmwjCy6wNntLUU48LzYq5tPVsL9d+yXWyKw/VjiaSnjnlfMrYVy5gzO
	EyDMNCkuGQzeqCwJsEbDbtqiu6/p34rVW1nBY1Yz4un/rO8UADdcdxzJVi0WfKtqrGbQR4qYphm
	RnqjgFOKcxFyiHyRjdlHyqAZFk58wXZ1zjRoHxRbTY
X-Received: by 2002:a17:90b:3845:b0:368:763a:17b8 with SMTP id 98e67ed59e1d1-36951889325mr3054654a91.2.1778831920063;
        Fri, 15 May 2026 00:58:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d008:80b:a00:27ff:feb6:42dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36959c7eacesm542040a91.2.2026.05.15.00.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 00:58:39 -0700 (PDT)
From: Pramod Maurya <pramod.nexgen@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pramod.nexgen@gmail.com
Subject: [PATCH v4 2/3] staging: axis-fifo: Fix alignment of wait_event_interruptible arguments
Date: Fri, 15 May 2026 03:57:35 -0400
Message-ID: <20260515075736.172172-3-pramod.nexgen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515075736.172172-1-pramod.nexgen@gmail.com>
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260515075736.172172-1-pramod.nexgen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second argument to wait_event_interruptible() was indented with a
single tab instead of being aligned to the opening parenthesis. Since
the fully-aligned form exceeds 80 columns, break the condition at the
comparison operator and align the continuation line to the opening
parenthesis.

Fixes the following checkpatch.pl warning:
  CHECK: Alignment should match open parenthesis

Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 3aa2aa870ea9..1c34de020cf8 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -246,7 +246,8 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		mutex_lock(&fifo->write_lock);
 
 		ret = wait_event_interruptible(fifo->write_queue,
-			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET) >= words_to_write);
+					       ioread32(fifo->base_addr + XLLF_TDFV_OFFSET) >=
+					       words_to_write);
 		if (ret)
 			goto end_unlock;
 	}
-- 
2.52.0

