Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387D328614;
	Wed, 28 Jan 2026 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769630845; cv=none; b=R0uh22kmKgEL/GgV3ro0e9gaE03YNYd2fjrXPApwl2cVLscFKH1ceR1ACpOyu83HCQ0xmi1zLpyeCiWA3Rp8VKchD5k1MfRafSJI0tuYoL4sRCa9pHtnHsrEHbqMEXKDcsJNLGnbnkz9ioOObgACCiWWZdI9eKQ+ITPPxvHZjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769630845; c=relaxed/simple;
	bh=WJYm3BSRkz1An2PC0aXTesII295ZcnaPRHHED2aPySk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XvQA712xsqLziS+cKoltsTQkx2hfoBp5Fe3VdHn3q3pfDlciK7kupBQYGWWQmmzd+V9XLHm3iOQyP/0IGCDewg9xtCJDJEJd+x5UYnRgmIcykQzQWwa5CCSfURjUpU63daO+M7tgCVclsF8DuuSSSqQWIDi1O0eAu6C8l21cUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tdz8nUYe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tdz8nUYe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=m1f+8eHf4P8Xbntn2R/p8SEVfauoHo5T4mSnF9A5K+w=; b=Tdz8nUYeR+WihB4E26y5XDO2il
	ACbuIhnEFQdWacibqm7YIS3tcSQm89cCGtb0lxx6IwKRQWVEHIBqC0ROJo/F9lZ4jzKs2663ny7cL
	379gNMfkV1tMdOxYznHodJLf3L6LuHK0kdhZ34O85ECs9LYqJx8EK8Hw3gKcpsgeQpn0V/710Vu1v
	3dvUZY4N5EyZ6mNJvnMSZ7IL4YoIMGIBrr6mAJiJyMy9WiqkopsF9eKFcMqLyHM7CVVgetcrxUkOw
	Sijh2UQDJDvYEiT+HleLE7RiEoYwReGZzaXLrEEK2/1o3+mFPX4WGC7kBrQ/bSpgnsZXS2VFLafEb
	n0nOLF6A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlBov-0000000GiaF-3RbH;
	Wed, 28 Jan 2026 20:07:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: buffer: buffer_impl.h: fix kernel-doc warnings
Date: Wed, 28 Jan 2026 12:07:20 -0800
Message-ID: <20260128200721.540666-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Resolve all kernel-doc warnings in buffer_impl.h:

Warning: include/linux/iio/buffer_impl.h:172 struct member 'direction' not described in 'iio_buffer'
Warning: include/linux/iio/buffer_impl.h:184 No description found for return value of 'iio_update_buffers'

Also correct one typo (word order switch) and remove one stray space
in a kernel-doc comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: remove a stray space in a kernel-doc comment (Andy)

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org

 include/linux/iio/buffer_impl.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-next-20260128.orig/include/linux/iio/buffer_impl.h
+++ linux-next-20260128/include/linux/iio/buffer_impl.h
@@ -113,10 +113,10 @@ struct iio_buffer {
 	/** @flags: File ops flags including busy flag. */
 	unsigned long flags;
 
-	/**  @bytes_per_datum: Size of individual datum including timestamp. */
+	/** @bytes_per_datum: Size of individual datum including timestamp. */
 	size_t bytes_per_datum;
 
-	/* @direction: Direction of the data stream (in/out). */
+	/** @direction: Direction of the data stream (in/out). */
 	enum iio_buffer_direction direction;
 
 	/**
@@ -178,7 +178,9 @@ struct iio_buffer {
  * @insert_buffer:	buffer to insert
  * @remove_buffer:	buffer_to_remove
  *
- * Note this will tear down the all buffering and build it up again
+ * Note this will tear down all the buffering and build it up again
+ *
+ * Returns: 0 on success or -errno on error
  */
 int iio_update_buffers(struct iio_dev *indio_dev,
 		       struct iio_buffer *insert_buffer,
