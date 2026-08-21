Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462539E190;
	Fri, 21 Aug 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356771; cv=none; b=UQ/9iRcBYIdqVVIYDMGPlp7L9UKxMiMnvl/a+CG29Py4Rj5E48kobwzqMAoX11Csv+jYKzE3vYfxH4cdwcnqf1yNV1rpktcjznwIHrhzJnaKbAc+PR4OIvQ761HQ0NDzwcHUgUtvp8nU06xUenP16sTCnWcT7MHyG9gA8u1BOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356771; c=relaxed/simple;
	bh=ZLIhpNwaE9VJe3cx+uBL3ElSPn/fSTujLQoytD4yVk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bv1j8cJVEuBVF7uhH9sDJhyHJyWYY8/4wc+TgQKrfzSLnuaPxKsrz9tEY7LuEiOuB5dLXy07p31JzaTUm6/O233Q2E33XS5vNyJZIxW7TP2U/Zj5d0eDKq+Aazp7cdR0RzohAwKKrp/TtiIfxzenPbqlHevAKiRho5GfQnIoPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeNel8XA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeNel8XA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4621F000E9;
	Fri, 21 Aug 2026 23:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787356770;
	bh=iORrnZVAwfQWYIDC8TKD5jwmJEL/3amzP6KOEUXRfMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HeNel8XApOdIWPkLrfKlGergfnnw876dIx7SvL5eiDi1viR5s6IREJR7BtLCGs/wA
	 Pz5P1nSha8HgBFDn8fccEeJqgeWNApYDGtCdnpTzzkEjw9oBXMLSyALwLVlVH0gDok
	 80i6nfGOORXuDCJbJ7x6lc2WRV8980NVuUcjOtAhFl6VIeOLHtMdoX5CiINh9pCFNL
	 5FzwrEDbGME5dGn4kds1oykgLGiSeTySlCyz+x5GvCbYIPplgOgslmq0eDu0UZyf7k
	 WIyFdH4vx0GEgc6z1xPJUiBLCXJK4DHdorxbQkBZhyFxSHZcky8E+RD00WqifKDd8g
	 HM8TReo6A7Iag==
Date: Sat, 22 Aug 2026 00:59:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Tanoh <olivier.tanoh19@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Guidance for a first IIO sensor driver contribution
Message-ID: <20260822005927.55846ad4@jic23-huawei>
In-Reply-To: <CAM49wQtRt5JWDWZtu4Kc-Lk9miv-Uc0nYocd7JFiTVycXQExkw@mail.gmail.com>
References: <CAM49wQtRt5JWDWZtu4Kc-Lk9miv-Uc0nYocd7JFiTVycXQExkw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 16:14:05 +0200
Olivier Tanoh <olivier.tanoh19@gmail.com> wrote:

> Hi all,

Hi Olivier,

Would have been better to reply to you earlier thread with the additional
context of the replies to that available to anyone seeing this message.

> 
> I'm an embedded Linux engineer looking to contribute my first sensor
> driver to IIO. I'm familiar with the submission process (I've had
> patches merged to staging), and I've studied the structure of existing
> IIO drivers, si7005.c in particular, so I'm comfortable with probe,
> channel definitions and read_raw.
> 
> I have I2C hardware for testing (Raspberry Pi CM4), so I can buy a
> part and validate on real hardware.
> 
> My difficulty is picking a target. Most of the simple
> temperature/humidity sensors I looked at (SHT3x, AHT20, ...) already
> have hwmon drivers, and the recent parts I found in vendor catalogs
> (e.g. MAX30210) are already being submitted upstream.
> 
No particular suggestions from me.

> Two questions:
> 
> Are there sensors the IIO community would like to see supported that
> currently have no driver?
> For a sensor that already has an hwmon driver, is an IIO driver
> considered worthwhile (for buffer/trigger support), or is that
> generally seen as redundant?

Very very rarely does it make sense to move a driver between subsystems
and it is painful to do.

Jonathan

> 
> I'd rather pick something useful than duplicate existing work. Any
> guidance would be appreciated.
> 
> Thanks,
> Olivier Tanoh
> 

