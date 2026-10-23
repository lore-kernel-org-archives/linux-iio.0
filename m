Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747301;
	b=aRCseezTDGqP7bYRcnewKBXDuhJkjcbeVmcdaxHCRqh03lMibrOKsLcvB+OhqDpZJAxm
	 jr9yUzVFfSxXIDJEzQ3Nc1k6OWbBJWg2EY7TC4FVXU6V9+BgM+FfX+OuQ0BzG+1b8QzD4
	 HS+IshGBl4gWiuEN+OX5bRzEwYKDMyrFTJZLLtBA3lcJwbBRmedD2tkMOh8ZdVMTQhI3h
	 DygnFSg1CLs+AN+4Nas5hNmVcwNEJelHoxMwUyGaliSqu3tTnN0vmYODI7KySeXGhN+/o
	 Q4O85i6xHAy5mbxbvIODF83lPrA5LZfddIgW5qrZWBxZtrtLGj4GY5JHFEWo87pazQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747301;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=7WVW9LTCsDSlQNBj+ssV+xOFD2713qkXxDb5vqL1zmw=;
	b=njXA1ybhcNSW8q3Iwvkw7J6XmvSRGXYK/J2HAdkW1YuqGRXMseDd+/7l/a/CepuTvYYL
	 Ddl8pupqI/D8sAbswz6vcsbRohj8bmtLaq8VRkLXVoTCtqF/rNd3uP+V6ktj4VzMQpDNz
	 etc3NFN70Mwr581BteS9Yzxx2cDOtkktcXXTxRHQoosw3wa5e4up71g+4sIDTUPXHgmmA
	 6GR8Db+402Qq1ep86ehp+QBoB6CEbL0mt26mU9UcCPm0U+kii9XUreJPhT4ELi2LfBl4c
	 0CnrlS4U7VCow5otz+bPZaHzSjDfMzWYMlnkIYkHznzVNRuao+Q5KlV+TJE74KbXe6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZRGAxF1Z;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F684606A31F;
	Fri, 23 Oct 2026 09:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F684606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZRGAxF1Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792747302; x=1824283302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j6agsC6FkDh8TpkbmEQdEdh2DcF162EGqj2Ha9Ht668=;
  b=ZRGAxF1ZBxQDBFVKB8gVoNpIWL4wUKQ4uTESn/VxTeWOvC7wwkXuoJ+3
   +YDWQ+MWcfa+brO+OaWp0jeP5ZEF0fNE+ick8S5yvCepWlRc6aUM/WElg
   IqXBtNTNdc4IvYh8AQWLbu/YWltKsQG0fr8tIIXiQOnkoqxx8sT6UdYXj
   GU2o3roBIwg1L10v7IOdW2+ffSiJ/bFPSmVjwgaMUNXxxAypviRa17oMl
   UmEIrZcMu5B1lsKGNNj8g34WfJk4hLBZjEe7Owu/IIseN5h8bSaptwiJ0
   efzriua/9OMPN2d584M8d9zL1IvoxEr6TE7PjT9/gegfpaPA2y/ifDmvA
   g==;
X-CSE-ConnectionGUID: fX//dhF6RIemXj9TK6Fhlg==
X-CSE-MsgGUID: g8vkq3+hQvGb53bF02TNlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1400760"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1400760"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:21:41 -0700
X-CSE-ConnectionGUID: qIckkqhAQ2WsiZ/gA/1eHw==
X-CSE-MsgGUID: PcubL6yVTxKZrRpWBbwtuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3977368"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:21:39 -0700
Date: Fri, 23 Oct 2026 12:21:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jesper X Nilsson <jesper.x.nilsson@axis.com>
Subject: Re: [PATCH v1 1/1] iio: light: opt4001: Re-use generic struct
 s32_fract
Message-ID: <atsnIMEnefu0GD96@ashevche-desk.local>
References: <20261023090802.1957593-1-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20261023090802.1957593-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 11:08:02AM +0200, Andy Shevchenko wrote:
> Instead of custom data type re-use generic struct s32_fract.
> No functional changes intended.

...

>  static const struct opt4001_chip_info opt4001_sot_5x3_info = {
> -	.mul = 4375,
> -	.div = 10000000,
> +	,ratio = { .numerator = 4375, .denominator = 10000000 },

Oh, I should have compiled it, but I missed. Should start with a period, of
course.

>  	.name = "opt4001-sot-5x3"
>  };

>  static const struct opt4001_chip_info opt4001_picostar_info = {
> -	.mul = 3125,
> -	.div = 10000000,
> +	,ratio = { .numerator = 3125, .denominator = 10000000 },
>  	.name = "opt4001-picostar"
>  };

Ditto.

...

Jesper, please take this patch into your series, but also fix those typos.
Or if you are busy, I can do it after my lunch.

-- 
With Best Regards,
Andy Shevchenko


