Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794395759;
	b=djLMJtRjiK4dBrRRxFg3dlPAz/cmZj7pAcX4Qeu/yXbNfOFHTGQmzcp6xGLziIn+neei
	 1nJYBuGZGNbKVGVLDCubc7Ezwl3GFOe6TRsh7XM0fC3p7wyrzIqrElgwZryBMa5VCf95T
	 SA7SLHYRnHBVazZy18kXGJSRfLT7IqPN3AiUnC68Fvgz9MWePnHT3nC3+DC9pjAD14Yxk
	 HCQTwcLpIbNgm3BITo/bZdZDwa4yN1cwJjHkrL6MmnJ+XZ4c0V01g7+JQg66Lpz+UwpuB
	 8JiLkwHj1c8DisV8hO4fjBCXP5ZhohROSMMvw9GnmPGLkPa6/3K9ta44/8ZzmJ/4a/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395759;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QoXDFOU7PGq6/Dzt88XHi/3F/xg2sHOoOolhNnfS460=;
	b=nDTtVCBwe9maUSnmU9HxtCQ9HKWIn+rxoDa4OHtkYimROG7COBCCqJlfdMbGUDsw0LN9
	 S21LfagnwOAaquyUBDp/K3km8IW+XW3+YJMv/VAhzSErvaCJLDaC+pSVLhWBRyDlR1MyT
	 cJG5xfg/JTBby5lmh9PRLFR9MQIEe7gUI/Ah2TlX5Njy7fljGIO9SCX/FGK3rP6F9DU4R
	 CFfwxoVkp0DFV5+jSPaoKQBbWaKJM50biS9qUXNQ6Ios+S8lCBmB/qFfSS/gs6mGw5Zdu
	 zr7s4av3oC9xjEcV3fZfqx/vG8BF3ZSLpuluapwx5+GCb9SelSRLcJiTTAf8o1+DdcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTEeUGJd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4C606A327;
	Wed, 11 Nov 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTEeUGJd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794395759;
	b=Nt4RQpfM+ga5ySPSLPhX8s4KJZ9JyaBK+cNWLNtqS8aktUuzmPDCNswqpWoskHLFPSby
	 9YYw5lyy/qSz35Pa/k/PZpWFDGJLhc/CQhPgKnEwQ7Rw72tiL0uKgdg6cIeClOVRQ19SJ
	 tE+nPznfngfPfJc+6MM6e34Z/9JAAsa1WugEUHfLAT9oLigFospTZn9JwX0fpZIQsWDUz
	 NyINYxb5v804Lf5ZMJjic3e8sWZ2hDrTk+XHAsH1A+n4OOUiDNIVt5Y/lp9rZT0jYtkv5
	 lFbL0UIE6K3vn6aAHYfwIIPAZV+g1DIkyyz8enWSMdOsEJ8ueLtYavIBidwGCQ8nqEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794395759;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QoXDFOU7PGq6/Dzt88XHi/3F/xg2sHOoOolhNnfS460=;
	b=btRh8RyrT5QwhD/rew/oHOjv1rOTCqxtUZrfi/sY2ChKGHE1fumB0kWUjr6uJLM9kW0O
	 UVZZ7mm0yDOeTnYOXYSQzHU15tJqGC0RBHQBAswWdQ8oNEXXm5LlKgShRbBsNS7kgnWP8
	 wLK6EQYBgLYfvrWJx54kFwm6yINFlbkBQdga4Ca9KK6JmJU2GKhZISjrc/k2IoEvqRonO
	 sgu6vxtZKuiT4BvUx3Cecqk1ZmSm+zFAym1ZBo4GDAfxqXSMgSlhmcjJZFj4y2Tl6fuVR
	 vDFVnJnjwIr2eRnrqfdoN1Y5U3W9lfxpmYEleL7LmnkDHRM31ujrr+ASO+Fk7A8KvDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id CF7B81F00A05;
	Wed, 11 Nov 2026 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794395758;
	bh=QoXDFOU7PGq6/Dzt88XHi/3F/xg2sHOoOolhNnfS460=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iTEeUGJdOjUraFXVuwGYomD+0WPcN9oCwQXFYR3BcTo8GLm2UhM18ixcAJs9hGVhj
	 E6eih64WxTR0GT3BbnRuVxQqK5jeflsoNlSgEFLUfUQ4Mz9LkttDxiLpl93GipaIhx
	 u/SKOQJyTvx1Nw+OCrPRdDS0XkrnPCMh4CaMNKSEiqecBaVVvVGTB7EzA58A9hzK0l
	 28VVrntWalbt6/ChLT/kZPm1o548/Cj14wsrmj9imkAkZi7UafJ4kerczc79SNB4OQ
	 tj9WL68Bb3m9cx6FxkbCDSgYeORNq48QxDtiCjfd72S4QkXOjX22L0HVCoFB5BAxbl
	 VgqZbKk8NySsw==
Date: Wed, 11 Nov 2026 12:15:44 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: at91_adc: move to devm_* to fix NULL
 pointer deref
Message-ID: <20261111121544.00006c23@kernel.org>
In-Reply-To: <20261111101345.185122-1-abdelnasserhussein11@gmail.com>
References: <20261111101345.185122-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 12:13:45 +0200
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> If 'atmel,adc-use-external-triggers' is not set in the device tree,
> at91_adc_trigger_init() leaves the external trigger slots in st->trig
> as NULL. The error paths and remove function unconditionally called
> iio_trigger_unregister() and iio_trigger_free() on them, causing a
> NULL pointer dereference.
> 
> Instead of just checking for NULL, refactor the driver to use the
> device-managed (devm_*) API for registration and allocation. This
> modernizes the code, eliminates the need for manual cleanup functions
> (at91_adc_trigger_remove, at91_adc_buffer_remove, at91_ts_unregister,
> and at91_adc_remove), and inherently fixes the NULL pointer dereference
> since the core handles the cleanup of properly allocated triggers.
> 
> As part of this simplification, the remaining trigger initialization
> logic has been inlined into at91_adc_probe().
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
> v3:
>  - Addressed review comments from Andy Shevchenko:
>    - Removed the redundant dev_err() after devm_input_allocate_device().
>    - Declared a local 'struct device *dev = &pdev->dev' and used it in
>      at91_adc_probe().
>    - Declared the loop iterator inside the for-loop.
> 
> v2:
>  - Dropped the simple NULL check approach.
>  - Refactored the driver to use devm_* API as suggested by Jonathan Cameron.
>  - Removed manual cleanup functions and error paths entirely.
>  - Inlined remaining trigger initialization into probe().
> 
>  drivers/iio/adc/at91_adc.c | 185 +++++++++++--------------------------
>  1 file changed, 52 insertions(+), 133 deletions(-)

I'm not sure if this is an adequate fix. I'd imagine there would be two patches,
one that just adds the simple null check so it can be backported and this patch
that will go upstream.

The commit that introduces the bug is 14 years old, so it doesn't make sense to
me to backport an entire devm_* conversion.

Jonathan, Andy, what do you think?

-- 
Kind regards,
Joshua Crofts
