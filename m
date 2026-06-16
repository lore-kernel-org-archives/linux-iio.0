Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBB2BE655;
	Tue, 16 Jun 2026 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599362; cv=none; b=HlXYz3UxyU4pivbgISHJmek4UfcDbIY2JZ8Vqoj7Hiwibimw7y6F41Rza3K5VTCYCGbzEVBa14dbCKbLBujO5wPDd9xQWGZIl7WUEP6xUrBfBn5ZZ+qawQw5gW7GnA2NrTNZZ1LwmntwyTCNs52yfv8HTYKCmSs0ylhQ42nkyMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599362; c=relaxed/simple;
	bh=59OBy9wEIe3GcwycXno80dQq0pk0UjAfeXmpWq21c3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S28jZB1ziyW+5SXXQ36kyawX6eLPFfBz3DU4Qd15h0jZpw9qVs2/61GHk4FH9M2m7RkhzNKCLXCkd+Hu8Syz6mhulMj1RAfe23/uPVVkjav6LXRQSdA31zkmVN2nZy2RAP72Jg3LdYD7Amm8MVp/xd51NpqrPqT8gpK1BzgQwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXQAENBI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXQAENBI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781599361; x=1813135361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=59OBy9wEIe3GcwycXno80dQq0pk0UjAfeXmpWq21c3I=;
  b=FXQAENBIO4+XPSAHB7GzwQzbp7u9V9D1QmDUh0kNsfXN0Q28KoSgcJ/r
   4F1IAivMX6vU/A8+DH0iLJ7uReKGZ16UJbHdqOT/EXPN59moeSwoIULLp
   +lIklZXiRekABpHwUyGv+gwT7YGIadSm3ytw9aNUv5OvXFHJA5X++r+DK
   B3J50aVvorpZAS4UQ/xKD/ugfzxWeSH/VZW5G+53bvWUa+M/+FS4afN0H
   Re/ipTzsTFc7dnx5XsxrG01YdVD589vU9xOLDaDOq4C3v4Mz09QWVGGPX
   mbJ6hz1GSIQjrkIUHJDoHfN2tgiSnDZe3KoTodhNAP0qSrQ0ICuiI+xCe
   w==;
X-CSE-ConnectionGUID: SqoevtctR+CTCXuA7eSykQ==
X-CSE-MsgGUID: SKHfITTuSoqndGHE69Qhyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="85995367"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="85995367"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:42:41 -0700
X-CSE-ConnectionGUID: lkjev/sGTD2udMrGDLhabg==
X-CSE-MsgGUID: jOTawoCFStilq0b/k33xVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="245333872"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:42:38 -0700
Date: Tue, 16 Jun 2026 11:42:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: hexlabsecurity@proton.me
Cc: Jonathan Cameron <jic23@kernel.org>,
	Remi Buisson <remi.buisson@tdk.com>, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2] iio: imu: inv_icm45600: clamp the device-reported
 FIFO sample count
Message-ID: <ajEMfH-_76M1OBqE@ashevche-desk.local>
References: <20260615-b4-disp-feb19207-v2-1-2d36f1e5fc54@proton.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-disp-feb19207-v2-1-2d36f1e5fc54@proton.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 04:09:48PM -0500, Bryam Vargas via B4 Relay wrote:

> inv_icm45600_buffer_fifo_read() takes the number of samples to fetch from
> the device's FIFO_COUNT register and uses it, unclamped, as the length of a
> regmap_noinc_read() into the fixed 8 KiB st->fifo.data buffer:
> 
> 	fifo_nb = le16_to_cpup(raw_fifo_count);
> 	...
> 	if (max > 0 && fifo_nb > max)
> 		fifo_nb = max;
> 	st->fifo.count = fifo_nb * packet_size;
> 	regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> 			  st->fifo.data, st->fifo.count);
> 
> The only bound on fifo_nb is "max", but the interrupt handler calls
> inv_icm45600_buffer_fifo_read(st, 0), so on that path the clamp is
> skipped. A malfunctioning or malicious device (a counterfeit or
> compromised IMU, or a bus interposer) can then report up to 65535 in
> FIFO_COUNT, making fifo_nb * packet_size (16 bytes per packet) as large
> as ~1 MiB and overflowing the 8 KiB st->fifo.data heap buffer with
> device-controlled data.
> 
> Clamp fifo_nb to the buffer capacity (INV_ICM45600_FIFO_SIZE_MAX /
> packet_size), mirroring the existing watermark cap in
> inv_icm45600_wm_truncate() and the sibling inv_icm42600 driver, which
> bounds its FIFO count to the buffer size. The clamp is a no-op for
> well-behaved hardware, whose FIFO never exceeds the buffer size.
> 
> This hardens the read against a malformed device-reported count; it is not
> reachable with conforming hardware, so it is not marked for stable. The
> unbounded count has been present since buffer support was added in commit
> 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices").

The commit message is most likely AI-assisted. Please, try to make it triple
times smaller in each of the patch. Most of the content should gone or be moved
to the comment block (beneath '---' line).

-- 
With Best Regards,
Andy Shevchenko


