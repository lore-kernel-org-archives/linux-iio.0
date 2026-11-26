Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656815;
	b=ttq9uesRCEU+Yj/WrPSTzmMUXAw5WoX7xRfpl7Mr7o+25P/Ca7E/QWmC6tYb1Xa5Wxr/
	 aBHaJksPb3+GZuZAgppVv4P3vs53gXuziANIXUtvQgYyF8d0zd80zav0FmPXnsEdtKtmG
	 4QS8KZREfSB4vxfx8d3vhyTCxkvPp5fZMX8ImURs3r6LnW1GUlIWrld3huxUBKJGt/jjB
	 caLQ9/ujWGBuqM//vwxOE+rlGAO03nHwP6n3FOLuyykN5EAzQcl21X+raY3GzsrOkzdA9
	 kqI92tV72UJYuBOl2PCl3r3UNJf4UGU785rQ4+ZjqUnIpWLkr3oJ2vYzn5UZy/kDzdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656815;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QCO6efh7OQFG60Z5z9nuLXfn+huQqjnIYxJcKIW/9C8=;
	b=Zhaas14K45sxEHd0In9SXSqM7XyJbOPCEdN8pNXuqOu8oTGuH4C8jZOc9OE/FCCTY3eG
	 GMQ7TipuqVzmfOaCx1+8VBFa3j1ecF++M07NeKEZYMFid5ixd7Zp6C7l5flTVLZThaERi
	 vANuNYGRGFRRqjtrV1L3OuhN8LXXHXCjmyGtxTNxfsN261TMIT3nO1YXtIK9t3bClqlre
	 CzXZ0W5cV8cl7rhU0TmiwWt6XQy/D3YNxxmItwaA+sXjhFO5i8koY+cr5afHeti6wFkN7
	 p1Ztpc1ocaeTHvvO6c2ASYwUQldEFbJHZ6fTnV2e7dlnhk+Pw4RrE+z60RdBkMT1q0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6hDOA6d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97121606A321;
	Thu, 26 Nov 2026 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6hDOA6d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2691F000C0;
	Thu, 26 Nov 2026 01:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656815;
	bh=QCO6efh7OQFG60Z5z9nuLXfn+huQqjnIYxJcKIW/9C8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y6hDOA6dOfj5FE1vH3cKp/dN25l3xj/0XrRWm/psK/hJO16DjvLuFqzzLHzcmPRoA
	 sHMoMmJEpRj3AwK+S111UNLDbsR5kw1LcyBnYmxzTnkqeSAVf+aFjyCVffMztOuq1h
	 M96G7Iqf8CKZj5uMlSyMRiF9o7+jTRyKYXTI4vUs3ayYKTghpmgGrOzhgevz3hekfK
	 h/R9tRXU8GMQQ6VSN0MzCLR+zkNarGFyi5w7hTNOzmiuHPS1r3jV7449IgNGacihW5
	 Y6DM9cKsRjvw9NeX/WVLUJ5WufzmeF0CbpPOYWpNC3GweqIsIenXWhhOOdWRL/dLAQ
	 TLpu2F31uYkVw==
Date: Thu, 26 Nov 2026 01:33:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nishant Malpani <nish.malpani25@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] iio: gyro: header cleanups
Message-ID: <20261126013331.0e6bb05e@jic23-hlaptop>
In-Reply-To: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
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

On Wed, 25 Nov 2026 20:24:01 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> Remove any kernel.h occurences in gyro/ and update the headers in
> accordance with IWYU (at least loosely).
> 
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
I suspect we won't get much additional review on this lot
and seeing as Andy already took a look, I'll pick them up now.

Applied to the testing branch of iio.git

thanks,

Jonathan

> ---
> Joshua Crofts (9):
>       iio: gyro: adis16080: reorder headers
>       iio: gyro: adis16080: apply iwyu principle
>       iio: gyro: adis16136: apply iwyu principle
>       iio: gyro: adis16130: apply iwyu principle
>       iio: gyro: adis16260: apply iwyu principle
>       iio: gyro: adxrs290: apply iwyu principle
>       iio: gyro: adxrs450: sort headers
>       iio: gyro: adxrs450: apply iwyu principle
>       iio: gyro: st_gyro: apply iwyu principle
> 
>  drivers/iio/gyro/adis16080.c      | 15 +++++++++++----
>  drivers/iio/gyro/adis16130.c      | 10 ++++++----
>  drivers/iio/gyro/adis16136.c      | 10 +++++++---
>  drivers/iio/gyro/adis16260.c      |  9 ++++++---
>  drivers/iio/gyro/adxrs290.c       |  5 ++++-
>  drivers/iio/gyro/adxrs450.c       | 17 +++++++++++------
>  drivers/iio/gyro/st_gyro_buffer.c |  1 -
>  drivers/iio/gyro/st_gyro_core.c   |  7 +++++--
>  drivers/iio/gyro/st_gyro_i2c.c    |  6 ++++--
>  drivers/iio/gyro/st_gyro_spi.c    |  4 +++-
>  10 files changed, 57 insertions(+), 27 deletions(-)
> ---
> base-commit: 903941a9b06ae445c70646ab061b604c2dea17d3
> change-id: 20261120-gyro-kernel-header-removal-7e7ce8b60656
> 
> Best regards,

