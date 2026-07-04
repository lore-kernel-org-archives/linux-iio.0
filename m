Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E53A3804;
	Sat,  4 Jul 2026 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783166733; cv=none; b=nmdo8AMY09mkVD6bxZgWeQTjne6ESf8jLG1oony24h4N881EuNIoSzBHUWc3uoN5KyshFSSQUYyfNtxyjEji816ST02GbtrtqdOLvWUo27V86LL1wG2/7JL7F5L7p6GujdmS0gQPSxnVs4TrSKj2h7V5fBCgAVjUkCQ/CKKh644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783166733; c=relaxed/simple;
	bh=wLn6ZabVHDwroogZEoTKjLmBHpSdjyR1jnoMasvDq1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwGZaFmHcY/kKMrI2wsiQ2RSw4Yioka8kG7rUaZscKONHX1Q0ZeKDnbtIq6+qN4PnA8oPKu0/Y95gdu0AUo2TRSgwuNWlNPteLBqd60V0oabfbzbTPnOSESQeLAd4/D1stOC0s1Mxx7aIyEWqju8qAZsY4K+5R6++scI/aLiIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INkD0XRo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INkD0XRo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783166731; x=1814702731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wLn6ZabVHDwroogZEoTKjLmBHpSdjyR1jnoMasvDq1Y=;
  b=INkD0XRo6XoTcv37qKAefpnBs+VkBVPZgyBokJpyKkrzOcDI+UibFxWJ
   Tln7MEAjyXZU/S98/6jPhOcrCGXk+11b8+yPMb52BV8p52jwp++IR+5hW
   5+yAVib7R3/Q3KMLbLq8t15PEz3dIpF3TzEKct4Sps9S5/ZzSfhJnwBa3
   myay87zQmSxh7PI/Z8WzVj6bwdGf7pe8Q9o0oQIo9TboZNPGMPFTyLpbS
   arXNJPVJktgOeWT1I3GswUvwFTC+Xnifw537D0uQYrvQKRaGZIiZ6UXf+
   0QNLL3RixmN8g7dKb8+8lsp0frhn76Z0HdQYzfl4CBC9OlR+Np4FCssRz
   w==;
X-CSE-ConnectionGUID: ZXqpnBsnR9utAJNAatOFsg==
X-CSE-MsgGUID: IFnc+6nbTcCF8/arT/wWJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="101299292"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="101299292"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 05:05:29 -0700
X-CSE-ConnectionGUID: BfQDh5eMT+eDx1zUBs0JdA==
X-CSE-MsgGUID: z37iDkbqT8KkGlh7mQyNaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="256877388"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 05:05:26 -0700
Date: Sat, 4 Jul 2026 15:05:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <akj3Ay8mwemRj-9U@ashevche-desk.local>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-3-stefan.popa@analog.com>
 <9878f042f424bfbd7fab24175298224b58e87779.camel@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9878f042f424bfbd7fab24175298224b58e87779.camel@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 04, 2026 at 01:42:39AM +0600, Siratul Islam wrote:
> On Fri, 2026-07-03 at 13:29 +0300, Stefan Popa wrote:

...

> > +#define MAX40080_REG_CFG		0x00
> > +#define  MAX40080_MODE_MSK		GENMASK(2, 0)
> > +#define  MAX40080_PEC_EN_MSK		BIT(5)
> > +#define  MAX40080_RANGE_MSK		BIT(6)
> > +#define  MAX40080_FILTER_MSK		GENMASK(14, 12)
> Should be one space after #define, like the first one.

I saw this but left uncommented as sometimes people use this style to
distinguish bit field definitions from the register offsets. When one space is
in use it might be not so easy to put the borders. I.o.w. I have no
strong opinion on this style, but if you think we should be all the same for
all IIO drivers here, I'm fine.

> > +#define MAX40080_REG_FIFO_CFG		0x0A
> Here too
> > +#define  MAX40080_STORE_IV_MSK		GENMASK(1, 0)

...and here...

> > +#define MAX40080_REG_IV			0x10
> > +/* Current is a 13-bit two's-complement value (magnitude + sign bit). */
> > +#define  MAX40080_IV_I_MSK		GENMASK(12, 0)
> > +#define  MAX40080_IV_I_SIGN_BIT		12
> > +#define  MAX40080_IV_V_MAG_MSK		GENMASK(27, 16)
> > +#define  MAX40080_IV_VALID_MSK		BIT(31)

...and here.

> > +/* CFG.mode field */
> > +#define MAX40080_STDBY_MODE		0x00
> > +#define MAX40080_SINGLE_MODE		0x02	/* one conversion per Quick Command */

...

> This can fit in 1 line.
> static int max40080_update_bits(struct max40080_state *st, u8 reg, u16 mask, u16 val)


Here...

...

> > +	ret = i2c_smbus_read_i2c_block_data(st->client, MAX40080_REG_IV,
> > +					    sizeof(buf), buf);
> This also fits in 1 line but it would go 92 cols, so not sure which one is preferred.

...and here the wrap is done on logical border, so I think it's fine and reads
well.

...

> > +static int max40080_get_range(struct max40080_state *st, unsigned int *range)
> > +{
> > +	int tmp;
> > +
> > +	tmp = i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG);
> I think tmp can be initialized, since it is only assigned once.

I don't get this comment. You mean switching to ret?

> > +	if (tmp < 0)
> > +		return tmp;
> > +
> > +	*range = FIELD_GET(MAX40080_RANGE_MSK, tmp);
> > +
> > +	return 0;
> > +}

-- 
With Best Regards,
Andy Shevchenko


