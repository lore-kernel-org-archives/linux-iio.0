Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857E3AC0C7;
	Thu,  9 Apr 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742055; cv=none; b=fTh8ruPUfXEPt1jEpZj6wNh7Ttlss6tBsiPOBY07/KB7pS7d4vuNw37BYpHjisXQyd25Q076RAabQyU0pjTbv/dQ9yLtOwZePIus+HV44+Nc2jRiBpT0imNdqM80W8hRIxlmPlZi3IMkRnxC46VkOizVHWcIaH+WUpX1vWEIdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742055; c=relaxed/simple;
	bh=NT6ZaDBFXxjiBxIPO0bW6BFt8fd5WH+0up5keRkph8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t4hqOl0/bYbRgQOO+KwuMJy/JAo5ReTixZdyIWghcThPvvBa27MVs+LCz+N5bbLciGpAIKSsg/sZvnwS/nadH4+yhrDyCTaIorsHEYpLkETQCV2qK6FTyvAsTYiZ/0MeqWplrMUL1ES2ZNZoLkwMXCUJyEuhIqJDRv/IIHyxRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XEc8m0o3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XEc8m0o3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89E7C4CEF7;
	Thu,  9 Apr 2026 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775742055;
	bh=NT6ZaDBFXxjiBxIPO0bW6BFt8fd5WH+0up5keRkph8w=;
	h=From:To:Cc:Subject:Date:From;
	b=XEc8m0o3PbOmSmu7jxl36wsiSqIn+BYRy9ZIdZwIEuSBoAcxe9uyBZ/piKKz0JKBI
	 4V91r+7MkTGwtcHH6auFo98RX/9b5JL9c7kZeB5QgkibKau4o6IdhVJBdTr1zL4u+B
	 uS/NoWMJ4RaRsUUY9Koh+L2Fkaf5aaSU6iWxNwtc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH 1/3] iio: pressure: bmp280: fix stack leak in bmp580 trigger handler
Date: Thu,  9 Apr 2026 15:40:47 +0200
Message-ID: <2026040947-overhang-fax-02d0@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=NT6ZaDBFXxjiBxIPO0bW6BFt8fd5WH+0up5keRkph8w=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnX18TPXrw37MO2Tw0SuzZcNnr7WI8jyepCeua32MKn0 h0zWoNrOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiSQ8Y5gcf2ZDvkMN4cIJL +ac5kZqHOs2jnzIsOHbA5huTDtPMbwtvfFd7H3za/Pc+FQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

bmp580_trigger_handler() declares its scan buffer on the stack without
an initializer and then memcpy()s 3 bytes of 24-bit sensor data into
each 4-byte __le32 field.  The high byte of comp_temp and comp_press is
left uninitialized, and the channel storagebits is 32, so two bytes of
stack are pushed to userspace per scan.

This is a regression from when the buffer lived in the private data, the
move to a stack-local struct dropped the implicit zeroing.
bme280_trigger_handler() was fixed up to handle this bug, but this
driver was not fixed because there was no padding hole, but rather a
short-fill issue.

Fix this all by just zero-initializing the structure on the stack.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Fixes: 872c8014e05e ("iio: pressure: bmp280: drop sensor_data array")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index d983ce9c0b99..9b489766e457 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2616,7 +2616,7 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 		__le32 comp_temp;
 		__le32 comp_press;
 		aligned_s64 timestamp;
-	} buffer;
+	} buffer = { };
 	int ret;
 
 	guard(mutex)(&data->lock);
-- 
2.53.0

