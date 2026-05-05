Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D1282F32;
	Tue,  5 May 2026 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985195; cv=none; b=SbA2y4AWGYbhBBE/EPyzC0mW7r2dG9sKiwaPjmiUeBmAoH6Gvcf1O0/rg5Z6+E/mDrUb8+umGBAZCUYF165jLfxEhJmgh+5o8aKemcJgbJ82Oksw5yVaKf+Mfz2JhMMmxjhQK1oqLHFzaSi8KrJpJf7+kSaKHIeePu+fr2uQiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985195; c=relaxed/simple;
	bh=Cc/maqm9hLs0V/Pb7qCyphNk5Htn4bj1ffBs6rx/RzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPGzHFPCUixG2tm/iC3yOq9I7ytyYLqyCBiuERfi2seTImhH8SVAF9Z6B1jqMvdMmU+ykZHqAZg6UprphZryobFRyWij64kdVcxSB2P2ROcCOZnNUMVzrsQps0mV9zwhNOHtTVt09FiGmPjz7VzBrZdotRmukxoZjughp1XdzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dORCq9SO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dORCq9SO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777985194; x=1809521194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cc/maqm9hLs0V/Pb7qCyphNk5Htn4bj1ffBs6rx/RzQ=;
  b=dORCq9SOblaT3aP6EsbDrDhBWl6nnaGq9KZc811szIRbIu+kapsaSZHI
   kq0i14JcJNFhKekmBVx66Mi7JFMqLc3hsY/IqB2LpafRO2Nh1/jfbTe8a
   SvupakmHPGHaoXAbF68kTjvC92BjhSquW8kaJXsf5eL6P4/nNwnKuaTlm
   y21Hv+5gptbv6A4Y8iJnBPSJZaezpvWhm1C99GR9pJOBTNJHHD4lbH+r6
   KvR5vP/2IsjdAEgqkwGzCHhMIoegvEMkWZvrd23ijyMOeaSTTlgk6xSAy
   eTbMYyJz3UdV7YXUliQmh2q1JTKOY5uFPh8IW26LDoAScAYYU3/QTJNV8
   g==;
X-CSE-ConnectionGUID: 1YK4lY+GQXm6df66sekFJQ==
X-CSE-MsgGUID: V1p3mKicRjKOIkt74gehLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82705067"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="82705067"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:46:33 -0700
X-CSE-ConnectionGUID: i861TFWxS4SCVFoau9Ioxw==
X-CSE-MsgGUID: uLp9fwmCR9C9DaAs6SfOSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="234794343"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:46:30 -0700
Date: Tue, 5 May 2026 15:46:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, rodrigo.alencar@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 06/13] iio: dac: ad5686: refactor include headers
Message-ID: <afnmo0x-jT1j8smd@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com>
 <afIRG2S94JEn3Oqd@ashevche-desk.local>
 <CALoEA-yBU_pwiOFQx89-Gcgmtz_KtuxJJvph7uKPHKJNihDS8Q@mail.gmail.com>
 <afJLlpsU17Pmp0uH@ashevche-desk.local>
 <CALoEA-wvYvZr7ixC4UOh98mZAas1vbOe5CXT89DOy3e7xTmJ_g@mail.gmail.com>
 <afNBY6dQ5Nw-EZcH@ashevche-desk.local>
 <20260505115553.2ac39ec0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505115553.2ac39ec0@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 11:55:53AM +0100, Jonathan Cameron wrote:
> On Thu, 30 Apr 2026 14:47:47 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Apr 30, 2026 at 11:18:42AM +0200, Joshua Crofts wrote:
> > > On Wed, 29 Apr 2026 at 20:19, Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:  

...

> > > Also I've noticed that there is a /tools/iio/ directory in the repo,
> > > perhaps we could
> > > add it there so people don't have to search lore?  
> > 
> > Perhaps, but it should be approved by Jonathan. Sounds good to me,
> > nevertheless.
> > 
> It's not really a tool so the overall tools maintainers may not want it there.

Not yet a tool that is accommodated by Linux kernel project.

> Is there any precedence for similar config files?

I haven't seen such.

-- 
With Best Regards,
Andy Shevchenko


