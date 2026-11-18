Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992717;
	b=wmGfNmnyX+gTw9+SM6dBHcEIGCIDe6LWXBWed21UZDfQfOwkC+RalhJ5YObS7fv3QU5o
	 gUIUWcG8BnQ4gPZN7CLq1VqfrG9sFMHiJs7J1ylwhq/bgqmV8jCa3WiLXQ8iHH64Z/v+b
	 yCThlB1xbjq0XeZQgYwsjGbWZMstEM34o18seEgm0BEOGGzVQ8IZ3X5eA+9eKVP+2B7GZ
	 zCxFBpFAHQ8DjPhKNVjzOEPofLJSlRy8uiWBf3JSNejSbcbf0JpWh1N2pyS9SZw1+62K6
	 UYHRF/g/YRnHYqizzbFeqkzqdNMEusHgBT1Hi4kuxt8tpvH4xUC96UpIzPed8KfRyNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992717;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=374ri7+4MeVZtf5um2Y1DNiMy9roud5hxc7+KcS4KyA=;
	b=gpQa+oYujkUVo9hKiEcPOLRtNujj8XEpJxkPq0/pJBskcVZ76ssQ5rLX0LZLSY01Dza3
	 lbSln4ZWnltfGPbIs0RH65V5cfFm6LlCbEwm5zAtAqjO2BiiDpxhswjhgY9q43438WhMQ
	 sbgAR/NV8Pd3xdzrdDo1J+mUo0lQhV+A5Qy+vinAwfIxb4NSW/WZ/V3aOApyPq5kucIBx
	 ym0OlBnDHMFLfVGbfdDcNM2i2I6prLFyGVTB0iK32r3kvYVauxzE+uQLrmX3EUBAKdOHy
	 Gb1pYVV27VsCVfI07w5/+OL0JTLRa+/f1grZfTZasLVPZqGi9kqV7jg1plg4kgczx3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MtmMx8sj;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F317606A320;
	Wed, 18 Nov 2026 09:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F317606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MtmMx8sj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794992716; x=1826528716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JRYvHjc2XzoEsxyTnYYkNUZ2Ub40RofbKnyppuYWcVE=;
  b=MtmMx8sjCr5vR+qjxpRhT2uNF/AhwpmpnYaQB8iYuwddgwW1eHRpf46g
   3e9L02Hoy2kNWR8sQXviPEI4D14YgBRHKkDWvp0weTXSdbJvbq8ZvQFHK
   hHLP0FCbp66isUf6r15T62wjaQMSFVNv0JbRazYb2WZCzVLFO1q7EiAMP
   Ihx6d4l3R4NHPI0G+L6txUO2TuJqABPynBSXJ8k4mwsBmbAdvmmxQ7rzV
   OQ5pRDF2MHj3d98/issjEuwX9g833B9Bjk5YPrAopSP698FMHMMrNrg7K
   w8MuxjqixGHADcE6nB9dgkpRHsa5xs+NpRQBT6NGSHotohuaVBRFON8a3
   A==;
X-CSE-ConnectionGUID: a+1EVYp8R06QWilypDlDKg==
X-CSE-MsgGUID: hAiYoEO7RPWg9VqHpJEg6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3818818"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3818818"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 01:05:02 -0800
X-CSE-ConnectionGUID: +yvOVnxlTj+CX2zSo4rUIA==
X-CSE-MsgGUID: nKNRUAYyRJqpgofT/76kLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10424378"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 01:04:59 -0800
Date: Wed, 18 Nov 2026 11:04:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raffaele.tranfaglia@gmail.com
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH RFC] regmap: kunit: add tests for values wider than
 val_bits
Message-ID: <av1qOFxolvDhQTKs@ashevche-desk.local>
References: <20261117-regmap-kunit-val-bits-v1-1-a1cd02063217@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-regmap-kunit-val-bits-v1-1-a1cd02063217@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 07:55:14AM +0000, Raffaele Tranfaglia via B4 Relay wrote:

Thanks for starting this discussion! My comments below.

> Add two test cases writing 0xffffff0f with regmap_write() to a regmap
> with val_bits = 16:
> 
> - write_wider_than_val_bits uses the RAM regmap, a bus that only
>   provides reg_write()/reg_read();
> - raw_write_wider_than_val_bits uses the raw RAM regmap, which goes
>   through the value formatters.
> 
> Both expect that only the low 16 bits reach the bus and can be read
> back. The raw test passes, since regmap_format_16_*() only store 16
> bits. The RAM test currently fails: _regmap_bus_reg_write() hands the
> value to bus->reg_write() unmodified, so the bus sees 0xffffff0f. With
> the rbtree cache the value is in addition truncated in the cache only,
> so the cache and the bus disagree.

It means we can't enable this test cases without addressing the underneath
implementation(s) of the regmap. I think the proper solution is to cut upper
bits on the regmap level, so the cache and HW will see it as expected.

> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> ---
> regmap_write() takes an unsigned int, also for regmaps with
> val_bits < 32. What happens to the bits above val_bits currently
> depends on the bus and on the cache type:
> 
> - buses with raw write() go through the value formatters, which
>   silently drop the upper bits;
> - buses with only reg_write() get the value unmodified. regmap-i2c's
>   SMBus backends and regmap-fsi then return -EINVAL, others (like
>   regmap-ram here) take the full value;

To make the users' lives easier we should not move the burden on their
shoulders to carefully cut the upper bits all the time it might be required.
I see the only solution is to fix either globally in regmap core or in each
bus and document that somewhere that developers for the new regmap busses
won't repeat the same mistakes.

> - with a reg_write() bus and the rbtree cache, the cache stores the
>   truncated value while the bus got the full one.
> 
> This was found in the adux1020 IIO driver, which writes ~u16 (promoted
> to int) to a 16-bit register. It works on I2C adapters and fails with
> -EINVAL on SMBus-only ones [1]. I am raising it here as other drivers
> can hit the same thing.
> 
> The tests in this patch expect masking to val_bits on both kinds of
> buses, so the reg_write one fails today. This is only to show the
> difference: should regmap_write() mask the value to val_bits for
> reg_write() buses, or should it reject such values consistently for all
> buses? I can send a patch for whichever is preferred and adjust the
> tests accordingly.

...

> +static void raw_write_wider_than_val_bits(struct kunit *test)
> +{
> +	struct regmap *map;
> +	struct regmap_config config;
> +	struct regmap_ram_data *data;
> +	u16 *hw_buf;
> +	unsigned int rval;

Reversed xmas tree order?

> +	config = raw_regmap_config;
> +
> +	map = gen_raw_regmap(test, &config, &data);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
> +	if (IS_ERR(map))
> +		return;
> +
> +	hw_buf = (u16 *)data->vals;
> +
> +	/* Write a value with bits set above val_bits */
> +	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 0, 0xffffff0f));
> +
> +	/* The "hardware" should only have seen the low val_bits bits */
> +	if (config.val_format_endian == REGMAP_ENDIAN_BIG)
> +		KUNIT_EXPECT_EQ(test, 0xff0f,
> +				be16_to_cpu((__force __be16)hw_buf[0]));

Do we really need those explicit castings? I think they are already inside
the byteorder macros. Also we have be16_to_cpup() and le16_to_cpup() which
might help.

> +	else
> +		KUNIT_EXPECT_EQ(test, 0xff0f,
> +				le16_to_cpu((__force __le16)hw_buf[0]));

Ditto.

> +	/* And that is what we should read back */
> +	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 0, &rval));
> +	KUNIT_EXPECT_EQ(test, 0xff0f, rval);
> +}

-- 
With Best Regards,
Andy Shevchenko


