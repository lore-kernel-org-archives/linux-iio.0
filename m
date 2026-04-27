Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045692F12A5;
	Mon, 27 Apr 2026 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273002; cv=none; b=phyD1PhSNeeWiHYvUAePagk7X1HJgTMuARJyQKNfJoCi2sA+0ZjdL7LCVP2aXHL4+WnM/yYDhKVCBAbm61M3h/SkcU48H7U2CDfoIx17nguIWDSxLhZ5OeDKQw3+T8gXJ0ByB67kocLwUk1suVzg3uxoDmpn4sNtheyCh6Logvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273002; c=relaxed/simple;
	bh=AzwLsyNbWGdhAqTw2RwdQyC52TDKHcmYIZZkhUoAc1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVghEG8hZGfRwVSnIjj+C6Qe/GB/nrhiA1B3R190/RKrZAnmK8F9I0enNdq3sE0Iq1UXqqdN6+MrA/5L3soFiBftPrCmdV61qbYhnllOPGALBN8svGRyh1HBW+S4NB2dLiozur2npDT5AKLehUmS5zE0qrGCLDvmstPQivKZ2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnGT1ZtM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnGT1ZtM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777273000; x=1808809000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AzwLsyNbWGdhAqTw2RwdQyC52TDKHcmYIZZkhUoAc1Y=;
  b=SnGT1ZtM8zrj0bhEUJV3obu7E/L2MMyrOHehqMTX5+0QefoNDAyjSEO0
   Lxvcgmk/yqGDTxTUNq2UW4CMoV/jmPDym8U4XkYbQdYhNC1G77Kmbpeu0
   iwfy5JD+P26Ki1/5FEXLhC1RNXIzXPEj3vp3msu7nS9suzOQZbkZ8FZKb
   B+HxfBsP5T4Yg/22Zx5TYRhJm15lM+4ez/fq44fl45n3ffnvtbBaEkePA
   WM5tRx2IKZC3f9q0zCXEVNzUFAj5jMSrg5x4ybvpoYH/nJJK3ZShf0hvn
   AB35Lxd40Z2JLMzW25mcAtlawiD0EKR1sE+a+zGQnexevycaN/KYL4z2k
   w==;
X-CSE-ConnectionGUID: 3qzesCyNTPq3rABsKqtzZg==
X-CSE-MsgGUID: JpLrW8rtQxezQKODv5WaLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78042909"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78042909"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 23:56:39 -0700
X-CSE-ConnectionGUID: 3pXHY9vRQrqefH7qPMrgqQ==
X-CSE-MsgGUID: Qk/Ld2uLRoqpMjZWVkvCCA==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 23:56:34 -0700
Date: Mon, 27 Apr 2026 09:56:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rodrigo Alencar <rodrigo.alencar@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v10 02/11] lib: kstrtox: add kstrtoudec64() and
 kstrtodec64()
Message-ID: <ae8IoA92L4jlOBoQ@ashevche-desk.local>
References: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
 <20260415-adf41513-iio-driver-v10-2-df61046d5457@analog.com>
 <mhfgedq2t5lqtu6535ahdmpbvib2xzp2hmyt7ezflnf52r56jh@ze6tee7vpij3>
 <20260425164006.17b75faf@jic23-huawei>
 <20260425233316.0a2e2abd@pumpkin>
 <o5m4mp6qrt6pzhns4q5vyxc3fwlat7675a46wpr2phjbveosw3@rwmdqelfnkix>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o5m4mp6qrt6pzhns4q5vyxc3fwlat7675a46wpr2phjbveosw3@rwmdqelfnkix>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 09:02:26AM +0100, Rodrigo Alencar wrote:
> On 26/04/25 11:33PM, David Laight wrote:
> > On Sat, 25 Apr 2026 16:40:06 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Fri, 17 Apr 2026 09:36:20 +0100
> > > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> > > > On 26/04/15 10:51AM, Rodrigo Alencar wrote:  

...

> > > > I have an alternative (slightly more complex) implementation of this function
> > > > that handles E notation. I find this particularly handy when writting big
> > > > values like 25 GHz when the ABI is defined in Hz, so instead of writing
> > > > 25000000000, one can just use 25e9, or 2.5e10. I found that my python code
> > > > was printing big floating point values or really small ones using E notation
> > > > and that was giving me -EINVAL, so I had to adjust formatting when generating
> > > > the string input to the file. No big deal, and we would not need this here,
> > > > but if maintainers find this useful I could add it into a v11 of this series.
> > > 
> > > I'd rather we didn't slow this one down. However I'm waiting on some tags
> > > on this patch from folk who are more familiar with these parsers than
> > > I am.  Given discussion, Andy or David Laight perhaps?
> > > +CC David - please make sure to include folk who have been active
> > > in discussion of earlier versions to decrease chance they miss the new
> > > one.
> 
> From Andy's message "We still have several weeks time", I thought we would have
> time to discuss this e-notation thing, but that's just a nice-to-have indeed.
> It fits well in the decimal context, as it is widely used and works in powers of 10!

My main concern is to have one source of implementation.

Yes, we can have specific parser for the specific need in the certain subsystem,
but as I already said (and maybe not once) the problem is that if any bugs or
features is desired it may diverse for the 2+ implementations of the same, putting
bug spreading and double effort.

Having e-notation supported is fine, but can we do it separately?

> > I can't help feeling this code would be smaller if it didn't try to use
> > the existing conversion functions.
> > Something like:

> > That is missing the overflow detect for the multiply and add.
> > While check_add_overflow() hopefully looks at the carry flag (on non-mips
> > style cpu), I don't know how the 'mul' variant works - it might be horrid.
> > A bound check against ~0ull/10 might generate better code.
> 
> It may be a compact parsing but aside from bugs or typos, there is a readability
> tradeoff. For the context, yes, it would be better to accumulate interger and
> fractional parts to the same variable, rather than separate ones.
> _parse_integer_limit() would have to allow for a custom init value, so we could
> just skip the decimal point and resume. The proposed implementation reuses tested
> infrastructure and follows kstrto* conventions. I suppose the most important thing
> to review here is the new interface with its function prototypes.
> 
> > But I really prefer functions that return the terminating character to
> > the caller - they are more useful for parsing compound parameters.
> 
> I agree, I tried something like this with the kstrntoull() approach.

With the wrong naming. kstrn* is oxymoron. Semantically the kstrto* are about
strict input checks, including overflow.

> > > Maybe start a discussion about whether adding e notation as a separate
> > > thread after this has merged?
> 
> Agreed.

Yep, sounds like an additional feature that may be added later on.

-- 
With Best Regards,
Andy Shevchenko


