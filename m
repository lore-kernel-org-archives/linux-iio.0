Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795518261;
	b=RKCLc53kb0pwbZvupPYQlxJQzJMpBeKvyHdPVCbjQs87hL2mqsntltpMrRXsU/+961cO
	 UmvGAXOdp5K1nx9aT5BIRPDFAAu7lTH2Trk8JyyFpYMJT3wnrF3D2DCXQ/DRApUKityyZ
	 0fcGkxEXSwB7c0r/vcDnSfVKdZmcWBrq3wpmR4v6dIzMzzjHfC8UpPHPAfbnTUfaRUiAS
	 BSZGcr2FXBs0orULeKdX4aDf+HNy6GZFr7xJ2Qg7FRW8RQy1luFM8figB9P00yNSpe4/D
	 VQK52ZwJbue3FdXA6PNOjWKlmVanl3L4D81xyBndKVke4Wj6kDzMWAgYd5DinoKSJjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518261;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=HwbRyNe0cxCMoQ/0iMUVZy8uE0wBvumaj+tzDGFjfc0=;
	b=nWw8lzgZG+lWQlDNliL6/JJlxu/LRcMNexyVBlokulLIUlbYyJv32ud/tXyXNKghobNp
	 5UuFtniTBV50NrYTWWH9zJXntJtKbGVmLlq95HPEd90h+mge0FukNv6R/0IOiJkuMI/pT
	 dcfPOFVSeEpqPcsWnY+Q1cMYnx8NYQmxf/mlSku7Mdjf+e2atuNdLTzkbRZRayCgXnEaz
	 eR4F5910kAzHqyUbEeAC+iTHApXr08RRwhoib8dcG4Vj7OTsUJi974evfJ/sbPlj8draH
	 0/SF5lw+RKHiSKuQlB+077TgxMLoVmOMV+lol/myDs19jHUQeedC3eZLEGhfWVu2xgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a3cGPQ5i;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39219606A339;
	Tue, 24 Nov 2026 11:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39219606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a3cGPQ5i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795518261; x=1827054261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=866/B+a0CRGgpxrNrCVpsidaot1giUE/gHeiKkuAJSI=;
  b=a3cGPQ5i3onw06JaTdmZZYnxsuuA5txcT4mp4cKvQpMuKAK4Wl18toYm
   4HVxTL+UrHa2StqszFh+9kxkn4jQj63jwe/MTRfaU3Ds92HkP4ycCFUUG
   czU7OKtzV4E7E2FpLcTXnCC80pZC3uHc2D2DJ+3TIeOJSwhDtKuM7ZJOr
   ebi1KK0qiT+kDcAERVTzn4S/gbGJQ2aclfzdTRn6qdHiB9byAY4hr7CtE
   oDVZn5QHLoa9qelJKyHijocOImoYze5R8CZfV8YwIKnG41ciSnlGEiL1s
   q3gCyOgjOnm0nvBFha5hQmzRdH01WBRCFL2tBCH/tKJnpwNytFKpi4FU9
   Q==;
X-CSE-ConnectionGUID: fvJ4oTjmTROTsnzrkw9bxw==
X-CSE-MsgGUID: X5E8IuVEQbm28UGLinW4WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4258637"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4258637"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:04:21 -0800
X-CSE-ConnectionGUID: AZn5hDfvSp6PrK/cf2LEpA==
X-CSE-MsgGUID: yzLD3Fq+TzSMa2IVs10jYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11559712"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:04:19 -0800
Date: Tue, 24 Nov 2026 13:04:16 +0200
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
Message-ID: <awVvMPBx8lTs-Oid@ashevche-desk.local>
References: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
 <09328c36-a32f-488b-a2c9-76fab784d259@kernel.org>
 <awVq-mE1H2g01yS4@ashevche-desk.local>
 <4012fef5-2d69-41e4-81ef-52f06d9313f7@kernel.org>
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
In-Reply-To: <4012fef5-2d69-41e4-81ef-52f06d9313f7@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 11:51:11AM +0100, Joshua Crofts wrote:
> On 24-Nov-26 11:46, Andy Shevchenko wrote:
> >> > +static const struct file_operations iio_debugfs_reg_fops = {
> >> > +	.open = simple_open,
> >> > +	.read = iio_debugfs_read_reg,
> >> > +	.write = iio_debugfs_write_reg,
> >> > +};
> >> > +
> >> > +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> >> 
> >> Static here but not in the header file. Same goes for register_debugfs().
> > 
> > Oh, how does it compile?
> Unfortunately it doesn't :(

It means I have DEBUG_FS disabled (in the configuration I used for compile-test)!

-- 
With Best Regards,
Andy Shevchenko


