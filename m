Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B23E0749
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282386; cv=none; b=CBqdfO2eFKxZqGuN6b/3GZfsLeUmspRVhdehWXhKnHIKSjOGr4Z5QO34zf6Ccwkkh/RSuicfW9TjTXkwO3QNlR+UujzQvNGf3BmRADMFBK9TTiDfNV/Rb1DLdYZx1URZCUMgs447GCFsChWIlMow/0Y4flLXsS4CkdkKR6lyQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282386; c=relaxed/simple;
	bh=di+Mh/b86F3wXONTaaZklyskM2AArrNMhkc2iR3mHMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UW1JnaQr911PVA22DekQiKQmxDzhzCfXcKzPOzW+2QcEZd/J1M7fFu9TxtO9CzMaugohFo65KBHUvXb7jvxhPi8wwn7KtPKOwt8pCNULWbfRAJISWIWQwatMWUq2fhdGlFJH82KIaOqTIrjccXgUKT+yvZFVTkfbVUIrCzzgtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdYE27S1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdYE27S1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e2fd2603b0so4467075ad.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2026 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282385; x=1791887185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WFX4SVdMUoUy+5Ur1rRMmdJPeBVm5LQQKBJ/uWUKeSE=;
        b=PdYE27S1Y175KtP7DLHrGR6io16VktyajjNMZ5haEzs6rG2SnkMlBCoM6MgUAa2kGJ
         xSIfCoaE8giifeAroDecsrlIAmof+SQQ0WmfR4NkJhhy2Gc4DmQV7M59UQktbvofw+/5
         OT85Pi0zDuQ6k3gr6aTsDrGBRlgBvWaydtRekvG6ifRIBywcQjhbZExR2bK+tmJSpVNL
         1Umu/j8qYFw8MJHsjKhQSjQt6UD2pQXltUwCkAZyGQevC/v5h3b61+v3/Wlc74t3Fknb
         XCRY7mG4SiPmZfuKubW6u81ZTzsIYuOBkxcQrLyok7oHdCUsS7W2pJa5CgALKv2IsQh0
         qRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282385; x=1791887185;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFX4SVdMUoUy+5Ur1rRMmdJPeBVm5LQQKBJ/uWUKeSE=;
        b=sUjTmVmqf+jln8yE5wnz7TzXu/t2UAzLrBJrrCfOQ11m0AHzyFoqcf15j5ZbFgxFce
         NnxBglga7oqZ9MtuNKfklStBZ10dxCYy/3GEM3J8cMFEwe5Qkoc2dlDQPZkfUlofhAtH
         RcEG9qRv8kZjI6FEl9jb8CrXnkeHuwsiNL9mlcyyQ2k4sgFB+aNo8MnRAWkbG6g+vxmh
         T4J01KIumBdMArQJBLBWavRq0grW1ybGk7njSK7xBjmlsAk+VAs2/LaC2DAHznrUwJGv
         +0UNgrAZfTqaBZeaOwkgifSWn2cE49WbisYB4k3EG7ZjvtDtWEZHJiNna8jCb5DepbY5
         f8PQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBk0cIoqJFYYdcTkwOfKuSxHYXOHgagfx5liCdiC0Q8UxkSLq6tx3dS2V8atUeQnIhjOYixqOw58M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEyI5R1lsOI+AqKxfP7XJocedezwQB4Ttg9tQHaXPgJ0zW4/R1
	xbt/5m2je27OZAnT+aCbfhhpFFfqlKrAJYkKj085mj1slo/0DBiT5I/1
X-Gm-Gg: AYBFou2qpZ7WBudSW4KBR+46J39A+5Ko0Tpy66Fn60dJNQv1B7j9tzYOO/ShQqizqmc
	wzm3RiXwMH7vl88pPT6RafGZI/GmmxTO9qMXt836PFMcgMHUddeL12pmIJIxX7R+aL3s1nvMvzt
	bJazb9cg/SxErIW/7cxZfr0q8q9Ccpbt+ygdq+lwFvdvQOPDUBXFX1AgiDbX3RmRwKBIoq6yVOm
	NzteU7q82jj/xneOqPHaoWGoM7ZIYnqPTGv/GnbG+43z3mnzx5IPRPlQJ8xP439Pkm07zL5BdvN
	F3Q3GEZUZ/2BXfa0ZE7Wj6Vo5+nC/IcjZojDmtowPaRIE5AvSJBpdSfM36wx2S5q/a6Y1hYGAFn
	fu+RcpkzM3FIvaVfNo95062Zbru3jdqeDLuLBqXFUXksRxmw+bToWL60WAp09iM8hsXXcPK9/T5
	K4GPa47NvzRsnqE16kvVSdG8JptXyyBOnrbbmgfjLPAzpwup6Shzk7MZv77WSQyn1yz+xzFnsUJ
	HzLk9TnsDo3cU0/I1UlifkyfOdDpXji5UZO1fNAQsH0itM23XKklEaTK43ODbl6OJVvgLOXkHJx
	f9vw/TJu
X-Received: by 2002:a17:903:3d05:b0:2e4:b218:f689 with SMTP id d9443c01a7336-2e5dcdba966mr7448435ad.53.1791282384685;
        Tue, 06 Oct 2026 03:26:24 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ecbed5sm19532515ad.47.2026.10.06.03.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:26:24 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	joshua.crofts1@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH 5.15.y] iio: buffer: serialize buffer teardown with mode claims
Date: Tue,  6 Oct 2026 19:25:14 +0900
Message-ID: <20261006102525.172949-1-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100642-decathlon-jittery-ce0d@gregkh>
References: <2026100642-decathlon-jittery-ce0d@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 84bb0fc46ccf6a545b8fdf57cda83770186ed8dd upstream.

Buffer-mode claims hold mlock to guarantee that the device remains in
buffer mode until the claim is released. Normal buffer updates take
info_exist_lock followed by mlock in iio_update_buffers().

However, iio_device_unregister() disables and deactivates all buffers
without taking mlock. This can invalidate buffer state, including
active_scan_mask, while a buffer-mode claim is held.

Take mlock in iio_disable_all_buffers() so that unregister honors the
mode-claim lifetime guarantee. The info_exist_lock -> mlock ordering
matches iio_update_buffers().

Fixes: 0a8565425afd ("iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

[ Backport by Jinseob Kim to 5.15.y: mlock is still in struct iio_dev,
  so use indio_dev->mlock instead of iio_dev_opaque->mlock. ]

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c81dbd2f0972..30d20e3ef051 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1187,6 +1187,8 @@ EXPORT_SYMBOL_GPL(iio_update_buffers);
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev)
 {
+	guard(mutex)(&indio_dev->mlock);
+
 	iio_disable_buffers(indio_dev);
 	iio_buffer_deactivate_all(indio_dev);
 }
