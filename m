Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD737FF47;
	Mon, 23 Feb 2026 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879492; cv=none; b=RClt7H5PD3OX/q01h9Q2vzFNSjQdIlzb5ifxIWw7F/Tmw4W+UtUBtmA4YlX+LYbRlkR06KXoHspEx/a57LrCyuKERwkzbQ+3kM9bjgJlsub2C2sjo01snGfQyDYQ0kEg+TVyeZGmlmdMufjWb0HWadR7KYDAoI8BCtItSGCeazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879492; c=relaxed/simple;
	bh=5qStVCqsaxcLwloex/fifxFkrBqG3eM3SckTb5NwC7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPJacWIXjgJt2Zp5w3o25PQITp+1zdnZhL62N4+TZ2wx4oydnAD6mtvcH9dZTeS+jezxB2VdRVcfWIEelEj3PyiaQETNXQXQ+CR7l2a2pTcBJ5VBcziBigPqGlieOzaWSsCkmaO42ASyaU/TzPiseHWaHG+UbvSA+LOlNropq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so33GO5J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so33GO5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8365AC19421;
	Mon, 23 Feb 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771879491;
	bh=5qStVCqsaxcLwloex/fifxFkrBqG3eM3SckTb5NwC7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=so33GO5JKVhsaHCigceCyqm5XTUQTc8Jn7aaq3ZUGWJXUHt7Rc9fO3Z6ZvK3C43PP
	 UA4gzGk7VJbkRuMnBw89H72pb9sAa0Vz7FM+GEGXVWJiUV35AZQO0eqc4NqOqdkaFA
	 xBH5OtWyH96AocryVKcvBkNCFWAebm/MVDQVRdP0PfxfklwPEQ5xxVRRxVNCx5UDNo
	 mzI3e2sD3FlE5T1WR54/9uXLa7Xmmr9UdanYQsRdkTzVfwLqm0thKbiv5X1feJ1eYc
	 5RyZD1YOE4X8ypXsxJ0JTrUH+7WaEl4BdR69GjswPRKRAdsQHFvqq7Fa4U+P+QucKr
	 BU5QA4dNYmXkQ==
Date: Mon, 23 Feb 2026 20:44:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Archit Anant <architanant5@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use
 div64_ul() instead of do_div()
Message-ID: <20260223204442.444c7503@jic23-huawei>
In-Reply-To: <aZwRt7ws7PeHyuPM@smile.fi.intel.com>
References: <20260218125327.21467-1-architanant5@gmail.com>
	<aZXD0smUd3CRgPcv@smile.fi.intel.com>
	<20260222134326.7fc1f45a@jic23-huawei>
	<aZwRt7ws7PeHyuPM@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 10:37:11 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Feb 22, 2026 at 01:43:26PM +0000, Jonathan Cameron wrote:
> > On Wed, 18 Feb 2026 15:51:14 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Wed, Feb 18, 2026 at 06:23:27PM +0530, Archit Anant wrote:  
> > > > Replace do_div() with div64_ul() since the remainder is not used.
> > > > div64_ul() is the preferred API for 64-bit by 32-bit division when
> > > > only the quotient is needed.
> > > > 
> > > > Also replace explicit casting and shifting with the BIT_ULL(27) macro
> > > > for clarity.
> > > > 
> > > > Note: A mathematical simplification to `(freq * BIT_ULL(29)) / mclk` was
> > > > suggested during review to improve precision. However, as confirmed by
> > > > maintainers, the original driver's truncation via `(mclk / 4)` might
> > > > be intentional or relied upon by userspace. Since hardware is not
> > > > available for verification, this patch preserves the original logic
> > > > to avoid regression risk in the absence of testing.
> > > > 
> > > > Issue identified by coccicheck using do_div.cocci.    
> > >   
> > > > Changes in v2:
> > > > - Replaced explicit `(u64)(1 << 27)` with `BIT_ULL(27)` as suggested by Andy Shevchenko.
> > > > - Kept original arithmetic logic `(mclk / 4)` to preserve behavior.    
> > > 
> > > The place for changelog (and comments)...
> > >   
> > > > Signed-off-by: Archit Anant <architanant5@gmail.com>
> > > > ---    
> > > 
> > > ...is here.
> > > 
> > > But do not resend until maintainers explicitly ask for that.
> > >   
> > Tweaked commit message as Andy pointed out was needed.
> > 
> > Applied to the togreg branch of iio.git
> > 
> > Andy, if you want to give a tag I can role that in for now as need
> > to rebase anyway on rc1.  This mail felt like an 'almost tag' ;)  
> 
> I think you are talking about my Rb? Sure
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Added. Thanks,

