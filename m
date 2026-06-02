Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19879463;
	Tue,  2 Jun 2026 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409171; cv=none; b=ayiBzIS6ruLIsXozBIclYeYnMgX9wLdarnqo3QduLH2lNnHZX0JWCpxC2cOebhh9/NtyewKf7qwyvBaOSiKB1ilblX0cUS2pIbSGuILQmhtaBkuqRs0rk9VzDp6qGe7VdoSp+ZZ1xamn8isNOhAyIO9ZOIhC+nkLjZKXNbKpI8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409171; c=relaxed/simple;
	bh=jjkON13fuXPua8qhknMzbj0t+F8+cBDpmMJLaAHfpt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYVKoEEvtIdGCxCUMHBtD/TYVKs6DwMrqo+dI5sniwCHk8XmbYbHJIQFiX5mAx2wDQ9WDQYBfQssy6Ohsoe9MdlBW0//799nXKQotd1+cAm4H3C1//89mxjYG+ZbaZiqgLkAhm4DGGjDE0LfiapPKQTHip24R6f6OFlYU/54/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdv/8kjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdv/8kjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481F71F00893;
	Tue,  2 Jun 2026 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780409170;
	bh=jjkON13fuXPua8qhknMzbj0t+F8+cBDpmMJLaAHfpt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bdv/8kjZHcHOa++NveCq8QUeOX+VUa6c3IH4/LJsrMwwnlqduTsXJI8EK6vpGiYfD
	 TSPo8ZO2NAK5ZlGElKZQwlK8MmFpnnlVaN2KSFMt/7bouHU6+DiaEXncnPWfMsS2pz
	 ZzVkSUWlOej5wsF6moEGkgFnVVYYiSOMqLS4YBLc0T+MfWK9VRDZx54FuOeoEh//hi
	 KOK1sZfp+dyWqx777OOjJ4xP1SUZHzAMwax7WZbCDiFPsTkx0ADGEWnZ3Y1NXcyc6i
	 VdY23ykWAGnocLGnSr9sTTke5xSWg72cVRUtiothsWt09Imqp2VRMVZ9Auop8Dy1fj
	 pd/sOvb5Qy0Cw==
Date: Tue, 2 Jun 2026 15:06:04 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 10/11] video: backlight: lm3533_bl: Implement
 backlight_scale property
Message-ID: <ah7jTGHj6c6aJ1RO@aspen.lan>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-11-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-11-clamor95@gmail.com>

On Mon, Jun 01, 2026 at 06:18:30PM +0300, Svyatoslav Ryhel wrote:
> Since the device supports linear and non-linear modes, implement the
> backlight_scale property to describe this state.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Thanks!

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
