Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6B3EB816;
	Wed,  6 May 2026 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062889; cv=none; b=X40FwiqdoS8G4d5f5NZmg6VHjZmcC3KIcHSikkWLXKpXzhMIn5T7M7FZOPb/lr3iHC7zVkSQKdVJiokI6BTpzbejBdMzDXewYUkOhPg7m5GmtKEOW9565T724G2gvl9df37kmaaEL1379pX8Kd7gPubPZMTRcTapr8ZiOXc2jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062889; c=relaxed/simple;
	bh=uc5jcGiv8MUIqVawpgKNvOMWtGIYu/N5b639SJ3zaIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTa4elzQMYI/nb7y8WWAFJmXqz+XvVI5NuvX+WfYeXnv7k0oxnrNlONOOO7E4DUluG/FEGXwYbH8wEwZTotbUDWKaGsvuOs/9Q+3WUPwY1wCBJ3Lb0a5AyYST9hELHuqNrBYTUi1LN2FymG0B78wa/71VMVuCg40vWeUrv0/oGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFS4MZYO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFS4MZYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778062888; x=1809598888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uc5jcGiv8MUIqVawpgKNvOMWtGIYu/N5b639SJ3zaIM=;
  b=WFS4MZYOF5gSnEJlvgJyLftM01h5mM1VClz+bO7v4xXD6y47Kfq6IR7d
   HuRdW8L/7jK1oBb9sOTOy+mgl21jYan2uMkTiYKd1ZEW9n9+NKgDDX1dF
   W/bYdShaZfFW119gxQMwYYxyo25xSPgyPWxTTdxOutGlokbGYj5IZ3OT0
   O06TUtpu0cwJeg5/KEC9zAVfr5SjJNmwRa+cleuMh6mlQ+HLkGIUM6+9e
   kvhdlS8YTGbhy6qNla00+mFArNoKw2dzlQlsOfRCNZsPh0OWf5jFftjc/
   98VjzboUZ3qFpTXsFXVUep8cD+UQkVNQEDb6z5z42G1SfCs3eTpV0mTD6
   Q==;
X-CSE-ConnectionGUID: C1+RcYtqTymfbqgXFLlt8A==
X-CSE-MsgGUID: 7zjDaehpT1Wd6pzwbyeoVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89298054"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89298054"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:21:27 -0700
X-CSE-ConnectionGUID: X0H9MkwRQU+kOPljia8AOQ==
X-CSE-MsgGUID: pCBR/j7ZTjCDNh0URg4Cxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="241109094"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:21:25 -0700
Date: Wed, 6 May 2026 13:21:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 0/3] iio: light: tcs3472: devm conversion, wait time,
 locking cleanup
Message-ID: <afsWI3MKoWZS4mL3@ashevche-desk.local>
References: <20260506094311.222500-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506094311.222500-1-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 11:43:08AM +0200, Aldo Conte wrote:
> This series of changes modernizes the tcs3472 driver by completing the
> devm conversion and updating the locking style to use an automatic
> guard (mutex). Furthermore, it implement control of the WAIT state,
> resolving a TODO.
> 
> Patch1: Converts the driver to use device-managed resource allocation.
> This removes the need for an explicit remove() callback, since cleanup
> is now handled automatically. It also adds a new function called
> tcs3472_powerdown_action() that powers down the chip when the driver is 
> unloaded, removed or when probe fails after the chip has been enabled.
> 
> Patch2: adds support for the wait time resolving the old TODO comment.
> The user can control the WTIME indirectly by writing to the
> sampling_frequency attribute. Changing the sampling
> frequency attribute results in a change to the wtime while preserving
> the current integration time.
> Similarly, if the user has previously set a sampling frequency and
> then changes the integration time, the driver re-computes WTIME so the 
> previous frequency is preserved. The patch also handles the deactivation
> of wtime when the requested frequency is very high, as well as the
> extension of wtime to its maximum values (by enabling the use of WLONG)
> when the requested frequency is very low.
> 
> Patch3: converts the remaining mutex_lock()/mutex_unlock() pairs to
> guard(mutex).
> 
> All patches have been tested on a Raspberry Pi 3B with a TCS3472
> connected to I2C-1 at address 0x29. Sampling frequency and integration
> time changes have been exercised checking the value of WTIME and
> consequently WEN and WLONG. Raw RGBC reads, calibscale, integration_time
> and threshold events continue to work as before.

Thanks for contribution, unfortunately this series needs much more work
and more preparatory patches as well. I have reviewed the current series.
Please, follow and address (or comment why it can't be done as suggested).

-- 
With Best Regards,
Andy Shevchenko


