Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089948;
	b=GapKf5/VHT6CgvVfQs3uBZDZU5Q7KpETYi+ZbGJI4wezdeX93lQFiycEIJWLruyOCsdz
	 qzhq9ID9g9lBIEhOB1WhLxZtEutDVaA3VLuOxmXrbsDsAjRqMsm5mSIsvuCsdYtN2oulA
	 1YpEmBDqlFnZ30y3ej+/FAHCEnXZ5m0snQp4TRro/ZzpW5nFE+GTum+G2Xjx2a8JLMm9b
	 tFF+UkLM7nVCoYhwnKB6LitfLgh3mbKqCdAXaU7WRE3oB94qPEkap994eVO5GqDcAWzM5
	 /Ie46WPBA0I8Yb6WhacT7bGTREcNcivt4gOkiFn2ReeyH6ujF41IHQ78bQQhGDmM9zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089948;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=vuQD/S2GyE2GFjBMyGiQ0UZSsPsBVMyvUF04h28eoX4=;
	b=D14i66IRkRX4q0/kZgyQRxSezsqzdWciW3Om+Htc2viyNOw6Hw2w4PH5PJZQwMg+Vl/L
	 kc1ZBQX0kvGb9eFle5IkqSv4wq0ZVJRNaGm4jq51oD+yNSmEMNfnbqpIwvkmIaBVGGV8O
	 7MWpwDzrdnlf52cotaMfHnsMsNkXUEulMQbrTI4yDc7vsEjhSW/tlR/mZ/anmm4VaaOok
	 uV7DXCUsPNrZrad1Z+rUH1ZSAs5pT9tYFx5tr5rrr/ubWJQLMi1EIr7mhoU9p7uJ0EOc2
	 bZyAjo3fz3at389tZYavXrb5ivFHNuyvefzStWLaOCnDaXRVFL+nj74B9A1VHpJ783Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="bCwxjX/n";
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC293606A320
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 08:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC293606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bCwxjX/n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793089947; x=1824625947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o7AD41NaBYScybLpolYoUZ1hcFCropF6qLsNBfMNhhE=;
  b=bCwxjX/nA4AEXsYKcBCD6UrW2o2nqDCEyw9f4Kfg27oNOPN0Iz2rJSoA
   Wy03qg2tpfjX6GE6IHvldA0kVWVT5RIB93E7FovJs8ni5n3IJvU9c+kLh
   MnEygJIFF2vND1Rc9SVCFCoi1GcTF/uCebNrELpD9geVodW74Y+LM7N2m
   BQf9S82GSe37sSQUDRG2WsYXb67XMFCGRxhNusyScbV/smqCE5YHJ2JE7
   bjnyzN1t9rPU/sGgykngt/EebyRTTFjz1rUp/YWhRGtDsBIhBUC9s7UDN
   7EN0ucOo5Mrijg/DVp1ASzm7JQgmXBy2+vgBm3uht6g4Oyq6Cu51m0AcO
   w==;
X-CSE-ConnectionGUID: 1+UdzSs/QiegqCxysELYcg==
X-CSE-MsgGUID: ritMA1nhRM+lPHAxAuOu1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1687821"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1687821"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:32:26 -0700
X-CSE-ConnectionGUID: AtjTt+4AQtWiRQvFuZvCFw==
X-CSE-MsgGUID: C5EwbOq7Sr6aCxVcoK9QqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4826618"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:32:25 -0700
Date: Tue, 27 Oct 2026 10:32:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 23/39] iio: adc: cc10001_adc: use
 iio_push_to_buffers_with_ts()
Message-ID: <auBhlvhC7YwyaGfd@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-23-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-23-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:41PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Move the buffer onto the stack, local to cc10001_adc_trigger_h(), and
> declare it via IIO_DECLARE_BUFFER_WITH_TS(), removing the now unneeded
> update_scan_mode() callback.

...

> static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)

>  	unsigned int channel;
>  	unsigned int scan_idx;
>  	bool sample_invalid;
> -	u16 *data;
> +	IIO_DECLARE_BUFFER_WITH_TS(u16, data, CC10001_ADC_NUM_CHANNELS) = { };

Move it up?

>  	int i;

-- 
With Best Regards,
Andy Shevchenko


