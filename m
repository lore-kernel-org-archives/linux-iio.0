Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1D35DA65;
	Sun,  5 Jul 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783261459; cv=none; b=E8p4j7vx6Un7XIGOQlJiUqruIOIhB7yQao7nJU25R5tiYYMXxWAvqY+hodE0GHy+94LyYnbIlTVyhVfqT+i6ZQ04PCkHWRRtFZNOhzQD7dTllqHhstKdKefOzYzoI/pu+FLw4tKQnSdOU2l165p+5F7IE+sdXwGBfnJIX2XBP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783261459; c=relaxed/simple;
	bh=ioBsz1cxqqJ5Cfwc438MwhnrR79hn4G9fpou+DxQcxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOD1clW0noeBl76pj8PEa1dXaBwsT4HVtZ8woX2vDsmirg21wVvqkWcG6hEg3gw2oZPdptIkcBM8UeQ4EKLXE9tgs3SVWeQ//PgU7KZOtn4wEtqsZLBc0ldLmKEjCiALcYsvh3ouSoi3Nq67Z4WmnFwi5poPUkC2Ts7ddgjRyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KnoqeCKp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KnoqeCKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783261458; x=1814797458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ioBsz1cxqqJ5Cfwc438MwhnrR79hn4G9fpou+DxQcxc=;
  b=KnoqeCKpv+2nLED8z0WgtnfexOApDNJ1QY8hjXHfWwGFHIWv0ZHx0W46
   OVFnpX7yLo2QQpFl+mevJL6TJYD9pJwBZbfXAI2Wa93S8h4nGgXUoWDfx
   sX6Ea9o93TrDgUTBwyG1xjBDuzovHlCG1/lg3QTbJyvKpJKwV7wMApBQL
   FK159ignnRbLNuA3724UxNVuDmKs2LVKBPdqZJANnzVAqbav5qYPKD1J9
   p4lpy7FAEVmXJvm/M491fKnUsCudk1xYVYkS/1jDUE34Mv/GG2K2gOpoe
   k5HEv/+I8C9wZ4f5NTuTBFYCadKHqnIsuQmPzwbU0MkO79D9qGGozDDt2
   g==;
X-CSE-ConnectionGUID: ONPLloVZSXGZ+d23Mq3bfQ==
X-CSE-MsgGUID: Z69KLKgRQ0Sn57LymprQmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95288051"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="95288051"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 07:24:17 -0700
X-CSE-ConnectionGUID: bI6laMnJRimNV+4UP42YZw==
X-CSE-MsgGUID: NJ/qjkHoStKL4ecwCtZWAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="250829420"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 07:24:13 -0700
Date: Sun, 5 Jul 2026 17:24:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 1/6] iio: dac: ad5686: refactor command/data macros
Message-ID: <akppC9oRzspyq8du@ashevche-desk.local>
References: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
 <20260705-ad5686-new-features-v6-1-269594c7aae5@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-ad5686-new-features-v6-1-269594c7aae5@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 05, 2026 at 12:38:56PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Replace usage of bit shifting macros for FIELD_PREP(), which would not
> ignore bit masking when preparing SPI/I2C commands.

It's not marked as a fix and has no explanation why.

-- 
With Best Regards,
Andy Shevchenko


