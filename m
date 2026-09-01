Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A139CCF6;
	Tue,  1 Sep 2026 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226158; cv=none; b=LiIIQ3Vdwn2fzYh2TKowSR1yxZ4wBvFmX4VnzpjXv+Gk1etaAvLbYkobbS4V68DwDHT6jK+ZJGcvCO0ViaDVjpMj7GfZ/LmR1Bg3EScMV+jkFHjq2eHUqffR6fyQpAf241juTMQhUDlbyByeG2xWbUvgWExnJHCd4qES+msZRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226158; c=relaxed/simple;
	bh=3smUd3a0APatI9BUSz1ytbePNmt8B9juutuqa+zF3Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSzzKhMkK7MRAHbiC8+yxtbaZWoPBDKBYsAMZXQPoJGx+uHFP6kdZYQL0omi7AdkJtkalE56mhzu2VBCsYzBRLYrWB2de9atoS92DU6tWFYzZSeki5N/geyMD7jVNUGnKe172m/p0dRejkHlEHzP74oS14CZjNqxbdrba6Pq2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfs1LPZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfs1LPZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2B11F000E9;
	Tue,  1 Sep 2026 01:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788226155;
	bh=Q1rcKWwnLsEj07FeAyupuKPSQi7/cyfKCIUX/4F0A0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kfs1LPZSsxI3f8JeNtrBDZPLWD0ikfmxC9rLK4NAzGnF4Z6O0jY2tPwssqcfe+UGT
	 BbRKj4nCEyGfUAtxq4dcCskbVGcaLZNY5WexTNFG8pD7Pd+Y6VR7Ci3CyVt3fngJq1
	 GgifPq/5z2iAOwNADTvCm8IUZMZPLHerattG97V/eAl/KUscu/XP7OwJ6uoxUFDKZm
	 J7wwMqaQkXBShWaPoiCvumbGhzN4NM8/xM/PxhaRo7h9eu4pMfi5THxLrixQywoyCG
	 CDRlwpr6Lf8kogvBXAX1tVkTiphxgah/6vfaTaSR411l1p5bPEOmVPVJ6jHshqh2Xq
	 +1RkqjgK4JBpQ==
Date: Tue, 1 Sep 2026 02:29:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kyle Hsieh <kylehsieh1995@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Message-ID: <20260901022910.118b80ad@jic23-huawei>
In-Reply-To: <268eb714-2849-4ebb-9f9d-9607fcce3358@baylibre.com>
References: <20260824-ti-ads112c04-driver-v7-0-6b3c9c87d0e4@gmail.com>
	<20260824-ti-ads112c04-driver-v7-2-6b3c9c87d0e4@gmail.com>
	<268eb714-2849-4ebb-9f9d-9607fcce3358@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 11:28:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/24/26 3:49 AM, Kyle Hsieh wrote:
> > Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> > delta-sigma ADCs.
> > 
> > The driver implements:
> > - Single-shot conversions using the IIO raw read interface.
> > - Dynamic parsing of single-ended and differential channels from
> >   device tree child nodes.
> > - Hardware interrupt support via the DRDY pin, falling back to
> >   software polling if no IRQ is provided.
> > - Per-channel reference source selection (internal 2.048V, external
> >   REFP/REFN, or AVDD) via the reference-sources device tree property.
> >   refn-supply is not yet supported.
> > - Hardware reset via the reset controller framework, falling back to
> >   the RESET command when no reset controller is present.
> > 
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
Added, thanks.

J
