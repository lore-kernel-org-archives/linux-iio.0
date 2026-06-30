Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E062E6CCD;
	Tue, 30 Jun 2026 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822223; cv=none; b=bVUIF5AudtgOIFt9Ie7tRtkBZQuyu3OVMsDUC360/VjepO2NDQ/bV6uVb4q0yM3JPMs9cIezUSuBc0V4kIhgVEISsV36O4zIh0DvQTZoGsaaoRkQx3ySepZnOE5PJxOGCSjDqcfiGZxD+EUHaFT4Q9E++Z8NNu9LPxU+QbE1gTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822223; c=relaxed/simple;
	bh=nnKfNNoQi2mX4bhRyFZ2Qt4ZP48zuHBEcPETaD7ybwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D12oVskxdnSvRfjtTfC5Vc88CKSOZEqaSa0+BeOtRdANyTkn7fhl6YIADobHTI6opoQbLrbbBegipiimyEQyEXXbX8Ic/squHmQ5vPryTq/m2ymxa0UPIRXyfFPwAcn9rzMJx20lEwzErTMSjC5gXiDpYSCF+C7jj6xKsgGsnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLPkpD3i; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLPkpD3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782822222; x=1814358222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nnKfNNoQi2mX4bhRyFZ2Qt4ZP48zuHBEcPETaD7ybwU=;
  b=XLPkpD3iAfI/CUuMhp0JAqJdqJenl9Vy+f/Y55gmv0rx2WQYa2tKXHzz
   kdjXsIz4WdmggdJKrsolE9FUWf/7qQqnrBSqyP+/huypnhVASzLeuiNSm
   LYri+l1dWvch1hRxH+B66LpaACSc7scashxcePRPLNo3TVIW7fej6oCsJ
   009EQURLEqZsFPTwUx7plxh3kr1ePHOF3XNtqUSnqqUAZ+YvapzjKHN3l
   ziD0igvnhXp98wyTtEG7q1MnhLPOyfoTccijRrikhtpyYC5jfhGIA+QYs
   4GVq5lFChlCQu/j/j5tYjNfkLzo7HxBaupBrb10QdMcxBfKC5ym1Qf630
   Q==;
X-CSE-ConnectionGUID: OBPl86rkS4ec5ntSbOn1Rg==
X-CSE-MsgGUID: F7PsJ/zrTOeI664GUGwrAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="87216004"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="87216004"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:23:42 -0700
X-CSE-ConnectionGUID: vkTv8ITNSma9Tgd9In8mUA==
X-CSE-MsgGUID: PjQptynNQs28p4qyqrBhTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="251198195"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 05:23:37 -0700
Date: Tue, 30 Jun 2026 15:23:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	marcelo.schmitt@analog.com, jorge.marques@analog.com,
	mazziesaccount@gmail.com, Jonathan.Santos@analog.com,
	jishnu.prakash@oss.qualcomm.com, antoniu.miclaus@analog.com,
	duje@dujemihanovic.xyz, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] nvmem: microchip-otpc: add tag-based packet
 lookup
Message-ID: <akO1Rgf4tibxbhfk@ashevche-desk.local>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
 <20260630093603.38663-7-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630093603.38663-7-varshini.rajendran@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 03:05:56PM +0530, Varshini Rajendran wrote:
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

> +static struct mchp_otpc_packet *mchp_otpc_tag_to_packet(struct mchp_otpc *otpc,
> +							u32 tag)

Despite the length I would place all in a single line.

> +{
> +	struct mchp_otpc_packet *packet;
> +
> +	list_for_each_entry(packet, &otpc->packets, list) {
> +		if (packet->tag == tag)
> +			return packet;
> +	}
> +
> +	return NULL;
> +}

...

> +static struct mchp_otpc_packet *mchp_otpc_resolve_packet(struct mchp_otpc *otpc,
> +							 u32 off)

Ditto.

> +{
> +	/*
> +	 * Legacy id based packet access: offset = id * 4
> +	 * Inside the driver we use continuous unsigned integer numbers
> +	 * for packet id, thus divide off by 4 before passing it to
> +	 * mchp_otpc_id_to_packet().
> +	 */
> +	u32 id = off / 4;

Make a temporary variable for off % 4. In such a case it might be compiled into
one assembly instruction (yes, it may be not achievable IRL currently, but it's
just a better style in case one will use this piece of code to copy'n'paste
somewhere where it will make more sense).

> +	if (!(off % 4) && id < otpc->npackets)
> +		return mchp_otpc_id_to_packet(otpc, id);
> +
> +	/*
> +	 * TAG-based packet access: offset is a 4-byte ASCII tag
> +	 */
> +	return mchp_otpc_tag_to_packet(otpc, off);
> +}


-- 
With Best Regards,
Andy Shevchenko


