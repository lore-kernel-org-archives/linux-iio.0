Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30A369D72;
	Thu,  4 Jun 2026 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780606468; cv=none; b=CZYIodluTLIKBjQZNJfaTaNdQVf6Z3dnikfQtRa0GQ88zruSwJKGb39nNL7ZUzqwHTfKMwO5TeQNZn1hdnjmBCSTgDzuXkBtILS6uIkq8G7w45vUtBf7pnTRro19DIxFhyNkRxK/eLV+l9UlTFjpkMJtPaay/e6wBKm/7hf7+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780606468; c=relaxed/simple;
	bh=hTcwQ4ncLleADqyIVn8NZ1xNqhwxWJ4JZ82JrMztRhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qmdot7j3lq2hWH/Rw/U6UyaBWrv7G/DYH0h29h2J9L0qRAbPe5sHg6TCSbB5h/8U/VvY7S1vZQjqLLJYEDMzB8osULs2I33SDreefwghXYZ5R4m0wsumQZoD56EhzmTRx6TVDNyQ320+RU3jWPMmPnm7blih9WLryLURfAavP+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrtlZ483; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrtlZ483"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780606467; x=1812142467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hTcwQ4ncLleADqyIVn8NZ1xNqhwxWJ4JZ82JrMztRhE=;
  b=KrtlZ4830k1zwMdHJROIfuI1IO6W4NYq8YKNyOk9u9AdKPLJ+TCEWGsr
   M3XDz9KrNL2s1oEv6m2Jd9GEAmuiuIb6vL8yP2kB43X+tPjlNU109NwbW
   xSx5SaSGKUl9nZPep68dm7a6m4YUic7zbx8Bf/2RKSVjF6XUmJ9gO+9Rt
   gL817jBIkqbE+bzRs2a8r0CzHgEMgd7lG1vrs8C3hFsCYNRFZvxvSq+fG
   WlderuJ38lJIus8PdzzNmoIeepT6i457+lv+/tE2qd6UY0c+4q/eZudEv
   +eD0WxpC0MtJJAN4TQtGyFrzjq6joVwp27ZCYNXrwY7AC58kgjtQ/WVnU
   g==;
X-CSE-ConnectionGUID: p04xI7qqRaWU2QuMW2rzFQ==
X-CSE-MsgGUID: GzmCZfr/QxCCmts4Bm61oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91756108"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="91756108"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:54:26 -0700
X-CSE-ConnectionGUID: REyQ7+rsRfiHwl7iJwZ1iw==
X-CSE-MsgGUID: ZdQ1mZxsRMKrK4BQbUISHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="238299503"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:54:23 -0700
Date: Thu, 4 Jun 2026 23:54:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
Message-ID: <aiHl_b4fVXc5sLzX@ashevche-desk.local>
References: <20260603145134.58956-1-m32285159@gmail.com>
 <20260603174447.63a181d5@jic23-huawei>
 <CAKqfh0G4xDUh7ZR=f760yOAqYqjSLhWGw4UP8KiRM=nnZhg6BQ@mail.gmail.com>
 <aiEsnl1cwLRXrUq8@ashevche-desk.local>
 <CAKqfh0E-N0QWGkQwBknr9sV8Ryakzo+jxAMPE=ee+CQbLMjwVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0E-N0QWGkQwBknr9sV8Ryakzo+jxAMPE=ee+CQbLMjwVA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 08:20:25AM -0500, Maxwell Doose wrote:
> On Thu, Jun 4, 2026 at 2:43 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Jun 03, 2026 at 12:27:18PM -0500, Maxwell Doose wrote:
> > > On Wed, Jun 3, 2026 at 11:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > > > On Wed,  3 Jun 2026 09:51:33 -0500
> > > > Maxwell Doose <m32285159@gmail.com> wrote:

...

> > > > > +     ret = devm_mutex_init(dev, &state->lock);
> > > > > +     if (ret)
> > > > > +             return dev_err_probe(dev, ret, "Failed to init mutex\n");
> > > > The only thing it can return is -ENOMEM I think. Which doesn't print anything
> > > > so
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > is enough.
> > >
> > > If I'm not wrong (and after a quick google search), I think it also
> > > may return -EINVAL but then that means the device struct is invalid.
> >
> > What?!
> >
> 
> Then I was either misled or I'm just stupid :(
> 
> > > Still may be worth doing dev_err_probe(dev, ret, "Failed to init mutex
> > > with error %d", ret); or something along those lines. If you want I
> > > can get this out today or I can also wait for more reviewer feedback,
> > > but your recommended changes seem pretty simple. TBH though I'd still
> > > argue for the case of either dev_err_probe() or dev_warn() since not
> > > having an initialized mutex is certainly an error.
> >
> > I am on the side of dropping the message altogether. Invalid dev here is
> > nonsense. Just read the code.
> 
> All of these changes have been made in v2.

I am not sure I follow. I was specifically talking about implementation of
dev_mutex_init().

-- 
With Best Regards,
Andy Shevchenko


