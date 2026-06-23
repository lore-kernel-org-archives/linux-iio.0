Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73323ED6A;
	Tue, 23 Jun 2026 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239493; cv=none; b=d78sBMtCHD6zEoUgMEMBlZkN7bUFD5u73p986Digt/eZHxEa7t+47WqFleMmrF9/YKsHV70W3UrdnkEVpDaJxnKL+JKIO0wNa5hT1kpsLNoSOMBt36NwkttVgO+VXqLplIUPX+3fsAt/NbRHiuN4nfmYp/iJsrhYQ7Qpqsgb6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239493; c=relaxed/simple;
	bh=/CHkWCxKFKJxBpWJ4OZug3VCBnEclX5h1FZJe5iM2DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpzUvaet5fwhKXCXy0edskztjqyG7gRQpPVi1+q3WpBKrjULs3umnPXvdBgQoI6MqutTtVD3zYk7YDVwZ80TT3+04F7G2vZJjI7J0m9OVB2MTtdBRKuqF4YbHg6sqYUbPZWFWsQefYgC8oMSJppnaojZ2oQKVdqcECMXjtGavHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCTyuych; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCTyuych"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782239492; x=1813775492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/CHkWCxKFKJxBpWJ4OZug3VCBnEclX5h1FZJe5iM2DQ=;
  b=bCTyuychDKcv/9Dbj1Plurb4x3UdJ4Ygh3OQDdP9m/FX7Vuizene1FfP
   KantunVue+eXC7L3u0DT02CllnGElYyTHiN7fwwNSjlP2XMZx+OCPqWsM
   qZ0Te5i5PIJZZwCxyTRbwHE6E5V6Pi4vbP5nfbceZKfXBt02CrrhAgsGk
   ZOxJ1g+/69/6dGTs02tk++UqlJwjxvXETpGqcCsIPqFVbqgmURk0o4NVQ
   /3TO4tN51i2VER93A682+r4QqwB/8Fhvv32/puT+LfavoZZIEihRk0Z2e
   PBaMdcGC9byC2dGH1ZhtxJmArY38yEhvDsTcizFAT07TB7fjxNuX+Bv6o
   A==;
X-CSE-ConnectionGUID: 1cM1Mqa6R8uoLjMGZIjoCg==
X-CSE-MsgGUID: QDJG8xNQQZ6lvXM4PC9GZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="94110583"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="94110583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 11:31:32 -0700
X-CSE-ConnectionGUID: tEX+s1a8QDyOsWxvD4ZH/w==
X-CSE-MsgGUID: ac9PgAfZRaKbo7qcpLsHvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="273285631"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 11:31:28 -0700
Date: Tue, 23 Jun 2026 21:31:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] nvmem: microchip-otpc: add tag-based packet
 lookup
Message-ID: <ajrQ_WWkHYC9seDq@ashevche-desk.local>
References: <20260623105944.128840-1-varshini.rajendran@microchip.com>
 <20260623105944.128840-6-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623105944.128840-6-varshini.rajendran@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 04:29:37PM +0530, Varshini Rajendran wrote:
> Add support for accessing OTP packets by their 4-byte ASCII tag while
> preserving backward compatibility with the existing ID-based lookup.
> 
> The OTP memory layout can vary across devices and may change over time,
> making the packet ID approach unreliable when the memory map is not
> known in advance. The packet tag provides a reliable way to identify
> and access packets without prior knowledge of the OTP memory layout.
> 
> Two offset encoding are now supported:
>   1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
>      Used in DT as: reg = <OTP_PKT(1) 76>;
>   2. TAG-based: offset = 4-byte ASCII packet tag
>      Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
> 
> The driver resolves offsets matching valid legacy selectors (multiples
> of 4 within the packet count) through ID lookup, falling back to tag
> lookup for other values. This ensures existing device trees continue
> to work while enabling new tag-based access.
> 
> During probe, packet meta data including the tag is read and cached.
> The driver also validates OTP memory accessibility and emulation mode
> status. When the boot packet is not configured, emulation mode allows
> access to the other packets. When both are not available an
> informational message is logged.
> 
> The stride of the nvmem memory is set to 1 in order to support tag based
> offsets, comment in the header file is updated accordingly.

...

>  #define MCHP_OTPC_SIZE			(11 * 1024)

Side note: At some point maybe (11 * SZ_1K) with help of sizes.h?

...

> +/**
> + * mchp_otpc_resolve_packet() - resolve offset to packet
> + * @otpc: OTPC private data
> + * @off: NVMEM offset (legacy ID-based or TAG-based)
> + *
> + * Legacy offsets (multiples of 4 within valid ID range) are resolved
> + * through ID lookup. Other offsets are treated as 4-byte ASCII tags.
> + *
> + * Return: pointer to packet if found, NULL otherwise
> + */
> +static struct mchp_otpc_packet *mchp_otpc_resolve_packet(struct mchp_otpc *otpc,
> +							 u32 off)
> +{
> +	/*
> +	 * Legacy id based packet access: offset = id * 4
> +	 * Inside the driver we use continuous unsigned integer numbers
> +	 * for packet id, thus divide off by 4 before passing it to
> +	 * mchp_otpc_id_to_packet().
> +	 */
> +
> +	if (!(off % 4) && (off / 4) < otpc->npackets)
> +		return mchp_otpc_id_to_packet(otpc, off / 4);

Hmm... I was thinking about something like temporary variables for these two.
Note, in some cases the compiler may issue a single instruction when it sees
both together. That's why in many GPIO drivers we use something like

	unsigned int offset = foo / 8;
	unsigned int shift = foo % 8;

or similar.

> +	/*
> +	 * TAG-based packet access: offset is a 4-byte ASCII tag
> +	 */
> +	return mchp_otpc_tag_to_packet(otpc, off);
> +}

...

>  {
>  	struct nvmem_device *nvmem;
>  	struct mchp_otpc *otpc;
> -	u32 size;
> +	u32 size, tmp;
>  	int ret;
> +	bool emul_enable;

Perhaps keep the reversed xmas tree order?

-- 
With Best Regards,
Andy Shevchenko


