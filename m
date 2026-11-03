Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728515;
	b=o5p4lmtH9s/GdlG0b18HBWc5q0zMrgsf5PCecMoUrHp3ZPM/Gpbue2DjERpubOWPentC
	 sfJkHLdwSQbeMCnZ9IzauOI/SDVuwBwsmY7KabbIgLhkSkoVjQVBqBwG8X9v50CS7G/hC
	 QUGv4SHF3VkglsV6rtUNRQxfDleo1RZGni1raKHFDKx5QcY7OyMpWhXRTJ7tlXqdikp4N
	 8+vJBIGgVNwzZ1tjgQBehJzGLL+V8aFochcvHRINECU8bBn7Ctds0H8oORhkAoSrvEqZV
	 NfPT8cAdxCXQUc1FyeB0TeKmW4zHRiV4IQok9XxCPPkhf//ewjQXhCZe5riFYVhpotA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728515;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=vOBzh56n144noKV3PHaLSH9i92DpO9KzWkaNh52aE5U=;
	b=uomyKOVfJklOhrglRAPPiFusNvMWQaNOV8NLbzugKBw8qY8FRYG3lSdwBzBLpYNxptKY
	 LibPkSoU5DKdJXt1k59Epi5brXNd1Idacl3ep6y9x+9vRkKgYIMfEZO+4M0XSzEg+Wq0x
	 BVJ79QU2+YByWBlKP1TrFCnZCBSMpMczj5a/ZLGDa8qfzCC8xI1mFMWccqwKcPdknFL3j
	 wzBj1A8HvrDrkpIkLcPTx57g6llmuHhZmTEnzLFBq6ujJzC9sEp2xwnDINZYEqlYtkiac
	 ytT3NgwCh6s9k1Hxfw62S/xJfiUHgaIfD/kqGoe5bbv53dFKiDeGnJYR3SG/+GOvz7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lIlejqV+;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B910F606A31B;
	Tue,  3 Nov 2026 17:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B910F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lIlejqV+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793728515; x=1825264515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PPR82qP108L5LZRNQMAuw9rFplyvK5ROnQ8wqU0r73g=;
  b=lIlejqV+ZT4xcy4XLknuKM2qYsEzTqPwKRHidZFIQX+6e3WHg0ffwSJw
   MJT0EYNhSSDPbKl9Ck4M4+f7m2OlMAmuLjuscF/OdSIpHfd3VwobnWZ9n
   8eH4c82zcJWqWVRJltpasXGD02sAJl7IEFVkwwIK8a55YGxdMlLYAZy1H
   N2fmB8Zeu1bWxvE6Es73urziP82ONE0K9n1+QGCzhjHihYlg9Ta/vi7MX
   dfumilW8HqFwBRBuIcQn+o9izdbfbLSBYd2Qf15Y59R8OXv8noHcn6Fzj
   5ro3LH/zCx7rUys/frPeCo0eFOFRdCDt7sg0MqElLW+mrraeHFxIrcYdH
   Q==;
X-CSE-ConnectionGUID: VdDztN+2TfKq+qPzCu1U3g==
X-CSE-MsgGUID: o7991mqxQmWk4k1htxuhRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2556269"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2556269"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:55:14 -0800
X-CSE-ConnectionGUID: LUA5zw7zQbeWTPB/+KpGKw==
X-CSE-MsgGUID: h/Hy8qUXTBa6bFdBUz0dSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6501189"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:55:12 -0800
Date: Tue, 3 Nov 2026 19:55:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 2/7] lib: kstrtox: round to nearest, ties to even in
 kstrto[u]dec64()
Message-ID: <auof_hMbsbFq3MYj@ashevche-desk.local>
References: <20261102-e-notation-v5-0-d399e544a982@analog.com>
 <20261102-e-notation-v5-2-d399e544a982@analog.com>
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
In-Reply-To: <20261102-e-notation-v5-2-d399e544a982@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 07:41:00AM -0300, Rodrigo Alencar via B4 Relay wrote:

> kstrtoudec64() and kstrtodec64() drop the digits beyond the requested
> scale, which truncates the result toward zero. The error is up to one
> unit in the last place and is always in the same direction.
> 
> This is easy to hit with values produced by userspace floating point
> formatting. Printing 0.3 with "%.17g" gives "0.29999999999999999",
> which is parsed as 299999 with a scale of 6 instead of 300000. With E
> notation a negative exponent can also drop integer digits, so "19e-1"
> with a scale of 0 gives 1 instead of 2.

To avoid unneeded brain work it would be nice to add an example for negative
input, like -19e-01. And I hope (and it seems the case) we have test cases
for that.

> Round the result to nearest instead, with ties to even. This is the
> IEEE 754 default rounding mode, as used by strtod() and printf(), and it
> does not bias results in either direction. The first discarded digit is
> known from where parsing stopped, so no extra pass over the string is
> needed: the remaining digits are only checked when the first discarded
> digit is a 5. Since round-half-even is symmetric, kstrtodec64() keeps
> rounding the magnitude and negates it.
> 
> Inputs that fit within the scale are parsed exactly as before. An input
> that rounds up past the type limit, such as "18446744073.7095516155"
> with a scale of 9, now returns -ERANGE.
> 
> Update the existing truncation test cases and add cases for ties and
> for rounding at the type limits.

-- 
With Best Regards,
Andy Shevchenko


