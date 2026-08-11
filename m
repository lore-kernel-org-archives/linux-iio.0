Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5413D42E8DF;
	Tue, 11 Aug 2026 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442906; cv=none; b=nHNmKMbBzdwPbad2Y9irhtKjU8auFqF03Ti0bTfkFggzLYKTpKCsthlwbfhByIv+zRvMU2opIFKnUpk90lf2qcsXF7oyFinvBc7vQFdvbh2/gVM8R/IQNoWBWLoI64I0AGpo07iuyzOmxvjLoZFG7yf52QsoFLIw4GwTQ9Tlneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442906; c=relaxed/simple;
	bh=f742gWR9UuDb96yr7N4MJlaJbG5H+tLnKOozg1XziRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf5VXXc0MqraWd9/KEjv2g5VklXJ4nFGGJlSBbzT79Inf9hnIKTsnyjIOwaGOvm7JtOA6GcNIJUkJOdHlDiZhpSnwchnIogzGcNCBOmu6X6HQABV1lwC6e7Ni8g16hY593Yt5YngBGkmySX5ntbr8FGhU1ak5K7SVqRS3UyJIPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRwKhtF6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRwKhtF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786442902; x=1817978902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f742gWR9UuDb96yr7N4MJlaJbG5H+tLnKOozg1XziRk=;
  b=RRwKhtF6UXwis6FizMasBF/y8FF2bXvHlfKu07pWZOl3hvZfpSY4a6VZ
   UPMwq7WC9vF6/Y2CRK5fJyGC2eKIXkdSSQVL9JxF6/rG1saYNUGfyRIfi
   sr2VcL/YjovqyixjzLoqmJ6Oj/kYPoQ3DaxHqFGenMLWUpxWl6dUI4g/O
   bJDBdtjt77fLyA+29zDyk9O7O9UgKlgk0LqLR4EPbxKELRl16s3KU0ucb
   hYcCnxn811LT5tgXXn7sYPfo4VgEYTP0VfdjsxxvRnsiTdqU7gvCrT3DA
   xLfpHWGARtAdA414uxNw+XZoszVOKhpNM4Oes5NgPmgh6vNoxlLo4j/wP
   g==;
X-CSE-ConnectionGUID: c020kHNVS7umggV/sIZQIw==
X-CSE-MsgGUID: AnHN3QOjRN6Yhb1J2nagyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86822778"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86822778"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:08:19 -0700
X-CSE-ConnectionGUID: PxezY6T+QTOaDN83yi/tAQ==
X-CSE-MsgGUID: 3edO+QtfSaGL9gC3YYCBFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="259448968"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:08:16 -0700
Date: Tue, 11 Aug 2026 13:08:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
Message-ID: <anr0jtvYorFKaEXY@ashevche-desk.local>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
 <anovRGxtsyJZ8cO9@ashevche-desk.local>
 <247b0e35-f49e-4bec-abd4-4a2c3dd49a2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247b0e35-f49e-4bec-abd4-4a2c3dd49a2d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 12:05:47PM +0300, Matti Vaittinen wrote:
> On 10/08/2026 23:06, Andy Shevchenko wrote:
> > On Mon, Aug 10, 2026 at 10:53:07AM +0300, Matti Vaittinen wrote:

...

> > > Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.
> > 
> > Can it be FIELD_PREP_CONST()?
> 
> Can you please elaborate why it should in this case?

I'm not sure why it's not obvious, but the parameters are constants, why would
we need an additional check or even checks?

-- 
With Best Regards,
Andy Shevchenko


