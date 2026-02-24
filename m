Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A4366579;
	Tue, 24 Feb 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926330; cv=none; b=DSzS5xRB1Snjhyk0/W6a2eRBoo2+W/Iiwz3uGeUgTYohateJAk6gEUt/MRKO/eMTaUEOinNlzKjeiar7/m/yRl+WcnKhoisLKpSqz9jb20g3/iZYFDNkrQukZnDyYxpxzkrrlXg5OaQhfPMOTLSGQ3VjJzfkGePT2N+DkQoLYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926330; c=relaxed/simple;
	bh=P6QrjailF7xxBNmLgKoeAmHlSatQ4U9I3eOA9ixYbXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjiwJnRA7yI8I6ic9SgBt4afDdtABWZ5oGcPAEePJkHH4AZqZ/xTS2JNHgWkJ7mNGvLtuWOT4nlAV44qOqCSCmQC9chyh0kKrlQ7UE3BeQG7LaacmW+TqOM/r8MB73tJCsRBb17hmrvxon10ACClJzVOhA2AWv4Yzvut1tzk/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxqfQIgg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxqfQIgg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771926329; x=1803462329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P6QrjailF7xxBNmLgKoeAmHlSatQ4U9I3eOA9ixYbXQ=;
  b=IxqfQIggVq+E/x1DIF2A5YtXtOd/xL/3Qm/aAXJVG3FyHDfTqx04Wn7e
   UTFq78cX9i0ksROOWO0ugdGr9diLwW9QvNkpNRWU6FRFcEfsdAEHDJblf
   cbMXoCqRz2VhcDhXLB+FZHaVWU0tGLyTuXMHC1eibBv4T8gmWD76BISic
   hg05nPPqDh67BqjMDvO87yjDQMbGQ3q04V4RHL9hU9jwrmKk/nbf8Iu4z
   5UaK4Hb0JJH2w1nR8tqHid+w5YPLPEjMICtYTSCUYN4eS5DtUxUDYdiGr
   jQCBJXj71JxZzNpKG60O1UzXXmP69vPB88ItSYfv5aM8nrjcSKJvFxbYB
   w==;
X-CSE-ConnectionGUID: dDPBddimQle70CBIjYQaNg==
X-CSE-MsgGUID: Wr7EVPAUTf27J67W8Jek3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72640514"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72640514"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:45:23 -0800
X-CSE-ConnectionGUID: L8nb+EC3RgmPftp1E44n9A==
X-CSE-MsgGUID: VYznSX1DTayjeINTJrv89w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="216015898"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 01:45:20 -0800
Date: Tue, 24 Feb 2026 11:45:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] General clean up and bug fixes
Message-ID: <aZ1zLpWkVdHpc2fk@smile.fi.intel.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
 <aZxFDIaOiqSqAbd9@smile.fi.intel.com>
 <aZxFSoTwIpDKNU4N@smile.fi.intel.com>
 <20260223211810.63ecc189@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223211810.63ecc189@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 09:18:10PM +0000, Jonathan Cameron wrote:
> On Mon, 23 Feb 2026 14:17:14 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Feb 23, 2026 at 02:16:17PM +0200, Andy Shevchenko wrote:
> > > On Sun, Feb 22, 2026 at 09:40:10PM -0600, Ethan Tidmore wrote:  

...

> > > > v5:
> > > > - Patch 1: Integrate some of Andy Shevchenko's changes.
> > > > - Patch 4: Split patch up as requested by Andy Shevchenko.
> > > > - Patch 5: Split this patch from the patch number 4, to keep bug fix
> > > >   separate from style fix.  
> > > 
> > > Jonathan, this version is good to go in my opinion except patch 6
> > > ("iio: light: gp2ap020a00f: Fix possible error swallow").
> > > 
> > > Ethan, do *not* send a new version until we decide what to do with patch 6,
> > > and actually the rest may be applied by Jonathan if he is okay with them.  
> > 
> > It's patch 5, sorry for the confusion.
> 
> I tweaked it and applied the series to the testing branch of iio.git

Ah, thank you!

-- 
With Best Regards,
Andy Shevchenko


