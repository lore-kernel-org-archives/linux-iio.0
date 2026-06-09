Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5EC42882C;
	Tue,  9 Jun 2026 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016822; cv=none; b=rPME2TwGV8zHxtgC7wx659TCwT3zmlJpfYe5iEi70KyyNDbx1klcdTIXlelNgrSqr8e47L/j8BsZhUmYCZnjIVuo9tIK+iZkTgfTvukO8YDv1dgOtfuyJK1QZLVjicSxWoi4nNTLsIZ8zKZCSkRnQBcsiDOCpf83ZYYtfwbv9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016822; c=relaxed/simple;
	bh=FRmFW7y/c7/skVXDIqcrF5qMjZh+zhY6k6zFkxYFLAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYU30nOrGA0ddpPVZFNjN7rkNnXVm0pZbo/950HhfeaR8F2g1ZWkg0CnmTwnzFlrnvciCot+ZuGZKeRfJ4im6xY4vw5hG946nOlb/4+2x6/hWwIoEJgOFQikTZ1fG3sRPEixlehTsGQr0kVztsO9m0yY97Xh6d1HYsA4aTUSdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htpxhgRt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htpxhgRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781016821; x=1812552821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FRmFW7y/c7/skVXDIqcrF5qMjZh+zhY6k6zFkxYFLAM=;
  b=htpxhgRtYSUfufFuYiGDinyzhvP0qizGsmz49zbQ+LWPux5OmTnMQb4i
   pOvnqBAD2HKriAkNwgaoA5ShCP48oxUfn5B/RyIEVFObHAH92ICoY8Shu
   uR5Q835Ty7haT+hesHMdHbLZ2R5/LSLcIuq3xzFI0uDbX4CzhjpQyz8y8
   TBB0LAPTFzcLZO2TcCu7+8fQfFRTsNCsW9xQDq/LOd4TSxkzP+bU9qEeG
   uCoHvV3wIp8neevyQp/OtsHde8njjCIHzlbN4GzaBOp+SmfGhTne+N7Wc
   q9OvsNCht7tqKpi+i7WU+jSM/65Xu78OLyC3SYlXw9v86LOU7xELtwmVw
   A==;
X-CSE-ConnectionGUID: 26/mBKsbTwiDCF1K0wxAAQ==
X-CSE-MsgGUID: Is2G2nxCSbKIpjUZB9NEtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81632436"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81632436"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:53:40 -0700
X-CSE-ConnectionGUID: inZsok33TdmJwH1ZilPzKA==
X-CSE-MsgGUID: mPCbVBLbQOqhkMUkNrd4wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245975046"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:53:37 -0700
Date: Tue, 9 Jun 2026 17:53:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: tmp117: add TI TMP119 support
Message-ID: <aigo7vb8eotwamG_@ashevche-desk.local>
References: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
 <20260608-tmp119-v2-2-30c3537d5097@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-tmp119-v2-2-30c3537d5097@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 06:00:25PM +0200, Romain Gantois wrote:

> Add support for the TMP119 temperature sensor, which has the same
> programming model as the TMP117.

...

> +static const struct tmp11x_info tmp119_channels_info = {
> +	.name = "tmp119",
> +	.channels = tmp117_channels,
> +	.num_channels = ARRAY_SIZE(tmp117_channels)

You want to include array_size.h.

> +};

-- 
With Best Regards,
Andy Shevchenko


