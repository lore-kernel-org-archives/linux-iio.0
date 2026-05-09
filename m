Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD029BDAA;
	Sat,  9 May 2026 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313265; cv=none; b=X9/GOQnGY2HP0oD2X+MjZbQxDjHEsxqnJyC/mV3Juf1/E0Kpm7Uoq6HKe4pDqVF0DR0A2+O76dKak5yF8jeUxFX91yYHZdVTPiBTf4ImQuI0kSmWsOtSWYQI8d/IGHGdtmoWb0p8WdRhOGdBfKlpDVPE2K13fZAIxn129W6bOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313265; c=relaxed/simple;
	bh=t05tuoZd261IjLLrYcnqJyYpZFLiIP9D13913mHpUUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DClMz+as+TaYg5KJhNRqWTirypslRGF8c6izTkU21s/rTszNzgYQoF9m0LvAohVRd2TdTLDmaAkIQO8Givnp41firL6zfRy7UpxZiPz02dU54EQ0UnkPSA5uVP1IAYheDkLDaNl3Qfv57tDWyS5whRI75d59JcnFnqjsMVdm5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lj0m/pQN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lj0m/pQN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778313264; x=1809849264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t05tuoZd261IjLLrYcnqJyYpZFLiIP9D13913mHpUUA=;
  b=lj0m/pQN86j6ASUwlOyteNVYPr8qsiltbeB4KVpMEGopPdlptCIxmw3+
   RmprZGhq4kL9bm1TbEkLheEJO3J2ffGBriuuHks9csEJveIlhOOPqrF+D
   IbjhMzARE6FWP8532Om2vMo02stAkx4FM/bPRuhVIRHJlv4KL/Js8bTqc
   zWfLB6YiBE0k84SrHHzeJcSyNziOcd1Zps+bP3aLLlshk8Q7/lSK2KBO/
   hLToLAEUL36nwfRCCqKWC509Uvk7KVeSP1Te7uFfILA8KldDTBeT+DBU0
   Cink+JKTnCmtKhFg/i49rnU6FJz08JHB3HLZ4OhwVPhvuk0Xaj5jVY8M3
   A==;
X-CSE-ConnectionGUID: HwgEuC2RTDigNc0DOtUczw==
X-CSE-MsgGUID: JP/8XuzYQA26JANcppxpug==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79384616"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79384616"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 00:54:23 -0700
X-CSE-ConnectionGUID: H0YzgkALRcGzyuCQ/PPpdw==
X-CSE-MsgGUID: /ZXlFVKUSb2yODNMwpQauQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 00:54:21 -0700
Date: Sat, 9 May 2026 10:54:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
Message-ID: <af7oKgtzyFmPogJJ@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
 <af2zup3PFlgs2DtE@ashevche-desk.local>
 <CALoEA-y-Qg22NSfVBLtqx4VFp0q=xqLOuL5Wf8TxW1AswW1+hQ@mail.gmail.com>
 <af7Zql3NkhDwKWBc@ashevche-desk.local>
 <CALoEA-zBRC+sZqtP4YiSu8ZBgw69t9_ZqaOQ9BDResRWhnGR=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-zBRC+sZqtP4YiSu8ZBgw69t9_ZqaOQ9BDResRWhnGR=g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 09:47:25AM +0200, Joshua Crofts wrote:
> On Sat, 9 May 2026 at 08:52, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, May 08, 2026 at 03:51:06PM +0200, Joshua Crofts wrote:
> > > On Fri, 8 May 2026 at 11:58, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, May 07, 2026 at 04:35:52PM +0200, Joshua Crofts via B4 Relay wrote:

...

> > > > > +     /* Only power down if currently active */
> > > > > +     if (pm_runtime_status_suspended(dev))
> > > >
> > > > Is this one a correct one?
> > > > We also have pm_runtime_suspended(), which is different.
> > >
> > > As we only require the status of the device and not the power.disable_depth,
> > > pm_runtime_status_suspended() seems adequate.
> >
> > Last time I have checked the code on this I remember that probably this one
> > doesn't guarantee that immediately after returning to the caller the device is
> > still in a suspend status.
> >
> > The difference between two as documentation said is in "...if runtime PM
> > is enabled for @dev..." for the pm_runtime_suspended(). So the
> > pm_runtime_suspended() is stricter in that sense.
> 
> Okay, if you prefer pm_runtime_suspended() then I have no issue with it.
> I can amend the series version this time.

It's not about my preference (I am fine with either call), it's about
understanding the code flow and what does fit better in _this_ case.

-- 
With Best Regards,
Andy Shevchenko


