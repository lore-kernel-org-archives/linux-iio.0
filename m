Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD438C419;
	Thu,  9 Apr 2026 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775727493; cv=none; b=Bg5JFjm3IHuZN9ax7ubqv/wS7qOPAHGPXshCzAj8yPIggXCtxTpo/Ko/qsqZomAbgf+JyTbNCcbscVceZpuZFu0amdaXmxBYZ7WTyHuPMZcs0GkE1dpI9MwmDMqp5yYvBWac6gSFfvfTOK9S3eePmuWwH1n3Rx6nz88Qbo7b2Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775727493; c=relaxed/simple;
	bh=d28MZR2CYNgtyCslv8ud9mHP49RhTKpmrl0qbhB5Ym0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7w/4OKhFWcqzbpSI5mAhTn0PW5c/I0Ni5XgGfOKb1+ppncCtxdklRH4bIgRruse/MEx7EuboWpnDVNiqMc4AgExwAteac1OB/YDeNbOF0go0/CzNNdqTbWrAWil2xo0VEviLU8XdXagvnzZOrF+xA/NYzYMnHCGTQkR1PwAcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+AW5j4R; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+AW5j4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775727491; x=1807263491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d28MZR2CYNgtyCslv8ud9mHP49RhTKpmrl0qbhB5Ym0=;
  b=N+AW5j4Rnod2iqnpAHTrqwSEIm+OSB0ePOWt0HDaV0TaI+nsYPh4jxW2
   Y6OSnjANzoh3vhKwfBWiB8c/CDGFIX2ShBuy4d+vsfGqMeJ2+ND0lhiW+
   GPNjZJNHUcrYEaI4qsG/vgUORsMi+CXGBx4nOJ/f2mUbCFimwzj7TMcTS
   44aq8NcfAQADFPfTDVFiDdAXTkHDz8FbKu0T8Mt1Z08nxVjzTbwQbnOgX
   quEz3awdzzsFQdsugDH6QO2M71faGynv7fYtpEld7K4O3ed/p/qJvMYtk
   rcawB+dVYn+gE4m/Q2xc86meOnJTn+8FV+UGXD6V4fsRw9HLKYU8TxxO4
   A==;
X-CSE-ConnectionGUID: VgocGUJRRUaX611Ht175Pg==
X-CSE-MsgGUID: jY3nElaiRXyGUWZPniNw2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="99354860"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="99354860"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:38:11 -0700
X-CSE-ConnectionGUID: WIqF9mZyRJuXk2SUZ5ZsyQ==
X-CSE-MsgGUID: yTq9P2BoT3WeTNIwDixW7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="251859213"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:38:08 -0700
Date: Thu, 9 Apr 2026 12:38:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: light: vcnl4000: make pm_runtime_enable()
 device-managed
Message-ID: <addzfuu5YroX1l9M@ashevche-desk.local>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
 <20260405-vcnl4000-drop-enum-v2-5-7c8dc98c3974@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-5-7c8dc98c3974@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 05, 2026 at 07:08:42PM +0300, Erikas Bitovtas wrote:
> Replace pm_runtime_set_active() and pm_runtime_enable() with their
> device-managed counterpart to remove them from vcnl4000_remove().

...

> -	ret = pm_runtime_set_active(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
>  	if (ret < 0)
>  		return ret;
>  
> +	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);

This moves the calls, now what if registration takes longer time than
autosuspend and device be off while user space or another caller can
access it?

>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> -	pm_runtime_enable(dev);
> -	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
> -	pm_runtime_use_autosuspend(dev);
> -
>  	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


