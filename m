Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD0299950;
	Wed, 25 Feb 2026 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019572; cv=none; b=S+vcH+Y2aL0A7JK+r7weogdp3XBXKFrC4fhejT9nYsK6LiyDLSBmg42S08hSjfD5mFKLQXF3Zj1RoiiVeuWx9058zUWsArY9n2djy8OEZ5EmmJjDgTNoZR+FVZRZGlj+fNHtMUzc8SG7JlJ1/GTlv9WJ+iuD/49I0d9g5oGfE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019572; c=relaxed/simple;
	bh=JXEWp+qnDzlYOwveRWBdqueum11fy3OIIMV+fKOmbDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgTD7LrHggBBdFYPXvfna3PMTLkhs7COBhwOW5llIMGuzrCsifYrWqHWduvPf5SFP61+Yv7WWrO35iXVWiTNcdAmj4VGl6gE29ZuirlU2f9XKn23Khbug7G4GLC6ME64Zl28s5HqAyaclzmLEbz/dSa9ptZgiCgqHgWhjMPCFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyBC6xNL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyBC6xNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772019571; x=1803555571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JXEWp+qnDzlYOwveRWBdqueum11fy3OIIMV+fKOmbDI=;
  b=XyBC6xNLx0VrilAl0a09mmjjzbTw2es6FsaT5NI2CiJ4c44A4fOIzQyG
   K9ZqsCZBU9VFiKLQbW7n5FI2kbknuN5ZZXjqu8u8QVuciU7VXqopbs1Eh
   JvnMsRHxamq4Qt44/tMBnUrx+JtDXNVcWAIQ2Fr07CaKZiVbbnxaI6o4K
   65BRs7VIB+axxHX/68OlQTeEOBLd/6pgEfcmjRHyaJPTf3PTdyMz8mXkq
   D3bO9s0w7KF8E5QKQVE7jed4jpR0piKoQDnGY4VagBPdKwS0Zf1S31kK4
   BdYG8UUK2F2Q1w14CgbTaHyka+yLsfyCWcJuYpKP1EB1E/MNRnDY47hfc
   w==;
X-CSE-ConnectionGUID: KLPbB2+9QUeXu/CsEtMvGA==
X-CSE-MsgGUID: t4om87X0RpuVjUmpzvy2IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72929830"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="72929830"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:39:30 -0800
X-CSE-ConnectionGUID: FeNyNdDdQMuxOwoL/mV7Cw==
X-CSE-MsgGUID: NDMyZZUrTBuvzEljtkuzuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="221211738"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:39:28 -0800
Date: Wed, 25 Feb 2026 13:39:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <aZ7fbdpWRFsvpGWf@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101711.2368206-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225101711.2368206-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 11:17:11AM +0100, Francesco Lavra wrote:
> The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> accelerometer invalid samples (i.e. samples that have been acquired during
> the settling time of sensor filters) with the special values 0x7FFFh,
> 0x7FFE, and 0x7FFD.
> The driver checks FIFO samples against these special values in order to
> discard invalid samples; however, it does the check regardless of the type
> of samples being processed, whereas this feature is specific to gyroscope
> and accelerometer data. This could cause valid samples to be discarded.
> 
> Fix the above check so that it takes into account the type of samples being
> processed. To avoid casting to __le16 * when checking sample values, clean
> up the type representation for data read from the FIFO.

...

> -	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
> +	struct {
> +		union {
> +			__le16 data[3];
> +			__le32 fifo_ts;
> +		};
> +		aligned_s64 timestamp;
> +	} iio_buff = { };

Hmm... Have you considered m68k case? IIRC there the alignment is 2 (even for
64-bit members), so theoretically the beginning of the structure can be aligned
to address 2. and hence the __le16 data[3] will have no gap to the following
timestamp. In current code it's 64-bit and not 48-bit item.

I believe it's easy to check, though.

-- 
With Best Regards,
Andy Shevchenko


