Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17A39283E;
	Mon,  9 Mar 2026 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055802; cv=none; b=qQlwME7XjVOFX37wWVraxzrrAV1QhWI8BihY1/Rb+j3ID5js8yL+QJTbZYHqD/KPSPCgX7ds1kIXQzcFbXENU0mCPFKLoKLMXkTdyatHSbkbB9U6TJ+Jr1YIQVyL3e/dpA8nDLcwaE6Xd7RjzH2TmsH6kBB8OM6jVvr+LA8Yxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055802; c=relaxed/simple;
	bh=v8+jI2LNrEaRuZDpx9JDeIgG+YuG2DhE9BGy8+6oFGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5rgUbo0PwJflXbADqoIp+7KM1IkVyevpnr6/rhp7FDMQq3Rjl6wTsplJZqomcjyR53UCY6J27EZAiEI8eeN5rPmCPHxgMTx5Ncfd0zeZQ7fZa7/t6rQW/9IxQksiW1dAncnP0PRYcxLPQH0Ujc5tW5mfBZcXu99DC3ByvNsJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fT+l8pJu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fT+l8pJu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773055801; x=1804591801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v8+jI2LNrEaRuZDpx9JDeIgG+YuG2DhE9BGy8+6oFGU=;
  b=fT+l8pJujOBVcDiF+Pe/OsQ2s6OBod7zaVTNkstG0DGVtrrdE/04CrKd
   HFjYZH8NTNNG9zsBPTsdodgsI3IIcgDfkDGOOmV2GZclx5lcLxxcA1jUP
   DBBJEYgU1ZJi3B1fdTo9IxtoOIq/nExMfYqFZpJJZOy7Mtw9HgrWrRn8+
   t08tuI3aXLgiJvq47GSxCXebgKCL+Ur8Wbz+yLqZNUtd5yX1Qb3NAl+Sr
   ijaV/hc8FZTOvagkXUngvTTjMClAtUj1KbsLn1QEgdi3H3BJFnWMZ1cI6
   BoKuPjjRESFyp2DKaOI+M1a8gcBwANPE4r8mIPG5jUUUsPlJQkPUS35b2
   A==;
X-CSE-ConnectionGUID: 3AL/Bp40R1isCg4nbndsuQ==
X-CSE-MsgGUID: ZdNy5wqPSjyl25tBgpereg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73269969"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73269969"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:30:00 -0700
X-CSE-ConnectionGUID: JSBctCVsRDWp6RODd1NMmg==
X-CSE-MsgGUID: 49fJ/eL4TKurOrJj5IqYpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="257651275"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:29:57 -0700
Date: Mon, 9 Mar 2026 13:29:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sirat <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <aa6vMjKwcjYAE9xN@ashevche-desk.local>
References: <20260308113728.40860-1-email@sirat.me>
 <20260308113728.40860-3-email@sirat.me>
 <aa3lRthNn_VnFChk@ashevche-desk.local>
 <CANn+LWKVJgXTTyd4usZcaAzvws1DvzFuQ2Lm9f8xa82SU36DDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn+LWKVJgXTTyd4usZcaAzvws1DvzFuQ2Lm9f8xa82SU36DDA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 04:27:22PM +0600, Sirat wrote:
> On Mon, Mar 9, 2026 at 3:08 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sun, Mar 08, 2026 at 05:37:28PM +0600, Siratul Islam wrote:
> > > Add support for the STMicroelectronics VL53L1X Time-of-Flight
> > > ranging sensor with I2C interface.
> >
> > I'm sorry, I missed cover letter, but can you remind if it has the explanation
> > that brand new driver is needed because of ...?
> 
> Thanks for the review. The existing VL53L0X is very different from the
> VL53L1X despite
> similar naming. Trying to extend the existing driver would mean
> rewriting most of it.
> 
> The VL53L1X has a different register map (16-bit addresses vs 8-bit),
> requires a 91-byte firmware blob at boot, has a VHV calibration cycle,
> and distance
> mode/timing budget configuration that doesn't exist on the L0X at all.
> Also, newer
> abstractions like regmap instead of raw i2c_smbus.
> 
> I'll make sure to add the info on the v3 cover letter. The rest of the
> review I will address on v3.

Sure, but have you checked also other drivers? Sometimes the chips are designed
based on the ones from acquired companies or licensed IPs. Please, be sure you
checked also other drivers in the same subfolder (sometimes we have even cross
cases, when the IP is multi-functional and parts of it are already done as other
drivers in different subfolders, but I don't think this is the case you have).

-- 
With Best Regards,
Andy Shevchenko


