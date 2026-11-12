Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450386;
	b=jvYOTzA2NKsdAqxmoDmgQn85gneJAsBxkdBS3FlVNNB/9lmubnAPMeK3iMejcqPb8vQm
	 ciwsO/zLJ8tjSHN4KkVeuA0xHg3RG7QaHWGphg24Lp6sF5vQG1EjFnWqh9qHUlxzShApw
	 XJJ/nqQLE+vca8aMb6mq4twI+mKirSn03b2I7J9fgHvGVTWY35ic4xvUzVLZh9PW+V81/
	 l7hOLTkrgdLwBUuwV1JV0Jn4lvrV+d6EICSjJqsxLK+g40ukdHSunu8zfszxIMB+ZNNrL
	 +gzGKWz+QOj8bufLNcx3YSEoL6pLCGHILM/DWrxPczSGRCyPIDML1m8yYpt/v7Onmqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450386;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZKKsCw25bN8QIo2qnZkKp0J3NkYgtDw3pdERHmxH12g=;
	b=PgKQneqAM21xA/JyZHKrcXqjXT+E7L3ZYhOnu3hbh4SADSG7yuz7PSiH49scrgXE0uxA
	 EBkeyFrO3Cjz1Xn/v+/WZ4lGgS6exvczV7PiYIc+OCRnUpvemhyS6S2s9Zp3g562njfwn
	 z0Dt9Q9d7USI7aOANUHwY+pqWmOa83EIsBcwzh1p2kq4hR6Sg9CTFXzCI9773lBxWCm2h
	 AhhTLbMvqUx6wJBm4+H4ZOwzFZPXHVy+5F8gnEwZB1/6P2h8SACS99a75rsBDHfAS2XjO
	 Ysh6CiL49LQtKyPYYkgtyhPXpQ8Pb/FhmUUcHagjWMGDdcXTdG7DD+MMa579KuFbzXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V0y/59U6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB6606A31C;
	Thu, 12 Nov 2026 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0y/59U6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5711F00A05;
	Thu, 12 Nov 2026 02:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450385;
	bh=ZKKsCw25bN8QIo2qnZkKp0J3NkYgtDw3pdERHmxH12g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V0y/59U6PTHaCvD7UUgWfz8yVtke15Qxj/yORI+W2+OO7p1dckoD5hmtzVh6/Sy+0
	 XxO2fXYzBsKukAcvcoDy1LtFWaiSspxLrT5qGTgg7Pl3PX3chM+gy4WOYB+HoREvLI
	 mYqGBMUfJMiEQ+fiudq0608Nxo4i2fQXaVQNepIvw3joh5RNJCsolqTKCT0wtn1fvj
	 gWv0jgfnjIkvZxZiNYmZ3q10gvDyJ7SpopKuh08FFObUgndCCdp/kwUPsMicnUsJUq
	 ZHaak1jOLIcbWP8B+ZJ5kdoNSu0usrnneXTiTUGN5LH4fa1x4rI4jdW/A+dYQGdHHD
	 JmjM3HLC6IMCQ==
Date: Thu, 12 Nov 2026 02:26:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
 linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: at91_adc: move to devm_* to fix NULL
 pointer deref
Message-ID: <20261112022619.5693c4f9@jic23-hlaptop>
In-Reply-To: <20261111121544.00006c23@kernel.org>
References: <20261111101345.185122-1-abdelnasserhussein11@gmail.com>
	<20261111121544.00006c23@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Wed, 11 Nov 2026 12:15:44 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Wed, 11 Nov 2026 12:13:45 +0200
> Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:
> 
> > If 'atmel,adc-use-external-triggers' is not set in the device tree,
> > at91_adc_trigger_init() leaves the external trigger slots in st->trig
> > as NULL. The error paths and remove function unconditionally called
> > iio_trigger_unregister() and iio_trigger_free() on them, causing a
> > NULL pointer dereference.
> > 
> > Instead of just checking for NULL, refactor the driver to use the
> > device-managed (devm_*) API for registration and allocation. This
> > modernizes the code, eliminates the need for manual cleanup functions
> > (at91_adc_trigger_remove, at91_adc_buffer_remove, at91_ts_unregister,
> > and at91_adc_remove), and inherently fixes the NULL pointer dereference
> > since the core handles the cleanup of properly allocated triggers.
> > 
> > As part of this simplification, the remaining trigger initialization
> > logic has been inlined into at91_adc_probe().
> > 
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
> > Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> > ---
> > v3:
> >  - Addressed review comments from Andy Shevchenko:
> >    - Removed the redundant dev_err() after devm_input_allocate_device().
> >    - Declared a local 'struct device *dev = &pdev->dev' and used it in
> >      at91_adc_probe().
> >    - Declared the loop iterator inside the for-loop.
> > 
> > v2:
> >  - Dropped the simple NULL check approach.
> >  - Refactored the driver to use devm_* API as suggested by Jonathan Cameron.
> >  - Removed manual cleanup functions and error paths entirely.
> >  - Inlined remaining trigger initialization into probe().
> > 
> >  drivers/iio/adc/at91_adc.c | 185 +++++++++++--------------------------
> >  1 file changed, 52 insertions(+), 133 deletions(-)  
> 
> I'm not sure if this is an adequate fix. I'd imagine there would be two patches,
> one that just adds the simple null check so it can be backported and this patch
> that will go upstream.
> 
> The commit that introduces the bug is 14 years old, so it doesn't make sense to
> me to backport an entire devm_* conversion.
> 
> Jonathan, Andy, what do you think?

So, we don't have to backport what we upstream. I could take that null check (which
was v1 of this) and then apply this on top I suppose to make things a little
easier. Alternative is to ask for a backport of the simpler patch with this
referenced as unsuitable for backport.

Jonathan


> 

