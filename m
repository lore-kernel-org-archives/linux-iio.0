Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8E3019A9;
	Fri, 16 Oct 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156783; cv=none; b=C6VaQAcWRoOKpVuozAxdKAwhPVBj8a9tIWxwfhxVNRFVSdadpcyMsXFCKwqDg8Nh+Kwe94HPFlPDO6nxp3ukD24q4AfIK8hqgUJ/2KBVix8JTWo8MA0mVJ1hl1xQhvGVYiS3fKar+yyyCZkMXvcCeyLbNpDLokf9hbFZ4yi+Gsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156783; c=relaxed/simple;
	bh=V4PkteCKx/ZxERlS7LFcwpcqpKl234HFVZU267Hcd0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHoAgrIB5PVz175Z/65S7KwyG4eATZFjUmRtVSSQMeB5jUNq8O5xkuAVjimQ98X9G7CkWfeKBi373hh+KNsg86PTr2foDSyZxC7eW/LPFD5U9c77tf6fohNW2RK2S2dun1IzwOIz58UgPme9ebWH9eH6dszQy65OzBJMlzOJYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmlkGu/o; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmlkGu/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792156782; x=1823692782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V4PkteCKx/ZxERlS7LFcwpcqpKl234HFVZU267Hcd0g=;
  b=CmlkGu/oUXS5PckbGPTSen2oX5soqc/Lp0aWkut7A/dM0NAdCzG50ntK
   jZjVlQQ+/c09gPSNT1Q30CuHmQB2ElwUmAYHJ/DzgPwd3PY39aNA2oVNX
   WRiWo3jYB4MI9HvHg6H+bULsqSqxzX+BqhzI8I5okc4Ryak8rAVvE7UsH
   BfDXik0/X5adPEqCFop+go4o81WPT0FBsHsT21Uhi+Jja2WywW9ABZH9D
   gKsmkNx7ptLLQIhGmmNuDXdCLjYgXzi+64zKRoyo3s5rUDq1Ycw8oJFcK
   J3HYWoUW9g4h0mnyMECbFf9XmK2Kg8wbCK723mqH60WIy1bqblHt41T7Y
   g==;
X-CSE-ConnectionGUID: o3cHtQacQc6ckGZNyxMm+w==
X-CSE-MsgGUID: Biv+r8jMRHOdPJSMJ9sWtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="951416"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="951416"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:19:41 -0700
X-CSE-ConnectionGUID: AcvKuJBFRfCe6ErDfXiifA==
X-CSE-MsgGUID: y9cPUVNMSNOTskDScbYCzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2367032"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:19:36 -0700
Date: Fri, 16 Oct 2026 16:19:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
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
Message-ID: <atIkZa0noHjcl13X@ashevche-desk.local>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-2-3c21648c8e26@analog.com>
 <atEeZPOLASHAcnjF@ashevche-desk.local>
 <atHjHqyxXj6jkObW@nsa>
 <w7waqang6lriwbcq6o5s5yuedouuwgacmnj55qsjpzjrv3jut2@cthvkakgyhpi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w7waqang6lriwbcq6o5s5yuedouuwgacmnj55qsjpzjrv3jut2@cthvkakgyhpi>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 08:18:08AM -0300, Rodrigo Alencar wrote:
> On 16/10/26 09:45, Nuno Sá wrote:
> > On Thu, Oct 15, 2026 at 09:41:40PM +0300, Andy Shevchenko wrote:
> > > On Thu, Oct 15, 2026 at 01:49:42PM -0300, Rodrigo Alencar via B4 Relay wrote:
> > > 
> > > > Frontend devices might not need a backend driver to rely on. An IIO device
> > > > that supports backends can behave differently when they are not available
> > > > and that should be acceptable. Such parts may provide basic functionality
> > > > solely using the control interface (SPI for instance), being able to have
> > > > extended features when a backend is present.
> > > > 
> > > > Add devm_iio_backend_get_optional(), which returns NULL when the backend
> > > > is not described in firmware, i.e., when the io-backends property is not
> > > > present or, for a named lookup, when the name is not listed in the
> > > > io-backend-names property. Other errors, such as probe deferral, are
> > > > still returned.
> > > > 
> > > > To make that possible, a named lookup that does not match any entry of
> > > > io-backend-names now fails with -ENOENT, the same error returned when the
> > > > io-backends reference is missing. Also, the missing reference is no longer
> > > > logged as an error, leaving that to the caller.

...

> > > >  		ret = device_property_match_string(dev, "io-backend-names", name);
> > > > +		if (ret == -EINVAL || ret == -ENODATA)
> > > > +			return ERR_PTR(-ENOENT);
> > > 
> > > No. Please, use device_property_present() instead.
> > 
> > Oh right! Totally forgot about that internally :). And it fits into my
> > internal point where I don't agree much in treating -ENODATA the same
> > way as property does not exist.

+1

> Say a frontend consumes multiple backends, but some of them are optional.
> If we care only about the presence of the property we would fail when
> trying to acquire the optional ones when the required ones are defined.
> am I thinking correctly?

If there is an empty property for names, shouldn't we simply fail? I rather
would consider the firmware table to be broken in such a case.

-- 
With Best Regards,
Andy Shevchenko


