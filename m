Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096659;
	b=bNujpboCv5jgrul8xPkLdvduw49rjstk3hkKsnfpvo7IkFMU8n/vbdlXUdEwrKRx6wpN
	 3jF9ax2TI6ZzP8ftsKNRTEefeiQ9JsjqVFK6OPkLdgw9soSdoAdJsr4Aw5YV8Rcv0cnLY
	 GgrJlZh59VCAKpFHPD/06cyDtSRkRovik/A6P4BfOvWtMrpvP2FMQzDgW6+xXN31q8rqr
	 BXYfltkq0GrJtFv1kPiymxD9bY8mmzjVGBef2LvEuIq51LuLlb3d5H2rIlMoI6UxQXwsL
	 6y+y1fF+zBPS0jsc72aJoPYQwZUBMkjDZrOTIJ8KFuDD1fFRBvHa9N7EXdmw+TqZpnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096659;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=MH+utCLByoHUrkCDfZ5Khn4rliwPXSZJfLR+w81syWg=;
	b=IECFiPdcSLHQMJiEcd3uOAK0UQiLrZJDXYGlaNuHcSA/IDgG8RZVvVOas06q4y78dffa
	 F0eoykugZ9ulvMZU/qY8Q1rA1NMbvh53vrwZ0+VHU9qe1ZpdEcGOqJ0Sfy/xFGzPKbVcK
	 m9Xjt8ghX1R4viq0FyXW0BnzwaMXoyMcNhKY7DK+wFQHl0op1G6fZt/whncDWZJmWu2rN
	 RVt2yKtvzWbv01hymIjGjmj2AGKU7g9ciVRb0FqXrrHxY5yVjufhCSmfI2vfaHQrZ4sWr
	 NqF7GiMzxVbBr4+z4MEp/SWNBBGh4JYwrE5UJCIA3O12AgB0EGHAh2EZe9JPXgLs1Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=azW2Asqz;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70102606A31E
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 10:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70102606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=azW2Asqz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793096659; x=1824632659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QMU/oM4MD0LAaHarQu7t7HgzgZowp7/olk8I1Z06YEs=;
  b=azW2AsqzNpNKzKQoHWYcm1snGwX2UD1YNJPM3nAEN2hOO/h5h008zO8p
   9Q/Lt4/PvZRgIM1EoPnz3qcvDGWB0l1RnjWgPKRaMCWUk/CQPxoknRJ1t
   4JS8hKPPLn5X/I9hQG8fbIHG1LM2KIYP0/8OaLs568V/YWiHW+r7rjDCL
   hTkqrU9PwdspuickNerX3jkIr2pm8MJOnjB65YM2Q0BSZr83tvl3UcCnd
   RXrJ8T9paZB/LuLmTtoPhMP6GpCAZsax3sYlnlr2df7JOdTJI+dVvEBcb
   bcqQD5Bs+N2sCfdXyZxIvfbKpX428e5WhbGrJvx+r682TQ6fe7jQ4N/r9
   A==;
X-CSE-ConnectionGUID: DFxhr7Z1RWeMbha6+VKIbw==
X-CSE-MsgGUID: OOmSowGIQmK4VXR+Vgo+jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1676350"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1676350"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:24:19 -0700
X-CSE-ConnectionGUID: /U5xIUatQ1GFHoQXL+3CQA==
X-CSE-MsgGUID: Wi48zNwpQjyaE+IkKHlqBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4590658"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:24:17 -0700
Date: Tue, 27 Oct 2026 12:24:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 32/39] iio: adc: ad7887: use iio_push_to_buffers_with_ts()
Message-ID: <auB7zg8H8bMGchzw@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-32-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-32-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:50PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> which is a structure within the iio_priv() data.
> 
> Replace the data buffer with one declared via
> IIO_DECLARE_DMA_BUFFER_WITH_TS(), for 2 __be16 channels.
> 
> Use be16_to_cpu() to replace the opencoded equivalent.

...

> Otherwise I might just rip out the pdata path in the near future.
> This patch being an example of how it is causing maintenance burden.

I don't see users in the kernel, I think we may just drop it for good.
If anybody wants that, they can use software nodes in the future, no
revert will even be considered.

...

> -	return (st->data[(ch * 2)] << 8) | st->data[(ch * 2) + 1];
> +	return be16_to_cpu(st->data[ch]);

Add asm/byteorder.h into include block. And yes, the include block is a mess
in this driver.

-- 
With Best Regards,
Andy Shevchenko


