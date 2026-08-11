Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1435C6BD;
	Tue, 11 Aug 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441783; cv=none; b=CANjL1JzwvCr9tZLyBaP1FowS/SyU6CSGlA+yZHQIt84Macdq3F9E364mLFC1r2Jr7efPl9GMR3/+mx4ntfe3SgyMLl6KHX0wvZVTizyI1XxRxPmDskJp7EsymVU2yX+UC+aDRbxgPvJFA5O/Mvmi89jg8oWWEMElkrtkBsxmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441783; c=relaxed/simple;
	bh=oPz2z8yIjlJHfbmyR4lDTVf62hLM/tzSKPpNWTFdvgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiYGhdQzcX31fqqTwwU6I7ivx+/6KD7de3gvgZE6hz3sd45Oh5S96fnbR/p93Pyq95UeWZaVn0+1yic99LGE4OlybtloUWbMiZQF19NnYSK34FuasV+t4OLHdsdAt0tUTNeX8k7RWmod+17AKU3yPkYsdIPAQekhwkqbuT0BvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvhMLZBx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvhMLZBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786441782; x=1817977782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oPz2z8yIjlJHfbmyR4lDTVf62hLM/tzSKPpNWTFdvgI=;
  b=PvhMLZBx5HcIJkjIw/chXWMlAqUCbypur6IHKlEo4vDGWFDMLMwZN8G1
   MBQFfslMsjToYCeSstOkJQXs9VAT70ywQDfo7QlxczgNIU/SdavAKt336
   BjkMogbq9i7IcJhm+E00UriETbmmrKpUr6wZPPgj2YE093uU2gQB0wKNi
   RVcE1iyXie3pif8+RAEeYshT+wuwLxy03yRRxIePyY200PYZZSdhMI2aC
   IKnWmeDKjmx3AyQEU/+AwF2Sh6YiPEmhNAoPrBiTTrIBu1WV+N3sA9VkT
   Jipbct9ispaKBt+TaLMpeoVYNcv3w8xmz/GY7TwTAh4l7tyjfKsN1Ys2U
   w==;
X-CSE-ConnectionGUID: bhB2UFrxQE66omFK2Kil+Q==
X-CSE-MsgGUID: j5WTf9W6TMus1/R0J+X8EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104500483"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="104500483"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:49:41 -0700
X-CSE-ConnectionGUID: NgiTkreUQVmmxyuQkfhcDg==
X-CSE-MsgGUID: FgU6spPeTBq1+VKk1c6ADg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="257082719"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:49:39 -0700
Date: Tue, 11 Aug 2026 12:49:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: add shared IRQ support
Message-ID: <anrwMci5d2VW56-X@ashevche-desk.local>
References: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
 <20260811-vcnl4000-v1-2-50e7fb657692@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-vcnl4000-v1-2-50e7fb657692@jacques.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 05:07:25PM +1000, Tsz Shan Chan wrote:
> Use the IRQ trigger type set by firmware instead, and fall back to
> IRQF_TRIGGER_FALLING if no trigger type is specified to maintain current
> behaviour.
> 
> Support IRQF_TRIGGER_FALLING and IRQF_TRIGGER_LOW, which match the open
> drain active low interrupt output. Reject unsupported trigger types.

Can you elaborate with the reference to datasheet if the HW support this
type of IRQ? In such a case, how does HW know which type to trigger?

> Request the interrupt with IRQF_SHARED, and return IRQ_NONE in the irq
> handler when there is no interrupt pending.

...

>  	ret = i2c_smbus_read_word_data(data->client, data->chip_spec->int_reg);
> -	if (ret < 0)
> -		return IRQ_HANDLED;
> +	if (ret <= 0)

I haven't seen mention of this change in the commit message. Is it related
somehow to the trigger type? How?

> +		return IRQ_NONE;

...

>  	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> -	if (ret < 0)
> -		goto end;
> +	if (ret <= 0)
> +		return IRQ_NONE;

Ditto.

>  	isr = ret;

...

>  	if (client->irq && data->chip_spec->irq_thread) {
> +		u32 irq_type = irq_get_trigger_type(client->irq);
> +
> +		switch (irq_type) {
> +		case IRQF_TRIGGER_FALLING:

Hmm... Do you have a case with edge sharing interrupts IRL? I think it's
a brain damage setup if it exists.

> +		case IRQF_TRIGGER_LOW:
> +			break;
> +		case IRQF_TRIGGER_NONE:
> +			irq_type = IRQF_TRIGGER_FALLING;

Ditto.

> +			break;
> +		default:
> +			return dev_err_probe(dev, -EINVAL,
> +					"unsupported irq trigger type %x\n",
> +					irq_type);

Broken indentation.

> +		}
>  		ret = devm_request_threaded_irq(dev, client->irq, NULL,
>  						data->chip_spec->irq_thread,
> -						IRQF_TRIGGER_FALLING |
> -						IRQF_ONESHOT,

> +						IRQF_ONESHOT | IRQF_SHARED |

Also assign these above in a separate line, so this will be just irq_flags (and
name it irq_flags as IRQF_ stands for).

> +						irq_type,
>  						"vcnl4000_irq",
>  						indio_dev);

-- 
With Best Regards,
Andy Shevchenko


