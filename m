Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B030DEB8;
	Thu, 11 Jun 2026 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206076; cv=none; b=brBSwOpY2Ab/oO62wBKVI7SZ1E3v6POxRlA7UiPVAxHActpJyp7W/N0bJjpDUUrLaMmr7OjhSvoqefigjK4jRqsrI9xhhbnI3AjXbgHBny4PIRdlmMcXwraf205rYY34IDoPw2h2wYRTyaiPU6QO8fRuNZU7kDc3B/VDHNppUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206076; c=relaxed/simple;
	bh=ZsYHI2Mv0/sivtqF2/BNg7mQl3iBrP2bqcQipJwiT+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Anc1SYlaNtOnPirZ9jRRTZP//gAGZbDC56gRIgfUj3XXmX18dIiRsNHLM63VcahWEhUyNVaMe7eHm8EByQWgGIdMOfknT9TUFPX9tjinNz+YAygCnzVsHklGaQQALbJ9nM3sxMPqPuSxCx2+eeDiuU/bqQxPQieaHVP644+gOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXIXh/UE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXIXh/UE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781206074; x=1812742074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZsYHI2Mv0/sivtqF2/BNg7mQl3iBrP2bqcQipJwiT+Y=;
  b=KXIXh/UE+RtfjZbZWSKCylfzkfw+lWUJZ9EXSIa8yk07l4RVT7YfY3nH
   OO/2YB2BwXgfOV9RyLVySoMQskmpUSIUPuexuALIlYnF7uPZCz3gHFAqA
   +tHykquc1ntsgkCm/TR1EzvM6TDGvn6au2PAwzl0sAr0X53ldVp0A0UCo
   WFvAdgpVm2o0jWKgq0KP8vG7ud6NoS8Z0K/Ng3xPyKOcp3bmnjuIOdo8N
   0St0+9lrEE+0OacY7YccUVAaMxmhX1nVRz4z5quyD61yayRmK80krA1Ek
   731QvVvxpWsSgbZ7XUbkdBnRwUFYMzsrbrDNRJ7aGExnalxolwBONSdeZ
   A==;
X-CSE-ConnectionGUID: 1SxWtLrYSr6etcJ97qJbDg==
X-CSE-MsgGUID: MJQyfFTOTeSAtvXlT5Qe0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="104698285"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="104698285"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:27:54 -0700
X-CSE-ConnectionGUID: qhaqYVHXR62R6ZSVw7gEwA==
X-CSE-MsgGUID: H7BMtbp3SoKVHA79A3Horg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246662023"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:27:48 -0700
Date: Thu, 11 Jun 2026 22:27:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting
 LED sources from DT
Message-ID: <aisMMgsGMNwOq1lX@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-15-clamor95@gmail.com>
 <aihoH9Pmzufa9pnE@ashevche-desk.local>
 <CAPVz0n0m+i7wexfC0BWwvdOuJxDk_=x+EpxEbNmoHN1AsEmfNg@mail.gmail.com>
 <aimy3BxBaXQ3Uigd@ashevche-desk.local>
 <CAPVz0n0bpo6PAfdN+LGEgPYhEx8mqtu_SL=WnDxhWn-Cq4rQKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n0bpo6PAfdN+LGEgPYhEx8mqtu_SL=WnDxhWn-Cq4rQKA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 03:33:42PM +0300, Svyatoslav Ryhel wrote:
> ср, 10 черв. 2026 р. о 21:54 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Wed, Jun 10, 2026 at 05:45:28PM +0300, Svyatoslav Ryhel wrote:
> > > вт, 9 черв. 2026 р. о 22:23 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > > > On Sat, Jun 06, 2026 at 07:57:38AM +0300, Svyatoslav Ryhel wrote:
> > > > > Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> > > > > defined in the device tree.

...

> > > > > +     int ret, i;
> > > >
> > > > No need to add 'i'.
> > >
> > > This is personal preference as well. There is no strict rule that
> > > iteration variable must be defined strictly in the for loop.
> >
> > This is a preference by Linus who is the leader of the project.
> > Also in IIO we have some set of maintainer preferences.
> 
> Well, this is not meant for IIO,

Oh, my bad. I am overwhelmed with the IIO patches, automatically thought that
I am dealing with yet another IIO patch.

> though it seems that Lee is also in favor if this approach.

Good to know!

> > > > > +             for (i = 0; i < led->num_leds; i++) {
> > > >
> > > >                 for (unsigned int i = 0; i < led->num_leds; i++) {
> > > >
> > > > > +                     if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
> > > > > +                             continue;
> > > > > +
> > > > > +                     output_cfg_shift = led->leds[i] * 2;
> > > > > +                     output_cfg_val |= led->id << output_cfg_shift;
> > > > > +                     output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
> > > > > +             }

-- 
With Best Regards,
Andy Shevchenko


