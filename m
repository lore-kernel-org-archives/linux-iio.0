Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967509;
	b=wBaATR2bzh4/i76dK0SomRW2B6xeO3OYqFK40H1664xXFOzoKiDgeved+rO7wPLYpoHt
	 6MGcCdluC4oGZsxa4jntalAd3ZiT6NONAtk4kw1YlfeAXhrPidXqzzhjpfbc+fAfbxZcN
	 Eh5nS7ZmETv002UxYzpcQLb4dnDH9OTqidl+vtuhUfelSVhkjEeTIfhJTlfi8wQQx9arD
	 WZ1XiJshJNMFj5G6FgNDfMkZ1Pb7m37c+wpQAlvEOJJGWgDU+nypNu98qtdrEw53v+kFW
	 9Um2CdsozsgU9lCvw6CLm819VrCmt+KC1/nzWdCuX9FFuykzx06CtFf1Dv1RnKuCXPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967509;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PzzYCm84YYwPwX0v9WKoCdiyAzVtZzHZgV9Vqt/HgyM=;
	b=e1FJO7tL8i6d4lXt7O1WsnACIcJLXUX84qzhRaczqZFaHqkhPSiC/h5z15f1JKwEi2MM
	 vLCIYHLxh4wECoFcfKaj7bm9JT6PvKDv1TYUViXoJhdo7fpqUQpX+bwQx5+apgR9we8iW
	 /tuC9keHrsg9k5DHMtwdeT2IW1kYxAT6XtreE5waperGN8preGaqYUccy20tLD90i8qD+
	 EkS+CbObI7MWGhp4mDZFxlOTT65f1ZRbtDaN88cr1r3CEKBxoIEZjZA+aWzXuN0vsm7cl
	 rd+fW7UaBxdc3IyaaQstHIP4GGY8S4+c+a2AlF6szIt32qDSKP9ZtYrb7gKnN+sOE+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fptfE6vd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21A606A31A;
	Sun, 25 Oct 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fptfE6vd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36CE1F01825;
	Sun, 25 Oct 2026 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792967509;
	bh=PzzYCm84YYwPwX0v9WKoCdiyAzVtZzHZgV9Vqt/HgyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fptfE6vd6NRkeVl4VAZY9fT/hLQHTxe5WXiBR/rfhy4anpqfBPf7HURorfVVOQjwG
	 PPskkiikZfvOp+13fciIKn379aPkwWAV9MqOrWEcnAnBg9G2Pp/sidLGBdsGtg7PI7
	 JJDcrOTfBBFMsWjIqImbAiMdr/Gg2dV/C4inU0kntIXBXTJXVXJI5i9QtEjj1vv+Og
	 KLF6eZo3VGUv2rV1F5B+ANDNtV+TvzTMnSWy4q15OC1jt2EF7cJgka+7kNXuwTZBoC
	 PGCwt33BNlwxCoLQ3yn62jv6k6X+2hhjyvFWDogIKkg2pl2z8mvwel2DOAWabusA25
	 XAy6zjPu19koA==
Date: Sun, 25 Oct 2026 22:31:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: dac: mcp4725: Update the cached DAC value only on
 success
Message-ID: <20261025223141.0cd4ac03@jic23-hlaptop>
In-Reply-To: <at5v4pw34L8Cj0vU@ashevche-desk.local>
References: <20261025141351.33554-1-pocj8ur4in@gmail.com>
	<at5v4pw34L8Cj0vU@ashevche-desk.local>
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

On Sun, 25 Oct 2026 23:08:50 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Oct 25, 2026 at 11:13:51PM +0900, Baek Kyu, Kim wrote:
> > mcp4725_write_raw() updates dac_value even if mcp4725_set_value() rejects
> > the requested value or reports an I2C transfer error. After writing 1000,
> > a rejected write of 4096 returns -EINVAL without an I2C transfer, but
> > out_voltage0_raw reports 4096. A later powerdown exit sends 00 00 instead
> > of the 03 e8 frame for the last successful value. The EEPROM store path
> > uses the same cache.
> > 
> > Return the setter error before updating dac_value. This keeps the last
> > successful software value for readback, powerdown exit and EEPROM writes.  
> 
> Does it need a Fixes tag?

Yes. Given I wanted to reduce outstanding patches, I added it an applied
to the fixes-togreg branch of iio.git

This goes all the way back to 2012 introduction of the driver.

Fixes: cf35ad61aca2 ("iio: add mcp4725 I2C DAC driver")

> 
> > Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>  
> 

