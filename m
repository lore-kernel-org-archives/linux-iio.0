Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FD4C9010;
	Wed, 13 May 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689995; cv=none; b=ECNelDnVEfhNF4F5998TdBYcnFwKDHxPAfZ+5AleoVe0ZQG8dEcoKEg/zyy1F7snVn7XS8Xz8Ih/EZnJuh3Q69LDaxQpixZX52m4BR2HFolwub5dtAHYI/tA5iREvh6+Rh4vxixtTCxWVJZHzuuNxamXek7Qc/kiBrWWpM/KPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689995; c=relaxed/simple;
	bh=mxunz4MW4jpV0tnx2WxY4zq+7/dKM9doGoR6j21ebWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4BfHJuHG8OuknpLnm2efZ2zSHeeNGYx99u7ggUjoWu+0d7dcn14Zkua7Pza6fg/lgXMGWNYKLZgukfbwPZPivIuKdVZynh1bLaU1OXujvK2ai6fsCi5crNzsO7yifAJQYuTa3oRoMEnq3wPvFeL7JjYi9MNU68nxlqMHkx9rpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwXljY4L; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwXljY4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778689994; x=1810225994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mxunz4MW4jpV0tnx2WxY4zq+7/dKM9doGoR6j21ebWk=;
  b=lwXljY4LdhuF3yOTANt7wUEuVPB0DUxMh8MyFl4XHW1Gqu8w1sY1vW12
   QlkzHlR1P0FUYPxjYKALHxCoAIckJ2FLBqfazBJgSj56aJx3jI6HHGbl9
   7eU+wtKJHejmVdpor+zdin2s5E9k3Sj0vuw3gY/kfaTpJtuKTVeLUjqYA
   WCopAFOG5Vr8N5ezLEsgDGUVVaTCM0JvxN3AsXx+/8AC10BJZweTl8Hpc
   Kyx8oWpzYFKSpM9h8bu+SjpEsjeABkAGOhnkABr6Mr30GYkm6N1tj3ePV
   bJ48kLd2gSoHtG2EHlk8PHzGxP3/xgMITTek4EjcUSrlGplGSmFUYdHcZ
   Q==;
X-CSE-ConnectionGUID: JtjBHlGYQKiw+GJVXT+EWA==
X-CSE-MsgGUID: neTSdshsRf6OEAK7q6jPrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79655255"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79655255"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:33:13 -0700
X-CSE-ConnectionGUID: cln8ptfhThm2BjuBchjTKw==
X-CSE-MsgGUID: SmElSIkuTGaOB115ogmSug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="242478605"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:33:12 -0700
Date: Wed, 13 May 2026 19:33:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
Message-ID: <agSnxdJH_0evb0eM@ashevche-desk.local>
References: <20260513020654.168071-1-m32285159@gmail.com>
 <agR4OExvzbhCNsjk@ashevche-desk.local>
 <DIHMOLAPN64W.1W0OU35JH5SLJ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIHMOLAPN64W.1W0OU35JH5SLJ@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 09:45:12AM -0500, Maxwell Doose wrote:
> On Wed May 13, 2026 at 8:10 AM CDT, Andy Shevchenko wrote:
> > On Tue, May 12, 2026 at 09:06:54PM -0500, Maxwell Doose wrote:
> >> Include linux/cleanup.h to take advantage of new macros.
> >> 
> >> Replace manual mutex_lock() and mutex_unlock() calls across the file
> >> with guard(mutex)() and scoped_guard() where appropriate to simplify
> >> error paths and eliminate manual locking calls.
> >> 
> >> Add new helper function kmx61_read_for_each_active_channel() to mitigate
> >> certain style issues and to prevent notifying that the IRQ is finished
> >> whilst holding the lock.
> >> 
> >> Update certain returns, and add default case to return -EINVAL in
> >> kmx61_read_raw().
> >> 
> >> Remove now-redundant gotos and ret variables, as the new RAII macros
> >> make them unneeded.
> >
> > Have you used --histogram algo when prepared patch? Please, do it, if
> > not yet. It might improve the diff itself and hence makes reviewers a bit
> > more happier.
> 
> I *think* I used --histogram, I'm not sure what happened :/

I haven't checked myself, it's just my feeling that it's missed, but if it's
the result, than it means we have the best possible representation.

-- 
With Best Regards,
Andy Shevchenko


