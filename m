Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97F3A7F75;
	Wed,  9 Sep 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960283; cv=none; b=JpD8K3QMIH03srpIElHKGXY1AHTtJNaOW6rvLe0nbPxR4rQJ+MilHTK5ne9Gn0XHmO0emxZpb9/ptsIzuRWC27jRn0ax3Oi58di94KA0FoUayAdL29hyU8JZ9fv3mgXtFo5NUJ1wYyIiIJoo1ngi6RWqA5BmYe8aOx4Fub9OSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960283; c=relaxed/simple;
	bh=9IgJXWR1Pr7kzyZipuWrbyHe25rOrV0jbpzIuS7pZ+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUzud2clnk+XCoDm7GAyM+JZyzRins0emNPPdelpIx4nAkvHYxMej2cBpcscjJ2eTUqeiwuLZ79zFUmAlXMz5bYhaA4hNKtcsdHj/zmi0Zu1YNZpYh1TH/PMgTe/neMwRmr5Ql9W243asaVyVFfTc+PfvmpzkP344iVtQHveyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4AKb88t; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4AKb88t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788960277; x=1820496277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9IgJXWR1Pr7kzyZipuWrbyHe25rOrV0jbpzIuS7pZ+o=;
  b=C4AKb88tmXoMWSMayPo+KMmwpSO5EtoYgu2N5x3DK3TOx+fr+AjVp+By
   cB6lgERY0DycQnpMeft+Q5hlFKs/aeR+hCo8Gn7S+aAxXsL5plY3m/jfh
   Jjnb3CxeF4liP1VMGOtfnFbrHjcoTOZBlAJ/sgKXGTQWZbpGCMrM3osce
   MQd+L64Hdo+M8Jvix/csZ8ioptsC+INX6gWmnyH1yWfFJvXh2e0KDD8l0
   Rss9tbjcKXriZjdNb081WHrAPLdocE7nEBGfDQItq3FHU8ZbzSILo52GJ
   oZ3IVEVuzQhsLXZ8xUJfUBJOe67x4aqoD6dVZ6KGcr2EEQJ+Pskn543fl
   A==;
X-CSE-ConnectionGUID: Pb/2UaGIRVOjSev7DelafQ==
X-CSE-MsgGUID: 7z/XQglERLy2pTiPsZV1/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="114930437"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="114930437"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:24:31 -0700
X-CSE-ConnectionGUID: 8zuodlHCRwynxSkxoPQTiA==
X-CSE-MsgGUID: iCFhEhywQT+PjhZbMvgAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="268744686"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:24:29 -0700
Date: Wed, 9 Sep 2026 16:24:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: ad3530r: add support for AD3536R
Message-ID: <aqFeCa4lVozSOZir@ashevche-desk.local>
References: <20260909-iio-ad3536r-upstream-v1-0-16ab930dcee3@analog.com>
 <20260909-iio-ad3536r-upstream-v1-2-16ab930dcee3@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-iio-ad3536r-upstream-v1-2-16ab930dcee3@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 02:19:10PM +0800, Kim Seer Paller wrote:
> The AD3536R is the 12-bit variant of the AD3532R, a 16-channel buffered
> voltage output DAC with an on-chip 2.5V reference and an identical
> register map. Add a chip_info entry for it and the corresponding SPI and
> OF device ID table entries.

I haven't checked the datasheet (perhaps you need to add a Datasheet tag?),
so assuming it's correct the patch LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


