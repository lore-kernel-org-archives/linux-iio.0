Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777386;
	b=BF1UtyCDxjRMJKQqly8LJEjU/hIyQB/wY5hoLVzA+epP+N/Ew3mjuz/Vi+EykLCjFzyI
	 dg4ea781CBqS149cQ8Sb0mzas8L6lnup86YT2PPZj4a3mVLp2hwSTd6LmAX+rsM2yjrcH
	 YTcMX64wG7GYZYL0/fU9dSnAqdSjKTu2m9oaBwSLiCKa7InkcUbj93BRZA+WsoIXnT/y1
	 +sJrjU4j9SGSEwRevnmcU71yrxBvM5g+uCLUFmd7VKcBpXGzWraDTZ15G2vmb3gmMujCU
	 VE0TuXvE4tSF3DdwVKDseZEZeylrj/SoXk4hgcAdwktQiT98dqoE/M+Ov/ZtSrc3Xvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777386;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=IU/hlSkS0ZlcXAiMbavSZF/m8ZJfmUnU74uO4s48uCk=;
	b=K3dOIxNjDsxpj0vsziJcrOq5QS6npzDAO5LRec/diEIEDgoKn73BDb2v+oaztiIstERt
	 NdjIjVCJUJLkXCxQf4Yy7u3G0aN16D50a8m2ZsxDu3EbmedLJJWrOudtkBWqfPqU20IRj
	 n8jtRu3Xj7p03MGC21w28A62lTISqIJN6xgg87+H5yDLBrxPpwwNicI+BtPCrai1wnjtj
	 Lk1rrnUnGlyoTbkD2vTWP5UBDguAP7cDXqIPLVbGhA7dNTHGATg0u83zQOKlOfrwR5Rlk
	 5oBOeuXu24BQFSkC1FvKZPd00xn+3ytuR0a9LKrCEDs1YOi3kCntUDb3rggTRQUcRjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fl6vAUL0;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEA606A332;
	Fri, 27 Nov 2026 11:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AAEA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fl6vAUL0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795777385; x=1827313385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=60sMrvoiY0fFSRxnoXqAX03tCYSyAzPXmO7RCFfJfFc=;
  b=Fl6vAUL0xB6W3fLdAPECl76hCBEFCT8+872WrlWTd1ojXX0WQYSlAC07
   JM+rUUkwP3Sq1Kl4S83AcejPNeG2Ga9sZiwYOIZmD9Ii43v6c7AaUrf7t
   6DKoW7FTj+/pS6fywR1r1MquzBJ+SLiXsu4ncboTC0FcQszJXBxAO6ClL
   bguN6KGJgxMn9Z548dYVHoFZcl6jQ/1lM1S3Zbxrwj5G8e4XFhmdoifag
   5auppPfQtz2nRs9QkOdhgj63nV5Cr3Q1bZHlWhfBJ+bPYURYE9nsOgLFn
   ha1ZoVZsOSJf8kyA6bRuIbxrPVgWC+0pBskKFL9d/nyph6kNgH+BstQKT
   A==;
X-CSE-ConnectionGUID: pZAtlUuLTByjaepr8yn9Kg==
X-CSE-MsgGUID: BBeYqqpqQkq1bilAPnQJvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4544007"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4544007"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:03:04 -0800
X-CSE-ConnectionGUID: cYAF2QrxRg6hEMuKfrKzlg==
X-CSE-MsgGUID: MhyoIV2vRTOWhnRaWT6q/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="14049140"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:03:03 -0800
Date: Fri, 27 Nov 2026 13:03:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Joshua Crofts <crofts@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: rohm-bd79703: Fix full-scale voltages
Message-ID: <awljZLpARRVUFqbI@ashevche-desk.local>
References: <0723d51fa973f0204e1c436c08a784b7b1cca795.1795699121.git.mazziesaccount@gmail.com>
 <3ec029d6-d53d-4cd9-8582-a15cfd3eb4d1@kernel.org>
 <036d044a-67ef-4716-aa0a-cdf3108c12e4@gmail.com>
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
In-Reply-To: <036d044a-67ef-4716-aa0a-cdf3108c12e4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 08:34:22AM +0200, Matti Vaittinen wrote:
> On 26/11/2026 15:31, Joshua Crofts wrote:
> > On 26-Nov-26 14:23, Matti Vaittinen wrote:

...

> > > +	int vcc_mv;
> > 
> > _mV is the preferred style to denote SI unit variables.
> 
> I have discussed this before, and I disagree. Regular variables have been
> lower case since forever. Capitals have been used to scream "Note me, here
> is something unusal you need to pay attention for" (like macros). In my,
> admittably not always humble enough, opinion, the whole "denote SI units" is
> stupid. I haven't yet seen an engineer who wouldn't understand the meaning
> of vcc_mv in this context. And, to be very blunt, if I saw such an engineer,
> I would rather him stay away from the driver code. On the other hand, I have
> seen engineers who have spent long time with kernel code, stop reading to
> wonder "Hey, we have capitals here, what's special with this
> variable/member". So for me a change from vcc_mv to vcc_mV makes this worse.

And I disagree with your argumentation because the scope of discussion here is
more than just millivolts. We have (in practice!) already a problem with mHz
versus MHz. Yes, in real life. So, that's why it's better to follow SI for all
SI registered units and stop messing with the multipliers.

> > > +	int vfs_mv;

...

> > > +	data->vcc_mv = ret / 1000;
> > 
> > Better to do ret / (MICRO / MILLI).
> 
> This is another thing I've discussed also in the past. If you genuinely stop
> to think this, why would MICRO / MILLI be better than 1000? Which one brings
> smaller cognitional load, huh? And assigning the result to variable vcc_mv
> makes units explicit in any case. And speaking of SI units and scientific
> accuracy, what actually is MICRO? What is MILLI?

Then what prevents you from adding a new multiplier to units.h?

...

> Micro is 10^-6! Milli is 10^-3. So, this becomes "ret / (10^-6 / 10^-3)",
> which is plain incorrect. So, instead of making things better, this
> obfuscates stuff even further. So please, let's not spread this madness any
> further.

Because kernel does not work in float, it works in integer space. We don't
have fractions without keeping a multiplier in mind. I do not consider this
a madness.

> (So actually, this should be 1_PER_MICRO / 1_PER_MILLI - and that'd
> be even more cognitive load. When did our goal changed from making
> easy-to-understand -code back to making fancy-looking code, which is harder
> to understand, while claiming it to be an improvement? That's what these
> discussions really look to me.)
> 
> I agree on using MEGA for 1000000 and even 10 * KILO. This makes sense as
> when the amount of zeroes increases, counting them becomes harder -
> especially with old eyes like mine. But using (MICRO / MILLI) instead of
> 1000, that's, in my opinion, just plain stupid. Intentional obfuscation of a
> perfectly clear thing.
> 
> I am ready to discuss these points when I submit new features, and I've done
> this quite a lot in the past with Andy ;) But with a fix for a pretty severe
> bug potentially causing unexpected voltages being driven out of a device -
> which may cause a havoc to hardware. I'd rather get this fixed ASAP. Maybe
> you can send an improvement patch with suggested styling "fixes" if you feel
> really strongly about them, and we can continue discussion there? I am sure
> Andy will also join us ;)

Yep, with my full disagreement with you :-)

-- 
With Best Regards,
Andy Shevchenko


