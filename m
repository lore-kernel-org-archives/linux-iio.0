Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233722C234B;
	Mon, 16 Feb 2026 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771229660; cv=none; b=YMUJmAr3tJgrsU3SeSWZbb4V+TTsbKm1XM3LKAnXOXOKeCsS8/goGV/YgxSu50VG2M0al5TcVmwyRs8K0MP2B+f1dO9R2xISDwAjT9ZSRZ9VCW3ARDfA4+991Ecrfs4wO7YFgnaybMZaGkj0T4ru2j3bbyVawmtuzZc2V2032vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771229660; c=relaxed/simple;
	bh=OgcFpDBniCxk3aFdFHopHMCIxVV6d8Nnyw/SA16iK44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duiw82V55oiQuITtu1NcnaNp4zB5xRqQQRaWsKLjHYGLuvlC+KOj1jWmze5VQ+0RR1VxXcgvyBBGSwUPuSUFZFqr6xEQnKMzCas+2nFx136bssGbtuoMmuD/q6liwVp3m1zcS9qV46J82506DKo0zDFAhF71t5l3RdJcAgbmOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBBF7qYT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBBF7qYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771229658; x=1802765658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OgcFpDBniCxk3aFdFHopHMCIxVV6d8Nnyw/SA16iK44=;
  b=IBBF7qYTUn7T1GL6sRTCUOyEPjO2PdZcgsX1Vd5EOw/iHQauoYGMNoEw
   Vyzus3Ibmfxq/Gw9Fmota8RlS7jRIXAxH1rGC4y6tN1Ao2Q++jF/lLF0Q
   FUtiNh/Sgf97oKTq3ZOu5q3LgRofdh9CuxAymLP6m+JCh/BIHvC2dekFq
   Khz58vS/xOKjGEnLdtwLGwdyAL6db2V4msRgucyg+95NimyOIgePAzogy
   VA1LdHSPkJkeXmhc/pdoOpeVNWMagAeb0gv/C3amMY5d1JzX2qV7AStxp
   F5J2HuVBNZeof7XtKa1eBZee6nIlGE0l2+1g5+NtWR0n6WPAS1SYPW6wb
   g==;
X-CSE-ConnectionGUID: JSAa70b4RzqVzLPdJ3JDnA==
X-CSE-MsgGUID: ahT8fUpIR06NiY+Af6ciCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="94937742"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="94937742"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 00:14:17 -0800
X-CSE-ConnectionGUID: f5G9atY0QweCWyhnc3Ox4Q==
X-CSE-MsgGUID: Lb1azUNJSnKZvcrKs/m4oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="213545790"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 16 Feb 2026 00:14:15 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 07DC695; Mon, 16 Feb 2026 09:14:14 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
Date: Mon, 16 Feb 2026 09:14:12 +0100
Message-ID: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/buffer/kfifo_buf.c     | 29 +++++++++++++----------------
 drivers/iio/industrialio-trigger.c | 24 ++++++++++--------------
 2 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 38034c8bcc04..a126cc05fb38 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -224,9 +224,9 @@ void iio_kfifo_free(struct iio_buffer *r)
 }
 EXPORT_SYMBOL(iio_kfifo_free);
 
-static void devm_iio_kfifo_release(struct device *dev, void *res)
+static void devm_iio_kfifo_release(void *r)
 {
-	iio_kfifo_free(*(struct iio_buffer **)res);
+	iio_kfifo_free(r);
 }
 
 /**
@@ -234,23 +234,20 @@ static void devm_iio_kfifo_release(struct device *dev, void *res)
  * @dev:		Device to allocate kfifo buffer for
  *
  * RETURNS:
- * Pointer to allocated iio_buffer on success, NULL on failure.
+ * Pointer to allocated iio_buffer on success, error pointer on failure.
  */
 static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
 {
-	struct iio_buffer **ptr, *r;
-
-	ptr = devres_alloc(devm_iio_kfifo_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
+	struct iio_buffer *r;
+	int ret;
 
 	r = iio_kfifo_allocate();
-	if (r) {
-		*ptr = r;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (!r)
+		return ERR_PTR(-ENOMEM);
+
+	ret = devm_add_action_or_reset(dev, devm_iio_kfifo_release, r);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return r;
 }
@@ -275,8 +272,8 @@ int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
 	struct iio_buffer *buffer;
 
 	buffer = devm_iio_kfifo_allocate(dev);
-	if (!buffer)
-		return -ENOMEM;
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
 
 	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
 	indio_dev->setup_ops = setup_ops;
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..00c8b7e5c8b9 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -634,9 +634,9 @@ void iio_trigger_free(struct iio_trigger *trig)
 }
 EXPORT_SYMBOL(iio_trigger_free);
 
-static void devm_iio_trigger_release(struct device *dev, void *res)
+static void devm_iio_trigger_release(void *trig)
 {
-	iio_trigger_free(*(struct iio_trigger **)res);
+	iio_trigger_free(trig);
 }
 
 /**
@@ -658,24 +658,20 @@ struct iio_trigger *__devm_iio_trigger_alloc(struct device *parent,
 					     struct module *this_mod,
 					     const char *fmt, ...)
 {
-	struct iio_trigger **ptr, *trig;
+	struct iio_trigger *trig;
 	va_list vargs;
-
-	ptr = devres_alloc(devm_iio_trigger_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return NULL;
+	int ret;
 
 	/* use raw alloc_dr for kmalloc caller tracing */
 	va_start(vargs, fmt);
 	trig = viio_trigger_alloc(parent, this_mod, fmt, vargs);
 	va_end(vargs);
-	if (trig) {
-		*ptr = trig;
-		devres_add(parent, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (!trig)
+		return NULL;
+
+	ret = devm_add_action_or_reset(parent, devm_iio_trigger_release, trig);
+	if (ret)
+		return NULL;
 
 	return trig;
 }
-- 
2.50.1

