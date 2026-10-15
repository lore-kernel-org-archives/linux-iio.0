Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC857F723;
	Thu, 15 Oct 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088217; cv=none; b=HkGt5ccTq5fj/FavvykTgf+GAre1mb6jomzKhL4PcKaDAhTZjiFQHs32H7srHtbcMZhJqtJuGqufU1LuaBmNqgXoJ39190SXYK7W4+sWNNdY0UGzXi2siA9KK1hgEEvKO79Y3m+YPZPj6OPDNfCks7oZTkMfciMDOfupkg3sdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088217; c=relaxed/simple;
	bh=zcv7Jb3qXXXVu6PeodO7ckwHnhG6wgII4999lN/9D6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvqWkl/kVd8rCgZehb9Xh2y2iIz35OhhvQarl73wumoPvl1+9kbx5i5CGoe6haJwsOyrx2NguTr6nVhUxfXrMh2NlzJFJlLJzLKr7wg4Qi20fwSYx09PPnOFHLVBQ7/2Sz/W1g4KzsFQOKf1tuiOgEAb8va1fh9y8Vd0xOR5ScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfaSt7Lz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfaSt7Lz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792088210; x=1823624210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zcv7Jb3qXXXVu6PeodO7ckwHnhG6wgII4999lN/9D6U=;
  b=LfaSt7LzL5sQ5tgYAgB1tT9bS1WLbSvkpSCze2JQxJH6cT697N27rWql
   ciliwOTkuq29FGzn8yawCuM9g82+vNVptkAZzl/kA8GKW3pS2xRvVpqlL
   ao+TCY6Nn1cRijqakrZTiyP7z71tTT+bDROu3xIzTUkD3wfh3rj7uYIb9
   NPzufIaLSG0lKlsd6NZcKL+33vhkqFwsjQnAk7BM8iA/w5/fYBH6jDvn7
   G5mNaRjeUlRw/7ysmLXcmJHhkjWoXXZgtHlcDDh7kohamlhDGKn3tUKSL
   oSh1Yj6KUb7GwYiR2fjUDcVEFML2BkMfAzRGUPkZOL4pNxX36Jp1SGj0L
   w==;
X-CSE-ConnectionGUID: SjNtqV0aRd6KG+QEtm3sWA==
X-CSE-MsgGUID: nWqXYpZbRjuDhE7h2eFvhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="770908"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="770908"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:16:49 -0700
X-CSE-ConnectionGUID: PRSsn64xSACHQtN2pci4nA==
X-CSE-MsgGUID: +Sc5oHvATIabm18d/8RI5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1733644"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:16:46 -0700
Date: Thu, 15 Oct 2026 21:16:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
	Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
Message-ID: <atEYjMpwn0yKFBk3@ashevche-desk.local>
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
 <CAMRc=Mfn7+uQYvLjGLxU9wMOnRwx5pyPgaLp6oNx+ZcFXyXL=A@mail.gmail.com>
 <cde9d00a-bfe4-4093-b03d-f76a122e4ded@baylibre.com>
 <as46xFp-3fXvWPlm@ashevche-desk.local>
 <ca27a15c-5b21-4381-a82f-e80bb0ae488a@baylibre.com>
 <atDXNlsDIAzOpgFg@ashevche-desk.local>
 <11c08f9a-091d-43fb-8c1e-f3f2fe6ec3c2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11c08f9a-091d-43fb-8c1e-f3f2fe6ec3c2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Rob. Here is a discussion how properly to check if the specific node has
gpio-controller flag set. I tend to say that in the case of a simple branch
(in opposite to if-else) we should use _property_present() and not
_property_read_bool(). Can you be an arbiter here and tell the correct way
of doing this?

On Thu, Oct 15, 2026 at 09:04:58AM -0500, David Lechner wrote:
> On 10/15/26 8:37 AM, Andy Shevchenko wrote:
> > On Thu, Oct 15, 2026 at 08:01:14AM -0500, David Lechner wrote:
> >> On 10/13/26 9:05 AM, Andy Shevchenko wrote:
> >>> On Sat, Oct 10, 2026 at 08:46:30AM -0500, David Lechner wrote:
> >>>> On 10/10/26 4:00 AM, Bartosz Golaszewski wrote:
> >>>>> On Sat, 10 Oct 2026 01:25:52 +0200, "David Lechner (TI)"
> >>>>> <dlechner@baylibre.com> said:

...

> >>>>>> +	if (device_property_read_bool(dev, "gpio-controller")) {
> >>>>>
> >>>>> I think the right one to use is device_property_present().
> >>>>
> >>>> I thought this was the one case where device_property_read_bool() is
> >>>> actually correct because gpio-controller property is a
> >>>> /schemas/types.yaml#/definitions/flag.
> >>>>
> >>>> Otherwise, we should just remove device_property_read_bool() from the tree
> >>>> because there would never be a reason to use it.
> >>>>
> >>>> My understanding is we should use device_property_present() for non-boolean
> >>>> properties when we want to know if it is present or not before reading the
> >>>> value of it.
> >>>
> >>> That's not true. The _property_present() checks any type of property, while
> >>> _property_read_bool() returns an actual value of the flag, while they might
> >>> overlap in the behaviour, they are semantically completely different.
> >>
> >> That is exactly what I said.
> > 
> > But you made a code different. As I read it it checks for "is the
> > gpio-controller property present?" For the question that you may
> > think off "is the gpio-controller flag is true?" I consider rather
> > if-else branch as we *either* option.
> > 
> > So, when we do
> > 
> > 	if (...check_flag...)
> > 		do_smth();
> > 
> > I assume we check the presence of the property (flag). If we do
> > 
> > 	x = ...read_flag...;
> > 
> > OR
> > 
> > 	if (...read_flag... == true)
> > 		do_smth();
> > 	else
> > 		do_smth_else();
> > 
> > I consider the appropriate is reading the property.
> > 
> 
> Are you saying flag != boolean DT property type?

No, I'm saying that semantics is defined also in the context of use. In your
case you check for the property presence and do not use it as a value.

> type: boolean
> 
> vs.
> 
> $ref: /schemas/types.yaml#/definitions/flag
> 
> I know we have both names in dt-bindings but I don't know the history on it
> and if we consider them semantically different.

-- 
With Best Regards,
Andy Shevchenko


