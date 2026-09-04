Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8A35C6B7;
	Fri,  4 Sep 2026 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492141; cv=none; b=DjKaMyuPJCGqjGeLLmekbAu19XhFWZO6pTdDiFeEhlaZpKeKn742H7vnIXOwnrN3kemOhQVmm5iSEcum5UUkQG6yZX4m8PhsFAFl8qv6Hx/1tye8KxGzdnHbN8EgIqsYwcVKWBijiKUs057gEL8HqWb3ukP4AC+2z+etfQPVWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492141; c=relaxed/simple;
	bh=hflFMy0m+NrbRs+d0IOTC491PlYNN3w+6B+45RmK+4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjyaaF0e5Yxo8P/hKJeJNwCCImgsOzO25/3alnNJodToo1dirEARXO7AhQ84Dz03qGYjmNItym7ljdFVlqJZNgww2enidytGvLP4eK8VEIUImopqeQoSzgBxWPJYDkueAtRKUwCRBcfxXdRxC+ZJjtnhzXQRCiEs5EUCwfIVYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap5vLwxT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap5vLwxT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FB41F00A3D;
	Fri,  4 Sep 2026 03:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788492140;
	bh=kGPh25OHgaIHIG20SM6/WxXLbE9R2XBwIwJT6RI/ATk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ap5vLwxTxfBU9RJlju9XJg7jcEJWFL8/3qMPyJ7crfZjRvyHSQXVcf7DaqV0jrX2a
	 AlV8Bz+OnsMZG9CyBwOkqyfYcqLiDS2ZZOdJDHqUfhOZ4/H7ilplFdl6EJoT2069Lo
	 uX1CPLG/1Xz7VVJSJEcjhn2vDuNubVWF6FyDKZGudjCegBOAX+hafzA8K7IDBLXGns
	 UZ3RDaYJY8guuoW3muYBXOzMQ5RgzfIANcyaAi+4ZDgzEzpTQH7R08ZDkCAwga04Rn
	 KwV5J1Md38Ffvoe9cuzl0AwsG7XoT7A5vfQHnpeJO2oxnpM4Y65hRsSK/MCFQm8uH/
	 5ytKErki0vtBw==
Date: Fri, 4 Sep 2026 04:22:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Akshat Chandra <notmissinge@gmail.com>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: add SGP41 driver
Message-ID: <20260904042215.0e21cf29@jic23-huawei>
In-Reply-To: <20260831232157.27037a5e@systembl0wer>
References: <20260831151235.64076-1-notmissinge@gmail.com>
	<20260831232157.27037a5e@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 23:21:57 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 31 Aug 2026 20:42:35 +0530
> Akshat Chandra <notmissinge@gmail.com> wrote:
> 
> > Signed-off-by: Akshat Chandra <notmissinge@gmail.com>
> > ---
> >  .../devicetree/bindings/trivial-devices.yaml  |   2 +
> >  drivers/iio/chemical/Kconfig                  |  11 +
> >  drivers/iio/chemical/Makefile                 |   1 +
> >  drivers/iio/chemical/sgp41.c                  | 384 ++++++++++++++++++
> >  4 files changed, 398 insertions(+)
> >  create mode 100644 drivers/iio/chemical/sgp41.c
> >   
> 
> Not only you're missing a commit message, you're also missing a
> MAINTAINERS entry and a dt-bindings entry! Please fix this!
> (Note, the dt-bindings and MAINTAINERS entry should go together
> in one patch, preferrably first in the series).
> 

Whilst it should be a separate patch, the route here to use
trivial-devices might make sense.  Only thing that might be
worth documenting would be vdd-supply.

I'm would be looking for description in the cover letter of how this
is different from, and not suited to extension of another drive
such as the sgp40 (obviously there are more channels on one than
the other so it isn't trivial!)

Jonathan
