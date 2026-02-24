Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6118EFD1;
	Tue, 24 Feb 2026 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927353; cv=none; b=Fpm0I5YBplJshoc5EMpHgaeTPVzHBq2HhYBdw78cg50UPTyqwZZix+sJYEFk0YjpO1mPuEJaRaEzH/NyAyInjXdyHhRRdMTCYtGG8e0ujuBYCElLLMRs4+0qZtJrd4E5achdAcMgMGcmnJ+O+3+P0KcwaoGwRKbkUv8PlpssbaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927353; c=relaxed/simple;
	bh=vEiJRhqW8c3E4qOWOAHZE5AvAFbaqH1ekxsuH4r5ug0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVomzJ7qWjEOuTdsOOvduqrDYWTbbN4l2sYKuBuVPDU6AVoC8rNrRyCxcCFZzrdPMtOxstFVpUIjRxFPbyuMab+m6kvtMn7Ij6Pz61HF/GjlHNsKwUnUPiH2gmQ/NVcqUBSxQajp697lC9BpQyRyHnpQuCuTwqsWzVm55bxjneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Imc0vctl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Imc0vctl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771927353; x=1803463353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vEiJRhqW8c3E4qOWOAHZE5AvAFbaqH1ekxsuH4r5ug0=;
  b=Imc0vctlKt0ME6QLEKG4WemSJAsEUHxINmWbhpnO2sfw+d5548kjC3zg
   omRDGMVLEZauRtOr/9nzNQ2BW1fXEJgUfjAQH8TjEaPaJnlpJLRxdF1AL
   HnCONpyNtBUn38+Gq7IGT82mx64V/RGPiTHfK1BdOP2IfEqnM9BfOH0W2
   lpELvYI0jG38AmzNIlkXfjmLSM5gNzmzboinjE5qUZrm2wyepV5Do7dee
   JFjDpXkaAfV1tda7VWk4R+f3NMTaqGj4Tq5o5igAQ8xgNITlVltoYFxkT
   HPrzRseUVAIuCVe3fPCSsJUYXOI4xLOTNxnkVhB811RC5cArhA+7tmcBa
   Q==;
X-CSE-ConnectionGUID: mRn5JC91TeKIrcs3+FHsZQ==
X-CSE-MsgGUID: jEZhPnq9QP+dwOXbGIoeSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83648523"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="83648523"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:02:32 -0800
X-CSE-ConnectionGUID: i4DCdOV6SjuXJ89EMQvVGg==
X-CSE-MsgGUID: tWUNc2oYTCKOMkeYhjcrFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215711521"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:02:29 -0800
Date: Tue, 24 Feb 2026 12:02:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: gyro: mpu3050: Fix incorrect free_irq()
 variable
Message-ID: <aZ13MhjWl1UAJlap@smile.fi.intel.com>
References: <20260224023511.274038-1-ethantidmore06@gmail.com>
 <20260224023511.274038-2-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224023511.274038-2-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 08:35:08PM -0600, Ethan Tidmore wrote:
> The handler for the IRQ part of this driver is mpu3050->trig but,
> in the teardown free_irq() is called with handler mpu3050:
> 
> 	ret = request_threaded_irq(irq,
> 				   mpu3050_irq_handler,
> 				   mpu3050_irq_thread,
> 				   irq_trig,
> 				   mpu3050->trig->name,
> 				   mpu3050->trig);

No need to cite the full snippet (we may easily open the file and read that),
it's enough to mention like

	request_threaded_irq(..., mpu3050->trig)

or just in free words without any code.

...

> void mpu3050_common_remove(struct device *dev)
> {
> 
> ...
> 
> 	if (mpu3050->irq)
> 		free_irq(mpu3050->irq, mpu3050);
> 	iio_device_unregister(indio_dev);
> 	mpu3050_power_down(mpu3050);
> }

Ditto.

-- 
With Best Regards,
Andy Shevchenko


