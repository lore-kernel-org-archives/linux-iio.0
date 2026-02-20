Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78621CC58;
	Fri, 20 Feb 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594168; cv=none; b=LSRtKq9vJ+k9UMN1S4VJ/uI/fw6ee9XUBR3m1swD9qaAZnPXHWr+u7A7FqjXDLon+CEyMoMB0PKSDtvKzFVgShvoY5sErNHhsJYto9xDRYyKz7RXwviJwzhcVIbMfcOzcuTgYg9WW8ScdnNwDipCeutxaiWidOq3DFrcNCrw/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594168; c=relaxed/simple;
	bh=AQjZXXatpHZSStwTlIQJE4Gi7G56uTODReuyq+4fDXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dx+xiXZQP3Or5pekyxpYwXpTUUaDm6qpLkN3fdWQ9cw0OCZWIbA/KnSNcstPB3bMNXoNgvDlhvbdrwfFiRJEXJWN+Mtpd7IKeuhp1h3lQmnCzq3MDe5AaNHrCEvqkbxDv52EqdAHp7up+jmcU/5zRUWMTZ2DnKoCCY74KhQUxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPREUoJK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPREUoJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771594167; x=1803130167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AQjZXXatpHZSStwTlIQJE4Gi7G56uTODReuyq+4fDXs=;
  b=mPREUoJKBAcZKuHS0s7DS3JrHIFAcgNNW9WBNu16yGD/Y285hHPRMlzm
   bBW+OuHoYW4ygjlqZLAaIW9raBaWdDgjYVxtasB1taoAczlKWO7jU5TRf
   6vd0tECM7UvraN7gsnSARNHjGU43rARuxnhFSrtZs1q7tapCSH0Qkolyg
   WY5qaMS/LtOq7TX+QPv9AYCKsSJVjF+/JthxfuoJNjagzMhFZkEmk4/Ke
   5cDzXB6eCAGWzubYrbVTlR85SMwoGtTohhuMRfiYT9JUeI4iH4fkZl7zD
   BxenhP5Sd8OzoxxulFRjGZl5yat2vbX5YPio0hQ6CYk8Czq0abbjTMdhC
   Q==;
X-CSE-ConnectionGUID: Lq3bb5goRESwkYqcvLRMAQ==
X-CSE-MsgGUID: 3fe/SFpZTgasUkryI/GhbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="71710573"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="71710573"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:29:20 -0800
X-CSE-ConnectionGUID: K5BslAP0QLmbdVDFb3QXQw==
X-CSE-MsgGUID: jTqcqt1aSjubJLycJWsl5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214703442"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 20 Feb 2026 05:29:17 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D9B8095; Fri, 20 Feb 2026 14:29:15 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 1/1] iio: core: Simplify IIO core managed APIs
Date: Fri, 20 Feb 2026 14:25:19 +0100
Message-ID: <20260220132912.2392102-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

While at it, inline devm_iio_kfifo_allocate() into its only user.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: squashed some code (Jonathan), amended commit message & added tag (Nuno)

 drivers/iio/buffer/kfifo_buf.c     | 39 ++++++++----------------------
 drivers/iio/industrialio-trigger.c | 24 ++++++++----------
 2 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 38034c8bcc04..92ffe9131190 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -224,35 +224,9 @@ void iio_kfifo_free(struct iio_buffer *r)
 }
 EXPORT_SYMBOL(iio_kfifo_free);
 
-static void devm_iio_kfifo_release(struct device *dev, void *res)
+static void devm_iio_kfifo_release(void *r)
 {
-	iio_kfifo_free(*(struct iio_buffer **)res);
-}
-
-/**
- * devm_iio_kfifo_allocate - Resource-managed iio_kfifo_allocate()
- * @dev:		Device to allocate kfifo buffer for
- *
- * RETURNS:
- * Pointer to allocated iio_buffer on success, NULL on failure.
- */
-static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
-{
-	struct iio_buffer **ptr, *r;
-
-	ptr = devres_alloc(devm_iio_kfifo_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	r = iio_kfifo_allocate();
-	if (r) {
-		*ptr = r;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
-
-	return r;
+	iio_kfifo_free(r);
 }
 
 /**
@@ -266,6 +240,8 @@ static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
  * attaches it to the IIO device via iio_device_attach_buffer().
  * This is meant to be a bit of a short-hand/helper function as there are a few
  * drivers that seem to do this.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
 int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
 				    struct iio_dev *indio_dev,
@@ -273,11 +249,16 @@ int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
 				    const struct iio_dev_attr **buffer_attrs)
 {
 	struct iio_buffer *buffer;
+	int ret;
 
-	buffer = devm_iio_kfifo_allocate(dev);
+	buffer = iio_kfifo_allocate();
 	if (!buffer)
 		return -ENOMEM;
 
+	ret = devm_add_action_or_reset(dev, devm_iio_kfifo_release, buffer);
+	if (ret)
+		return ret;
+
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

