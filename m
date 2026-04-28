Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8895639BFE6;
	Tue, 28 Apr 2026 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391034; cv=none; b=kWnPPLcVUDFntsxeijXjSVmgYurjMiGYQi12OLOz8q+D3o8tKkZneE5lfakP+CRFFzfuJ+jQAXq9cdNIwaGulv0nEGHiEjYlRVes9jn/hX25DZ3z112HtIdVey6TNNtZssTyJANutOuKDCts9iE6HdDB04rEWu5uyoylYF9EZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391034; c=relaxed/simple;
	bh=pOWmNRzxgD/tgc4Z3UTAVHfE17nMkUF6T/jlIC+WUHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdwpmW5FXZF9yI6g1VFMxGXr1BUAvUcRHaiihAiLasn0HO8junsibloGisDIvlY+2XbTXTtKvJ79tKPUxr7bJBK4IozA9s4vjsTs38Y4P2m3/ytylpZTLX9Xbc2kBEOVtxhjbpTRU2cpPEBilfab05fwTS1Y53r/gyzJlr9uSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RHlq1KT8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RHlq1KT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777391032; x=1808927032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pOWmNRzxgD/tgc4Z3UTAVHfE17nMkUF6T/jlIC+WUHo=;
  b=RHlq1KT8jaSrT3UZKvsPoBrT3DHLx/WHcCddSplXWWdohDCvVeToPU9g
   ANkuNJFRbbwn4wjM/qKrs4BQUtyEOOmfVnONMM4B43LmuK+LatOaqSu36
   VO0V7ffxUqhub7Dt5fqyCUmou95AazBwghOKIS9NqZUUUKLFOLJgCpjiT
   IqDyWkYzAVf0o1Lk7ZyMFWccvpXmxuie5IwFuC8IL36xsIxbDftspC48o
   2ZKDkfd5Yq4Kue19NOW/px/RBnwACvtpRoqpGZqlKPgpqBq+Q6cc5rLDe
   u5OAxquPAuMtWgGBVP/ZjbNdRX6HefpjOrDm8TWPqFMZ/CEucvrSKwE65
   A==;
X-CSE-ConnectionGUID: nqb6s9B8S2qWdwQgxnws7Q==
X-CSE-MsgGUID: ZuOCeMaQQjWMGzQX57N05Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77334490"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="77334490"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:43:52 -0700
X-CSE-ConnectionGUID: Gs6KXCwEQryZyEU35/vMCQ==
X-CSE-MsgGUID: hvZ8GGK5TVm6asemo1ewcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233123750"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:43:49 -0700
Date: Tue, 28 Apr 2026 18:43:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Salah Triki <salah.triki@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: max30208: fix wrong scale value
Message-ID: <afDVs3Zk-pCajNnH@ashevche-desk.local>
References: <20260428085415.52858-1-salah.triki@gmail.com>
 <afCTYDYCRXoxi37r@ashevche-desk.local>
 <afC3wHzcwWMMgt3i@pc>
 <20260428163458.477eda9b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428163458.477eda9b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 04:34:58PM +0100, Jonathan Cameron wrote:
> On Tue, 28 Apr 2026 14:36:00 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
> > On Tue, Apr 28, 2026 at 02:00:48PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 28, 2026 at 09:54:15AM +0100, Salah Triki wrote:  

...

> > > Isn't it an ABI change?
> > 
> > Yes, it technically changes the value exposed to user space. However, the
> > current scale (5) is objectively incorrect according to the datasheet 
> > (0.005°C per LSB).
> > 
> > With the current scale, a raw reading of 5000 (25°C) is reported as 
> > 25000°C by user space tools. This makes the driver practically unusable 
> > for standard IIO consumers without custom workarounds. Since the driver is
> > relatively recent, I believe fixing it now to match the hardware 
> > specification is preferable to keeping a broken ABI.
> 
> Yes.  It's fine to fix completely wrong ABI like this.  It can get messier
> in more subtle corners but out by a factor of 1000 is an easy one!
> 
> > What do you think?

I think you need to write a wrap-up of the above and add to the commit message.
With that it will be justified as far as I am concerned.

-- 
With Best Regards,
Andy Shevchenko


