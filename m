Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962535;
	b=iT5VEHdwuvLf8GzD5FUHKlFxxdBz+FKb+25RZ4oJqPIHtcBt0V8eqH6WUosTUg71yCO/
	 1U51ho67C1iGlJaqPiDoEfqSB7Rw/p/OxVBYpdT/fT8WaT5/3WU5HASuiXJ2uu6cme4Ec
	 KLoF0reSLtFVgKNI/aqhysPdegmqzF+ZDxId3CYv1qR2nH+y7pBvjFwile5PORh4Xx8pu
	 qEPKKHvJQxGhZpHsJGk5A+aGU9GclzK4AtbhSxRQc7iOjzLjIXU1RcsYwdrNmeW80tPw2
	 Gfio5CyKSQKb2kDRI8pEp8Tag2fLB0ZcBgUXOg6gfOnXAroE1pBpDWijUE72yNUTvdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962535;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0hTonDNrvazpNb68heoGRE1WEbqb6H4Cq+6nx5Aw3Tk=;
	b=VhOsUYJUaVPBYz/M63TeXTV2akBp4y4xcDPKqKAZdujglw0WShcFEKOSCQiREl7CcGKO
	 wuLFzGfssdn3IOp3mAAbK870sfwrf6uVZ0cb2f1tEfeKhOhvovsr7+SLM4MsZEY6LQDG1
	 5NMms9d1/FGQkR49rAORLUoYS+1daUdnvLt30L8TTx4L8ZYOmLsozAcrBYwOdNSszDSaz
	 MTcbkMdmWriOEpNZjzipEBIR0Ob4wZW22D4ci7bAOvOPmnZ63wcleRs9m1z5268D+7bZN
	 9UMAey28ASPBberFzJnVVKe8YxGZSc27fCyOp6HxdV7kdYNq4tiO7jZEzPlzBeaFX5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F5ft2uBt;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847D606A31A;
	Sun, 25 Oct 2026 21:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B847D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F5ft2uBt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792962535; x=1824498535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tPktMJC8ZUhXLZKzTryijfniAEadKhAOZYoSqFz3s/s=;
  b=F5ft2uBtoShifCkCyofc0daTdvzoUV7aXQqZwI0n9Ca9u/h5ZaGc6eSp
   1YxhagGnZZmLzNxH+XoP84sVRq2o/5+boP+9LUqw9koSf5ukAkJpniMjJ
   hAjpKcBumcwQnvlw9s6kJ1LA5Ai9SGRpIehYWv5ctfigIf+0TDsEqkxjo
   fhW+SSTCE9dFPbVi8T19mPfUQGWhen4uv8ptIO3Hn7Hq1RwFlibs/IW4t
   oPM5d3IsfBLU8snuVz49Mbz12tV7p3QKwVzH0AYN16evFBYYQvkoL4PJS
   F9XjJ4MnryWp1g5fVBswjZdCt1ra2/sDPNL2MIO6cEN45cUsssZIp3dGA
   w==;
X-CSE-ConnectionGUID: A6TiOpIbTEyzNxjtotw2UA==
X-CSE-MsgGUID: 3bSSpmQdQnmCTXksUxHFIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1658313"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1658313"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:08:54 -0700
X-CSE-ConnectionGUID: TUC48Du8THyPchNmdbrQTA==
X-CSE-MsgGUID: k2wGBJzmT7OpB91T3QBeKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="5932743"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:08:52 -0700
Date: Sun, 25 Oct 2026 23:08:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: dac: mcp4725: Update the cached DAC value only on
 success
Message-ID: <at5v4pw34L8Cj0vU@ashevche-desk.local>
References: <20261025141351.33554-1-pocj8ur4in@gmail.com>
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
In-Reply-To: <20261025141351.33554-1-pocj8ur4in@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 11:13:51PM +0900, Baek Kyu, Kim wrote:
> mcp4725_write_raw() updates dac_value even if mcp4725_set_value() rejects
> the requested value or reports an I2C transfer error. After writing 1000,
> a rejected write of 4096 returns -EINVAL without an I2C transfer, but
> out_voltage0_raw reports 4096. A later powerdown exit sends 00 00 instead
> of the 03 e8 frame for the last successful value. The EEPROM store path
> uses the same cache.
> 
> Return the setter error before updating dac_value. This keeps the last
> successful software value for readback, powerdown exit and EEPROM writes.

Does it need a Fixes tag?

> Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


