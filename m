Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316143DEBC;
	Fri,  2 Oct 2026 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927242; cv=none; b=fBQwZsgoyHw0fkKWA7OswgyiEAf240FtgcqZ8BxZj+mCnZTiAWwEKxDWuSAzbjuIebZY8XkGyssJZYzOoBuFFMCtratJkw+rOGsdm+i0CV3lkgH60rovVn9q48vlhwNIEUQDGIDsVq/FOlajkzK8tEEuDFlMxbfmJHgmZdS9So0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927242; c=relaxed/simple;
	bh=Wxx7BE27k32cM8Qguk+q3PFzErHd4vfXpg4whHpDgzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGlWETkfE6tOii4sphzowWumdgGx+8eiTuM+7KR5SvdQ/nNr90W1QjYspqQNW7vtXg0vHmSj2DBv6ScqDKz+WyFiEpEa83lKwIiSK1bwCufpaHsjxLuK5EKwmnuKxdFpNdx8ptcm+mWZhtBDrMzjtAhDExrgChacuBoN4il5RPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmSfrTsB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmSfrTsB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790927241; x=1822463241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wxx7BE27k32cM8Qguk+q3PFzErHd4vfXpg4whHpDgzg=;
  b=HmSfrTsB6I4tDcZZzUqen+y1FVYt0Sa9pv77H5kxhslveJG7vS8xlaXo
   GglXzyZ+8gjevT4P/Ch9HeT7YWKx7X5PtFzl2mg0x+zj+C5EXMjqdJQDz
   sQL47TCbyeS0tN4K0LyhY4k5kEFwLXanvBbVn9Y3UQHxPgQSr8hyE7Qt5
   87ylFNrSXFVAT03ZoeSUEuLQKdGYzdvQpjGg7c/fZlCumIEEaxXJOns9r
   XIK0E/BjHdx9ca+8Is8IEw2JgW3E6fu7bYmySPc31NqQvr17GgM2kFF1s
   XAXLSXNccwhllyWmYE1kYweqoeO45Y3O4DINrtguuNjyjEW2T/HGJZzU9
   w==;
X-CSE-ConnectionGUID: sAKKlbJXTn6+mEJqxVuhTA==
X-CSE-MsgGUID: vEhwpJv6QRO2dlda0l0XIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90459667"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90459667"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:47:20 -0700
X-CSE-ConnectionGUID: Y4YMcAxLS4qVHwOXPxc07A==
X-CSE-MsgGUID: jJsSHN8bTdGwfpzvTMPt4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279944467"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:47:17 -0700
Date: Fri, 2 Oct 2026 10:47:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v11 1/5] iio: pressure: dps310: use devm_mutex_init()
Message-ID: <ar9hguH66x33F5Wk@ashevche-desk.local>
References: <20261002072526.250081-1-zoone.rupert@gmail.com>
 <20261002072526.250081-2-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002072526.250081-2-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 10:25:22AM +0300, Rupesh Majhi wrote:
> Destroy the mutex on unbind so CONFIG_DEBUG_MUTEXES can check it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  	data = iio_priv(iio);
>  	data->client = client;
> -	mutex_init(&data->lock);

+ Blank line.

> +	rc = devm_mutex_init(dev, &data->lock);
> +	if (rc)
> +		return rc;

-- 
With Best Regards,
Andy Shevchenko


