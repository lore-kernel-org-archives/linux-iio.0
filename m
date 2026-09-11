Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D135200F;
	Fri, 11 Sep 2026 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114724; cv=none; b=QgUlM0cuIG6zrIudzrKNMzCdQwRrkDqRR3D+6j5AJDi4MsdXf8yKTo9slIq4+vpDr+z9R/n1o+ZEuEavM5bXhYTNiqxfYsXC+G0CmknBqN82Zf59RKGm38Tplmu6zec19IduUSLFoxweXncL/krnX2ZjN/PtSFoxRQQEMf4B+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114724; c=relaxed/simple;
	bh=nDXv6Y96Q8Iewfya/R7dSrOBB1xFG/BWPpt4OScrzHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgiLVJbj9Ia50ACjNIVwAHrXZ7Q7JKZzEV5KNWkIdyoLt7pSwM9ECSfveuzA/pPfY2hIU3hhK2NyJxjFCOCypAlCv4CgGlRC6QJ7Dyq1L7HHgcQk50s9z40hqNUTNEvZX+CkJWp8jiXEGHVfQmpV6ZSZJYm2qB82+7fLU2DD7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T637TzRm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T637TzRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789114723; x=1820650723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nDXv6Y96Q8Iewfya/R7dSrOBB1xFG/BWPpt4OScrzHA=;
  b=T637TzRmgny8cYKbYhegfmcBDMAFqwOSSuhyKCfPo1RmNfZf0zSzYJ2n
   4ZJeaq9bZBMVkHG6XKvjGQ5p/U7pk6DmCbQDVtfNUbWpy9rGsjmHW+cj8
   y73eN3UW0YZvnSXj/MID3T1jxa+NLcZ3frAHrVDQEly5p9jEhtAj7kzN1
   XbITcJKTMM5Vml0GsTx16CSEqaLPUPk9xYVG8AuYIdHNspKLwp0UBBmqV
   RcytKoKEYii1zc45wHhBx8OrvgXVE6c2ngwOLGX5+VEriulJYyA55TpQH
   Xy+cNhSA1nLDNHQSJwedBTRw8d3Z4smegEK/8goaYjKJtb7ha6oCiARpw
   A==;
X-CSE-ConnectionGUID: BgeS5zbtRNSaTaHFjScptg==
X-CSE-MsgGUID: ZzQbmHruTdOEMI6yJj5Qqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="115115579"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="115115579"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:18:42 -0700
X-CSE-ConnectionGUID: S84+z6GjS8GGPHn2UPBX0g==
X-CSE-MsgGUID: XkbMB2YNS7m9l9RD3Ljf/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="296844468"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:18:37 -0700
Date: Fri, 11 Sep 2026 11:18:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v7 03/17] iio: backend: Add support for CRC
Message-ID: <aqO5WmC2TjXVduBA@ashevche-desk.local>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
 <20260910-ad7768-driver-v7-3-7f70b07627e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-ad7768-driver-v7-3-7f70b07627e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 07:36:21PM +0200, Janani Sunil wrote:
> Add a backend operation to enable or disable direction-specific CRC
> handling. On input data paths, the backend handles CRC data generated by
> the frontend. On output data paths, the backend generates CRC data for
> the frontend to verify.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


