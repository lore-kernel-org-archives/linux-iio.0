Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B872DFA5B
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776671083; cv=none; b=a2zNhOzn61fvTpAmtQYnCzzRmHLouVQpl1m8FcfpClAE+H3OpwDL3XA4sP0PFhSdcRht/vhA52CgA6MH+yQ+27KuiaF61cfgXuVL5RVHZYNWa7rnTAwAx9GXqB2wBM85L/V3bPSHdo9FTxgOSQpAeHZr07PrBb4gT3qcts6sVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776671083; c=relaxed/simple;
	bh=qY5sW6mUoQ6mXDMe+8oxrEAAUyMHH9ftl+9VSHLKkC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4hVL+p8f4TBiGTg8T5VWs0AAYTGmRJK8o0GQXfRpUrDQ1HrS1VJPlVwrl4RlXqIoGWmvYK/J8zbhNMePO9EkPN8sjneRy+yKWwVBz8Ok76pU9MV+1/E1yS5AFuu+P9E6Kf6FgJstI40fPk4o+bdBuQnyPzH/0QfpqEUgm+BpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1Cyg9mg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1Cyg9mg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776671081; x=1808207081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qY5sW6mUoQ6mXDMe+8oxrEAAUyMHH9ftl+9VSHLKkC8=;
  b=R1Cyg9mgXPZRhxGjoVNszEI/VVYdSN7SwPhXvpr5hw5MYcCujg5fuihs
   OYd+aVY0VW22Wi7m3WotDqyrNubRAfYgDpZ5zNAMqskiwLbEHbl8z4ym8
   8BSXuCpOHLReisA/gtMwd0QhArHjnHr9AguC4XIWsVrJmJaJ+pTY/qpoV
   +9hLKIeGMDouhhppEx7LBYMNPc5QIsMUHN+YnVWJlKBMWtmK859VsrDhi
   zsS1WgC8WGsbJonJQC1ccPPtNPu23qp6g04ryXnTI3y4YFHcqotDDCoRB
   BxWz+szQ99uhV1zlSszTBosnUmt1+H27A+HI2yDI4OA+j8cyabyFfgNZ5
   Q==;
X-CSE-ConnectionGUID: jsoVLh2xRZCCRAYm2u1MoQ==
X-CSE-MsgGUID: JuWNq+20S9u+uv9BXJxcpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77449944"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77449944"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:44:40 -0700
X-CSE-ConnectionGUID: J1kvtW9NRi6L5VL2aCX5gA==
X-CSE-MsgGUID: JbL9yCY9RzuXbxKfqGqwmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="231523266"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:44:38 -0700
Date: Mon, 20 Apr 2026 10:44:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: LucasRabaquim <lucas.rabaquim@usp.br>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org,
	Matheus Feitosa <matheus.feitosa@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: tsl2591: simplify tsl2591_persist
 functions via lookup table
Message-ID: <aeXZY2Nj71Em7Z6y@ashevche-desk.local>
References: <20260419003557.45287-1-lucas.rabaquim@usp.br>
 <20260419123604.591dc3ec@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419123604.591dc3ec@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 12:36:04PM +0100, Jonathan Cameron wrote:
> On Sat, 18 Apr 2026 21:35:43 -0300
> LucasRabaquim <lucas.rabaquim@usp.br> wrote:

> First a general process thing.  Slow down!  You might well have
> gotten more feedback on v1 if it had been on list without being
> replaced for more than a day.  I'd advise generally not sending new
> versions for at least a week so multiple reviewers have time to look
> at the changes.
> 
> In general the change looks good, but I'll leave it on list for
> a while before considering picking it up.

Indeed.

...

> > +static const struct tsl2591_persist_entry tsl2591_persist_table[] = {
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_ANY,  1  },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_2,    2  },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_3,    3  },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_5,    5  },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_10,   10 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_15,   15 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_20,   20 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_25,   25 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_30,   30 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_35,   35 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_40,   40 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_45,   45 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_50,   50 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_55,   55 },
> > +	{ TSL2591_PRST_ALS_INT_CYCLE_60,   60 },
> > +};

Instead, make this to be an index of the just an array of u8:s.

	...
	[TSL2591_PRST_ALS_INT_CYCLE_30] = 30,
	[TSL2591_PRST_ALS_INT_CYCLE_35] = 35,
	...

...

> >  static int tsl2591_persist_cycle_to_lit(const u8 als_persist)
> >  {
> > -	switch (als_persist) {
> > -	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
> > -		return 1;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_2:
> > -		return 2;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_3:
> > -		return 3;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_5:
> > -		return 5;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_10:
> > -		return 10;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_15:
> > -		return 15;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_20:
> > -		return 20;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_25:
> > -		return 25;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_30:
> > -		return 30;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_35:
> > -		return 35;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_40:
> > -		return 40;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_45:
> > -		return 45;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_50:
> > -		return 50;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_55:
> > -		return 55;
> > -	case TSL2591_PRST_ALS_INT_CYCLE_60:
> > -		return 60;
> > -	default:
> > -		return -EINVAL;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {

Besides the style of

	for (unsigned int i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {

> > +		if (als_persist == tsl2591_persist_table[i].cycle)
> > +			return tsl2591_persist_table[i].lit;
> >  	}

...this loop now not needed at all.

	if (als_persist < 1 || als_persist >= ARRAY_SIZE(tsl2591_persist_table))
		return -EINVAL;

	return tsl2591_persist_table[als_persist];

> > +	return -EINVAL;
> >  }

...

> >  static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
> >  {
> > -	switch (als_persist) {
> > -	case 1:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_ANY;
> > -	case 2:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_2;
> > -	case 3:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_3;
> > -	case 5:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_5;
> > -	case 10:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_10;
> > -	case 15:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_15;
> > -	case 20:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_20;
> > -	case 25:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_25;
> > -	case 30:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_30;
> > -	case 35:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_35;
> > -	case 40:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_40;
> > -	case 45:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_45;
> > -	case 50:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_50;
> > -	case 55:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_55;
> > -	case 60:
> > -		return TSL2591_PRST_ALS_INT_CYCLE_60;
> > -	default:
> > -		return -EINVAL;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
> > +		if (als_persist == tsl2591_persist_table[i].lit)
> > +			return tsl2591_persist_table[i].cycle;
> >  	}
> > +
> > +	return -EINVAL;
> >  }

Ditto.

-- 
With Best Regards,
Andy Shevchenko


