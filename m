Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A49437448;
	Mon, 10 Aug 2026 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386891; cv=none; b=rNhPYjReHa66xiTi8+xLgf3V5tN4AXXuSBYs28Wj/6tsyXW/TU4ILIRJhWTKBrbMhjl81UJcBIhFG9OqrrLizDNrsnQjfrtUkLcTVG0mBgXkiwq4BykRRBB21ggBRt12iIJOLRgKIlRlyUPOH2KkqICMvjp5RA20veu2gBvOQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386891; c=relaxed/simple;
	bh=w7E9hKgMW1GqumxvPPfpkzjLh2yL0WE6NH8MkvAqG5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMKC1GDQOw4AHzl21wKHOxNBH3bOfkVXv74cevgWKnIcbMmNYkZyYraXxrzFzLOvrHYy2RGhxz0O+JuOYBY+w5/jtwnX4HnomhE4yAQSdmxTjL4WqNYUvqsEa868xsDF2Bj+mKEKULLv8OkhlhZUjEg9yegZ6fgOn8dhePsazjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DarhLggS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DarhLggS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786386889; x=1817922889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w7E9hKgMW1GqumxvPPfpkzjLh2yL0WE6NH8MkvAqG5U=;
  b=DarhLggS/vOzLIKzvHdTDCU/Lv2q7XJ02hmmtkkHV9KH3ilkJkHf5hwZ
   gfU7M4+rVKRMUx0+/Tj4z7Y5OgPwd7phKNhQE6UZF4Mt8JKxPiMxi14Q9
   Z4nPTA8Cq5PWMqxZaKxDW9QaJZOfiOuiljSBTaxhpQyVAKLLJooEqqsJh
   VK+3yQVGAIq9TeLy5zWqLYONXixk7mxf2mE8GLenedRxwuFFvraBscMq6
   /cpbNoG5wBhHxdEmnHBF8jLjfxx1HOBcJ7NQHL6TN8a8vL04Z6z9B4FT7
   n0CenyZRf/ZVAZPO/KLxXv8s7YIEwCvL9SfOVEf/CKHOIjQUC65GlMHIe
   g==;
X-CSE-ConnectionGUID: 2M2m2xilTzeC3W/uIyjaeg==
X-CSE-MsgGUID: 6QbpG5UpRreSp/2sJYVuGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97564762"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="97564762"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:34:48 -0700
X-CSE-ConnectionGUID: ZREt/oXqRduguFrIQ3mNZg==
X-CSE-MsgGUID: 0pJK7HhYQL2j8XyViBIZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="293041329"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:34:45 -0700
Date: Mon, 10 Aug 2026 21:34:42 +0300
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
Subject: Re: [PATCH 2/3] iio: light: stk3310: add per-chip match data
Message-ID: <anoZwgq6ZO_VY064@ashevche-desk.local>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
 <20260810110423.41697-3-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810110423.41697-3-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 01:04:22PM +0200, Jorijn van der Graaf wrote:
> Introduce a chip_info structure carrying the device name and channel
> specification, attach it to every i2c, OF and ACPI table entry, and let
> probe take it from the match data. Clients instantiated through the
> sysfs new_device interface under the lowercase compatible-derived name
> have no firmware node and do not match the uppercase id table entries,
> so absent match data falls back to the original chip data. The channel
> data registers move into .address and the shared channel definitions
> into macros.
> 
> This is a preparatory change for a variant that provides more channels
> than the existing parts. No functional change.

...

> +		ret = regmap_bulk_read(data->regmap, chan->address, &buf,
> +				       sizeof(buf));

I would add

	struct regmap *map = data->regmap;

and make this on a single line.

>  		if (ret < 0) {
>  			dev_err(&client->dev, "register read failed\n");

...

> +	chip_info = i2c_get_match_data(client);
> +	if (!chip_info) {
> +		/*
> +		 * Clients instantiated through the sysfs new_device
> +		 * interface under the lowercase compatible-derived name
> +		 * have no firmware node and do not match the uppercase
> +		 * id table entries.
> +		 */
> +		chip_info = &stk3310_chip_info;

This is an interesting comment and approach.

> +	}

- Where does this lowercase come from? Is it Linux forced conversion?
- What's wrong with simply failing the probe?

As far as I understand the problem is preexisted. Or was there any default
taken? How do we know that the chosen default is a good one?

-- 
With Best Regards,
Andy Shevchenko


