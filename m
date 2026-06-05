Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEF23CFF6C;
	Fri,  5 Jun 2026 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664312; cv=none; b=t/q0HW3XrzHXBiwTC+v17Kq/43FkNo5KycwKn7PFB2yr3Lj5tcgvdFKZTbsA3v2NH/0bP0ivjW/7zh23DPC6l4hzOXGQw9d5wZyXF5LPpE2Bdw7SravXYpC47vnSEZTZ2OUBQUQvEjIJ8OnF8jhLJX+lkjrmpe11IGs8WZDLLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664312; c=relaxed/simple;
	bh=0mvZ5ccmnn+t3r/7oZliRmzmi26H9mrqYxoK0sBB3ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fg1JqCHOVgxo5oVWFq3bcB0K2x2Ye5zL+wGAoVL/4M3lj/NeUaclBqF3/l5FrBJeCjtynWoRHKzIF+TnC6/Vx4o21bdQLpFNHuxYIZW650iDe1RC5E7xZkGCYseveiGPBbmOGd8sXGiCCdSy4Oe1BMNEgznu6DcQtqhK3pd/FO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi2srNwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi2srNwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607181F00893;
	Fri,  5 Jun 2026 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780664311;
	bh=7MDDcDGHJr36FLibczVWacRk/RcBwbDXG+zlx4eFpEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oi2srNweKawqJidw78V+jMUh1xdu99jpeFL3UHOo9wr+vNqYlxzsQjK2Phn6k8WsC
	 DWsOcNGiTFmGdUqk2ebp8EApswWTOXSvGBxr8vFCivB5E5CW7dikmrRUqIm7oldc80
	 v3eZM3mdVbeRVqAfms6/V3RWzvogJT7+ZJzGxRhMardoCaU0OMtnleKD+1QkJ2X4Do
	 U4qM5ZBduP1WJyaVs3Q1baKMsMQaTv0mAwWrnEt0TQGVciqW2oK6r+JCjfjt0WhaaD
	 SjVAHuZF25WNWjus7MF4E+JO7ZYMIFELycx+RpP8GVH9cREz3NuDcA2Q+VRJgZ9jVh
	 Y/5oNW31y+0RQ==
Date: Fri, 5 Jun 2026 13:58:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v4] iio: dac: mcp47feb02: Fix passing uninitialized
 vref1_uV for no Vref1 case
Message-ID: <20260605135823.15498032@jic23-huawei>
In-Reply-To: <CAMknhBE0udo56sJMzXdqB3+r6JKtsfTy89-V+37vFqnE_GfejA@mail.gmail.com>
References: <20260604-mcp47feb02-fix4-v4-1-cd6ce03749a4@microchip.com>
	<CAMknhBE0udo56sJMzXdqB3+r6JKtsfTy89-V+37vFqnE_GfejA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2026 18:28:01 +0200
David Lechner <dlechner@baylibre.com> wrote:

> On Thu, Jun 4, 2026 at 3:47=E2=80=AFPM Ariana Lazar <ariana.lazar@microch=
ip.com> wrote:
> >
> > Ensure that if a device has Vref1 but reading the regulator returns an
> > error, mcp47feb02_init_ctrl_regs() is not called with an uninitialized
> > vref1_uV value. Also add a device_property_present() check for the Vref1
> > supply before reading the regulator.
> >
> > Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999]=
 case")
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/
> >

Fixed this up. There must not be blank lines in tag blocks!  If I miss
cleaning these up then Greg won't take the pull. So be very careful about t=
his.

> > Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> > --- =20
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
Applied to the fixes-togreg branch of iio.git.
This is a little less minimal than ideal, but it is still readable so
I've taken it without asking for it to be split into minimal fix + refactor.

Jonathan


