Return-Path: <khali@linux-fr.org>
Date: Sat, 30 Nov 2013 14:04:02 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Denis CIOCCA
 <denis.ciocca@st.com>, Shawn Guo <shawn.guo@linaro.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alexandre
 Belloni <alexandre.belloni@free-electrons.com>, Brian Lilly
 <brian@crystalfontz.com>, Brent-Crosby <brent@crystalfontz.com>, Jim Wall
 <jimwall@q.com>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
Message-ID: <20131130140402.21abae28@endymion.delvare>
In-Reply-To: <5299D3BA.8080700@kernel.org>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
	<528DF164.8060009@st.com>
	<20131121131402.GF1029@lukather>
	<52926901.9080004@kernel.org>
	<20131125094044.GE3176@lukather>
	<5299D3BA.8080700@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sat, 30 Nov 2013 12:02:02 +0000, Jonathan Cameron wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/25/13 09:40, Maxime Ripard wrote:
> > Hi Jonathan,
> > 
> > On Sun, Nov 24, 2013 at 09:00:49PM +0000, Jonathan Cameron wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> On 11/21/13 13:14, Maxime Ripard wrote:
> >>> Hi Denis,
> >>> 
> >>> On Thu, Nov 21, 2013 at 12:41:24PM +0100, Denis CIOCCA wrote:
> >>>> only one point: it's possible to use the same names with DT? (using _ instead of -)
> >>> 
> >>> Yes, it is, but only for i2c as far as I'm aware, and usually the DT compatibles are with - as a separator (I
> >>> looked into the ePAPR, but couldn't get any explanations or requirements on this, even though it's used in all
> >>> of their examples)
> >> 
> >> In other discussions, where the defacto i2c device tree bindings have been followed, the conclusion has been that
> >> to change to a - from _ would result in userspace ABI changes, so whilst no one wants _ the discussion has
> >> concluded we can't really avoid it.
> > 
> > What kind of userspace ABI changes are we talking about?
> IIRC:
> 
> i2c has a generic binding that matches to the name bit of the i2c_device_id
> array.  That is then exported in sysfs.  There are quite a lot of instances
> of underscores out there in these names.  Thus unforutnately they can't
> be changed without possibly breaking userspace.  Typically those same names
> are also output by IIO though obviously we could keep that the same whilst
> changing the dt binding.
> 
> Also the i2c binding allows binding after dropping the vendor prefix which
> is even more 'interesting'. See of_modialias_node in drivers/of/base.c
> 
> I'd therefore argue in favour of just leaving the underscores in existing
> drivers as a nasty bit of legacy and doing our best to not introduce any
> new ones!

I don't know what is the problem with underscores, but please note that
hwmon i2c devices are NOT allowed to have dashes in their name because
that would break libsensors.

-- 
Jean Delvare
