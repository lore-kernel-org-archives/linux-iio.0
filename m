Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D131F990;
	Wed, 29 Apr 2026 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490646; cv=none; b=hB4l7v+aM+9oj1DZqd8yoIQSY+r4LOwtTquOoBztxTPdZS0xJ2HXoK35Lw99OxRNXCsbkWLIIDHvcLPJf+AeBcNQJ3BuEj74VJBFmbtVb1cAGp+xYmv+q//4HJLTYlOE0HUHizbQqHBCDzyvK5hGWC/iq9PxqiaowkEqEwrKc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490646; c=relaxed/simple;
	bh=VUsORD/O91PwiBYfOEoIQEqNc5SDdu4xfItKzTCCBeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ely7yfcLzNJWEMPsGREj0HWw93jlXIAbCLe880JOe7iIy9QjYVn3LiYRmJcA9e55jyWMIooZL4PvImZXqK+9SpVWVJ39L7l/wg9//f0FB2prYb/IODQrU9DYFl7UsG2fLP80tn8gGDoNTN7/y/5x7gh3t7wKycCwTmKb8zhlxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OvTtaBaQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OvTtaBaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777490645; x=1809026645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VUsORD/O91PwiBYfOEoIQEqNc5SDdu4xfItKzTCCBeE=;
  b=OvTtaBaQvEyBDfgvj65hn9dfDbvGl8qJdX10a0JuaPJ6e3S8AgFD3l0p
   gJ0G6ZbyHMGK7uvY0xF+UuYNu6H47yxr0lNpV4Gq9wpSIQUSZq/RXh8zz
   iPMvwQfCJ6xTy9LT0gO+j3rhJGM36wcPssQVz6Swn0gNflbDwPnJlshle
   euwLH63uA93AOCEfRSTIBi95ysIQrUKAgD3lbWccPq5rtsu1QXaXDsMTE
   f8wvPFFzQJzccqSrHUHA3sFuytVTuVExxoSgcD7IogkBG4fcFuBjzVDyg
   1DMbaz+/oiOGpL45Hkdg3fbNkxSR3Z0KzawpqUzA3K/evp0uXLBYJcnGP
   w==;
X-CSE-ConnectionGUID: hwHQci3SS/etmLcFk4swvQ==
X-CSE-MsgGUID: 5jk4Byd6RZWplU9Q7FZrSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="101094356"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="101094356"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:24:04 -0700
X-CSE-ConnectionGUID: kMX87iNnRwai51giWQBl1Q==
X-CSE-MsgGUID: iukaLL5ETMaY/arw3YzLIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="236133584"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:23:59 -0700
Date: Wed, 29 Apr 2026 22:23:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] iio: light: si1133: reset counter to prevent race
 condition
Message-ID: <afJaymMR32iStbyX@ashevche-desk.local>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-7-469f21d960eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-si1133-checkup-v3-7-469f21d960eb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 05:04:55PM +0200, Joshua Crofts via B4 Relay wrote:

> Sashiko reported a potential race condition happening when the driver
> returns an errno after a timeout in the si1133_command() function. The
> premature exit causes the hardware and software counters to become out
> of sync by not updating data->rsp_seq, therefore the internal hardware
> counter keeps incrementing.
> 
> Fix this by adding a call to si1133_cmd_reset_counter() before returing
> from timeout.
> 
> Closes: https://sashiko.dev/#/message/20260428-si1133-checkup-v2-5-70ad14bfefe2%40gmail.com
> Assisted-by: gemini:gemini-3.1-pro-preview

Reported-by: sashiko-bot@... // there is an email mentioned in some thread in
			     // linux-iio mailing list.

,,,

> +			/*
> +			 * reset counter on err to prevent sofware and hardware
> +			 * counters being out of sync
> +			 */

/*
 * Respect English grammar and punctuation. This is
 * the style for multi-line comments. You can consider
 * this example.
 */

-- 
With Best Regards,
Andy Shevchenko


