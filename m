Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7D3DA7C3;
	Tue, 14 Apr 2026 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776185968; cv=none; b=sNe6pdGenj/zIRPGAtJNg5GJebN3EUz2BaSCmHHAHWgHwsbIo0pM2RNAEI1jhfEaNiIrOcbO3HVe0cLddZEV5jOxcpR2H4stkm4NBytTrP+R8IzbhBklQX795iLy/nbOo2bU8aDwg/v+czYtqyxGAh8+DZuX2eKXcWgUewAtNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776185968; c=relaxed/simple;
	bh=jOEyb/KuyVjIePfZvdwqF0VJR5q0TCEVCq2cdDlHJkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSYwdlkoS/dP0PYFmHXEPgAUCxrElHtAbz7kdih8Y9qTbSHTDyB2+F7aRObRQ3Tr05MtCCbpuKuQc1G1xNqF684aoWdmyeXhq+1ZgjmbXkLpM0twodtWzAgSzwH2qgd8v4+xZ4n8CIvLiuU4xwMjs2AEpLziLMIHArArpRxZZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFPaJmSA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFPaJmSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776185966; x=1807721966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jOEyb/KuyVjIePfZvdwqF0VJR5q0TCEVCq2cdDlHJkg=;
  b=mFPaJmSAAtEXeftugz3+gesbmTENb9ZfC45wOsCroXQJnu/1DxrHWX08
   BZl+Y6X+RhCKmAXW0SD4s42qOwBetaMpdhTtC1nerPh5Gyv5zqp5yY2pR
   J0GhkK4aVmGbViFcauU4S8aE31gsw67KBmR7SAE5VGAGw5ydeF/7V0HTC
   oJsQ40ueOj0TVVdLD7IQT+Flu0apBAEGLUclt78X6USzxFVLneQFfdvut
   hqZ9t4qBddm97v25e9FVMIRrwWAWpKs1rtdgWYL5Vx+ySI9uuPGHljiQu
   c5HRkbVZmTLT0DCyQ3FZk/BmQ9MdD2NJqVR8TbkHrgnimHkIv8kY2XgR2
   g==;
X-CSE-ConnectionGUID: YMpOFPHES8ahsouDIzHk3Q==
X-CSE-MsgGUID: B/nE79bQQ6qJRyT5eLlNqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="79737535"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="79737535"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:59:26 -0700
X-CSE-ConnectionGUID: jzclmp2lR7SCzBe3wzGPzg==
X-CSE-MsgGUID: XlmNrgNrRumr35GY8vsTlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="268124205"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:59:23 -0700
Date: Tue, 14 Apr 2026 19:59:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: frequency: ad9832: simplify bitwise math
Message-ID: <ad5yaDeXhqn7KLmy@ashevche-desk.local>
References: <CALoEA-wfx3=eVq=omiNmDeSaZpNP85KZd32A=GBiU-DVZ6btAQ@mail.gmail.com>
 <ad40MI2oyvDeu4Gh@ashevche-desk.local>
 <ad465p5LVaSMlTUa@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad465p5LVaSMlTUa@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 04:02:30PM +0300, Dan Carpenter wrote:
> On Tue, Apr 14, 2026 at 03:33:52PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 14, 2026 at 12:45:31PM +0200, Joshua Crofts wrote:
> > > On Tue, 14 Apr 2026 at 11:57, Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > It's up to you. (u64) casting here is not bad per se. And it's more robust
> > > > against changes in the second operand the type of which is hidden currently.
> > > > (Reading again what I just wrote, it seems I objecting my own suggestion!)
> > 
> > > If I'm not mistaken, the compiler would always do a type promotion of the
> > > "smaller" operand (in this case fout). By casting at this point we're just doing
> > > the work for it, so I guess it doesn't matter.
> > 
> > Yes, and the problem here that BIT_ULL() is (semi)hidden on what it returns for
> > smaller values.
> 
> There is no way we'd implement a BIT_ULL() that doesn't give you a ULL.

I meant that it's not crystal clear, one needs to know the naming convention of
BIT_ULL() and/or check the implementation. Reading (u64) is much clearer in
that sense. Also in case of BIT_ULL() parameter being < 32 it may be replaced
with BIT().

-- 
With Best Regards,
Andy Shevchenko


