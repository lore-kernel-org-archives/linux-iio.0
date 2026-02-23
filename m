Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13C275AE4;
	Mon, 23 Feb 2026 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836358; cv=none; b=HGCP/VLE/mhw84STER2BhMPozPVCYDLVwoLq0a+55W0jAu6nfiQ1F5n3BSehiEf2KV8PNkApVGGJyl0GwPHQSibR7H9nDtkiEf9p6jGvlYmpXA7jOIU+QU57gYKQVqZyElUt6E2LbC9/tot6+m/uw5jJaP3I+KzfsMSghfqCLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836358; c=relaxed/simple;
	bh=TdBg/QLlZHVi+4kXOp9uwPw2/1rT6BHnzdGB82m3m58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atC57xljWK+osuduiD4Rx+ZzgrhUITCbDl0wzj0wWoNfNQKB1dqp2mrXzHN9KA8wa9pZVWyXmcdUY6W3C2IZ79yn7RWOgs+JxezGSpgQeAJtI1Pjzs48R7icPqjv4JGVzt8iSu1LpHlB8vPdMk6RU2e10puauONYolxPFJs62PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3JoohH5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3JoohH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771836357; x=1803372357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TdBg/QLlZHVi+4kXOp9uwPw2/1rT6BHnzdGB82m3m58=;
  b=B3JoohH5FCtWEFrwo/bsR7BSYn0Y1JsqEtMcTxD1eal+Nya0PLr2SdoF
   kpN4SvbqeCGlxO+v02WPOWfd8EeRpEjS5PusyE0SxNfHOW2OPzNxudv75
   Yw6ic4Xhry4+uumZ5Loe1nsVdiDg3MveSwXVRT9QvtkQ5w9dBTWXCi5G/
   t2/1NxjOAoTmTPW2kzj3NOAjg0Y/BjuRaHC4Kv1YZNlBPF/MvaIysTEFR
   TP8SosCsbv4fYpuuvah+nOAQgDedyfKXQzEtwZxI0YKHENHGbXmR16Pn5
   VaB3W+g8HLe3qIiNrxCh+QBqoG1T8FMsdaXltx0rfRvxqrXjAoVQKhVfX
   Q==;
X-CSE-ConnectionGUID: xSWLe4y5SoqMiknJXTPezw==
X-CSE-MsgGUID: 51ZfJf2ITMSd56CP9LaODg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72530587"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72530587"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:45:57 -0800
X-CSE-ConnectionGUID: b+oMMMxOS8CZd3NzrAHmEg==
X-CSE-MsgGUID: bB4UROmDRLaKglvIgtVmfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215632967"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:45:53 -0800
Date: Mon, 23 Feb 2026 10:45:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check
 spi_get_device_match_data()"
Message-ID: <aZwTv3rB89km7rEI@smile.fi.intel.com>
References: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
 <aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
 <aZSD-3WIVwT6XYWX@smile.fi.intel.com>
 <a823c9b72fcc3b1d88ff9dd93580be6241826153.camel@gmail.com>
 <aZWI-80-K7xfuEBY@smile.fi.intel.com>
 <20260218095820.00005750@huawei.com>
 <20260220105507.30a2f7ec@jic23-huawei>
 <aZg_4KQ6hDqBeSJw@smile.fi.intel.com>
 <20260222132246.6447d539@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222132246.6447d539@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 22, 2026 at 01:22:46PM +0000, Jonathan Cameron wrote:
> On Fri, 20 Feb 2026 13:05:04 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Feb 20, 2026 at 10:55:07AM +0000, Jonathan Cameron wrote:
> > > On Wed, 18 Feb 2026 09:58:20 +0000
> > > Jonathan Cameron <jonathan.cameron@huawei.com> wrote:  

...

> > > Applied.  I also added a link tag to this thread, to say we had
> > > agreed to make it policy in IIO to not have these checks.  
> > 
> > Thanks!
> > 
> > Do we still need a process/maintainer-iio.rst?
> Yes. Been meaning to start drawing one up for a long time but
> there is always something else that takes higher priority :(
> 
> If you want to propose something as a straw man that would be great!

Taking into account my constant lack of time and not being a native
speaker I would like somebody else to draft a skeleton. I would be
happy to throw ideas how to amend and/or extend it.

OTOH, somebody like David, knowing more about depth of the IIO and
the style can also draft if he feels like doing it. David?

At least, existence of that document drops quite a burden of repeating
something which can only be scrapped now from the ML archives and
IIO existing drivers (taking the date of pulling it in the upstream,
the newer the better).

-- 
With Best Regards,
Andy Shevchenko


