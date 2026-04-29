Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03612F7AB0;
	Wed, 29 Apr 2026 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486750; cv=none; b=i88RwGWK1/6fx6w42HowS6hqb97TK0nzxTz6RMwWIUt1Jy29/0a9cG3y96dBqfG5bJU9JGvFKzyycOAazTz3sf2B3hTUH4Oj/c44L+DYwR2XTQ5I19xADQCmIMaS3lExGW4zPG+ZgF+qi4ize80fRPPudkejorftbQGe3FRJbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486750; c=relaxed/simple;
	bh=XUnfE43s1L96DK/VH0nbzoN8tn+uUaMZ4hL/OTGdZHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwxURi0BAIkVxxDHaF9pPfjT9hjrMLdKfbNUEOlxCGoNmprkjk8DiO6nf1BrFZHp78wbR/TRXojpKuFHHALJIsS3NqsWrnTmRbG9Vh7OGxMF3S8XOfwXvf4Y9kg7KLowEBY4q4p69W5YdnQ54Bm6n6UFiSdeJexbcxOhwPH9lk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCRymchL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCRymchL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777486748; x=1809022748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XUnfE43s1L96DK/VH0nbzoN8tn+uUaMZ4hL/OTGdZHg=;
  b=BCRymchLsOI+30MgHIGtz+wiGEZcbbKkQdLqZs8pXRZ+RBYd865ZVVJV
   oVg+E0T7UU6bynSZhxmt7nXpOV4/iSH2xRUkAWAjm+SsNsZEZlP3N5Q+E
   TZtSVbQmpbY3zfdUkUp63FD7d/Z5JMBel6bZxLAm/sSVellic5WVSHYba
   lXznIbMleTtVOH3RrAAoFtNjLRz68zjvFavluPCRlP7yM8yCjCTBeN57a
   mh8JcOTdnFFybduolSoHfFpUDf5MkR/NX2AK47EAzuakznjLjxkPmU4sd
   DpnoQegEMq1Pws6ksZ9sJ/n5HMeD+mATwcQZF84K7hyHnLhhTcGuMVLDj
   Q==;
X-CSE-ConnectionGUID: 5UPXjFc8StmsHnL2iXMgqg==
X-CSE-MsgGUID: Z/e2hbw2SX2U7AsbpQqvvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78533844"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78533844"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:19:08 -0700
X-CSE-ConnectionGUID: BWTbbBnKTLO051jcqc9y3Q==
X-CSE-MsgGUID: RhPgFI/QRVu+O30u0W6DHA==
X-ExtLoop1: 1
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:19:05 -0700
Date: Wed, 29 Apr 2026 21:19:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 06/13] iio: dac: ad5686: refactor include headers
Message-ID: <afJLlpsU17Pmp0uH@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com>
 <afIRG2S94JEn3Oqd@ashevche-desk.local>
 <CALoEA-yBU_pwiOFQx89-Gcgmtz_KtuxJJvph7uKPHKJNihDS8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-yBU_pwiOFQx89-Gcgmtz_KtuxJJvph7uKPHKJNihDS8Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 04:38:02PM +0200, Joshua Crofts wrote:
> On Wed, 29 Apr 2026 at 16:14, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > I haven't checked this deeply, but I hope at some point we will have
> > more or less usable state of `iwyu` tool that may do this automatically.
> > At least current result looks better than the original.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> I did find a "filter" file of sorts for IWYU that Jonathan had on the
> mailing list.
> It does a good job of omitting reports of very low level headers but at the
> same time IWYU still tells you to include things like <linux/stddef.h> and
> remove anything <asm/*>  from your includes. Perhaps it needs more
> tweaking?

You need to check that manually and then decide if we need more amendments
either in the patch or in the `iwyu` "filter" file or in both. In case of
filter file changes, please share them to Jonathan and mailing list, so other
people can adjust their work in case they use the tool.

-- 
With Best Regards,
Andy Shevchenko


