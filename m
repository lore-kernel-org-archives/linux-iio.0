Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6B391844;
	Mon,  1 Jun 2026 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306963; cv=none; b=ZtLS9Wtt4A6i5IP+hcPk4OFNeHLCXi+tpA4TpmgPLzeGITlj6DwBFeRaYLzDHjiePi8H0Z8clYpmL9yFvx9KfBv1dZg0OwpH++wFinsaxZ4qv3KkwU+6WeNS3Ejcl9WBzyBtb9yh6feUA8MCg1rDVj/+CPeoW+V0dfKSRL1LbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306963; c=relaxed/simple;
	bh=3lySmcIQTdQ+0oxBdzdfPCFBU34nhvIeg8baee10nl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3rYIXWtdgQzxajk+m5ttxEfVvleI+kSfq6gVyyFYqViRjsrTvQjTEKwMSIdb7VsRBrvrIk29OBqKTQXIHTyRs5V8MYtNCIuxypUTleTiM6LVPVIk32cGMxf38CRvclT1nUj6YfndmQk11Cg+WinLITtnCoWypdfVHIYp9+cGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMSSiRLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMSSiRLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66A71F00893;
	Mon,  1 Jun 2026 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780306962;
	bh=AfAQTwpjF8cgBwHCLw0+ft1yhjbjjx6tHyyLmu7O/3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZMSSiRLCCilG6BiNZ3G0n7TGCZWoBg/fmTXRjNnApTs6k9VB6Oc6gOP+YAjF9Qv2m
	 yl+LsIXlkFVhzTtJ5HjQiLPQTHlhrc61tuzN5LYnIWJrwVRZz4gNLFZzOSNhjCIbJH
	 Ce4O745pfn3vF82Th4Xm6ZMrZD7RrY7ZTwNYstz/SqTWCEz7/XH2By1jLLOdJ5/gPb
	 Q0pg38PLCypkD7VeUFJuaUivetvUPuMZxp5KsTIMwyz/v5c8QboDTf1iH317nXZRMc
	 55sxR1OXAV81C0uBldUi2wEdiiaWZk8hRUHHI0BC4ovl3w//M5kcP1TVoHntBrjue+
	 HME4xfQCPZTqA==
Date: Mon, 1 Jun 2026 10:42:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Wadim Mueller <wafgo01@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: types: add IIO_VOLUMEFLOW channel type
Message-ID: <20260601104233.310ac930@jic23-huawei>
In-Reply-To: <ahx5cuM1xlOVP6DT@debian-BULLSEYE-live-builder-AMD64>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-2-wafgo01@gmail.com>
	<ahx5cuM1xlOVP6DT@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 15:09:54 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 05/30, Wadim Mueller wrote:
> > Add a new IIO channel type for liquid volumetric flow sensors.  The
> > unit exposed via the standard _scale attribute is litres per second
> > (l/s), so drivers reporting smaller native units (e.g. ml/min) only
> > need to set a fractional scale.
> > 
> > Update iio-core's name table, the iio_event_monitor whitelist and
> > the sysfs-bus-iio ABI document to match.  The new _scale attribute is
> > folded into the existing shared _scale block; only the per-type _raw
> > needs a fresh entry.
> > 
> > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
> >  drivers/iio/industrialio-core.c         |  1 +
> >  include/uapi/linux/iio/types.h          |  1 +
> >  tools/iio/iio_event_monitor.c           |  2 ++
> >  4 files changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 5f87dcee7..2188557cb 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -507,6 +507,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_scale
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_scale
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_scale
> >  KernelVersion:	2.6.35
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> > @@ -2458,3 +2460,12 @@ Description:
> >  		seconds, expressed as:
> >  
> >  		- a range specified as "[min step max]"
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflow_raw
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_volumeflowY_raw
> > +KernelVersion:	6.19  
> This is probably only landing in kernel 7.2 (or later?), so bumping the version
> seems appropriate.
> 
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Raw (unscaled) volumetric flow rate reading from the channel.
> > +		To convert to standard units (litres per second) apply the
> > +		channel's _scale (and _offset, when present).  
> Early reviews suggested to use SI units so I think we would have cubic meters
> per second. Disregard if I missed some review accepting it as liters per second.

I don't think that discussion ever finished.  Please makes sure to capture open
questions like this in your cover letter.  A comment in the individual patch / code
is also appropriate so people don't miss it.


J

> 
> With best regards,
> Marcelo

