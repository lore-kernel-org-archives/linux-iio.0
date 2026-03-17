Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732A3A6F1E;
	Tue, 17 Mar 2026 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744215; cv=none; b=sgb6/KTtCd+e+wSRsJamSslvMk3ePyeU1DvmgAAOB5h5lSrQIFrTCPUccf0n0+i+M1o+lfHYu+bmZdvdSRYIZ+SqrTIy4BdalK/Lmmc8bX0IrEUhSCKcGxkTzqb31Lf+/tHf25ZcSOnmUxKrn0azHxhtwT+NN8u12eeSc9MQpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744215; c=relaxed/simple;
	bh=6FdHlQFrwR4c8Ja2fUIysHsxFeBq9+NT4YfB6VEXTR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7gRH0jVLgKP6t5nhNBnYqa3Kk+svzu4lHtixASlIgQIVQan5NHLShEytAgr2uGhEmNLApI1Iwe8qea1bFRAuf5hGyHER5ycezWEBoubUkgjFF8Q/uQZhBk97xrGFly/rxt7krH4zDKri67jnO+0drovWqZHA4R6QWfP4OPnqC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fc0jEXmH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fc0jEXmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773744213; x=1805280213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6FdHlQFrwR4c8Ja2fUIysHsxFeBq9+NT4YfB6VEXTR4=;
  b=fc0jEXmHrLWtxyZDeKx9jJW2A40iG9n63yc2Ykt1suhlMBK7Yy3Ckf66
   m33PflhJqXVBGGbnnkx6M8K926iWLy55okAiYJiTqay5a9ciz3RuoDeTw
   K/Q1goixRYs0js+SsrDd0ENS8AgC7EDiCcKG/g/VOhAkE0aF/Qeh1dQmQ
   JuYTHD6hnRxPwFX4ggz4BJOorP3JFRDDyiALgvS0Is99g0z6Awf9uZkgK
   ALOn95rg2x3QJtr+B1EgKqm/kqLS47atKoXcV9j7fT9XpOxK/iBUTS0I/
   ++qq2lLLDESb9NAq1UlbzS5zrOMr1otgLMkPuoqpG01gtqM8ya9wT55DA
   g==;
X-CSE-ConnectionGUID: MuScCdJrTVO6qjj3yXd7nA==
X-CSE-MsgGUID: jFLEH5dVQ3uIHh8XmQSmfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="77382090"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="77382090"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:43:32 -0700
X-CSE-ConnectionGUID: 66rNbHKVS7uNc7s7xwX3iw==
X-CSE-MsgGUID: EmOr9u7nQmSqU09/FRkleA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221456042"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:42:11 -0700
Date: Tue, 17 Mar 2026 12:42:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7191: Don't check for specific errors
 when parsing properties
Message-ID: <abkv_76b1cue1bGK@ashevche-desk.local>
References: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com>
 <c59c19d923d369eac2a0a46405e13e41836591c2.camel@gmail.com>
 <CAHp75VcpuxP=3cGuVrJoSuirQ3vPNR9LLWkf5CyaGcghJ2hzag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcpuxP=3cGuVrJoSuirQ3vPNR9LLWkf5CyaGcghJ2hzag@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 12:33:28PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 20, 2026 at 12:04 PM Nuno Sá <noname.nuno@gmail.com> wrote:
> > On Thu, 2026-02-19 at 15:39 +0100, Andy Shevchenko wrote:
> > > Instead of checking for the specific error codes (that can be considered
> > > a layering violation to some extent) check for the property existence first
> > > and then either parse it, or apply a default value.
> >
> > Not really sure how I feel about this one. Checking for specific errors is a very common
> > pattern and this change just makes it we check for the property presence twice. That said,
> > this makes it more "future proof" (though I find it very unlikely for ret value o change).
> 
> I already have an answer to this:
> https://lore.kernel.org/r/aZcenabXYsOdBu84@smile.fi.intel.com

Does it help?

> > Anyways, even if we choose to go down this route, I don't see much benefit in starting
> > converting the drivers with the pattern below (which should be a considerable number).
> 
> There is not a big number of them, so I prefer to have common patterns
> without exact error code checks.

-- 
With Best Regards,
Andy Shevchenko


