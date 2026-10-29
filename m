Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278746;
	b=SFYnKByPGyrqtX7hUOn7+dYKljtKZ8WNA76ZLcevahSV16AbAOYR26bY82ux+nNSY8TH
	 C3F3ey1MoxIFFXKh8kXIDP1DCOgB2F4IxF1pgoPFapvAXMI9yWNmZtR/kJuvVT0+Feohr
	 ZcZacUhvWkwH8ZnIem3S6w11DJ+z7CQEq/xU7VGoDmiZlUvKdpEiqjrPn78JACUYZ4BJ+
	 6OehRj6JsEg+YUpJIQ3TvyZvlk3OLaK/KuS1tPJT6vhnrnwkg8mw6/ZX1z/ERsYzYj2nf
	 m5YD+IFNd3cnm+P+JxyavQTUNaFcsbbX3FRQO6DcU+yT7LEvIgwsYp9Rfwgo34WWLSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278746;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=53kh1jzqgst4C7GMrt2nlms5x3GRLs7CUdsfirKiIAU=;
	b=GCzfcERSwJ8fFz5VMfEBbMh4CK7qyy4i/ikK3PhWat7n4UJdBLYv7bVgBQKmSQoGmC38
	 E6Cy+P54w4yWk9q9mAh7qo/lbgqF19ou5JrH1I4RGCYxsWLygkB3hHQa3WKKARIgpfBf/
	 qViiL/KW2CGlHhhROlAMZibPMGmANsh9atI03Nmz0k6Wlipqdtuxrc0E/SaWYESkp+LgF
	 KPKk7Uz2i1vdGoDofE/F8lP3u0tdIT434yM2TaILeezjzI8WMdlg5Mu4CICqnBf13o79o
	 WFVbZUI7xcbKynynRAW5IYCcyzdEdM/GsvfDqHFhBMHthBNvwYjIkfmL35WDS0U6B+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iMSYRC50;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12F606A31A;
	Thu, 29 Oct 2026 12:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E12F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iMSYRC50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793278743; x=1824814743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=etVGe+d7u+6Nv9Ztfov9yJUfiPZViljR0oxwR4I/XcM=;
  b=iMSYRC50g1/r+iSOJKAWIfIfksnnJZMh9UTn7WPuLzpVvjhutvgZt6q5
   thdK/E7iqJj+vT2gUrdqOiBAZ/Wlb537CK08Lq9O67DHkhPdKsMEZr2Qx
   OZSqbxkh67a9YH8EW5vAUHd6xMAGoxAQMkhVjKmVDwxmnavdYL6gq718b
   lC2pDYBWQpTvb+xp614i1V4eXobIKXnBixl7oKaC0nk+Pz/rVobQ+T2YQ
   E7J5Qqw63i+bvrXQe+uefYDEf5nPr9BlmScno94Jq52K723QYqmSe36Wy
   u+bPjQP9LMxxpZ0eiw56JOLREwwPyLd9veDoW9NrLQwh3cKbTqTIIZzey
   Q==;
X-CSE-ConnectionGUID: 7557HJU3QpeQHmKqQE+bqw==
X-CSE-MsgGUID: aYQdXZ4YS4mC5tzv0aGVBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2017216"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2017216"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 05:59:03 -0700
X-CSE-ConnectionGUID: awUjsFGATXGR3LpaXrm0Cw==
X-CSE-MsgGUID: HMIFTgzBQ5qfE8yEzVwm0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5231919"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 05:58:59 -0700
Date: Thu, 29 Oct 2026 14:58:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH v4 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <auNDEQXkQ89RHjc4@ashevche-desk.local>
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
 <20261028-topic-sm8x50-iio-max34417-adc-v4-3-d4baaf3ee903@linaro.org>
 <auIPfwQII72aqyWA@ashevche-desk.local>
 <d2e93ac7-1689-4e06-a694-d0a95d05a400@linaro.org>
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
In-Reply-To: <d2e93ac7-1689-4e06-a694-d0a95d05a400@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 04:26:01PM +0100, Neil Armstrong wrote:
> On 10/28/26 16:06, Andy Shevchenko wrote:
> > On Wed, Oct 28, 2026 at 02:19:06PM +0100, Neil Armstrong wrote:

...

> > > +static bool max34417_volatile_reg(struct device *dev, unsigned int reg)
> > > +{
> > > +	switch (reg) {
> > > +	case MAX34417_DID_REG:
> > > +		return false;
> > > +	default:
> > > +	/* MAX34417_CONTROL_REG field OVF is volatile */
> > 
> > Why not add a case instead of a comment?
> 
> The case is handled by the default, the comment is here to
> explain why MAX34417_CONTROL_REG is considered as volatile.

Still, having an explicit case is better, just add a comment about the field.

> > > +		return true;
> > > +	}
> > > +}

-- 
With Best Regards,
Andy Shevchenko


