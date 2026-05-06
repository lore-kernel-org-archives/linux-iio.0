Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2573D6465;
	Wed,  6 May 2026 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058860; cv=none; b=f4r/nJ9iiMnXilCRcLe0S+pLGnygSDtrvFLPP9dX4CNdYCumBaLUHuJQacD4NJzdnHdSw0RrteA5sElG2Q6JwX336M+i/Syvxx+p0+uoByd6nK0Y39TzL0+N2a8ZlvQU0X7eDDygcnHF4D+GLqMcqLF4CRhXvXD33+Z7h+0in3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058860; c=relaxed/simple;
	bh=JvvwDl3kN6hb08i/6mPPkKjdPd3flUbucfSDwfFJnC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuMBH9MOsYSa8R48QQeEl5vf8fGCOnFjZAPKTJwXuQdZOap+3dNCGu+mGnFPbbMF2iLG6TVLqX2F6AOB4narSzh/82d/ldzQ62++6lfZoxF8eY88uj4EFTY0WFvCDajFrcTIfm+ojsu/DgLlnzGCcYRCrjRtt0iqyfJzENuqVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iB0x6gcL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iB0x6gcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778058857; x=1809594857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JvvwDl3kN6hb08i/6mPPkKjdPd3flUbucfSDwfFJnC0=;
  b=iB0x6gcLn/lnlU0uCaWewS7o3pfgc4PgI5Yion/h8HCn3L3yproibawy
   gv4MaNgPtUfdY/96sHUPhIL/6xiPv6xxHKkv7QkUD14vVkQ7qKrXe0zss
   BxKSwFIq25u6JFZw36XJzvDWaqdvicY2hLz7XM1ljgO2cXyHpANe2fz6W
   dtUBjBQmkrHoBh4zNFG2jYx+6oIhgwZ51mPBFfTBBksnaeoJhNvCPpa6H
   8QwkGB9pZ1mfZ/SHlXepg4BwYswEK04pu827UeKiuKFVPcTbUBAzL8mDS
   6jyUsbc0gIpSVHNh5k0RASMeoQWtBPi3f0q/Ar+iwVatGUC4qvFuNgNiK
   w==;
X-CSE-ConnectionGUID: V3hkrxz1RpOwlaxzRlSWmQ==
X-CSE-MsgGUID: POGMg1ECRAqzs3CRh1GrRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82590035"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82590035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:14:16 -0700
X-CSE-ConnectionGUID: a8idyTzdQXicqt7KBSY9hg==
X-CSE-MsgGUID: 3e08nABIQBavkE9NlrIAmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="266439631"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:14:15 -0700
Date: Wed, 6 May 2026 12:14:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: zero-init bmp580 trigger handler
 buffer
Message-ID: <afsGZOxaJFvgLKgw@ashevche-desk.local>
References: <20260505173455.181358-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505173455.181358-1-devnexen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 06:34:55PM +0100, David Carlier wrote:
> bmp580_trigger_handler() builds an on-stack scan buffer containing
> two __le32 fields and an aligned_s64 timestamp, and pushes it to
> userspace via iio_push_to_buffers_with_ts(). However, only the low
> 3 bytes of each __le32 field are populated by the device data:
> 
> 	memcpy(&buffer.comp_press, &data->buf[3], 3);
> 	memcpy(&buffer.comp_temp,  &data->buf[0], 3);
> 
> The high byte of each field is left uninitialised on the stack.
> The bmp580 channels declare storagebits = 32, so the IIO core
> transports all four bytes per sample to userspace as part of the
> scan element, leaking two bytes of kernel stack per scan.
> 
> Zero-initialise the buffer before populating it, mirroring the fix
> applied to bme280_trigger_handler() in commit 018f50909e66 ("iio:
> bmp280: zero-init buffer").

Same Q, is any part of the above, including the initial report/analysis
AI assisted? If so, you have to mentioned this in the respective
Reported-by:/Closes:/et cetera tags.

...

>  	} buffer;

 	} buffer = { };

will suffice.

>  	int ret;
>  
> +	memset(&buffer, 0, sizeof(buffer));

-- 
With Best Regards,
Andy Shevchenko


