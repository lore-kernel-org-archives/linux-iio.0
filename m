Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A799242D9B;
	Mon, 16 Mar 2026 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669925; cv=none; b=JrPnk0HuCo5lvX8WXDGMWT91ihJaLkZzO6NbPJNhE/ZBqP/zbX7Th259JBqqwLJO+AA+0NPpS/HA8OYTfK//SyYsJm9Z7FRC1+yWQxA6D6tjUZG/7YS+s3zk0NOWKW5faOtO9FdC65EMeNadHh6wOxfMxVe4RDGKSwzyVVemIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669925; c=relaxed/simple;
	bh=XzlAeO35Nybt/uL//5fo6DmhGygRrTUlKYg0PPuM89Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGaUV10cAoSipax3UkHkCEA8veQ5uB14nNAdykOUikH5Hj/mP+ukrYjC1zXfAeB9g7ymjPWMaEkcygqBh9gg50E4PEq06MYjzDTn/eFvbry/+Y1ayByENh21J/ibduNWkhgR8SGuQd4EZ9kkNtC0UzeaVAc2HlBWfCLlEhKt7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmGv+O69; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmGv+O69"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773669925; x=1805205925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XzlAeO35Nybt/uL//5fo6DmhGygRrTUlKYg0PPuM89Y=;
  b=UmGv+O69NtWEn9035UMQv36+MqmwMowjpWJWHqSlOicuOFfdYYN/+7Gf
   uM53wIDbzPBQ43sLB9eHZglHRpsSO4hpqruf1OLVUumGc3VfGzvB0noNz
   RvDK0FGS+SC5Dj9UAJiVIKUuMoSedpPPhkg44CbM/Pb+wwQ+G3jtJursZ
   wrcNSyzwxL45aVPqkaMJpeXkXoUofifvx3JiHz7OtVLmSmuUIEmyV+4pN
   sQGVPsfTxKzS9zo12tTK18Pp5NTbl9zi0rDJsu4wGf0HWy488iaOaRNfi
   NupYzL/XWBI+j6W8k9M4ejTxPrcV4vavafc/z/sdc/IjpITY6jW/7rde0
   w==;
X-CSE-ConnectionGUID: ZHHzL/szQW2CydLTFUdx6g==
X-CSE-MsgGUID: /w3dl2UpSM+a85jSC9j8xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73702261"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73702261"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:05:24 -0700
X-CSE-ConnectionGUID: kBkIOTTJQgelG7e980sCAA==
X-CSE-MsgGUID: Au+yBR01SluMNaQTaZSPSw==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:05:22 -0700
Date: Mon, 16 Mar 2026 16:05:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Message-ID: <abgOH5Zo6J9m8qiW@ashevche-desk.local>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
 <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 06:13:32PM -0500, David Lechner wrote:
> Add a DMA-safe buffer and use it for spi_read() instead of a stack
> memory. All SPI buffers must be DMA-safe.
> 
> Since we only need up to 3 bytes, we just use a u8[] instead of __be16
> and __be32 and change the conversion functions appropriately.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


