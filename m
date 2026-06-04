Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8E2BE7CD;
	Thu,  4 Jun 2026 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602723; cv=none; b=BzYxYCXLsFhfoC6PrtkgTQgVaqRXLDe4VM23WlLKEGVc65DTZkk7S9GbqVMWbPPirLcgKvvUdSFHdYAI2QkKirp+dp9EfP+c3l+FWpP94XrVMl7CmLgcHlXMztmk5kRd55qRpYkxm552erRYNUiDirlOO/0XO+BJK2nBChCI+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602723; c=relaxed/simple;
	bh=T3ON8U+Lc0mMTzbjnCLobpvwbCqKFznwnEswAAqae7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkwAImxjgTmFuR9mFKtmOFQv6Hv/Xjo/uSo4KLb/lRb4+gqpR97YIZmyBelvB0jHUD6X/seKBpoY2sLgI1S8TTnXC1h2A6Ag5Lv2Bp5PAAsX0hnXgYmPP3BfPAgOtugwIplZ3z5iehD1tbz43OQGUOe9WJZEq7kQCspFSwBkjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVd4a2IB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVd4a2IB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780602722; x=1812138722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3ON8U+Lc0mMTzbjnCLobpvwbCqKFznwnEswAAqae7c=;
  b=hVd4a2IBB0+GgnTY+NPh4kKcDyF7lHFWS3uAeIKKVk6419wdQnfsoJ4U
   9pDAncLRBpvQ6vSw1EjCSU/brQRG/71NwBM4BffSG39Abf0M0xQOGYbSe
   sLAJwCbRaRDDqeuVIoM+FYM+kdw36hureGG+ZlJt+xoCQ7db/FUVluQx6
   yBER/12n4GU0kYAFvd/bqXGNIgjQ0NL8/GYri02I7NTOTpqq34DQtYQv4
   f22eQEGEOYDTBuXf3ffxCF4XC4qO7XisUKET2b6HLHz5SKWAt9FkvNdx+
   9/6Mudo65dsskFVOJT9otq/KL8nhfl1ymhEfcYlg5OtYBYATGyyHGOoEz
   Q==;
X-CSE-ConnectionGUID: 7cCSEYN1TCylFxfFHcvGWw==
X-CSE-MsgGUID: WWNVk9lgTNKU6pBxTkEs6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81436922"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81436922"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:52:02 -0700
X-CSE-ConnectionGUID: y7yeIrLtTGK7pVjwDRpjtQ==
X-CSE-MsgGUID: IHnfC1g9RO6glRyHfCs3NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="268334198"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:51:57 -0700
Date: Thu, 4 Jun 2026 22:51:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	rodrigo.alencar@analog.com,
	Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 09/12] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <aiHXWwRK2LQxdRYv@ashevche-desk.local>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-9-691e01883d27@analog.com>
 <ah8roqGqZ_VhAPaa@ashevche-desk.local>
 <ylp2jf3wbojbwoozhow433vcvnz24ahvqlr35hhdoctm42rqqn@irrv3f76gr7k>
 <20260603135525.41331916@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603135525.41331916@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 01:55:25PM +0100, Jonathan Cameron wrote:
> On Wed, 3 Jun 2026 13:26:43 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> > On 26/06/02 10:14PM, Andy Shevchenko wrote:
> > > On Tue, Jun 02, 2026 at 05:33:56PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > >   
> > > > Use of local SPI bus data to manage a collection of SPI transfers and
> > > > flush them to the SPI platform driver with the sync() operation. This
> > > > allows for faster handling of multiple channel DAC writes, avoiding kernel
> > > > overhead per spi_sync() call, which will be helpful when enabling
> > > > triggered buffer support.  
> > > 
> > > Why spi_message_alloc() can't be used instead of manual handling?
> > > (Seems no current users, so you even can modify it for your needs.)  
> > 
> > I need to manually call spi_message_add_tail() to append messages.
> > I suppose that such function is a bit weird and no wonder why it
> > is not being used. struct spi_message_with_transfers might need
> > to be properly declared so that users can populate the transfer
> > array without manually moving pointers or having to redefine the type.
> >  
> Agreed it would be significant surgery. Perhaps worth it as a follow up
> if you can find a couple of drivers open coding the equivalent.
> 
> Otherwise perhaps send a patch removing spi_message_alloc()

My experience with removing of dead code in SPI is that Mark is reluctant
doing that. Maybe if somebody tries that  it will work this time.

-- 
With Best Regards,
Andy Shevchenko


