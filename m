Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793497540;
	b=0MkuuV6xntXKx8EdXL+Uo1ds4a/dEEI0NGuIehR6ZofzjV0a70AFg8dUSthu5Uvqy+O4
	 UicW4agGru4lQ1db6tsG59jdz34Ahdp1sfNnSYyWrKO4HOGZfYyUFQPLZYSWnjFI6rzI9
	 YtNvzhPueH1JWu+FrR21o25ZHk8oadoe2dwuNzMJ+MPvBan290OTbFEtt4AxV84X6TNpv
	 nGvUhV1mF72F+RJWEF/PFtlh/q6IO8ExKHJ/bL0IvUwdIN4pEQ2lWDHI9NFBQWJf3RLVL
	 pnSxUgbzXz19yGsRSX59kRdthfUxJZgQUMUDKwXJ5mU9i4l1fnxw64wzlSCwbFmO1gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793497540;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+Qf98bRevhqOejE1NOQza0hGGDrxYSzN++rkrz4J+mU=;
	b=2vXjh09NrI3wn1MLXJk+/skS8l/gQpFTiXYg4IYrbNMZRj5GyZkE/QlJbx8F/A6EcEJ3
	 A/My52WS8iCQSsl1DTj3CquPvQcxu/M/oKdtrgNp8nXZsgoGWeqtTunOKilIT15Cd1JcP
	 K8HpFLxW1tUdRs6/z7i9Lfw0y/+nKvczVrL5o/X7FtmdEGmY8DVmLn17V9fqtpH3U77Ar
	 INIHIvjb+1MXHV9qqInAEY4w8aBq3Za6fC5dtwWE8MVAWt0WQEVJpGGV4+x6g6BRfl6Ci
	 8pfDfF9tjR41zlLv+SWiUA8VzrHM/POC6uIZQl3G/ZMRZZN3S9LvQkql1r0sXhC547g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTPeCLOf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609A606A31D;
	Sun,  1 Nov 2026 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTPeCLOf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D811F00919;
	Sun,  1 Nov 2026 01:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793497539;
	bh=+Qf98bRevhqOejE1NOQza0hGGDrxYSzN++rkrz4J+mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lTPeCLOfcgRDs+QfVVAIS7GXloInZnFPfAAzIe+JRr3E38CrbNjsQ1q+RseAJ0KD5
	 Z7ZZOVioMBknYm34t0PrrK/J0uGriYme/qS4m+eu+tzVQ8mEmhRmzMTjXd7aB4KWyD
	 4wETXVF/xMxSekdkFfdygk+0xtE6Js8gM3A5/fTsRhsBDeOtUC2MOvFm2zOskMp2fq
	 sFm4BogaLBmY8C/kmDAVDXLLGoO9LJxJzmf1xeGXQte9Q1Swi5oW23QVkSUtKlkoht
	 FU71UrS9d2VK+JMg2TSSDCD0O7AHbIbXoE5jeQbOeA1yX4J9/RH689fqecs3+6EqKw
	 a0mobPRmtjgKg==
Date: Sun, 1 Nov 2026 01:45:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joshua
 Crofts <joshua.crofts1@gmail.com>, Shi Hao <i.shihao.999@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <20261101014537.52c76f0c@jic23-hlaptop>
In-Reply-To: <102aa257-9816-4e56-ab90-f3edc2a725c5@gmail.com>
References: <20261029074851.216029-1-marcus.yu.56@gmail.com>
	<20261029074851.216029-3-marcus.yu.56@gmail.com>
	<533bca43-8de5-4295-b226-5ea3742871de@gmail.com>
	<auN2jwQVr-GSnZvF@zephyrus-g14.localdomain>
	<102aa257-9816-4e56-ab90-f3edc2a725c5@gmail.com>
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

On Thu, 29 Oct 2026 21:59:28 +0100
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> On 10/29/26 5:38 PM, Chang Yu wrote:
> > On Thu, Oct 29, 2026 at 12:20:24PM +0100, Jose A. Perez de Azpillaga wrote:  
> >> On 10/29/26 8:48 AM, Chang Yu wrote:  
> >>> Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> >>>
> >>> The AS7343 is a 14-channel spectral sensor featuring 11 visible
> >>> channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> >>> flicker detection channel.
> >>>
> >>> The driver exposes 12 spectral channels (11 visible light and 1
> >>> near-infrared) via sysfs. Runtime PM is implemented to stop
> >>> measurements and enter SLEEP state when the device is suspended
> >>> or torn down.
> >>>
> >>> Future patches will add configurable gain and integration time,
> >>> interrupt support, buffered reads, VIS channel, and flicker
> >>> detection.
> >>>
> >>> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> >>> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> >>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >>> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>  
> >>
> >>
> >> [snip]
> >>  
> >>> +		/* Check for digital saturation. */
> >>> +		if (status & AS7343_ASTATUS_ASAT_STATUS) {
> >>> +			/*
> >>> +			 * Per the datasheet, ASTATUS is self-clearing: writing
> >>> +			 * the value back clears the entire register.
> >>> +			 */
> >>> +			ret = regmap_write(map, AS7343_ASTATUS_REG, status);  
> >>
> >>
> >> isn't that the STATUS (0x93) text? the datasheet says ASTATUS is read
> >> only and ASAT_STATUS clears on access, so the write shouldn't be needed.
> >> it also covers analog saturation, not only digital
> >>  
> > Aw man, how did I not notice that?  
> 
> easy to mix up, STATUS and ASTATUS are one letter apart :)
> 
> >   
> >>> +			return ret ? ret : -EIO;  
> >>
> >> -EIO reads like a bus error. as73211 returns -EOVERFLOW for this,
> >> wouldn't that fit better?  
> > 
> > Sounds good to me. Jonathan, if v7 goes in, can you replace this if
> > block with:
> > 
> > 		/* Check for saturation. */
> > 		if (status & AS7343_ASTATUS_ASAT_STATUS)
> > 			return -EOVERFLOW;
Diff I applied is:
diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
index a26f2cd571f9..aff0cba2239c 100644
--- a/drivers/iio/light/as7343.c
+++ b/drivers/iio/light/as7343.c
@@ -195,15 +195,9 @@ static int as7343_read_raw(struct iio_dev *indio_dev,
                if (ret)
                        return ret;
 
-               /* Check for digital saturation. */
-               if (status & AS7343_ASTATUS_ASAT_STATUS) {
-                       /*
-                        * Per the datasheet, ASTATUS is self-clearing: writing
-                        * the value back clears the entire register.
-                        */
-                       ret = regmap_write(map, AS7343_ASTATUS_REG, status);
-                       return ret ? ret : -EIO;
-               }
+               /* Check for saturation. */
+               if (status & AS7343_ASTATUS_ASAT_STATUS)
+                       return -EOVERFLOW;
 
                ret = regmap_bulk_read(map, chan->address,
                                       &result, sizeof(result));

With that applied to the testing branch of iio.git.

Shout if I misunderstood this discussion.

Thanks,

Jonathan


> > 
> > I've tested the change on hardware and everything works fine. Or do you
> > prefer me sending over a v8 instead?  
> 
> with that fixup, LGTM so:
> 
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> 

