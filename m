Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEFA36655E;
	Tue, 17 Mar 2026 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743475; cv=none; b=AgrZYg+MntEdl1+lFGtf2w4ikvIRrBXSj+sagu4i1vby72vpRzrTTlNGTdEEHNpgGfpESB8vubhl5LiUFitcwtKPTu55hYnvvI7b2TeSQ9SLhlT5wK61QfyZLa86MmhL1ABPFsJ3NB1Ch662UO+H83k9dZ42KKYH0oXPk0ti0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743475; c=relaxed/simple;
	bh=1n3VOVl3x+1BOkcpZTwb3qWmCeX6KadDJhMAjOVUtdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktJ782PRJ6OCWXIz0yFdk7PH04xwcSRqvB7dseDFQ+VsX09OpMeMXNuRb2OLsgR53Sz+ZHgO0bPqMO26n3B+IwAqtUgu7Jl1T8oIgDbC95hMzSXztgIr+HM0+TDzq65cERpgGHR9GANbF0j2coUOpGqWKMkF+VU8ChA9XKizVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzFq/es5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzFq/es5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773743473; x=1805279473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1n3VOVl3x+1BOkcpZTwb3qWmCeX6KadDJhMAjOVUtdw=;
  b=hzFq/es5bBqbrxuIonuvK+UhYgHB2Xi3twBaclpw+1uVhQqangH/GrUj
   XVHh2fPfxLQoRrctf8GM4NkNE1CKqMrLtyj2EE5Y7dWmNYGD6fPTXepwS
   3AMAi24jkMYLY+RaDbOzDIuAh3aXChuSl3oAAXbwwzh/zR02EY0PC6ZVq
   J090z+oYi5UIgQOSUlgqhwdAoxnC5wvXxfE+CsnhKGxNFh+Fh3znp7LBg
   JEozii7c91BtswQNGddzYO7xGuh7mM1/LjlgBeJe3+ONiMHYXv3sq7+tN
   QihRanqFguqsT6oqVtmdlzd00qYaGtQak610IdQw4oG8ndQAd2JMlleow
   A==;
X-CSE-ConnectionGUID: jBkzvqaLS1eFkCW48FKhyQ==
X-CSE-MsgGUID: 2RB1wqYITMqtK2eV5aOQFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86126444"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86126444"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:31:11 -0700
X-CSE-ConnectionGUID: nK1XShSfSKKjF4w9SCFsmA==
X-CSE-MsgGUID: aPjlNS0tQQScsVkAVNScHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="216591023"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 03:31:08 -0700
Date: Tue, 17 Mar 2026 12:31:06 +0200
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
Message-ID: <abktanVPsFwIlIfH@ashevche-desk.local>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-5-antoniu.miclaus@analog.com>
 <abQdvXq9MtIZ0EpZ@ashevche-desk.local>
 <20260314120022.56265de3@jic23-huawei>
 <abfT3qbFaM6PIDKx@ashevche-desk.local>
 <SN6SPR01MB00908E6EDB8F4D20D391664B9B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
 <abgWpzT_fcMqRHzf@ashevche-desk.local>
 <SN6SPR01MB00904D9E9C5008D32066E2029B40A@SN6SPR01MB0090.namprd03.prod.outlook.com>
 <abgf3TZTib9UrjSB@ashevche-desk.local>
 <SN6SPR01MB00900C6A79A51852C73D6ECF9B41A@SN6SPR01MB0090.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6SPR01MB00900C6A79A51852C73D6ECF9B41A@SN6SPR01MB0090.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 17, 2026 at 09:54:13AM +0000, Miclaus, Antoniu wrote:
> > On Mon, Mar 16, 2026 at 03:09:18PM +0000, Miclaus, Antoniu wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > Sent: Monday, March 16, 2026 4:42 PM
> > > > On Mon, Mar 16, 2026 at 12:31:09PM +0000, Miclaus, Antoniu wrote:
> > > > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > > Sent: Monday, March 16, 2026 11:57 AM
> > > > > > On Sat, Mar 14, 2026 at 12:00:22PM +0000, Jonathan Cameron
> > wrote:
> > > > > > > On Fri, 13 Mar 2026 16:22:53 +0200
> > > > > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > > > > > On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus
> > wrote:

...

> > > > > > > Nope. You are talking to different devices (more or less).
> > > > > >
> > > > > > If it's a twins in the package, why do we have a special handling and not
> > > > just
> > > > > > describing two independent devices in the DT/fw?
> > > > >
> > > > > Because they are not fully independent - they share:
> > > > > - Power supplies and voltage reference
> > > > > - The CNV clock (conversion trigger)
> > > >
> > > > Okay, then why not having a core part and a glue driver that registers as
> > many
> > > > devices as you wish and provides just a common stuff?
> > 
> > > Because the AD4880 is not two independent ADCs sharing a package - it is
> > > a single device with a single interleaved data output. Splitting into
> > > separate IIO devices would make synchronized dual-channel capture
> > > impossible from userspace, which is the primary use case for this part.
> > 
> > Sounds to me like you need, probably, a virtual device for that.
> > Maybe even on IIO level. Do we expect more devices like this to
> > be enabled in the future (or maybe already in tree, but lacking this
> > feature)?
> 
>  The AD4880 is a fairly unique part - having separate SPI config
>  interfaces per channel with a shared interleaved data output is not
>  a common pattern, and the chances of another device like this being
>  upstreamed are low. Given that Jonathan has already reviewed and
>  approved a previous version of this series, and the patch has
>  collected multiple Reviewed-by tags, I'd prefer to keep the current
>  approach.

This...

> > > The shared resources (supplies, CNV clock, interleaved data stream) are
> > > not just "glue" - they define the device's operating model.
> > 
> > Sure, like any other resource for MFD (HW speaking).
> 
> MFD models a single device exposing multiple functionally distinct
> sub-devices. The AD4880 channels are not distinct sub-devices - they share a
> single interleaved data stream, and splitting them would break
> synchronized capture.

...and this are important pieces of information. Can you add a summary
to v7 commit message explaining on the chosen approach?

> > > The per-channel SPI interfaces exist only for register configuration; the
> > > actual data path is a single stream handled entirely by the backend.
> > >
> > > > We have similar (to some extend) cases with SPI/I²C where
> > > > drivers/platform/x86/serial-multi-instantiate.c services as "MFD" for that
> > > > type of busses.
> > > >
> > > > > - A single interleaved data output stream
> > > >
> > > > How does it work in non-racy way?
> > >
> > > The data path has no software involvement at runtime. The CNV clock
> > >  triggers both channels to sample simultaneously, and the device outputs
> > >  the conversion results as a single interleaved bitstream on the data
> > >  lane(s). The FPGA backend captures this stream directly - no SPI
> > >  register reads are involved in the data path. The only SPI traffic is
> > >  for configuration, and each channel has its own independent SPI
> > >  interface and regmap, so there is no shared bus contention.
> > 
> > Okay, so it's in a way more complex (like a camera sensor in terms of
> > data/configuration paths) device. It's now even more looking that the
> > current approach is a quick hack rather than a solution to make this
> > properly fit Linux device model.
> 
> The driver uses spi_new_ancillary_device() for the config path and
>  the IIO backend for the data path - both existing kernel
>  infrastructure used as intended. No custom abstractions are added.

Also would be nice to have something from this.

So, I think for v7 we need transform this discussion to a summary that covers
all aspects:

- why MFD box can't be applied here
- why regmaps are independent
- how does it look with data and configuration paths
- the device is unique and we do not expect more to come (or very little chances)
- et cetera (or what I forgot to mention)

> > > > > Describing them as two independent DT nodes would mean duplicating
> > > > > all the shared resources, and more importantly, the data interface
> > > > > is a single interleaved stream feeding into one IIO buffer. Having
> > > > > two separate IIO devices would make synchronized capture impossible
> > > > > from userspace.
> > 
> > > > > This is exactly the use case spi_new_ancillary_device() was designed
> > > > > for - a multi-die device sharing a bus with separate chip selects for
> > > > > configuration but common data/clock/power infrastructure.
> > 
> > This... It doesn't fit the data path as far as I read from the above.
> 
> Right, spi_new_ancillary_device() covers only the config path.
> The data path is handled entirely by the IIO backend with no SPI
> involvement at runtime.
> 
> > > > See above.
> > > >
> > > > > > TO me is either something special about channel 0, then we have to
> > > > > > synchronise
> > > > > > accesses, or there is no point to have this patch at all, just make devices
> > to
> > > > > > be the same under the hood and describe as independent pair.

-- 
With Best Regards,
Andy Shevchenko


