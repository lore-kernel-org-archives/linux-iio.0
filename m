Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEAD393DC8;
	Tue,  2 Jun 2026 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442470; cv=none; b=OpE4IUNRyOgQBS1JdObIthPeh2Dbx0zEnhuSwkGJM2/gWqAwqf5Uh80uhZ+AZZ8WgAPGqqfTCN1g4JSwiy2bYSLAyPB1qduUrLttQu7VvNQyLan1AOM05HD5fibl+JLOp3TA29XcM2JmTLuq2C6bupu48PNwsnrWsyg+Ze8/yjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442470; c=relaxed/simple;
	bh=7hlK8eYJPPiBHqrMG5zTTAtW/+ttDNt0z8C+yseUxfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoKw8ozXkBBpKIuCaasf7tYvcFjIa1gdq6PqEx/iJRnwujxtyPz6x45xI5dwn0dJKFEXxsVDknIGtVKmwydlVvpbVAcaWgnH0xArg6kavZWG4elWbn1eZfGOfs/c7MRuFi4V5+jjoqp4YdrV8XrPqiWgdY35p6EfDy9JzPGdlfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ju79SQJt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ju79SQJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780442468; x=1811978468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7hlK8eYJPPiBHqrMG5zTTAtW/+ttDNt0z8C+yseUxfY=;
  b=Ju79SQJtem974CG2ou5k4Hot7eblEBapFATXc2B4Uo68zZfj193+wGo5
   5wnhnQ44wxe5wRB/ra7omRUXPsWMfSXpecc3AfhYmHXhel/5ddPK3gCtQ
   Xt7WfL7tdOcn/GMFD65BJyap/IfApd1pACo9P+DyA10lgS3NYcuR94/I5
   yxpLJy1V/E25MRB/Lu/ek47VFt4SrkrUI8CfM8dxzlK50XMG0bEVwZwjc
   Pzz3R5sUFx7ouPa2/2g+DjFkX8T+3bL0/Zsq5mVY7d0jLXJkesvvd5H/M
   CQrM5JSoD0X9By73kzNt/VF4WgKcWAfQKwRNDer8jJQmPCqY5FERNJhjt
   Q==;
X-CSE-ConnectionGUID: O2X9cssdTniaKquFGYv4SA==
X-CSE-MsgGUID: /nR0rTtcRMWOzM3ZkDcgkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81422938"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81422938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:21:08 -0700
X-CSE-ConnectionGUID: NlIfMYfZStejQAcir8rCuQ==
X-CSE-MsgGUID: D7xuuax+RVuqplRVZaUWHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241564860"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:21:04 -0700
Date: Wed, 3 Jun 2026 02:21:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Liviu Stan <liviu.stan@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Francesco Lavra <flavra@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iio: temperature: ltc2983: Fix inconsistent
 channel wording in messages
Message-ID: <ah9lXlmgcsNQZXKd@ashevche-desk.local>
References: <20260521164323.770626-1-liviu.stan@analog.com>
 <20260521164323.770626-4-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521164323.770626-4-liviu.stan@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 21, 2026 at 07:42:56PM +0300, Liviu Stan wrote:
> Replace occurrences of the abbreviated 'chann' and 'chan' with
> 'channel' in error and debug messages throughout the driver.
> Also changed the diode invalid channel error message from
> "thermistor" to "diode".

...

> -	dev_dbg(dev, "Start conversion on chan:%d, status:%02X\n",
> +	dev_dbg(dev, "Start conversion on channel:%d, status:%02X\n",

Here and below inconsistently used : with channel. Be consistent with the above.

>  		sensor->chan, start_conversion);

-- 
With Best Regards,
Andy Shevchenko


