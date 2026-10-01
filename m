Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285F472554;
	Thu,  1 Oct 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882455; cv=none; b=TUoYTYJ6XygfwFK4CikQ90oQfQHo7QLXnyWnXPgnmv2K991oakfypw/PV2FyXQPxj8TWL7SaQy/mKlpSynfvCUOjM1dv1m5IC4BvllK4eLpWBdEA0kuh4kxlnTaORhxpLosLk6IFRbV522um3gNdBzJmYHc59TjKbj5ldGFUHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882455; c=relaxed/simple;
	bh=fma80QKfS1HbQk1sY9MPxh1EoCg9IQFBKBL01ct1Hn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaHVhmm5IeO5wft42vLJOHaByvGOtjNLubBXpSAY2IK21S1CTha8rmgR++aYoBHglkm9IF9mhKZGDywv9mPqY31lem5c8kqlpRc/ftoPg723Z65OJ5drlmVzPY+mtKcp7ofRisT5TCsEC1v8caFOGRnL+l7Gsh5rDF1Gt2jMW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MV7BFiVi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MV7BFiVi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790882453; x=1822418453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fma80QKfS1HbQk1sY9MPxh1EoCg9IQFBKBL01ct1Hn0=;
  b=MV7BFiVi6a+evF6j33W4HUzh6l/i7fzV7+sxPUV96lR5nguMhiG+8wAq
   eK4nK7AzqU7L/+jdkNoRzuZ+pZp1hFm4N3GHRbxHipHHQu07Z7lPGUvFg
   fRBWbmdzcMoswyhq1++KurNvFsH7k5FDsoA6rHiEjn7Vi8Aeur/YuFJVi
   7Sy/XsjqUlDGojdrJPRH8s+f+ZqfW9dvWqyGa2kREaQnc2knY92BfmeMO
   zwXUGpPsVnWheVIPkNTxAs4OJSJi0lbVLtuVy/Accwz+uC9GAc5aEfOGc
   O+izVDFvjdo3s0TP8b2zA1fqO6fiUXGiM8wqhM96lrp54ObOdp31K/YB5
   g==;
X-CSE-ConnectionGUID: ovWLYQSGTKKI+wmjqPtyqw==
X-CSE-MsgGUID: mmAhWujgRHe6SlMWof0mtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91753880"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="91753880"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 12:20:53 -0700
X-CSE-ConnectionGUID: FQ7MlkvTRj26Q+2S4rO9aA==
X-CSE-MsgGUID: T1ujAVfnQZ6+r7P4pqEaww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="152429"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 12:20:51 -0700
Date: Thu, 1 Oct 2026 22:20:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] lib: test-kstrtox: add E notation tests for
 kstrto[u]dec64()
Message-ID: <ar6ykJxQBAN9OrRS@ashevche-desk.local>
References: <20261001-e-notation-v1-0-75187bf06c10@analog.com>
 <20261001-e-notation-v1-2-75187bf06c10@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-e-notation-v1-2-75187bf06c10@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 12:34:57PM -0300, Rodrigo Alencar via B4 Relay wrote:

> Cover E notation parsing in kstrtoudec64() and kstrtodec64(): positive,
> zero and negative exponents, upper case 'E', an explicit '+' sign,
> truncation of integer digits by negative exponents, large values, and
> failures for overflowing or incomplete exponents.

...

>  		{"0.2",				20},
>  		{"0.18446744073709551616",	20},
>  		{"1",				20},
> +		/* E notation: exponent causes overflow */
> +		{"1e21",			1},
> +		{"2e20",			1},
> +		/* E notation: no digits after exponent marker */
> +		{"1e",			3},
> +		/* E notation: sign only after exponent marker */
> +		{"1e+",			3},
> +		{"1e-",			3},

I would also consider something like

	1ee // double 'e'
	1e+0b // an attempt to have a hexadecimal exponent

-- 
With Best Regards,
Andy Shevchenko


