Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A854378832;
	Sun, 19 Jul 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784450944; cv=none; b=JE5r9ceQ4jG6J8ijMTqSGlWs7tRoPli44WQxeJ8V6ZfQL/r3SHNRQnBiAG0XIeXtRf/Sn+kLKbW1bSqBnWX+m4J5of5fJQEdLMatKoCDLZ/H1DmGhQ8Z6PKUhuFkAew5bdxzCfrsJYGKEmqwdEyUZzkrUcx8QWxwPZTAY09mdzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784450944; c=relaxed/simple;
	bh=SQ+TPaDKyoSVgAbV9I8JJ2ljOsAXs0ekOlbZRGoi0tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRRW6Ucja9J8110Z6StmUGZ0YhjrYbM4WTERbLhYSY8d2mYaAU3SJg5ZrLgA6uq3R810X8moC6bFx5WdapsFXsFhoOTBf7L2mzYsaRktw/C+hiev5SH5WYI19koDyqyh7FwE3IdAOElYFj+kcF3isy1TBu5vp0jj+JHjZMK+iIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVJRLjp6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVJRLjp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784450944; x=1815986944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQ+TPaDKyoSVgAbV9I8JJ2ljOsAXs0ekOlbZRGoi0tk=;
  b=CVJRLjp6W1irgzpMttIp+d6IQkdwcuIJY7HWG8JefsYwv1Zo+7418wJO
   Ra4RZUFR9JyuBZPFWnoVAEaDRYj2zGbg2coTLUeI2Xigl6LFar+nRHdza
   QJ5Rw/5kzu6tSLqNLQoAiQv/ClSFDqvfzU/ijaWuJ+J0WmDAMwd5AniH5
   UjJ8f/IuNDAw2vOeRYO4GSZ7BtFtF5CI/CvIErSff4JMhdKS0Kz46uosj
   wHanTTvAuUqAwtZZhmz0F6FlxoISoPex8BglJSfeNflvQzbgmsQnx4dRE
   mAx8juynC5FzrRIjp7SuxVpn8yPI1SIsa/OPfeIn0aZrllkR6fehhXWzr
   g==;
X-CSE-ConnectionGUID: 1idy0eEhTDOGKWPlXWZ+KA==
X-CSE-MsgGUID: m1ArUtfIRFaRrXvGrOR9jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="84830236"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="84830236"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 01:49:03 -0700
X-CSE-ConnectionGUID: oGGp9bsaR2CZ0U1m4PfXwg==
X-CSE-MsgGUID: RVNHjHClTfuXaJK99HOkWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="255405190"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 01:49:00 -0700
Date: Sun, 19 Jul 2026 11:48:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v3] iio: pressure: dps310: add triggered buffer support
Message-ID: <alyPeWjFglrVhh8V@ashevche-desk.local>
References: <20260718224455.38acd927@jic23-huawei>
 <20260718235203.73699-1-zoone.rupert@gmail.com>
 <alyPNM21R2PEzkli@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alyPNM21R2PEzkli@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 19, 2026 at 11:47:53AM +0300, Andy Shevchenko wrote:
> On Sun, Jul 19, 2026 at 02:51:58AM +0300, Rupesh Majhi wrote:

> Do not reply to the same thread with a new version.
> Do not reply within less than 24h.

To be clear, "do not reply with a new series within less than 24h".

-- 
With Best Regards,
Andy Shevchenko


