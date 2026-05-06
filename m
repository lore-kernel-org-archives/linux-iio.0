Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FFB3EDAAD;
	Wed,  6 May 2026 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061115; cv=none; b=CecYMOQYAUpAmsoHEEfQiK8qpgEQ0oVOWhy3+y3ygzYc4EfRyvt7SKKSO8gNyIrSoIu1bID+C83l4B1giCWKitj01TKGBadGlqq/1pahKjXTky49okGJ/03kQkLak+hXEH8VELBzncojVMeX/p3yW/DQ0oRu6kqfqIgAuQYHqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061115; c=relaxed/simple;
	bh=4IkWzT5qzevj0ZAcc4KqL76bMrVgRUKbFD/1Mzumk1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaSVPLTXKTwBhSbcEzKNL2i215nBQsKmKcm4Xc/UKpbz41A88xenPoV+eYqs8Enaj6cA22OdAtOWZacv80dCKomFCOeJAJ2TkzzbcuZ2iuihS/EKtQDR6WNKYxjrPCQiKeC4hNM6xRFLU7ggNG6e7vPYelC6au9cajGinXVSr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgOCUkKf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgOCUkKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778061113; x=1809597113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IkWzT5qzevj0ZAcc4KqL76bMrVgRUKbFD/1Mzumk1Q=;
  b=RgOCUkKfOZ2DUuOhol5NnOe4gqq8lZft5OZ55hIY5axqjAkjDPfIDDuZ
   zky3Z/XVWZT68bLnKjWZx63RVQ4Pe+zICO45N+49WBIimb/qerEbNoze0
   5A8abOfh04crqZ/SHQy+A6NfFcdw/Zt5H8AIzBaJMOCmLHOGY9xYJ+q7m
   /U+kMjYgzl0kwzt0HKyKM8IL7Y24zLb35sdt/pMGfyZRvE/IdQ78IAAxx
   gv2axoC4uBT1smLhe+RXaocdj0bSk3pw/FzQC2/fPcfzfyXrTE+EBWMyh
   0ryv6EzaGRgLNtXReE90yCiEKbaktYgp5eJpWsaZqiCW1Z2zLHKd8/p3b
   w==;
X-CSE-ConnectionGUID: /Yx36mR9TkaMdLbpnCV+yA==
X-CSE-MsgGUID: jNf+zbfwQ3W1WelZf7OOTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82856064"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82856064"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:51:53 -0700
X-CSE-ConnectionGUID: BfUpmPsrRLe6eWvzGNkEZA==
X-CSE-MsgGUID: IfS96DxBSUm3QAmLjgvtbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259791590"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:51:50 -0700
Date: Wed, 6 May 2026 12:51:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <afsPNMHwjNrY1N66@ashevche-desk.local>
References: <20260506094629.8999-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506094629.8999-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 10:46:29AM +0100, Salah Triki wrote:
> The ENS210 driver uses SMBus transactions (such as byte, word, and block
> data reads/writes) during the probe and measurement phases. However, the
> initial functionality check only validated a subset of these capabilities,
> which could lead to loading failures on adapters requiring SMBus
> emulation or native-only controllers.
> 
> To ensure compatibility across a wide range of I2C adapters, modify the
> functionality check to verify if the adapter supports the required native
> operations or, failing that, supports the SMBus emulation layer.

...

>  	if (!i2c_check_functionality(client->adapter,

> -				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> -				     I2C_FUNC_SMBUS_WRITE_BYTE |
> -				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +				I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +				I2C_FUNC_SMBUS_WRITE_BYTE |
> +				I2C_FUNC_SMBUS_READ_BYTE_DATA |
> +				I2C_FUNC_SMBUS_READ_WORD_DATA |
> +				I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&

No, the above is FINE as is, you need to adjust the new added lines
accordingly.

> +	    !i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {
>  		return dev_err_probe(&client->dev, -EOPNOTSUPP,
>  			"adapter does not support some i2c transactions\n");
>  	}

-- 
With Best Regards,
Andy Shevchenko


