Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C84734C5;
	Fri, 16 Oct 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156895; cv=none; b=D31ne7kxSnjmS+uWKSN7G3V9bw926olCOy+GjnjxM5c1L58UogFLk0yg4+mfQmCY/42Qq76SjKsZmolLItn0hhKAyPqPu53QwWzzb0sauxhmzzzvx7gB5NXSLKn10hl9RKKBsU5gxfkET2VepOlomRWlsKhSOg+rior4nKgzMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156895; c=relaxed/simple;
	bh=n0cM0p5u7gLc3K2yxiD9t34PShwzCcXzLk2wcRSKJYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPNbcPNrRGuQDzRSxH0WgXxJWCXKIH3IGL6p2rFT0RAP8mTGps+zMFfsbBq6gMsNp8L+2fCFgUBQj/2YxCf7EQIivXYOVvIHY5u3uT+pK4AvxJSYcspaJBtHC3hcZF6aTUZGQSIP1y+hm7zSQm5vVKYPbLeOFKOZnseKl8isSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJC5RqjR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJC5RqjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792156894; x=1823692894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n0cM0p5u7gLc3K2yxiD9t34PShwzCcXzLk2wcRSKJYE=;
  b=JJC5RqjRe78bYvzFjR/m0nZWc05oUqOvOz4/uwYXK4E3zkt15hCZ7YJY
   B5zvElWowUnPnmUUW9W19JePAAY7cVNlzstVQKPOhW97+1QIgmFxE1BOA
   ly09nrTsvf0r+VOcNl1eao+JOVcEwdPajdyKZrC602XeciJcAi4fcOSyH
   ox+3OTkBcyBJJJDabELAoVAubq4LtB/U2U3hXwfsAQu7UYlOMDjSSce9m
   G4PBy+DZHigznnJmc0BmxPJtuTuHIf7/5lJeByucEAcQeptAov8dHWRAm
   IdkgCyD/rzbc8WmvRGtocqncYHRisBxBT/Dy+gyTC5O1Ui5E74ssrtxmM
   Q==;
X-CSE-ConnectionGUID: /zi8rTc0STG+WTi4fmMFfA==
X-CSE-MsgGUID: gynAvOLdRamXfgElBW+d7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="820236"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="820236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:21:34 -0700
X-CSE-ConnectionGUID: efsWlcQqQAGih+pJ3uRrqQ==
X-CSE-MsgGUID: cXuibnOIRdmTI53stBothA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1831905"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:21:29 -0700
Date: Fri, 16 Oct 2026 16:21:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 02/10] iio: backend: add devm_iio_backend_get_optional()
Message-ID: <atIk1rXqGUZaLQfp@ashevche-desk.local>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
 <atEeZPOLASHAcnjF@ashevche-desk.local>
 <atHjHqyxXj6jkObW@nsa>
 <w7waqang6lriwbcq6o5s5yuedouuwgacmnj55qsjpzjrv3jut2@cthvkakgyhpi>
 <atIeAJPYyWNfYU7T@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atIeAJPYyWNfYU7T@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 02:01:59PM +0100, Nuno Sá wrote:
> On Fri, Oct 16, 2026 at 08:18:08AM -0300, Rodrigo Alencar wrote:
> > On 16/10/26 09:45, Nuno Sá wrote:
> > > On Thu, Oct 15, 2026 at 09:41:40PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Oct 15, 2026 at 01:49:42PM -0300, Rodrigo Alencar via B4 Relay wrote:

...

> > > > No. Please, use device_property_present() instead.
> > > 
> > > Oh right! Totally forgot about that internally :). And it fits into my
> > > internal point where I don't agree much in treating -ENODATA the same
> > > way as property does not exist.
> > 
> > Say a frontend consumes multiple backends, but some of them are optional.
> > If we care only about the presence of the property we would fail when
> > trying to acquire the optional ones when the required ones are defined.
> > am I thinking correctly?
> 
> Hmm not sure that makes much sense (I mean having optional and non
> optional backends for a frontend). At least I'm not aware of any
> possible usecase we might have internally. That said, you're thinking
> correctly and it's fairly simple to accommodate for that today. But
> Andy might still prefer something like:
> 
> if (!device_property_present())
> 	return return ERR_PTR(-ENOENT);

> /* A comment here would make sense given it's not that clear what are we
>  * trying to get with the below check */
> ret = device_property_match_string();
> if (ret == -ENODATA)
> 	return ERR_PTR(-ENOENT);

Yep, this must be well justified. Currently I (may be missing something) can't
see that justification.

-- 
With Best Regards,
Andy Shevchenko


