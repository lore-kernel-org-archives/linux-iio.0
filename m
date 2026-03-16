Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D21A9FAF;
	Mon, 16 Mar 2026 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690816; cv=none; b=UfexN5UUXBn8sc6WYtXKsr77QiA6MS15bNc9RbZsuzZjWnH8e4d8zzEbB9g4Q7u0oQF13fi0SIxlhikw4JqarAjfWBZMN07GQMJxYQwWukT/urktVzLs03NbHOuk+4TyRznXPfZMnOEoRlki/yDupgKpbuEA5Lo9iLqjRMygWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690816; c=relaxed/simple;
	bh=eziUrfGIEYZ7BT4ezckdVtKWxCQhIqxmP6TJr4uBdHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJTa3SaE1fcCPKZaQ29jld4MC+7ugHY3Qs7Un94a1pozSmyJkoivyXvsc5/e0ukc/xj0al9q4+FsfP/tI0NX8/4WB3DCGtUnWMTYZvB5Wk2CKJ7vu2rIPvDLn3L8l3E56MTnzgUo9dX2F9o44zcGTUPZ3O2SMD2Fs9LD7FMIR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FP3KxoQW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FP3KxoQW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773690815; x=1805226815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eziUrfGIEYZ7BT4ezckdVtKWxCQhIqxmP6TJr4uBdHY=;
  b=FP3KxoQWaGbLvxPpBX6nEUK4Cm/FzNF0KRw73ALUcdCE+8nrw69ijqaJ
   VlWkoVjYTv47P3Qo9tq+yU5jBrKhVWoJtyB7nlGvSlGJwkqUcBOUVowE6
   uicJNXPQDfQOYzs0rrqXGId7/c1JFsbQFQspkIad/TQghjMGrMs3c8Zgm
   E1Co3iO0UTfgdfIaLsMSz7eqfqtanc+qCzVruahKnKI5XKNQ+k5E/w3gT
   uXubhXCzGUwOOckVXVpLP2V5gGSJS2Mu6tHU3Rqz079OpJ8mBAMAcaoSo
   z61DDP4eam0YZriZlS+WIpB1HbJlbF4KI1NHGdZCZ19fYXIAUZAWtr/il
   g==;
X-CSE-ConnectionGUID: 7v4gPCnYSLe0lS/ukL04AA==
X-CSE-MsgGUID: 6lzpKLyQQ1GSNULYNTZepA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85413833"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85413833"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:53:34 -0700
X-CSE-ConnectionGUID: 4+Ngo4LnSJ2ceDssZaHjJg==
X-CSE-MsgGUID: IVqsFRHcSa+cfG5ze0RgvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217807926"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:53:33 -0700
Date: Mon, 16 Mar 2026 21:53:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Message-ID: <abhfulXY1PbCow-Z@ashevche-desk.local>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
 <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
 <20260316183117.4dde7386@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316183117.4dde7386@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 06:31:17PM +0000, Jonathan Cameron wrote:
> On Sat, 14 Mar 2026 18:13:32 -0500
> David Lechner <dlechner@baylibre.com> wrote:

...

> >  	u8 shift;
> > +	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
> On this. There is new generic infrastructure for marking these.
> https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/dma-mapping.h#L720
> https://lore.kernel.org/all/01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com/
> 
> Would look like
> 	__dma_from_device_group_begin();
> 	u8 buf[3];
> 	__dma_from_device_group_end();
> 
> Do you think we should adopt them rather than doing our own thing?
> Slowly though I don't want the noise of a mass conversion.
> 
> As normal, advantage of standard infrastructure is cutting down
> in subsystem specific magic.
> 
> I 'think' result is the same (though it also forces the trailing padding if anything
> comes after this and needs it).

As I read it it will be an equivalent to

	u8 shift; __aligned(IIO_DMA_MINALIGN);
	u8 buf[3] __aligned(IIO_DMA_MINALIGN);


-- 
With Best Regards,
Andy Shevchenko


