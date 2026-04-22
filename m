Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E7345CDC;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869184; cv=none; b=RxbYVm9J6WUfdfhFjQjtB+68ffXhBhfD7nFcmCaV+q9o7Seci3WomDy7w/Nhq096372k7EwzwazzJeL4d3St6s7ScXGdXw2ZRKPksDF9vK2Ta6jWynUxqLNL8uWFId0/Ga2PYdfO29zutBSzv12G4gG9Mrn8aWdVndtVp4wU3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869184; c=relaxed/simple;
	bh=fxSwh5YZV0lJwNqSnII1QOTZVKAjsKtIukTH30xl2OE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7VBHRaSY1hqniefppe9Zc0IQusdRUH4OezTayjmHf/ObKCX85Nr4l9dakcqu7OFNN3VpTxJbe2y3l2PO/xDJFeKhTWBWKcwEdFid6AU5nadF1bw/UiSYmiy5Ai0wJc3ve2eJpzNRM+4Kqi+hsTYfk9j9oHy0IwmQ49Va9C8iFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKbhA42z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKbhA42z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9A04C4AF19;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=fxSwh5YZV0lJwNqSnII1QOTZVKAjsKtIukTH30xl2OE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VKbhA42z5pTeKTR83QwZzXsi2Iu6DfE0gCqqcGxTV3K321c0xo77BioKtZV7VC0qv
	 XGjJ6s2sZg9zO2ixuOJ4eERaAzfQd3Kfmi3Mf7HLbQhxUcz+1owB8RfS+OA34Tt00Y
	 8iOwpQJ1iWQwme46oZIgPnNAvCJEqxMaRzjuu12lCj9pGfjqkQACovG3TB51D2b35C
	 wdSdJWanvXqIRoEq2ls9kUzfqagKpEFLNHgoTkOIHnVSnXMWxV6hwA3lwOO8fnRkdV
	 v0uJtE3eV6ke7+Rw2fiP/LqiC0vGBfJdGBTQUkoumAjDNWaTAGgAsr25JDVlOokGex
	 LYbfnv+77bKPw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEA8F9EDF7;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:47 +0100
Subject: [PATCH 13/22] iio: dac: ad5686: fix input raw value check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-13-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=852;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=f6PzyqSsWxOZZP4d7ht2aA8eC0y4w+JduFiMQSa6zy8=;
 b=2zDSyBy3PiTZVEfheySnluorFvGYtbMC503N7GbMqpmFI4Jm1nUdvB3I0thMUFSWM83HzqcPR
 NgfzkzxSvc8Bm+dugDpgBA2e98CPjy2VtBOwH6QPUNsVoKE+kSQZMgm
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Use in_range() to fix range check for input raw value, which is off by
one, i.e., for a 10-bit DAC the max valid value is 1023, but 1 << 10
equals 1024, which passes the previous check, allowing an out-of-range
write.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 19d791c655b7..07a944311f0e 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -185,7 +185,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > (1 << chan->scan_type.realbits) || val < 0)
+		if (!in_range(val, 0, 1 << chan->scan_type.realbits))
 			return -EINVAL;
 
 		mutex_lock(&st->lock);

-- 
2.43.0


