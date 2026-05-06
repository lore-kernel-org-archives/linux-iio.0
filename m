Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286C19DF6A;
	Wed,  6 May 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060237; cv=none; b=Co5kGrG/oTLU0qI4C8N6Rs6AQig0Ppfdi1Qn6qk9rz+iVD7iiExUXmVhv1W5aiFLvd7otxi9n+yJUwoFuFNA3Iv4GTsL6tPCKemqUxz4uYgfhQhYFrfUweBFoCXUFcY/DEkBHB/fuClrzkF51FUHF/IyzpuVjlxNYuX7yxBrfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060237; c=relaxed/simple;
	bh=D+SONsRKaJJ+YAPphJThdhdgAu2JHnvmL7T4I7EcbVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upEgEwDWeUxtRnrIx7EiXzLxKJJPRlL4vR0Tp3EzS/NIHSUPDBsUWpSWOe0jvxwmUH4tClPneG5D5Ul8HGNRdGWCpUFt1iZbkDZUT8xJM1cftR224Vh/Jdr5ct3RQND8D1heIABkwLfKTX5I3VSiWk7sxitnrrA7cV3O4VTLdkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1jjscSA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1jjscSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778060236; x=1809596236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D+SONsRKaJJ+YAPphJThdhdgAu2JHnvmL7T4I7EcbVQ=;
  b=O1jjscSA9irlgFlHU5q5XqHWfZ/Oz1G2us/5OTqqHv0j8m8UyNCdxi1a
   lFGNOox7S3mJ5wXA7W/E/AbgwoK6hmsawHlAmREAn+PfeL02u9d5dZ9p0
   1+sEDyfdLnJJeciT1kJ1PDYUO0AL+QQbH8DGZeDGOkepoD98DZav8OY1F
   dCDCkfaWW2O1Npam9RdPpkMyiQtC6lWk6/4g53pBSUcAkN0J1+gKW2Uz5
   Dybcp/LcuOdbpBrjp2pAGylfkAmGBHEmBsHRv3DaYSv7k3J4AbSFjEY1Z
   K591QQlU7Xpu4CWLq77ccxFlTt4NhOa2qRopIENrRVY5xYdqd/8a38UWu
   w==;
X-CSE-ConnectionGUID: ZlP1eOz3SOO9cfcGljW6dA==
X-CSE-MsgGUID: q5PjmJk0T5ugO4ejgwlV4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78008109"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78008109"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:37:15 -0700
X-CSE-ConnectionGUID: aWt/2CnqQwi6FhigT4Ii0g==
X-CSE-MsgGUID: oNMmyroBT6iIeUjlmMiDJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="229687046"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:37:12 -0700
Date: Wed, 6 May 2026 12:37:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com, martink@posteo.de,
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] iio: accel: mma8452: Use dev_err_probe()
Message-ID: <afsLxtDisDSZSvjS@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
 <20260505174640.3998281-6-sanjayembedded@gmail.com>
 <CALoEA-xhRv7UN-yp_PLAbmvz8rOksCroT2Uhx=WTk=WpRujx0w@mail.gmail.com>
 <afsITtK0oEUMcqPi@ashevche-desk.local>
 <CALoEA-z2X_sh+g9M=9jW+EBLx2c5j2U-9TYdMK03HHc52nVp-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-z2X_sh+g9M=9jW+EBLx2c5j2U-9TYdMK03HHc52nVp-w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 11:27:12AM +0200, Joshua Crofts wrote:
> On Wed, 6 May 2026 at 11:22, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, May 05, 2026 at 08:45:32PM +0200, Joshua Crofts wrote:
> > > On Tue, 5 May 2026 at 19:49, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

...

> > > >  static int mma8452_probe(struct i2c_client *client)
> > > >  {
> > > > +       struct device *dev = &client->dev;
> > >
> > > Stray change, I assume this belongs to patch 7 ("use local struct device") of
> > > your series.
> >
> > Not really. It switches to dev_err_probe() that uses it.
> 
> Perhaps I used stray change incorrectly. The series has a patch that
> adds instances of struct device, so I'm not sure why this patch is adding
> it as well.

Because it makes sense here. OTOH, we only change a couple of lines, worth
it having the temporary variable or not is a good question.

> It took me a solid minute to realize what happened when reviewing
> patch 7 of the series, I was ready to say it wouldn't compile (see my
> comment in patch 7).

Yep, but it's okay for patches that have dependencies. These two doesn't seem
like backporting material, they are in the bucket of "cleaning up the things",
which may have dependencies and it's fine.

-- 
With Best Regards,
Andy Shevchenko


