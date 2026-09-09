Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EB566C73;
	Wed,  9 Sep 2026 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962706; cv=none; b=cFM17qk+zWMG8okQAs3Vb0thLeha+y73LjLGeWj6u5+jr6A4vj0Mn9opwldgigNOmVV7KQD+ribDFliuzgiZKU/MWNnrshiCR7OrNdVyt7TVr+TKydsUrcHrMeHehZE4OocEqjjFoJWiGCAVY0Xf53YmeNiJSBhMPljPgSTCjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962706; c=relaxed/simple;
	bh=WzLzZPMN7mAi35vrn+vRGzHIt2lcUU7JxPWDYVyUTEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAk/wZRPi9QfSdTywEvMuKeAsKsp4I1/n+li6AgBAFT8CUPuki2U/wxpk+zt5OaVv7CpXJi9CWhzJKoONoBy8oWZ50ZYxH4IVkm99X5+lLA6OJZt8AULbSZyvMhwjrUKEzZlt+f5vDZbLGBHvbu6X7Y/q6qt8ZUkan/ACaECJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLBjizof; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLBjizof"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788962705; x=1820498705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WzLzZPMN7mAi35vrn+vRGzHIt2lcUU7JxPWDYVyUTEI=;
  b=bLBjizof7jxRZdCBsjRx+Sdk2rV1jnaWkZ4YMMTnUEWfHJOMZTSaNISE
   gTGM+pwCmdSn4O9JjKRe5yxVvY/emKHx2LzmcRc5+/+NFEx/0kfJBM7aV
   N/a1TOzCgRUx0Jfle2Pwg9ZYW3j2N3pOkRuY3CH589i224V7fwThiuHrE
   IHESQdcGyPLqbhyjrRv9+8PmvTU18F2jL+WVgQME7sh4jmwjTvrMzCbTk
   mIwumbk/FOgJW4MCoiLI8NcX6rYjvoG6frY46VjxAJId7TiZfCrjYtuNc
   2gWnikxP6GhzTtGpUutki1kUEXJr8KBkV5kTM2NEweifT3SSSIdUBVcxG
   w==;
X-CSE-ConnectionGUID: DM7h5nW1TxWTRkbsGyBqsw==
X-CSE-MsgGUID: d7dVa/jWQHCY3yG9N7N8EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89514495"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89514495"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:05:03 -0700
X-CSE-ConnectionGUID: Vt1dy3sZSVGXy6tfENw/5Q==
X-CSE-MsgGUID: 2rIUlRd6SYymIoS4LJH5qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="268750689"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:04:59 -0700
Date: Wed, 9 Sep 2026 17:04:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: ltc2497: add 2x conversion speed mode
Message-ID: <aqFniZF6CrYXnPjz@ashevche-desk.local>
References: <20260909082755.366269-1-andrei.stancovici@analog.com>
 <20260909082755.366269-4-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909082755.366269-4-andrei.stancovici@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 11:27:52AM +0300, Andrei Stancovici wrote:
> The LTC2499 can convert at twice the output rate by disabling the offset
> auto-calibration.  Expose it through sampling_frequency and
> sampling_frequency_available on the voltage channels.  The part ignores
> the setting while measuring temperature, so the temperature channel does
> not carry the attribute.
> 
> The wait before a result is read is keyed on the conversion currently in
> flight, whose duration is fixed by the mode that was active when it
> started rather than by the mode just selected.  Otherwise the first read
> after a 1x -> 2x switch can reprogram the part while a 1x conversion is
> still running, which the part NACKs.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +LTC2497_DEFINE_CHANNELS(ltc2497core_channel_samp_freq,
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ));

I believe having this on a single line is fine.

-- 
With Best Regards,
Andy Shevchenko


