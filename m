Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB43D890E;
	Thu,  4 Jun 2026 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561726; cv=none; b=LYEKHx64CGlFH4v3sAitduqzEJMUgBx+00JTY2k+RMiUqZMZIhAVmV6cLyKF7DMA4LzLrwcC6Asth8R8qRXia1TmP2PdFCM407h7kQ8IlKPM3Z0qM2ajuxxSmsZ8iS3tcUdULItHBj72tmQgKtvbRxIKG1WMIjq9+RYyd2vRIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561726; c=relaxed/simple;
	bh=9zx19wYtgE4Ikgm/7eUIwQDO7PeN13kjlAZtI3wzgzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UofJG5fJ1Fb25S/yTsby87/6W3vbnTKGwf0+s+5RfKBd6KYZVBZbtHUdi0Qp29zzVslZ0NnwEPA2qRKWsLekO/p/YeIKcQo/ipdhPjF/SHvnDCGtP35mRytf+QnNshV3DBR2MtaceUOr1Ca4Nc1nOsMSUIcUYJa1M2A8bGnr3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6FsWGMG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6FsWGMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780561725; x=1812097725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9zx19wYtgE4Ikgm/7eUIwQDO7PeN13kjlAZtI3wzgzM=;
  b=H6FsWGMGJD91fHw0D22iFIid8oYAxAW9ZJJ1zKAOdb5tqvBUDaS6kCZx
   0mvUsy5MbFBBi+MDbtyVCATwV+xZQ9KMARhtl50kZ7xBCKNNYqHcm9WED
   rOpWhHQDrRR8e4YFbxKu14Lpr+EaMfgeqTRCY4wlRXT8rtTynAg57Ez/f
   40n8noirNAh4zhABPRN3MZbG+pnFI1bbh5uIrdxHiQ7lM+/KQj2VEhHlE
   6Z7vdTfoSFvPD+YbIqoaWODXzFUVSYH+Pb+77H5l/aarXlzQ/WJ9oTjwy
   66XuoeoqbWzW7Jf5XBQd4Z+0p2h26MjjLrIdOzYpPf5OixHq6DC3n2hGP
   g==;
X-CSE-ConnectionGUID: +EJBaNADQ0yI1tmvDTAUkA==
X-CSE-MsgGUID: 6Oo9ufSeTGGqiaaCu8KaKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="85006504"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="85006504"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 01:28:44 -0700
X-CSE-ConnectionGUID: m/mIAiOJRGObUZ2Jq6XieA==
X-CSE-MsgGUID: NRF4GEenSZWEhPadMEmw1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="238143085"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 01:28:42 -0700
Date: Thu, 4 Jun 2026 11:28:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <aiE3N6zErq2WcCvS@ashevche-desk.local>
References: <ahP3O2tQdu4dNx_c@stanley.mountain>
 <CAKqfh0En4pHqSfxfd2FHSDTxfWx6BfJLfeQ3xup4bwfLSTrZRA@mail.gmail.com>
 <20260526191946.409160c8@jic23-huawei>
 <aiEpmqKwFuIMRfdl@ashevche-desk.local>
 <aiEtIGOFhF8AfUCT@stanley.mountain>
 <aiExQzpIOwPgwd3-@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiExQzpIOwPgwd3-@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 11:03:15AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 04, 2026 at 10:45:36AM +0300, Dan Carpenter wrote:
> > On Thu, Jun 04, 2026 at 10:30:34AM +0300, Andy Shevchenko wrote:
> > > On Tue, May 26, 2026 at 07:19:46PM +0100, Jonathan Cameron wrote:
> > > > On Mon, 25 May 2026 08:20:31 -0500
> > > > Maxwell Doose <m32285159@gmail.com> wrote:
> > > > > On Mon, May 25, 2026 at 2:17 AM Dan Carpenter <error27@gmail.com> wrote:
> > > > > >
> > > > > > If the *ppos value is non-zero then simple_write_to_buffer() will not
> > > > > > initialize the start of the buf[] buffer.  Non-zero ppos values aren't
> > > > > > going to work at all.  Check for that at the start of the function and
> > > > > > return -EINVAL.
> > > > > 
> > > > > Commit message is incorrect, it looks like you're returning -ENOSPC here...
> > > > Tweaked and applied to the fixes-togreg branch of iio.git + marked for stable.
> > > 
> > > I was stumbled over these patches by Dan. Since the file_operations for the code
> > > in question do not define .llseek, the seek is not supported and will return
> > > -ESPIPE. I'm not sure why we have these patches to begin with. Dan, can you
> > > elaborate on the case where the *ppos is not 0, please?
> 
> > The simple_write_to_buffer() will update *ppos so partial writes are
> > supported in that way.
> 
> Can you show the step-by-step scenario? I'm still fail to see how it may be happen.
> Is it somewhere inside the kernel loop? Which VFS function(s) is responsible for
> that in such a case?

Even if ppos is advanced, the simple_write_to_buffer()
https://elixir.bootlin.com/linux/v7.1-rc6/source/fs/libfs.c#L1188
won't write more than available in the buffer. Is the available also
being advanced somehow?

-- 
With Best Regards,
Andy Shevchenko


