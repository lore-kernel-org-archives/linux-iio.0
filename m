Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51C3F7869
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562601; cv=none; b=rJPozKf0kenvzAhkgec3kDX+QUsy/kV61URxg8WsBbyNo6SDl64fNp4tdMcHL8lh8+bh8JVsXhJZpTVjpwYumKnB7F1rwymdTag5AtpA1XPK6MhJQhzNI9T8uSmenjqIQaQD3+9YI1IwSLp2w0h//KRBGWBgrrKFKnriLuMrUrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562601; c=relaxed/simple;
	bh=cm2tXAnBC2VyaUQyCNa9FGk7UUi5xqVxJcZusYpA/Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXflSI0dx+uRX/Zf5+6mprVOCTgR6ttN+gv9yLzHSW+DV5nA6gda4tE+P3j4cJiC4XsZ//XsiJVPij3iE+cjW2AvdE/vnHBxGPVk4mZuPxkyl3AJv7KPJctkork79YtFRIn/zdAOdJwIFQRXwhLVLqDgDExP6+85tph/FrUVKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+FKbOpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+FKbOpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655291F00893;
	Thu,  4 Jun 2026 08:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562600;
	bh=p6x5nSnDgcx+5fHk0y4ymp+aNMV4Puft4q4NggUmWRQ=;
	h=From:To:Cc:Subject:Date;
	b=Z+FKbOpBns2fS+aYgXM7kIdEi+CAr+HmOv9b1RXd5ELp8FmnIthdtFvtkZIihfDMA
	 aDWB3jV6ittkDLESATFpYIIhgQyFRJVX2AwkCCYOV+OtR/2Do6qqWwEXp9GVl8g5YN
	 fHXHuGmU+74qoQhy1t1H2sVQahlCF8T7QeAT0J51XPxCnTeWPjWMKY60GaegtBA8np
	 LZYPx1LQqsTjdFc7WDkTfmkf5M91Y69UNmbgyi5/ckOR2v5JayTs8TunF58j5QBqfu
	 FFCNWVwLtoyVis+dGZdkuQPXoQkj0whCqiAPwmG1mRBz3styGbk00r09zcmZRxOksi
	 ACFfSm2Hqoq6w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned case is zeroed.
Date: Thu,  4 Jun 2026 09:43:07 +0100
Message-ID: <20260604084307.640053-1-jic23@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
to userspace if the data passed in is not a multiple of 8 bytes and the
timestamp is enabled.  Use memset() to zero it after resizing.

Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob88%40gmail.com
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
v2: Zero the new buffer not the old one (which might not exist)
    Drop bonus Reported-by:
---
 drivers/iio/industrialio-buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5c3df993bea2..157b0415091a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2445,6 +2445,7 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 				   indio_dev->scan_bytes, GFP_KERNEL);
 		if (!bb)
 			return -ENOMEM;
+		memset(bb, 0, indio_dev->scan_bytes);
 		iio_dev_opaque->bounce_buffer = bb;
 		iio_dev_opaque->bounce_buffer_size = indio_dev->scan_bytes;
 	}
-- 
2.54.0

