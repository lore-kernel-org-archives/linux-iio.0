Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF13546E4;
	Thu,  2 Jul 2026 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983936; cv=none; b=FdJP2GJbD1E2H+8DTVh2CIfuD18hHrtSTx4hnFyCjW22xFrWtx+sdqmoMj9T8isjkvExO5d9J5RTCXjwAR0gB3yKQZQz6+4VtFNuzuGOZq34TtoWsxUyjyq125CZjh+dLszzysamDo5aniumOF1+QlGEdQTm24eEPS7xTqNXTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983936; c=relaxed/simple;
	bh=Wxesf7mQ4kRoGZgPMWdUAMLk2lDVLro3SBjRkgYwV7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHm5N5wG8Pih3Gkx0eGA3zigfV9tRvkSg9iMIv2k/JZfZUjmisEjo7JfxAlhuhmaD+D/YAeLnZx241BoLHdlSX141mctjvsXlr84InkWEowja2VCiZJQG1cVn35KhMg0fks2ZQi5wCWG5euGeD2CAFTB9RBH4+XNjSBKLRpBNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxaYcBae; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxaYcBae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782983935; x=1814519935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wxesf7mQ4kRoGZgPMWdUAMLk2lDVLro3SBjRkgYwV7Q=;
  b=DxaYcBaejRzfICVpNFWFsnPgg24dEoBUNoC0OOUG2m3bW+SwHi+wU4hb
   kc2tUx1VaglW7trlNmHSmB1qOadNS18d4q/zr16cEVMtxpinHjbrdauhF
   NqCANF8BoclwPeFYcAZmn4lMDFQHkx0lgl6WlSOFSi+xoUkMYqH1IBOaE
   5f/jmO8ZAORYXBVL99wN7kDp3y565a3ofSVggrLkr8Q+zu9rx+JbPS0Kn
   9u/1Ig/KBV0X3c79rweOgdXJhaPrd/A7EDalYEr1XBNraOwFEYdfpLenq
   u6dMjcYY9nVoDPbvJSkG8N7iH7V4GngIsQghVnqjV0E9N+1EmuhqJAndN
   Q==;
X-CSE-ConnectionGUID: BO8meSeBRfuGG6diDMuAfQ==
X-CSE-MsgGUID: L8BxG3JQTZOahKbu0wm1ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83820442"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83820442"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:18:54 -0700
X-CSE-ConnectionGUID: XsPZ5tFwTt63D0xwpNQ9yQ==
X-CSE-MsgGUID: bjYJg1iRQ9iXUDad25PPGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="256389404"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:18:51 -0700
Date: Thu, 2 Jul 2026 12:18:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "David Lechner (TI)" <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <akYs-QgyjN-nmjq-@ashevche-desk.local>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-8-ceb9b0b561cb@baylibre.com>
 <20260701212019.12757df3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701212019.12757df3@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 09:20:19PM +0100, Jonathan Cameron wrote:
> On Thu, 25 Jun 2026 16:55:10 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:

...

> > +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> > +		struct ads112c14_measurement *measurement = &data->measurements[i];
> > +		struct iio_chan_spec *spec = &channels[i];

> > +		if (!fwnode_device_is_available(child))
> > +			continue;

Also drop this dup check.

-- 
With Best Regards,
Andy Shevchenko


