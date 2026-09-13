Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6838735D;
	Sun, 13 Sep 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789333990; cv=none; b=bQo1qPhVuvylJyDC0B6F5sxthQZlEiTkwi4KCwYas0orYrm0Na4NpVjDIX0kMRN9Ra1/WIFofJ39BYhgVsiM0rJT908yvA4llyNZx/zEJICSTJwnXtQBI7godSBVcMbNjJ7dvq9NDvcZ6JEP0DO0t/HQvE1+wk/yoPBFGTGZmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789333990; c=relaxed/simple;
	bh=XO2m+EmyzEhdxQpTMg3HesA2pk86ASTlsqbXQia9Pik=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=qUDOrXGARpydVS9gsok8MTXzHJi2hjmOMtrJ6Z5cQU2Qm8reEdq4Crzt15xyQVO2y5uQ+tnaX3aUiw2pK03LX/yTIKPS6vVbknc53GgT3t2C8FraM6WtRaTZOxyisQvINnYI4cRLktxwMUrsGG7L/9ByEAlBTL5AFpB1am1HCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6GBYu8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6GBYu8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4A01F0089D;
	Sun, 13 Sep 2026 21:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789333988;
	bh=Jl6gquUKGO8V9WB7lcjRyipstCblPfbTrnNjTycRUQk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=g6GBYu8qFFr4omlJppNFx2OrF/4eljzvjKyV6WLZe1q04+rDjhoRoU3XiNMPm8g7C
	 DKQV5ltlfoSpdffTuPRFQXB3PMNEx3d+NFbg6acJekXmjaXED6blA6l5PgxHs1+lFd
	 on/ExWrgWI38w6sjak75bL1lfQIHXUrHg0bXN4U5bXbh90+P0p+KZnpj84BYYP9Lz5
	 PqCI5R8nd61n/+GEhQlJsv7PPFPO07r65QVxgqs64NDIKctFeHd2Oq4Kz7/VddbFdw
	 Sud9cZq4PaMdzdGOxeTEY2LuGIkTl/Dus/JxfbnAxTBDuQ+K7CYdwqlq/mGX8Of94w
	 dj9CaRvFqALvQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 6/9] iio: adc: rzt2h: expose sampling frequency
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260910085430.3173166-7-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260910085430.3173166-7-cosmin-gabriel.tanislav.xa@renesas.com>
Date: Sun, 13 Sep 2026 22:12:40 +0100
Message-Id: <178933396021.413489.9480922200160073497.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=XO2m+EmyzEhdxQpTMg3HesA2pk86ASTlsqbXQia9Pik=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqpxHiBMIfYy7KC5dL6i7ZiB4Hl5A3qHgo+b8sB
 bTYVRBeULiJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaqcR4hEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiFmKD/9f8i732yUMMCaztcprTqpIDyeBjBWmj5TE5gzw3k5BeGG
 llLz4juJcSZsm7V1EI21KE1Kn4aBX/5YgvGLMAW1W3TbGb3iptElc52UHbllKJ4/8akFTVlqVt/
 QKNRmUwX6oZNJyFmhSm5sX0IGSmZOXUVbJ/EdXTFD07zYKWXkqv3lhsAKU71RVBk/+BMTZAxlsF
 01RXhu3zH6M/6pWvCOh+fOWAyYO9+o0xalnZdxy998XeU3o56oVIhbgRSsNdG9kW8z9Bhw+nHwl
 pX+4MCJcDhoWn0lh3u1y4FUomjWNtAklspv2gy/z4wqG2stCmXNHN3cUZmypq2K/2+pEt+bcx5J
 4hiycXfgYqvrhY+654KIcPQ6flatI8dYTZ0X5ECpi00wXY5+15VOBcMd1GeoGtKwGTAFOwDfIUR
 JGid7V4RqzFTUx7AEpzDvppInkRF00dys1Yi0H9905zSff12pu1e5sLGiQ5OUzbHecsNxiTBupN
 443erJDehE/R/XTKZdCKTTSVHxFtsCKc8ZVD2iinvbmLDjY8FGZo3AV1FzuX/N99Nn5zJ6JrNBw
 Bnu2txfNp3QmBAqqopbGzDWYydPpjcBNxK731jpnzkGRu7ByhVdBNfCUz1Tuw0mElRGnNEVLECg
 hQmuZGEs7DCxCSXYlc7bIPEN6eS8oqb8JjpK5AQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Expose the sampling frequency as a per-channel IIO_CHAN_INFO_SAMP_FREQ
> to let userspace control conversion time.
> 
> Each channel conversion takes a fixed 13 ADCLK cycles plus the sample
> time programmed in ADSSTRn, giving a rate of ADCLK / (13 + ADSSTRn).
> 
> Read the ADCLK rate from the "adclk" clock to derive the frequency.
> 
> Claim direct mode while writing so the rate cannot change during a
> capture.
> 
> Program the sample time into ADSSTRn for each enabled channel on single
> reads and on buffer enable.
> 
> Wait for the maximum amount of time a conversion can take + 1 jiffy for
> the completion event to come after triggering a single read.
> 
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

There is a sashiko comment on this one (See below) but I think it's
in the category of things that we don't are about if a timeout
has occured.  Please sanity check but I'll not hold series for that
one.

>
> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> index 0460dffe189e..8ba7b0fde8a1 100644
> --- a/drivers/iio/adc/rzt2h_adc.c
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -2,6 +2,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/cleanup.h>
> +#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>

..

> -	ret = wait_for_completion_timeout(&adc->completion, usecs_to_jiffies(1));
> +	ret = wait_for_completion_timeout(&adc->completion, usecs_to_jiffies(5) + 1);
>  	if (!ret) {
>  		ret = -ETIMEDOUT;
>  		goto disable;

Sashiko:
[Severity: High]
This is a pre-existing issue, but does branching to the disable path on a 
timeout leave the driver vulnerable to a race with the interrupt handler?

If the timeout expires and the hardware interrupt fires immediately after,
the ISR can execute locklessly and call complete(&adc->completion).

Since the disable path calls rzt2h_adc_stop(), which only masks the interrupt
at the device level without waiting for executing handlers via 
synchronize_irq(), could the delayed interrupt complete the structure after
the next read operation calls reinit_completion() in rzt2h_adc_read_single()?

If this sequence occurs, the next read could return immediately with stale
data, and its own triggered conversion could eventually interrupt and corrupt
the subsequent read, leading to a persistent desynchronization.
-
With a timeout we never expect to see I don't think it makes sense
to care too much about stale data.

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
