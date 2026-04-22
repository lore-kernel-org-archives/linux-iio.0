Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3A346E66;
	Wed, 22 Apr 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889515; cv=none; b=PmJf/xrvHJ09y4KJUUCMwii1mUqGCpR3QRNnddxs66M2OfTa2+A+2ESHZwq4AOM470bp3I0xDykEhTAWl5v4OLo2DBNt3D2UZmkzdj6eSb+6oaRcI2MkFv/3JS/ivU7cO3apAyrfEhb/5C2wBZQlmqIVQ/Kebzt8ytwZ9l3Hluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889515; c=relaxed/simple;
	bh=GpYOFPNHiOrthT2QhxIuN1DShVpLeeiB+wkDzqoFwGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsUc1T8XR1wK9MyddmDwX4UKoZYxUIktLTxf5rYJgCGp2Dqwor2IRp9UAAHL+SZ1TbvaLcvu5wIrPyH7YQesMdFDEUGSzDrgp46uYZY2hvSbyjneHMd0wFDQjSrqMSUQi/1Wn8SJAYRMXC+JhdNMmXmNJYpWC4ziXCMPL8luPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhRWxIJV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhRWxIJV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776889514; x=1808425514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GpYOFPNHiOrthT2QhxIuN1DShVpLeeiB+wkDzqoFwGs=;
  b=jhRWxIJVOcOVPzPNFHwATPWQEwjfIW7MesFEd+XhqLdPuxMRmHhxKmiy
   imccrZMdC/wEmJbfAj2+ZUTlKkwyBycYbqyNCLmiC9Bhktg16Xx+23RVE
   yhk3qPgF7LGCvJScdDB/EYFlKlaXLouPSr1l/Of0vAETMCKTRO4JIBAbZ
   ziIeORH2Iw6C17XeVt9fgoCw2sNEkUUE+bJ9QlHboY3xejYczZFI5I/XD
   moeVrOv9QiKcmV7U+rJSDClXRskLPD1uJmHUPop9hxPqO4x/iGd5bOnIO
   zwGU7gMFw4o29hjI4zVoSxA1rIKB492+UltB16/GskY5t3OrSu7vUQsiS
   w==;
X-CSE-ConnectionGUID: hSOF78nlRFuqoHJohUvKRA==
X-CSE-MsgGUID: iOK8iD4iSPeWxaCmOAM4JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="78039867"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="78039867"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:25:13 -0700
X-CSE-ConnectionGUID: 3l3FowGeSzKAwKNWasZJ2A==
X-CSE-MsgGUID: pyalDTcRT8SO7OWN1AiqCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="262841716"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:25:10 -0700
Date: Wed, 22 Apr 2026 23:25:07 +0300
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
Subject: Re: [PATCH 12/22] iio: dac: ad5686: fix powerdown control
Message-ID: <aekuo0Kn-LEiWn8C@ashevche-desk.local>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-12-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-ad5313r-iio-support-v1-12-ed7dca001d1b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 03:45:46PM +0100, Rodrigo Alencar via B4 Relay wrote:

> This patch fixes powerdown control issues by protecting the cached

Please, read Submitting Patches documentation. It clearly says to use
imperative mood.

> powerdown states with mutex access, and by using a proper bit shift for
> the powerdown mask values. During initialization, powerdown bits are
> initialized so that unused bits are set to 1 and the correct bit shift is
> used.
> 
> Dual-channel devices use one-hot encondig in the address and that reflects
> on the position of the powerdown bits, which are not channel-index based
> for that case. Quad-channel devices also use one-hot encondig for the
> channel address but the result of log2(address) coincides with the channel
> index value.

When I see a word "fix" and no Fixes tag I got confused. Please, align commit
message and tags (either make it just refactor, or a real fix, or explain at
bare minimum in the comments block why there is "fix" w/o Fixes tag).

...

>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> +	int val, shift = ad5686_pd_mask_shift(chan);
>  
> -	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
> -				       (0x3 << (chan->channel * 2))));
> +	mutex_lock(&st->lock);
> +	val = !!(st->pwr_down_mask & (0x3 << shift));
> +	mutex_unlock(&st->lock);
> +
> +	return sysfs_emit(buf, "%d\n", val);
>  }

Why not use guard()() from day 1?

...

>  	struct ad5686_state *st;
> -	int ret, i;
> +	int ret, i, shift;

Do 'i' and 'shift' need to be signed?

-- 
With Best Regards,
Andy Shevchenko


