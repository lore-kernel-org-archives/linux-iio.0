Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB927876A;
	Tue,  4 Aug 2026 23:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887173; cv=none; b=c5wXi3z07XzmyznPnKKMsJ0vWdo6uJvNQgn36YTHvlNKAnnCMnt3dzgVPtip/joHeAeMor8wByM5OK6CsP+bowc1mwX4r5FIgjgJG29RJj8sPRZZGswNNyVHws2lnXCqRyc6gwCPJsr7uxvlbfgX61FlT7lyfgYXwnGi53sQ0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887173; c=relaxed/simple;
	bh=IGlxB+cjXGhotHSR5Y/gM6kxg65s3JF9L1DezP6vOtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q56yjCcKaEpSYf5w7w/Dnswu4ltdJuDg4wzE2FjoWAs3GzXO3WO2PA/r2g8L7FLR5ykfqXoRQP5nHBwLOb+bMOEzsWOoqFoPUUzQYYoWWjywhrIGU37+Lv+7IRiHQb4G/Amr6j09qmSFBlN2Yi0ecPrpZjD5TI+DdOdbr4TyMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJu3vWrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJu3vWrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE71D1F000E9;
	Tue,  4 Aug 2026 23:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887172;
	bh=tgzQT2eb0ik9glYYypPb1LzOOimeFURiv/h2vun0Vak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lJu3vWrAjtCCcNHl4C0SdtXvewyi1xf68K6cFLypaJ1W9OhalrQhlozIUsLPNDdEU
	 RJ7Cizdz2XXQDvKnQOipzOBRoxE+kOb/QCd7pYPvfSNdQu7chVUWRo8tPOkeTowTBp
	 OuLB93amB6igBhb0P3FjMD35xVTn9ghmbTMg5aR8KxEtscP4SPW8+AoBTL09+EFIDL
	 9FWpQ7q3IxhWHgYuiz12Vu3/ZwfJrHFE/cYk5cSwtb1U3l65c5YqX4wuJRS4OjIVII
	 X+PlJI0n9KB5cA+g7FuDFmwA28jv2TNS/FK25n5gnAWrGQxkfEzPdkEWWYxacsUj3Q
	 abZ4NB61G4k4A==
Date: Wed, 5 Aug 2026 00:46:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Siratul Islam" <siratul.islam@linux.dev>
Cc: "David Lechner" <dlechner@baylibre.com>, "Lukas Metz"
 <lukas.metz@gmx.net>, "Nuno =?UTF-8?B?U8Oh?=" <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <20260805004606.7a190728@jic23-huawei>
In-Reply-To: <a967c89f72bc36226dfd35ceba61dc0d2e632ddc@linux.dev>
References: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
	<20260802-dac8163-work-v3-2-3ecc7bc66d0d@gmx.net>
	<50fee508-db53-46c3-b245-22893023f370@baylibre.com>
	<a967c89f72bc36226dfd35ceba61dc0d2e632ddc@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Aug 2026 08:28:51 +0000
"Siratul Islam" <siratul.islam@linux.dev> wrote:

> August 2, 2026 at 11:19 PM, "David Lechner" <dlechner@baylibre.com> wrote:
> 
> 
> > 
> > On 8/2/26 11:07 AM, Lukas Metz wrote:  
> ...
> > >  +#define LDAC_CHANNEL_A_MASK BIT(0)
> > >  +#define LDAC_CHANNEL_B_MASK BIT(1)
> > >  +#define VREF_MASK BIT(0)
> > >  +
> > >  +#define DAC8163_INTERNAL_REF_mV 2500
> > >  +#define DAC8163_RES_12_BIT 12
> > >  +#define DAC8163_RES_14_BIT 14
> > >  +#define DAC8163_RES_16_BIT 16
> > >   
> > Macros that just map to a number that is part of the macro name
> > aren't that helpful. We can just use the number directly.
> >   
> Each of them repeats 4 times. I think typing a number that many times 
> is more error prone than having a macro.

These only go into DAC8163_CHAN() as the resolution.
Sure we might end up with 13 due to a typo, but on same
basis the channel numbers might end up as 42 rather than 2
but we don't define a macro for those.

So I agree with David; use the numbers.

Thanks,

Jonathan


> > > 
> > >  
> >  
> 
> --
> Best regards,
> Sirat
> 

