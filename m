Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942760;
	b=HFnlbZxi73LbUx+tflr0LIaNhgLd+8VG6lwWa7/o9/WAujwH/MtrYITtDxzdKt3eS/Ep
	 cDCEqnlc5k1JCEHK1E7baHScq6Q1v3EKmJke2TjoX8a4JrMLlVttptVSTHbijcX+H/Nfz
	 BXL/jej5aVfsN+1nYzfkf3cBIRcGCqbZxbUlB7vBbuIu6jO8JFl7NqJ3Ewl7HKL6xj2Wr
	 lUoJ8hC1D3OyBg4QAnpl2tEhspiG+WhfRUOJ19H+bG6N2TWiXVQZxnWVEoA6ovYrMv2iK
	 uZtFRhOkP6Nr/bp7EN4Ep5fx+eaDiDNS+UW0OVYAbYH2wPIEABFFan5RD7hreUAnmGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942760;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=wwK8f1ftDI3JQxElQgoHCVKxTh4XeAHbtI8cNy1B1CA=;
	b=EEob4gskU1rXXoZK6UzbEZaXV7zhgWQJA6hMKAAA+F5fPdf5A46bFcE3qWOmr6N2SahW
	 /GnGSKNU20R62gnWuejPRNaJCIaqObPfT+GvKfoMcRSVlSdHy4fccDQkcvk/iqH2KBOcR
	 CDQdrbl+M/9L/ZEBQqkeLAtaj71YC/iJoP+RV7tV48Y1kDFXz2v/woOT0GnDqhc2coIEV
	 12XoVc9LyOHXSp7PnrnhKbMVZW7fTyYTrf7GHaLZUIyWdRIzJ81TjEdtvOFbFBZQ6fQz2
	 CShGcihIEBxsw1RDWmmTiczv16BniMjJvzyB5h+Pjq5ni3od0pGvvpJVmyhsLIfTL2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CbAWBNH9;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2301606A31C;
	Tue, 17 Nov 2026 19:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2301606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CbAWBNH9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942760; x=1826478760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jc/NclmTD85NteXITn7QacW3p6/ESnNHfFIdkZY4kIw=;
  b=CbAWBNH9ttlhYfsgXkWyRbn7cj+iHfTbvRGD8O5EktalpfktATz2p8t1
   5LM++QXQxxpJeVrsqQRls3eFQHin4wurH66vfQyQ80uD2jWaLYZSlGE6w
   DHUHrk7SzNB3iD0bZSCseI4FtqT8050XMPQkMcs1dAbkIKjrYEGZmQC7x
   Di/16sgZEBPD2TNKXmjqodjw/LAFjyM9bOC/dVTOzh/aydo0D8aZQ8vJu
   vf6gyjECILxXI7rXnyifnKQDn2UNnc0fPFmSo/knkc5s6kWHWy4lmRsen
   tyWoIFsLTimltpCFyr7seASAt4jfFAg08iv44cibfJY29NgR+HG073ejr
   Q==;
X-CSE-ConnectionGUID: uC9ZHX64R4CayYI7VfhNqQ==
X-CSE-MsgGUID: uxyoNpSITxKhO6x2soDAaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3581445"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3581445"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:12:40 -0800
X-CSE-ConnectionGUID: 9Do1u1TBRhO0tsLUrh9WEg==
X-CSE-MsgGUID: wcnQ2b8rR/CA7BreRp7SwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10170484"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:12:37 -0800
Date: Tue, 17 Nov 2026 21:12:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: proximity: sx9360: reject negative hysteresis
 values
Message-ID: <avynI5oa5e2K64qH@ashevche-desk.local>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
 <20261116205320.26070-7-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261116205320.26070-7-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 02:23:14AM +0530, Arnav Kapoor wrote:
> sx9360_write_hysteresis() copies the value into an unsigned int before
> comparing it with the threshold, so a negative value becomes a large
> one, passes the "val >= pthresh >> 2" check and sets the largest
> hysteresis instead of being rejected. Return -EINVAL for negative
> values.

...

>  	unsigned int hyst, val = _val;
>  	int ret, pthresh;
>  
> +	if (_val < 0)
> +		return -EINVAL;

Same issue, checked variable which value has already been used.

-- 
With Best Regards,
Andy Shevchenko


