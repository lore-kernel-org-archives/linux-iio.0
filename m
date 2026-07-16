Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CD41F36B;
	Thu, 16 Jul 2026 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204078; cv=none; b=Q1la3VAJsqlPXlLPZ8bcsazoSNz82/7GlNJfgx2FhiFca7zxd6LdMP3pJlAaq5HAiaYu5bHRTjqJYCXu6MJAvSbWavnMMIcTPURinS7zcMG2dR4tPq6jd+5DyzDkodlnyzFp8ukffAVY5lMBTeoZBYtRKQ5bGDWONoFhS8mbsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204078; c=relaxed/simple;
	bh=FTaA6P6cACQCqvNkO/eeVW+Qzfgf+RrEiDNTaFytseI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGvtNzE/B1XkTTwqc8zJFBOSPtQT4MzpDbAnQga91LdaWEvMr+lgxZp+SnKJ0H58eHbXh5+FGaHPUFgRvEgtsAk7BNyaOZPhCI8I1ijiWXNSfr7JjdZDP+cjadeYM1o5KL6McnZP4It2HcA2gTmMeN5+KV2MBE4HCGw2PDVbs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHl90W20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHl90W20"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 724CEC4AF50;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784204075;
	bh=FTaA6P6cACQCqvNkO/eeVW+Qzfgf+RrEiDNTaFytseI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RHl90W20KYM6Yz9QTDJs/VyEjvA4h9dOZHYqMBIGH8/V9qgC/lKzZVs+1/23/u8VE
	 ht/Sgw/+GzFT37UbmcUDOtqOiwfXF29upYJC76FL5kBlw7GhzzH3z62y7b7A3T4ret
	 5KUAf5vCNeXIu5YFY32B94/ih6qJXdWehGdrZbKbpijKGhrCWeQbngIgPLRmd/ofj2
	 Tp0oT8XW0pr23ulEomSMyiNjrwDTnpdZGswgW14sxICbkT/ApdSPItUTw4Qz7ltsDy
	 hwFFLHnfcLk8r7mNEEIpk3V/HnXaw7CNteoEA6V34KoOQtZ/btdig5jxEf0507j55S
	 cvOlALLrjeqhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500A5C44501;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 16 Jul 2026 13:14:22 +0100
Subject: [PATCH v8 6/8] iio: dac: ad5686: read_raw/write_raw: use
 guard(mutex)()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-ad5686-new-features-v8-6-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
In-Reply-To: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
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
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784204073; l=2244;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=BcgCZiXLdZZR59ERuvhrdjKwAQM7osR14G6RyRMDnDQ=;
 b=mycAkS9G4xk7KOCPWaN7Od6i+Caim9GEHlrYtvLCQLGTKFVWFNpQyWVxT82SmSMfE7Pu9WtGn
 KpKbnZxl/P/B4Olc79TA5JgRcadxQy4G80mvD8rJ/0eArtUSErc+lRx
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 67cd581a24c5..68986dbaccea 100644
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


