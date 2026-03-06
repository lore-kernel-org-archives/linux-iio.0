Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745462DEA9B;
	Fri,  6 Mar 2026 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798998; cv=none; b=JsLuorBj068dN1kHLXaBVKyJNtCk6yZcI5oNHwkkUvhtCjgpoBetpXSUnwNm8V0oVHP3+s03Ha8Eu+zzXLk77vIwDfygHSMkqZW3EGpPvmfcUsI9NEgwtdaqpJx8fdTBL5gG0s+GYqLUJ89YJEWCOqC4OHR+949tiA+Z/eL1wfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798998; c=relaxed/simple;
	bh=nVVub8fwfY6QBhQ2M77L7oG9jsYVZgUizfpDlI1q/aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw0N3S+UHpoksCCjt691yHoyJqOnxG1g3zo/oeyZDvDGVCHSoBYWqgjHKIr/n9FbttFwRdsuhbR8A62FswOEDQdyGk1S3Jz3u4OJkjT19Xaa7uDV/QsotvO7/4EvFG+wWLgtu66ubR540eiC0gzyltPQTv7aLlEErnl7quUJLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHBPk8gX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHBPk8gX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772798998; x=1804334998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nVVub8fwfY6QBhQ2M77L7oG9jsYVZgUizfpDlI1q/aA=;
  b=VHBPk8gX6BDVqWK2fFC3lGbauh3BhL8jJAjuXu7dC5TYSfmb0uRFUVE2
   /2a8/69n16ACpTHppdyyx91VM5jIJbuuhCj2mp4q00UxIZFmGmRCzplia
   /KDoRTku3ioQ5PjQCu4pmEws5FoJgJ1cac7khl1lBrgR32Nn5IVpEwfLQ
   XjE7rMIKHmhyBcTw12/M8ziQ2C8RdOwk256VlD4I8BxQi5XTULeoAGMXQ
   artHyjlO74awDHkT4p+P6fwBwbh/OzOChXZ1nqhib54ggPMAdYt2jOfVE
   NX26FQl+M6ifX8LFWBMwXzjHVYBotth0w2XM+0iGlji3aBsNbPPcMeGZn
   Q==;
X-CSE-ConnectionGUID: eNPGMou+Q+yKwJW/TuGxWA==
X-CSE-MsgGUID: DBWUqi3URhmxYxj+o5mF8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73605303"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73605303"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:09:57 -0800
X-CSE-ConnectionGUID: N+BTpeh3TRKfLK77LLHkTw==
X-CSE-MsgGUID: iC4M1LnJSBKpRfjdq8Ysgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="215690111"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:09:54 -0800
Date: Fri, 6 Mar 2026 14:09:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 4/6] iio: ABI: Add support for floating-point numbers
 in buffer scan elements
Message-ID: <aarED5TAWg2qFtxi@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080658.2844434-1-flavra@baylibre.com>
 <70f25902-5c79-46f9-8c67-99633b22b5ac@baylibre.com>
 <098886563f5fdcde837989d0556ed9a2d8d3203b.camel@baylibre.com>
 <CAHp75Vdni=OgHiDi8G5s6CgBFZZuypOyJSo5DFjaKYFkLGPqkQ@mail.gmail.com>
 <dd6d1436-d509-4233-ba1f-5a3f870f35fb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd6d1436-d509-4233-ba1f-5a3f870f35fb@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 08:37:48AM -0600, David Lechner wrote:
> On 3/5/26 3:23 AM, Andy Shevchenko wrote:
> > On Thu, Mar 5, 2026 at 11:09 AM Francesco Lavra <flavra@baylibre.com> wrote:
> >> On Wed, 2026-03-04 at 16:45 -0600, David Lechner wrote:
> >>> On 3/4/26 2:06 AM, Francesco Lavra wrote:
> >>>> In the data storage description of a scan element, the first character
> >>>> after the colon can have the values 's' and 'u' to specify signed and
> >>>> unsigned integers, respectively.
> >>>> Add 'f' as an allowed value to specify floating-point numbers formatted
> >>>> according to the IEEE 754 standard.

...

> >>>> -  Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift] .
> >>>> +  Format is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift] .
> >>>>
> >>>>    * *be* or *le*, specifies big or little endian.
> >>>> +  * *f*, specifies if floating-point.
> >>>>    * *s* or *u*, specifies if signed (2's complement) or unsigned.
> >>>
> >>> I would keep all of the format options on one bullet point.
> >>
> >> That's what I did initially, but Andy suggested doing differently [1].
> > 
> > And still I think it's better to not mix them. The floating in the
> > same sentence is confusing (along with 2's complement mention and
> > sign).
> 
> Then I would split up all 3. It is strange to mix some and not
> all.

I don't find it 'strange'. The integer are grouped together, floats do not
belong to that group.

...

> >>>> -is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
> >>>> +is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift], where:
> >>>>
> >>>>  - **be** or **le** specifies big or little-endian.
> >>>> +- **f** specifies if floating-point.
> >>>>  - **s** or **u** specifies if signed (2's complement) or unsigned.
> >>>
> >>> same here
> >>
> >> [1] https://lore.kernel.org/linux-iio/aZ7dCdLs5xcJ4UGW@smile.fi.intel.com/
> > 
> > Same here.

-- 
With Best Regards,
Andy Shevchenko


