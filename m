Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2D27442;
	Mon, 11 May 2026 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497449; cv=none; b=Dt6ZB5PrVomhjc/0U1U9jcUzJjTEriItDmJpjF7fu9h8kbatYkhnUUJXiYflMjOXSQLeQqyrBhFrqjEwVkm3ciIosNhW6WvDkSTXCH2P0pYlKUfaRcLD4n5aK8fRHn3dRbIegf+g6xFkESJilTedX0wOqw7x6S0pyqEPUlgNgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497449; c=relaxed/simple;
	bh=3t+mW6R+/9HI43g54mNbCqXkSn5ua1S+y8nfTl5n3yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+hQVKRqmJi45ms+zp6dJuzgO8tfI5C8jylKFUHBzafMnQTLjpPoKVZ7hfZUxD78yEgOhk2aolXokBeiJmGTUzMKUngse+/mz3OAOYuTXmBgM2UYzJoKjMOjWHZDdWey/qemlGs8MKqkAWQ7K4TLjXC97n0HtoHxpBItuH7mf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLVLtHFz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLVLtHFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778497449; x=1810033449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3t+mW6R+/9HI43g54mNbCqXkSn5ua1S+y8nfTl5n3yg=;
  b=YLVLtHFzX0bwX71yv0tMIfRwHhY5cHMo4iDE+dRWrJOw4czwqASytLr+
   i8H3P0y7MqZyEci6DsV+6ZWwrRHfwUp0b/NHLDM8krsoj0ORpgnR2NY9v
   Au9rvM3C+Uopu75+aNLqgfoaBuHugMOc5lEgUK+6Px9xrpEJHu5R9LxqB
   /druiG+jP8SIi4cBZSQR9H0XABGdjM+d2UJTpN09oWWU40Y+ICX4Ljhuy
   t3RAjA81/zbOLO8Uvojsf0Py83q3tRXvZFV2wT+LirCaNqH79BUA7NX/4
   4oyOpXlQn2oYAm7jHD+WE7j6gNvy7MtNUk0tLbKTA46VZmGMC0gZRyQmd
   Q==;
X-CSE-ConnectionGUID: doK6+LqbToOipHRvfMv1Fw==
X-CSE-MsgGUID: iJv+N7FXTZSQUqxY3mH5kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="82993030"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="82993030"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:04:08 -0700
X-CSE-ConnectionGUID: 57/o6IIfTku7kkOc8z4JxQ==
X-CSE-MsgGUID: fbBYv9EbTeCc44tlZ3JMsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="236448350"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:04:06 -0700
Date: Mon, 11 May 2026 14:04:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: light: opt3001: prefer dev_err_probe()
Message-ID: <agG3o3tXt605PBA8@ashevche-desk.local>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-3-f7879dc3455c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-opt3001-cleanup-v1-3-f7879dc3455c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 12:04:08PM +0200, Joshua Crofts via B4 Relay wrote:

> Switch driver to use dev_err_probe() to unify
> error messages generated in *_probe() and probe path functions.

...

>  	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> -	if (ret < 0) {
> -		dev_err(opt->dev, "failed to read register %02x\n",
> -				OPT3001_CONFIGURATION);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(opt->dev, ret,

We have client available, and here is dev in use. With this being said,
I think the proper order of cleanups is to get rid of dev member and
use local 'dev' variable here

	struct device *dev = &opt->client->dev;

> +				     "failed to read register %02x\n",
> +				     OPT3001_CONFIGURATION);

-- 
With Best Regards,
Andy Shevchenko


