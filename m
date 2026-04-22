Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD43F1647;
	Wed, 22 Apr 2026 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887937; cv=none; b=mSw/nfyq1x9YFW85YZ98QV2ovIvFdrrarKmCwKi2RnGcl+Ix/4+oHXxyZlHdQWpuW77ye58K2Yzf5ehdbrtGlzUGbBd5Qy5NVSb2+UxmfA47Wf2VKbumGduYDBcJv4BETHqPjpXLWr1PNlB/DU2T8aZhqhXn0GokF1NcuC830RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887937; c=relaxed/simple;
	bh=OOgdRLXHv0BaiUJ6qwPegTgtJyR/wZLtUvvQiS8hoG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrrEZ8/bZ2fizIYxHpE+MkdqMvVTS5DbX0tIglQOv6zD2Ml1MgLDytULz88jFFMVFgU41N2vrb6WOe4PrClJiHzMdzMzrcKGPDBAwIDOGWRDRrMQEP9vn2rMqx0XHC/zkovtzAqhfG71AH0TFglVpyV+e/gkny7tCCbpG9+nA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QlMEoqlA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QlMEoqlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776887936; x=1808423936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OOgdRLXHv0BaiUJ6qwPegTgtJyR/wZLtUvvQiS8hoG4=;
  b=QlMEoqlA83PiPLPEb/NAlaDBOELq5pkA0JW2dINSRGvjXENrJ6ZQww21
   8qGc7PnhByyyWDd8xKXV9Bjv1OFWduwNUVpNZsfTh7HgWHb+aVjrGC3GJ
   jYznjpr5WWVuOKkduN/aWxHUkrBXKR/XL3W5E3W52lLCVvJFqSnDl8x1M
   Ra1uhZspk2B597yQv8Bz/W8CIOju7o0IGugI0FvwwJcJa768Vn1ns2Xbo
   oEJ8S3vsGNLwDilIYocPDoOMf5kMTcwJe2a1CnLoSSZeSawhP/0QJXTNs
   POP2pX7gqfECeX8jB6Wo/CLGseD+2xjjsyY5sS8rwy1mKisa+PoKD3pAH
   g==;
X-CSE-ConnectionGUID: BoTN7UgrTSOkzf9HLMuTgA==
X-CSE-MsgGUID: JK7RLCC7QGyTNtyFoz/bHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="100506140"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="100506140"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:58:55 -0700
X-CSE-ConnectionGUID: TCNRmZsSRhKVCVFHDPVt7w==
X-CSE-MsgGUID: XpV9vZF9Tb+j6seuEwY3sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="232351169"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:58:51 -0700
Date: Wed, 22 Apr 2026 22:58:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Auchter <michael.auchter@ni.com>,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 11/22] iio: dac: ad5686: fix ref bit initialization for
 single-channel parts
Message-ID: <aekoeFYIUMMcKMtC@ashevche-desk.local>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-11-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-ad5313r-iio-support-v1-11-ed7dca001d1b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 03:45:45PM +0100, Rodrigo Alencar via B4 Relay wrote:

> For single-channel parts the control register is used to enable the
> internal voltage reference and perform powerdown control. The reference
> enable bit position was ignored when writing the register at the probe
> function. This patch adds a control_sync() function that properly consumes
> the mask definitions with FIELD_PREP(). As further cleanup, the created
> functions and definitions are also used in ad5686_write_dac_powerdown().
> Some local variables ended up being unused (so removed) and
> st->use_internal_vref is initialized earlier in probe.

...

> +static int ad5310_control_sync(struct ad5686_state *st)
> +{
> +	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
> +
> +	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
> +			 FIELD_PREP(AD5310_PD_MSK, pd_val) |
> +			 FIELD_PREP(AD5310_REF_BIT_MSK, !st->use_internal_vref));

I prefer to see explicit integers in use instead of implicit boolean promotions
in FIELD_*() that might lead to subtle mistakes.

st_use_internal_vref ? 0 : 1

In the code compiler will optimise this to the current state anyway.

> +}

...

>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
> -		shift = 9;
> -		ref_bit_msk = AD5310_REF_BIT_MSK;
> +		ret = ad5310_control_sync(st);
>  		break;
>  	case AD5683_REGMAP:
> -		shift = 13;
> -		ref_bit_msk = AD5683_REF_BIT_MSK;
> +		ret = ad5683_control_sync(st);
>  		break;
>  	case AD5686_REGMAP:
> -		shift = 0;
> -		ref_bit_msk = 0;
>  		/* AD5674R/AD5679R have 16 channels and 2 powerdown registers */
> -		if (chan->channel > 0x7)
> +		val = st->pwr_down_mask & st->pwr_down_mode;
> +		if (chan->channel > 0x7) {
>  			address = 0x8;
> +			val = upper_16_bits(val);
> +		} else {

Would be nice to see address to be assigned here explicitly if it's a constant.

> +			val = lower_16_bits(val);
> +		}
> +		ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
>  		break;
>  	default:
>  		return -EINVAL;
>  	}

-- 
With Best Regards,
Andy Shevchenko


