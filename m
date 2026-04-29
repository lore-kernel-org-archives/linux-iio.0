Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA30363C57;
	Wed, 29 Apr 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473251; cv=none; b=TJhndXs+jHsZDe+MEF6bGN4EjrnvKT1ZKQlyBJx3p8TyW6aTEzeTSMematZlJvOnbcAXaP/Q55yGwWqV/XJHLT1ivx4UPtEN7hXQs2M4DoRwtQEsNvEt9mTVrZsSaDhjKiV5WMIjkhpI60HfNQMeR936C7k7Kn6mG5vb1DZkFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473251; c=relaxed/simple;
	bh=qyVBnY8z/zjbAcchxDgR10vjueK3OWFrLYAzjSDxpuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnScoIEw5HnkgQe7pob1jawt9sAgr2pfpswb1iVEwirkaOvmZiGpKMlbFmg4M8GYXdSozjVG2pBfisXrSzVFDWbw8N5nLnQXG3JgJF0dwC3MYrxkRiIerAo7qEjG1maoVzEAapR+EXttKDFR9rZW7mX2ovWzivjOkFQg2w9pl7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1xlG1lu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1xlG1lu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777473250; x=1809009250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qyVBnY8z/zjbAcchxDgR10vjueK3OWFrLYAzjSDxpuw=;
  b=N1xlG1luDySCM0C4lolLTd68dKjZ9NYbOfhVtQzs52vjMSGjQEvLUsB+
   Lxvv/yQnYdqQ9B+iu7OCZgWk+NJ+jwysbZlmv4vO4s0PgNiy8hN+RYpaT
   ZeGMYE5v5F3E+liQjvsQeOMQKT10DnCgmj6Qo53PzyHfnzyGIqgwdBUNH
   iuJUj9LtY4TVLd9ePhFm5STAKl7MvrxUEg3TWJzXDEE1XTADfccvlwEhg
   FRyQgkxhz+4v0jTCevyE1mYSr/Gypg8U6CcYfNAGjQ6tUNbTACz/7zhGI
   htiIqnfLjyLYYvWsnSvQCH6touPzs8aSvmhiI3q28ySluR7Q9RTcJ1YgR
   Q==;
X-CSE-ConnectionGUID: ZW/JKSjbT86iQ/Y4YX0Eag==
X-CSE-MsgGUID: RCx9HxDWREqM3zhwmOe48Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82266690"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="82266690"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:34:09 -0700
X-CSE-ConnectionGUID: yGW2H58LRBO40zLgeNTrUQ==
X-CSE-MsgGUID: w1HV8WBZS4aNQhfgT3hRbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="238247898"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:34:08 -0700
Date: Wed, 29 Apr 2026 17:34:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 10/14] iio: magnetometer: ak8975: switch to using
 managed resources
Message-ID: <afIW3HuMVrmh6Jhm@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260427201412.3067235-11-andriy.shevchenko@linux.intel.com>
 <20260428173256.25a64370@jic23-huawei>
 <CALoEA-x5aQNs74QDRV6iQjRWQ==wVAtVGikNyCGKQMD=hkiejA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-x5aQNs74QDRV6iQjRWQ==wVAtVGikNyCGKQMD=hkiejA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 03:48:52PM +0200, Joshua Crofts wrote:
> On Tue, 28 Apr 2026 at 18:33, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 27 Apr 2026 22:09:55 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

This is combined reply to both of you.

...

> > One day I'll have time to write up some notes on patterns that work
> > for runtime pm + devm. I don't think think this one does - note original
> > code didn't work either as would underflow on regulators in some paths
> > and hence print warnings.

> > > +static void devm_ak8975_power_off(void *data)
> > > +{
> > > +     ak8975_set_mode(data, POWER_DOWN);
> >
> > Add a comment somewhere appropriate on what we are undoing with this.
> >
> > It's a 'might not be runtime suspended' at time of remove I think
> > rather than the mode being set at that point in probe.
> >
> > If it is suspended, we shouldn't call the regulator disables
> > in power_off.  So maybe gate this whole thing on
> > whether runtime suspended.  If you do that be careful with what
> > state we are in until runtime PM is enabled.  Maybe you already have that
> > covered elsewhere.
> 
> Okay, I'll add a pm_runtime_status_suspended() check here.

Also check for the DPM_FLAG_SMART_SUSPEND and others first.  They might
be helpful.

> > > +     ak8975_power_off(data);
> > > +}

Hmm... I thought that we have the device is on (unless SMART_SUSPEND is
provided) during removal stage. But I think you are referring to the case
when we call this one on the already suspended device (which is probably
happens before managed resource tear down) and hence regulators will go
into unbalanced state. Yeah, it would be nice to read some howto:s on
the topic...

> > If following comments above and below you'd need to set the state
> > to active here.  If you go that way, make sure to add a comment to
> > say why it is up here (and hopefully prevent someone thinking they can
> > move it down).
> 
> I'll make sure to write a comment warning others about moving the function call.
> 
> > > +     ret = devm_add_action_or_reset(dev, devm_ak8975_power_off, data);
> > > +     if (ret)
> > > +             return ret;

Oh, true. Before accessing the device we should know what is the state of PM.


> > >       /* Enable runtime PM */
> > > -     pm_runtime_get_noresume(&client->dev);
> > > -     pm_runtime_set_active(&client->dev);
> > > -     pm_runtime_enable(&client->dev);
> > > +     ret = devm_pm_runtime_set_active_enabled(dev);
> >
> > This hits the race with whether we can query if the device is disabled mentioned
> > above. Dance where we need to be able to check that before we turn runtime pm on
> > so that we can correctly do regulator disables if we error out before here.
> 
> So just do a devm_pm_runtime_enable() instead?

This needs to be thought through...

Jonathan, do we have already examples in IIO which do something similar
in the correct way?

-- 
With Best Regards,
Andy Shevchenko


