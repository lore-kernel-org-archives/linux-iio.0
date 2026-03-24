Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D87275AFD;
	Tue, 24 Mar 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354637; cv=none; b=VGXYdS0lLvmoYjaPArl6OwYCZ4NVzgz4dOm45+AkEL4AobJYhc4HAlvqOp7UWf8D9k09gnEfluoS0diH84E8PApp/iq/YK/RldmVEZOPb3oAG1r1VVv3S0dZ0dsrMEuEj6jUSxAGb4dqoOlHo/b2UFGujB/XS+/XyAAAGHiAOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354637; c=relaxed/simple;
	bh=EeNKUcc+UstYrxCT3YVrGgDkq/aCvxIDxvmk7IPO/os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmUDyA2BFfXUs2Q0FymZIGGLdwIWj70kQ+rln1aqx/+8bs4ELDytkyzQgk/K0zToXG0VFcgzmN4Ro/XjVsJvmGLOeL73+evpHHleoKoGggOXAwErGw/xVpARdlZQOcOxAFnEJPCwdWeVWjy5YIDpDTJYeK5jY0OVNZIs4Wy86C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cg408YMX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cg408YMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774354636; x=1805890636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EeNKUcc+UstYrxCT3YVrGgDkq/aCvxIDxvmk7IPO/os=;
  b=cg408YMX4By9+63aoJfmmkfuwDxXl3j0iWnRnAsIYSMMogVCOkuCOiUp
   ImLmcLXn91KPkr1YmsieQ9uUYZStiZHx3o6HKkWOGuWfZhGi41DqoxpBo
   iynggYYzMAAeKHyKiysny/d2mLJROol7k7Fs4YMmCho2okmSYSizTE8rM
   IBRc6/W01Wkxk3FEQnQlBfy68ISESN8RXQ3hpu8aAVDD3jHVMQRy/R128
   a/L2LTTzTRepRYUgKqdbRSQIB8uQ+jbvIimsfQ/DARM1t48FV0a36ycw4
   J+V6MLKHLQNHFA0F8eXdpIqAjs6bQgcNdjuIb2QrsdvsGQXBpYJSjdXlV
   g==;
X-CSE-ConnectionGUID: 62yh7g+uSSmyW82F935OBQ==
X-CSE-MsgGUID: qsvdrqr1Q/mOhlsj5NQygg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="92746740"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="92746740"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:17:15 -0700
X-CSE-ConnectionGUID: JpPVZz7KQQ+HW3YlnhqMww==
X-CSE-MsgGUID: x5pr3EyXS2Wwz6DgRxv/Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="217760557"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:17:13 -0700
Date: Tue, 24 Mar 2026 14:17:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/6] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <acKAx34s1MStfy3G@ashevche-desk.local>
References: <20260324084655.653781-1-flavra@baylibre.com>
 <20260324084733.653906-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324084733.653906-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 09:47:33AM +0100, Francesco Lavra wrote:
> The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> accelerometer invalid samples (i.e. samples that have been acquired during
> the settling time of sensor filters) with the special values 0x7FFFh,
> 0x7FFE, and 0x7FFD.
> The driver checks FIFO samples against these special values in order to
> discard invalid samples; however, it does the check regardless of the type
> of samples being processed, whereas this feature is specific to gyroscope
> and accelerometer data. This could cause valid samples to be discarded.
> 
> Fix the above check so that it takes into account the type of samples being
> processed. To avoid casting to __le16 * when checking sample values, clean
> up the type representation for data read from the FIFO.

...

>  static int
>  st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> -			    u8 *data, s64 ts)
> +			    __le16 *data, s64 ts)

Dunno why this indentation, but if you need to send a new version, consider

static int st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
				       __le16 *data, s64 ts)

OR

static int
st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag, __le16 *data, s64 ts)

(yes, the second one goes to 83 characters).

-- 
With Best Regards,
Andy Shevchenko


