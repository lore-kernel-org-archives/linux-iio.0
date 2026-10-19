Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEC3D6663;
	Mon, 19 Oct 2026 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395788; cv=none; b=t0mK2KCDmlf7aPXrMefp4H2BBq83tjJKHXBqAVrzbwpZE2k03qTzKK57jOpRvDUca7gfazm4gZJffZ2FaGhN835dsKWGpiypqdho/QxBnp6nUSEke8qMxXXMyYmLlUQHKyKIg/+5t9xRff2EqK/Xd+vgIl+lQ86HOIYT4MiCdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395788; c=relaxed/simple;
	bh=1MEWIqY1iEmJajy/pMiPMozqoMRw6oshocyeG+HxxdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF2BRc1FcTTJ+VOgYLMNryjCO3M9bL0OGWR1hdgChPu6k5n5/J+Vjc4o7JyiC9Lg5cyz+DV0cKU1AY52MMDQfMa/i9Dsc+tk295r0CkqIDimQgHWj8U/5/t34ItEVBG6WV4McumCY0s8J1F5dn0VjViQAyf9oWZ1eOH6hQ4gOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nG1/QM9U; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nG1/QM9U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792395787; x=1823931787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1MEWIqY1iEmJajy/pMiPMozqoMRw6oshocyeG+HxxdY=;
  b=nG1/QM9U4IInlOOke1FVss/KrFdLFt1kQ2IJZlihmEh131I8Vt3yBPY5
   Jqp6u6w4q5/O28WRrN4bbAcj6y/k/0d3fomdFIcbWmsPFgBJQaE8ufp8F
   bhnWbQvZMH9aRezOC0eb0ghRehHVAC56m21WMS1EVCs+fefZqJ6TkBM/s
   IG+aew6oB4zTKGXEwECWXG01RU91WIx5aU4619BnI4U+9MCEz0AlXOaes
   OkaRSABb88MBcBqIKK/BsZkSgR9xxUO30CnUQcTK/PowvxSqlH6cse662
   OEbkE5nNEekbekinOW60C/jg7VuYHSU8nfvW5fwQ/acEqU489x+l27fjw
   g==;
X-CSE-ConnectionGUID: A1UEXPogSGuszoUEEKghgw==
X-CSE-MsgGUID: GzOW52D+RwSmC3G3CTlhfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1095299"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1095299"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:43:07 -0700
X-CSE-ConnectionGUID: KMwFm/jRS16F7rZDaAxL9w==
X-CSE-MsgGUID: 3a051f4XT/e1b3pSCj0B8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2414449"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:43:04 -0700
Date: Mon, 19 Oct 2026 10:43:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Amir Atef via B4 Relay <devnull+amiratefabdallah1122.gmail.com@kernel.org>,
	amiratefabdallah1122@gmail.com,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: frequency: ad9834: use guard(mutex)
Message-ID: <atXKBfDxumHGUh8M@ashevche-desk.local>
References: <179219435216.322.13409717511306957730.20261017-ad9834-guard-mutex-v2@gmail.com>
 <20261017205454.0dda6c10@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017205454.0dda6c10@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 17, 2026 at 08:54:54PM +0100, Jonathan Cameron wrote:
> On Sat, 17 Oct 2026 02:45:52 +0300
> Amir Atef via B4 Relay <devnull+amiratefabdallah1122.gmail.com@kernel.org> wrote:

...

> >  		ret = spi_sync(st->spi, &st->msg);
> 
> I'd rather see all error handled at point where they originate, rather
> than only some (with special case for the last call) so here and similar places, do 
> 		if (ret)
> 			return ret;
> 
> 		break;
> 
> Or you could even do a return len; here if you prefer.

I'm definitely against this. return len is a common non-error case, that's
better to be at one place.

> >  		break;
> >  	default:
> > -		ret = -ENODEV;
> > +		return -ENODEV;
> >  	}
> > -	mutex_unlock(&st->lock);
> >  
> >  	return ret ? ret : len;

So, if got the above way, use

	return len;

here at the end, and 'break;' statements in the respective cases.

-- 
With Best Regards,
Andy Shevchenko


