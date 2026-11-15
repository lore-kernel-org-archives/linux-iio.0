Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775559;
	b=q91J97f2tNLq+T4JdbTPrNRVZdSD2vBBRt8Kd0hiMKG3U7B8d2ADX0Tu0/6x0nVOMFnk
	 MQaaewU6PME9TgL7VYadzfQUbB2CvZjX0CIjbbyYHdxiN1y/xh3Iw9DpGY0UAucqMrpDS
	 IXNDLZXUAyDL0iWGsAij5ZRjiOtpWbSMgigsIOuEQ+z8d+3+bVd5TRd14JkDjDgiDiCQh
	 0piEIY9e5XRBXqJz8CF4LUsqGPZvFm4H66s2qAoxC5vjP4jo/rDkt6GE3JyWU0r0V6WLy
	 PYpqRIcfSOTptTqxQG/fJ4k87jvzRNBBuCVbDi7vXEeSfkVy3DV30L8Ergg/V5u1OGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jouxlhOzLpqepWHajds1z8FuAnArg4ZPk+Xi5qk90og=;
	b=3+ch1WH39cIn+2uWMAQacVlIa1AFFvDNq45NH6gRtd8jJ5a9Ro0sJFT7KtZZ8o4qpnxp
	 9uxpMwB3RgfxCJrzbwthyzCdCzlgocvEphI7bBiaw1FRFn2J8Pkm6O27lxHq4xOInzKEb
	 KSEUVjn4qG3/kJr+igqRS6btOGCshRY1W2gAyeMhMn5yIpaYb2Qydzhhhcc2Vc1ciFTlw
	 bssN3Exw5RDtUV0F7EpZj2fzULGBgEJQzKwW2BOWdXxShKgBjgQh7tYuXWyAH+mne3i8g
	 gZRnRU6yy4Kf2d9nbEiE5cyHM45Jl2MSh0IdVw2vHyGxatDjMUahxGIcKEvPDZSW0tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PamrlYar;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4921606A32C;
	Sun, 15 Nov 2026 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PamrlYar
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69E1F000C6;
	Sun, 15 Nov 2026 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775559;
	bh=jouxlhOzLpqepWHajds1z8FuAnArg4ZPk+Xi5qk90og=;
	h=From:To:Cc:Subject:Date;
	b=PamrlYarhMPhcfvheFoctcVhWuu5/mxJwW5usODJ6fVZbrLqj+/ArkyGwRtVe/Hw8
	 GFD0CAVbzUb+D81Ahf5R7RM5tCnvGJNHwRcN1xMv10Nuwtj7u3NUnviPO8yP+yJgG9
	 uKXoq90DzMMfTbcUp0SHm5gqsA1ykj8k8rPNjvjnNWMDAhPpaR9OHAQ2sGezDRAJXA
	 JkJkGTMkHwl1p6qReioqZOFB1V/RImzbIAXSe5p1QhfznvtDQgh3C2JD7JdtoMyk4b
	 KkSJWKRcl0DmHTemduFnS4DeybVgSuFXFO45ZSywkDk8shAqHPgwGN2ZWjSoK0mtSE
	 /Wg0pCwiVD03w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH] iio: adc: max1027: complete the EOC wait when using an external trigger
Date: Sun, 15 Nov 2026 20:45:51 +0000
Message-ID: <20261115204551.2783884-1-jic23@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

When an external trigger is in use, max1027_trigger_handler() starts the
conversion and then waits in max1027_wait_eoc() for the end of conversion
interrupt to complete(&st->complete). However max1027_handler() only
completes it when the buffer is disabled. With the buffer enabled it
instead polls the current trigger, which is the external trigger
that is still being handled, so the poll does nothing,
the wait times out and every sample fails with -ETIMEDOUT.

Complete the wait when the buffer is enabled but the device's own
trigger is not in use, as the comment above the check already
describes.

Fixes: 075d3280b4a1 ("iio: adc: max1027: Allow all kind of triggers to be used")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---

The comment clearly states that we should just complete for
triggers other than the one provided by this device, but the
code doesn't do this. Ideal would be if someone has the part and
can test this.

LLM spotted the issue whilst doing some other cleanup and
prepared the patch.

I think the reason this got past testing was that the code was
fixed to actually return an error on timeout whereas a bug
previously meant it always dropped through and carried on.
---
 drivers/iio/adc/max1027.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index d475cc91108d..65a0e85faca9 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -478,7 +478,7 @@ static irqreturn_t max1027_handler(int irq, void *private)
 	 * with another device. The core will then call the relevant handler to
 	 * perform the data processing step.
 	 */
-	if (!iio_buffer_enabled(indio_dev))
+	if (!iio_buffer_enabled(indio_dev) || !iio_trigger_using_own(indio_dev))
 		complete(&st->complete);
 	else
 		iio_trigger_poll(st->trig);
-- 
2.56.1

