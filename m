Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E173ED5C5;
	Fri, 14 Aug 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697467; cv=none; b=kJAp/zpzafHvenm/9fTEi/mqRlnqjBcVNg7IwekBqT6tIBtO52BD91tKV7fUVz5LMKcIDHoB/tzHHoEhVPujss+ZT4rq+D4mvvO+zMcBI+wy/H6vYoEmOemU7SqXdfPBfUlu3xZq7HgLPW5zUuhTGZDG7ty4BbMjy0fX6Uj76Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697467; c=relaxed/simple;
	bh=SsR2yLOdKhhePkqoloa2LcvFipGNBQ1psgwCNuP/2jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiciSrUxx5avEw/+jCvFVN2eHLMKPTcoag+eHMmMBPpGcHVazN6BKHgw+iZKk2NOBwQaEMILz0GBJYKo7xpvgx5A43Tz1Ep0yfsxcTqeUSSf1q3r6akSsTTiTpkCEvfkPer5Vrh4bQa/eiywNDEYQ/cWL6nQpU6Vx0XEVNtp4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfatAFAt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfatAFAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786697464; x=1818233464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SsR2yLOdKhhePkqoloa2LcvFipGNBQ1psgwCNuP/2jY=;
  b=DfatAFAthpx96NcSjjgjWv/kacykCKH3QyhinE+D+19swiznCJRg9OIk
   jse6gNxRn/PVoFN7wtQVUOaActGjPTMuEG+TcDtWzef8VqqFUAmoeL5lh
   zzR5bvsTz++lnjP9wVpcr6RXCiMkUt3CHSTU9vXTN4/0eDF9uT5I/wAWC
   QFTyCBHg2Lkodws/iIPL6x8RFXCOPK/0tVBI7hYojaGf+6fc9c7ZWVszG
   8HENpe+JWIcEMwsgMSFt+cD876VWA0csCTuP2qsdqwS24DFv/8HgxBVmq
   67Wvx3FhjGUqnyWpm0+Eck/w1ZE3/tig375ULI8xR6I/eNisn2JWxYb+w
   g==;
X-CSE-ConnectionGUID: kTCfCHAiQEK2JgngX+os3Q==
X-CSE-MsgGUID: /Bp0t5JhQIGoawRhLpHsWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87494075"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87494075"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:51:02 -0700
X-CSE-ConnectionGUID: gw9ekX+6QyCGJlcGhLwBMQ==
X-CSE-MsgGUID: fo8K+qZeRaGBUfBpE6zk/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="302409052"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:50:59 -0700
Date: Fri, 14 Aug 2026 11:50:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Maxwell Doose <maxwell@maxwelld.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
Message-ID: <an7W8VKXrIKzl9xt@ashevche-desk.local>
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
 <DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
 <CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>
 <DKOBND0GKI21.2843OFKP0KR40@maxwelld.cc>
 <an7OSM04kiviu9xL@ashevche-desk.local>
 <CALoEA-xkxGY9sTeTR3cXgzadp+Uuk3MZh21ubD82kyijo4NN8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALoEA-xkxGY9sTeTR3cXgzadp+Uuk3MZh21ubD82kyijo4NN8g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 10:25:32AM +0200, Joshua Crofts wrote:
> On Fri, 14 Aug 2026 at 10:16, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Aug 13, 2026 at 09:47:00PM -0500, Maxwell Doose wrote:
> > > On Thu Aug 13, 2026 at 3:47 PM CDT
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Aug 13, 2026 at 8:52 PM Maxwell Doose <maxwell@maxwelld.cc> wrote:

...

> > > > Note, that kernel.h shouldn't be there at all, but that is definitely out
> > > > of scope here.
> > >
> > > Makes sense. I wonder if it may be worth doing a patch series removing
> > > all of the kernel.h inclusions in IIO all at once (or maybe some drivers
> > > have a legitimate use for it, but that seems highly unlikely).
> >
> > Yes, for sure! I have simply had no time to do it myself, but I have a low-prio
> > item in my always grown TODO list. So, if you do that, I will really appreciate!
> > But be careful, the actual patches should care about the whole bunch of the
> > inclusions, and not just about kernel.h. This means each driver should be
> > carefully inspected in accordance with the IWYU principles.
> 
> This will be a gruelling task (implementing and reviewing), but perhaps it
> would be easier to do one sensor type at a time instead of the entire
> subsystem.

I would start from the easy cases where kernel.h is just not used at all (not
even as a "proxy" header). Then continue with the rest.

Joshua, note, it's only about the drivers that have explicit kernel.h
inclusion. In general the entire IIO needs to be revisited, indeed.

$ git grep -n -lw linux/kernel.h -- drivers/iio/ | wc -l
234

$ git ls-files | grep ^drivers/iio/.*\.c$ | wc -l
707

-- 
With Best Regards,
Andy Shevchenko


