Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF83C76AD;
	Tue, 12 May 2026 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596627; cv=none; b=iVwinDBUxzjcrgYCkgBVGMtceZaHO9xPxAhNsM44r9Q98/HhlM4sEF488tIV5o3o+zT7zmVWMe2pUAtgXijXRWQUFoeKfUXs9dMEBfSCWynF5w6I2eGe6WNs1Zl28F7F2j7QsW9bCao6cFMdNCr+gDBGP2zhbfYK9kub5Ky8iDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596627; c=relaxed/simple;
	bh=n9tRuu3N7iLd1tEB24+w5l1tK78xIPXc0jV0xZqyd7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHrjXF0p52fXQIJ9JLoej/p9TRzBnSafKTBvedNQZ4KgfCNol7mLeL3NEBxfoJGZkWOjZzjkQCSYvXBh5U0L1zy42EsjVSxC/R6vCztpJpM20KRJxfUlg4tewLLXHNXWLxwM7LKLH2CBik7KdsscGLB2Cu2cJi3gyBJvzs3tT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ozd/4d/g; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ozd/4d/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778596626; x=1810132626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n9tRuu3N7iLd1tEB24+w5l1tK78xIPXc0jV0xZqyd7g=;
  b=Ozd/4d/ggG+By9y7tgFWLYRjSwClcwGzjLfWTun8NL5zUZxKio8hw6Mf
   EKC8Dnx+BCV9PPEwRl7UY6bvWZVCFJK5GxTS7yjmsE1SXWTZ6VC4jBh64
   TyOIryCUxqNHCph04S3xHeyJvgyZ8CUXyAQ/GhAZNapcxcFnpEU9pNc1U
   FQg/uxQAMYN2y44pIzFGem/46/mgLHRTe2EPpbnsmNjeW21dN8eF3O57v
   Os+Ks6d1VY38FiQ3qBM4umUu93FdsNQZsnvoY5LSHZVb2Eo11Tk3J+RqV
   UakELYqpDRvCAM5nGDUNMIuJ1SkL2O+076Yn8VIP7T0RVWqS8VlWzYJLt
   Q==;
X-CSE-ConnectionGUID: OUqZiRu+SWWQ9oZvetL0sA==
X-CSE-MsgGUID: 3P4vNBn3QUSV69+yUnjBGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90969764"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="90969764"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:37:05 -0700
X-CSE-ConnectionGUID: hutQM0+SSL2Qlydyc02OIA==
X-CSE-MsgGUID: Dgl4yHWjQQiYdbf5vLYcVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="241784544"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:37:01 -0700
Date: Tue, 12 May 2026 17:36:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 06/11] iio: test: iio-test-format: add test case for
 decimal format
Message-ID: <agM7CT4RjzwliKmb@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-6-34af2ed2779f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510-adf41513-iio-driver-v12-6-34af2ed2779f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 01:42:24PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add iio_test_iio_format_value_decimal_64() kunit test case for decimal
> value formatting, exploring different scales types. Also, the same
> iio_val_s64_array_populate() macro used to populate local array is used in
> iio_test_iio_format_value_integer_64().

...

> +	iio_val_s64_array_populate(24, values);

You want to test this first...
I think the previous patch needs new test cases.

-- 
With Best Regards,
Andy Shevchenko


