Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFF2D3A69
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081430; cv=none; b=QUhMVyQUMOpeKdJ7AOfuJR/eAlPnmwzBbfz0PQS85yyaW3vNjaE/GotU3e202CKnIc0s+EbyHaw7Xyew+ioVUKIn6ynuBfHmpj54Jz6tcbiIttExPHiG7Pt/dxBfArjuxh3bPhqgV4JvUvbYFMZIJpPV555lOvBX9yYboJICrh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081430; c=relaxed/simple;
	bh=0bBqSUvIxzOrINLgMycPclzNqzsWJ/9kPBc7hSL1BtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1Me7eugGgSjAVYMhW5PrB9QNAOjfNDSG7G5GG1z8UsoShZK3x4z42I2sQkSiHlfDBkzObURpDay1xD7ufCiUcImfCD1FN/bhjIDfOpvFqPYD64lUxv0raxpitdC9ZTwCKb2HfMYVx3XXk7/+RhsyN4BPAKdqScVdQXq1cO/wG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuoeL84/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuoeL84/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab46931cf1so25096395ad.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 04:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776081428; x=1776686228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RTEfxdc1l3m8peU3ZVlNLuiK9i3AY5YcO1a6Vk2UrX8=;
        b=PuoeL84/WerVXeYRkwEUsRk/IoBvJdXDLo3e+SnjKjjSuAwtA+C0BXhhonkwwlEo3W
         nt7pUXWOGex9Ikkuu0ZDlan7zx2lD/zv8mLOitWomcxutDo54+bqxkDLNWQ9ZJdZhVsW
         NilK3dj/uA2JaQx5jh7OGUUFHp0FT5ubYki3kfdbvq9brKtVEkxPB1dE6fd1uXd48CKn
         oY+OLfMBMRXZG92qY+8xq7rpejGFQwg+zkDokTtvifZQi4xr+ji0VEF46QUsbX026+Hm
         mUTq9YwK9KV1OmNoc/biVDHB1TxouEVwgIWuMswihAIJg0LC127r5Mz2cyZqVwQk6+im
         08qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776081428; x=1776686228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTEfxdc1l3m8peU3ZVlNLuiK9i3AY5YcO1a6Vk2UrX8=;
        b=NBCqyFciCPasBTD9ges034XUuF8njPDq5DfM4pV8qDIjKlPyUtDENP62OAvcbp+QzY
         nzswfqMf3fjpuJqC+yS6Evti4r/IyWv7A/EstyxMM8VOwJKZQNZEG3BVacDgHVYIUcN2
         1Mv4ay+ykDMb3c6fawyepkpnQ/ayEa+sELfK3SgTR2IuzLYt6q441jl4Gp0gzq2pumpj
         SM6R/afdE8YQxIG/jz8czyRuuaCFE0rTOSgm3XUlLphXCjx0G7zu0ZpQOl9OpoBep+lB
         QP9pxabAtT7EAwTrs7oRnTRba3shAZ799tryJqWuibD7mlszyO7lGIVpV9tOPFdoyNpn
         pK6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+5OYOC9dBdoMamHncpRmTBU6ySdPXv1FJsSUijkr7V0QR/1sDxB4awHzMJhXoOTY1y9rZag6Jyft4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgVp71HZ3AjBibu6x0C2d5J+Cp9cLGHSey8P7Am7nnwIzwY1Ub
	nEnnBwHuPSzIlrkCK39vUNw/dgTgGjEY7ww0eepv4gF3l1hidKmFUhOW
X-Gm-Gg: AeBDieu1O9bYqrrxGowsutWV5OtvaUtKpyefJvbfMzu3nf+PfDyTN1XMB2PPWLrqbW+
	GPuJBveI3/WMn3gHjQH+2s/VA7whqGneGECXXZiwEe2eZNa5YDj8fwF3wIZ+IgfMtPajYZMhDQm
	DWmA4fiY7ewJo+a3pJUNXQFwQFGqcFDkEyetHpRYyA8P0DTm22T6IbYSwamTrR5KIV/NFy0R430
	G8FEW7xGxPvIFtPkX5T47Jq7B1owORWANFTu1tiXNb3IJ4cU0EqsIQJuZO8iMaBa+uhVMgR04jQ
	QqbHF0MwQM3DwS22XugL6XuTRcYa76HKAmAW0hTWvVbj+y4pGcfSkbgckOvp8o/1TC3ApI4JLjQ
	/ZTw+XZxRduvBr9hKZFIYKUFwCR+cRUsKI9GNQT1QVYlga19oQ8aaPko+3dkv5lT/Ge7iVz1wgD
	kNgms5EprOJ9bwQVhviVOdE2gT4Wih7wo=
X-Received: by 2002:a17:903:249:b0:2ae:47b0:dc80 with SMTP id d9443c01a7336-2b2c727c6b2mr151783215ad.11.1776081428501;
        Mon, 13 Apr 2026 04:57:08 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:db27:7a46:955d:48f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2771esm109736585ad.63.2026.04.13.04.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:57:08 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: trigger: Fix refcount leak in viio_trigger_alloc() error path
Date: Mon, 13 Apr 2026 19:56:56 +0800
Message-ID: <20260413115656.2789049-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In viio_trigger_alloc(), if irq_alloc_descs() or kvasprintf() fails,
the error path frees trig directly with kfree() rather than releasing
the device reference with put_device(). This bypasses the normal device
lifetime rules and may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device(&trig->dev) in the failure path and let
iio_trig_release() handle the final cleanup. Also update the subirq_base
check in iio_trig_release() to test for >= 0, so that a negative error
code from irq_alloc_descs() is not treated as a valid IRQ descriptor
base during cleanup.

Fixes: 2c99f1a09da3 ("iio: trigger: clean up viio_trigger_alloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/iio/industrialio-trigger.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..ab544976018f 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -509,7 +509,7 @@ static void iio_trig_release(struct device *device)
 	struct iio_trigger *trig = to_iio_trigger(device);
 	int i;
 
-	if (trig->subirq_base) {
+	if (trig->subirq_base >= 0) {
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
 			irq_modify_status(trig->subirq_base + i,
 					  IRQ_NOAUTOEN,
@@ -572,11 +572,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 					    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
 					    0);
 	if (trig->subirq_base < 0)
-		goto free_trig;
+		goto err_put;
 
 	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
 	if (trig->name == NULL)
-		goto free_descs;
+		goto err_put;
 
 	INIT_LIST_HEAD(&trig->list);
 
@@ -594,10 +594,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	return trig;
 
-free_descs:
-	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
-free_trig:
-	kfree(trig);
+err_put:
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.43.0

