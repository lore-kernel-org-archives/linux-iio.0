Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1053806B2;
	Mon, 11 May 2026 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484567; cv=none; b=NUL7SF8PNC7QwQJCRBNLyr8xKU6J68WsYz5+TMUa9zArDMM74TENkG2y8+2RRBKIZmyAKAGJENSeZn8nScY7h/6ktTr63iH+BiJmQTvSQYGy8yxoz2DbIWLEF/zJEOgDYt3ZIzOmP7Q0B7uoyeUEPtqhsUQxzXqFi/8/vjMUJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484567; c=relaxed/simple;
	bh=WT55UTsZJddGiBGJjct98q89RtSi5GGDJs51+PMOywU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKRBBWSFAOsdXtB3mIYCXRoSNxKW8tPtwYEZOtSvS2cRBw2d/Pv6YpxSPacy/aXfhyBMJYPZC4z9LV6PXQe70zIwzrInt79EXUiQpXgSJy1DBG32Mf6XQHlT1F2LdAQZwJpeLS94Z8tEr0Y4fOU6qRmpFPO/3EGUh5KpZBurhrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWBj4/P7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWBj4/P7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778484565; x=1810020565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WT55UTsZJddGiBGJjct98q89RtSi5GGDJs51+PMOywU=;
  b=CWBj4/P7APBiGMquJBVjUp8QYhW4oq5hqp8DKjE8omCw8sJFqIPVdW59
   90L9ru1eBWX0J11+3H/OAUu13VsAvCr9JKH7hhjgo62nvUL1z1q8ZtrSH
   TTWezn24TbeDD7y84RXLgzjtk6YfDE0e1vH7+snZBpgqPdzJsDs4b9QYp
   l1OS9fkEoyKIm+YNZeWTvO/668zZqIuHnZWm4gbluvdrAW969UE1jO79C
   O1kLwE1IX8X8PzgCT5sH2iAik184z4RSnS7XQ98ZCAPkQVpforQHzC2CH
   /x204ZwNGDoYnk7k6LutrogCfwa/e55uKRzkk6arZI5l7aZrCE6PkRBIo
   Q==;
X-CSE-ConnectionGUID: CLV2g+7OQNSJKnAArRUQbg==
X-CSE-MsgGUID: 3NckLn3KTQir+lSJyLcMFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79546748"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79546748"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:29:25 -0700
X-CSE-ConnectionGUID: wOYdJFQKRwqvexshMHMKvQ==
X-CSE-MsgGUID: m5Mqh94GTEu/Nm1pAF/rGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="267739739"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:29:23 -0700
Date: Mon, 11 May 2026 10:29:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	alisa.roman@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ad7192: replace usleep_range() with fsleep()
Message-ID: <agGFT0aHuqWGpUPq@ashevche-desk.local>
References: <20260510113921.50133-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510113921.50133-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 04:39:21PM +0500, Stepan Ionichev wrote:
> The AD7192 datasheet (Rev. A, page 34, RESET section) says:
> "When a reset is initiated, the user must allow a period of
> 500 us before accessing any of the on-chip registers."

> fsleep(500) expands to the same usleep_range(500, 1000) and
> keeps the 500 us minimum.
> 
> Drop the redundant "/* Wait for at least 500us */" comment.

> No functional change.

Same comment as per other patch.

> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> v3:
> - Cite AD7192 datasheet for the 500 us minimum (per Andy)

To have it in the code comment is much more important.

> - Add this changelog (was missing in v2)

...

>  	if (ret < 0)
>  		return ret;

+ blank line
+ comment as per datasheet

> -	usleep_range(500, 1000); /* Wait for at least 500us */
> +	fsleep(500);

-- 
With Best Regards,
Andy Shevchenko


