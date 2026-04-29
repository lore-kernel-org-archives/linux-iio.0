Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412403FBEBD;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=IsIJPRQ6cpNpljsF6p6iYIQ049eTKIdmtIhA9HykUYmBI4jY7a0ciOvIjWohPTDs38/kxyayJHwmQZm314+ciD5Xealjn/SnEnpZx6SgqBrKYQsa9F75J/NoDb2xm1S+LH8EmnGlWyQjXIhrPstdroFillGGLWzwvZrXfKNJcLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=sM1kRdBJCD4TGiRYIknbJztxuL3qEzLsr8B45TCbhY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ao6pUcl5F5cOtEQiOidwT91XgfsjQV9pYr9qVLMg1+5YPpMUSGQRpEqeay1gKZ0WV1ClzGP/zcEaRQmhtbIK6NPcPBrtSQt3/qSUe1mAnLuc4RkurLzXKjMDernZaNibfXxHzJlpjWVrGsE0V9XgxYVHA2KNgt4Yx0+sEhPhGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGRAhzgV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGRAhzgV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3FA1C2BCF5;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468057;
	bh=sM1kRdBJCD4TGiRYIknbJztxuL3qEzLsr8B45TCbhY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lGRAhzgVKzzRPNVpOTMhDpqAxaLrqDNDPyLEFIVdv0iC4+BrcKtMA043Cwwo6jN/9
	 9XS6CQxqUvVhZB3zS6EZ9mtLJ/BwJQskYi/QZsNKq6aw7X6CkZLkxEcjl2kgWmYveU
	 DpmUjUTU+LgsO+Cngr3KwzDvMRq4v+jiQ39lTdvkoQkkZInrBLzuYWk75crQmH/JXK
	 Tkxq9SJqbNypT0jLYD8Do9v5c/hFDjaYEVC4IEXbZW6DRXSzTXDzWnhOtcLE/q1A7I
	 KamQIRL+ru9LvAgoOSDMeu7wIy9Xej/GUB3gBEBHq9AXxjvIg1Pxw6ETSw2Ch1Cc1Z
	 NY/lHrK4mtEEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC538FF8875;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:35 +0100
Subject: [PATCH v4 05/13] iio: dac: ad5686: fix overlapping DMA buffers in
 I2C read
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-5-bb8f1cbd68e1@analog.com>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
In-Reply-To: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Rodrigo Alencar <rdealencar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=1342;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=z//9u6PswtgHUejmo4eNzd3La9IQg4Jj8G/hjxUaHc0=;
 b=Q5kCfVXd2U0uebBfIbMgi/xxxP092I/getGLhO8heWIERHqVUwrL33qNiSNI3sKyyEhZIdFPt
 7AB/vH7vdh9BeyGTOPuhdh1CyWfhjveeo7JcuRCMmnt1coUliChCjMq
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The TX and RX buffers in ad5686_i2c_read() both reference data[0], causing
byte d8[1] to be shared between the TX buffer and the RX buffer. I2C
controller drivers that map all message buffers for DMA before initiating
the hardware transaction will map overlapping memory ranges with
conflicting DMA directions (DMA_TO_DEVICE and DMA_FROM_DEVICE). This issue
was reported by sashiko.

Fixes: 4177381b4401 ("iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support")
Signed-off-by: Rodrigo Alencar <rdealencar@gmail.com>
---
 drivers/iio/dac/ad5696-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index d3327bca0e07..d3b46496d67d 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -26,7 +26,7 @@ static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
 			.addr = i2c->addr,
 			.flags = i2c->flags | I2C_M_RD,
 			.len = 2,
-			.buf = (char *)&st->data[0].d16,
+			.buf = (char *)&st->data[1].d16,
 		},
 	};
 	int ret;
@@ -39,7 +39,7 @@ static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
 	if (ret < 0)
 		return ret;
 
-	return be16_to_cpu(st->data[0].d16);
+	return be16_to_cpu(st->data[1].d16);
 }
 
 static int ad5686_i2c_write(struct ad5686_state *st,

-- 
2.43.0


