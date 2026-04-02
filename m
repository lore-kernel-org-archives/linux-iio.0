Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE203EE1DD;
	Thu,  2 Apr 2026 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146456; cv=none; b=Giv2RHsETTjpf6jz9uhK3kcXCX4Eac9iiQh6A1GrKcQVLLXnHF0OWeBYlltUTXgkexqEIcBg5NmHkOLt8Buue1Xucy52bciwXGDe40Kan7KRcVzNM0lKycJ9mwbuQE0oqVLAZTzNFf0YggBD5hNYqDPszkyuCzCtoyU/lET0cMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146456; c=relaxed/simple;
	bh=NNCjv2ZdmVCtPsLbi5cpk/LVnlCg2htihlVU122tBWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVriLKwwFfS7B3pBzVQLI0gV6LNfI77tD4/tjvhHd/Plt5WUJa5cQuaA7GSyS7rzARUTxnKPVHkBpHr10QCptcKNGtESrJO603DJF27OfohXNIjC+8C8JFBrEuU0EUwVq4IRsGE9VgU0KdKDshGt3iR2vLaHIGMznjt2Hm53juw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/Yi/lbL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/Yi/lbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775146455; x=1806682455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NNCjv2ZdmVCtPsLbi5cpk/LVnlCg2htihlVU122tBWE=;
  b=S/Yi/lbLvxfHQh22dpxINDEZXJixR+4ZdfTCt5u05FgC2MetGebMw8/B
   tllMp9vVjgTS3u/ScFeFBktfcORlXRsvIT1cuwGnSuem/kQBc63el66TT
   Hlpcopc24osbsrwL87CXr6euNRZ2Y5wgtcUIcCym86Rrcama+i+FJEHNN
   1p0n5XHmXz7Ffx7amh3sOREDlpUxyFolP1qcnbBeolDZQywuO+9TFeqAO
   QpyhiIWu+La02ITK5HjckKNPSf/iaMG4hGnbiySPwYR+pbbed1eg2Q+ci
   9FjYYttZKnO1yn2jkczPty9kkxrYsRTHFJ6FjyakIYlmPS1N0zuRzOky3
   A==;
X-CSE-ConnectionGUID: DMaW2DozQm6Bv4ICj30Iag==
X-CSE-MsgGUID: 2uvsRCCQRyiCy1M4xxZxtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="63760010"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="63760010"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:14:15 -0700
X-CSE-ConnectionGUID: b4khTNdaRVO0CSOg79OxYg==
X-CSE-MsgGUID: ZjeNP17wSL6Iqj7IP5RM7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="224167458"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:14:12 -0700
Date: Thu, 2 Apr 2026 19:14:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, ktsai@capellamicro.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/2] iio: light: cm3323: fix reg_conf not being
 initialized correctly
Message-ID: <ac6V0WWyndrg-7pS@ashevche-desk.local>
References: <20260402151730.18901-1-aldocontelk@gmail.com>
 <20260402151730.18901-2-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402151730.18901-2-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 02, 2026 at 05:17:29PM +0200, Aldo Conte wrote:
> The code stores the return value of i2c_smbus_write_word_data()
> in data->reg_conf; however, this value represents the result
> of the write operation and not the value actually written to
> the configuration register. This meant that the contents of
> data->reg_conf did not truly reflect the contents
> of the hardware register.
> 
> Instead, save the value of the register before the write
> and use this value in the I2C write.
> 
> The bug was found by code inspection: i2c_smbus_write_word_data()
> returns 0 on success, not the value written to the register.

> Tested using i2c-stub on a Raspberry Pi 3B running a custom 6.19.10
> kernel. Before loading the driver , the configuration register 0x00

Extra space needs to be removed.

> CM3323_CMD_CONF was populated with 0x0030 using
> i2cset -y 11 0x10 0x00 0x0030 w, encoding an integration time of 320ms

I recommend to use backquotes when providing a shell commands.

`i2cset -y 11 0x10 0x00 0x0030 w`

> in bits[6:4].
> 
> Due to the error into the initialization of data->reg_conf in
> cm3323_init(), the print of integration_time returns 0.040000
> instead of the expected 0.320000. This happens because the read of the
> integration_time depends on cm3323_get_it_bits() that is based on the
> value of data->reg_conf, which is erroneously set to 0.
> 
> With this fix applied, data->reg_conf correctly saves 0x0030 after init
> and the successive integration_time reports 0.320000 as expected.

Overall a good catch!

-- 
With Best Regards,
Andy Shevchenko


