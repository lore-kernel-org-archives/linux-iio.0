Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578887;
	b=HpQCBN9XZG1RjRLBoscMIszEd95i/p34vYSqP+M6KGdcn3LqDmtnPX+sNwpAvM3oKqUB
	 INUTL6ZDiAfjU7N0CmxGlbPbjhcWzMPmwDEYtvlYTVwLrXqGE6JuYsnlU1h2akxaw9w88
	 XUb988Kir8Q7tHiwd5ewdsA+07+1OxDTWvxuGyLEmM1i8zMEW51MRGBZi5WIvWMNct2EU
	 XdVLY5s4EMU4V6AY+UvYbKUdUvlLBfsW6x4TFvKqkckjCyJPPaaPZL81Ry0P92673LS8i
	 +nnQesUQ5YjJhpW82sH1YoDX2r8EOGSEleo1re8KBtjpxRlCkso+3+Fx9MjXhsg3cgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578887;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=n7cVia9sMCuK38IPq0c2Vj047wAgXP1lK8/kz0AS6VY=;
	b=Q28mh2ZrkAV66pH3Oh7RwS7Dg0K0SwOVE01a2XHtxG1W3eAmDYUNJKg7Ln7eMUK6YWw3
	 S8/BOO8eaYiZ6Uo/FGg45fuktzv5zeruDMIC42o4kJ4vAHZvmK4l1bUjRqm280MYgMMAm
	 BZMZF4gEhldpguWnDBmhhHq2c9kiSYTTT/iqTvsqOIljhrk0Ys08tU0BuigGQydqKyfmm
	 Z5Zcc28yt1Pf7GqA395aMsUSYmo++c4LOOvDalCauqsYOoFdMDyc3PKXI9VPluldvDJ3Z
	 WkG2oIH5HD9uvhKJbqXaqyFi2zUkygOI1sRJevoL8pNs97n21QHIbt1F/4fh6pffxUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CWlte0AN;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A748606A323;
	Fri, 13 Nov 2026 14:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A748606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CWlte0AN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794578887; x=1826114887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bhznoLiBqCl32w7oDyhSSediGWB4SNiiwODIA4P/vmo=;
  b=CWlte0ANEODbPz5wWin/8WWTFUlhORPogNwA5gcPaiXpTqD89IwkBo2u
   svXxfoNUrUuOJT5PHUtSk3uPgu7KtwnyRXlb/ZGITzsO6yKBbgVoojYXN
   /NACReiy7DKBNkXI41l6QcDFo0RD/ib4N/F6UZbH0Jrfuf7k5Hocq3sBE
   Jf8VPGWHg2/khf8DxF/f/VYYTbA/SchOfOCLDOmOTOrVPELOQ2769W2zU
   FeS+ajsODT2PdLTUrxB/iJZK9AZxr9rBQNDKaYCytY3tGS9xi0XyjZePX
   cyLs0f243c9j0y21StiYtxUkrOFY/4ArIvAicAPx5ldE/hEi1CsupNuzq
   A==;
X-CSE-ConnectionGUID: icMUxm9yQBufp4EJte2f/g==
X-CSE-MsgGUID: dDqFtO0gSZCWBeS4TSUh9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3269812"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3269812"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:08:06 -0800
X-CSE-ConnectionGUID: 9N6ttaSDTv2JjFfr2B3SqA==
X-CSE-MsgGUID: deacJUKmTWOJlI4xNenDLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9014490"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:08:04 -0800
Date: Fri, 13 Nov 2026 16:08:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	crofts@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: temperature: mcp9600: Avoid overflow when
 scaling thresholds
Message-ID: <avcZwcY8HQrUjbF5@ashevche-desk.local>
References: <20261113080558.173889-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261113080558.173889-1-zhujun2@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:04:56PM +0800, Zhu Jun wrote:
> mcp9600_write_thresh() scales the integer part by 1000000 in int
> arithmetic before clamping to the supported temperature range. The
> multiplication can overflow, so a request such as 3000 degrees can
> select the lower threshold instead of the upper threshold.
> 
> Cast MICRO to s64 before multiplying so that scaling and the fractional
> addition or subtraction use signed 64-bit arithmetic. Let the existing
> per-junction bounds clamp the result. Use MICRO consistently and use
> div_s64() for the final conversion to support 32-bit architectures.

...

>  #include <linux/interrupt.h>
>  #include <linux/irq.h>

>  #include <linux/math.h>

This can be dropped now as it's implied by math64.h.

> +#include <linux/math64.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
> +#include <linux/units.h>

...

>  	struct mcp9600_data *data = iio_priv(indio_dev);
>  	struct i2c_client *client = data->client;
> -	int s_val, i;
> +	s64 s_val;
> +	int i;

Please, keep the reversed xmas tree order.

>  	s16 thresh;
>  	u8 hyst;

...

>  		/* Scale value to include decimal part into calculations */
> -		s_val = (val < 0) ? ((val * 1000000) - val2) :
> -				    ((val * 1000000) + val2);

> +		s_val = (val < 0) ? ((val * (s64)MICRO) - val2) :
> +				    ((val * (s64)MICRO) + val2);

I think we can avoid casting by doing

		s_val = val < 0 ? -((val * MICRO) + val2) : ((val * MICRO) + val2);

>  		if (chan->channel2 == IIO_MOD_TEMP_AMBIENT) {
>  			s_val = max(s_val, MCP9600_MIN_TEMP_COLD_JUNCTION_MICRO);
>  			s_val = min(s_val, MCP9600_MAX_TEMP_COLD_JUNCTION_MICRO);

This is also clamping.

...

> -		thresh = (s16)(s_val / (1000000 >> 4));
> +		thresh = (s16)div_s64(s_val, MICRO >> 4);

Do you need casting here?

>  		return i2c_smbus_write_word_swapped(client,
>  						    MCP9600_ALERT_LIMIT(i + 1),
>  						    thresh);

-- 
With Best Regards,
Andy Shevchenko


