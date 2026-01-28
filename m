Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123603358BE;
	Wed, 28 Jan 2026 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769581553; cv=none; b=PVX9oKts5f2R5r1zh5mp61a5Uao7bTRRlOBcT8ohz3/eEz9kIKWbnWKC7R0eKFlekLr0aIuWh+eVzIX1GPvZhcWp7zBq48sQ9lUtD9MqTV7STcOYLyl3l6HtHyY3+EBVd0wfemwGFACyUhi3pgWl0Et/18bLKG7n7Hp1icuKoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769581553; c=relaxed/simple;
	bh=JBHbJESdolOKq5C/tbFptCJ0rQTiKy18RuDC4M11vf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E2IeZd3SapIW8YLs6BTqIMpuI3d4suta/gi0KOrXXLF5aETrS84tupYDlTDSFyS4HqZz+uH2Ur4qmJefcqxUwNHLO8Ku3j/VqkfGMkdIllar9R6FTnBZ6FhAad4VJsgQYC/370wy6xjxnANhxS9qy3z3RAg7kUEIRwn7tieuxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cWW/zp81; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cWW/zp81"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5AOxMfDQ/+qWrloB1WUfYm6i0Rqt5bB4g4Zy0L98XHM=; b=cWW/zp81/uvIZIb/TmP9rtxoTA
	ckJ4kasvo3hSPt4lUNQ2NIiqD4R94+sq/jAeYXg6k4J17GyAPGb6zuvpgVPLTg/DBNft0sHv2iWvn
	lTSQCnPgnfKGw8qTWH6gr+E0Dch66BsNJp0JY7HCyHDMQlptWUnTgvmORBXQ0DcBl5Vygxo/PWDMn
	hKEvQbTY5xWjCjnxjxjFNtojWrf/frdFHSDDGj5+jdz+Rx8Bp7jLGvunZtpW8GgsYr5yLl+S8Jy6d
	h8Ic89LZVhZUOTtIGK/wt/RCNizGdLrtnBzawJYsIjAAnBVP+xIS1106h+SFOm6HuvST3ei0z1XPX
	5c5s4Pkw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkyzv-0000000FXPx-29gW;
	Wed, 28 Jan 2026 06:25:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: buffer: buffer_impl.h: fix kernel-doc warnings
Date: Tue, 27 Jan 2026 22:25:49 -0800
Message-ID: <20260128062550.405473-1-rdunlap@infradead.org>
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

Also correct one typo (word order switch).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org

 include/linux/iio/buffer_impl.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20260126.orig/include/linux/iio/buffer_impl.h
+++ linux-next-20260126/include/linux/iio/buffer_impl.h
@@ -116,7 +116,7 @@ struct iio_buffer {
 	/**  @bytes_per_datum: Size of individual datum including timestamp. */
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
