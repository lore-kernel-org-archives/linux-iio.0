Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778243;
	b=qwinvdwzv4slTVcGERzzDEBwY3wLsGFPIxq7b5impqUpFDwuPtKTVa0KN46Ztl+bTQ2O
	 +gHQSr4hbtSxI8B1edNyYNd1d0wW4m7LJR6zfZWXqs0/WLYFMQc/afOg8Tr6d3D65CjI+
	 gQzopjth3iB85n4n77/MfXGyv9h1KY8Udok8R8hVzgDBC+fGxbWfz4Vbczan6sAZNkmvA
	 We5ufJwRk14H+PTcuxTJd3xiwOHMZy8s6zLCs3SEiipudfF9GbepES3kuE4A79PhO7Zc6
	 R1fkqEMi+2bVs8XZXb76XzzUsByJrEQSuwFvoWifZ0zhBJ/y9wC/2OupYx2uWO8oqGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778243;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=2SfUB9AsKnaOtsYBplCcPHv/GA84AEnVulBsWeK1iCM=;
	b=ZGWENoM7PgjHJmFRGyFmTqVTP9tE0QeMTrlU8uutBNQa0Vhhf8uogX80CmKODudxb+/D
	 GwQ+lZRMqDkPrsYML1tJzv4rwm53JI97h/+AW+TyeJF9UP2cDOZOptZkrvqKujgLS4iiw
	 7mDXy07Bc/8+u+deMKNNqb9JF1O9EZRm2YOX1+VV12zF41R6jCBXoRpqUXpreQc15rYS+
	 sTh1ptD9hK1qeo9/YgTgM6O6+NzyGFYv8oJHpt06v2Q0mNl/gBQi7Nmx2BQ4btTDkxh+W
	 l33w6CpnMqOs/xAaFi7wEDt4bE59EhDYcF8MibhvehT2CA/XxiQeAy6RIsC5zn/PIVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ggYoB/EH";
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE0606A31C;
	Fri, 27 Nov 2026 11:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40CE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ggYoB/EH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795778244; x=1827314244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BSa/EC9bI25mejnkJlHUoyPafBlsWY7+H1RB2E1yMA=;
  b=ggYoB/EH6N12M1ZYN8r+EDzFdNosirhY38jErryzFkbkbLrWjgPixiBN
   KkHOQ6EnhYK6jKONDlDli3SP6Sz93OeeN800lEapezoa0qkMdi0gL9dA0
   3+IWByag3lRegw4cF8D1MjEj8AiaZmEgHQSsvk15u2vG0ay+YbvDzy46o
   84BJrjzFXqhoB3xVEfZh7roIR3PMShwEQ3wFuesuJehh8g4+j4XfVgh9p
   ATYlL30hZMYUfDLLhO8e+4JB+joyq2lviFvanL6OvSeMdbHhfLmzh+Zel
   /Ah8+/sNCLh5wzq9970S4XzdjWsoEfAya4FPrntc7FATF6ICFLTdFEI1i
   A==;
X-CSE-ConnectionGUID: JAt3sApdQHekzDXa9qsXEg==
X-CSE-MsgGUID: HUTK6r8cSzGDcGzqlT8qFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4573698"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4573698"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:17:23 -0800
X-CSE-ConnectionGUID: w3fDEev/TbG11XLfgzAddA==
X-CSE-MsgGUID: NmtthEanQUqWtjCInFEJzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12982235"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:17:21 -0800
Date: Fri, 27 Nov 2026 13:17:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: proximity: hx9023s: fix division by zero in
 set_samp_freq
Message-ID: <awlmvqPOw3eppj3u@ashevche-desk.local>
References: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
 <20261126213710.1047676-2-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261126213710.1047676-2-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 03:06:46AM +0530, Arnav Kapoor wrote:
> hx9023s_set_samp_freq() passes val * MEGA + val2 to div_u64(), whose
> divisor is a u32, so the sum is truncated to 32 bits. MEGA is an
> unsigned long, so on 64-bit the product itself does not overflow, but
> the truncation does, and on 32-bit the product already wraps. Either
> way, any value for which val * MEGA + val2 is a multiple of 2^32 gives a
> zero divisor, e.g.
> 
>   echo 67108864 > sampling_frequency
> 
> (67108864 * 10^6 = 15625 * 2^32) triggers a divide error, on both 32-bit
> and 64-bit architectures. Negative values wrap the same way (-67108864
> also gives 0), which the check added by commit a318cfc08537 ("iio:
> proximity: hx9023s: Protect against division by zero in set_samp_freq")
> does not catch, as it only rejects val == 0 && val2 == 0.
> 
> Reject negative values, and reject frequencies of 1 kHz and above: they
> give a period of at most 1 ms, below the smallest entry (2 ms) of
> hx9023s_samp_freq_table[], so they never matched anyway. With them gone
> the divisor stays below NANO and fits in 32 bits, so a plain division is
> enough.

...

> -	period_ms = div_u64(NANO, (val * MEGA + val2));
> +	/*
> +	 * 1 kHz or more gives a period below the smallest table entry. Rejecting
> +	 * it here also keeps the divisor below NANO, so it fits in 32 bits.
> +	 */
> +	if (val >= KILO)

	if (val >= (1 * HZ_PER_KHZ))

> +		return -EINVAL;
> +
> +	period_ms = NANO / (val * MEGA + val2);

Can you find dedicated multipliers like

	period_ms = (MSEC_PER_SEC * KILO) / (val * HZ_PER_KHZ * KILO + val2);

? And seems this KILO multiplier has to be explained, as I don't get
the precision used here. Or maybe something even better in your mind?

-- 
With Best Regards,
Andy Shevchenko


