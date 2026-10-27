Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117985;
	b=pFsE/X6/lUmmwOWjQe5S+kFTNlmhYjcnSDskKXa1c5C9kfDeLQtS+1syWUSE9u3BepES
	 6f7xLTPhk81Jxkyu1uftxfWylRIUKUScSMusGAfNSDuRbGXEX+BvUTQ9FoKy53KDa12lf
	 4sbz30j9F1Kdc1RK36MPypFkoMU8fvTrSBP0rhB3dUGuqzYRFuotfqaCOos3Qh9fiFTM6
	 bdm/cIV7rYQ28Y8PXDwBKMy2S+hbdtL9ibe0o8rTbR1jY//o/U5cO6Pfw+ZW55F/9DWWE
	 5ffBKYrnZ+yF5dKaS9BKrHJPdFixlHEHUZ5Otz+FuD7uWL3FusmPw8CyYyxGj7lJ3pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117985;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4KsMVf7JGzmeUeS3pME0rOFzTeLahdK1u2oXNHAyHlA=;
	b=aAHyAlRd5o6F71wbev/t6P4nfGKn4VM0Ixhrvj5NYo+Lni1qFywbPNXq/GtKaJo0xmhS
	 Ev8U0s1AIjDvvP55ncoIJi5kJMGtpmKnfHnVg5p2VMRGOQe+eNuENEieU8YTkAc+oglIx
	 Bk4WfPqYE/defVj2pd1e97+4Vd7SuSR7qyF8+cfap1u9jU8uXK2VgI3bMc47Iq207Sval
	 5ympx0Zy7ivoxBKAx9n/uLk5+Ix+iuLABGjrXpwW7PwmQ3BHn1P8zhrxCcJSZDsdzIq3a
	 WAg1cm94lb1ZU4eHUi4jyUk3qyBuuiAzdngo0kXGrEQPcZvfGXIjVnelLb5eaA4tOZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FNEiMFIO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3A60A3821;
	Tue, 27 Oct 2026 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FNEiMFIO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5501E1F01828;
	Tue, 27 Oct 2026 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117984;
	bh=4KsMVf7JGzmeUeS3pME0rOFzTeLahdK1u2oXNHAyHlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FNEiMFIOCcNKa1ICW5DgFHGvqcbzZpKO5zADluau00rjbEbMEakvm09yloAoZSMHP
	 vYbXgTwB6BgLZUkQnZmkHb9M7wID3bhgCEoP84a9u64MrptSkxemcpyrkaaoM1FO9y
	 oFLHQdlLZ/jdWUr9XcV4VmGaGx0/0mFq2MWK4raY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:14 +0100
Subject: [PATCH 10/15] iio: light: tsl2591: don't divide by zero with low
 gain
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-10-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lucas Rabaquim <lucas.rabaquim@usp.br>, 
 Matheus Silveira <matheus.feitosa@usp.br>, 
 Stepan Ionichev <sozdayvek@gmail.com>, Joe Sandom <joe.g.sandom@gmail.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2094;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=eaPrto2BMvGsjPbaJV0wiuHpsVsuJ6pcE1h7xYuaKT4=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjML7+iyUzmZ+3OLTopc1VqHP6UfFRiz4k6sWGD3q
 t32Xe3CjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhI7AeGBQte+dTN3RQqdvja
 gpY0w9Y9puanTjPMj1k9h+ebldHvjtCNtxvadsQf8F2lCAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

The number of counts per lux is the integration time in milliseconds times
the gain, divided by 408.  With the low gain, which is 1, and an
integration time of 100 to 400 ms, that is 0 in integer arithmetic, and
each read of the illuminance divides by zero.

In that case, multiply by the coefficient and divide by the product
instead.  The result of the other settings does not change.

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Cc: stable <stable@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lucas Rabaquim <lucas.rabaquim@usp.br>
Cc: Matheus Silveira <matheus.feitosa@usp.br>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>
Cc: Joe Sandom <joe.g.sandom@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/tsl2591.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 286dc09e170f..773b50c17e71 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
@@ -424,8 +425,13 @@ static int tsl2591_read_channel_data(struct iio_dev *indio_dev,
 		}
 
 		/* Calculate lux value */
-		lux = ((als_ch0 - als_ch1) *
-		       (1000 - ((als_ch1 * 1000) / als_ch0))) / counts_per_lux;
+		lux = (als_ch0 - als_ch1) *
+		      (1000 - ((als_ch1 * 1000) / als_ch0));
+		if (counts_per_lux)
+			lux /= counts_per_lux;
+		else	/* Less than one count per lux */
+			lux = div_s64((s64)lux * TSL2591_LUX_COEFFICIENT,
+				      int_time_fval * gain_multi);
 
 		dev_dbg(&client->dev, "Raw lux calculation: %d\n", lux);
 

-- 
2.56.0

