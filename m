Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566683E1232;
	Thu,  2 Jul 2026 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990389; cv=none; b=YKuC2RkQ3geCRRoiHQuxXzqOoR3BdxAJ+xXWQG3Xr/I/A9nb43HlqkCnSMPfxUFyQllxSCvHuLWN4kqe2UFkEdoAabq155z/DI8HuSz7zwSnlxJfmrAdUzZPHAc3VbR9I6yfGDdNCYRzcqhaJEPh+C4vH08I4fdPfb0PCJh5zCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990389; c=relaxed/simple;
	bh=UPv6eNhsg0Fw4V1IesWctm2uhQTjwiEHmOTZe2tTKuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qScmgXWGEgKM4vY2FF3yD4yM35aoMzeuBsICJs2WH9tFtErwLlnvi8VM/SjvTLXbYxgwyF+nPmqqCpDa1vwZYgxDRy0alWtA6So8S+u60aCnBytp37R9RfZIGLbrF+F98/StkTCM/YsMjx954UhrRTXqzpG6lRgLmaGEjj8WLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/dH0I8R; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/dH0I8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782990389; x=1814526389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UPv6eNhsg0Fw4V1IesWctm2uhQTjwiEHmOTZe2tTKuo=;
  b=f/dH0I8Rn/DnGmD7ghDe/CrvJM8gTEHArUKdqubmlETXZGzp893MEJVC
   hhoFKSwUdMUKru3Bm4EhTI4zScfafXUMgZC/ux+/p9W0AwXPQtGgtYrvz
   g6VXwKJhqzYfvlTd5UGP03Z4ASapcanaZhWS0tBRQxX8Mbp/P2mnm5Bac
   6qDkWp2B2Z8A5uogstsEHieCKl/PujR5PC+n2N/IgG7nm1uaPrtZtvC4R
   TC1hSTXy9kAJdpnp7GLZZokYnQZEZIEXG+c1u+3U+Hb4u5WpdYXHStlGm
   wulq0mJbX1dJ/EikMNGvpteuPBZbjULv6YjPJVIqsH7q+gpBCmL8O76QO
   Q==;
X-CSE-ConnectionGUID: kkfwoPrIS3Ot/mXHEqr9QQ==
X-CSE-MsgGUID: UuqpHYdfQGSjbYfpR9cNXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83791670"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83791670"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:06:28 -0700
X-CSE-ConnectionGUID: vgJg8MfsQIWPnH2E2KOmdw==
X-CSE-MsgGUID: yrzVBV7mQdGOWHt52d4LeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="290957656"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 04:06:25 -0700
Date: Thu, 2 Jul 2026 14:06:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Anas Khan <anxkhn28@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix typos in comments
Message-ID: <akZGGzt59mRGMBXH@ashevche-desk.local>
References: <20260702101129.62445-1-anxkhn28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702101129.62445-1-anxkhn28@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 02, 2026 at 03:41:29PM +0530, Anas Khan wrote:
> Fix several comment typos in industrialio-backend.c: correct "through"
> in a channel-spec comment, "initiates a process" in the activation
> comment, and drop a stray apostrophe from "Gets" in two getter
> kerneldoc comments.

Makes sense.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


