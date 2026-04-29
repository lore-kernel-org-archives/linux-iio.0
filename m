Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89873F54AB;
	Wed, 29 Apr 2026 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471394; cv=none; b=Q2AVkESsENA/vAlP3+fpP2kRqSz9y1pD766BlQZJuoKtnWZfLKV9VN2FKxSyP3ZDJ5pzhNCtw1F45cgcTgx0T++18eEB3FsMNm4Whkvp4cXIvnPe4wZ/jP5FuqlCEXxVQ/6xlB+WTu8TJzmC/x8oyDt2+LFWkr7EOZ9AoFGhlDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471394; c=relaxed/simple;
	bh=a2IS6YHxzOSBFCmaz7FUGOfiKvytgfncz+E1p+6kUB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nERAh6YvBKevSjO/6xOEPfRdBvmUAdAEX0Bq6k0i/gFh7X6QzFamKeUvb+RB5fwtA3KvUB1ihXCY57fM5FB8Bg9ldIfikLbcbC5E0V8jJ1Eb/J4PKzm3TmZ6b7YY5CSf3mLGFSz4CxpfZjh7VqCSSg1Nff9g40FPU6/M9BFzk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsJdW80b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsJdW80b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777471393; x=1809007393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2IS6YHxzOSBFCmaz7FUGOfiKvytgfncz+E1p+6kUB8=;
  b=gsJdW80blJAWsOj5lsIVWHX/CRlXf88A+Fl0OfVGbEdAHnkVsuitGT0M
   0lLWtwPnxpgRLzRY1IIYcJcT1k6YR/4QVR0AdiDT1INLlMqqjGQxBWEME
   PaIjM21JOYxy+crv4Ai4KOMth1WHprtxgyEJE5wTH0o6dnMj9p1IWRWM0
   ONZWj/2fmROh/+Q0Wlgx2HbzAPG/DgYTafNzgx6EE0npFAdAo1kEkhB0i
   TJq8XOv+/nparinAZTDiZ0HddCHFq3W+fIRnWygG61zi9aUmy3wQetSMv
   1uJlCfApJILbvbsmv4454HkMnI62LLdhgCYM0YAtnu4HMifs4d3ULen/S
   w==;
X-CSE-ConnectionGUID: PUQsPCJbRdWc+WAY8bpr5w==
X-CSE-MsgGUID: sctriTNvQEiRLs2eaIlzpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88706264"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88706264"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:03:12 -0700
X-CSE-ConnectionGUID: DzcoeIk0TGm8PXlOydJU3A==
X-CSE-MsgGUID: 7fSE+IRzTySwpGiTDqD1IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="264664305"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:03:08 -0700
Date: Wed, 29 Apr 2026 17:03:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 04/13] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <afIPmf90zHsPkhX5@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-4-bb8f1cbd68e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-ad5686-fixes-v4-4-bb8f1cbd68e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 02:07:34PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Fix powerdown control by using a proper bit shift for the powerdown mask
> values. During initialization, powerdown bits are initialized so that
> unused bits are set to 1 and the correct bit shift is used. Dual-channel
> devices use one-hot encoding in the address and that reflects on the
> position of the powerdown bits, which are not channel-index based
> for that case. Quad-channel devices also use one-hot encoding for the
> channel address but the result of log2(address) coincides with the channel
> index value. The issue was introduced when first adding support for
> dual-channel devices, which overlooked powerdown control differences.

...

> +	/* Initialize masks to all ones provided the max shift (last channel) */
> +	shift = ad5686_pd_mask_shift(&st->chip_info->channels[st->chip_info->num_channels - 1]);
> +	st->pwr_down_mask = GENMASK(shift + 1, 0);
> +	st->pwr_down_mode = GENMASK(shift + 1, 0);

Why do we care about upper bits being cleared? Can we simply use here

	st->pwr_down_mask = GENMASK($MAX_CHAN * 2 + 1, 0);
	// or even ~0, U32_MAX, et cetera
	st->pwr_down_mask = ~0;

	st->pwr_down_mode = ...same...

-- 
With Best Regards,
Andy Shevchenko


