Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46A317173;
	Tue, 28 Apr 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392996; cv=none; b=Oa4MCtKufaUv0KYEEmRpv5l23EXXzVT75MJZBdEDFJGU1e5P2zVsKi4v4Pg8Ix6l8OzDyfwZXeBL1WPcZ/OXu1t5YXqy9Ryjf31ztclpXiTOpA1VNeDQsgGHf/xBqwIzrOCUXoN8juWwfXwoxtpm5dDxI2660L6wzwKCEJA5GWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392996; c=relaxed/simple;
	bh=l1xfPiyMfIyDoWo6tkiJtpWxxGJUP1GcMGW1bAKwzD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQwM5UHlfLSqZ0wbyi+HUfEJZgz+c2QZ6y4iaGFTu/2Sjs+RWmjGddbbwIRNCTBXqkXOXxlWdUXO9Ne0S3fXasyUroYI4RZv8a5n7DRJWTaS85UbrtHnFaEAjTvnfaET07++lUkgh30u3BGzvJBQ0ZzGfk2GrIGGX9HGfo2KFQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tE1usBPA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tE1usBPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E28C2BCAF;
	Tue, 28 Apr 2026 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392995;
	bh=l1xfPiyMfIyDoWo6tkiJtpWxxGJUP1GcMGW1bAKwzD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tE1usBPAtjX6XCD0TEsnZHQojSfzwfalAcYasthWNNoR48J0sKcgykXZe/Ij/NQbY
	 yMTLc5sjBqomBneMI9F2kUe4UVfYXjkT6QkawEGXRNyrQaVnnhjpUoCN5MYm8OMM2i
	 ax5DaILatFElayT3qofRSrRxEF7IxxDwjgOAtoN/Sp9Nvogy9ooBXOlC/0CpdFhcHN
	 zjAAl9SUhaIrdh9SdIuD99fcRXbp0akU6mXqM2wZFit0RnXDYEgZnLVcoGCiT1LBLf
	 0G1Lr4A0TeIqfJTYbxiP8bgud2sx7fM9rrVS01Qup33kMD3gf8kHvi2rgBL/Ohycxn
	 aUoDrbwEmZTWA==
Date: Tue, 28 Apr 2026 17:16:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes
 to the driver
Message-ID: <20260428171626.1fc178d5@jic23-huawei>
In-Reply-To: <CALoEA-zLo1Neb=6xqwRyNcgsWBdpXPQox3mvJo9pEXs-Y0h__w@mail.gmail.com>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
	<CALoEA-wCTEUA44ST5eg1EyHQTEop=wHn12NGddyqzPMa+EUZ1g@mail.gmail.com>
	<afBbylL3Ygt9GEYy@ashevche-desk.local>
	<CALoEA-zLo1Neb=6xqwRyNcgsWBdpXPQox3mvJo9pEXs-Y0h__w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 09:14:55 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 28 Apr 2026 at 09:03, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Apr 28, 2026 at 08:37:22AM +0200, Joshua Crofts wrote:  
> > > On Mon, 27 Apr 2026 at 22:14, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:  
> > > >
> > > > This series is an attempt to make the driver less a rabbit hole.
> > > > It's a continuation of what Joshua Crofts started doing. Hence
> > > > it is based on his work and first three "patches" here are supposed
> > > > to be folded to his series accordingly.
> > > >
> > > > I have compile-tested them, but I haven't done full double check of
> > > > the correctness from functional point of view. Joshua, please do that
> > > > before incorporating into your series. Yes, my patches are assumed to
> > > > become the part of Joshua's whatever next version of the series, that's
> > > > why mine is marked as v0.
> > > >
> > > > Should not be taken directly by the maintainers, but any comments, review
> > > > are highly appreciated.  
> > >
> > > When you said a few changes, I didn't expect an 11-part series :). I'll go over
> > > them and am them to my branch. I might check out the guard()() and chip_info
> > > changes.  
> >
> > On top of that also one may consider to switching to use reset-gpio instead of
> > poking "reset" GPIO directly. But this sounds like too many for one go, let's
> > make this 17 patch series go (6 yours + 11 mine).  
> 
> Fair enough, perhaps another time.
> 
> BTW, if I'm sending your patches to the list, I should also add a Signed-off-by
> tag to the end, right?
> 
Yes.  You are 'handling' the patches, so need to add your sign off.

