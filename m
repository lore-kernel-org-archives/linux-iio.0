Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049F2E5B2A;
	Mon, 10 Aug 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388656; cv=none; b=RPCuvfN/Y5Yi4dbRF79LE558Wr/3S+4BeRiD4coSUCt/xkJrGhi1MGGVglFbO+TD0S0e48Q5LeUzE5WiO8oNAarlkS+5qu5S8GF8u1+qSDJ4fasGzBsl2z1k1ZI57AQWBvxsSgv3vm7pyisnavkZ3Zz2Rj4AFCOXgVtOXjr9nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388656; c=relaxed/simple;
	bh=p3EOHRDcIsjjnfmVNE6qO6wdAxXQstusCBbuQ6fqIvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duI/x+LaBccxAJm0pnTXiyZztgH+Oq1qdHKh2hOfYP9mTZnJPsKhwuQSd5koqccISZkS3ROXuiJVzwBN5yfaDEvk/X0JBjhkynFT7uxzoWilEaCDkxRNWaOA4ClieLg+fDl3vdVRXEMR1F4hepWLz3kEQyfegViKo12W7wV461Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlV+Srkf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlV+Srkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786388655; x=1817924655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p3EOHRDcIsjjnfmVNE6qO6wdAxXQstusCBbuQ6fqIvc=;
  b=OlV+SrkfWBEMglqR7SFC3yv7HBkI1LD3Cl1vs6dnL9TxdGvDXKWLQELM
   joMGVHTEWYKrvFWMeQkYyrbpUV+BSj0bAHtzG0wtEiqSa8j/cJquAGkWA
   6wkTcLJp0xfcThfbmQ49TScMFN/6ap5sAVitCFHQvzbBiMjhu0i5EQn5T
   g9OrKCHqg+ZE7U+ua/7yhy3KlQ7XmQqag6rHcZyqt4SOOZaPNDL0T1uR4
   UrILbtFRnP72Q1qS0li6fhXQUsJhndhliBGpmTO8qwollHxllmfD2a9MT
   2ws88pmgkmYW1NY2WNukjAXlQLEdzhi9NyDMDEMzDSwRwpV0WkPuaXmlu
   w==;
X-CSE-ConnectionGUID: Vsp+/VVOQlS/QWPDE21QMQ==
X-CSE-MsgGUID: xoEXKvu3RtiHXG0A0y1yuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97264197"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="97264197"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:04:14 -0700
X-CSE-ConnectionGUID: 5MjL9ZyXSny7xPrD/F6Ajw==
X-CSE-MsgGUID: WwxIWlxGSBu5GPD/RN5QWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="258844653"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:04:06 -0700
Date: Mon, 10 Aug 2026 22:04:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Philip Mueller <philm@manjaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: imu: bmi270: Match PNP ID found on OneXPlayer
 X1 Pro (AMD)
Message-ID: <anogpNeCbeF2UnUA@ashevche-desk.local>
References: <20260731195325.44453-1-philm@manjaro.org>
 <20260731195325.44453-3-philm@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731195325.44453-3-philm@manjaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 31, 2026 at 09:53:23PM +0200, Philip Mueller wrote:
> The OneXPlayer X1 Pro (AMD) uses 10EC5280 rather than BMI0260 or BOSC0260 as PNP ID.
> Adding the ID will enable the BMI260 accelerometer on the device using the bmi270 driver.

...

>  	/* OrangePi Neo 2026 (since BIOS BCPH01_V1.20), etc. */
>  	{ "BOSC0260", (kernel_ulong_t)&bmi260_chip_info },
> +	/* OneXPlayer X1 Pro (AMD), etc. */
> +	{ "10EC5280", (kernel_ulong_t)&bmi260_chip_info },

Yeah, this is in Realtek PCI scope which ACPI incorporates by
the specification, and yes, I have a long discussion about this
or similar IDs that are misused. If we go this way, this needs
a good shameful comment to point all this creepy choice made by
some unaware vendor(s).

Also, keep it ordered, I think this should go first in the table.

>  	{ }
>  };

See also ca2f16c31568 ("Add 10EC5280 to bmi160_i2c ACPI IDs to allow binding on some devices")
for more details.

-- 
With Best Regards,
Andy Shevchenko


