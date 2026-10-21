Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588994;
	b=BNgK+YIlWvePytqWK0onF5tP3tR3UhKDQDK6e98aohZDg3A3ggaDY7s3erYotazFLpeI
	 JupUzFKPF29AoJIFljpQdGyiC3wpp7jmWzQIC1aDxjCiBxp6FaZoAq73IpxJiOGlXaSQ+
	 2t7xktnM3mAdyexvD4Td6CUpjQszm5PtUAFXzbe/3BFEM+eG4JiesxRIAG+DTy5/5gfTk
	 VDG+KcnmifeZNt4Nys69lP5GCZSPB3K2zICsLDE36u8lz+ujfw5mQlKdo1T1J7XpuHEcb
	 +UKueKFuEUP/7xzmEVhHRyaQUCfZhc7RHPDarP0ctBeLOM0tQFHre24qIyd6jvKbrPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588994;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Organization;
	bh=3H+LKjSf/NCPSTee+0b2Xv1F9bOZnSXFKKZAMNNuix0=;
	b=m8QqcAGElxvIE4wvtUFTsibXTw71x55XqKJg7E/XX75upyXMqQ+FVEma3/w7OpvRFh67
	 ocslf5qlXsJUNcgJazgwcX5V51sUpvlc/xju+MxAvfzCU8C+CQ5+4HyrS/1RNdcdCkdJM
	 k5jP1EqL3tOdHMoR2Oi1TEo9wYYv+Ml/uQUV8ycwUtsg3NkmBf8+t8RJW7Ef/YtaGxeHk
	 qsKlrqDI4CeLsHs3SLrUdaY1U7m57yVPQJCqXs1gT4V/v4mwh6p7Zf0r+NbalnfOkBgo3
	 mA778unjHTCcS+r0tSuMpMNMsNZtU27O0mHJ976Z0U7lWUBmz6YVQ7o161p1mzdpkew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cTWMh1cb;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A660A2600;
	Wed, 21 Oct 2026 13:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 949A660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cTWMh1cb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792588993; x=1824124993;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=0PIM/WlSKU/1sNBZpagcrdl6dMbbUa/CVra/KaUcxSA=;
  b=cTWMh1cbDsOftguS+k+QG+J1qm5IDJfy2MU11bmGQE0J9kFNGREljLdb
   s4Bo9MKdRAjABu9vT4H3Yj60FWBB3XRS7rm4a3QIU0XvMlSppzUBNWQSF
   IieSv9nAH/TivYlC2Vp5KL/J9j0dFLJhCmnCcqn2lK7caaGm1lZQpIf9V
   WMBGPSa7TbNRAC5HBIpbqxrvG2+kdczHwEKraxw+6aL0ebBKjnNx2NeMN
   KGA14Sy4S6eDYbRJwt71/FBWEbH6r6ANU991BnKkaIP28foH5CCe2J4BT
   pIXWboR21RcGwn1y58j8Fv9ew6ca/BROAocgGwoAVsbIUcBno2Vshal1r
   Q==;
X-CSE-ConnectionGUID: Z/rgQ4G8Qye7bGLiqppHpQ==
X-CSE-MsgGUID: fZ+7nd1RQRqnGBXStJ8nNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1209905"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1209905"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:23:12 -0700
X-CSE-ConnectionGUID: 6gFptDBxTkKNtVIXOHrtJw==
X-CSE-MsgGUID: Mt1CA/iXTQSu03IuNs6zjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3487562"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 06:23:09 -0700
Date: Wed, 21 Oct 2026 16:23:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH v2 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Message-ID: <ati8u6-OUEi7KOHw@ashevche-desk.local>
References: <20261014141650.259929-1-ciakval@gmail.com>
 <atEdM6wi_FAGFjrr@ashevche-desk.local>
 <20261017031411.05dee323@jic23-hlaptop>
 <atXSBHbOPYYltHUW@mm-ntb-00805>
 <atXZwm5DzCK8S0_K@ashevche-desk.local>
 <atdRJ3JqAyGWOnxf@mm-ntb-00805>
 <athxOKkugAYL62F9@ashevche-desk.local>
 <ati5lzd2KotvmMC6@mm-ntb-00805>
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
In-Reply-To: <ati5lzd2KotvmMC6@mm-ntb-00805>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 03:09:43PM +0200, Jan Remes wrote:
> On Wed, 21 Oct 2026 11:00:56 +0300, Andy Shevchenko wrote:
> > On Tue, Oct 20, 2026 at 01:31:51PM +0200, Jan Remes wrote:
> > > On Mon, 19 Oct 2026 11:50:10 +0300, Andy Shevchenko wrote:
> > > > On Mon, Oct 19, 2026 at 10:17:08AM +0200, Jan Remes wrote:
> > > > > On Sat, 17 Oct 2026 03:14:11 +0100, Jonathan Cameron wrote:

...

> > > > > FWIW, I don't think it to be very urgent, as people probably don't use
> > > > > it on x86-64 (seeing both as it had only DT probe support and that
> > > > > impacted users are likely to have noticed the oops).
> > > >
> > > > What do you mean by the second part of the sentence? It's as easy to use on
> > > > ACPI platforms as on DT, we have so nice trick called PRP0001, which allows to
> > > > enumerate "OF-only" drivers on ACPI platforms via SSDT overlays (or other means
> > > > of DSDT/SSDT provisioning).
> >
> > > I did not know about the PRP0001 (thanks), so please disregard that
> > > argument. Still, I believe x86 users to be few if any, since the oops is
> > > quite easy to trigger
> >
> > True.
> >
> > > and AFAIK most x86 distro kernels ship without CONFIG_OF.
> >
> > How is this relevant? This driver doesn't use any #ifdef CONFIG_OF or alike,
> > so most likely the driver is available for x86 as well.
> 
> I thought that CONFIG_OF was needed in order to be able to probe a
> device using the driver's OF table. TIL that missing CONFIG_OF prevents
> only manual probing (`echo "tsl2519 0x29" > .../new_device`) but not the
> ACPI mechanism.

Actually not really. The manual binding relies on i2c ID table and
the OF ID table is a fallback.

> So:
>   1. Please ignore that argument
>   2. The wording of my Patch 2 commit message is not correct ("cannot
>      be probed on a kernel with CONFIG_OF disabled"), I can send a v3
>      if that's preferable.

Yes, better to send a new version with better wording in the commit message.

> Thanks for getting me to learn a bit more.

You're welcome!

-- 
With Best Regards,
Andy Shevchenko


