Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795273109;
	b=pTd92bzfWys4wJC0O/9SHuXa/XHRwEL0um0SEvfzg1b3hdhyH6lqHe/tRiVBeXZZDCVv
	 A4ZP/IVkefcxUbMNPy632fSsWTxDMENzcSSyPxgpltjGSYUnLqLimIm9pmdWI5ktobd1n
	 3RfsSbTfLRTklKBx9MXB9BYbLDNaFXX9VrguHEc3Yw32QFhomSegEzxchHvh4jnV845Ld
	 /QdmIbLq1bHEOlY2gM588IR7fuNRvbJBcC75ysSoH6+jK8Fw5YuMM06EmWv+GWzcMwtQ8
	 6ZKmB/X6Lg2vSU/rVm+K1KqnjbJr5uzz60LPqScIybNvOFmMk4dJ4OqH0KRe/0+To4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273109;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=i3b3cLtt8G5/INJz756VDaB4GfRsAFuhpYGDkJwdzxI=;
	b=VkDlon/+mBDdzICmMUmIzQajMol0R1d1G3SykpqubUvr/mA3fm0rtyEI5N7Sl1CA3XwR
	 PCXvxT94JEjgASquOkfqnebBPr9hZ6KwHL6NPP4F49LFGRHNYFa+tr+rmRVktCquP/kms
	 Lo+Zr9twgpMvn3ssfS9oeMoYhM+6u+K029Qb3uRn1LRZyqvppydOLu1FkgjGnd1LClokv
	 aDSPujTv3+Uf8G9rFt4dF8a8+A1MNS0xyS/01K25J7ws0L/MQ0WB8iN5/ieNZez/Km5aF
	 kDHQiqy5q3WeDS+Pqi06hsoMXy4SvqUvjUxc71fwIFYGWsa5MaNUtbWHKejkqrtRdNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gsRsfpvD;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691A606A320;
	Sat, 21 Nov 2026 14:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8691A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gsRsfpvD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795273109; x=1826809109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+2TVOJ7oWyeYgmNbI/7CjJduZ8iKEhMSXWBN6IhabsA=;
  b=gsRsfpvD944MrXJqZmhmuH4U6fR66u86B5T08p+N42Fp8DUpIKuQCyt4
   kgA66q1inP5fUL8EfvSml0BJets6ejwsPBJCrMEJECB+agfA6lISCsfGT
   8vy0gZZ/cyIUrAzSRp6LtytXoYPTSJMy+OVmRsU9kak6hvKnQ0AjcCaW0
   7VXZPdhQh/uphOv8rEjSQRlCC27yi0370qHO+sNuBG4kFHQeM0f7Z1WBw
   SCX4KBrto59z+sL+B5qaUKSG9656G0zePKOgn8DpNJJiuTMv1HMWGeB9x
   UCFjljjuuKzLoFADo271ISXdNKEm06NgtZjhvbrX2JmBMqpZ8TWWvp1Bm
   A==;
X-CSE-ConnectionGUID: 7xIHk65nT3md4TJN+No91w==
X-CSE-MsgGUID: fhRY29ixSUeguhgKGUvALw==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4176173"
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="4176173"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 06:58:28 -0800
X-CSE-ConnectionGUID: 6GiRcTiFThySDZbJz8JxEQ==
X-CSE-MsgGUID: WFRzvSSJQ8WHjwrfWzIsNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,225,1787036400"; 
   d="scan'208";a="11338686"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 06:58:25 -0800
Date: Sat, 21 Nov 2026 16:58:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joe LeVeque <joe.l@reflexrobotics.com>
Cc: jean-baptiste.maneyrol@tdk.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: inv_icm42600: return -EBUSY for
 temperature reads when idle
Message-ID: <awGxj7xP6oTlkUt0@ashevche-desk.local>
References: <20261120020850.24318-1-joe.l@reflexrobotics.com>
 <20261120020850.24318-2-joe.l@reflexrobotics.com>
 <awAT-ofy0p_uhvGN@ashevche-desk.local>
 <CAJLMkXafYtUx7gXE8g-sJ0keGW8eSrVGPc2ao5EzjkxZ-nN2cA@mail.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJLMkXafYtUx7gXE8g-sJ0keGW8eSrVGPc2ao5EzjkxZ-nN2cA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 10:32:52AM -0800, Joe LeVeque wrote:
> Hi Andy,
> 
> The -EBUSY here is consistent with the existing invalid-data case in
> inv_icm42600_temp_read(), which commit dfdc31e7ccf3 (“iio: imu:
> inv_icm42600: change invalid data error to -EBUSY”) changed from
> -EINVAL to -EBUSY for the same situation (both accel and gyro off).
> Patch 1 returns the same error for the stale-data case, so userspace
> sees one consistent response.
> 
> https://git.kernel.org/torvalds/c/dfdc31e7ccf3

I see, but even if it's used otherwise, perhaps we need to consider to replace
in both places (or rather replace existing one first).

What about using ESTALE?

> On Fri, Nov 20, 2026 at 1:33 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Nov 19, 2026 at 06:08:49PM -0800, Joe LeVeque wrote:
> > > The temperature sensor only measures while the accel or gyro is on.
> > > With both off, its data register keeps the last measurement, so a
> > > temperature read returns stale data. On an ICM-42688-P, a value held at
> > > about 52 C was returned while the chip was at about 62 C. The data only
> > > reads as invalid before the first measurement after power-up.
> > >
> > > The temperature is the die temperature, used for accel and gyro
> > > compensation, so return -EBUSY when both are off instead of stale data.
> >
> > Hmm... EBUSY means they are doing something and kinda hints user to come again.
> > Would this condition change on its own if user comes again later with the same
> > request?

...

> > > +     /*
> > > +      * The temperature sensor only measures while the accel or gyro is
> > > +      * on; with both off, its data register holds a stale value.
> > > +      */
> > > +     if (st->conf.gyro.mode == INV_ICM42600_SENSOR_MODE_OFF &&
> > > +         st->conf.accel.mode == INV_ICM42600_SENSOR_MODE_OFF) {
> > > +             ret = -EBUSY;
> > > +             goto exit;
> > > +     }
> >
> > I would choose one from the below (they all have their pros and cons)
> >
> > ESTALE
> > something like this, but error message is specific about file handle
> >
> > EL3HLT
> > what is level 3? But we have the only user, and it is outside network
> > and it sounds close to this case, but why not EL2HLT? (Also the users
> > are outside network.)
> >
> > ENODATA
> > also used a lot, so semantics not so clear, and data is there, but outdated
> >
> > Depending on the answer to the question at the top of my reply, the error
> > codes may be EIO, ENXIO, EPROTO, EAGAIN (but if EAGAIN fits to the flow,
> > EBUSY also fits).

-- 
With Best Regards,
Andy Shevchenko


