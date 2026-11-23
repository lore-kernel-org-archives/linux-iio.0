Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432277;
	b=XzY+Bf8W4mTwvHG0QaM2uxSjK3qaCnpPG8tdArG6LgMqRTqevhVASqxamji7Dr2Gv6fw
	 XPkDzSNp3AgXkWgAzmPLD/fEzbsRLFw/+oL/F2pRSrYoKpnsy7gIcwo6qb4ujvjqmwZCV
	 kj+pJoyLSQTLyDvkbt0V5uLQuvQ+EO0Zoi7ZRdGyXNOrh0A+cfoEhZcqSo2b+el8mzoDQ
	 AZzKmpq11eUNDzq0z7xjwI2ysAGwLDEbdJoEOF/hCM4oh7TSC+FXH9uxRnJk5ylC2TyDT
	 oWoIkmtQcVmlBVfldELuYsJ9gFp684+idIeQhpk3+zCgUfSm9lir3LJ8PmBgIWivkTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432277;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=+2mpNKtPeOzO01n8vIXZER6Fe5vylz/N9Hs9Fo1I4l4=;
	b=E1hEslOomhTErXlyQbZNCoY67jzAAU6tf6hMuSKOGsy+5SzibFQoHAThZOPlkl5mkvql
	 eOBFHlfJCw2w5BleG6UQo12e5qSB91H4tfPNTJwETkICxE80fpPNOI/+uOYu3rt5o0zk1
	 BoaRYLPP4R/nbIXAKCnVucjzyHW/tcClIpLM0CV9k5D0dUOpsMVHpZ01L7kGu9vKXhbbz
	 /GkCVnWGJXL6nUrlCREIMTngsyzHThKyfkeUCpQLqzSkwKVk5/v4c9D3HwAarlKG+72e3
	 3yN9xgjCB57htZi2ttJhCLtGXHpVApVeBKJHg2UqA5sQu7eCvcaSQpOwhcUhmrZki0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FsIbKMhy;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489BE606A33A;
	Mon, 23 Nov 2026 11:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 489BE606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FsIbKMhy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795432276; x=1826968276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=obV+BTxi/AUalQQHOgFOoauMrPLv2UnyPj8VmY8Q4xg=;
  b=FsIbKMhyA5of295K89LHFTC06Tl9nP442qDxvIULDr025gOlPSnSEs6I
   9rVcJs6Nu/U24xeXk4aVIBi9a4GwG8vL+UcEdbjKJ2WJnMLtCxfRUqX6v
   jTrS7f333aWzVb0U825sGM98w6Qc8toFqN4wWtEex2Gzejjg/pYP54r8J
   FIuGkxwTVnXM0TSEMqdc6oL9coE5ITHFH2SyJzmglpXCddTFP3R/afg/W
   8sSSk8rBDcRgXjVTIJZV71IIqdPAIFYMsr7FGED74Tu0wFPeExvqwz43g
   GEDA2Shl4NOyaRGyErlm3+Fb4fnvleUmrYSxK01Bf0x2/M207BYs7TL9a
   g==;
X-CSE-ConnectionGUID: M71/fxk+RtWgrZAAzYVTUw==
X-CSE-MsgGUID: ZkavJ0ONS0CRhAb20zIHZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4128599"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4128599"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:11:16 -0800
X-CSE-ConnectionGUID: 4iPQpwiFRKmAT5sUwSQgUQ==
X-CSE-MsgGUID: vjjTVDKJSp6WJEGSBfmhnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11370798"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:11:13 -0800
Date: Mon, 23 Nov 2026 13:11:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: proximity: sx9324: fix proximity threshold
 writes
Message-ID: <awQfT6jSKo9pjxjU@ashevche-desk.local>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com>
 <20261122074649.239441-3-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261122074649.239441-3-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 22, 2026 at 01:16:42PM +0530, Arnav Kapoor wrote:
> sx9324_read_thresh() reports a PROX_THRESH register value r as r for
> r <= 1 and as r * r / 2 otherwise, and the division rounds down for
> odd r. sx9324_write_thresh() inverts that with int_sqrt(2 * val), which
> is one register value too low when 2 * val == r * r - 1, so writing
> back the threshold read from an odd register value lowers it by one:
> setting the threshold to the value it already has changes it, for 127
> of the 256 register values (3, 5, 7, ...).
> 
> Use int_sqrt(2 * val + 1), which gives the largest register value whose
> threshold does not exceed val: for r > 1, in integer arithmetic,
> r * r / 2 <= val is the same as r * r <= 2 * val + 1. The result only
> differs from int_sqrt(2 * val) on those edges. Checked for every val
> from 0 to 65535.
> 
> Also reject negative values. They are converted to unsigned int, and
> 2 * val wraps at 32 bits on both 32-bit and 64-bit architectures, so
> e.g. INT_MIN is written as 0 and values just above INT_MIN as small
> thresholds instead of being rejected.

...

>  {
> -	unsigned int reg, val = _val;
> +	unsigned int reg, val;
> +
> +	if (_val < 0)
> +		return -EINVAL;
>  
>  	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
> +	val = _val;


Why not simply

	val = _val;
	if (val < 0)
		return -EINVAL;
	...
	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;

Note, reg might still be not used, we have more validations and with your
approach the reg assignment is in the middle, confusing...

-- 
With Best Regards,
Andy Shevchenko


