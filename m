Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB83D3CEA;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212160; cv=none; b=b8TUK3yLE0GcYdE5ogmKARIGuG1hGlHyFOWbhUa9Jf8cu1h2KtpesacxcbEHhhhqWOXBOz6RCI/4Muu7WyHhAJdztwyI6Oa1wrH/HWsZYxLhIIf2vJxnODFbi6IUVgiEP4FOUtePiZ81fV00jqVc5t3raHii2vjSwhilb8fDJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212160; c=relaxed/simple;
	bh=XktOlaasuSm3hYXKmS8amfCoiKQ/2h3DNBwBGo5qc3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f88iJ7WiEM4fFKQUPtNfCOItG+T+mys4zSDjKHfyxSn2A9lPkFb3UrZbqtWV5sl6p0bP2Qylvihw6zUuDOYD6RXXA7qhvwu/N6ftUEPmx/Rb0ncSwrJXVNjYOF1NigyhnYCsDkgKbA9vGaMFVImXjbVmz7+NRJp1bbb45JpCD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG+F0dCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG+F0dCt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D045C2BCF5;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782212160;
	bh=XktOlaasuSm3hYXKmS8amfCoiKQ/2h3DNBwBGo5qc3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lG+F0dCt/HbyjH1xzL+8uGMetdtQhkdsZCsRrAqNigbROVcN1x6i4U1lv93hwCMW3
	 T9Cr/5IEtsQabeL+O7ix+K8oGJKnPvRK2dmZ9+P74UN0TfgluRIpGYyDr+0Xw52YeF
	 CSzWuot037B0PHTGMhEfij2LQLiIcW26XkqTW10+OxFxS0IfigqbZNME1nYpp/RihP
	 dUWgRQGP4ESnhwq4HIG9N2sX0moguOJ9lEzCaOS5Vkhg0UAmfM3/3OSYztKZbonRgG
	 aqlSew8iWnjdlls74vl0l9qLHFcbz8noBYsiBMUA2QA10iRXBN4LvCdp64+pvkBhzN
	 MzbSWyD40gBcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3383ACDB470;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 23 Jun 2026 11:55:50 +0100
Subject: [PATCH v4 10/12] iio: dac: ad5686: read_raw/write_raw: use
 guard(mutex)()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-ad5686-new-features-v4-10-28962a57db0f@analog.com>
References: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
In-Reply-To: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Maxwell Doose <m32285159@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782212158; l=2132;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=KXdOCM8K80hSnPdNpvlDlxzShY7L4kR4B4GuvME7upg=;
 b=ZoaP9D3S1C/ZDb5Y/umaSxJ7T0JDRIk/kaNRPwyiWRSyqvJLxkjMpLqrvbOjsbgLqTjABno7S
 knXYJbVzew+ComIlrQKf5ZuREylVGdBb1fRnNQBXLCuofNzwe4YOzxE
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Use guarded mutex lock to facilitate code review when adding new
attributes. This will allow for early returns, avoiding error-prone
locking and unlocking in error paths. This also adds missing include
linux/cleanup.h. Gain-control support will allow the scale attribute
to be configurable.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 75dd7921c67b..db175e77b0b7 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -8,6 +8,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
@@ -177,11 +178,11 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 	struct ad5686_state *st = iio_priv(indio_dev);
 	int ret;
 
+	guard(mutex)(&st->lock);
+
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
 		ret = ad5686_read(st, chan->address);
-		mutex_unlock(&st->lock);
 		if (ret < 0)
 			return ret;
 		*val = (ret >> chan->scan_type.shift) &
@@ -202,23 +203,19 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
-	int ret;
+
+	guard(mutex)(&st->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
-		mutex_lock(&st->lock);
-		ret = ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
-				   chan->address, val << chan->scan_type.shift);
-		mutex_unlock(&st->lock);
-		break;
+		return ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
+				    chan->address, val << chan->scan_type.shift);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static const struct iio_info ad5686_info = {

-- 
2.43.0


