Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD533F38A;
	Sat, 28 Feb 2026 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301139; cv=none; b=hx0zNVYserEa2wRqpxRlZWP65kT408M5MA5ZznA2SlrijVUvIKXP/JHxWVHhI7O6KgKtTypVEPuonCNMDcA2lA5H+Oq5cEfNTPanLWUeHe2PNFBizvKtr1J0SqNQ5/s1eLsgsBv953MHxI/VX0WKCfq8rHvuGeOqLowTcYvEMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301139; c=relaxed/simple;
	bh=3YiMsqZH0IYRRTdNMS7i3lLlsP+3iUaq6+HmJg+bBQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpW6T7rrDNY5ep/HPsS3jCIMJq5AYUJOLx/jvZPGvUFqB63so80VJaIv8Dn+Ls0vTjw7jFMzvXCDUMYI0G7VR0Im8/3SXcwIa45CIUDHkOmJnqrq5hm/Q0NBV0nIR/MjxDDd36amM00T9LqKe4NdGKe8AgHYExOpJ8eb3vCRpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pakou9M5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pakou9M5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BF0C19424;
	Sat, 28 Feb 2026 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301138;
	bh=3YiMsqZH0IYRRTdNMS7i3lLlsP+3iUaq6+HmJg+bBQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pakou9M5//aRCSz8iLjlttXz0M2U1oytpgblcvPZoKCiyt18ndpU5VVzl0cg7TgKf
	 0Hl4PXYchVGRuInPuU2h2OS8S+4PQw/6c/yfaqrA/WFSwmRcspJTS9HRoX48UeyGRb
	 O6+/WBLvZnZ52mCEEl2oAdiyyjPX/OZIl3BAsBprOt37cEskjiU2YmtTtsHvQ76faa
	 bm2HkpnUenB2mEDXN/755qOhi/D7G+4Ak4mYqsau42/WxfF26AzwQUVt42A/L+gCZ4
	 JL3i+r87vvH9snq6S1m0lgFhdEIAsi/NEkcYcQkHzcsSQ7EnKvF2+cqhftIm+xvYtZ
	 /1Z00g1fTNFag==
Date: Sat, 28 Feb 2026 17:52:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Francesco Lavra <flavra@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: ABI: Add custom data type
Message-ID: <20260228175210.114cf455@jic23-huawei>
In-Reply-To: <aaBtgQsU0MP8WV_q@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
	<20260225101806.2368391-1-flavra@baylibre.com>
	<aZ7gdO58NV6gjgWC@smile.fi.intel.com>
	<eeb28077-0886-42b4-b468-21f5c6a6444a@baylibre.com>
	<aaAQtJ5WTDtkxi08@smile.fi.intel.com>
	<f637d8075569613f97fbe7ff6219e6adde53646d.camel@baylibre.com>
	<aaBtgQsU0MP8WV_q@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 17:57:53 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Feb 26, 2026 at 04:30:27PM +0100, Francesco Lavra wrote:
> > On Thu, 2026-02-26 at 11:21 +0200, Andy Shevchenko wrote:  
> > > On Wed, Feb 25, 2026 at 03:27:55PM -0600, David Lechner wrote:  
> 
> ...
> 
> > > Not sure about the latter, but something explicit like
> > > IIO_MOD_PARTIAL_QUATERNION sounds good to me.  
> > 
> > Another option could be having a custom iio_modifier instead of a custom
> > iio_chan_type. I think this would address the concern of drivers being just
> > a proxy between hardware and userspace. A custom modifier would be used
> > when the data representation for a given channel is too exotic to warrant a
> > generic iio_modifier enum value (but would still need to be documented so
> > that userspace can make use of it).
> > I can imagine a generic userspace application that interfaces with (in this
> > case) rotation sensors (i.e. looks for IIO_ROT channels) and can support
> > not only "standard" rotation data types (yaw, pitch, roll, quaternion, etc)
> > but also "manufacturer-specific" types.  
> 
> And I am against this. It will provoke a vendor to escape the standards,
> common libraries and other tools. If we need something which is too exotic,
> the driver should convert it to the standard one. This way we will support
> HW and won't require or allow some dirty tricks based on vendor-locked
> approaches.
> 
> I'm talking from the experience on what vendors are doing or want to do
> IRL in other areas. One of the infamous example, is Broadcom Bluetooth
> used back in Nokia phones, the so called "driver" is useless completely
> in the kernel as it's just a proxy for the HW <--> userspace link.
> 
> TL;DR: I'm in favour for anything that does not touch user space at all,
> or has explicit meanings. NAK for CUSTOM, manufactirer-specific, et cetera
> from me is warranted.

The representation here is to my mind 'odd' enough that I'm be surprised
if another manufacturer ever used it.  Maybe I'm wrong though, I'm out of
touch with IMUs these days and defacto standards do arise sometimes.
I'm not sure we can paper over it in the kernel without going to
floating point maths and I don't want to start a precedence for doing that.
If anyone can figure out an efficient integer solution, then that would be great.

I'm not against a specific modifier, but that space is only so big so I don't
want to end up running out of space.  Maybe this is a case for a low impact
experiment: We add a specific modifier for this format - with full documentation
(and userspace code in the tools that come with the kernel) and see if that
opens the flood gates to requests for other custom channels.

It's worth noting I was relaxed on this once before for pulse oximeters
(the things under drivers/iio/health) because for various odd historical
reasons I happened to know a bit about the maths needed to get data from those
and there was a plausible channel type for the channels (as they were always
light sensing, be it against a light source that was varying). That one didn't
lead to a deluge but then it was more a case of allowing a minor abuse of
the ABI than adding an official custom path.

Also worth noting this sensor provides all of the real channels in normal
ABI compliant fashion, it's just this odd derived channel that is tripping
us up.

Jonathan


> 
> > We could even think about allowing more than one custom modifier (e.g.
> > everything >= IIO_MOD_CUSTOM is a custom modifier) so that a sensor can
> > have its "manufacturer-specific" data in multiple separate channels; and of
> > course each such custom modifier would have to be described in a per-driver
> > doc.  
> 

