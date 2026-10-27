Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089515;
	b=tSXTW3yjdKc2YEyY+uxHdsyBNaTQ3WC6mJfPnv/5356IrRKHldyryZX0B7BhuHI+b0KP
	 P2GNNp4oob4IQaHxmlab07yDCxy42ac7Sen+zAN77lb9tQ/SCM2Zlvpb4ZoaiqlvqpC7r
	 8xettAhfCL83uYrvtbIyCPnJIDXt74tQWsZdEK/3VUPL646l5EkrBqQWar8WKg5akSdt+
	 22XV+Hivd2Exw95yzJU5Q1MP2soGPBiSSic/fj4TzUcY3cjt8IhjzZOA/qBSJFwdJ7MG2
	 0aRXOD3LL9P2m3ec0HnhdGTbp1IG9BYGwr9BMj7Pe2qnrqZZRRG4wFOCND4SJgEbnKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089515;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=o6ZyUwkdQdD5r2siToK4fzp1KkqQ0radf7NdK4XHkVQ=;
	b=tR3K8m+k+R6cMlxl8Bwxpu6S3lGuczG60DH4dD1Cig5h09M5dLCKyIFtoHrtDY8xJdi7
	 TTH5bg8UGngKlgxLTcvzyQly+71GbyzaFxys6FSAGqzp7Q7CjiSOeuaJx3f6tVSrnQTSJ
	 PtIspiniZhErxypyIJHRN4l98oXK00BQKeelQN6Ih1vkIoI0f1lxKg7/Y6Ue8Q2OzFmZ8
	 6YrqmBsjxfsmD7jLdh8hhKwZLSg194FiEZW/N5bTyWWAnJMM/pZzQ6bKpDUI5Htl6UZ3K
	 beGDONEai4F2S07Td55uQe7EoCGFUBv8C1bLFISjS7+x3pkDujojbh60LTDb+J0dBwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rl96MVHo;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E6606A329
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 08:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA1E6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rl96MVHo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793089515; x=1824625515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DwM6nOTXFIcbNtE7lJbjdnCFpZdvmPKW0haZ0ueHH1k=;
  b=Rl96MVHo6sIdPAQqJ97cYG4wiWfGCtqEvbqE/+26KHKkYCzV0r83aTyA
   ZT9wTurjCa54zfDlpTN6AqwFKmHVscowp5wNM36hS8/arQrH2Xgz5ARdx
   0rIe2xB6LqzwwCrrmvwk4y2p2MbJygFTH+s84rdKBXuCP7NZusRXMkKfF
   MXKdbgCp4O18Je9zH93ChGftXw0J4wbjumB/AVp5DgrNUR6hCEDtoHv5j
   oMXFguglRpUwdtrPihYIjkFgxMOBuq+RpQmoHft/07lPOp/CGgDkLNhEE
   86a/FmW/Ldh2/s0RUB1wbSpkHtXV5+tXy2Y/o9F+8ffyAtglmnlAcadYL
   A==;
X-CSE-ConnectionGUID: qgkJpMcPTeabgihwVYIhOA==
X-CSE-MsgGUID: hhCAgmYCQO6QWGCY/BZmhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1679904"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1679904"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:25:14 -0700
X-CSE-ConnectionGUID: avKzTAdWREah2zLZLAP/bw==
X-CSE-MsgGUID: OnAIwIQrQhe36wI4zBpfrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4392771"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:25:12 -0700
Date: Tue, 27 Oct 2026 10:25:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 17/39] iio: health: afe4403: use
 iio_push_to_buffers_with_ts()
Message-ID: <auBf5WQlpOrJF6x0@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-17-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-17-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:35PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> The pushed buffer is never a direct SPI/DMA transfer target, so move
> it from the per-device state to the stack. Use
> IIO_DECLARE_BUFFER_WITH_TS() since the timestamp offset depends on the
> number of enabled channels, and zero initialize it.

...

> static irqreturn_t afe4403_trigger_handler(int irq, void *private)

>  	int ret, bit, i = 0;
>  	u8 tx[4] = {AFE440X_CONTROL0, 0x0, 0x0, AFE440X_CONTROL0_READ};
>  	u8 rx[3];
> +	IIO_DECLARE_BUFFER_WITH_TS(s32, scan, 8) = { };

I would move it a bit up, giving the visible context to be even before
'int ret...' line.

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
> -					   pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
> +				    pf->timestamp);

One line of 82 characters is okay I believe.

-- 
With Best Regards,
Andy Shevchenko


