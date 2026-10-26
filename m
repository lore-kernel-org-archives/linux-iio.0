Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044103;
	b=AHCc9S83LG1SxgByQj0nRddXYyvjb3EigVFak9RHDej4lelevFbgRFRaT7p3uph6fP+s
	 9D8726vrQhe7Lnc/g7itDkkw8WpZAOTDndJYrbphRLL4nX2QBIZA/F97AGqgQMpjQhvJP
	 wOP93q0ruL4HbsYEUaGOCLF99WBqSWaYmpQ3ss4hz56dF1Rf8ngm02IsJFcpl50Niidv2
	 u3Q+KAg5ifZpTdk3nZmjnuMaLrdyxFWXiZLwPpWGl91Tl55E4yNPHJsTNN9jP3Kz+yIcy
	 tFOmnv1JaV5grtPcz8MSGmz12qh2QRIO5T45ehBJTTewq5jcZhth6KlhWmIsrXoOMrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044103;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=5gIl0t6kJCxw2MNLMNSbR+KgSku/5SVUrggtOh2gw7g=;
	b=vG+WY61LBf1xIW+FDjLS8gwVkbhQF4pxupGfIEtwv8UhoDJbl7Xek//Bx01zvxoVQEtg
	 +UZDVYn0nzDP6p7rPTb+2FvtN86W37fbQ6jgkM+D8QOvgTq0Z1FJQ20R3kgs0Y6N3rQaE
	 Zxtu93kR4nLLxx0oYg+50gi9XuREWqSL1Br6D92fofwH7rrtU/OpnV0EBk7OPz340YQCJ
	 Y7hYhf7JnKTkJOX+dEi5OHOw1dw0be0aWNbgymkik1/KY2+CfAx9rSXrGv2plgmndzIXZ
	 5uNkYfXF68so4fYnOOfzPZOMoo9B9j084CYWkpeCXq/41xeAOrsshYG68DVYBk6JZqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="n/l4QQ7c";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B7606A31A;
	Mon, 26 Oct 2026 19:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n/l4QQ7c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793044102; x=1824580102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pt5t8K/pIpbSSx50cuHnBxf5hCIfQ1RsdhJ9lGlqrtk=;
  b=n/l4QQ7cAM/33rSmNpi89VlJVko3UYqrm4zREJUu0+nhg+MMCZ6hpuNf
   Rxlre0wRosbA0xQjCdFyIuFBUAmV5vXoZQ9Tp+1UInFStxVbSdperIeDS
   IYLHuTtXvi+Vc+HrtIdpbNz4gGOLzg4Pal6j0S1XT+2EZp4Blsf5pw6Ym
   OsOeMtuV6pGcAzIQsdC6DIEHTRdPtCgxhC1CKj3TpGvLqHaLkzlHLYRpj
   gonsTKHgK1jODjnndedOTk8/Ng0bHTD8Hk9hfW4Z1DwwuvtYHtR+bKm6g
   nuhGp/lJaXcWoNqHpIbbegDO58cmiyhoBYBfp1EfTHxRWcIX5chNXF9qZ
   A==;
X-CSE-ConnectionGUID: 5ezgg+jiS8yxOns8T0FbCQ==
X-CSE-MsgGUID: shL4GuuaQW+r3LhXDzD0ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1733712"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1733712"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:48:21 -0700
X-CSE-ConnectionGUID: wYcMSyN3TkOuTFxQ4XQvxw==
X-CSE-MsgGUID: cd3MrB2mSx+36nNCMKn/pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4746044"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:48:20 -0700
Date: Mon, 26 Oct 2026 21:48:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <at-ugcvhOmPFpJP6@ashevche-desk.local>
References: <at8g26_l5JVbqs2i@ashevche-desk.local>
 <SN1PR12MB25284A3A9B89F3CC50689527A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB25284A3A9B89F3CC50689527A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 12:06:36PM -0500, Victor Chernyakin wrote:

> > > regmap gives us the two 16-bit registers in native CPU endianness.
> > 
> > It's only if you specify endianess for the whole communication of regmap.
> > I'm too lazy now to check the original patch, but if it's not specified,
> > it means the device native endianess, whatever it is on per register basis.
> 
> We do specify it, yes (the chip is big-endian).
> 
> > > If the CPU is little endian, that means the overall 32 bits aren't in
> > > __be32 format (because the two bytes in each of the halves are swapped).
> > 
> > But yes, even if you do it in the device native endianess, it will still be
> > a pair of 16-bit values with the halves being swapped in case of treating
> > them as a single 32-bit value. This is unfortunate... So, basically this
> > needs to be elaborated in the comment above (where you refer datasheet).
> 
> Can you clarify what you want elaborated? (or are you saying, *if* we
> were working in the device's native endianness, *then* we would have to
> explain that in the comment?)

In the comment you can add something like "We may not read these
two registers in a bulk transfer because they are 16-bit wide and
the byte order in the compound 32-bit value will be wrong."

Yeah, we can address that by swapping 16-bit parts, but it might
make code worse to read (and possibly affect generation as well).
(FWIW, we have even swahw32() for that.)

...

> > What I meant is to compare decomposed val64 as well.
> 
> Hmm, if we only worked with the decomposed values, I think we would have to
> write something like this, which is probably even worse...
> 
>     if ((val < fdc1004_calibscale[0][0]) || 
>         (val == fdc1004_calibscale[0][0] && val2 < fdc1004_calibscale[0][1]) ||
>         (val > fdc1004_calibscale[2][0]) || 
>         (val == fdc1004_calibscale[2][0] && val2 > fdc1004_calibscale[2][1]))
>         return -EINVAL;

It can be avoided by using a helper to validate. Also the meaning of the outer
and inner indices is clearer. With one-dimension array it's unclear what those
indices mean. Ideally the outer indices should match something with datasheet
and in some cases can even be named.

-- 
With Best Regards,
Andy Shevchenko


