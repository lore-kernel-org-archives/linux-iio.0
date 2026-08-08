Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6E24886A;
	Sat,  8 Aug 2026 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786222624; cv=none; b=JCsXxg7G3/ejagtewW93qdwmuMAXzmSyfRyQp1+hOtRM++6rXFDFEmc9BojQaL0MiCWBdUza5kC4aIE2Lu6jGG8KVAhOLlE7FogaMgctrk1jRm77v3pBSutGLPpD3yhb3V9p9Jg0HGRXPVO4t6s4kiogXX1VKx5K0QCPBmMFRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786222624; c=relaxed/simple;
	bh=XkBczDBoKXNi8wTXM+WDhxjDs4tYlLRpFpx/QmR8i7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJRwQF0bt27OCJ6cRfWbKfN4KaYUcwlx5QTFXkHl2BrSeRjZjTDOpmK/NUYQ+q3BG6v3Qx/GktI4fQIBnYmi36YLo3BZxfKtzzPKJVq1vL/GfDt0XbFDWAb9nXVwu1onjKdzsdMYmGU0D914Uu4FOqj7LGF0+XQk+2RUe4igCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkD7LDkQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkD7LDkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786222623; x=1817758623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XkBczDBoKXNi8wTXM+WDhxjDs4tYlLRpFpx/QmR8i7Y=;
  b=bkD7LDkQmQF44I/Z6vegJr8dsvYbhaWBwVkfl+Vfj6YJl36qJ7gl74hA
   TfbxHkcbdnZkuN0Mcznfnew9QyK9+oCje8wyj1EaAL3X7jMwiXk8gICmm
   yXeDUXrqINlR/ZXygOOyVygEQDaD/5KCY7g5vWEuDVIrdRvkn/wSzaFcz
   u8p1B3CzgiC85sfKW+qUU+hLi+xFssZAFoYvaEj4lIpX0XLzkTFQc9alL
   6kmkMr2mMS1wED4iuV3o3nGuTQW4ixEbEZiSXjsL8OU8a/nBCaYMj4SkN
   jq8nnE8MdaodFdkqGzDmREQgDqXzcQqzBsVYAvM114gnKpW3xcZcNs2on
   Q==;
X-CSE-ConnectionGUID: 6dWw3txUT6mOctxy2s1zVg==
X-CSE-MsgGUID: Z1FOemB7Rs2g6yEiiMTpjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="74330316"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="74330316"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:57:02 -0700
X-CSE-ConnectionGUID: KD3W/oe+Su2lOLeI+4Sodw==
X-CSE-MsgGUID: piFka4BfT2y/ruy1EfPRxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="286083335"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:56:59 -0700
Date: Sat, 8 Aug 2026 23:56:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, u.kleine-koenig@baylibre.com, dakr@kernel.org,
	bhelgaas@google.com, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: htu21: Fix SYMBOLIC_PERMS chekcpatch
 warning
Message-ID: <aneYGVo4gbbbYqFK@ashevche-desk.local>
References: <20260802012329.9877-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802012329.9877-1-adinata.softwareengineer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 02, 2026 at 09:23:26AM +0800, Adi Nata wrote:
> Checkpatch warning:
> 
> WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +static IIO_DEVICE_ATTR(battery_low, S_IRUGO,
> 
> WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
> +static IIO_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR,

>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(htu21_show_samp_freq);
> -static IIO_DEVICE_ATTR(battery_low, S_IRUGO,
> +static IIO_DEVICE_ATTR(battery_low, 0444,
>  		       htu21_show_battery_low, NULL, 0);
> -static IIO_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(heater_enable, 0644,
>  		       htu21_show_heater, htu21_write_heater, 0);

What's wrong with IIO_DEVICE_ATTR_RW()?

Same comment to all patches of a kind from you.

-- 
With Best Regards,
Andy Shevchenko


