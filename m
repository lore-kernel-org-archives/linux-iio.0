Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7DF2874E3
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720151; cv=none; b=OmeKIEH3s3D7KwqbQ1b5nfec5KfwHrn1IUNSBkdRcy74HKshx3x9omB7SeTn+vODZQft0lU6g/tC5H9WqQsXjxDWeWAaBZyFH96kkGL/n+hck6m9q3sv7AY+lF+JQ+f7d6Bjq6jfBV0FGpZJAnf3RLqUAGx+Fl5aki9czMv5EYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720151; c=relaxed/simple;
	bh=WoKu83GnxoVw8FpSe/svac5iqGUXbqdnSvWjA0lXhbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2n/l04wpAr0wyVjlZl3RtNS/UJgI1L0Bio2VGPK0/QhEFD1Hmsr5pJMsOTW9gwzrU3JB5rLi5nEA8mQ+Aoj5TA/0h3CW3diELydG3xspcIL6/eAa57BuEb2g4zYYRgB+mkMXAVD4IcaNd2ciNNH9EfZNqu8gjNyUB0DqIDP8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+F60NQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+F60NQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0A91F000E9;
	Mon,  3 Aug 2026 01:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785720150;
	bh=bHLZFEwChFy7Fvy0x3lmWI8CRlaMFVmwTpVvKxqetxo=;
	h=From:To:Cc:Subject:Date;
	b=G+F60NQktpvujt/F2IR9FqT5EtYE8wgprDNy3TLGJEWvnxmZzHk5P/ohRMSoeHAxj
	 ryVGet+BdwF0TzrYSuSLVE8hsvdYBza9Vjw2O2TMO3PXkH+NAM6hgKR2M0qj656fvc
	 EbdAmfv9jQle9Q+N+m/nUH/fgq6lZKeQUxCJR9C5GOeO7kea4GI+UjaYaR5dpDzG0t
	 OlxijwBtwYjCTXPfqANjBFVltxdN7+XJPwHBvWU85zH+KmyLCEKboYMWrQBRc27YaW
	 lO0ARotTHBVRkxrVvDqycttt1Kjh/H53EC9eWeuiIn6Ue2gJbtu2qjP1yYkpCzlSqH
	 ec1uW6rlBTsgA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jinseob Kim <kimjinseob88@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Sanjay Chitroda <sanjayembeddedse@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned case is zeroed.
Date: Mon,  3 Aug 2026 02:22:24 +0100
Message-ID: <20260803012224.219493-1-jic23@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
to userspace if the data passed in is not a multiple of 8 bytes and the
timestamp is enabled. Specify __GFP_ZERO for the devm_krealloc()
to ensure any extra space is cleared.

Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob88%40gmail.com
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---

v1: https://patchwork.kernel.org/project/linux-iio/patch/20260604084307.640053-1-jic23@kernel.org/

Drop the memset in favour of __GFP_ZERO.  (Andy)
Thanks to Nuno who pointed out there is a self test to ensure this
behaves as expected.

 drivers/iio/industrialio-buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 531fc4ccc15d..4960c8377932 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2464,7 +2464,8 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 
 		bb = devm_krealloc(&indio_dev->dev,
 				   iio_dev_opaque->bounce_buffer,
-				   indio_dev->scan_bytes, GFP_KERNEL);
+				   indio_dev->scan_bytes,
+				   GFP_KERNEL | __GFP_ZERO);
 		if (!bb)
 			return -ENOMEM;
 		iio_dev_opaque->bounce_buffer = bb;
-- 
2.55.0

