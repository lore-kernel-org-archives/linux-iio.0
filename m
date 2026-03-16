Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8AE285041;
	Mon, 16 Mar 2026 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671535; cv=none; b=V66UWM3Zq/3FleulUICiDnl+/Y3XZ6cPPjv7j1TIL+09HRvHab21uqYo3CI7L6objlV++OvG9IPuloH59NyVWiMPwhUR47UXTV5GuEPNvNAeOzbMT6lN1ZpRwf11H7YMCmX8Ck5Xvn01ahkrx5giBZWSqG4Lap/xh3kDxnTetk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671535; c=relaxed/simple;
	bh=fqN89o2KE9huMij61XVYmeD17RW0ylT7M1rKw9tQWNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt/QUlNaokGm3JSDBMZ7zc1ORKAy4TNAqHg7qAZdVts/ix1SK4z8p6I2e1MZJ0o3fP6rHw3pkQ4NUT8hRBTHJvfEPMvLx5GIekxraRqn7iuHhj6h2dkJunDyZpEp96Sr6QKfkQyPcq2HWSPxGd0mUJU4rvgG3tQTkmRsi/JHbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD+wk5YO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dD+wk5YO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773671534; x=1805207534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fqN89o2KE9huMij61XVYmeD17RW0ylT7M1rKw9tQWNk=;
  b=dD+wk5YO6OL0LOcDC9siTpuQIy2xbV6hZyWMitEXCYY9c+hWjkkBFlQH
   CML8NTWpaMMZd2h/e4ZzyL0SotMFI8nhC9cAGXNbofFXZ8e9jmZeLSkIU
   pJRPQ+MNUO9QCjGagiXW+e5I4IJPFcvJbjHRDqBKhQsbni9e52mLagNIO
   H/unrXSD5cjE7UbsBVeQusHOuaLM7AXbTiO0wqfIOx25sTi42UBLsNtWp
   4qaO49h04VmVsqtSjbq9DE4hCVQ1VcEv8ersQZYCsQaNZDfQAoJ+ZgYmC
   6QkFPHjMdEITP7wRNoV3YcL99cP28C+YTOT0yCs+wUJnpnhRrQyGn7EvW
   w==;
X-CSE-ConnectionGUID: iPiOsz7FR7mrD1LNXcxoPg==
X-CSE-MsgGUID: q28anEPSTk2l9BKn4ZToxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86040259"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86040259"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:32:14 -0700
X-CSE-ConnectionGUID: ouvIJjVyTPy7MuNWyrLnpQ==
X-CSE-MsgGUID: oTGlBoumTlihw2cdRz5oMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="216440179"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:32:12 -0700
Date: Mon, 16 Mar 2026 16:32:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: ssp_sensors: ssp_spi: use guard() to release
 mutexes
Message-ID: <abgUaXpJOveAtAWF@ashevche-desk.local>
References: <20260315125509.857195-1-sanjayembedded@gmail.com>
 <20260315125509.857195-2-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315125509.857195-2-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 15, 2026 at 06:25:07PM +0530, Sanjay Chitroda wrote:

> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.

TBH I don't see much benefit in this form. What I am thinking of is to refactor
to have the guard and timeout_cnt++ in the top level, and

static void ...(flag)
{
	if (flag)
		return;

	guard(mutex)(&data->pending_lock);
	list_add_tail(&msg->list, &data->pending_list);
}

helper for three (*yes, 3) repetitive code snippets.

-- 
With Best Regards,
Andy Shevchenko


