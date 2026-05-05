Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2FB42B74B;
	Tue,  5 May 2026 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984911; cv=none; b=LzQrHtCNVWXref8hibSm4BFTBFdyCYSLLV5CF7BhiNFpxOZA7QG63aTZiTJ84muZwjNMKsffJ843T3NuWtjZ2i+gIdhs6WzrB80FIVPwHzAJdX8XrsFBbUG/N5L9T12gfSrXkfmLi1vv3GuKkVxsktVTmhzVwCswHcp7EKCMDy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984911; c=relaxed/simple;
	bh=eeJbbu5cyBz04nCEYaRRMo5VrtFwTXipFdUtmpNRZJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUCDpif/xXNBnGTydiV7te9r86e0NHVI4UiDDaaRVaIaDvyeKgtM6L8ViBl4Vfbrjj+gkhVq5wxBX7DI6ZitmN45P2WiTCpn5QGdzuizc7Hi8nkwo/7XckSWNphecPcuYVmWiLYIfIWeJPN0u/u3DKixH0OwS/C4xwqbD92Zayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBHlukIg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBHlukIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777984909; x=1809520909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eeJbbu5cyBz04nCEYaRRMo5VrtFwTXipFdUtmpNRZJQ=;
  b=aBHlukIgmmKBZW15yo4iH6LWTqUY+H06ugcPSEOhaqDs2Z1Byfavtjtq
   MYrLjFZY5vtnywdqShYOkel2GroaIUxtFLwfK0ONOvCTOhWlB93E1HNTn
   /t2TGLQfJU5WjKkXRN2y44KriXIDcHmeodqg7xblvR0yqoUusTNVCqlo7
   BmrcwfjKLcI3oYLu+TSMs7MLPD1wWXCtUkOuaFoYFZWDVLXOndUnMv/Ii
   9Rvui0Dua0zZhbcJBKQeVuGh5i+U7Ir8A9/aZDCxqxgQg7fxr56coSe6d
   N6jJq/ul7Uaa9Ud20IX8eWdHHWSATKUgi+xRFrzKMMaSv6sXCeD1xJLA+
   Q==;
X-CSE-ConnectionGUID: SppG53oNTWqANVCnXZ0i2Q==
X-CSE-MsgGUID: HLbKo/5XRLSQZLkvHjbvhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78760650"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78760650"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:41:49 -0700
X-CSE-ConnectionGUID: s6RdnkJbQDqxjSvB11M+5g==
X-CSE-MsgGUID: vRMJVVURQDiaKGpZmcT/Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="233139474"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:41:46 -0700
Date: Tue, 5 May 2026 15:41:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, lars@metafoo.de, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] MAINTAINERS: iio: adi: consolidate entries
Message-ID: <afnliKBrxlkx1Vmq@ashevche-desk.local>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
 <20260430190642.3434650-3-sanjayembedded@gmail.com>
 <20260504172457.4d7c7390@jic23-huawei>
 <AB6B7E29-83E2-4BE8-AF74-1DE8358527E6@gmail.com>
 <afmyqE6-XcT-SRt3@ashevche-desk.local>
 <20260505115409.44245db6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505115409.44245db6@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 11:54:09AM +0100, Jonathan Cameron wrote:
> On Tue, 5 May 2026 12:04:40 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, May 05, 2026 at 08:00:23AM +0530, Sanjay Chitroda wrote:
> > > On 4 May 2026 9:54:57 pm IST, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > >On Fri,  1 May 2026 00:36:39 +0530
> > > >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:  

...

> > > >> -AD738X ADC DRIVER (AD7380/1/2/4)
> > > >> -M:	Michael Hennerich <michael.hennerich@analog.com>
> > > >> -M:	Nuno Sá <nuno.sa@analog.com>  
> > > >Specific maintainer. Why is it going?  
> > > 
> > > I'm assuming that to avoid de-bounce issues from *@analog.com domain, we are
> > > adding linux@analog.com mailing list as primary contact. with that in mind,
> > > this series drops all entries which match the wildcard and have analog domain
> > > maintainer or reviewer while keeping the rest as unchanged.  
> > 
> > But it's removing people behind their will! You really should do this
> > case-by-case. Some of the people who left the company might still want to
> > follow the driver or even maintain it. What you should do is also pay attention
> > on the Supported vs. Maintained which makes a huge difference on the
> > responsibility and financial side of the Subject.
> 
> Some of this was in response to discussion with on specific person.
> That one is fine but be very careful beyond that.
> Probably best to add a link tag back to that discussion as well.

Or at least mentioning this in the commit message / cover letter.

> > Btw, Have you consulted with your Legal department on all this?
> > 
> > > >> -R:	David Lechner <dlechner@baylibre.com>  
> > > 
> > > Additionally, When David is list as reviewer in individual driver entries, I
> > > consider as redundant part; All IIO subsystem drivers/iio* already covered by
> > > top level entry, which includes Andy and David as reviewer.
> > > 
> > > Summary of changes in series:
> > > - analog domain specific entries are dropped and catch with linux@analog.com
> > > under ADI IIO section.  
> > 
> > No, you should give a good explanation why in each case. Yes, you may combine
> > the cases when people left the company, but you also need to
> > - consult with your Legal
> > - consult with those who left on what they wish
> > 
> > None of them seems done so far. So, again BIG NAK from me on this series!
> > Rework them and even part that drops the entries that already have the same
> > maintainers as current ADI level ones (assuming adding Nuno in a separate
> > prerequisite patch) is good to go.
> 
> I'm not keen on using the top level reviewers as enough to drop an entry.
> Where Nuno and David have specific driver entries the lifetime of those
> may well be different to the top level one.  So leave those alone.

True, but if the people who maintain the certain driver(s) are okay with the
collapse, why not allow that?

> The only ones I don't mind falling back to the top level catch alls are
> those where we are dropping a reviewer / maintainer (and they were asked)
> + there is nothing else listed - hence the higher level entry is the
> only source of information.
> 
> A wider scrub is not appropriate.
> 
> > > - Non analog devices reviewers and maintainer is unchanged for each driver entry.
> > > 
> > > Further, I also agree with adding Nuno Sá as a maintainer in the top-level
> > > ADI IIO entry, so that all drivers are maintained via the mailing list with
> > > his oversight.
> > >   
> > > >> -S:	Supported
> > > >> -W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
> > > >> -W:	https://ez.analog.com/linux-software-drivers
> > > >> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> > > >> -F:	Documentation/iio/ad7380.rst
> > > >> -F:	drivers/iio/adc/ad7380.c  

-- 
With Best Regards,
Andy Shevchenko


