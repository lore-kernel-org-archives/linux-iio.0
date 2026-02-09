Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440A2E7BCC;
	Mon,  9 Feb 2026 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626689; cv=none; b=W9KrzoUpTzhkuLjdtH4DELh8Brn2VeAc9MFV+QCX4SC8aepp6rffwrMVyvFrjFUNYXKsSEn+GtFNwd5cYvl/uqpoiqFc2HdTcSIoJbq92ZwLDOaqRp+Ju6DiyUHuH7sYawnMegKO9m02De2c0gXVFPb67oTp0mx/N+wgYB0cfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626689; c=relaxed/simple;
	bh=1GuNOQWFdbqz99/pY5+rOFXai4k5OCGe5hO9P0kPD/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLlSmrEvNhKcql6yWYSwj/2RiJvyJVibDOX8eIHHJHoZlZ2bxHa9AFQOYZuUakBCctkL33MOamJc47TMS5fPPDHylktQbcnWKUv83XmYXv7sThaKfaEwqy8QHuF7D12aBDPtz1SwiKbGI+04U4/OpPnZ/ou6xmEvqmOha9w/s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSFrD2QU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSFrD2QU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770626689; x=1802162689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1GuNOQWFdbqz99/pY5+rOFXai4k5OCGe5hO9P0kPD/A=;
  b=QSFrD2QUl++kydUHhkGUZYRM/JFR8klUBXfDuj98LG2fGKnuM5lAoJPj
   0yHz6BSdttReNiwv2QFtdl6X6FBQI7kAnlSUEoRQCSRzUKh+Uo5jaEPId
   NPxt3w+oVnNr4cKX9Mlvz4iS/TXQvl/6hjjtCSbFx2l4lIaxIFExR5IKx
   rGzy8Q1sYayLp68kEd8lSu6RrqTdH9jhi3+tuIiXC7+/oOEMZ3E6wQfqG
   tFJdTTjkPYxxxLa4ekS/BvoWnOGu+/J74E6rKoXOhm8bk2xZ5gCYC/RVu
   j4z5SPBAc0IHDXODvsIp29x7yUX3M1ar5ePUtDcp8Sjm30JDerx/rCvJy
   Q==;
X-CSE-ConnectionGUID: OIWnq5+ZTNuITbj3ZMG5jQ==
X-CSE-MsgGUID: WQE4UqXVT5yw3igZWvBtsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="59300072"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="59300072"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:44:48 -0800
X-CSE-ConnectionGUID: tLcdU0aoSaGVJI4wTHDPoQ==
X-CSE-MsgGUID: Sb2SHepcTVCkjOS33I7ZYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="210613762"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:44:44 -0800
Date: Mon, 9 Feb 2026 10:44:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: proximity: hx9023s: add ACPI support
Message-ID: <aYmeeWeXRdPHZxRr@smile.fi.intel.com>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-5-2b4d74e309d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-upstream-20260219-v1-5-2b4d74e309d1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 11:37:06AM +0800, Yasin Lee wrote:
> Extend the hx9023s driver to support ACPI matching by adding TYHX9023
> to the ACPI device ID table.

...

> +#include <linux/acpi.h>

Why?

...

> +static const struct acpi_device_id hx9023s_acpi_match[] = {
> +	{ "TYHX9023", 0 },

No ', 0' part, please.

> +	{ }
> +};

...

And since you added a new ID, please add to the commit message if this is
in a wild (and hence the vendor and model of the device that it has) and
also an excerpt from DSDT to the comment block (after '---' line).

-- 
With Best Regards,
Andy Shevchenko


