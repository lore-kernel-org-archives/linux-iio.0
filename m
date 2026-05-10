Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F115228CB0;
	Sun, 10 May 2026 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778399153; cv=none; b=eBCegBnzvcPUFR/NeOnRzzSzTAqlgzuxaw1inYrLbRi8w9jJH7+ZdsyRTkwHGTRQh4G9N7/6yEUu3K8UuyquYMcihQ49piLME95qnXteWQCQHb+xoGjkvM92/wjTNi77OsbUtt6kEKiBG/+4fMoS5irOrC/PUrOsP9C5muVGlOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778399153; c=relaxed/simple;
	bh=d3Rhn5UO3/0JsVSzG+DthgMlLavWYkAyytTrVrQQ8NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRU77LavfNdczb9EA8gKJavaHQ9dBviVpA/k8ZOPVpnkEQfmb45aTc9PAPrM0FspOKQ8Uofg4QO8H3ZwHOhndqBDSrPxcmQnx4jViSajC/UUp/kdQzX7rw6A3rtflrMLOKLExK4dWaTcs0rrtWlC51paa4m1zbap6fT5wYjASbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hk07oB4e; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk07oB4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778399151; x=1809935151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d3Rhn5UO3/0JsVSzG+DthgMlLavWYkAyytTrVrQQ8NI=;
  b=Hk07oB4e0+Ymi0KlZnCxfeMN0tsC65RtzgZ4de6OY9ouxIGLqpezp3zO
   AmB2QfdxGiM9ua+pipWhjOFAQV9WdpXriUjLO/mfYZaQrZHNl2mfM9wUY
   +PiWZVXgYeI3KuDBT391/J2ENTFoasNUJQb+FmtudV/lkE9adnF/sVSPR
   tAc21mbZJLlvL3iTu+5Kq2WLliYFwZRWz1PGaPdZk9k96YTbtIWSsoH8q
   PZuk6/UEPnxgRCzteaD1d/p/+HrKUjRJa5Ev68cGxlgu5p4TOX2f4x61X
   6WjfDakyXuQ0hWYCe7vaXcl0Ej3FSyxv1cpgpVUqjTLo9NyjzZ5NSEc1j
   w==;
X-CSE-ConnectionGUID: BDUVj+vHTzi3VjFGZAmqNQ==
X-CSE-MsgGUID: rz/GP/PGTWmiQ3MVQm/TIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79258717"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79258717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:45:50 -0700
X-CSE-ConnectionGUID: b66BKEjfRO2mal0w1gtiyA==
X-CSE-MsgGUID: VZS98VipTm2+ArmBJc9TBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="241146663"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:45:48 -0700
Date: Sun, 10 May 2026 10:45:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: document SPI interface
 switching sequence
Message-ID: <agA3qSyLQs1_ySKh@ashevche-desk.local>
References: <20260510072918.85734-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510072918.85734-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 07:29:18AM +0000, Hungyu Lin wrote:
> The device powers up in I2C mode. Switching to SPI mode
> requires sending a sequence of SPI writes as described in
> the datasheet.
> 
> During this sequence, the device may still be in I2C mode,
> so SPI transactions may not be recognized and can fail.
> Such errors are expected and are ignored.
> 
> Add a comment to clarify this behavior.

...

> -	/* switch from default I2C protocol to SPI protocol */
> +	/*
> +	 * The device powers up in I2C mode. Switching to SPI mode
> +	 * requires sending a sequence of SPI writes as described in
> +	 * the datasheet.

Add a reference (Section number and title, and/or table / chart number
and its title).

> +	 * During this sequence, the device may still be in I2C mode,
> +	 * so SPI transactions may not be recognized and can fail.
> +	 * Such errors are expected and are ignored.
> +	 */

Otherwise it is indeed what we want to be here.

Perhaps also add a line closer to the code (that will be visible in the patch
in case someone ignores to read the comment)

	 *
	 * TL;DR: Do not change this!
	 */

-- 
With Best Regards,
Andy Shevchenko


