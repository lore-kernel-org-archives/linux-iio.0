Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605878;
	b=k054DOENNo3IRJFKSnLVEYdceF8lTT2OhtibjqWkxAVEXTIDcxKhj9yAZYhjpmDn29Qc
	 7KrHvNgJ5wb5wmT4PDwj6aLmU/vy2n6yYdDTxV4shdegXznffYc0PW2UmEObi/sWcV7R+
	 4yMwz9Tyhkhr35e2nQMCBUKIFZQyzFjU3W8WtIcEC7UO+fKT8sKsaedoILGisLiD/EE75
	 eApoVL5AoXi6dFbzTED1OTtANpGozd8CxW3vCillmBp4gSI1zDLpViGJfkUPGWG8nmyyd
	 PEPEfOE0R/HCTjdaGxuZG9Q9KRRPOXpXOnpiOOd0OaDXQzgYeNel1I9iF6VZ+WkQKPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605878;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=tyYYIWnrs5egPhfI1c7tKp8na5wlEtiIgP9Y4XVxBrY=;
	b=T2zMUXxWSVRXHAA300dCrR2mc3+P4k9x9FQetRMEURk64Sij+RXj4q009qTPeYmx98s2
	 8XGZwWO7BOVkvRKlnDG9okf+uyDjZG9MG7zUHAXMfW9KtGVq1RBwl0vrPOiXoxR8SNF7i
	 +IoRlOHdKxDFHdvRf4n+YOAouOGLCcsO5DtdjMzwhnPzJZGLHbKdgv7gBUFbgxrQQKJYe
	 ALqNcJ84MicvXIIsbgRxdkrO47hQgsKkAnkSH91fYG+KpI02Xu2MkTR0SGZOdpKqsI9ZR
	 3b+FSPryh07lQ+QiMA308XNWE4yuns2ymKFPa9lMK/2WgX6ap/NR0kzj1OCQLAm7jww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hamY0xtX;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08597606A31E;
	Wed, 25 Nov 2026 11:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08597606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hamY0xtX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795605878; x=1827141878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6o1H0aJk4yI9oA6cTUnex+WRsIK2UPxhVvmynQrOM9k=;
  b=hamY0xtXyWXeVHdPEtBTmpcn6qjKcGXtPUYOTScyeg+/Z7KWWFkRcOUo
   dz9FSthhHDE14njbjyXN9pUq3SXPXSIb8yQS0qpUWsGgZyG0Vv6bM9JlN
   Oh3wqaLdXgWai0nhe4edpctzEu9e5b4SfZY3h2qZCN3YtlO0yfSA8CcbK
   b7MwugtY+ivz0w8E0uHTr1WyL4cGOpgewoI67jUmykFhD1+fiFj9FbiT7
   pwWjI8OTpKI9y/DwLjW/16O50OvkJDqcAC0iqqKBkIv7nZyc5waROZsdE
   BmylTf3wrdKDRORwnYm4IiTicqCTUmqQvydA3EgL3i908ta958PEu8WjR
   Q==;
X-CSE-ConnectionGUID: NX8xxAHsTHeItZZi/w5aFg==
X-CSE-MsgGUID: +PKu9N/iTtGTQ5lC6kxhQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4384193"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4384193"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:24:37 -0800
X-CSE-ConnectionGUID: Nh4obFo3SBKK3p7hBZ3nvw==
X-CSE-MsgGUID: bPSFDOwIRRuvspVqQy6teA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11823773"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:24:35 -0800
Date: Wed, 25 Nov 2026 13:24:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: adc: mcp3564: Use guard() to manage locks
Message-ID: <awbFcJiIp6FR-gAt@ashevche-desk.local>
References: <20261124204054.85634-1-vaibhav.chahar26@gmail.com>
 <20261124204054.85634-2-vaibhav.chahar26@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124204054.85634-2-vaibhav.chahar26@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 02:10:53AM +0530, Vaibhav Chahar wrote:
> Use guard(mutex) instead of manual mutex_lock() and mutex_unlock()
> calls to modernize the driver and improve mutex handling.

...

>  	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2_REG, MCP3564_CONFIG2_BOOST_CURRENT_MASK,
>  				   FIELD_PREP(MCP3564_CONFIG2_BOOST_CURRENT_MASK, mode));

>  

While at it, drop this unneeded blank line (same for other similar places).

> -	if (ret)
> +	if (ret) {
>  		dev_err(&indio_dev->dev, "Failed to configure CONFIG2 register\n");
> -	else
> -		adc->current_boost_mode = mode;
> +		return ret;
> +	}

...

>  	case IIO_CHAN_INFO_RAW:
>  		if (channel->output) {
> -			mutex_lock(&adc->lock);
> +			guard(mutex)(&adc->lock);

Add a blank line here, so it will be visible at a glance that guard()()
is used. Ditto for other similar places.

>  			*val = mcp3564_burnout_avail[adc->burnout_mode][0];
>  			*val2 = mcp3564_burnout_avail[adc->burnout_mode][1];
> -			mutex_unlock(&adc->lock);
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		}

-- 
With Best Regards,
Andy Shevchenko


