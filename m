Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0EA311942;
	Thu, 26 Mar 2026 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513036; cv=none; b=dwnrz2SfAN4VVvIHsSEXdoBAqDR+fnq1OtyYHskXMHEa3S0i6vOiolVcxDlvnVIniBQwe2x6wiPhG4BaHLZSlNSpyUDOfVcMRqcNu9zkZDvONzXk9Sk8l1fdv4TLO7Co2fKdMXoaAgeTppqyrC39KhksPLYVx3WDverJW3Tk0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513036; c=relaxed/simple;
	bh=o5w9pCdQJwJqIVMSOTmmS4wYOSdHSHb2HuYN1QFD+iM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtPfYiHrA0wmO16QG/TddO1BJpLyBspOD69ZXBuIjjzpRijV4x3iWNgHbit7i8YeCxSGq67ywV0zzw+QMY5AJARiPjf4wavG9oO9aoJBm07dYZAvFnLgTBgHga4n5+MvcSipPIRbDeYhF5uVfrlGJ4B7v7F9DG41mkL/uENtk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iROPofh8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iROPofh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE0EC116C6;
	Thu, 26 Mar 2026 08:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774513035;
	bh=o5w9pCdQJwJqIVMSOTmmS4wYOSdHSHb2HuYN1QFD+iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iROPofh8FMQsZItMkKQeqjSxBOoQDko4rjzNC4WXNGgosWHZYvS0goy5tCRlc+4Np
	 NQfss1cj9XhKsN3P4btYYz3xCJdei9fskeQ6gkEo2TXRRW67Z0wNLmn83N3YDWzxjW
	 HSvXNMWsEbNlDy/lJP34ri9Qyzj3yV7Tz6Riou2aXLDfRr2Fkxhd6ICSzY7Zj2udDd
	 BqvpYDjPbwWQ0sqy4gVi/TiPgbZU5rRZvHblVpDYIkwP063XKectD7noXqoy0CPFNc
	 SteGkqLGRYTSEDHU8Hlt8ssOIt69eMUMRcO+WaC/FNB3gohnBk9LGHitDBuyCh076m
	 jHS8YXlhSK71w==
Date: Thu, 26 Mar 2026 08:17:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Jones, Carlos jr" <Carlosjr.Jones@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, "Hennerich,
 Michael" <Michael.Hennerich@analog.com>, Liam Beguin
 <liambeguin@gmail.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Tobias Sperling <tobias.sperling@softing.com>, "Marques,
 Jorge" <Jorge.Marques@analog.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: Re: [PATCH v2 0/4] Add support for LTC2305
Message-ID: <20260326081708.05b50999@jic23-huawei>
In-Reply-To: <SJ0PR03MB5854559AD0D2624A6251ED6FF456A@SJ0PR03MB5854.namprd03.prod.outlook.com>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
	<20260325201931.26ca84c1@jic23-huawei>
	<SJ0PR03MB5854559AD0D2624A6251ED6FF456A@SJ0PR03MB5854.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 02:21:28 +0000
"Jones, Carlos jr" <Carlosjr.Jones@analog.com> wrote:

> > On Tue, 24 Mar 2026 15:13:27 +0800
> > Carlos Jones Jr <carlosjr.jones@analog.com> wrote:
> >   
> > > The LTC2305 is a 2-channel, 12-bit, fast ADC with an I2C interface,
> > > compatible with the LTC2309 (which has 8 channels).
> > >
> > > This patch adds support for the LTC2305 by introducing a chip_info
> > > structure to handle the different channel configurations between the
> > > two variants. The LTC2305 exposes 2 single-ended channels and 2
> > > differential combinations.
> > >
> > > Also updates the device tree bindings to include the lltc,ltc2305
> > > compatible string and documents it in the Kconfig.
> > > ---  
> > 
> > Whilst checking for what comments were in v1, I realized we have two
> > different people looking at the same thing within a few weeks of each other.
> > +cc Kyle.
> > 
> > https://urldefense.com/v3/__https://lore.kernel.org/all/20260325-
> > add_ltc2305_driver-v5-0-
> > e0d29daa54f9@gmail.com/*r__;Iw!!A3Ni8CS0y2Y!6jxk_dJQLHUO4PVi3Oca_
> > VzVHN-qeFu-y2tE5xXMwuy-
> > x2UFG5Fn3KO4Cw15QcDsqTCgFXQQLLRQrdgokg$
> > 
> > I guess this is just a case of neither noticing on the list?
> > Too many similar part names, so I missed it until now.
> > 
> > Currently I have Kyle's patches queued up.  All else being equal that seems fair
> > as Kyle started on this last year whereas Carlos' work on this is much more
> > recent.
> > 
> > I'm seeing some small differences. Please could you work together on this.
> > Ideally send any additional changes on top of Kyle's series.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> First off, my apologies to everyone for not knowing how to check for
> existing upstream request for the LTC2305 device before working on it
> and wasting everyone's review time. It's a learning experience for me.
It is pretty rare!  Only tend to see this sort of collision once every
few years.

> 
> But it's still awesome to see how both ended up with almost the same
> code after review.
> 
> I'll reply to Kyle's series to ask if the delay for LTC2305 could be included.
Excellent!  Note I've merged Kyle's code, so patches on top please.
Potentially the delay might be a fix if I understand it correctly.

Thanks,

Jonathan

> 
> Kind regards,
> Carlos
> 

