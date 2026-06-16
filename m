Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F952E88BD;
	Tue, 16 Jun 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599181; cv=none; b=hJCpZekrUCNubSPbB/qBYOyESpo/W2IroEiAiLa03aKBX1EksJ1ycsOZN00r5CJRPGNU48enguKgdLt55B/PjLzhc1gZ6yaqqu44zjIm9eeqh+P18gYgGu0wwydC88QpK/US4MqvzES6wVUcxFhduE+vZKOOICKXWc8tvgBbbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599181; c=relaxed/simple;
	bh=tBZFHxInDIYQ6WYD34zO342zVjlswV1EmePpQeg3fLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4rXtx4Tycg1ISWCYRMFoYkW66WF4ArK8Ikbx4ETyOIugfJHpq8B3UEg5EpXCSVnTHmY8JIEOmAu6q8rCLCK1r4MvstifDf/2a8Mue+NG3kuTMhuvmwxH1pbnSi8IaZEwWXFYGLNisJbqOeBqJRVxuToPYxj2cw07Bu3Y4bL2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qpj2J9zF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qpj2J9zF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781599180; x=1813135180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tBZFHxInDIYQ6WYD34zO342zVjlswV1EmePpQeg3fLs=;
  b=Qpj2J9zFNHCh9a3n540k6vNxDHM4kHn1/5Fjbphm9pmoYJhAJPtXf4gR
   NisGWRfNhMiqBcHj22UujwdJZy3dXUU7kxa0LwD+7CyvcEakGLmIMQL33
   GimxiKlfdxLCvYO0dnqTEDb+mZxnz0VIkGmx26Sb9E9HVB6K87yjc9ke0
   ogxk4qlcBFoPH0d+OB3GNaLDknxSGvyQmr7a9qkiK2KsJw+3oAt0ZpaQo
   xCPyoGoXqs5Yb8vJVzuCxMsCbLxXtWnmvvTc9uLKhj5o5YN/5ZEHQsJPa
   d/ERor1Gkk0E9uBQUk70DreeZtxkU8Z4ll505IP8cYSHmwIE7ds+LnNw6
   g==;
X-CSE-ConnectionGUID: Hm9RZbpkRKGyTs/IWwkPMQ==
X-CSE-MsgGUID: aS/HeQmJQlKQZjBNxcvzcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92675299"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="92675299"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:39:37 -0700
X-CSE-ConnectionGUID: vdmDoTvnSLip9gL7cc7Nsw==
X-CSE-MsgGUID: RvRPh7L+RuaNjhrARR3qBg==
X-ExtLoop1: 1
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:39:34 -0700
Date: Tue, 16 Jun 2026 11:39:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: hexlabsecurity@proton.me
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: clamp the device-reported FIFO
 frame count
Message-ID: <ajELw0x5DiyMuFYZ@ashevche-desk.local>
References: <20260615-b4-disp-ef4f7a59-v2-1-af5e980bcdd7@proton.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-disp-ef4f7a59-v2-1-af5e980bcdd7@proton.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 03:43:17PM -0500, Bryam Vargas via B4 Relay wrote:

> __bmc150_accel_fifo_flush() copies the number of samples the device
> reports in its hardware FIFO into an on-stack buffer
> 
> 	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
> 
> which is sized for at most BMC150_ACCEL_FIFO_LENGTH (32) samples. The
> frame count is read from the FIFO_STATUS register and only masked to its
> 7 valid bits:
> 
> 	count = val & 0x7F;
> 
> so it can be 0..127. The only other limit applied to it is the optional
> caller-supplied sample budget:
> 
> 	if (samples && count > samples)
> 		count = samples;
> 
> which does not constrain count on the flush-all path (samples == 0), and
> leaves it well above 32 whenever samples is larger. count samples are
> then transferred into buffer[]:
> 
> 	bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
> 
> bmc150_accel_fifo_transfer() reads count * 6 bytes through regmap, so a
> malfunctioning, malicious or counterfeit accelerometer (or an attacker
> tampering with the I2C/SPI bus) that reports up to 127 frames writes up
> to 762 bytes into the 192-byte buffer: a stack out-of-bounds write of up
> to 570 bytes that clobbers the stack canary, saved registers and the
> return address.
> 
> Clamp count to BMC150_ACCEL_FIFO_LENGTH, the number of samples buffer[]
> is sized for, before the transfer, mirroring the watermark clamp already
> done in bmc150_accel_set_watermark(). A well-formed flush reports at most
> BMC150_ACCEL_FIFO_LENGTH frames, so legitimate devices are unaffected.

...

>  	if (samples && count > samples)
>  		count = samples;
>  
> +	count = min(count, BMC150_ACCEL_FIFO_LENGTH);

Can actually the above be written as

	if (samples)
		count = min3(count, samples, BMC150_ACCEL_FIFO_LENGTH);
	else
		count = min(count, BMC150_ACCEL_FIFO_LENGTH);

>  	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
>  	if (ret)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


