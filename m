Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672F4AB1A9;
	Fri,  2 Oct 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947952; cv=none; b=cKyRdf2JvACBt/g098yJNpXNd+keLBT3/AUbl1w7oQ790IOhG9bplcFOlavX6gjCDYafbYMY45/29Eo3tzfEp1epJcgrVQnu+Rsmqzbu6QXGiZ/1epAq3YVimb9jjo+nCL3vU2CsgZwrMeWNl+nKJ29NlPPDtzWF60ccuocBufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947952; c=relaxed/simple;
	bh=66wXKvA1hJzub0V/DhVtU/Gzq0pJg5UzFBW853S8Q98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urQG5enGmFeBBpddZjcXdM3a3XdxB6CXnYua89FByJVTcMf03Z71baLGSQ5gpd5u1FHOjYDbbN/onAFmDxQMLdgTcH60tcl4nem7flUvub7IJ8gvDuXNnz3D1G3oe32hZTbWOPlUX76+jI5Ylx+5U2p90DxnWn8jAS3s69zzrTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWyvfHn+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWyvfHn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790947951; x=1822483951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=66wXKvA1hJzub0V/DhVtU/Gzq0pJg5UzFBW853S8Q98=;
  b=KWyvfHn+ageb7Jt0di3yfNbcBu7Sy7dZz/V1vaXNhCS+uIYKecNePq9d
   h1uBLL10uMSs13Y8nxHNBChI7+BdlPT5aWCxykg+qpjFSERebzRMOcsZG
   i3qhwJynpAXGTyODam/p4IhGWL65FfhcwL6eYJBmT69HBhvtBoQcLGLMa
   h56jSI3MZy2DLW64s3u3ZzuTAwUi6v57Xgw2WPVDv7y+1QmXfnFxmIu30
   RudTyIZ5SxWJaELxGcglW4CrNiHsbSS2cgE0stPpqOxn1S7sAPgJOQm0R
   ex14uAtwHqBRfpDxr0+AxP29wiRol9p39J2VVFQY2dJQEtNERk76oicII
   Q==;
X-CSE-ConnectionGUID: YlsJmif4Q/SycWa1WShJUg==
X-CSE-MsgGUID: UI8Jmt3OS8+8vXw0yNRljA==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90613269"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90613269"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:32:30 -0700
X-CSE-ConnectionGUID: KCWCTXgwRfyhFv51UrmT3Q==
X-CSE-MsgGUID: Vh7MbyU3Rw6EiQ2PIGWncA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="280988032"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:32:27 -0700
Date: Fri, 2 Oct 2026 16:32:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: cdcp206@gmail.com, Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: temperature: ltc2983: avoid string comparison for
 leak detector
Message-ID: <ar-yaTw3gBFde0iA@ashevche-desk.local>
References: <20260929-iio-ltc2983-fix-string-compare-v1-1-d67d612d6ddd@gmail.com>
 <arzb0JQxkJAsLsEa@ashevche-desk.local>
 <20260930150336.GC3142230@ax162>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930150336.GC3142230@ax162>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 05:03:36PM +0200, Nathan Chancellor wrote:
> On Wed, Sep 30, 2026 at 12:52:16PM +0300, Andy Shevchenko wrote:
> > Hmm... I consider that the compiler warning is just a noise which we should
> > ignore or disable. It's doubtfully useful as if it may prove the always false
> > or always true cases, it doesn't mean there won't be other cases in the future.
> > Do we have any discussion on that warning before?
> 
> I don't think there has been a discussion around -Wstring-compare
> before. Unfortunately, it seems like clang's -Wstring-compare is
> different from GCC's -Wstring-compare. clang's is basically a subwarning
> in GCC's -Waddress and GCC's -Wstring-compare does not really have an
> equivalent in clang proper (it seems like it might be a clang-tidy
> check IIUC?):
> 
>   https://godbolt.org/z/zzT4WsoT8
> 
> So if we want to disable -Wstring-compare, we should only do it for GCC
> in my opinion.

I don't know if we really want this. Since Arnd also stumbled over this and
issues somewhat similar change perhaps flag approach is fine (and Nuno also
leans towards it even without relation to this warning).

-- 
With Best Regards,
Andy Shevchenko


