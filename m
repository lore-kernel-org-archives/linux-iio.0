Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495033263E;
	Tue,  2 Jun 2026 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391754; cv=none; b=YaJMg4MfKhVEgiKbdc7W8lXbWCL92TvEtaOv1/gWBv4+yW1RWxV8juAbEKTt346JObb2qODMxutb2WrAf9sAXX6xNkMz3hveGn6gHET7ljfU+QFJJspM/03EmrzhO5zqP2m43FNGXGNLjyjmtLrZAeAWtX2Ubx/ZNRQvcqnOees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391754; c=relaxed/simple;
	bh=ziG4VcaKXikTawSzaKlhMQsnCBS05ptE2hKHZaXwikM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjL1eOSIMzR8qY+ie4sa0OSzlsTrAbmLIjg9JhpeGSGYe6Q/Tb8GbC9DFqM/Ln5HUTpiSFfmtIZuezUIOWsJlIpCPMmLa8BB2OHlkDCj4/lFFYchEo9X0Dz3HT9FA78bgTw8dT+s7x6e5CRnnL3p4VN5wvnTnpEccyF9pFCBJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIOfEME7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIOfEME7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780391753; x=1811927753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ziG4VcaKXikTawSzaKlhMQsnCBS05ptE2hKHZaXwikM=;
  b=fIOfEME7s1UK4cdA7MBkgBRycC4dYOgkh/Yscj7Y+Ky+r2zL7+Bwg7K7
   HEC51JnT3XiWN/EFes9mGb+M5fLFoYF8ISnULLUNYdZOBNoEtNQZwbtNh
   RP9z9lp78s30WxrK5Y6aYUuKASGnNa8qNFuHgkny8+CSF4a8SBof5UL0s
   BuwcnyLaqA1QGcgxddwmPOHwIjgQHMtl6/yfKKO8t1DBuOvW5X5mMdsjd
   1M34u9ph9CnM7gEbZ+yl06lIAZhLBnMroOs73bC5Pd7OCnxpNoRQvCu4t
   qZq9NC0DzHv+uyJVKnSO56EyC3xL/VHsUjnjHi0qoWVUInytCAynkY7jx
   w==;
X-CSE-ConnectionGUID: TCQFvx7ERYmyIEdHYUKu6A==
X-CSE-MsgGUID: xCzH+XXLSJe5EdLfSMxSEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81164413"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81164413"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:15:51 -0700
X-CSE-ConnectionGUID: q3ipDNbxQNe4YXLmSWT5vA==
X-CSE-MsgGUID: 9qyL47/0Qb2lqOXuJbI06A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="245660382"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:15:48 -0700
Date: Tue, 2 Jun 2026 12:15:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: Re: [PATCH v6] iio: chemical: scd30: Replace manual locking with
 RAII locking
Message-ID: <ah6fQk2rOTDgBrYj@ashevche-desk.local>
References: <20260531233828.60697-1-m32285159@gmail.com>
 <e0a07428-9931-42d5-8b29-f92806ec39a9@web.de>
 <20260601115234.36867d97@linuxescape>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601115234.36867d97@linuxescape>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 01, 2026 at 11:52:34AM -0500, Maxwell Doose wrote:
> On Mon, 1 Jun 2026 17:38:44 +0200
> Markus Elfring <Markus.Elfring@web.de> wrote:

…

> > > -	mutex_lock(&state->lock);
> > > -	ret = scd30_command_read(state, CMD_ASC, &val);
> > > -	mutex_unlock(&state->lock);
> > > +	guard(mutex)(&state->lock);
> > >  
> > > -	return ret ?: sysfs_emit(buf, "%d\n", val);  
> > …
> > 
> > How do you think about to preserve lock scopes by using scoped_guard() calls?
> 
> Generally scoped_guard() (at least in my experience in iio) is frowned
> upon because of the hidden for loop that can make normal things (e.g.,
> break, continue) really weird, plus guard()() with {} is also (in my
> experience) more popular over scoped_guard(). In the past helpers have
> also been liked over both as well.

This is a slow path and printing under the lock can actually narrow the window
for value to change which means that it increases the chance the user gets
actual value and not the stale one.

-- 
With Best Regards,
Andy Shevchenko


