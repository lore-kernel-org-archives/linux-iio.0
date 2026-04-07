Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403436F418;
	Tue,  7 Apr 2026 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590340; cv=none; b=m0mnugkB0g6n7BBjNbqRVVjvzkVxVUZBG94Dkt/jOSH3/+pFNtQitSS+WD0CxL/b2I9V/60RU7GwkUhBBv7N76N2zfWC+xRCK1XIiQ+34uzBV+lkVN1WxmSert+2obbSKtscfgG5FT21tPHPN9c9mUKzGlCI1OWb563A2V0WfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590340; c=relaxed/simple;
	bh=6sRem4qGJyoTnXXM1n1oQWawHbtki0l4aI2Sjmg97zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4XUHbYoxDrGzVy/hoUaXgqFx1mr45dAnT3QOI682wUh90BXC4Nptq/CZ5wHJqNM2BGMbT6+zlHGdMVtH5sgDzS7hSBODn4mecmin+ki+jH3Lzq+A3eIWkHvo9UgG4qpke00GgiQd+JH3Jj1xQG8vPipRZtonw9hIJAvENRjDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAVggC3O; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAVggC3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775590339; x=1807126339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6sRem4qGJyoTnXXM1n1oQWawHbtki0l4aI2Sjmg97zM=;
  b=UAVggC3OzK/WW1GstuXjdJeSJardvxgN5aJNk/K6Csuwc1wpDSb1pgR1
   Ia9geAFSIdZ4Mx6c6HPyXISvnbxJw12daiKA3+Rj4u9ZZttjB6uE+1pMZ
   WY25jCbIckAmTi6BBHGUJVbUt9wKTvrxrY+Yp6rpXFMu1rc8ou8DUzJRo
   uDgBLqSM6NwzO4hxADh0i0BHNa0yz1ry5Se/uFMVV6BdKgOg4GkFfxSko
   nfqpg0IYUdvx45MPOp0ZXNaiQLGZP5lJfDPlX0eJLVJdQx956Tt5QMSsm
   rysM5w6HTRIt7+LV/ToTVgI63KYL9giMxd93lPAqUlm7AJAaFWh/l091N
   w==;
X-CSE-ConnectionGUID: +4VcxnorTBGG2bZ0GC7WJA==
X-CSE-MsgGUID: tqFazQagRYu3zgDDYzTcwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80423455"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="80423455"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 12:32:18 -0700
X-CSE-ConnectionGUID: 9DL90HYQS1GJwpuXrxDG3w==
X-CSE-MsgGUID: zmaNJpD9SRWX4LhoeErMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="228163686"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 12:32:16 -0700
Date: Tue, 7 Apr 2026 22:32:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] iio: ssp_sensors: cleanup codestyle warning
Message-ID: <adVbvTheQvDPuWnT@ashevche-desk.local>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
 <20260406080852.2727453-2-sanjayembedded@gmail.com>
 <adP8g8rYuXbfT3Um@ashevche-desk.local>
 <2D18BE15-3AC7-47DD-9430-E3ECB201EC84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2D18BE15-3AC7-47DD-9430-E3ECB201EC84@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 07, 2026 at 11:12:25PM +0530, Sanjay Chitroda wrote:
> On 7 April 2026 12:03:39 am IST, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Mon, Apr 06, 2026 at 01:38:48PM +0530, Sanjay Chitroda wrote:

> >> Reported by checkpatch:
> >> FILE: drivers/iio/common/ssp_sensors/ssp_spi.c
> >> 
> >> WARNING: Prefer __packed over __attribute__((__packed__))
> >> +} __attribute__((__packed__));
> >
> >Do we need __packed to be there in the first place? Isn't it naturally aligned?
> 
> This structure isn't naturally aligned as in header structure u8 is followed
> by __le16 and __le32 fields.  Without packing, compiler inserts padding to
> satisfy alignment requirement.

Thank you for confirming this.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


