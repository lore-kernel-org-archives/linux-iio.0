Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB5333720;
	Wed, 28 Jan 2026 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769581542; cv=none; b=kIlQszDqQR9/m94rI5pNB2FtscMpw+kDzjJCHzL3sR4Rp0G1VjdW5KqqdTkytRyxjXNskbOi18U7rHDhIaoBPLkHUZ5vIIlNBzroUu69dnOPH2WE0WV9MMnZ8daOlrSb5G/xe74kZ/sQnH6eBeF0daKSKSEEoTdzc/8TbdNttJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769581542; c=relaxed/simple;
	bh=r1mXbDZxlQg+gDzv/0r4dqAEazcmCZPdDt6uJfScUfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=smJn+ooHLfi3oMaLcft/NQRYitZend5I31M4A1cbgDmXrkGxJ8FWdEF9/wpzJDuoWJytYrB7avKPM4Wwl5+K/rmR7/GlG7r65Qqepk+23ZsHdQG2HZo3TUgSggj76V3fKUuQQrMvFgrm1K9VPIKpCMJcxBgFPGjTJcaGtg91tLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BJaTqurw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BJaTqurw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TT3DhV7bl/4qOyOSLoCo3QUTEoklY1kaBBRoPi+vQ0w=; b=BJaTqurwm1FuUtBj0oXfdVxrfT
	S+UDjagDorEFMRhcEC5bi730KNFgciZzhbgrNqHE7DW1yxyQnJYKGfS//Z58qbp9D4aXbfecOvYCG
	0m6UFBqL5WYcX95XGp0Knnzx5DKvoWeJ7PyAX3HwsrF0rH8AdlMDUZNoY78rpaI2jCWbnLl7gdXcL
	I83XkgJ2N13AsRf48MRdOWQ7aG8T00Jv7ZbvEob4Ci6LshoYOIYfLe2oxyGjWdAph4CxeFhHsWKl2
	RXjX+ZxmsAP75PN1L2uCXZ8u2hdz+ZYPoFCODUbAyUQllX6/Jtj8wqUHZYzJEHjjPAmIxtQ0tcl6p
	SZ3YIM6g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkyzk-0000000FXOo-27lj;
	Wed, 28 Jan 2026 06:25:40 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: frequency: ad9523: correct kernel-doc bad line warning
Date: Tue, 27 Jan 2026 22:25:37 -0800
Message-ID: <20260128062539.404595-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Insert a "*" in the kernel-doc line to resolve a warning:

Warning: include/linux/iio/frequency/ad9523.h:47 bad line:
 LSB = 1/2 of a period of the divider input clock.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org

 include/linux/iio/frequency/ad9523.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260126.orig/include/linux/iio/frequency/ad9523.h
+++ linux-next-20260126/include/linux/iio/frequency/ad9523.h
@@ -45,7 +45,7 @@ enum ref_sel_mode {
  * @output_dis: Disables, powers down the entire channel.
  * @driver_mode: Output driver mode (logic level family).
  * @divider_phase: Divider initial phase after a SYNC. Range 0..63
-		   LSB = 1/2 of a period of the divider input clock.
+ *		   LSB = 1/2 of a period of the divider input clock.
  * @channel_divider: 10-bit channel divider.
  * @extended_name: Optional descriptive channel name.
  */
