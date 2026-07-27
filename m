Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CED1A6822;
	Mon, 27 Jul 2026 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785113550; cv=none; b=qsKn/709sShCLaGw/OJi+3OcLsVNHKM6lh7p5NYXLATSoL+SVsNYhJF48TdV90ojRwZehVji7+hffo7Wqi405u0M8zNGYtcR0CY3mIcIB4xDnmGk358jw9BT85wU/xcYrkB+B17zypNkdzUdX83apZDVxPjm0LYBgPEsDJ43YEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785113550; c=relaxed/simple;
	bh=A51KEZuvb3X0JeoHjI1ToaXcWR4tDaIsa4K3tghPvnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn4dsvLzPu3wSgE4hpXENjWJqicgsb2fSf/uUx+Ge7SpylEkxbU/Wfvs26tJewbmw8nQu5JI6akBNYaB+OypdEJROu0ksVhVCk4f8ykDVS8X8nqliPm6+p0lY+oMTDX13d6mo1OSCcYy6u624eiW3LLNzT7enaJTWlDSxLydnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APGD99wi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APGD99wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F386F1F000E9;
	Mon, 27 Jul 2026 00:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785113548;
	bh=m8Fgs7nD3L3OEGwH+pO1pq4WPtbVz8J49EoQInWXpII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=APGD99wi4NR67bnMGn0TRg58B50xvd0lt2/ESAeNJt9KkHLlOOdm2ixRimNoN2UE8
	 M1vs0EO8qymmrn33r65AqGmVhdcJywGsFiSaK37WppvH96IL6KJL/HOZu4yxY/vdfJ
	 N/L/AtyjGuz/FJiXK/YFx5LVethMw5ZG7QLvPyg5cL0gXYettSpifrdIY6v+su8SZx
	 jxw08Cezbab62kjmJH6J7TuPPF/Dl7rbMmJmunFNzgDqk9D8GGTAw96jKKvFhC81XL
	 VEdb09rQQwQAyMfP5ixsc8bMioa2nlF9DXxw6TOpjXmymyv2yzR6uOoesAG3x3oRSG
	 aqcqo5LykSOxw==
Date: Mon, 27 Jul 2026 01:52:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Lukas <lukas.metz@gmx.net>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <20260727015225.53e116c8@jic23-huawei>
In-Reply-To: <1E57F5BA-1864-4644-932D-3612AE7B1AB5@linux.dev>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
	<20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
	<e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
	<amYVZtbxu4fjhBkx@berta-MS-7693>
	<6b3f1b6188afbb8ebf9576274894b5ed292eca92@linux.dev>
	<20260726191833.67dcfac2@jic23-huawei>
	<amZV_2_dsNZmp7Bb@berta-MS-7693>
	<1E57F5BA-1864-4644-932D-3612AE7B1AB5@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 00:52:23 +0600
Siratul Islam <siratul.islam@linux.dev> wrote:

> On July 27, 2026 12:46:23 AM GMT+06:00, Lukas <lukas.metz@gmx.net> wrote:
> >On Sun, Jul 26, 2026 at 07:18:33PM +0100, Jonathan Cameron wrote:  
> >> 
> >> As this has come up, I'd favour just having two static const regmap_config structures
> >> and picking between them.  Obviously I haven't checked but I'd guess that any
> >> overhead of extra text data for those is not that different to the extra code of the current
> >> approach.  Generally if you can make this sort of thing data rather than code it
> >> is a net gain.
> >> 
> >> Jonathan  
> >
> >I actually misspoke before. Since all dacxxx3 devices have different
> >default values (mid-scale varies for different resolutions), 4
> >different reg_defaults are needed to cover all the devices. I could
> >define 4 static const regmap_configs and pick between them or go with
> >Siratul Islams approach.
> >
> >Best regards
> >
> >Lukas  
> 
> If you need 4 of them then it's a bit too much I think. I don't know if it would be acceptable duplication at that point.

It's still not massive. They are sub 400 bytes each.  At this level I'll leave
decision to the author on what is reasonable.

If it were me I'd still go for picking between static const structure instances
when there are 4. Gets more dubious when there are 20+!

Jonathan


> 
> --
> Best regards,
> Sirat
> 
> 

