Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499711;
	b=O9w44WRN2JBJTFvyx4jXhkMdSCxaNoVXMmUbzOw+rgKiZPUoy+jybfNNceCujH81hff/
	 goVRuGWlLnTRShpCLHLWu98LQ1A2/vHUFotKN8Rp4c+uLDOK4T2DoIGwcMmdrp/P3z3m/
	 2NJxCZxe1Ob1JxHYXy1nyG3WF7xX2UQUBWfIl7Fg45IuSM0UX90BViGd+EzyMD6nAJInS
	 S+m6aeKBEQLy7bXvuPONff3swb6Xtpdt7KHPYJvXI1n8CzBwSNjsP71OKX4v9ymVpL4oK
	 t/P46KZ409q/q4wXeOXLB/6V4YcCMgT1mldTn5lJYvJBSQgFcfJaEdJuStMjcXEZVZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499711;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pg94ZvA9fm2CtwS2VRcFGv5BeKOthkyH8l1LVzhmn30=;
	b=UkhCcSpDZU9/ZVnpmZdwsV8ELoM7TRZUBlVGXJ+elg4Qgr7UbYazVrGWqCya/2J4D4zI
	 bdPPa8F6uPpEeEIDjc1aNcTCI5ePziO3b+6O5vFvXQU5zEjbE9J3JxapQLFSiTMUwkLVL
	 5yZCCqVU1dmcJEWcdwrFjYgmk0DygCvrg+g7hRebYjV4EEkIauQSqCnYv7fJodfqqgxfF
	 N2kUx0oa/8zbQzx+topcosZz8C1mnKTgH7r5f4I5FAvS5013GLrs+kWg9FCDdXjKxgCNc
	 aPtD93F2nFSd+yoh3XgLhD4B4KrQCkTMakrQ+gG9d+s7eYs+DA367xNgRkWM79EBEWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQDtmnmR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD1606A324;
	Sun,  1 Nov 2026 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQDtmnmR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9E61F000C1;
	Sun,  1 Nov 2026 02:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499710;
	bh=pg94ZvA9fm2CtwS2VRcFGv5BeKOthkyH8l1LVzhmn30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MQDtmnmREyaf9pjGRm7Ym9Cu5uz9yWinDYxINGq5M7dZYu8EfuoWLoAi+u06j6HMp
	 IQFYd9tIs+6oBjceAADKurLr7L3oqpTbAHVpYNibzWFNfH3/WVJvLXecBRi8CYnnOY
	 RF4mDbUvVD3JXv0aupNNXcHADi4Pszqjt8tuxKg073q90n65lFUH9bnT56cEzu4Zao
	 PsbT9wQjYhMQnHoqbfbriYwjWerhb/1idV9sbyyspe++57nAMDU+NAdfLTNHGn+pOl
	 CaijoQhK/cPUPRDhh17cRaEz2uE21cBi+pSgfrVh36kOdT0E7L3WNP8yVZ/RQE9LBj
	 0AffUfBSmQ1ug==
Date: Sun, 1 Nov 2026 02:21:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josef Bacik
 <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Cosmin Tanislav
 <demonsingur@gmail.com>
Subject: Re: [PATCH 07/15] iio: addac: ad74413r: fix the values of
 set_multiple
Message-ID: <20261101022144.54e8d651@jic23-hlaptop>
In-Reply-To: <auHCeHSLVRuChXYp@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-7-0d818334f6c7@linuxfoundation.org>
	<auHCeHSLVRuChXYp@nsa>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Oct 2026 09:38:19 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Tue, Oct 27, 2026 at 05:19:11PM +0100, Greg Kroah-Hartman wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >=20
> > ad74413r_gpio_set_multiple() walks over the lines in the mask and looks=
 up
> > the new value of each with
> >=20
> > 	if (*bits & offset)
> >=20
> > offset is the number of the line, not a bit mask.  Line 0 is always dri=
ven
> > low, line 1 gets the value meant for line 0, line 2 the one meant for l=
ine
> > 1, and line 3 is driven high if either of these two is.
> >=20
> > Test the bit which belongs to the line.
> >=20
> > Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> > Cc: stable <stable@kernel.org>
> > Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Linus Walleij <linusw@kernel.org>
> > Cc: Bartosz Golaszewski <brgl@kernel.org>
> > Cc: Cosmin Tanislav <demonsingur@gmail.com>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git.

I'll send a pull request after rebasing on rc1.

Thanks

Jonathan

>=20
> >  drivers/iio/addac/ad74413r.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> > index 2e5a58e48a89..20db890d958b 100644
> > --- a/drivers/iio/addac/ad74413r.c
> > +++ b/drivers/iio/addac/ad74413r.c
> > @@ -312,7 +312,7 @@ static int ad74413r_gpio_set_multiple(struct gpio_c=
hip *chip,
> >  			return ret;
> > =20
> >  		real_mask |=3D BIT(real_offset);
> > -		if (*bits & offset)
> > +		if (test_bit(offset, bits))
> >  			real_bits |=3D BIT(real_offset);
> >  	}
> > =20
> >=20
> > --=20
> > 2.56.0
> >  =20

