Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDCC34A3DA
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770237264; cv=none; b=azplE9keDqW+QVoVwoufoZxTOQbfNqOtxq3KFTmAyiX5eN1IuRMuCLPhZUoQlUeEfqKwSusNSdUrRiHVAGjcVqNVehYHCKfL7tCy5Iqg2lMGRCqawXjag6gKCrWzbYT13gDBlqE9vkdFIuEiKXplpqV7BrVRHYbMoUZHzX8vLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770237264; c=relaxed/simple;
	bh=rvhVa3smICLx3UXNDdk4ydZcwdUWyxqatm62NxBVvZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imagcFVUPVywV5WLNFRtsep88NzClux4qR8rKZxdK9VG3RiYnYJWzjEljHQ3AK74z6qIa0liuDdbc318tEOWW5S97vv400Kjy2+VfPZ0hx4YL7ezitoipq3WWwJ9FXw5xu3Qw0EMiX0SnXyPxgP1Rd0hWSJaG8bLMIbJo2CKggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1AybAqI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1AybAqI"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4359249bbacso864353f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 12:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770237262; x=1770842062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zm6pQ0n8k0aUMJnRRXuxnSNa9+Aku/yu04RgcWOPpwg=;
        b=C1AybAqIB9ElnWPZBFVyWkNkrl8PPnahwzO53rSnNyg26cbtp496BDIH0LcXK7Sw+S
         JB+X/o9F9ShGR54j3ANB7/Mn9VfbJ2MiRDV/0zUDpsmiaJuFTmTxPG76nqJVPU8U8G2Y
         Bk5lmxq63qar3hb1v+IsmohVZT7m96q5z4H5UdYrJwFwE0iWisE6hronHpatLGpQWZ40
         B05+uYxcry2a4cvj5Ja9C3/G/tOBacS5zvCsEzxBMGEq2IvXoQnMUyavtDAE63N3TL0b
         dxqA9LCeUvmEfv9GOEv5TSjw4HdGSh4ziXLFhQiXDsiJxVHTie5ArIx5+asXVNPJu8x4
         pxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770237262; x=1770842062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm6pQ0n8k0aUMJnRRXuxnSNa9+Aku/yu04RgcWOPpwg=;
        b=rjvV5Jk78TSaLAa0vEZbvyfO07p6u6bhoLK47j8Ffpa1FGfy3ginuQyfMGmxjqE97l
         xpejE/FAWe3dUzRvaQ1BYXeKfNGfhiEbH10hKQNbvp04mRlFP3wxAADA1tp9GV6Ewn5u
         PW2rwQNQhQ7R3ruXUB2F3X7KmaGU6VJG6zA6gClDG0LgvQzmXsCQMEwpwafstmsYH31t
         D3vKTgQYTJYypv7RGrplJbdFfUQlaoxjlSna6iSYzE3u29OztgL3lE1uTfED7WFSKKYr
         MI7LIYPDaEFQfP5QZ4VGDrzNqhNdotkOn/JORU3BlGLIQKqIrsOl3R53tQSMH7sfZ7kb
         v5YQ==
X-Gm-Message-State: AOJu0Ywd0ckxXqkpiSLhWu+D5nKQNyZAcz7fq63tN1ABlZDZt/C+pOEr
	UFepH/3Hn8aLhmqSFS5DVeWNqLra3g6jXETSPXm5eCGyX1VMlCzZ5mi7
X-Gm-Gg: AZuq6aJqfw63Fi6say36QdwNdxUFWWKqxSYq4Imxwh0e1liFuFy5g7A7ouUPtvsOpq6
	KDOJlgG1uvv/XAkbSb1xyIRwAP0W54UmfhIg0A+DovcHYmaQRZWox7sCdm024mE6k889snS63aO
	JHkKiXQXBcvdgF9xMrmYHgihai9ynsnMbW1YYGCIovU3dIVhR16b5pXnS1cL0aZtKyx+sec9RDX
	d3DRbFZBGR0eqrbQIHgenIJnxukqnaj6qFn8uW/6soGB1Xhi5CMq84KSDE+59CQ0o4SjlZF/2Ys
	UDHq0CbcXh32bAKCa309N+E00kpW2uEjEYfFBOYiMWImKGyszeBfh0be8O+E859bSUoymANBT24
	M+RmFl4lRs5xlh/P9fr00VgvctXWwsVshRuMGf6OGiYa+0tIIlP2KQyOLOgVTSeauRJB/rOZvVB
	VSMAoIsubEKW3y8TTh23KhVwV6Q7I=
X-Received: by 2002:a05:6000:4201:b0:435:b674:c9b1 with SMTP id ffacd0b85a97d-436213d80b0mr874187f8f.11.1770237261689;
        Wed, 04 Feb 2026 12:34:21 -0800 (PST)
Received: from localhost.localdomain ([196.235.235.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e38fbbsm9275097f8f.13.2026.02.04.12.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 12:34:21 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: trigger: fix use-after-free in viio_trigger_alloc()
Date: Wed,  4 Feb 2026 21:34:13 +0100
Message-ID: <20260204203414.89333-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once `device_initialize()` is called, the reference count of the device is
set to 1. The memory associated with the device must then be managed by
the kobject reference counting via `put_device()`.

Currently, if `irq_alloc_descs()` or `kvasprintf()` fails, the code
manually calls `irq_free_descs()` and `kfree()`. This is problematic for
two reasons:

1. Calling `kfree()` directly bypasses the device's release callback
   (`iio_trig_release()`), which could lead to resource leaks or
   inconsistencies within the driver core.

2. If we simply replace `kfree()` with `put_device()`, a double free
   occurs because `iio_trig_release()` already calls `irq_free_descs()`.

Fix this by:
- Using `put_device()` to handle memory tearing down.
- Removing the manual call to `irq_free_descs()` in the error path, as
  it is already handled by the trigger's release function.

Path to the issue:
viio_trigger_alloc()
  -> device_initialize() (refcount = 1)
  -> kvasprintf() fails
  -> goto free_descs
  -> irq_free_descs() (first manual free)
  -> kfree(trig) (refcount is still 1, release never called)

Fixes: 2c99f1a09da3d ("iio: trigger: clean up viio_trigger_alloc()")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2:
- Remove the manual call to irq_free_descs() in the error path to avoid 
  a double free, as this is already handled by iio_trig_release().
- Clarify the error path and the potential for memory corruption in 
  the commit description.
- Remove the blank line in the tag block to comply with kernel script 
  requirements.

 drivers/iio/industrialio-trigger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..7f53e2a5a101 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -576,7 +576,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
 	if (trig->name == NULL)
-		goto free_descs;
+		goto free_trig;
 
 	INIT_LIST_HEAD(&trig->list);
 
@@ -594,10 +594,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	return trig;
 
-free_descs:
-	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 free_trig:
-	kfree(trig);
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.43.0

