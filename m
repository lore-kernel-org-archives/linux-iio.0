Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4491FCF41
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131704; cv=none; b=l18E5nV8cA0+fgKx+mPioUJ15EGFbIMdmCdQ5OCac1E3R6Eyj6rDY2QqeHAlaTqGAQkmGOPAIoWSqMyXVn7gWPta+OxFeXc+1u6du5yCp7f9I5uGKimPZkkB7vSPjF+exg8fdYsrMWURD5OPmHge0KUbY+UGCFCKiVF39sixajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131704; c=relaxed/simple;
	bh=Vxd03UYkLhP5bkCW/penyxZ/dQAVpqPerWPLKOeQQjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/01/ca26lppDrv8cYza+zUzFM7ZaqSQHqQqeFUFcwsyRsvz1X4HN3gNLWmuElxMSK7Dg+wRxIiIT2wBsqqElt5sPBfG6/UWqouAycdvurRjONO8Ope8/vUtJpqwj0TKltCGbixvz4wBw0JHPacYXs3y0+ARUvg0iDeEjKKtWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=fmZ2wS9Y; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="fmZ2wS9Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NLCPT5WUUPSLkiIwaa5y5IGR1eN2GvTT4/K4sdl4IRo=; b=fmZ2wS9Yneb8V3q5dQOXCyjUWa
	/Jzy1fH7RmIzoqAEmuwD7sfA7dSGGhFfn1xA+XgvyVDMRdKZdOuCCEunCAHOaqShxf8sEkHtAPA1o
	sM8CULY5cH3avtHBMgPRKW9lkimLwcBAVzBt/3uOY7GG3qYv1qYIDBk3c2e4SQkexnLNLChXzPdlp
	2RwMV3QUOETWIkGHBQltME2EIHlW9fPeh4EyeI/I3S1VB+jxNC1giWrw6FSOm9UFlsR1Wu2CYasQk
	UWDNYjs1lhLSdwAIJQsbqvc2r9R9jDj4RM1xQ1LikaufZCh96WpmOqDcl6vYenK+cOng1U52GOa1N
	3JF41nOw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <lars@metafoo.de>)
	id 1wk1lz-0001RW-0O;
	Wed, 15 Jul 2026 17:43:47 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1wk1ly-000DNF-0E;
	Wed, 15 Jul 2026 17:43:46 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio: buffer: Make IIO DMA fence release RCU-safe
Date: Wed, 15 Jul 2026 08:42:45 -0700
Message-ID: <20260715154245.3814378-3-lars@metafoo.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715154245.3814378-1-lars@metafoo.de>
References: <20260715154245.3814378-1-lars@metafoo.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28061/Wed Jul 15 08:25:10 2026)

The `dma_fence` documentation states that if a custom release
implementation is provided, the `dma_fence` object must be freed in an
RCU-safe way. The current `iio_dma_fence` implementation uses `kfree()`,
which might result in a use-after-free.

Remove the custom `release` implementation. This makes the DMA fence core
fall back to `dma_fence_free()`, which calls `kfree_rcu()` on the fence.
This requires that the fence be the first member of `struct iio_dma_fence`.

Using the default release method for extended DMA fence structures is a
common pattern.

Reported-by: codex:gpt-5.6
Fixes: 3e26d9f08fbe ("iio: core: Add new DMABUF interface infrastructure")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 31c06bffdce8a..2c9ec93dff475 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -54,6 +54,10 @@ struct iio_dmabuf_priv {
 };
 
 struct iio_dma_fence {
+	/*
+	 * Must remain the first member so the default release callback can pass
+	 * the fence directly to dma_fence_free().
+	 */
 	struct dma_fence base;
 	spinlock_t lock; /* protects base */
 	struct iio_dmabuf_priv *priv;
@@ -1828,18 +1832,9 @@ iio_buffer_dma_fence_get_driver_name(struct dma_fence *fence)
 	return "iio";
 }
 
-static void iio_buffer_dma_fence_release(struct dma_fence *fence)
-{
-	struct iio_dma_fence *iio_fence =
-		container_of(fence, struct iio_dma_fence, base);
-
-	kfree(iio_fence);
-}
-
 static const struct dma_fence_ops iio_buffer_dma_fence_ops = {
 	.get_driver_name	= iio_buffer_dma_fence_get_driver_name,
 	.get_timeline_name	= iio_buffer_dma_fence_get_driver_name,
-	.release		= iio_buffer_dma_fence_release,
 };
 
 static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
-- 
2.47.3

