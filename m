Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA93CE494
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087977; cv=none; b=MM+j8mJBYGK171r8M0grLtmyQL4bvL1lv8weP5N6Zk1kDF750l1m4XRMa6fiOVP7fwwrsQ2irEDRFqTM8K5LN2/9gaG9CVHBBKwTo7y5XLMz4qeDicQ4suV1t1mlqjbNZdkeApO2u9WaPRcxs7KcD94QqJ43o4ssKGM5SH1F7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087977; c=relaxed/simple;
	bh=ZdQbCoPJwZCB3uMPJtQnV69MkLE1kKA2QPk0Ij15LxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8wYBAh2+KY7AQtjx39sSilQuq/lhCdaufnbwOZf/5ZydLogcCro1lVR1Zsdf1/8Woga/euy23B7V7iClsCWGZWXKbx4g1XqyPSOwayVj9Xo067Ct5ftKYIjPNaHC0hRAldl9Emh9VNdxKViFEFDj/xqhngwyD7XB5aNi7ng4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlRp7Iad; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlRp7Iad"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so663222a91.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087976; x=1776692776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ITeUfxAmccwJWBoBKTfUrPUP9cp6D5ar5cCPRAU5JZg=;
        b=jlRp7IadOuiByJXyze8DdZwPC1SshDd0cWkjO4Lik0qOaNJ6uHqdQDWQHvdX2VbR/y
         s3NVLDdPu6m8jQqo/3tJpfow/ZaBmX4cH9AKlaE/Ljo1NF2kOr1rc47tZLN5fIitlj4U
         sbWBThkB92qMu4X9mNaNYLAxmeVTE9W7hQcfeYOAnzx4fuAqBYUnTcKu1H7sqwNI3mg9
         xOvHuiKS9i1Za01YsmEhkDSJEv5Hnsc/tbolf9QXla5biB7BJaZLhwvniSa77sMSyWq7
         C8CpDCsZ2Hh0QuEaMDI9qIG0NdnYHp7Cmx/bBoxgKw0ZYMls+3ZX3dtLHXDU4X23LfSy
         lmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087976; x=1776692776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITeUfxAmccwJWBoBKTfUrPUP9cp6D5ar5cCPRAU5JZg=;
        b=aQC3GrWpj3rImqXLtAi+U1D4dNJ/esuVxOf+3gLF32hOGoZd6bVg4DEd5CmmsLeeGE
         /4e0glZWUR+1RVlhmHsBsN0+8dO6bs4HtY57Man+TQJfraqba2hsHgao1fkAIaIlxFDX
         irgT5vMfjukF98qmVnKsPNvsy2k5hzk/9K16LVkAc0sHQKTmfYQf571iERpKAZz+F0H/
         xj/prstPz0eGA6zCJTvzL0xshVQmLQlaJysNfAI6AU+6qPzdYaiqysraQ+ya6WJAw5wM
         OyUOI8BzI8/dD6b5Ds48DzDT3x1eAVASgU4U/FtTzZx1aa61ROdjWtYNt3pNFDbWyA4I
         jTJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PRZ6Jx7x0dOQx/3qPTkSagrzeoUMj0ZGVNXl5s24p2mmka7Wjafnjjie0NgmerTEOgcuqLvfB1Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBuVKdRnbNvEf1KUKRaGtLsQm3cCUwawkJxUDCcBnJ1YHl7MJK
	E+nrocMLWDdM0IO643MvZedGWiiVGKCgZxyPklkvZCa11vZPVZ9/uPib
X-Gm-Gg: AeBDieuvhXQ3Uzisq/gb1yklSeHw1KlQ4tUoh16vT8c3n+mPbYhvYAPy0iV74uPeyBL
	GOmuEacqSzn/YlOn5TIyCGpBV//WswDYkL9/Ax/kquYSKW1kyERgaSX0onpiNQlh4/WPugA5tUW
	HMKmbcmjyPe0/gOFqqHd77/fFqNzazg4O4tyr17XP84ggzx3Xt0piy2s0saO/Lx/3/OorhdGiMU
	4q789isj6oB9hUG5vghuDhRGHZYPVtUC4Udgq9uukcgAsIpnFgYaWF0GxvfQFp9VecsHJJ3Ck+B
	51ttvVLc+Yd+ZLkuG6qmYYwVnz4uVv+7jr9P0/MgVpFUs5QWX1c/9yuwOKMj1L3gaq6mOQ0yt42
	3TlyzUn52C0GgOBmBzba8rcOqawvjJq9XNVtyfkkf19JJwzFn/lwZds1SP/B1m6d48t7VxpBQm2
	3WL97b4ikXam6D6NYVfpZGRLSBM6//mWhFp2JR6LsOkw==
X-Received: by 2002:a17:90b:1d91:b0:35f:b57e:7f33 with SMTP id 98e67ed59e1d1-35fb57e8053mr3108234a91.14.1776087975591;
        Mon, 13 Apr 2026 06:46:15 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34e959bcsm15974386a91.0.2026.04.13.06.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:46:15 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] counter: Fix refcount leak in counter_alloc() error path
Date: Mon, 13 Apr 2026 21:46:04 +0800
Message-ID: <20260413134604.2861772-1-lgs201920130244@gmail.com>
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

In counter_alloc(), if dev_set_name() fails after device_initialize(),
the error path removes the chrdev, frees the ID, and frees the backing
allocation directly instead of releasing the device reference with
put_device(). This bypasses the normal device lifetime rules and may
leave the reference count of the embedded struct device unbalanced,
resulting in a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device() in the dev_set_name() failure path and
let counter_device_release() handle the final cleanup.

Fixes: 4da08477ea1f ("counter: Set counter device name")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/counter/counter-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 50bd30ba3d03..0b1dac61b7b5 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -124,7 +124,8 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 
 err_dev_set_name:
 
-	counter_chrdev_remove(counter);
+	put_device(dev);
+	return NULL;
 err_chrdev_add:
 
 	ida_free(&counter_ida, dev->id);
-- 
2.43.0

