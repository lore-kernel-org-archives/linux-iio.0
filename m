Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8FF32F75B;
	Wed, 29 Apr 2026 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472490; cv=none; b=P/APFV2EHkfOa+/AK2xiFAL0e4cyz//HGHOG3wgfzSaCjHjKiE7f15qAD59yjufeEraKfVGsZMes9BHolu0EUgZ556KE3W6HaYmbVByQIey7WPBmzBVJpjEVR79oEJfbNxpWCXMXgN8fbxwdg12ikfr5fbdwnyLaQ6+C8BRY8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472490; c=relaxed/simple;
	bh=v33BJO7ZWwOsr1HSLV2hixhr4YXF/mkQdDIivn3sYn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrlgtbiOHZKQe85agtFtHNQXVEgH89s8OjUJgpsy8W6PlLCHaYzzNlt/Nwkiy/4F4sUePUrYwJHcsp5xQxDLJ/1kg6GTA6I3podKHVMS7NVNMOT+S9L3XoRxtiOi9J1LYSFZoPEYWkMoPVvPUhMlwNFp+sOfmwgp1wX6GpCJyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmWZ2j7N; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmWZ2j7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777472488; x=1809008488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v33BJO7ZWwOsr1HSLV2hixhr4YXF/mkQdDIivn3sYn8=;
  b=hmWZ2j7NbW1cU+C44S2tbHNziAd2eMFrQmlBStC2BLBhI589Bodi35JU
   nV4iypBnuRrJ0hg0HclubBRevlLf3K0WErMs7NLStH287NRou9Vo8gqmZ
   qI3l6wed4OLwb7U5ns9xRMq+/6XYAGRBsfNL6MKTVwAYqx2W+ju44BppE
   +30jzdO4dUIXy6vFysOp8yK2r2z1hhiEbmM7uw/3cIkIcHt4JJQfS8C9/
   XXkv2M8lcp81oMTEQG5Ap74rMDrlQpO10DzYOhtIe1yxUB9O+gC+oKW5G
   nWjxB8RHHAnBq0WRzdP68ynWbxxfSStd5iU0sdOEfC3s0BOlmbN6Nx0MQ
   A==;
X-CSE-ConnectionGUID: WLxgyTbYR8u9+xS0jYyssQ==
X-CSE-MsgGUID: 4uLsvS6NQh+yE3CHBORjgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="77567233"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77567233"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:21:22 -0700
X-CSE-ConnectionGUID: jDPTALwNRFuyYSRszFI9Kg==
X-CSE-MsgGUID: BSpo5bNKS+aui9dJ0HVquQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="239311967"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:21:20 -0700
Date: Wed, 29 Apr 2026 17:21:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 04/14] iio: magnetometer: ak8975: Inline timeout
 constants
Message-ID: <afIT3Uk3NdMIKlH1@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260427201412.3067235-5-andriy.shevchenko@linux.intel.com>
 <20260428172212.1e1bacd9@jic23-huawei>
 <afDpBGa3N8Dd1L6y@ashevche-desk.local>
 <CALoEA-woV6r=gOfHHXgBG82+FCG6XMBcSy0=6SUiryCS9woh+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-woV6r=gOfHHXgBG82+FCG6XMBcSy0=6SUiryCS9woh+w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 03:59:11PM +0200, Joshua Crofts wrote:
> On Tue, 28 Apr 2026 at 19:06, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Apr 28, 2026 at 05:22:12PM +0100, Jonathan Cameron wrote:
> > > On Mon, 27 Apr 2026 22:09:49 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > > >     /* Wait for the conversion to complete. */
> > > >     ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> > > > -                           AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> > > > -                           AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC,
> > > > +                           10 * USEC_PER_MSEC, 500 * USEC_PER_MSEC,
> > >
> > > I'm not that keen on these being repeated in two places given they take the same values.
> > > Perhaps we should push them up to the caller?  That is, add them as
> > > parameters of wait_completion_complete_gpio() and wait_completion_polled()
> > >
> > > I don't mind if we have them hard coded into those two calls as they are right next
> > > to each other so it should be obvious they values are the same.
> > >
> > > Ideally I'd like to see a comment on why these numbers next to those calls.
> > >
> > > Fine to pass them in msecs and do the scaling here.  Just name the variables to
> > > make that clear.  poll_msecs timeout_msecs maybe?
> >
> > I think we are fine with _ms, so poll_ms, timeout_ms.
> >
> > For the completeness we may also give a timeout_ms to the third one
> > (and convert it to jiffies there).
> 
> Simple enough, however should I do this as a separate patch or
> just a fixup into this one?

I am not sure, but since Jonathan doesn't like the numbers be copied and split
far from each other, I think the fixup sounds better. The commit message needs
to be amended accordingly.

-- 
With Best Regards,
Andy Shevchenko


