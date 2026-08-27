Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2F332615;
	Thu, 27 Aug 2026 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814327; cv=none; b=oGUroaBZXfTJW97Xi2cDLsTNGFhWh698G/ax4InwLnXR31UbTkd8grISsb6UpJI6tPywmd3YdhzRbKYDJSRym/WuoPLZZaz/WD5I8keWibGLfFaVpgrq4cA9QUGd1gs7aXRz32JJ8Kk+G5nSSy4WfntzGZvqDaPAgSRz9p5SzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814327; c=relaxed/simple;
	bh=+r9mEjlNZ0g+i2JYBEDW6avkvezIwKOf1doASyqzTA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0CIQ/RytGO8Ru9+1XdLzrylQL1CS8wqP9e5YfjLYB6Wifs5MVXrFvL7XDWcqQ5l6RHB2lb0frGo+rsNA8cV7NS/XIXlXbWDj5XfiKU/ZZJ0R7FCtnfdh31BAbMG8QT1mRpopQCy2zhGdwIhh3a18FGk16Ifikzg6WOlu5psrrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVMw4U82; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVMw4U82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787814326; x=1819350326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+r9mEjlNZ0g+i2JYBEDW6avkvezIwKOf1doASyqzTA8=;
  b=DVMw4U82gf+899Fe9e8e6JM3sq8VIj8tigC4Rg1k87al4hj9v1p70Hfx
   byOWzBoFoVx4EjvSaoG2ZWOD5xxYlIsmD4pxJdEBgW+M+V8ljycQIQTAQ
   RqRRXEvFbNCN2q3j96amJwOlaEm6M/np7QdSR8hhiwjE3vqSkoMJ3aTUZ
   cCEMX9lT4NPXUJXfH7H7Y7W11e3tXFSIXEizjRmNCFLSzLPvA4QzbpxLO
   y5eYyd1nkLWGuNBok1218eD8HFvv4HUAkAIeCCs2Yhl/t239XF/t2q/Xg
   2DsQoapeWewvtd7P5PsOx1BKqjhJfeaLfA1pNn6Bya6NtrXca8dgWeVH+
   A==;
X-CSE-ConnectionGUID: B6QPxtwvS2mOEC3GXHhnig==
X-CSE-MsgGUID: O6fbMe6pTPiYtzeFrBRprQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88071160"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88071160"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:05:25 -0700
X-CSE-ConnectionGUID: kyN3eVXuQ2iWhD6Sgj/WVQ==
X-CSE-MsgGUID: HsHMs/ogQhuXmxhDOqbHng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="267827068"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:05:22 -0700
Date: Thu, 27 Aug 2026 10:05:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, grondon@gmail.com, linusw@kernel.org,
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: accel: bmc150: use DMA-safe buffers for
 regmap bulk reads
Message-ID: <ao_hr-0BelQWI27t@ashevche-desk.local>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
 <20260825085156.212042-3-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825085156.212042-3-yashsuthar983@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 02:21:55PM +0530, Yash Suthar wrote:
> The FIFO and read_raw buffers are passed to regmap bulk/raw reads,
> which is not DMA-safe. Moved them into struct bmc150_accel_data
> after scan, each buffer are protected by mutex, placing them
> after ensure DMA safety.

...

>  		j = 0;
>  		iio_for_each_active_channel(indio_dev, bit)
> -			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
> +			memcpy(&data->scan.channels[j++],
> +			       &data->fifo_buff[i * 3 + bit],
>  			       sizeof(data->scan.channels[0]));

While this works, I find a bit confusing usage of [j++] and [0] together.

IIUC the below is an equivalent

		iio_for_each_active_channel(indio_dev, bit) {
			__le16 *val = &data->scan.channels[j++];

			memcpy(val, &data->fifo_buff[i * 3 + bit], sizeof(val));
		}

and if go further we may use asm/byteorder.h macros instead of plain memcpy().

...

Maybe this is for a separate change, I dunno. I leave it to others to decide.

-- 
With Best Regards,
Andy Shevchenko


