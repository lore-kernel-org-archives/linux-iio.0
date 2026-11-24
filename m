Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517188;
	b=Y9nilsm6/k3Nvys9KMvi6c+9EBMeVNwL+Uc4jfS4WNtb2E6O5YHNDzfd8c1JshixjDE3
	 nG/Z6P1FolSS0X/g9dlwo4MVALq8yjZfrGUqBxHMxdmA7aHd8qP8peBYIOsbUq5e6UF//
	 qtzwCDFzfkeeRUDc8wOPe8x5RFx/MaP9Hnw7NWBWlSvcKA55DCw1DwkRONXxZ87PWfnMW
	 NH/T4MYYEL9JQ8AWsabPzag7lZh8sNhlCkhyUcMXpbUdqjr49W3QtqjBQknfbUgGdMlj2
	 31NxmZFRvyV3QoLgUkD2c0hzsztbQQTDQl+Q7H/gXsDDeGfGuM5XooGmUsM5LR+US6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517188;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=xXYEZ0sUAZ/QC18pSBqdsltwfapXYJDIzMGeRopQDtk=;
	b=B/DR/GD32bzGlX8QkBcqynf1GgcoqeEsO/bqO4IdFPyPbSsz/I1ih3pDqF2HnVPgQ5ls
	 Pwq2YQ5E1MOBvDofh3rt0sVioYzMKBHtEowiKMBoFKDoHz10fAMPmMWs9Bi31HBkqR1cK
	 Y6y8CAc4/DeZECruPzCOxmlK9gzzj9bXx2nlkBO+kWz3TIdzMsdIZA9N/8r/AfB+iccWS
	 U74YUE7OH1BRPKj6io6IQ8dtB4rWEAhBzfMdlokYrai0KT9A2IvReTK+Hz36IgS+HOXpf
	 q+zB7JEVAiH79zj7w6MBpffVgOQ0ux1tbUbpZxkUvyj1ef/tyhMCoLQWquyk7kbPB/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b7RKU6dq;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE4606A322;
	Tue, 24 Nov 2026 10:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9DE4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b7RKU6dq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795517187; x=1827053187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5UV7iUpUDjQT++va3q+P1i0mB6v46aVDGAtTeSUuD/I=;
  b=b7RKU6dqN/NUN64SIMCJqR3hnQCru+Duj6gIjCPrsnyCft7ErXtPqxkh
   CSiHgMorO/MPgXO8YnecAfhIgE9GfSWcQTbLAMddpzGU6D+FULEuzbhf8
   lvbNo9/NgZXPoEOxwB/2duypeai2sA1nA91xTnifXsL0xBeLkRPximrY5
   B1bGknR+3b+DY7DVW1rxy0rV1nKuolZC/Ish39CLP/w/4Jg7MHQ4ps4np
   tjWNe/ZylXxRJbESgzrk6/GM50j6emz6D94IlbAaOZZRCCeUT9rB91D3B
   xJQJ4XwhfwUTNKYu/GisgbBQc921KNcXeYIa+UOiGnNqtIYWkW4An9RsW
   w==;
X-CSE-ConnectionGUID: SoYSJv5bQuKPvLZd/lFLdw==
X-CSE-MsgGUID: qBtmxxtpQmGOUE+7IZ/dTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4249376"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4249376"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 02:46:22 -0800
X-CSE-ConnectionGUID: ptKsT4wYQdSm8H9Vu0Kr9Q==
X-CSE-MsgGUID: t/etMvuWRAO/hjszCb3/Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11652135"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 02:46:21 -0800
Date: Tue, 24 Nov 2026 12:46:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Split debugfs routines
Message-ID: <awVq-mE1H2g01yS4@ashevche-desk.local>
References: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
 <09328c36-a32f-488b-a2c9-76fab784d259@kernel.org>
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
In-Reply-To: <09328c36-a32f-488b-a2c9-76fab784d259@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 11:17:01AM +0100, Joshua Crofts wrote:
> On 24-Nov-26 10:44, Andy Shevchenko wrote:

Thanks for the review, my replies below.

...

> > +#if defined(CONFIG_DEBUG_FS)
> 
> Veeery small nit, but why not #ifdef CONFIG_DEBUG_FS? It's not
> as if you're checking for multiple defines.

Or even IS_ENABLED()?  Let me check if we have a precedent in IIO, I will use
then the same or most used style.

> > +void iio_debugfs_create(void);
> > +void iio_debugfs_remove(void);
> > +
> > +void iio_device_unregister_debugfs(struct iio_dev *indio_dev);
> > +void iio_device_register_debugfs(struct iio_dev *indio_dev);
> > +#else
> > +static inline void iio_debugfs_create(void) {}
> > +static inline void iio_debugfs_remove(void) {}
> > +
> > +static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
> > +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}
> > +#endif /* CONFIG_DEBUG_FS */
> > +
> >  extern const struct device_type iio_device_type;

...

> > +static const struct file_operations iio_debugfs_reg_fops = {
> > +	.open = simple_open,
> > +	.read = iio_debugfs_read_reg,
> > +	.write = iio_debugfs_write_reg,
> > +};
> > +
> > +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> 
> Static here but not in the header file. Same goes for register_debugfs().

Oh, how does it compile?

-- 
With Best Regards,
Andy Shevchenko


