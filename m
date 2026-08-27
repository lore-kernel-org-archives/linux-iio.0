Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98B39E19A;
	Thu, 27 Aug 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817213; cv=none; b=UDxbPrcKgORBniWl9ysbzIDAmFN6+JD2w2AXFW5t0KtrvsjRIBihWT/lI9AcFM33McQDxwV9W/4Jku5olQpLjePKgVv0EJ66RN2NSJaiEjQHu8dqTeFOAuRt9oKlNXKTwVIfyatb0DrTzycFzPXBLR77qmOXVePjig7HJtWznAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817213; c=relaxed/simple;
	bh=d/fIkbZwXeVNhTVMimDCcrkBk/1aXZJswCajsDybjh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwMcf2oBTBl0WTaVwE6OmtcbvdRqiV8RsHuhUm76OqVi9c9yTDHDdJVd3+t5NUEeHcnIqy0HDrIifPKX4Zgm6nLVYgenqTODq0T3PGT8nRrFyvvTF+lzvhg8F7FIwD8VsIXU1ol6r+GoFRlAVmnJ4V6i0d/H3WP5NnZVt2CKT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cX9796/K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX9796/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787817212; x=1819353212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/fIkbZwXeVNhTVMimDCcrkBk/1aXZJswCajsDybjh8=;
  b=cX9796/K4BjSrqmwVexRvpxoDCeZU2HoEIbLlZ2A3qiIRqesT1NUcDZo
   LhXnlpKRcv9SNdcgm9ZKrfjwDYMCR//uFPoSmySWo1b2mjoPFKuKuvCZa
   c5LZ006UIQf6jyK2+f4TKndBpK9J3/VCx9vaxesFYeZ5P28ZorYQpqOVh
   p9l53mMJYZjx/UROC+ptOcT9AJxA87QpLLQM+vNlNR939MCmMLlFBkbNr
   +xFgrWn+Pwtk/5PPM9gDgobfUyfo/MAFDjIDudYaK/zgsSzDPUrQWf9Ex
   50FJILgZRnh1W7HQcXocThIzdlJdC4VMw19IO2KA5QpUXQfgwBX7zNigo
   w==;
X-CSE-ConnectionGUID: rxhwcqATSjqVS9h0O/7Qdg==
X-CSE-MsgGUID: 7/W8Jt2GQPiE9cVYXmCSKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="105685091"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="105685091"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:53:31 -0700
X-CSE-ConnectionGUID: ga660RCwST2DcFwIkAS5jQ==
X-CSE-MsgGUID: 5JTlN94ARAGBZ9ywDr52TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="267838973"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:53:27 -0700
Date: Thu, 27 Aug 2026 10:53:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 5/5] iio: light: stk3310: support the Sensortek
 STK36C61
Message-ID: <ao_s9C3Ep3e8Mjrv@ashevche-desk.local>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826175409.326131-6-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 26, 2026 at 07:54:09PM +0200, Jorijn van der Graaf wrote:
> The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
> colour sensor (chip ID 0x95) found in the Fairphone 6. Its register
> interface is compatible with the feature set this driver uses:

> the STATE/FLAG bit layout, the data and threshold registers and the gain
> and integration-time fields, verified on that device (the ALS and
> proximity readings scale with their gain and integration-time fields,
> thresholds written through the event interface read back from the
> chip, and the FLAG near/far bit crosses with them).

Do we need this paragraph in the commit message? To me sounds like a good
for the cover letter.

> Add its chip ID to the known-ID list and the device table entries.

> Whenever the ALS engine runs, the chip also measures four colour
> channels, laid out directly after the ALS data as 16-bit big-endian
> values in R (0x15), G (0x17), B (0x19), C (0x1B) order;

> the R, G and B assignments were each confirmed by the matching channel
> dominating under red, green and blue illumination, and clear by its broadband
> response. The ALS data register tracks the green channel exactly.

Isn't it too many details? One may decode that.

> The colour controls, all verified on the device: R, G and B are gained
> by the same ALSCTRL gain field the illuminance channel uses, clear by
> a GAIN_F_C field in a GAINCTRL register at 0x4E (documented in the
> datasheet of the STK37660, a sibling part with the same data register
> layout; stepping it multiplies the clear count by ~4 per step while
> the other channels hold still), and the whole colour block integrates
> over the ALS integration time. Expose the channels with per-channel
> scale and a shared integration time, as suggested by Jonathan Cameron.

Again, too detailed description. Try to squeeze that AI puke straight to
the point. If one needs a Datasheet, add Datasheet: tag with an URL.

> The scale attributes reuse the driver's existing table rather than the
> iio-gts helper. The green channel equals the ALS data, so its scale
> must read identically to the pre-existing in_illuminance_scale, which
> has always been the gain selector alone with the integration time
> exposed separately; iio-gts would fold the integration time into the
> scale, and its scale writes may retune the integration time behind the
> illuminance channel's back. The pre-existing available-values files
> stay constant attributes; converting them to read_avail is a separate
> cleanup, as it changes the long-standing scale lists' text ("6.4"
> becomes "6.400000").

-- 
With Best Regards,
Andy Shevchenko


