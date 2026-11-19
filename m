Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081743;
	b=5bLKs/E8NNqgVSTXGFQwuwZvjQuJVRgMmWnzv4e2Zl4kMigWtCo5o+TYP302xXbHx6Ta
	 bit263AZROXbl+F4pcCZ0hflxPqk41zCQw1tHPdZ++v0zWuwNRVyOZG4k+Lwt1rTbacyg
	 O80SK3PM+L6ftP5N0a1JZnErs9749x3OABqcVBgOmPt8gAFoAhaWu6ecHogOrG27qvxKW
	 ETLq6G1uty4FXKmNvf5EFNcw5ELhpEMojiv7M+NByJarVu/qGHoAH4VCNBvZ0+MjwIkxI
	 8q22ou2NNya6gUkgRrkWxjMjf3sBwWjpEYufWfmr3ftuTtIZe1ODnqd+IsF7+vzZG5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081743;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1nDJYr4TG0cwd2A72OI8oxfC7BJORiNfmqfaaL+CdVQ=;
	b=l1+NgnKWx9SNVo22HKxJkTjWFNlALlidZ1AXMCdfghUpN4xekgZ73Z3udy7SEEU2Cvcr
	 +kX8saNyNEuoVWeFeeNQEhkpR6SxE2b8DyKWIxSwoPyq8EhtutIJ4ZVDaiuNaCR4rjlXD
	 ySrU7/NUfiEvoOCRX69yzIN2qOY08pRr5YMbsy4MXigvd30u4JemdtyRxHF4mJNDum1/i
	 fIDUW0u1BsCLE58I4ClcKU0fFyIm4Mq1/90Vz9xEAyFkAt+29y+nw2dl1X1ck5z0aCkvs
	 g24Z2RrgDpyoRxQqqMFFmK4FxMuUr9L3eZZVwqCx1pOzQWMpxGhsHF+Nh6ksPTjXnWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="jw/R5E1e";
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24B606A325;
	Thu, 19 Nov 2026 09:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A24B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jw/R5E1e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795081743; x=1826617743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nCzuL/GPq3Fhwivwu4erI9GwEg6PC21a5Sy3BiM7NY4=;
  b=jw/R5E1e9k8GVHcejV3crF3Iy3TWT+ZfA4oDaImaXfpQufbFrpianaK3
   KpbwKEPSA/CF5Xvss3ExPn/83fycQ0gI1v/qDRoioHzH20/lsU0s8jJop
   TnH+6TazOPT+hgaVkp1lsVgeiFFlsANvIrL2jEsf3HrzcZitWXfzHp4u1
   iDR97gLUFXQxRh7J4r5sFuywrL28aV4arMZ33C0F0lnO8poKleLuw9uXA
   5UQb/JycSCBBbsZF3VE6Harfw/8pEWRYYjZ9uuUUPJur6sA+roX8nsg5C
   2/4me42LN84Anp1UF9YhKMKp5AvzLlFmHHcTMrDNSSqElrgcBO4rQX+JE
   Q==;
X-CSE-ConnectionGUID: MNngWHYbQtycWkwaPqF2VQ==
X-CSE-MsgGUID: ZhcWlf+hTRS1TPxn4z4r0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3917621"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3917621"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:49:03 -0800
X-CSE-ConnectionGUID: ntCVTzcFRKi0/VusfuehlA==
X-CSE-MsgGUID: 1mOuvQ5wQu2Z0FQyyUDtXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10279243"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:49:00 -0800
Date: Thu, 19 Nov 2026 11:48:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Song Qiang <songqiang1304521@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: rm3100: check TMRC in
 rm3100_get_samp_freq()
Message-ID: <av7GCa_copMyGP4F@ashevche-desk.local>
References: <20261118164106.4108794-1-maoyixie.tju@gmail.com>
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
In-Reply-To: <20261118164106.4108794-1-maoyixie.tju@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 12:41:06AM +0800, Maoyi Xie wrote:
> rm3100_get_samp_freq() reads TMRC from the sensor and uses the value
> minus RM3100_TMRC_OFFSET as an index into rm3100_samp_rates[] without a
> check. A value outside 0x92 to 0x9f reads outside the table. The driver
> only writes values in that range, so this needs a chip or bus that
> misbehaves after probe.
> 
> Commit 792595bab492 ("iio: magnetometer: rm3100: add boundary check for
> the value read from RM3100_REG_TMRC") added the check to
> rm3100_common_probe() after a crash on failing hardware. Do the same
> here and return -EINVAL.
> 
> Found with a CodeQL-based static analysis tool that we are developing.
> Reproduced in a userspace harness under ASan and UBSan, which report
> nothing with this patch. Not tested on hardware, only compile-tested
> with W=1 on next-20261116.

...

> static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
>  {
>  	unsigned int tmp;
>  	int ret;
> +	int samp_rate_index;

Preserve reversed xmas tree order.

...

> -	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
> -	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
> +	samp_rate_index = tmp - RM3100_TMRC_OFFSET;
> +	if (samp_rate_index < 0 || samp_rate_index >= RM3100_SAMP_NUM)

Wouldn't be better to use ARRAY_SIZE() if possible?

> +		return -EINVAL;

Maybe -ERANGE?

> +	*val = rm3100_samp_rates[samp_rate_index][0];
> +	*val2 = rm3100_samp_rates[samp_rate_index][1];

-- 
With Best Regards,
Andy Shevchenko


