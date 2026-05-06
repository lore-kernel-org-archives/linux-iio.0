Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E12556E;
	Wed,  6 May 2026 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050418; cv=none; b=o2ilvKGK0Dn/917xcKQmII++0pX8hMkQkW3sPN9UIqRr9gNnZ/AAc7Rimi+8ISPjxpCl/iO66CSiMNOpALK2Z/LJoTjGF42dsU9SFWFszyV8wJpGZLOXh4vf4CoMeuVL3eFjB2vSd4CqxLWoLBdiY+GpeR0Ir8MjzcFrCmXNjN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050418; c=relaxed/simple;
	bh=lHucECQBivM5PpXqtEQ5Lvr0HJmDRkfLPYSIOiG/x10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpO/WgWp/VZUWpfFnMPvwBbVjqtzbQE7HXawU5vOpZTDNFCXtGU8K6/5p1jPRkdLGkAc48ASHLmijLT0T54Dm+wgZGc1+dqbaPayBXxVGVJuaqpCII88ofuLFfv7ZbhNwCRcTyByPQKtfrBXxsuixOcWAI2bsbHxV3eGjVnbDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDrWjKeG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDrWjKeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778050417; x=1809586417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lHucECQBivM5PpXqtEQ5Lvr0HJmDRkfLPYSIOiG/x10=;
  b=HDrWjKeG1RKavjizvAIKdzEokV9QGJ/MnycuZaEmLyYF31lB67W0fOwz
   gC49wTJWaHWjfP8PV0z9fB8GqtIc56FvDUzlKSVjeunRbnm1b1dhPXMcL
   5hK4ywLBpLWcNDmPecCbyK26SIAOBXj8JcDAFIPKIlOe1e+JeHQgoNRf9
   suhfa4vQn2Spb0oz+0XnIqbu924VBJPHR/rrsOPykcPJajn5sD9sQjOuT
   EfwfZrMEd7dXU2E7v6K1nuAjgQFlx5Y+4+JeyzIdLBOYXxkaH2dCyDFnd
   cpS5na2QBnEVwVXxp2uwGxS35v+JpkCoXrAY+/WVO8xVM4fEQEtK+gFhy
   w==;
X-CSE-ConnectionGUID: uAVfumf9STW2y/U12Rh79A==
X-CSE-MsgGUID: ukUrw1TqQ8++xLkpeh25xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90062131"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="90062131"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:53:08 -0700
X-CSE-ConnectionGUID: CDU3OHaTTDa7AQALmRzOfg==
X-CSE-MsgGUID: DBz2FD42Th2ekkn/fm0Qiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235929256"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 23:53:05 -0700
Date: Wed, 6 May 2026 09:53:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/18] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <afrlT71SjyQLh2xz@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-7-831b9b5550fc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-magnetometer-fixes-v5-7-831b9b5550fc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 01:46:03PM +0200, Joshua Crofts via B4 Relay wrote:

> The driver currently uses while loops and msleep() for polling during
> conversion waits.
> 
> Replace the custom polling loops with readx_poll_timeout() and
> read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> boilerplate, standardizes timeout handling and improves overall code
> readability, keeping the original timing and error behaviour. Add
> <linux/time.h> for USEC_PER_MSEC macro instead of using magic numbers.

...

> +	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> +				poll_ms * USEC_PER_MSEC,
> +				timeout_ms * USEC_PER_MSEC,
> +				true,
> +				client, data->def->ctrl_regs[ST1]);
> +	if (ret)
> +		return ret;
> +	if (val < 0) {
> +		dev_err(&client->dev, "Error in reading ST1\n");
> +		return val;
>  	}
> -	if (!timeout_ms)
> -		return -ETIMEDOUT;
>  
> -	return read_status;
> +	return val;

Besides the unneeded return val duplication, I think this is the wrong location
for this check and it changes behaviour (really subtle change!).

Before if the last iteration gives an error from the device, we return
-ETIMEDOUT instead of the whatever the i2c_smbus_read_byte_data() returns.


-- 
With Best Regards,
Andy Shevchenko


