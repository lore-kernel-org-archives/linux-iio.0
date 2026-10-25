Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971434;
	b=SflCH5ki7QGTahWROOQIF6FTXuuGkk9OaZLmMY+jy8Zw7cnPPoNfX6RUaUzw06IVibFb
	 zaAvNwu7z1gBXM/XPlIIAxm7jBHsmWA2vzKUyMJGeG1bzytlOPWS9F5WjU4eXxTGdKuL3
	 oO/npL+0VXCxLpwAz7bq2CuPib6pbeen5irKpbSmSwIo/RabIxPG3nzY7gVcXtrh2fy/3
	 cO2I+e1gM/x20nvYrzCi/cV/u15GDd0yeH1Es056xBBjiV4bf5JT+jTdnB7UoWM6PEvA6
	 hGn5Xe54PBbMl7euEYvsWw4OVHk3TxQU2+IGEOiRX4Ue9dGrmGnhEmOmww3FsxmgRyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bma8jEVFJ3EBAuTvKkRvO0Vh8YQAvdn3JovJj1C7RzA=;
	b=jGzcccgN40an4H6+xO8A7BEU9r8R/rS9u8LCvzVoBNSOuAbQPjTgi5fnCLUoQ0VRTjbO
	 CQWe63Xli3epxB/9Fi1yhdMllBk1yOrPC4OtBZZuw+9nfTml0Vo8sFmjnlR/8QZvuDlmR
	 SUtqazLAJhu/dQFh25gweIityypqgK2jYTUuObfTIPtqhATgTUb8IzRHkSUrzSiqrmRi3
	 3oqFGv2UFZHz6dwLLDvsj7CenXuFARKr/ZWwFve4U6YW68CAJJ1gIfepTcuqz44qkB0Vp
	 o88GyeoKszkOv82N5w3SjqCH4cb2l3QCDNANZx6Vx+gkucE43h0WCx8UNYdApe+Gr7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAQ4aJZj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EC606A31A;
	Sun, 25 Oct 2026 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAQ4aJZj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CC71F01825;
	Sun, 25 Oct 2026 23:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971433;
	bh=bma8jEVFJ3EBAuTvKkRvO0Vh8YQAvdn3JovJj1C7RzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OAQ4aJZjwRMCgZKlvqDXgV8bnUcW+avR2ulg7w8YRf58ymzPl3VGd2TzlGGHmFwKB
	 id+POS9EArDmFwdVOkZMrzZz9PQ6xtR37uxIQbvL4+rvbU5EZCWnVC7it6nhczDbBc
	 SDn/KM0vZvSQdZg/HINUuES87Bp6vpr/z5EM/8laLEv19hdeKJ3oK4tbyMe8LL1O9A
	 sOwBMYPi0p6+FLaEv0h/jIdqIPpbCYrTaspOEK8AzOgLjpF+K1VsmnMvBzIjxFMGZg
	 SahmRsgsPNjI1gQhFMUB8+NhWr7W+ugSVhTl07CbnCfolP0DSqYJScyUlhJipz++M3
	 9jnyz798tWcoA==
Date: Sun, 25 Oct 2026 23:37:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9500: ignore event config writes that
 don't change state
Message-ID: <20261025233707.3673d808@jic23-hlaptop>
In-Reply-To: <20261024175658.130546-1-kapoorarnav43@gmail.com>
References: <20261024175658.130546-1-kapoorarnav43@gmail.com>
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

On Sat, 24 Oct 2026 23:26:53 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9500_write_event_config() adjusts the channel and close/far user
> counts on every write, even when the event is already in the requested
> state. Writing 0 to a disabled event and then 1 leaves the counts at 0,
> so the channel and its interrupts stay off while the event reads as
> enabled. As channel_users[] is shared with raw reads, those can then
> wait forever for a conversion. Writing 1 twice and then 0 has the
> opposite effect.
> 
> Return early when the state doesn't change, as
> sx_common_write_event_config() does.
> 
> Fixes: 4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Applied and marked for stable.

thanks

Jonathan
