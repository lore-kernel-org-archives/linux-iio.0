Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A52EF67A;
	Tue, 28 Apr 2026 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374055; cv=none; b=IyHZxDDk66iHlolKI5y9MEXJnocpn/tw4ZT/5JsQQyLMhZKJl29EDNLDpj5YtRsAgeKD1n2GpqcEBup2oT/931Qy/gS8C/Rc+em5XoWh6TqGHSgPhDMZIOZ/NmS98EmOpqSQprkDzXXlbideKwXg0HxAmJHmWQOoNoBvUJ3xUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374055; c=relaxed/simple;
	bh=cHlEm2LXRFnJdXdIprRFm/4WAGHJvXhkcz0IRwlTHE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdXr/IUoO4sPCkaM6zKewH7ZIDS5rCxGjHx8WnE/TbLS7TGhdKpDnNe2gtRmkJOknLRcU9yx9opXZ21JSQ7PdGr3zQW4aKnX53Mh1V61gfCvuKZ0QO2rfKii9PF8sgXsp9LT5gtbEL83LEoS7yn6d7rFdfZtPqxjOppb9Jl6hhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9xxxyGv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9xxxyGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777374053; x=1808910053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cHlEm2LXRFnJdXdIprRFm/4WAGHJvXhkcz0IRwlTHE4=;
  b=k9xxxyGv9D1cYA/1IUca4nDwo4KBh4Z3fJjAvT3vNQij+0sZkaZGTSeA
   cgp2857cXZejel2O1/nprxXw8fy/OwQp0S/tcz/D6etJo7fDzMGT4tJXF
   N5ucBxgkRNf1Bs3u4+APs8LUdpgv4nE7R4H9NFEsShtZKNbeIG6n6iGaO
   9N9YaAfRfyeeTbsyobPTMlM0owDAnk3YYq3IQb9FX6HdB+w42MNArKDLf
   VSflPdyQkBANEdIuYukZ0HYT/XF/bb50s0dMPoUTGknTlMEbaA182UOOZ
   ljx+HvWt30e1B74pAm9iRw6Xyyz5Uenar98N2/6/XI0llHmfakl83e4KG
   A==;
X-CSE-ConnectionGUID: BENmDi9TShyrvz+ykJ3cHw==
X-CSE-MsgGUID: cIOlVDqYSvW1B3MaYTPAyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="80854186"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="80854186"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 04:00:53 -0700
X-CSE-ConnectionGUID: VAyUh35bTPmUlxafc0IKeQ==
X-CSE-MsgGUID: 3s0O00x8SE25z1pxkomXkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="257235122"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 04:00:51 -0700
Date: Tue, 28 Apr 2026 14:00:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: max30208: fix wrong scale value
Message-ID: <afCTYDYCRXoxi37r@ashevche-desk.local>
References: <20260428085415.52858-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428085415.52858-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 09:54:15AM +0100, Salah Triki wrote:
> The driver currently returns a scale of 5 for IIO_CHAN_INFO_SCALE, which
> leads to incorrect temperature readings.
> 
> According to the MAX30208 datasheet, the temperature resolution is 0.005°C
> per LSB. Using IIO_VAL_FRACTIONAL with 5/1000 correctly represents this
> 16-bit resolution.
> 
> Fix the scale value to ensure user space tools report the temperature
> correctly in Celsius.

> Fixes: 9ee95ae4cffd ("iio: temperature: Add driver support for Maxim
> MAX30208")

The tags should go with 1 tag per one (single) line. Do not wrap them.

> Signed-off-by: Salah Triki <salah.triki@gmail.com>

...

>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 5;
> -		return IIO_VAL_INT;
> +		*val2 = 1000;
> +		return IIO_VAL_FRACTIONAL;

Isn't it an ABI change?

-- 
With Best Regards,
Andy Shevchenko


