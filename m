Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210138E12D;
	Wed, 13 May 2026 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670151; cv=none; b=FQYnRZsCre7oLU12JNtMUQVSAXEGxDiYrUalE9x3/lVJ2TmYAUhrokTzQwJYO9nZoXXdibbKb0TcS3SCiD06/oHHd7mo1RfGYwCa+E/Wj2WWhp4JfJajBkLtrw0xL9rsu+vnoDuW8c7Ze4AUnpCtqWddN3M0SvWUejmsocVsDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670151; c=relaxed/simple;
	bh=8mxiR+XxgdNhT8ozvLYhfjeXQk7wBZCvgc7vttru0Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZkNNz34j9JeQ+HCcoGWUkzKKDQaxqZ/EyxFdZvPvYruLFbLb5fNR8qeGMpCM7EuTru5NbqRteg+WrqFn8L77cpowsVBqlEgifporWWw+oTQ2PRLrwxF44s8Nx5KdmB0ihlaSD5F91/ek7U9Pph7x9MAdydKDkg8nnFhKC3JPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5PN1zKX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5PN1zKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778670150; x=1810206150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8mxiR+XxgdNhT8ozvLYhfjeXQk7wBZCvgc7vttru0Xw=;
  b=F5PN1zKXcMKSi8CYJb6QEABcEL+TqRebxqQ9lQQtoIHCmvrZhvWTKLvp
   MZ7b5pS4En9mGBw/iQUhOJsjIvgV3YgwK1JowHkBmS+cZ0ezao4yxTmyN
   AqjrGf9+aVmbIGBIg5LQTO/8FdjRoDP5Nw2X4lG7Z6zWY2PpBPBXg/3gC
   IEwo9+EdSGIaW343DyfXDoJcn7fJ8q9WgY1swE1YQRlhZ+2TzVTBoSaxQ
   Fhwpr1VnxqbBVqJOdikY4MGj8PvJAC0LSgdaJ7RiyCgvrI2WzY/SwqtFR
   0HajXmB8nWim6bsK9BFVmrFrK9dt5MfCaiKOL436cpqK4cu8uOhb28l7C
   A==;
X-CSE-ConnectionGUID: hPlIxsXZQsmVcYobZ8v2PQ==
X-CSE-MsgGUID: MtSqxAymTfuRdvXfjiyD2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79615431"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79615431"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:02:28 -0700
X-CSE-ConnectionGUID: hrsTuj0nQfaWozjhaJNHLA==
X-CSE-MsgGUID: nTpfcgmgTvuguCQjn3lwvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="239869159"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:02:25 -0700
Date: Wed, 13 May 2026 14:02:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 3/5] iio: light: tcs3472: use devm for resource
 management
Message-ID: <agRaP73wMoYjsE7I@ashevche-desk.local>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-4-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512223215.25596-4-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 12:32:13AM +0200, Aldo Conte wrote:
> Convert the driver to use device-managed resource allocation:
> - Add tcs3472_powerdown_action() and register it with
>   devm_add_action_or_reset() to ensure the device is powered down on
>   cleanup. Before this patch, the chip remained powered if probe
>   failed after enabling it.
> - Replace iio_triggered_buffer_setup() with
>   devm_iio_triggered_buffer_setup().
> - Replace request_threaded_irq() with devm_request_threaded_irq().
> - Replace iio_device_register() with devm_iio_device_register().
> - Remove tcs3472_remove() as all cleanup is now handled by devm.
> 
> Rewrite the read-modify-write pattern in tcs3472_powerdown() and
> tcs3472_resume() so the new register value is computed first, written
> to the chip, and committed to data->enable only on success.
> 
> Use a local 'dev = &client->dev' in tcs3472_probe() to keep the devm
> calls compact.

...

> Suggested-by: Andy Shevchenko <andy@kernel.org>

In appropriate tag again.

...

> -		dev_info(&client->dev, "TCS34723/34727 found\n");
> +		dev_info(dev, "TCS34723/34727 found\n");

This is not part of devm conversion. You should not do two or more things in a
single patch — split!

-- 
With Best Regards,
Andy Shevchenko


