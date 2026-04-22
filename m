Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0343F164F;
	Wed, 22 Apr 2026 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886660; cv=none; b=nOoZ6MBVaY5PKJ4puzjHx/XMfeau18p0jx9o5V/nFAZxxnLIHIuM2jmmWOe72s7hwoYn5Pef7nHCBQQFZ0+xeazguDGwxXECg8g2rzrwcCuFaROS3zMNYAJr8vw5uLmYx5wwVavfA6KPxqxOzW5w5tCTXq2OGUMDd1Ss0HJKTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886660; c=relaxed/simple;
	bh=qJurq+cjd7BxyxQ+jVSJmq02IrkyAl3nQuSa6W5jJL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh/vAqPX0RQmNNVXsyzxrRaBxIudWNfWKpWkAoUXSOe9EwvtAEwM45RT4A/+mL9xVOPX7lni/IxEL6UItgNpb72m0jMu5q9mkvJcFGP2WnasZdbyLMT+HDgcYFcoRWEf0GmQnEIYgPskDs4CyWWwG8G5LYfsLg/n+33SpFZp528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K69CM3sq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K69CM3sq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776886658; x=1808422658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qJurq+cjd7BxyxQ+jVSJmq02IrkyAl3nQuSa6W5jJL0=;
  b=K69CM3sqcRLwfg2PkqKU7+xa/413WJKQm11yxkn/FPGb1ofz/YaApFwr
   Vb2iv4pdoPD9OfUUcQD5c8sqQmF8KUFSzriBMo+Z2CBCCD8iVsGJI0Phf
   gFxq3vXp6o0n5abDT+A8ZQXh9lGK/UFlZqH9PF4ztau9jSkcqdQal0g7a
   eIBZB4DIhJ7APv+MxH/ido6/y/U3nXv9me9Pr7alDd5mJfIJYDXsFUyLN
   T6ojTcnkleznuSWetq9LD7si9/jzBkB3luoActFi1cahs081s9+8EyYFX
   5OVovtfz7/xnCr9H0n1sfzgHAamM+ROVoX3a9fTF51LKaykGZ1SCsTWG9
   Q==;
X-CSE-ConnectionGUID: LXAr7DSkTDyhGp+9chySAA==
X-CSE-MsgGUID: OfcRV0nuTU2lPsyklG3sHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77912339"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77912339"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:37:37 -0700
X-CSE-ConnectionGUID: /fkV/rH4QQyyrhIrA+9NzQ==
X-CSE-MsgGUID: OKbwKThhS4u60QrBwg4QAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="228101969"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:37:35 -0700
Date: Wed, 22 Apr 2026 22:37:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: accel: mma8452: Use dev_err_probe()
Message-ID: <aekjfPR7JksBESxX@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
 <20260422165643.2148195-5-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422165643.2148195-5-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 10:26:41PM +0530, Sanjay Chitroda wrote:

> dev_err_probe() makes error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).

This patch should go earlier than dev temporary variable one.
And dev needs to be introduced here.

...

>  	ret = regulator_enable(data->vddio_reg);
>  	if (ret) {
> -		dev_err(dev, "failed to enable VDDIO regulator!\n");
> +		dev_err_probe(dev, ret, "failed to enable VDDIO regulator!\n");
>  		goto disable_regulator_vdd;

Before doing these patches, please fix the mess with the devm/non-devm ordering.
There shouldn't be goto after any devm calls.

>  	}

-- 
With Best Regards,
Andy Shevchenko


