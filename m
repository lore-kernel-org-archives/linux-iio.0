Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5030AD0A;
	Tue, 16 Jun 2026 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599283; cv=none; b=s59CMvlK741RUD87Jtkru/QBnO9W7HkhKgrO9swuPQ9bU8LckEnli1YMnrRFYcWygtv/VssErUF3w76FjgMo6tzcZRsFtl+EWA3olnIEdcq12M/XTNtkVlfZobkaGQ1PWbkZA3Seml94tgVe4oO4YGRLHp0G/FhFF773DLI9I7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599283; c=relaxed/simple;
	bh=d//dzoWe43jSoL+kMDmkV5YFg/rZWgvJjTi1kf7zJ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpSAEzHwy9ybozgWTZVMywLam/8BPZL2Key6QQ2b1kl8KpDwU8dKePzwHbzsUefT7z6lo6fH+tJYrw+Q6DIdzqPw1vKElhOe1csfZYVmFxRacvnbs7FLO82EpQYk1gHCvxCEkxA81nst2zOz1LWelzeCGTLTtZKZWG/urg9xhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3ZVWsaT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3ZVWsaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781599281; x=1813135281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d//dzoWe43jSoL+kMDmkV5YFg/rZWgvJjTi1kf7zJ/E=;
  b=i3ZVWsaTDTQ9Jvw9Zzt7Ukv0660Pc4VnvQdY/L65Pv/EEle0jvaRhBpi
   tjzDskmBgH1kdqm8sov3S4dWJqveeeAwlWmpFk7AFf7dRy5TrZaEUhZgy
   IQuk6mJjc6CfmnKpbVPHBQqGms+dUAL2HhXYc5nRfQbEgNj43m0AwgTAu
   5Si6HATZ4WeqFSFiZMex9sJD0Pmewdx/keOW+MMMyuoS4UBAVxkZhsRN6
   Ow9QWb6p/icqMXDBkr0F5jF1z5p7nJyv9lF8iUhFuyV96QUnoZsHpkuLV
   Ga79K/ob5zu91ymWaNV/G6swW1yT/9rqmcemPZTOv5afMU1JgiFNt4Bfu
   g==;
X-CSE-ConnectionGUID: xKg7yTU7Rw69XuPM36b7sg==
X-CSE-MsgGUID: jZNFyhTjT+W6b9B3eUIkRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82204200"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82204200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:41:20 -0700
X-CSE-ConnectionGUID: ctAZZOcaTSy4Nia+B0FDAg==
X-CSE-MsgGUID: x0WmMXhFSISjQEy9+mnTnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="252014111"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:41:19 -0700
Date: Tue, 16 Jun 2026 11:41:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: hexlabsecurity@proton.me
Cc: Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	Sean Nyekjaer <sean@geanix.com>, Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2] iio: accel: fxls8962af: clamp the device-reported
 FIFO sample count
Message-ID: <ajEMLPn8M7k0hxxw@ashevche-desk.local>
References: <20260615-b4-disp-1a8c7886-v2-1-0f0a2c48d840@proton.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-disp-1a8c7886-v2-1-0f0a2c48d840@proton.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 03:57:38PM -0500, Bryam Vargas via B4 Relay wrote:

> fxls8962af_fifo_flush() copies the number of samples the device reports
> in its hardware FIFO into an on-stack buffer
> 
> 	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];
> 
> which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The count
> is read from the BUF_STATUS register and masked with a 6-bit field:
> 
> 	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
> 
> where FXLS8962AF_BUF_STATUS_BUF_CNT is GENMASK(5, 0), so count can be
> 0..63 - nearly double the 32-deep FIFO the buffer is sized for. The only
> check applied to it is the zero test; unlike the bmc150 flush there is no
> caller-supplied bound at all. count samples are then transferred into
> buffer[]:
> 
> 	fxls8962af_fifo_transfer(data, buffer, count);
> 
> fxls8962af_fifo_transfer() reads count * 3 * sizeof(u16) = count * 6
> bytes through regmap, so a malfunctioning, malicious or counterfeit
> accelerometer (or an attacker tampering with the I2C/SPI bus) that
> reports a count of 33..63 writes up to 63 * 6 = 378 bytes into the
> 192-byte buffer: a stack out-of-bounds write of up to 186 bytes that
> clobbers the stack canary, saved registers and the return address.
> 
> Clamp count to FXLS8962AF_FIFO_LENGTH, the number of samples buffer[] is
> sized for, before the transfer, mirroring the watermark clamp already
> done in fxls8962af_set_watermark(). A well-formed flush reports at most
> FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are unaffected.
> 
> This hardens the flush against a malformed device-reported count; it is
> not reachable with conforming hardware (it requires a malicious or
> defective device, or bus tampering), so it is not marked for stable. The
> unbounded count has been present since hardware-FIFO support was added in
> commit 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling").

The commit message is most likely AI-assisted. Please, try to make it triple
times smaller in each of the patch. Most of the content should gone or be moved
to the comment block (beneath '---' line).

-- 
With Best Regards,
Andy Shevchenko


