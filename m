Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C92ED84A;
	Mon, 18 May 2026 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086672; cv=none; b=l7TDOSJDI8yoT+9kxsMVG385D0+YN3gCW0Fr72VBx4qYxAmxC22oXu6P0pM8Cu4GxKDxWsJMsFoGRXo6o3Ed+Q1gWnypuOEKWdt+INP4TLkg8HfSURI1UiPXADvqx+R6dAmcQB4MIQZVDdwGytzbvqDhtIn9h5muQrOtm80Cm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086672; c=relaxed/simple;
	bh=NaBsCiEzBh2l62UYbT/Tg/jcXbBwLVo6fLA30JPkv78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjzrFQ4gEzhoA0hjQeS/dpn9fTZxSKO39XGpa1snFTvKiKAtNx1CDqFDHMDnL7Q72hfDqE99sYLXUup9kM6wNGV//ca23NmPG4HVVKhR+02wfjbK78l53m0M1SpizlvFlRSgxllREBTBtyNBdV8We3D5gRkQfCpAJP5473hbHj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJ0+Y3j6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJ0+Y3j6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779086669; x=1810622669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NaBsCiEzBh2l62UYbT/Tg/jcXbBwLVo6fLA30JPkv78=;
  b=VJ0+Y3j6MHa3a89ia/m2HW6ZqfA+KmZgveH5rQPftIGqfoR5PFunbB8I
   yJJ7ZQfeJ7qGVu/dKZ3ZzewGRPfWK4hrj/+Em+jWW0nL5BE1/k0MouV/2
   JGzB3bS+0A8Lt23eLiub+j4YgUYcNu6jtVv/ydzo6nJzekkBZmvHZoYdo
   ZkX+YozptVvjhKRIrCkXtT3jx4goRZaXLgrIGzGd8BduQohz5SOQ/acGT
   bP7pq7i2H0ML7qFWPsrJweky4b2YARoXKjEBKELmlQl4JabK+eK7e05HG
   umCwHR3AL+9IAzV9fIFkNg1H/L95ISrufpQKGkzSHN83MSKkqG7fDyP9w
   Q==;
X-CSE-ConnectionGUID: LeqjKVlQS2OznMDBZJDD4A==
X-CSE-MsgGUID: nklyRi2AStSqFhnWX22xYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79980366"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79980366"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:44:27 -0700
X-CSE-ConnectionGUID: 72L9Bp4PStmSIaPG4eg5PA==
X-CSE-MsgGUID: fbIIQAseQ8+rVoOTzp+fmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="262856490"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 23:44:23 -0700
Date: Mon, 18 May 2026 09:44:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: veml3328: add support for new device
Message-ID: <agq1RVf-x4UnCOMI@ashevche-desk.local>
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
 <20260516-veml3328-v1-2-1d4b663e2fe3@gmail.com>
 <20260517143449.6c30b99f@jic23-huawei>
 <CALoEA-zpJ2B4W6N-++cBqE6fBLsd08D4j+Rozgpt+1=NBAga0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-zpJ2B4W6N-++cBqE6fBLsd08D4j+Rozgpt+1=NBAga0g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 17, 2026 at 07:11:06PM +0200, Joshua Crofts wrote:
> On Sun, 17 May 2026 at 15:34, Jonathan Cameron <jic23@kernel.org> wrote:

...

> > > +     ret = pm_runtime_resume_and_get(data->dev);
> >
> > PM_RUNTIME_ACQUIRE_AUTOSUSPEND() will mean you can rely on this
> > being auto suspended on exiting scope.  Will allow early returns
> > and get rid of your goto that you noted already.
> 
> Sorry if this is a silly request, however I can't seem to understand how the
> macro mentioned above works... Could someone point me to documentation
> on it or a functioning example in a driver?

`git grep ...` is your everyday tool for most questions in the kernel :-)

In short it uses the guard()()-type approach beneath, it creates a scoped auto
variable on stack and then uses it at the function epilogue.

-- 
With Best Regards,
Andy Shevchenko


