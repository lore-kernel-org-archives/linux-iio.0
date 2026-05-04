Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0D37E2EF;
	Mon,  4 May 2026 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893541; cv=none; b=iek91qHo1BO6yHyN/vpzr3YjPl1NpU8PLpTpx+N8GtS031zWiglDsZRWmt7UnfLQfc5OiKhoJXc4toW9T8oJYakSMsSUKJaUKhjk+8FZeilo/GDcZYsV0j99nQr1Nv7gf+gFbaLLWHJ5nPWPVHxwQziOJCgAe+jCSTvQyGioEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893541; c=relaxed/simple;
	bh=YV5P14OhlrSacSijYqynDT2tZdWZiCggrVLmyH2AHnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+ngvZeA9aC2uH0/Iytz2AKRFcbHJBIKIfCseU4QfSAhoiIE8edLf4CGAXi0KhVdaVi29+C99YkOYuBHA27dN8BrxSIBSVOXNeuNcNbfbn5qxo5YfwHApeR0yCbQB8g06cYnRH84ug5FkgumeHQefR0U7MHJVGAMGP9GK0tQBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEazw9i+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEazw9i+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777893540; x=1809429540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YV5P14OhlrSacSijYqynDT2tZdWZiCggrVLmyH2AHnU=;
  b=CEazw9i+bLy9jYpvuHQ0Pnb/AZctd+Rj01B3DA1GvEMPyC+jlDaw+vYU
   Q6YDlAwu7dbyPes6Z+ze2xMCJOGUEuLClbtZU5RQ8/MC6oEtQL2Hjp6HY
   kvNvGQQ9f3s73XhkCV1sCYarf06idkQVE0ydXyFiCcoclnXN0czO++bZI
   JTPueZUZcJ9mtHPK6prIsGjxX9iR8afrh4nGz0vDmS8VZxvPKUIT/d0Ys
   KX+5ikKG/d4+RKtUDkzKYsr6ioQJ+kIPDrbfrBZSKx7/C5yns7EaYGgdd
   YxSSlDZNXiCQj0tPI/9KWp1h4AIM4IO0Ma8XW8UujxTKMLZttokwmiEEj
   w==;
X-CSE-ConnectionGUID: CuA7lN6zRJKSlEr5QhAa4A==
X-CSE-MsgGUID: eZL5B5IQRpq2DQAR1fQ5eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="90124660"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="90124660"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:19:00 -0700
X-CSE-ConnectionGUID: z0VPGwZuRvm+k+XPAzOpYg==
X-CSE-MsgGUID: PZQPmrirTQy9fi4JfHdWVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="265837670"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:18:58 -0700
Date: Mon, 4 May 2026 14:18:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/17] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <afiAnxOpArNEb2C-@ashevche-desk.local>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:48:18AM +0200, Joshua Crofts via B4 Relay wrote:

> The driver currently uses while loops and msleep() for polling during
> conversion waits.
> 
> Replace the custom polling loops with readx_poll_timeout() and
> read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> boilerplate, standardizes timeout handling and improves overall code
> readability, keeping the original timing and error behaviour. Add
> <linux/time.h> for USEC_PER_MSEC macro instead of using magic numbers.

...

>  static int wait_conversion_complete_gpio(struct ak8975_data *data)
>  {
>  	struct i2c_client *client = data->client;
> -	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;

It seems logically to shuffle the order of the series and put the patch that
adds a parameter to the wait_*() custom calls before this one. It may mean
the new patch (as split from the current one by me, you can use there my
SoB/Co-developed-by though).

>  	int ret;

-- 
With Best Regards,
Andy Shevchenko


