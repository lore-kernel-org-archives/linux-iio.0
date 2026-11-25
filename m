Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616436;
	b=ihcRuhBQNWM0uL+V8N/csWTA5BRnFMHht8lCXvho6leZ/xP/9xQJYH0a1pHYLZEJ5rOn
	 mN3gTPlrmqb7POsjSKtlUnY07/JdC98+1qhAQ5ZljY2RFmuxsZuwQsTFPlC3CoMyIG6UC
	 eL6r+Uu3LSGeVK6f3aAaBwljQOk3VtlHOBXx7jfShDj6IKsvCkVrrPw+KdAQJkXS0gSeK
	 VgwADRb5FEs6gQFEgTLIZI5BB62p8OWT1SijpHBHroVjsVGRMEYqip/UrGLBkJdk3ipXy
	 2WyBoY9pkkgJpXH4471u6PkpiYvGbiDurLT3rPll163GuEDga1ZV8aFoMK2NE25tFEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616436;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=P7XJXxKmJ8/GOZB4yE4VWhOGN/nRrmax2/QYPkzoims=;
	b=baj0YtxR7WBDqzd+rd6UKGa7ewohUrtvtoQYQW1Br7fkkjtDiWUgDkcO6kjtuwq2aesP
	 PgJRphWr87r0djSssmPlWjqCJb7/90hJ9rFuXFbn/4yXhOmeMok2CanmZQUwBKJpN0w+W
	 VamVyK1XTW1ziO4D6aDR3AsTbsB03cPFUS1mY6crJcwCamKByapIJvQp397x+8qlQNrRl
	 KKhcOo8ABrnGlFlxJ7iEATJaelfrQSIZoAZQiDjFw8X4MZ2YxZGQ66OwaeEwnLgKm6GAI
	 Q08jlM1OoXVKqpjXbNW1xgvLluz8NhY0CWiz1AO+nzD40UPEyhVD4M39Cw46vkp22bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gu6IAk5n;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD9606A321;
	Wed, 25 Nov 2026 14:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DD9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gu6IAk5n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795616436; x=1827152436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CefdWxG7KFNULvAOZtSEI8rYEisnGf81C84Zk5BBZ1s=;
  b=gu6IAk5ngXf6gR6xp9qZGsSS4HEOlZcciHyE+VF85mUqjX2p3CgGsrsM
   RhiNkQeA5RGuqESodjnetIbvZF/DLyIU2PNNP4eYz10xXCfK/hyaDDUjl
   hc9qRYUWB4xhsxGpivgRgSW6iAWKReiQoDvIeNoUB6pnxS/0miJHCNT3T
   qU2cHj/Kchd5G/Fd1TGr37dhJXRyOs0iZ4bTW4i3w3Do+rlx7vW+SKT0Q
   1LdZRsanNegYZtR6AklKDtVINe6AuclOubt558N4G7w1OkgLDNgkmN7Ia
   VEtRFqAbMB/yJlow1YftR0T1tKe6oylNnsRl0Tp0h7pEpl1N5XrBwM9Rb
   A==;
X-CSE-ConnectionGUID: fS0hTuLMQGOT8dd8mYGj4w==
X-CSE-MsgGUID: iEi58oQAQjGAWYe1orNxDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4375341"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4375341"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 06:20:35 -0800
X-CSE-ConnectionGUID: 6aSUP+SFT+W5qCgoWANmuA==
X-CSE-MsgGUID: +g7AwX5wQNaWJVjGHO8JfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11874248"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 06:20:32 -0800
Date: Wed, 25 Nov 2026 16:20:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v2 1/1] iio: core: Split debugfs routines
Message-ID: <awburpe3O_XkhUMG@ashevche-desk.local>
References: <20261125140251.384361-1-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20261125140251.384361-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 02:59:40PM +0100, Andy Shevchenko wrote:
> Split debugfs routines into a separate file for easier maintenance.
> No functional changes intended.

...

> +#if defined(CONFIG_DEBUG_FS)
> +void iio_debugfs_create(void);
> +void iio_debugfs_remove(void);
> +
> +void iio_device_unregister_debugfs(struct iio_dev *indio_dev);
> +void iio_device_register_debugfs(struct iio_dev *indio_dev);
> +#else
> +static inline void iio_debugfs_create(void) {}
> +static inline void iio_debugfs_remove(void) {}
> +
> +static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
> +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}

Gah, these missing inline keyword... Please, add them when applying.
Or tell me that I need to send a v3.

static inline void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
static inline void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}

> +#endif /* CONFIG_DEBUG_FS */

-- 
With Best Regards,
Andy Shevchenko


