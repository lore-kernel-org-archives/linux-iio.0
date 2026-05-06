Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49531D375;
	Wed,  6 May 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086385; cv=none; b=l+/fUjRM5MsboWk3rqHitVxKxL85iuEh0UzMi0ZAiCNkOvfpX+5bwohneSk3KAY5A00TPirk562+8mmpqVy5faAormsUg+43sFvnlv83pWBkThsi6LSi4QretJnFpT2tY23wMULysurTawQodJ2qKP4ntgnerfrdyt/K3PYdV3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086385; c=relaxed/simple;
	bh=xrLeIriknLmCPSnnbyhqzw6LCFB/+6jF6hAGe8XU9W8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6Ttad4bD85RmKqfGSGAB/A3pQX7TyqFzXXBG79gdsEWvK0L8akS5zmzanF51ZMz7BeOceB0tk2VSAEyvdGB5ZLJbHkx5zwtrCH4ie2gX4BoKrBEdKzOb9v7Tp/EUJwETCF/nrTiiw44FVPuaHcgqf7ndG3weub4z+EHLWiNT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gygfGlkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gygfGlkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F8EC2BCB0;
	Wed,  6 May 2026 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086385;
	bh=xrLeIriknLmCPSnnbyhqzw6LCFB/+6jF6hAGe8XU9W8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gygfGlkRA+2bTiB/W6AJsEOREHZ8SFTExaXY/dj3M6HzhZkPRdYKiPBURsq7kFQoB
	 pFbJun6tUKllVyErLRzE2aIHnesDWS5UJvs39PzOOWYoj7gmsYKlo4zSB61PznhSIb
	 jQHG741WXjzSMjqvk6Swxy1UOir3wTxr+EgLzR1xNBAi+uv5FCVpvze7XDaupmpj3c
	 VWdWr+Xt7Xw6kYtr8KuQm+G4gmt5GndfMnJ3uKA89HIQJNIVGay48Q45TbRVqR396z
	 IdVYXhwr3HI3+96N2gqeiGklrvl2z/NmpBBQGKi2VNe1Js3X1aLHu6qdZYjPhWDRTN
	 iSjIseFlnCzdg==
Date: Wed, 6 May 2026 17:52:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/18] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <20260506175257.3d8d9792@jic23-huawei>
In-Reply-To: <afs9RRAldVXWqVaZ@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-7-831b9b5550fc@gmail.com>
	<afrlT71SjyQLh2xz@ashevche-desk.local>
	<CALoEA-xjvxYOQ8Kt+OXR=6E_TrjUmC4J6ZXftE6hri6z+Wzhrg@mail.gmail.com>
	<CALoEA-xBcPzoy4T3+0edrnQLV++k2VN5ozWan8L+gnV5P3CLFw@mail.gmail.com>
	<afs9RRAldVXWqVaZ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 16:08:21 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, May 06, 2026 at 12:50:09PM +0200, Joshua Crofts wrote:
> > On Wed, 6 May 2026 at 09:01, Joshua Crofts <joshua.crofts1@gmail.com> wrote:  
> > > On Wed, 6 May 2026 at 08:53, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:  
> > > > On Tue, May 05, 2026 at 01:46:03PM +0200, Joshua Crofts via B4 Relay wrote:  
> 
> ...
> 
> > > > > +     ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> > > > > +                             poll_ms * USEC_PER_MSEC,
> > > > > +                             timeout_ms * USEC_PER_MSEC,
> > > > > +                             true,
> > > > > +                             client, data->def->ctrl_regs[ST1]);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +     if (val < 0) {
> > > > > +             dev_err(&client->dev, "Error in reading ST1\n");
> > > > > +             return val;
> > > > >       }
> > > > > -     if (!timeout_ms)
> > > > > -             return -ETIMEDOUT;
> > > > >
> > > > > -     return read_status;
> > > > > +     return val;  
> > > >
> > > > Besides the unneeded return val duplication, I think this is the wrong location
> > > > for this check and it changes behaviour (really subtle change!).  
> > 
> > Hmm, rechecking this, I agree with the unnecessary return, but I don't think it
> > changes the behaviour of the function.
> >   
> > > > Before if the last iteration gives an error from the device, we return
> > > > -ETIMEDOUT instead of the whatever the i2c_smbus_read_byte_data() returns.  
> > 
> > Looking at the original function, it always prioritized returning the
> > i2c_smbus_read_byte_data() error code before returning -ETIMEDOUT (even
> > on the final iteration). In the new version, if the i2c read is bad,
> > the read_poll_timeout()
> > code will still be zero, therefore allowing the code to jump to the
> > i2c value check
> > and then return if bad (this is still the same behaviour IMO).  
> 
> It looks like I stand corrected! Indeed, we have two conditions to follow, one
> is provided in a macro parameter, and the other is for timeout. Here the Q is
> which one logically should be checked first? More thinking on it tends to your
> direction as it follows usual pattern as we check the return values (errors)
> from the callee first *then* validate the results.
> 
> > Maybe I'm looking at it from the wrong angle though. AFAIC Sashiko nitpicked
> > everything except this (but yes, it's still an AI so we have to tread lightly).  
> 
> > Same goes for the other patch where you raised this issue.  
> 
> Yep.
> 

I'll leave this one for now as the return val duplication can be tidied up.
I think the rest of the patch looks good tome.

Thanks,

Jonathan
