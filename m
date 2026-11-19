Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117499;
	b=Cc6JBfoGwhsCRG39YGujUnB3/UEwNBbM/pPlBrFlQmRFnZjSD3hrvMiB3D+IpOTtDoiY
	 FMckUkPDStEUjiV12kaujFFHVZ4g5wdeK/14BPUwbJJ4Wc0MWeSRrP7P9SnrUC9vDr7aQ
	 3UkdkmARTx5EhWDvkE6WlSzbd63pcKV+j+WmulaPR8k6bTbk/xn7A5fDcoWV82Ogg90hH
	 21AyoU2p2fdpzP8r4Itzw68I6W1ZXEfXv8O5ZAWNkBWgVm2X3zbMQYSF8YhRnO4unXZYL
	 bmdmRHb0X4YoXyfNw/iKPkryBgrv98elU6eWgNqmCNmhQ35j7nuMOlwM8VKmAjVA4vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117499;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=UlhNWECNMWboIMXZjG/HcjrAD3F1ADi/+8AJ3qORzzg=;
	b=Cm7jU4MdzdJLKJ2HLY/yWY/GyuSaLjYKNf+eFAlwnvyk7Mmdtd66MVaxdXO+a965XhvX
	 NdUAcyaQnT/Tm/q7XKBxGfkHnigjzb6ZqPmq2kEADt/QGS0sldvkTwmQsmnl95za7kfuW
	 B1hLEgBE80ZTcvqXMsgb62TXn6yXjWLAQshRRJt5TljMpGz2TW8M3/3/q2RKG07BzTZvT
	 Aza1EV0hTxpot8n7vWcQ2Yu/qF6pAwXZyZtwebkaoCaKs2KTTXxdsDPXl8i6mFOjNojLX
	 GiBXvBHc0H+uXPQG8MTEJH/0h6KNxj9qAp6kW4Ickd85nxJ9/ZCLs/gFA4IPSJ8YGUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UZIlzeKy;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFB606A320
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 19:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96AFB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UZIlzeKy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795117499; x=1826653499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Y9gPiQruHKxD6jWJBz2ZWFCBUjynP2pdyaJB8MqYXkc=;
  b=UZIlzeKyn2PSyZHf9b+rvibeAqT3eEfhNY1ytAXFuJ3ap3+7CjsSHx8F
   pR4ZLV9KeWKZ/5kqO/3VK75uj0lTGdPBLYkJU+2hwNXSDwi8rZmcoWO6B
   vTqn4Oh8WKDq62H3NhCb70UdaM9E4KvfATnO17AwD85GjdujMbdqwEEjT
   vpQCcbsjp16rLL9EzqFyXAgx4BqnBidw+a9CVa0SJNk9zIIuoLZYIU31U
   ssD1FaqNmX8oIBHK5qlvCkDKaXDARMaH+hOXRPcSKGf9dytovblO3KORg
   iME/2bv40QhC8kHc8p0UzZnL4TfeEOWL70c44ERbTciuL8/BCID6Qbkrv
   A==;
X-CSE-ConnectionGUID: YqbKhF2HTNq8/PsJzKwVzg==
X-CSE-MsgGUID: dzbXhakNT0akXamnHnOhZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4025361"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4025361"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:44:58 -0800
X-CSE-ConnectionGUID: R46t9OooQ3GmkRz7f6qFig==
X-CSE-MsgGUID: PY02vksNQqy2eVPq8Rg1Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10600932"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:44:56 -0800
Date: Thu, 19 Nov 2026 21:44:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: linux@analog.com, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: dac: ad5766: Convert GENMASK() to use static
 parameters
Message-ID: <av9RtQDXoR7phgga@ashevche-desk.local>
References: <20261117160857.1799863-1-andriy.shevchenko@linux.intel.com>
 <1a261f19fff18b074ed3e004c4896f2cf586b611.camel@linux.dev>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a261f19fff18b074ed3e004c4896f2cf586b611.camel@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 01:36:42PM +0600, Siratul Islam wrote:
> On Tue, 2026-11-17 at 17:08 +0100, Andy Shevchenko wrote:
> > There is no need to use run-time calculated masks in the code. Besides,
> > GENMASK() over non-static parameters might lead compiler to generate
> > much worse code.

...

> >  #define AD5766_UPPER_WORD_SPI_MASK		GENMASK(31, 16)
> >  #define AD5766_LOWER_WORD_SPI_MASK		GENMASK(15, 0)
> > -#define AD5766_DITHER_SOURCE_MASK(ch)		GENMASK(((2 * ch) + 1), (2 * ch))
> > +#define AD5766_DITHER_SOURCE_MASK(ch)		(GENMASK(1, 0) << ((ch) * 2))
> >  #define AD5766_DITHER_SOURCE(ch, source)	BIT((ch * 2) + source)
> > -#define AD5766_DITHER_SCALE_MASK(x)		AD5766_DITHER_SOURCE_MASK(x)
> > +#define AD5766_DITHER_SCALE_MASK(ch)		(GENMASK(1, 0) << ((ch) * 2))
> This could have remained unchanged?

Yes i could, but does it really show the tightness between two semantically?
I believe it's not, that's why I explicitly put the numbers instead of
indirection.

> >  #define AD5766_DITHER_SCALE(ch, scale)		(scale << (ch * 2))
> >  #define AD5766_DITHER_ENABLE_MASK(ch)		BIT(ch)
> >  #define AD5766_DITHER_ENABLE(ch, state)		((!state) << ch)

-- 
With Best Regards,
Andy Shevchenko


