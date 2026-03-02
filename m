Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D47A35AC2A;
	Mon,  2 Mar 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457210; cv=none; b=Jd1LpSp4uv5p52rWII6Sr/wClcM9KCBywPSezrWGXGIMxhwcHXqmLmdcFVpP5fLX9PaaRgLYfwA6Za0civF5VvFXkERZcrDMtWi4Hd6ZH++g8kjtYgPGEi34F3DjEPTu10dPJ5/5FBF9Wk5kh+e7KP+EUU5rpDwESbcaPpgtxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457210; c=relaxed/simple;
	bh=jonLXlS3nkJ67zur7OggV7pwpTPklMSO4m7JNHmfVvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laINji1x19tdXrvbqjwE1Wem94VXYXhQeIPA2eHI6NN4bw7brosmdEpPI4OH+kP2nAGfRrqerQoFWaBwyJpxO55ig6ewwsHlgbrDT4nIeA4JfEwRAQinx0ksGdkaSGwBWr91w16V3A5oc1qB0wZ+gTX8qTQUcqGH2bJuEQTodTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExN7Exy7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExN7Exy7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772457210; x=1803993210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jonLXlS3nkJ67zur7OggV7pwpTPklMSO4m7JNHmfVvg=;
  b=ExN7Exy7bRfgq+PH6wdn7Nqq6uS6+iERhaHqJh1ov0tDx2rdvD7XlbKT
   I0l2njKl/XuFuWv7fHM86l6k792bT4P9RqaHfQGbU/dm0VAQ70S0QnW52
   GgKJd/nME+WsL68DFqJkSms4JA13DrhHSqyAlzPrvkOJzSh/EqGWH37zy
   wR5wLmCY8Zr6k/uCa4aoPSi1QbaHRJJ7RwyDrvJmD5SRLjRffKGZm0rlS
   qiz7ITTkd0vT8E3j6ZUZkubyxWFi7Tp2hhWTwzsOXVNRM2zcw9nPvdmw0
   EJ8zls+sp9DIfEkWMEFdEOqc+g+7zYSFx0kiJqESN7hPn5fYEbkOAq0Zg
   Q==;
X-CSE-ConnectionGUID: YwmzzvaySDe99tXUiByj8w==
X-CSE-MsgGUID: Ak9TJuHKT+yUY8kNnn3T7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73164808"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73164808"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:13:29 -0800
X-CSE-ConnectionGUID: kl3y2uhUQVCTG/RwAofYGw==
X-CSE-MsgGUID: d/MSyCDqT3+Ay17f3qohjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="214122539"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:13:26 -0800
Date: Mon, 2 Mar 2026 15:13:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: adc: ad799x: cache regulator voltages during
 probe
Message-ID: <aaWM9Csvbj6hXW8n@ashevche-desk.local>
References: <20260302130632.29144-1-architanant5@gmail.com>
 <20260302130632.29144-3-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302130632.29144-3-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 06:36:30PM +0530, Archit Anant wrote:
> Reading the regulator voltage via regulator_get_voltage() can be a slow
> operation. Since the reference voltages for this ADC are not expected to
> change at runtime, it is inefficient to query the regulator API every
> time userspace reads the IIO_CHAN_INFO_SCALE attribute.
> 
> Cache the VCC and VREF voltages in the state structure during probe().
> This improves the performance of ad799x_read_raw() and removes the
> dependency on the regulator pointers during fast-path reads.

...

> +	int				vcc_uv;
> +	int				vref_uv;

_uV in both cases, please. It's a unit suffix.

...

>  	case IIO_CHAN_INFO_SCALE:
>  		if (st->vref)
> -			ret = regulator_get_voltage(st->vref);
> +			ret = st->vref_uv;
>  		else
> -			ret = regulator_get_voltage(st->reg);
> +			ret = st->vcc_uv;

>  		if (ret < 0)
>  			return ret;

Isn't it a dead check now?

-- 
With Best Regards,
Andy Shevchenko


