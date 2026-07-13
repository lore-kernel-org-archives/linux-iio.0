Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7F30E835;
	Mon, 13 Jul 2026 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946244; cv=none; b=VsDojuDOoMRqOuKbTXtFMzQqzKbvxdU7qErIyly7sArX8VXR7Ja0TN26JBPCjRFP/8795oO9gVAUny/iKrFwr1GqwHQdgd7acYCa6E94HGaa0Mh0ung7NnnwgyAogrheI/H97sVSj3ak4dPAEOS7x9Fk5faTdBFjI/FdQkLPRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946244; c=relaxed/simple;
	bh=75JTVug3gqDfqcNPrKRyLpRnca4pzq69tQ8V0wstcig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbICG150u9+b/+0T/Dw32Sdzc0lINTR6Vl2AnQ43rRgqWAeeP97SmnVVxAdi34eSRtKX2FZFc7uGpOeahwfJTUkNMu9Xy9ve6v1BtcGBcwh6LrCXYYNgnpcR4FOTbxJdtpW3f+tO6h6xyDnjBGJPq+FR/UnD4w+UqgoydxAcfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsmL3GrV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsmL3GrV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783946243; x=1815482243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=75JTVug3gqDfqcNPrKRyLpRnca4pzq69tQ8V0wstcig=;
  b=MsmL3GrVw8oe4SQH2rOoOU7Bi+adMc6CuIHcEtVEwId67PnN3dZTDuxB
   cOO4Nmed73+Ygu5UfhzD78jYwRG4aNXR3voBxezu4DZQ+8+/iGkE6cRmt
   d5c5ixrcHlZfQMPHG8Pg88Qo2sT16OWT748eIGugRjBHh9W6BLPf4M8ZL
   dBrblKaePqjcxmoxqdvIcZrgIZAt0XHXZJiKrK4ST8tQYZRi42P9Uxqja
   d3qCDJ74cqHRyJ1/P5GnUQccWmIREsnfLVSJMlMOWvknv/hf12KlWhQ+6
   xLMHzS4tOLnRgJPpK6udJe3jb0EFsH2kvMnjOWciR+cNHfMll1zf1EQD9
   Q==;
X-CSE-ConnectionGUID: HGfKRhtNQ26JRX7rwPPR3g==
X-CSE-MsgGUID: pwOCvYg3Rt2W5k7bymAQKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="96064695"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="96064695"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 05:37:03 -0700
X-CSE-ConnectionGUID: a9mjH/IzTou8JFhMr93vlg==
X-CSE-MsgGUID: Gkq/HpAESvqjCzMaN173lw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 05:36:56 -0700
Date: Mon, 13 Jul 2026 15:36:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, shreeya.patel@collabora.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: light: ltrf216a: fix runtime PM reference leak in
 error path
Message-ID: <alTb4-sg0ukY1aYI@ashevche-desk.local>
References: <20260713022829.234370-1-vidhu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713022829.234370-1-vidhu.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 07:58:29AM +0530, Vidhu Sarwal wrote:
> ltrf216a_get_lux() acquires a runtime PM reference by calling
> ltrf216a_set_power_state(data, true). However, if
> ltrf216a_read_data() fails, the function returns immediately without
> dropping the reference.
> 
> This leaves the runtime PM usage count unbalanced, preventing the device
> from autosuspending after a failed read.
> 
> Fix this by releasing the runtime PM reference before returning from the
> error path.

...

> static int ltrf216a_get_lux(struct ltrf216a_data *data)

>  	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> -	if (greendata < 0)
> +	if (greendata < 0) {
> +		ltrf216a_set_power_state(data, false);
>  		return greendata;
> +	}
>  
>  	ltrf216a_set_power_state(data, false);

Wouldn't be simpler to do

	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);

	ltrf216a_set_power_state(data, false);

	if (greendata < 0)
		return greendata;

?

Not insisting on this. Up to Jonathan and others to decide.


-- 
With Best Regards,
Andy Shevchenko


