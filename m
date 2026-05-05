Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AF37BE7E
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970969; cv=none; b=PFKCTDb17vnOIBuRi/Co8eAs35+a3euKmgo4GQkOOYEVXU2iMv4hAk+Iiv6+5QjU59ksru2KaNYEDzWezjzuw2XP2wR2HhjmT16i6xL8bH0E2oFlQ26cEWJtQdB0YqXeRjHLEHeHmFnhGFfalebKwruy06rQ/vquGOlJ9eomWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970969; c=relaxed/simple;
	bh=E6mDSIW9xdfVSueUieTY+U+gq4dTNb/D7JbiYQCZlJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyzNBHGoLsKOtOtmfgi1knHXyFHhvI82+aIV0txe7GDGzyS0PyZb7sqJ/Sb45qDvJ5Ldk0H1DdDUHzk/o+zxtBXipPKDI2tJWuZvxTr7o+jy4v4PPkUhL3O1nxzUAVoDssztAEixKkvKUkMYBISUSUxu7Tig+5+QUVfRRK0sBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkYQn947; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkYQn947"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777970967; x=1809506967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E6mDSIW9xdfVSueUieTY+U+gq4dTNb/D7JbiYQCZlJ4=;
  b=SkYQn9473Br4FVq0z5rVFqwZf3QMPuxBBzvusOfIiGSits5sttekI77t
   q0yvFh9vMX06cvRxyyTkkIQOk735VLQpyc1N386MsitKIcjjrLzT3tYGv
   ZReATQ/3L0F1cx1KhvcmGmr0KXWV5ytWC4DwA6mNnUgfyqkWbF2UIxX9j
   /dd6I2Wn/1riZgVngBZlCn3qxMEaAtJwsU7NfZB55UpruCeScWXk5cNsN
   DcLh5kczH6EjkgzYlUYmWKC/+e0dshqtx25E+Ml8K3gxhcllyJE6zLd/+
   AFwXYiVhUKp6AR9XDZKuiw0pLjTJEizS1oSBskLBg3xUAaNnSFh/6Fdg6
   A==;
X-CSE-ConnectionGUID: MqQwQB82Ss2LyiPZ3rO3aQ==
X-CSE-MsgGUID: wsPlUKcxREKV2s5p8cKZOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="104284512"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="104284512"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:49:24 -0700
X-CSE-ConnectionGUID: e8VZA/UBQUCTOw865UL3sA==
X-CSE-MsgGUID: znlhz6BMRlOMEu0FN8t79w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259107064"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:49:21 -0700
Date: Tue, 5 May 2026 11:49:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Dias <guilhermeabreu200105@usp.br>
Cc: nish.malpani25@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org,
	=?iso-8859-1?Q?Jo=E3o?= Paulo Menezes Linaris <jplinaris@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
Message-ID: <afmvD1EB159V498L@ashevche-desk.local>
References: <20260504190455.9841-1-guilhermeabreu200105@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504190455.9841-1-guilhermeabreu200105@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 04:04:25PM -0300, Guilherme Dias wrote:
> Use guard(mutex) to automatically release the lock on scope exit,

Better to point that guard is kinda "operator" and hence we refer to it as
guard()() [note double parentheses], but it's minor, just for the future.

> simplifying the error handling path and removing the need for
> explicit unlock and goto-based cleanup.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


