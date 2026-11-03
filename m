Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722499;
	b=bH6iLgMX8B/rDxTdusfFQJHY9Mlt4Y1lMNTQHLxmPt0N3FD0DsIV3nczNOVvfh23NBuy
	 JbGn0D8S2Ax3RQoWc1RKFFviSbjIaDsgIk3zMmv3fVgKKUtXP8gnnlbem8Kr/YFTcL4oV
	 RmHEvFFRgOfYF+88bj5L6kaAzWWjaJHm1fI0N34VgyeoArwtyh1kYVzISWbirmlboLsd3
	 mp6BDinoZm1gL3DgTSLwtjb97fC4x4s3QeyfxHu5jZLhO8tfg3z5Ei97jQ3qzfS0E0em4
	 H/iN3BD3ELjcsxtPlLzs4ACR+u1tMiLGtCAocFjJnp2VP4vC2faK1v8N29zpFXxJ5QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722499;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=EKCJmsDojR6fmOrZt3xL3Qv8JIBHOSZUtNHfGzpr6gM=;
	b=LyjlhfbeE09uWbxJ1VC/BEf+C9HZXrkzgU054AYmRqfTB2aV7IjsmRLAhcpckXwxyG6j
	 hVuO+68dOIRjOD05d+JcNdyi3a9+bH9hGAtsZ5fSDGNY3zzp4O7JfwHuPqMxl7sdMBJau
	 9F3i+b+AINzPsl1CQW98XY9uTnaRGKowcP69HshLXWGm3z4z1Pa60d8by5sPNYvxSQnB9
	 JVnqqMjRxXV5Nj7dwlXBCy8VQpjtASn9QJ1oYNfDRurwYDz43SXggNW+bTnJAQFvEy2r2
	 EY93McR21JH7wjrj+EwQytWwT3/8Rg0XWjG9Pny3oXWvbBjmRGySqeK4KPwbcNq7G7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U7915FKJ;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0683606A334;
	Tue,  3 Nov 2026 16:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0683606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U7915FKJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793722499; x=1825258499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Acx7f7PNUJNNihS9jXTISjx6ZVUeRGm4ZDOoBevZJME=;
  b=U7915FKJa13azIbYE/daiFihw6YrsaPnjzrdtN2/0ho1ocDdZnzsic0F
   hVEgweixGfLALxC/lzHXs09BGU6+/T1RnMS0PHixRChUNKvHrpQMcwiJN
   TQVvlKahxTQ2pHp8xg7kA6OH1rmHbm3oEcysATpJ6E6Qc85v2m5j6hih4
   Q+wLkR43BUSnUAPTE25n2J1X2igSSf4tZYSd4TiNdBBGhyPTYVKuuexhx
   GsqM3nISxndBucA5CfscT8Y/LGRgjFjsMb3JC4H9INS9D/mgDv0RoHV7h
   Hbv2xMLlVVu4ILCc9LB3ulqiBuf7OYxgT8J9/laVjteW+1jpjLjujm41b
   w==;
X-CSE-ConnectionGUID: euUmgpmvRBmqZbpFs8IxOw==
X-CSE-MsgGUID: HiywbwjBReSTfCkptSPTSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2452774"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2452774"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:14:58 -0800
X-CSE-ConnectionGUID: nhPE4N1wTuS0wqrduR9jJw==
X-CSE-MsgGUID: rdviNjH4Tj6XJ8HBUI6SdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6620460"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:14:55 -0800
Date: Tue, 3 Nov 2026 18:14:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marius Cristea <marius.cristea@microchip.com>
Subject: Re: [PATCH v5 3/5] iio: core: add iio_fill_val_int_64() helper
Message-ID: <auoIfKeWziFMy0zh@ashevche-desk.local>
References: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
 <20261103-pac1711-v5-3-71c20101a52e@microchip.com>
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
In-Reply-To: <20261103-pac1711-v5-3-71c20101a52e@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 04:37:13PM +0200, Ariana Lazar wrote:
> Add iio_fill_val_int_64() to populate the val and val2 output parameters
> with the lower and upper 32 bits of a 64-bit value, as used for
> IIO_VAL_INT_64. The helper wraps lower_32_bits() and upper_32_bits() in
> order to split the value with a single call.
> 
> The pac1711 driver will be the first user of this function.

NAK. Use existing iio_val_s64_decompose().

-- 
With Best Regards,
Andy Shevchenko


