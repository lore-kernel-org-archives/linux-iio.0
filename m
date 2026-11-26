Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706047;
	b=R0SYDMnMc5/2K/xuSMc+Hbcwu2NnKGVXIn0VIkee+q0pwjlDbUbAgRm0jqflsI17JXMq
	 n2Oo4VWAz1FEr2cUfXMt4WFZ2nXxPBzXEMPmD8w5Ch3ikF3Oc4SlOmM6et2RT6dL8sI7t
	 nf23QOJBp2Y4JMvqvOSHec3fJIWYLfLKwqkl+f2I5O3LE8ra9j8NFF6buaTReYBs+ZVCk
	 TnZ5XZMyOmNgj3N4pcIj59p8fM4e8FkA7VH7cVTKc3RIzQUVLB7b8P+bWOBDpWgY9qyBy
	 WrBoYtZQBQlS5pfBG3czBx14bQ+nQmwwEIjOu6nsStiM6YP86W0cYYCQJ6cCAfkh1wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706047;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=hEkRAUfnKvs3rHRfiWh3eAIsGaDREmkAPVhmY+7gVqU=;
	b=EVhDefMXVY+SWePcJBkzOY126R8kvr8D0xH8x/oUMzoRVsTC3dsp77/dNQZ7wUYCDmOY
	 k4XbWGbJCvGnGkQYPX8B3Ky0Q+ZHRZPygkQMkDL/vL5VZe7cH9CWj2h1b9ezAhcfy7iXw
	 sFw1D75LgEIqOYSr1zPr5zbG7mlJyxYSlo43zKZ64sxCzavhnRl3e8lRhgMqwhR8Gu9wo
	 DSiaPQ6wH2Ufvrr5TVnLEVCVWfYUZ1BAlkxqMegVt8ZrBCq5WpO7b2eopB1BmR62gmHOW
	 yremDmWuJu9nbHCoy1a40jB4TRtme8t1Ks2h429/owcMljCeSC3ycJ0U+0V5D0Lppvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f7c10ISg;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB8606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 15:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19BB8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f7c10ISg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795706047; x=1827242047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=llZyzvpE2Yg+J6yUesIgrGL1ELY5gbqOF6V6pcKUMKs=;
  b=f7c10ISgFdsymTatKIfblpRt7rKNHJA+pU+5L6KHDCVXea5R7a+CZhqw
   TbKCm1VMDOPGJa/oYqbGrwXzeqvZPE7pfDmnHvjTMAMqFXq990EX4hltr
   yfHzktqhSaIQ+yw0oJOfCkTdr4VLeRjtXZADT+i+bLC5tRR8iJvn/hZWN
   f80wXa+tm2cLgGdrs6ehoxhi18Mw9RKUuD9WDKH89zIkZWFWeZtC8y2tO
   3Zby3BGEtNiuRtcSYEGJQ0OK7CrArfPl05JSYfixLzx8+7beHWfX0ZXyq
   ihUDDc1/a/ublojDbaRB8eRTyjEnrATk/zqQgo+1ZN29J6SEp6UqXpBPy
   w==;
X-CSE-ConnectionGUID: /Pw9rdRHQZ2NK7idAngvYQ==
X-CSE-MsgGUID: IqIyfU8lQ0OeBRbVr42zAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4524560"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4524560"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:14:04 -0800
X-CSE-ConnectionGUID: 4iQMvioLSxOqnSSlllrIwQ==
X-CSE-MsgGUID: Ta4lIdlzSEi8qvG2jl/mxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12793238"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 07:14:02 -0800
Date: Thu, 26 Nov 2026 17:13:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhiqi Zhang <zhiqizhangg@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: pms7003: Reject frames with invalid
 length
Message-ID: <awhMt4r8CDJ0fjMm@ashevche-desk.local>
References: <20261126052717.69095-1-zhiqizhangg@gmail.com>
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
In-Reply-To: <20261126052717.69095-1-zhiqizhangg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 01:27:17PM +0800, Zhiqi Zhang wrote:
> The PMS7003 driver accepts any frame data length up to the size of its
> frame buffer. This lets a device send a frame with a length shorter than
> the two checksum bytes. When that frame is completed,
> pms7003_frame_is_okay() subtracts PMS7003_CHECKSUM_LENGTH and reads the
> checksum from before frame->data.
> 
> Reject data lengths shorter than the checksum before storing the expected
> frame length. Keep other lengths up to the frame buffer size accepted so
> short command replies and compatible Plantower measurement frames can
> still complete.

> Tooling disclosure: I found this bug. OpenAI Codex helped prepare the
> fix, and I reviewed the changes.

Move this paragraph to be after the '---' line below.

> Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> ---
> Changes in v2:
> - Accept frame data lengths from PMS7003_CHECKSUM_LENGTH through
>   PMS7003_MAX_DATA_LENGTH instead of only PMS7003_MAX_DATA_LENGTH.
> - Drop the extra length check in pms7003_frame_is_okay().

-- 
With Best Regards,
Andy Shevchenko


