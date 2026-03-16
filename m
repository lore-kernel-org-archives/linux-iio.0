Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD61A76BB;
	Mon, 16 Mar 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674471; cv=none; b=GZoecSzKH1Q6+hwFmejisphpN7Ll+V/GruM82Wd0ZCG+BtI4TTJFq3aMSzRhABYkrZsh1gxlDd6WfSpiV4LssL4XMGAXCWxcGPPtEmZaAJI8kkqBmvSuloxk4HkonI0REdXhkGkryNJI/hlbIExCh3V/VMdrisdqJTsSxqRXv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674471; c=relaxed/simple;
	bh=bU9p2jhuMrsNUOSKjEd45lnMcW78fta72PH7YREyHWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/d/Z2of0obes1bkMUzE7NZVOgGrYqAqcLuVzYPZmo6+uSbANRoFeWejdgrphk3zq6k6/U5CU/uho+1iIJLkkBAD6X3Ogn3RljVnGbatedpNj3P1TXqD2E4+81g67p+w95EZMmB0oa0Y1T/vYxeN0FtzCbIdg1vYu24X7qcLCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mO9f78GO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mO9f78GO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773674469; x=1805210469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bU9p2jhuMrsNUOSKjEd45lnMcW78fta72PH7YREyHWc=;
  b=mO9f78GOw5rtOpw7DfKyXp3hBGl6sBw8bymVge3xO6jNEvSFe0rBjB+f
   3TnmPbR7CT4s+FfLgN+wEKS7BDeI1gq1ppgdnOGhbTTDbZs5opeErlFf5
   tR8qQPS/qfzVjMPMUUPT1Ladn9s0rHg5KEzLhlCLp9iY6cUs8JaAOMsst
   s0kNhFl3mjRZ+629MbqZdqQC67lOyBSulNSpPxYH4BlIMM0Oy6pBG72Ms
   7pQL8xt2ddtPBHHeYC/0sZ8Ql0ID6KrMPMvn6odqB6auXpHYSTrJxiaAK
   lFs4LInbFJUZhXsMl5zB1fZGaZrP80WxdSiPwWZMjiR+LFtflbhlco0tE
   Q==;
X-CSE-ConnectionGUID: E18buDjJTi62f9MYDBh9aQ==
X-CSE-MsgGUID: Z7cixq4ISJiWyg0oqgduaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73711866"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73711866"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:21:08 -0700
X-CSE-ConnectionGUID: 01XILBKsR92/qxl54NhOJw==
X-CSE-MsgGUID: PA6iHNNjQrCc2D35V1Otcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221890892"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:21:04 -0700
Date: Mon, 16 Mar 2026 17:21:01 +0200
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
Message-ID: <abgf3TZTib9UrjSB@ashevche-desk.local>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-5-antoniu.miclaus@analog.com>
 <abQdvXq9MtIZ0EpZ@ashevche-desk.local>
 <20260314120022.56265de3@jic23-huawei>
 <abfT3qbFaM6PIDKx@ashevche-desk.local>
 <SN6SPR01MB00908E6EDB8F4D20D391664B9B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
 <abgWpzT_fcMqRHzf@ashevche-desk.local>
 <SN6SPR01MB00904D9E9C5008D32066E2029B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6SPR01MB00904D9E9C5008D32066E2029B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 03:09:18PM +0000, Miclaus, Antoniu wrote:
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Monday, March 16, 2026 4:42 PM
> > On Mon, Mar 16, 2026 at 12:31:09PM +0000, Miclaus, Antoniu wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > Sent: Monday, March 16, 2026 11:57 AM
> > > > On Sat, Mar 14, 2026 at 12:00:22PM +0000, Jonathan Cameron wrote:
> > > > > On Fri, 13 Mar 2026 16:22:53 +0200
> > > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > > > On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus wrote:

...

> > > > > > - What is special about channel 0?
> > > > >
> > > > > Nothing.
> > > >
> > > > Then why code does explicit access to regmap channel 0?
> > > > We should have regmap[ch] in all cases in the code.
> > > >
> > >   There are three places that use channel 0 explicitly, none of which
> > >   imply channel 0 is functionally special from a hardware perspective:
> > >
> > >   1. ad4080_reg_access() - the debugfs reg_access callback has no
> > >   channel concept, it's a single (reg, val) interface. We have to
> > >   pick one regmap, channel 0 is the default choice. I can improve
> > >   the comment to make this clearer.
> > 
> > Then it's simply wrong. You allow only one channel to be printed. The debugfs
> > has to print two channels, no?
> 
> The IIO debugfs_reg_access callback signature is fixed by the framework -
> it provides (reg, writeval, readval) with no channel parameter.
> 
> For v7 I can drop debugfs_reg_access. But doesn't hurt if we have at least half
> access to the debugfs for it.

This will confuse the users. Either do not print or print it all.

> > >   2. ad4080_properties_parse() - uses regmap_get_device(st->regmap[0])
> > >   solely to obtain the struct device * for reading DT properties.
> > >   The device tree properties live on the parent SPI node, which is
> > >   channel 0's device. This isn't "channel 0 is special", it's just
> > >   "DT properties belong to the primary SPI device."
> > 
> > Can we simply pass the struct device to that function?
> Yes, can do that in v7 if you think it is absolutely necessary.

Yes, please.

...

> > >   All register configuration (setup, filter, decimation) already uses
> > >   regmap[ch] throughout.
> > >
> > > > > > - Is it okay to communicate with different channels simultaneously?
> > > > >
> > > > > Yes. They are entirely parallel bits of silicon. Own state machines
> > > > > and everything.
> > > > > The configuration registers section of the datasheet says:
> > > > > "Each channel has it's own independent configuration memory
> > > > > accessible through it's separate configuration SPI interface."
> > > > >
> > > > > >   Wouldn't be a nasty race with HW IO?
> > > > >
> > > > > Nope. You are talking to different devices (more or less).
> > > >
> > > > If it's a twins in the package, why do we have a special handling and not
> > just
> > > > describing two independent devices in the DT/fw?
> > >
> > > Because they are not fully independent - they share:
> > > - Power supplies and voltage reference
> > > - The CNV clock (conversion trigger)
> > 
> > Okay, then why not having a core part and a glue driver that registers as many
> > devices as you wish and provides just a common stuff?

> Because the AD4880 is not two independent ADCs sharing a package - it is
> a single device with a single interleaved data output. Splitting into
> separate IIO devices would make synchronized dual-channel capture
> impossible from userspace, which is the primary use case for this part.

Sounds to me like you need, probably, a virtual device for that.
Maybe even on IIO level. Do we expect more devices like this to
be enabled in the future (or maybe already in tree, but lacking this
feature)?

> The shared resources (supplies, CNV clock, interleaved data stream) are
> not just "glue" - they define the device's operating model.

Sure, like any other resource for MFD (HW speaking).

> The per-channel SPI interfaces exist only for register configuration; the
> actual data path is a single stream handled entirely by the backend.
> 
> > We have similar (to some extend) cases with SPI/I²C where
> > drivers/platform/x86/serial-multi-instantiate.c services as "MFD" for that
> > type of busses.
> > 
> > > - A single interleaved data output stream
> > 
> > How does it work in non-racy way?
> 
> The data path has no software involvement at runtime. The CNV clock
>  triggers both channels to sample simultaneously, and the device outputs
>  the conversion results as a single interleaved bitstream on the data
>  lane(s). The FPGA backend captures this stream directly - no SPI
>  register reads are involved in the data path. The only SPI traffic is
>  for configuration, and each channel has its own independent SPI
>  interface and regmap, so there is no shared bus contention.

Okay, so it's in a way more complex (like a camera sensor in terms of
data/configuration paths) device. It's now even more looking that the
current approach is a quick hack rather than a solution to make this
properly fit Linux device model.

> > > Describing them as two independent DT nodes would mean duplicating
> > > all the shared resources, and more importantly, the data interface
> > > is a single interleaved stream feeding into one IIO buffer. Having
> > > two separate IIO devices would make synchronized capture impossible
> > > from userspace.

> > > This is exactly the use case spi_new_ancillary_device() was designed
> > > for - a multi-die device sharing a bus with separate chip selects for
> > > configuration but common data/clock/power infrastructure.

This... It doesn't fit the data path as far as I read from the above.

> > See above.
> > 
> > > > TO me is either something special about channel 0, then we have to
> > > > synchronise
> > > > accesses, or there is no point to have this patch at all, just make devices to
> > > > be the same under the hood and describe as independent pair.

-- 
With Best Regards,
Andy Shevchenko


