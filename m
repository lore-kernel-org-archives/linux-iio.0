Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912714;
	b=dKDlhePZE044Fi+wRuXqYQjkL8a5FsfAz2roRAgV/fD+uw64DFkph5a0rLEN1eaQl4YW
	 w0GrQWLz9S1+sbM43ZKsoRCyF58e6gzmoMtviAV10X8P1Ncrz6MO4GNKUW2o2PnZPIaGc
	 +/XBMLN5yCmZ6Syq+pcDhaikHRjaJHIwEePX2KUXDcBzPBrkoYondinKRc1eVmye1zbRj
	 NgpfwX7LhDmFr4Slod4QO0EZv38U1u/BOiJSDeMIEqAaw5X5Az+2T/f+M1BXxvwPG2qLP
	 2lJasRLG7HB3qHjDVuvKCS3I5e8T2mgYvPOSCLaKf45YlAHgG2pAJv3hHcnRDRbVYPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912714;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1kU0oUKFP8qs3a/uIzyFa5iGsKNkg9VEancdWHE3XQM=;
	b=flw9fwlj/xnfYtHMVh3CJ6M7v6mUhdY497BjrHSTA7Hp20NVc+e2xrDqLIsUSfAXCb38
	 Lp/6RT1CtrLvEWN6GIk09kkTGg89gP4zT7Or7lDaDeeGr1+npQNxM9agdIAHivqB6xaMC
	 I5cRqQLdOYvJb0RHr9mmta1bU9NIGicqILHL1GUbl2wTpyKU4TISwjfuSkZfjjiIDV6Hp
	 +VKFylbQdnMYC9Gd+BVSNeZDH8DuI3eFvsK2uMXo3HYljikh9K6ck60RWpQXtFp55IEy3
	 esjpezi8eDvLq87W7Rgwc3le4sRH4C7jwbqH9Faubo5YVWJ+sRqYne0yhsIrL3P0bCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WjSweDpC;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD77606A334;
	Tue, 17 Nov 2026 10:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD77606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WjSweDpC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794912715; x=1826448715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1UlDPg4H4GiOwBIiBQ4CE7u0ZPEqreZmQXDPKyudEx4=;
  b=WjSweDpCrx6Om1ysJGuC1XvBWWGeOPLYtGpuHQfEDIoTTTSm6ghnIJYM
   DQFE+ZC3wkCaZ7VVCx6QxjyGQIyRVz3L3d1aHcF5QJDerjK9cQ1DT9vcB
   iE0wa/yv5QSqTemWFxTmUnxBg3/DDwIjokzHtxJ98pyYWk3qxl5twhYvL
   iizlYmx7AWGHPj+M+w7K3oQFuXWgLorTQg2oQ+IRH/mtOWkgdsmeTr/ky
   +mfvvMNhVhXgYaGT81Y72CbRKzdxs84dQnp25LfJ1+txezXw8qZ16PoEj
   jHBtWsxZqQdd93B2E82BJMH7lPT4zd8olxKcJ3MCWs34YH6jmBb27qK6F
   A==;
X-CSE-ConnectionGUID: RNh6FDNMQh+ZYKQIzx76uA==
X-CSE-MsgGUID: OlQnGND1TDupR/muAQrHgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3577931"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3577931"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:51:54 -0800
X-CSE-ConnectionGUID: 0nLnxp+xRA6LUYWI5bwi4g==
X-CSE-MsgGUID: 9PSUDEkUS6mBMFNKGWUBRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10033258"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:51:52 -0800
Date: Tue, 17 Nov 2026 12:51:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1745: fix 16-bit register accesses
Message-ID: <avwxxbyzHP8tCgkV@ashevche-desk.local>
References: <20261116194214.45174-1-kapoorarnav43@gmail.com>
 <avwqtvhrxmgLe8np@ashevche-desk.local>
 <20261117104152.137597-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261117104152.137597-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 04:11:52PM +0530, Arnav Kapoor wrote:
> On Tue, Nov 17, 2026 at 12:21:42PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 17, 2026 at 01:12:10AM +0530, Arnav Kapoor wrote:

...

> > > - bh1745_trigger_handler() stores the raw bytes in a u16 although the
> > >   scan type is IIO_CPU.
> >
> > I didn't get this, what's the problem here?

> The handler does regmap_bulk_read(..., &value, 2) into a u16 and puts

> that straight into scan.chans[], so the buffer gets the register bytes
> as they come off the bus, LSB first. The channels declare
> .endianness = IIO_CPU, so user space reads each sample as a native u16.
> That is right on little-endian, but on big-endian every sample comes
> out byte-swapped. The patch reads into an __le16 and stores
> le16_to_cpu(value), so the data matches IIO_CPU on both.
> 
> I'll reword that bullet in v2 to say this directly.

Yes, please do.

-- 
With Best Regards,
Andy Shevchenko


