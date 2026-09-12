Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A12DE702;
	Sat, 12 Sep 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220060; cv=none; b=MfUbBYPQBfVD6omuTyRmmqBUfY50W/YkvGoGdK9PYuafCnCT7QXd/zTy8t/34g5KxgZZ+SD80O5zP/m4a/m2gbaLV5dvAvpJZ7I13ty+Wp7DPVmh3wVCdurw8J4z3Tsv+bFV0rps+21vbBlyDJI7tF8xyFh519JpTjS7FPyTu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220060; c=relaxed/simple;
	bh=uI2lCWjKinwIjNkbZnJCkiN0pNFLG9IVNnoW/AIIabA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlXENT8511lmhw9obU32eeyCb4dzCPKG0f6HFtNxDRkcue6/hFHD+wnHxS2yAc7BmsjVd3mzPdaVDoJAd8mJMCWCylWuvDShOY+O+qQIZc66M2rUjOl/HEBhybMUWmmk7FvrT0ey3hLouxcrq27cv73bh2ARTARxa0lxdgPgXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FU5nUZaK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FU5nUZaK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789220059; x=1820756059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uI2lCWjKinwIjNkbZnJCkiN0pNFLG9IVNnoW/AIIabA=;
  b=FU5nUZaKX9cY4oIaRcgFuRGys9Bn/V0s7jyHgvQfMOgr+oESi/8tBZ56
   PEvIlSuEBLSm54Pr4TOH8S2mVZe/LBJS4sjOn1Jf+5SmDD32PCCq4cOpC
   MR+rcAYn7Hy9Q0+CZIIok+ekuAR/E1zm1yKh3pXGIb3WTLsiF2XTV9aMI
   eqrPR5Qi1hHJeU/O/l4JEeWCg47f6dmUc9gTMZINi2AvudPdujysveAns
   nWCHGk5EzYNTa5fIreCxEpPI1pO+j19BNQvB7Ae8Kee+8aQdVGDqo3g65
   i/sdmWe0rDroC7PskbWDfiZiGpzMsn4/6M6SRn5BnFUENnLLeMKN8MFw4
   Q==;
X-CSE-ConnectionGUID: khb92MqWQUGELUVjOCbIJg==
X-CSE-MsgGUID: qX5crewMRjW2FTIrkWJQ3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="101012558"
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="101012558"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:34:13 -0700
X-CSE-ConnectionGUID: 2+Td6OM1QkugSBdDOgfs5A==
X-CSE-MsgGUID: VwpzJuGpQN2oirhn156mRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="275933395"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.239])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:34:03 -0700
Date: Sat, 12 Sep 2026 16:34:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Cc: linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com, samagazaryan@google.com,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@roeck-us.net, Frank.Li@nxp.com,
	jorge.marques@analog.com, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, lorenzo@kernel.org,
	enelsonmoore@gmail.com, rppt@kernel.org, pratyush@kernel.org,
	giovanni.cabiddu@intel.com, gabewhigham@gmail.com,
	haren@linux.ibm.com, pasha.tatashin@soleen.com,
	jirislaby@kernel.org, adrian.ho.yin.ng@altera.com,
	ustc.gu@gmail.com, jszhang@kernel.org, adrian.hunter@intel.com,
	akhilrajeev@nvidia.com, tze.yee.ng@altera.com,
	manikanta.guntupalli@amd.com, shubhrajyoti.datta@amd.com,
	jarkko.nikula@linux.intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] i3c: add i3cdev character device module for
 user-space access
Message-ID: <aqVUyYkpKT8iX4Jz@ashevche-desk.local>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911210935.1353126-4-meaganlloyd@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 02:09:35PM -0700, Meagan Lloyd wrote:
> The i3cdev driver is a character device driver that allows user-space
> to control and interact with I3C devices.

> Currently, it has the ability to perform Single Data Rate (SDR)
> transfers - basic reads/writes.
> 
> With the addition of sysfs driver_override, there is now a
> straightforward and direct way to match the i3cdev driver to any i3c
> device without stepping on the toes of more specialized drivers that are
> loaded automatically.

Is it safe? Why on the earth do we need this? The commit message has not enough
information.

> This is accomplished by the i3cdev driver not having any entries in the
> i3c_device_id table. After boot, simply set the driver_override to
> "i3cdev" and bind the device manually via the sysfs bind knob. This can
> also be automated with udev rules as well.
> 
> The character device interface will be exposed at:
> /dev/bus/i3c/<bus id>-<Provisional ID>

...

> +	struct i3c_xfer xfer = {
> +		.rnw = I3C_WRITE

In such cases always leave a trailing comma. It will reduce possible churn in
the future.

> +	};

...

> +	return !ret ? len : ret;

My gosh, wouldn't Elvis just work naturally?

	return ret ?: len;

...

> +	for (int i = 0; i < metadata->nxfers; i++) {

Why is 'i' signed?

> +		ret = copy_struct_from_user(k_uxfer,
> +					    sizeof(*k_uxfers),
> +					    uxfer,
> +					    metadata->xfer_size);
> +		if (ret)
> +			goto out_free_k_uxfers;
> +
> +		/* Enforce that padding must be zero */
> +		if (memchr_inv(k_uxfer->pad, 0, sizeof(k_uxfer->pad))) {
> +			ret = -EINVAL;
> +			goto out_free_k_uxfers;
> +		}
> +
> +		uxfer += metadata->xfer_size; /* u8 pointer so use xfer_size */
> +		k_uxfer++;		      /* struct i3cdev_xfer pointer */
> +	}

...

> +		if (!ret)
> +			total_bytes += i3c_xfers[i].len;
> +		else
> +			return ret;

Yeah, you really need to reconsider patterns you use in the code. Here 'else'
is redundant. Homework to understand how (#easy).

...

> +/**
> + * print_i3c_err() - Prints the I3C error encountered during the prior
> + * call to the core's transfer function.
> + * @i3cdev: i3cdev_data object
> + * @metadata: Kernel's copy of i3cdev_xfers (ioctl I3CDEV_XFER input)
> + * @i3c_xfers: i3c_xfer array that was sent to the I3C core

> + * Returns: void

Huh?! Where is this coming from?

> + */

...

Please, rely less on AI and more on the common sense and proof-reading.

-- 
With Best Regards,
Andy Shevchenko


