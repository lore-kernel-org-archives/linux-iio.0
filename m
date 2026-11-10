Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304689;
	b=kSJhVDKq2BkTmjNWmMSBbUeh9JWf6YQ9Uk0PC3oEyM8vlrKjNzrDBjyOjOFDOgdxQ5ib
	 Z+XsWYtJeC96jdJ8xAz71cOtTJDM6xzfI4R9zMsRHblm71sDtKB9Uci7kQQ9vAIrKDHkz
	 OgUQeJ8dLTXbnPBed5qmGltaJzxBHp8R108qwswrE5XmAvYAmwKbKMQxcU5AmLMWbItKk
	 eLa9eBvys1d7kl2hg+UCTZLWVwfLb4N6F9AnCNThzb64m0ubt1XmVZFmd5QmEvhBQ7Z0E
	 gN5lGtgWoQ9WldXs/Z2CNctaepM1xJmvG9q3vxpGQB+PDyQVQRte7IQzI7kcuvdyeNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304689;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=INGqzLdDhKQ8KqZLVYVuAJJweNcsIc9aGsEAGXCLg1g=;
	b=pFgy/1ORh9jI48OQnhRpYTqks5pq9dMiuSczB4c0moDazW5U7ZxtF9eGpMjy0hLJ3sEJ
	 JICuECC953pQ9Hgv4V+DmtRfgLSYr2Avc7GIXQ9KOIzqlb/u4JAVC8iXX7WFcUF3JUpHr
	 /Ub1lnZ8XP0z9c5W0+No0XzLYEmax1fFuT9Xa/r76bBSiUIc0uwwJIizCpYf6PQZIRsVz
	 P/CBX/xHg3SS7dQkJh+rDnXV0gwHoi/SAVhlQsrywJCNmsDmp5MPoSR+eHKDfGym4LqHs
	 E3/AFd/eoPUJ2QjR9dP3vMOBXND5IS9zpi4O/zfqAr2MmROch2BUA87y5lDRbhs0RDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AxiDXiAR;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225B606A31C;
	Tue, 10 Nov 2026 09:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5225B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AxiDXiAR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794304688; x=1825840688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QzPT9tGZvqRrW4sh2AHvUOUTAy1to+OE31K7C7vVxy8=;
  b=AxiDXiARsmpATPxJntkuphhGFuqjN7E8pCAXs/hQbF9rhaCOHTj0aYHO
   L7L3yMfP0WKDKxfsZBliBS4mn8On9ECI5NIZW3tST6aPxjbnXBXb2gH3e
   i15aJ3oPyEG4nav3kZ77oY7vnoO+OzH0tykWnfHD3uWyCh7DsUDBg9Ahr
   FBfNjkuC80aRZyCw/1Ei5wWQ4LFQSJLTDsIik4FuugZ5pGMIlW0CguitB
   IEr1cyWq1/Bi0vd0NCO155jcKI28dSlgyf8pxZ8PqpclVi6wFjJXMBESF
   3rodqtR9b6QD5SqTGhibclAAJSqsRiydb36asegl2Q1JAsbfP9hwbjfB8
   A==;
X-CSE-ConnectionGUID: I0rWP8pCTIqNQWZD3Fo1+w==
X-CSE-MsgGUID: /VyXWmN2Q7eVvnrOzeJDNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2923990"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2923990"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 01:58:07 -0800
X-CSE-ConnectionGUID: 4F1gYNVgT5G65fwPgWwEFA==
X-CSE-MsgGUID: UKagX4nSQUCGidoeHdE5uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8256232"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 01:58:04 -0800
Date: Tue, 10 Nov 2026 11:58:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: at91_adc: move to devm_* to fix NULL
 pointer deref
Message-ID: <avLqqS_9KcSdVvc2@ashevche-desk.local>
References: <20261110092848.141854-1-abdelnasserhussein11@gmail.com>
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
In-Reply-To: <20261110092848.141854-1-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 11:28:48AM +0200, Abdelnasser Hussein wrote:
> If 'atmel,adc-use-external-triggers' is not set in the device tree,
> at91_adc_trigger_init() leaves the external trigger slots in st->trig
> as NULL. The error paths and remove function unconditionally called
> iio_trigger_unregister() and iio_trigger_free() on them, causing a
> NULL pointer dereference.
> 
> Instead of just checking for NULL, refactor the driver to use the
> device-managed (devm_*) API for registration and allocation. This
> modernizes the code, eliminates the need for manual cleanup functions
> (at91_adc_trigger_remove, at91_adc_buffer_remove, at91_ts_unregister,
> and at91_adc_remove), and inherently fixes the NULL pointer dereference
> since the core handles the cleanup of properly allocated triggers.
> 
> As part of this simplification, the remaining trigger initialization
> logic has been inlined into at91_adc_probe().

...

> static int at91_ts_register(struct iio_dev *idev,

>  {
>  	struct at91_adc_state *st = iio_priv(idev);
>  	struct input_dev *input;
> -	int ret;
>  
> -	input = input_allocate_device();
> +	input = devm_input_allocate_device(&pdev->dev);
>  	if (!input) {
>  		dev_err(&idev->dev, "Failed to allocate TS device!\n");

Side note:
This message needs to be killed, we don't print -ENOMEM errors.

>  		return -ENOMEM;

>  		if (st->touchscreen_type != ATMEL_ADC_TOUCHSCREEN_4WIRE) {
>  			dev_err(&pdev->dev,
>  				"This touchscreen controller only support 4 wires\n");
> -			ret = -EINVAL;
> -			goto err;
> +			return -EINVAL;

Another side note: this should move to dev_err_probe() (along with similar
cases) at some point.

>  		}
>  
>  		input_set_abs_params(input, ABS_X, 0, (1 << MAX_RLPOS_BITS) - 1,

...

>  static int at91_adc_probe(struct platform_device *pdev)
>  {
>  	unsigned int prsc, mstrclk, ticks, adc_clk, adc_clk_khz, shtim;
>  	struct device_node *node = pdev->dev.of_node;
> -	int ret;
> +	int i, ret;

No, don't add it here as it's local to the for-loop.

>  	struct iio_dev *idev;
>  	struct at91_adc_state *st;
>  	u32 reg, prop;

> -		ret = at91_adc_trigger_init(idev);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
> -			at91_adc_buffer_remove(idev);
> -			return ret;

> +		st->trig = devm_kcalloc(&pdev->dev,

Add at the top

	struct device *dev = &pdev->dev;

and use in the code you modified or add.

> +					st->caps->trigger_number, sizeof(*st->trig),
> +					GFP_KERNEL);
> +		if (!st->trig)
> +			return -ENOMEM;

> +		for (i = 0; i < st->caps->trigger_number; i++) {

		for (int i = 0; i < st->caps->trigger_number; i++) {
		// align the type of i based on the type of trigger_number

> +			if (st->caps->triggers[i].is_external && !(st->use_external))
> +				continue;
> +
> +			st->trig[i] = at91_adc_allocate_trigger(idev,
> +								st->caps->triggers + i);
> +			if (!st->trig[i]) {
> +				dev_err(&idev->dev,
> +					"Could not allocate trigger %d\n", i);
> +				return -ENOMEM;
> +			}
>  		}

-- 
With Best Regards,
Andy Shevchenko


