Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991601;
	b=GX6UXunYjbpD0Obmmy9rxTdl1gDsOdEgRrRebGlwP8uq+5yGjOlepHe1bhB/ImoHCqRa
	 jYaXWT079hyydBvdt5di6pwoiuaiyMCOElc9yIlim28YHvA4qpInKtGhKiKpemybQ9OzQ
	 8kttD8A0LNDtGS72hGG7VsZI755eaM1GT3iL3HcnlWNuKhQJZSnf86n24um+fqJvexB27
	 4vVl/eHluQMWvgwhM1+rmMb4jeaceW5bprJH4oKmvEGeZvIlzDTm9RIJMIvUu7PD9D7Ec
	 hU7BY3ooLTwHFfDiEPYD3NoAvkV5jGFqxWZ9ZppPscge0M9IVHjtaCHN7qEn3X/pmeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991601;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/qDOWgOn8mFmbMn9GBQQa8f/i72Iyr5wPvGMAomQO28=;
	b=Zrsu58yULarZ4KEWhPsmxrIkedE6eProQKp/neMou5C4+kgLjAgRk1XUhzLgIdDl9X4J
	 mXecQb32/2tH0DwPWA35kDInJYMKkHNRyxus0gT3bn0bANUxuLCLhTX4tQN8rCteLZjlm
	 aXebbPu0oPc2OH4q0Ot3wZ6E9mn78RJgS2iDcKQQ86t474X6NsHCn9brBdBFnB5UXPAFP
	 gCvR5qRIVYo8//l0fr5KaNFQZ1Zwb1IGBxVZCw7770KePk2m7A+dVIra0Go3wzqoDx/5N
	 La7A19021cy44bablMS7yOf294c60WLYmmap4GpZkLYggrN6LpPr3KSOmzX4YdOuNBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0e554dH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73F606A31C;
	Wed, 18 Nov 2026 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0e554dH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794991601;
	b=MnB6SLOBSgo+4R3oGP2I1r150u6DWV2JnxYUCvBGgJnboij0+LvdPCAJtDIufEn0vOIl
	 Fv7YnaFDozGpS3x135Wku5mcKxCS+lB/RWPVtNzqzf86/0Y+xRjwlxYRGq7KuK+Y9RXro
	 H3UhASQhAKWQjmdGg3AaCKkzCFLkuhBkwsB5iBA60b3S0MVUBdGgznCdWD0uFwje9mJMt
	 D+z06s1g1fScwV8bydipB9ypAvx0pPEPny/k6ePry509B7vDKHUnEUGUP/TSpopVxyWMD
	 1H1UVkmTGwDGLrCHR6RTIF+wYE42g3WCIafhqcmsvlst/27Is41j3ikNU8Su4ff3RsA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794991601;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/qDOWgOn8mFmbMn9GBQQa8f/i72Iyr5wPvGMAomQO28=;
	b=Exg5bDANeq24AFuYgu4qM6WtI/2m/O/Nj8aW9njNMO1o5gGXgWO/cJ0/xk2oQitDIVVi
	 4Dnom+/fNP2XppRsxxXQpEEdHAL+FUOo3tExvY0vHX7e12sX15sraBt1GIKva3xRqT7xQ
	 nLuq+1EdlL4nXu0CNSIEFo3QZFJ/MTQMwWdL8FFAZ1EfErW9RqqksxjhQ4oQ4Yvey9nEu
	 ls2SxpukZ8wF5TI5IMOyDuymXj140eZHjqZuhncIiftxwkbsHvAhZV360SbnZCDniAeuU
	 fVWGkUzLe8LxJQygqca99sfTiFWnasL+VAioX+nyMR+A0rONC3juuLcBYZhF66H72IQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 0F8481F000C4;
	Wed, 18 Nov 2026 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991600;
	bh=/qDOWgOn8mFmbMn9GBQQa8f/i72Iyr5wPvGMAomQO28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S0e554dHPu21NsC390huysZw5iGFp9W3m3GBKMry0NphjlCP9zdCuFlpRslFPsdyf
	 xIEKi8J3BTbbWGGcjnsD9fjffBYY1KDjo/aP3xSDjODMI13iKL6Qp3s1Tn7SIZDI/M
	 98iEG6xJGLhROPh23zRNkE5o/Y5HzRgdgal6A3Q6Q8ToE1RiIttXxyltjYEVclySpa
	 5EnlkJNEWjuHq0H9Fu8FI1roTmh6ZQhAOQmKx7Wx0leK0/V1vc5/qXasRDzqsvoocc
	 xs+sQEaLPcpnji0G97wLj10y11vPcpBvONO/Gu2oLFL5sGDnxP3G9TBGAqqUcPsE89
	 ANGyqW4E5LzTA==
Date: Wed, 18 Nov 2026 09:46:29 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-kernel@vger.kernel.org, Martin Tuma
 <martin.tuma@digiteqautomotive.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-media@vger.kernel.org, Gustavo Silva
 <gustavograzs@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Tomislav Denis <tomislav.denis@avl.com>, Jorge
 Marques <jorge.marques@analog.com>, Petre Rodan
 <petre.rodan@subdimension.ro>, Dan Robertson <dan@dlrobertson.com>,
 Jianping Shen <Jianping.Shen@de.bosch.com>, Gwendal Grignou
 <gwendal@chromium.org>, Maxwell Doose <maxwell@maxwelld.cc>, Tomasz
 Duszynski <tduszyns@gmail.com>, Esben Haabendal <esben@geanix.com>, Narcisa
 Ana Maria Vasile <narcisaanamaria12@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Vasileios Amoiridis
 <vassilisamir@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Nishant Malpani
 <nish.malpani25@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Linus
 Walleij <linusw@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH 00/35] iio: closing default trigger handling leaks
Message-ID: <20261118094629.00007514@kernel.org>
In-Reply-To: <20261116014823.3132576-1-jic23@kernel.org>
References: <20261116014823.3132576-1-jic23@kernel.org>
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

On Mon, 16 Nov 2026 01:47:48 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Note this is compile tested only!  I definitely want a few people
> to test that I didn't break everything.
> 
> This is the first part of what I think is a long term solution to the
> currently really fragile ordering constraints around setting default
> triggers. Today these are set by iio_dev->trig = iio_trigger_get(trig).
> The reference is only released on the iio_dev.release callback and
> only if we have set the mode to include one that means there might be
> a trigger set. That mode set only occurs when a buffer is registered.
> Thus trigger release only works if we have already registered a buffer.
> 
> One solution would be to reorder so that the default trigger is always
> set after the buffer registration (we have had various recent proposed
> patches to do that for individual drivers) but that is non obvious and
> fragile.
> 
> The solution here is easier to reason about. Decouple the setting
> of the default trigger from the acquisition of a reference. Thus
> we can acquire the reference in iio_device_register() when we know
> all the conditions for it's release have been achieved.
> So that's all we do in this part 1 series.
> 
> Part 2 will address immutable triggers and those that are effectively
> immutable but predate that logic. That is those that set a one to one
> relationship between device and trigger.  That change is rather less
> mechanical than this one and 35 patches is really a bit big anyway
> even if most of them are small!
> 
> Part 3 and beyond will move to a situation where the iio_dev->trig
> will become opaque. That should stop anyone manipulating that directly.
> I have a few related cunning plans to test out before we get to that,
> not because the particular challenge is hard, but because they will
> trample on the same code.
> 

I went through the set and only have one nit (an incorrect fixes tag),
otherwise seems fine.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
