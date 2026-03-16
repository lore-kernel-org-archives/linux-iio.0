Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477F2D77EA;
	Mon, 16 Mar 2026 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672112; cv=none; b=RmgfP9gS7g2ErRlvsuy+ISFN5Pja3H9CiQ+W015XOGuMHN2uNxPVcSfLZEzcBC4iME71a7cEv5sVY2wQsB808XVfExCVf4mB7pZlCm005VlNwMFRjzv3gHRrQFg0TgohhNmHlTPufSR3BtA3o/uNT5V3MvXoKwHuOb3XZZUVChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672112; c=relaxed/simple;
	bh=ZAMW0FTCO7c8W2CeTKzlxy+5/e5aRWcPLqGZ/kPyQ08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNJ8JTOpj/VNJJJlvuBNxoOqef8cDtpoQmBAXMGaUPNU8+xgl4hZ1/Ufgz3xCp1SbSLG0GsO7VcUDeqRN1qdfvZu5QC5BEGmToCg/wLlukghd+04w4GiJ1HirGzSEnVoZwwpTUxxtn2j50qNFw75aqVf8s5v8XG+TadCQvvhCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoCvNLiz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoCvNLiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773672110; x=1805208110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZAMW0FTCO7c8W2CeTKzlxy+5/e5aRWcPLqGZ/kPyQ08=;
  b=VoCvNLizfWAVAJUymqg1uMHMX4NCSGaeC1Km9O6hjvCBtzbMx5CyAd+n
   1hG8vP1y689Aj6RBtNbtnBtif1P5MGDKf70AxbRX9ULgZKCZjhWrPHGp2
   EdlCDD4LYnR0+pEk1dl4tpKJpfN+c4bTs8FcBdfaZuVHwzMtFJYiGqwNZ
   o5O/i/7FZj4jQIXPbuv5QAvpoHvSjdOGArDsYLq8TIyXrE6x9gC6DsIrX
   4gjoC7x/yDs+qmavW1X7UAa0jzQ+TQseQIdFW9wPnWml2ViaJN38NxMFg
   oGMOPlcQNu7JYJLYwMq+jZdPtCWeWXjE8m0Zn0UYWx9nifF3eQAdZ49uS
   g==;
X-CSE-ConnectionGUID: ej8eQeKYQpCQ7NeDtWriHg==
X-CSE-MsgGUID: i5a1hQ5HQbKcwVJLU2oy/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="97296190"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="97296190"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:41:50 -0700
X-CSE-ConnectionGUID: U/h2dejRSI2oXKffvN4L5A==
X-CSE-MsgGUID: k3Yk+3/lRZ62tU8+0Ch3ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259839184"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:41:46 -0700
Date: Mon, 16 Mar 2026 16:41:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <abgWpzT_fcMqRHzf@ashevche-desk.local>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-5-antoniu.miclaus@analog.com>
 <abQdvXq9MtIZ0EpZ@ashevche-desk.local>
 <20260314120022.56265de3@jic23-huawei>
 <abfT3qbFaM6PIDKx@ashevche-desk.local>
 <SN6SPR01MB00908E6EDB8F4D20D391664B9B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6SPR01MB00908E6EDB8F4D20D391664B9B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 12:31:09PM +0000, Miclaus, Antoniu wrote:
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Monday, March 16, 2026 11:57 AM
> > On Sat, Mar 14, 2026 at 12:00:22PM +0000, Jonathan Cameron wrote:
> > > On Fri, 13 Mar 2026 16:22:53 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus wrote:

...

> > > > - What is special about channel 0?
> > >
> > > Nothing.
> > 
> > Then why code does explicit access to regmap channel 0?
> > We should have regmap[ch] in all cases in the code.
> > 
>   There are three places that use channel 0 explicitly, none of which
>   imply channel 0 is functionally special from a hardware perspective:
> 
>   1. ad4080_reg_access() - the debugfs reg_access callback has no
>   channel concept, it's a single (reg, val) interface. We have to
>   pick one regmap, channel 0 is the default choice. I can improve
>   the comment to make this clearer.

Then it's simply wrong. You allow only one channel to be printed. The debugfs
has to print two channels, no?

>   2. ad4080_properties_parse() - uses regmap_get_device(st->regmap[0])
>   solely to obtain the struct device * for reading DT properties.
>   The device tree properties live on the parent SPI node, which is
>   channel 0's device. This isn't "channel 0 is special", it's just
>   "DT properties belong to the primary SPI device."

Can we simply pass the struct device to that function?

>   3. devm_iio_backend_request_buffer() - requests the buffer from
>   st->back[0] because all channel data is interleaved into a
>   single stream (there's an inline comment). Only one buffer is needed.

But this is not regmap related, is it?

>   All register configuration (setup, filter, decimation) already uses
>   regmap[ch] throughout.
> 
> > > > - Is it okay to communicate with different channels simultaneously?
> > >
> > > Yes. They are entirely parallel bits of silicon. Own state machines
> > > and everything.
> > > The configuration registers section of the datasheet says:
> > > "Each channel has it's own independent configuration memory
> > > accessible through it's separate configuration SPI interface."
> > >
> > > >   Wouldn't be a nasty race with HW IO?
> > >
> > > Nope. You are talking to different devices (more or less).
> > 
> > If it's a twins in the package, why do we have a special handling and not just
> > describing two independent devices in the DT/fw?
> 
> Because they are not fully independent - they share:
> - Power supplies and voltage reference
> - The CNV clock (conversion trigger)

Okay, then why not having a core part and a glue driver that registers as many
devices as you wish and provides just a common stuff?

We have similar (to some extend) cases with SPI/I²C where
drivers/platform/x86/serial-multi-instantiate.c services as "MFD" for that
type of busses.

> - A single interleaved data output stream

How does it work in non-racy way?

> Describing them as two independent DT nodes would mean duplicating
> all the shared resources, and more importantly, the data interface
> is a single interleaved stream feeding into one IIO buffer. Having
> two separate IIO devices would make synchronized capture impossible
> from userspace.
> 
> This is exactly the use case spi_new_ancillary_device() was designed
> for - a multi-die device sharing a bus with separate chip selects for
> configuration but common data/clock/power infrastructure.

See above.

> > TO me is either something special about channel 0, then we have to
> > synchronise
> > accesses, or there is no point to have this patch at all, just make devices to
> > be the same under the hood and describe as independent pair.

-- 
With Best Regards,
Andy Shevchenko


