Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A046331218
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414678; cv=none; b=H79Rc2YAQcfqyFWuNyMvqfP3+FGCDNt9gNoDDJBHQevMz/EDvowijAx3f3PRulK+QMjGgODmc5g8JWwhGlpeJujwMTkAgL3XnaLrSVzkXdq7p8i+DsIQKQdQPrGwAOYd9u9+ObhWsuLZTm0KjyB2yKqXwTcg+XQpcuSo83PILpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414678; c=relaxed/simple;
	bh=VbL0tLUAH3UZLmtkfb8tua4XXl1CTP1BWEN8gXGJbfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzJQLc64LNt/Zbz+LBoK59qECM4XxhaTfVXIFaiLuzOZG/pAn0m9bDMKVZ9RvMQW67T1iVkFYo8KpzbGiSxOk+ZIw2XY5f84ME6HN7JCvllfRTKHUn83txAzNvrboZj43TvAEy8VR/4ET2f6yPEPanRYNLyMvA+XFUxwULM5j/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwPmrpnl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwPmrpnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776414677; x=1807950677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VbL0tLUAH3UZLmtkfb8tua4XXl1CTP1BWEN8gXGJbfc=;
  b=FwPmrpnlPw+A1mTgQYwD4b0heDwAuyuW/TVL0KXqvHv7b0FfIDdjTMPc
   z5LKVb+WjnUbPBSoH0wefhrOsRTxawvF5wT5IteCojBrhOd9tjTXG8zOc
   bW6HJuXhT9icNpg6nK/ACZgBmz/+bxCBmfoWy2QlMCu+C3Zuoz9l5CxeU
   C/HrejdxyGHbA11u5H82fgs2PM5hNTZlQgUNwsKT3VcdHloRlzPXx0Q2W
   huyWVxA402pUMFh5G7Dck+Br+AtWwlTxbrziRyr+H+GSoC941Qo8FQyDV
   5f/t+0qaLgfjOC9FrcLrnqKTROQ827XR48aljfFQlEqfyKf25B4cnzgC8
   Q==;
X-CSE-ConnectionGUID: 6Hnv31iSSaSXDiVVlYK6ew==
X-CSE-MsgGUID: JNVmetMmT/Gv7jeb78ijJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100075162"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100075162"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:31:17 -0700
X-CSE-ConnectionGUID: 7Xp2kwjSQYm1rwfho4TwHg==
X-CSE-MsgGUID: vLpeQYaHTZWaDKB+FOVjpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="231239747"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:31:14 -0700
Date: Fri, 17 Apr 2026 11:31:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giovanna Luisa Hirata dos Anjos <giovannaluisahirata@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Naili Lucia Marques <naahmarque345@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: common: ms_sensors: use guard(mutex) helper
Message-ID: <aeHv0DEEc2bS4YB8@ashevche-desk.local>
References: <20260416032351.224072-1-giovannaluisahirata@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416032351.224072-1-giovannaluisahirata@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 12:23:45AM -0300, Giovanna Luisa Hirata dos Anjos wrote:
> The guard(mutex) macro helps to simplify the code by automatically
> releasing the mutex when the dev_data->lock variable goes out of scope.
> This reduces the risk of forgetting to call mutex_unlock in error paths.
> 
> Refactor all functions in this driver to use this modern cleanup helper.

Please, read my comments to your other changes. Slow down with the submissions
of a new one until we settle on the rest, you will develop the style that will
be accepted in the future without comments.

-- 
With Best Regards,
Andy Shevchenko


