Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F2D3F20E7;
	Tue, 30 Jun 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820582; cv=none; b=GetNaTovRAS1elZHpdSiQBGNPgzxK+/5+Gd5EniW+sJ918gXdAYlaORQcoGt1amU+lBTRacfnboEPHGak8rrE2NUd0TOT1N50Dfg+AzVfIg0MjVSkVa2ZkTpDXIV0PGCmD1SpWMw+Nm3GaOfWkQgtg6HPBmAhXMhRQeGwaYrPCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820582; c=relaxed/simple;
	bh=akHXz8SqMo1P30MsFdy4bQn/F7nC4aKuZCLZeDpg0Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi0xkeab3rXOpbtxBqjvi5d6uikeIR1qj0WrX/2dpc6W8P/qN6BReKpn6U9bSaF0956kno17WRV7Bo00Z7bV0T662bN1spwqsxQQXG9emc6jcyOvxagowTnN1kkW9WNkUoINUMU6IeOyIXP00rpyoXQ2GhLOEonYccM36laPtLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Az9jMOQi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Az9jMOQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782820581; x=1814356581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=akHXz8SqMo1P30MsFdy4bQn/F7nC4aKuZCLZeDpg0Tw=;
  b=Az9jMOQiJ1cFdTr5M0TvPgZv9EDsEUqFRDAL/VNautbCH0HzjzbPjXVu
   UbXv+EN6Gk/hbMedt+9xREOtWfhv8nNBUZiUcLBqjagnka6jenSzoC5YL
   6tDSDFrAVyxVW3fk5jSDu0beFmTWdlX8tCDBvbhndLqlAzK0Ou1sN3ow2
   iQNGFL2P1WtyclCmJ3x53YNJ3HKzNzuriVJ4tV3w6sfgBjpxjAtZ8DDd0
   6vjn0IAw6xZY/QS6k+Uod/1GnYX6ch12I3TjLeGO/nKXz0+Czok4aM7Pu
   0VxIh8KhQ8O2j1nRY35czjwOD1Jb9kUltuM6s+Hu8Gwjq58qkkK/fpoEp
   g==;
X-CSE-ConnectionGUID: 3b+uT5j4Rx6kCMSAtVnp4g==
X-CSE-MsgGUID: KRNMb9dTTpm2/QQux1qwAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="95036721"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="95036721"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 04:56:21 -0700
X-CSE-ConnectionGUID: MwUPi+6pS8Cq1G9RVUlGNQ==
X-CSE-MsgGUID: TuRbyUU5Q/68vrOwhx8OPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="256166706"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 04:56:16 -0700
Date: Tue, 30 Jun 2026 14:56:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Jinseob <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v6 4/5] iio: osf: add authenticated stream parser
Message-ID: <akOu3mXLvJa06CoO@ashevche-desk.local>
References: <20260628191337.937-1-kimjinseob88@gmail.com>
 <20260628191337.937-5-kimjinseob88@gmail.com>
 <akJ818gkVzLN7HqU@ashevche-desk.local>
 <20260630000623.0c030d5f@jic23-huawei>
 <CALMSewJo-tnQL9KRyvABHpAf0-k=yOd1N=JzgK91rk0R0j_CBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMSewJo-tnQL9KRyvABHpAf0-k=yOd1N=JzgK91rk0R0j_CBA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 02:12:06PM +0900, Kim Jinseob wrote:

And do not top-post!

> Understood. I missed applying the earlier style feedback consistently
> across this file, and I should have explicitly replied where a previous
> comment was not addressed.
> 
> I will these:
> - reuse the existing OSF magic definition instead of duplicating a byte array
>   in the stream parser;
> - use loop-local variables where the variable is not used outside the loop;
> - rework the stream error handling so authenticated and unauthenticated
>   failures are handled deliberately;
> - either update partial_frames where appropriate or remove the unused
>   statistic.
> 
> I will also check lore for the previous versions and track the earlier review
> comments before posting another revision, making sure each one is either
> addressed in code or explicitly answered.

...

> > > Come again when each of the given comment will be either addressed or argued.
> > >
> > Likewise.  Please make sure to address every comment either through
> > changes or through reply to the earlier thread.  Perhaps some emails
> > have gone astray (it happens!). It can be a good idea to take a quick
> > look at lore.kernel.org to make sure you aren't missing any feedback
> > on a previous version.

-- 
With Best Regards,
Andy Shevchenko


