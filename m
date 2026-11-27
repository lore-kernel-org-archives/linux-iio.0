Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781337;
	b=iCyi/u0JvNj7WsNtzCUSeKqsvCxmicNqIXOLk44adx82/LLX88CiPtpwWJXcW2dWM9NT
	 1SicnzQBeZeevbO9+FtWXxIntB8/c0aalZAKxIznFgRYu4XlbB3iLaWza3mfqG8u7Aqkp
	 pDI6aFOtKfUABDLfAG/IbPkoAziZcg4BRXyR649hbUCD0RbwD7ic+xX+ENbRYJ56CMbaL
	 WIpV0G+wUlby5zk58Anl3Nex9oqu+Q7/qFRsOIGXT4UQ6wwnz4M6eO4nhT04THnq3NRTJ
	 B10in/gjTUDFez3X7Hsex3eZTWSA+wCQBUl0rMtiarBMD3oCySIJI6udF6YB+rh1RBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781337;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0dg6Yz7eoXk4e6gGpKGxtbW5NLVD5HlBpLZDUQ2uV1w=;
	b=B3hJFZ+gIfV3T69ypuyJBR70lcZmc79Wx7rGYkVnj/F7N8eRJ9W1WnAx+0r4fa8RcFf+
	 TQJz9jeRWhN5s8ur1PEC7snYMd10KzaqkTQgBw2n6dfOa2F4ZrGJ8M62aqOnzAysZ10G0
	 tEqZ/Q/8hokBB6KM7EqQ57ckQUY4PoL2hKOmCrTjNCs8cfV7WrVBA6YTQfyphlo8XQ2hB
	 wIb5fouwwjsmmvRiSgKkDbuehwxfP3GZ2mAzNg2k+ImWEk2ljM9dKqxu3/c1ZCNJF8Cgn
	 nGpMryN0CYYIEGrOwkMBg6D2VLcrFthys7HyBXgEi0sFejlTUo+IKFPHhyAAdbino9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y0HYy9s6;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62912606A321;
	Fri, 27 Nov 2026 12:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62912606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y0HYy9s6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795781337; x=1827317337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TQw/+E/JpjQyKTAKSKFYoGT1k3KALWhtx+FIqBfVhpQ=;
  b=Y0HYy9s6j0tDQMlJYBFDCV4cXBu0RfeU0Ay9+PGNzF4NBHvRLc+1tkY8
   DzsyHGsd/iaAmHqzewfYvuoO4ynIl4eDNPO5EXFc4LRf8oUR7qngfXtrm
   4FGSaeHFeKK+9JiDAisYM9iyZIT4anp5+/9F+buO2fnqHFZVHzpIHFFew
   YovI58rugvXZ6RWdhvRes3wXVxzxWAHvTPeDLry90HBegsbv+TB6CwGTW
   Lw7VBiNYzS3Frg+VCY8QatQAGFOGWF2WXWiFn/WskYD1Eo8CM2Vohx2kE
   YFP2fAROgnIt83DXzsksQLWNfw3ej0cRIS2VmLwl1ghLHy0vDtZvwhEo9
   Q==;
X-CSE-ConnectionGUID: HYcpx4QZSnuf9iEzQ2V00w==
X-CSE-MsgGUID: AFdClzaRQsiPBngb8gAZtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4683654"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4683654"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:08:56 -0800
X-CSE-ConnectionGUID: Oxfi6+/DRN2HWYtNsfMfvw==
X-CSE-MsgGUID: m42yh6kzQfahVo5n9rNoOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12423905"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:08:54 -0800
Date: Fri, 27 Nov 2026 14:08:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Joshua Crofts <crofts@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: rohm-bd79703: Fix full-scale voltages
Message-ID: <awly0_hYZ07aeRYV@ashevche-desk.local>
References: <0723d51fa973f0204e1c436c08a784b7b1cca795.1795699121.git.mazziesaccount@gmail.com>
 <3ec029d6-d53d-4cd9-8582-a15cfd3eb4d1@kernel.org>
 <036d044a-67ef-4716-aa0a-cdf3108c12e4@gmail.com>
 <awljZLpARRVUFqbI@ashevche-desk.local>
 <9291049f-987e-4402-b32c-12c33c7aaa33@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9291049f-987e-4402-b32c-12c33c7aaa33@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 01:46:12PM +0200, Matti Vaittinen wrote:
> On 27/11/2026 13:03, Andy Shevchenko wrote:
> > On Fri, Nov 27, 2026 at 08:34:22AM +0200, Matti Vaittinen wrote:
> > > On 26/11/2026 15:31, Joshua Crofts wrote:
> > > > On 26-Nov-26 14:23, Matti Vaittinen wrote:

...

> > > > > +	int vcc_mv;
> > > > 
> > > > _mV is the preferred style to denote SI unit variables.
> > > 
> > > I have discussed this before, and I disagree. Regular variables have been
> > > lower case since forever. Capitals have been used to scream "Note me, here
> > > is something unusal you need to pay attention for" (like macros). In my,
> > > admittably not always humble enough, opinion, the whole "denote SI units" is
> > > stupid. I haven't yet seen an engineer who wouldn't understand the meaning
> > > of vcc_mv in this context. And, to be very blunt, if I saw such an engineer,
> > > I would rather him stay away from the driver code. On the other hand, I have
> > > seen engineers who have spent long time with kernel code, stop reading to
> > > wonder "Hey, we have capitals here, what's special with this
> > > variable/member". So for me a change from vcc_mv to vcc_mV makes this worse.
> > 
> > And I disagree with your argumentation because the scope of discussion here is
> > more than just millivolts. We have (in practice!) already a problem with mHz
> > versus MHz. Yes, in real life.
> 
> I see no mHz or MHz here.

That's why I pointed that the issue is broader than just millivolts _here_.
FWIW, mHz is in drivers/iio/imu/st_lsm6dsx/.

> > So, that's why it's better to follow SI for all
> > SI registered units and stop messing with the multipliers.
> 
> No. There is zero reason to use capitals in variable/member names when
> intent is clear. It only hurts reading with zero real benefits.

It's clear for *you* or somebody else who is not the first day in IIO
development, always put yourself into the position of unprepared reader.
SI is known for much longer than computer even exist.

> > > > > +	int vfs_mv;

...

> > > > > +	data->vcc_mv = ret / 1000;
> > > > 
> > > > Better to do ret / (MICRO / MILLI).
> > > 
> > > This is another thing I've discussed also in the past. If you genuinely stop
> > > to think this, why would MICRO / MILLI be better than 1000? Which one brings
> > > smaller cognitional load, huh? And assigning the result to variable vcc_mv
> > > makes units explicit in any case. And speaking of SI units and scientific
> > > accuracy, what actually is MICRO? What is MILLI?
> > 
> > Then what prevents you from adding a new multiplier to units.h?

No answer?

...

> > > Micro is 10^-6! Milli is 10^-3. So, this becomes "ret / (10^-6 / 10^-3)",
> > > which is plain incorrect. So, instead of making things better, this
> > > obfuscates stuff even further. So please, let's not spread this madness any
> > > further.
> > 
> > Because kernel does not work in float, it works in integer space.
> 
> This does not mean Milli is same as Kilo. You were the one who ask for
> accuracy above (even though it really just breaks the known convention), and
> here you demand obfuscation.

Yeah, it would be nice to have the stricter rules about this, but I see the
problems it may lead to. For the given case we transform the value in MICRO
volts to a MILLI volts using a ratio MICRO / MILLI. I consider that much easier
to read in the code and _understand_ what's going on.

> > We don't have fractions without keeping a multiplier in mind. I do not
> > consider this a madness.
> 
> swapping 1000 to (MICRO / MILLI) - where micro and milli arent what they are
> supposed to be - is madeness to me.

And opposite to me as we may admit.

-- 
With Best Regards,
Andy Shevchenko


