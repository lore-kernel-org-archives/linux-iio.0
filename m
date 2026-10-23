Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763613;
	b=KamLI29o/D6g+VK6uar6kKo2a2AFqLtVxwoGvTV3GFlOoInB8jzWC+aJ6QJ61XwtfAQX
	 DvMmV8UHyHjar35RArSeem+YLHoZ1hZQSdwkqtLr9v996wF/bhJ5yh2jrNiwZjGRdQeN7
	 47Onr4GoniCT4gTwAn3WhSe+ndToTQNfF6lINgkK5wnw2qU8foOjUXdW/wmar4s6uTgv1
	 O3ZiQMW92MBLAw4fCCVnY4zRKj6sn+hELiwXjjsyVqDzfgFlCMMVMpe+taAsDIrU94NoL
	 /n7SVKbgSRd2kYfoqOjQ6dbR8uj3kRqgSyRBa22ieBTD/EDbRwYCoqykojqfxChD27Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763613;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ORhtAmG0qBKb8sZDK9ov0fjmK5SRqqJJe2XamVQhqJ0=;
	b=FpNLy7NjbpPXfDkKd+DvEQUmh6GpJ4ZTJZYiLTq8PLMsG8LmZoSnnoFr/CVHCjFgFGh5
	 IDVK8jOJ6AUamTX0QzILCgYk6jdc/Jy1gy46/eokr7XSp8LA8S97QxT2XaJyGMdLzI8gG
	 vihNFV0DrOZZ3p2JzzRZ4rh1+IZxY1QYgM8GY3oa+hELsOSycg7iCIK+NNBAnPyw16x4k
	 bXTNVKOlsbXsHaGzEMHRTjv8U7vEr/PPM52OGVr6+wscdXz3sgC0PNBltUB/nROf+MJ9d
	 QcPGJT1vkghjFNjDkWVeikeQjTsu7IrYq1GNPeKUeXjaUP2bLgvJU4faXt0RfG1phjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=avu6c0ov;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F5606A31A;
	Fri, 23 Oct 2026 13:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B80F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=avu6c0ov
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792763612; x=1824299612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qnUTN5bmg5EjJOE/IbYZWYzkK5hwAUw0nI7p3zXDzg4=;
  b=avu6c0ovlXM9PJGvVKJ3uFVyAQDWkMSmCj0/OVMhAZz6yAAajgIOtYyF
   UV0JRdU4syYxV6EHKxkgGK6ziZwGbY26Fs1PTJbuCJAGBDGsKeIBf2qyX
   YxVJCDBJhQ64AcxQRJ35O/2rAXjnfb/fuJm8EvmuEY/62VDai0os7dq3w
   HaTmQmESsgBYxHZj466ygM6dfs5b1XsBDaGwYdN/JVZf2L+lpUwRfTDEz
   Pivvt2sE1c1jsjiyiE/IBM6njhKLBdScCdZ9kPI7RbDfU73kmyTNfyhVy
   wYVY2TU9NZht4uuPrSj14+5MU+9gcRWXL84rfbP4ISKRpAEk6YWcgVtUh
   A==;
X-CSE-ConnectionGUID: uYtIll4mRJOYNru7E/BDSg==
X-CSE-MsgGUID: CtZB2Kh2Sje4k+nDKBqBjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1616999"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1616999"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:53:31 -0700
X-CSE-ConnectionGUID: guHjOejCT4yEx+MjTd/vKA==
X-CSE-MsgGUID: p6hDd+KxRNGhgPT+7hxH2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3633430"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:53:28 -0700
Date: Fri, 23 Oct 2026 16:53:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2 4/4] iio: light: opt4001: add support for opt4041
Message-ID: <attm1UUGq-K5Gb9r@ashevche-desk.local>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
 <20261023-opt4041-v2-4-ee320812804c@axis.com>
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
In-Reply-To: <20261023-opt4041-v2-4-ee320812804c@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 02:30:31PM +0200, Jesper X Nilsson wrote:
> Extend the opt4001 driver to also support OPT4041. The devices are very
> similar, with the difference being OPT4041 having two channels, one
> visible and one wide band channel ranging from 380nm to 1000nm.
> 
> The register map is almost the same. OPT4001 has registers to read out
> the last four values sampled. OPT4041 maps to the same registers, but
> has two channels, saving the last two samples for each channel.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


