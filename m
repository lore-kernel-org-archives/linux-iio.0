Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004240E8E5;
	Tue, 16 Jun 2026 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599318; cv=none; b=m2sBsGslSKdZYWf+rpprbOevmHBE8q8XJyfo3nxNxIRRA2/cX1fvlfOZ+ulAvMlSQYadeMATrIfQkIhCzAkQMlKAoy3ORVvXTFFs+83HA8f/GpiyZParxlUH2u0lEfl4hjx7vsM5YZLQBYJA3d6uppF2z8zMMwqKrC60jsGuma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599318; c=relaxed/simple;
	bh=o7fj+xT3vf5IaSeSOnZcOAyVf8yXOcoN+LgG/HJ8jZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8VEm+N77JlVdOdcqywTncjP8InFnnWBe1tktDuTL4r+OWceFw/mdxktv8XG+at8yrAvrp3cWvcnTNRgzH0JuVVKlagK2skJ6b5k1j6/R0ZN1Vs9KGHsrxXTga+boMJ1e6D+odtHoTYT3Pc11Tflp5m+JGemXFNZbvp0UQteGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtjARa9V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtjARa9V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781599318; x=1813135318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o7fj+xT3vf5IaSeSOnZcOAyVf8yXOcoN+LgG/HJ8jZw=;
  b=JtjARa9VKyFIsCFghJYzUMI5ujWeDcv5Ucq+1pjFjAYagt0RtyTj9qfV
   CHtXT49wKrb1E3PNzfGndBQAaII8ktvVj1uNWUvfvn+t5CMslNFHx/Pj1
   zmgD1F24u8QkLHHUJHBXuUDZlN6HChEEk6eyzL92b0waSpYJR2SPub1cH
   uAbySbcb7O8RxOpDDXOGqhf4qTAXfn4bwgJSxk8r1kLCSJPHO6pPGigdO
   eBtJHZ5bw5fkjxIulzBRuDKOOsDYfvJ/A8F4ZbDXX4qt6uy9TH0TKJp6N
   WVeomQZOliutpYPT8Wq43PxQLvgckgCeU9Xd7li1APZVvVlNCtoxh0coa
   A==;
X-CSE-ConnectionGUID: kfZHtTD/SY2YiDCu+vizfQ==
X-CSE-MsgGUID: 1cAHqUb9Rey7kXl7qpyDXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86197289"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86197289"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:41:57 -0700
X-CSE-ConnectionGUID: WIgq6mS5TnSDKXJeEvZqrA==
X-CSE-MsgGUID: yqgIfbe9S2aFMf1A4u0JNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="241329156"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:41:54 -0700
Date: Tue, 16 Jun 2026 11:41:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: hexlabsecurity@proton.me
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: clamp the device-reported FIFO
 frame count
Message-ID: <ajEMUChqvxGzSLl_@ashevche-desk.local>
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

The commit message is most likely AI-assisted. Please, try to make it triple
times smaller in each of the patch. Most of the content should gone or be moved
to the comment block (beneath '---' line).

-- 
With Best Regards,
Andy Shevchenko


