Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC63DE424
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282291; cv=none; b=pDDOjJ54YiFieEc0KZecv4bEv6IW/oLXIZflbfa+/4ZIWrvgp4pLDwRffdTGYlXeZKnYde+VXDJgkZchGXHeM28d6mHGZy+aY6RkhEKyxn1uECxk09Y9I/PoGFGG0hAGNw0/zVqU8LiTlJSzhE9hMFdn++45qHoYTpJUui9wZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282291; c=relaxed/simple;
	bh=yver8pXOmgFWjwfp5QF/iyMD4XbbVVz5EfAtdXYa2Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxwjqBlP11byUYo3Lns5j8Gz3HIAe+DDd3ikBMcQ28SYl5ViPO511OPs0CSwsrojXuUDmaahVvT2kmfXbfDrA3yV230vZlvM3VYfsKIhs66Ah5c5imyAoXoyf46JK6jwj/lGlu7uWMVflaoI4qEmqn6g5lAuZc2Fiiy615cNSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W50y1UW5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W50y1UW5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso872578a91.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2026 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282290; x=1791887090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nb+vH2FoP9mnU1KR3tKdPM5uXhMZyXKj4lvyuyTrdyk=;
        b=W50y1UW5qXOWJ2Q60I+mEXeNQjRGFfQusdle2ODWBrPBL9u0KgyRDZtUMTJEizCIbq
         v6RSLeM+qwBLZjfnlKMlt/kLLXyXW/wJcGeJRyvQlbDo3RSnoSjxhrOcYxETVfFyFMR9
         RiKXCsaiRGFZkLV6I1zZrYcl57wKu0CEQItgltCP56cjlUqUyY3my9Oq3xWKhGp/Y1rC
         IQ8IYH6OnZ3dvD+UR5H6g4ueT1EkmKw65gGVyvH058xDA3uyKw2tRa7lcYGaRlpHJvkD
         knGl7n+KhqGxgFvcojwitry9jqpgP6ciKSaT7uRL54wSr4GwP/RUzeUnuHmImxyED5FN
         h13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282290; x=1791887090;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nb+vH2FoP9mnU1KR3tKdPM5uXhMZyXKj4lvyuyTrdyk=;
        b=0WVEnA06fL8qhtH+ET2zdOR5tBz7RQn+/MbvHdjnhNqVBZI4sLOs3PJE31BteAOJ5p
         ztewWv88x8qbhnmsU5uS9IBvPAoyK0XpuVlvpAoVxREsGAxPb2jHhGJH+Zj6Qyaw6aBj
         01KXic0AjJm9+8zHKnajSi3TpVSZlD2bJWRxX7I+ZJCSc7pqfGLBlO3Mk+dhAC8vORXN
         XqKjQSdNLoCgS5ILsYk9o26/9TtrBMgViEXecAHmGhJ9d5sLV/X2/jfhjLUqUCXvw7yC
         W1spd9W+wnHooJMOfDfB1Ko6iW/2khSVvin0L8elVDxyqrxjKeEdnXaUziDA17fYuD5G
         ZKGA==
X-Forwarded-Encrypted: i=1; AKwUvBwVPWhoDhLTM2tz02pFjNT4bBbe+HdGsl/vVDPkgfIM7wfMb1or/VVQkqXKgTh1ML/yA0DYId7ajYg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKi1tMFLctodLrlCw2OlQJQXMSJanXrCSAAADoeZUFqMKzYsif1
	3N9MDDp6qJhYwUGAeEKk44et2n3hiQ7V7iERBE9dwfIO4o3Lm496tNuG
X-Gm-Gg: AYBFou1jiqXaHnnMQ60UzlZYN7r1qYMlQg77tY08iAbhv5X83Xl+UwYwsHy8rVEPUoi
	+7j4iOIu4SzQ1WVwZQ87MmL8Wv3Ia+UlvaVBWxllXNeLfWDXS/VDEYsy2OWcYz0T4lf+tOT17B3
	nSe7JInsEI5WU4hoqfPiRm5nieYqkFL5X8DwnOCSyRN+nlfW42Jp1Qf6J9xSpl6V6F5wIGw3bIP
	R+hTMnLPpGV04i47TpY8BaJ/gZtkZz2Gs33pK8AJkayy9vncpBGHg5Gf/jUMLSaeFQ3zgNcZUN8
	Tyc9K6H3O/OFuZcJ3FK2uYCL0jDE8+GJvE8K8IOVRmQ0kG3MFIEXdWEKfldQ7LMd3+ANWe0oSqL
	YmKSS+djWubkDHDJeoXpEb9pIPkvwC1AqOxhHtnFRXeAxUvOQmntXaTIaete6Hn9pxE+V2QJaoI
	sFH5ZySn/sOhMJJBOjwPXmOwtp1MoqqpBJUmLQ4j9xgO0ye7ykLxBmJVdh1IBg0sMtoTt4PFx3g
	CE77TpGMZ3c0eb9WdVgCqzsf9YdREd/xBeDIaJQMYe6jT4S43FmGqmOkGAhxA4zTYXYOFWAKUAq
	wiyywzc=
X-Received: by 2002:a17:90b:2b44:b0:3a2:b490:c459 with SMTP id 98e67ed59e1d1-3a87352fdb6mr758765a91.25.1791282289823;
        Tue, 06 Oct 2026 03:24:49 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543b0c1fsm5277415a91.14.2026.10.06.03.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:24:49 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	joshua.crofts1@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH 6.1.y] iio: buffer: serialize buffer teardown with mode claims
Date: Tue,  6 Oct 2026 19:23:46 +0900
Message-ID: <20261006102351.172907-1-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026100642-numerator-hurler-5b19@gregkh>
References: <2026100642-numerator-hurler-5b19@gregkh>
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

[ Backport by Jinseob Kim to 6.1.y: mlock is still in struct iio_dev,
  so use indio_dev->mlock instead of iio_dev_opaque->mlock. ]

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index d0bcb9c57f96..06b5e9fb9b43 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1291,6 +1291,8 @@ EXPORT_SYMBOL_GPL(iio_update_buffers);
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev)
 {
+	guard(mutex)(&indio_dev->mlock);
+
 	iio_disable_buffers(indio_dev);
 	iio_buffer_deactivate_all(indio_dev);
 }
