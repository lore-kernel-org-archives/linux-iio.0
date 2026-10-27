Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090032;
	b=dUXGaMbUz9ElhcVFokKYbC6RLi88pp6q5JjHPNEHNUDLLZ/M7o2al8BHUv860qlelEOw
	 AJ9VKkMZwrWgcJ8NAM7zUpyIqK0VaVMiYBj06ov8jbgzGwToctNE0s9M6VTyCELcPv62o
	 s6ray8u5swj13W049dhPjU2HlqwOFgWLuX+iRohxOWIPORNMqgQD4Ny7b8qUHQtDxLzxD
	 6EIdE1uUAJSA9Jm3cD8EbmhuJ9xxbmDNLzEiVz/0eTR+bwyu5if+1RQwht1S9bbLNCAyl
	 RDzHszrVovqVMlNwsTHcF1tQ3MRpkq2xcobUFflLmoKwrkrYFZamRh/1BFo/gjDeneQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090032;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=GKz/bTbuSpTLjDPQDrvOWOvVbLCLrHLKSU0PwbigsfU=;
	b=ohXZShb//sOeprH997Acs5Ymc/UIQxW0hMI/BiEWWkvLO+EfrWts1Jkl0M2bMhlrdDUX
	 JBexCg5VYpLK8OQ57fjcomeXpxHWdCTafWqZeG0kfGBfghkfEcUsKWcvMnCFKhjSeZ7Xh
	 CW9Ehzso9RV87lA9G4GI2kb+d7cvrLXUZNw9sduBVYKCdOX18N5wUdsa8IysWIHE5BcFG
	 OjBOGv0ETbzAEkp7rRRM1WbBM8G1a7xZRSDFKHIYvwxwjU2kwVOipvlpZGEHLlXjz+OU4
	 7fZGGpkZdW0V3y9D+3+xZq1hvohaLaZTfZELjZ6gL2i3modV6HTc9n4N66nz0GP2Pig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mme4XwA7;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0A606A31B
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 08:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3F0A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mme4XwA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793090032; x=1824626032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3u+BjVRWqQEKfI+JsRIvXSLKHl101C48hjFMfAQZ+Yo=;
  b=mme4XwA788WNJZHJA0ymToUL2kaPAXrDsUXvHqRNdzkB+Ea5a5d0WxD9
   MzTs++sk3HPkleO6AGNL+Ue07ntQLhvx9pbGX1elu1rybqo/rjoM61qgp
   PirY1NQCsfLAY7ml6DaGZxTWZVqYflH35DAI8GLTxH6JuIt5VDg8lJNvS
   giFHV8IS3Dlx38zLLZc9+0iDOYnUFDHYks5Ym5u0FlwFgs9eJm5cXjI6W
   /1I9f2rYMZPjWdjiAqyVoee5x3glg080aDOKPLzLVdCt2BAFkIhWLXcEC
   W+CPFwHn6ENasjDQbj+uuhTy67LVC0Ydg32xSeW9nh2sB3tFdakyNSVex
   Q==;
X-CSE-ConnectionGUID: Er86IAvoQDue8kFZirXKQw==
X-CSE-MsgGUID: aMAN3sDOSIKp/EXOdxl33Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1694242"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1694242"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:33:51 -0700
X-CSE-ConnectionGUID: XAWf24aMR3yJyh225IWkGw==
X-CSE-MsgGUID: cKhNpiuORdic5VfM6oX6XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6332489"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:33:49 -0700
Date: Tue, 27 Oct 2026 10:33:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Piyush Patle <piyushpatle228@gmail.com>
Subject: Re: [PATCH 24/39] iio: adc: hx711: use iio_push_to_buffers_with_ts()
Message-ID: <auBh6xwZA4JWyBp5@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-24-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-24-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:42PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Move the buffer onto the stack, local to hx711_trigger().

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
> -							pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				    pf->timestamp);

One line?

-- 
With Best Regards,
Andy Shevchenko


