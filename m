Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC03A0E8B;
	Mon, 24 Aug 2026 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557840; cv=none; b=VxMLpmV226ytJcLB4pTd9m15v52M5RugWtCKA0/Sv8GT9oa5aZGhsyRl08n1WN3//xfc4bjqSmasOEvSdiRPxWxvP0qFhUNhyjz59bAiwoQoZH6KK3gVjFYr9DBFDCqPYOOUHW/bfvPHKhwsMNsiIMXdtwYOsPPOhpbQScs/+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557840; c=relaxed/simple;
	bh=a8h6CxSdIVAtQgewDoWMWFAEwfbFjp9CKKSOZY+RnU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvnzG2oknboaRDYqjEckUTc1fVp9NNzXAcgbIr5kBAv7ua36Q94Mg/QIEKyVCbQJM9W2JXvjthmlCMc9SQW7FnqaWgsJKtPgM94dB7uyXNGfWBijMiKvZ8KTDUe+YIAvZPlmfgvCFP8g/6Plu6SnV7E9jwqpa66Yo2f3O0bPFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RslKas0j; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RslKas0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787557838; x=1819093838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a8h6CxSdIVAtQgewDoWMWFAEwfbFjp9CKKSOZY+RnU0=;
  b=RslKas0jQW6NHNzn5btyxXPSh4VgveUrOrlClXsER9bCFj9CpaFkieXt
   peqszWfN0D3XKxkwuEmb7qWevtcc1sEwot+rrcVCc2JCm7vWYaHhO/riD
   7CWESCOR5UJJsrBphQB0nmRyDi1eJu4YWHVpQvNK/LJCcpNbHeaA5e/eL
   ueMhWSwTnR8lWRtysFsWKnpIz7YJX5uFwI3rfmOKCtxytSQ9vung1lbig
   CmgmVTz9XGrHlQO8a7b0UHv2eubmP0lxG0sljcBCXIbSnVNb9CLRw5RUN
   RzhOxncUeP+gl14dGRXzeYOHFsxFxEVvnYgqxVoimf5bxr43riWmr6KlA
   g==;
X-CSE-ConnectionGUID: C6N1Y1dwTE+lpIR6FUdubg==
X-CSE-MsgGUID: XmG/3wxfQyW7dScsF8gZyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88203864"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88203864"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:47:48 -0700
X-CSE-ConnectionGUID: 2PWbNG/VSl6uvf6fo5ErOw==
X-CSE-MsgGUID: kUX1rp6/QkCc3gy11IFjhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="263209944"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:47:44 -0700
Date: Mon, 24 Aug 2026 10:47:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 11/14] gpio: regmap: Use regmap_test_bits() for single
 bit reads
Message-ID: <aov3HQlxpDxsRdvG@ashevche-desk.local>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-11-bb8fbd06d4eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-ad7768-driver-v4-11-bb8fbd06d4eb@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 04:07:04PM +0200, Janani Sunil wrote:
> Use regmap_test_bits() when reading a single GPIO value from a normal
> register and when reading the direction bit.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


