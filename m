Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0039366DB6;
	Fri, 30 Jan 2026 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769750717; cv=none; b=H+rM2eXFgOz24rSe4trXKNI+G7dIiu4QIablYRVsjLWd1dHvp0v1NHja1s2N3Ydm/+w2pn5IRbc+jo/LoDncX8cGJaYb4L/dlBYHYWhZlTUT4aGW/W//7H2poAJhFz8OMYXWYQGTvzYKN4ECwRvYvnt0PsFORal+3AY5zTYgiGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769750717; c=relaxed/simple;
	bh=r00Tssi3VDK+b222GycHJSQE/xoWqbmqZDf7jGSfHfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJlGa3NE/7cntnmVQ94GTr95Ox0bpy9CHhzkSjnMCxW9pUEgw918VClqNYYtbCU/ojb2/ltabw31onxXsXlTKZzpPOV4XBR5+1YnSi8tgilV26btuyNTfIzwV2V5B54x/gwGeLo9h8JI5usQZvX45a330WlSPSvQA1JG8UsgjlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpzcmAQF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpzcmAQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769750714; x=1801286714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r00Tssi3VDK+b222GycHJSQE/xoWqbmqZDf7jGSfHfo=;
  b=BpzcmAQFb1ozP95YtEgPF5yzUkxK3jUnU/dMmdkVBbSO3ovjmfWLSSrT
   L7vg6JhztHBQ0id/2qJEA4jS+pbXbQktRSoNeDlO5amVioo+YeBHDu6NX
   JtwhrmLyQxmaiOIh8DxVpHJB4QxgBxIMAp876ESiu5qjRpzQcR4JFqYNy
   TDqoyU/n2ZMQGE6zMZYwVOl55HYBUgcylxE5P3o1uIdXUbvyN5omky73b
   XxCZMijeDD75a6JhL8XysQ+9wln5u5XTnou20D9xtw6qW0i4jyrTG8gaS
   6RlwgUgDzzzP7Zbwcajpw19wbjpc5smzGYehWfEbclCO6XhwK2N5ldDeX
   Q==;
X-CSE-ConnectionGUID: TyvMyV9UTraw+AR4cJfL8w==
X-CSE-MsgGUID: pU2oAjVvRFGOeKBMm4wmmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="71088792"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="71088792"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:25:13 -0800
X-CSE-ConnectionGUID: zPjVbP/gRDqHurjwcVDAKQ==
X-CSE-MsgGUID: 9o6nXOleQhiGYeaulGJAmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="208013038"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.227])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:25:11 -0800
Date: Fri, 30 Jan 2026 07:25:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Chen Ni <nichen@iscas.ac.cn>, haibo.chen@nxp.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: vf610: Add missing check for
 device_property_read_u32_array
Message-ID: <aXxAtFgmX0odYwne@smile.fi.intel.com>
References: <20260128042700.2260803-1-nichen@iscas.ac.cn>
 <a820c04c224366e31ffbc6d7fe38068f8aab4137.camel@gmail.com>
 <20260129174021.4022306d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129174021.4022306d@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 05:40:21PM +0000, Jonathan Cameron wrote:
> On Wed, 28 Jan 2026 09:29:47 +0000
> Nuno Sá <noname.nuno@gmail.com> wrote:
> > On Wed, 2026-01-28 at 12:27 +0800, Chen Ni wrote:

...

> Given the driver has a fallback for info->max_adck_rate[x] == 0
> I think this is intentional.  It would be clearer if this had done.
> 
> 	info->max_adck_rate[0] = 8;
> 	info->max_adck_rate[1] = 8;
> 	info->max_adck_rate[2] = 8;

Just in case, we have memset32() if it fits :-)

> 	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
> 
> though rather than where it has the fallback in vf610_adc_calculate_rates()
> 

-- 
With Best Regards,
Andy Shevchenko


