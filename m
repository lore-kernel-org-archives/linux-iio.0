Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEB36215B
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860358; cv=none; b=du+WzKkjGMR+0xyR3rUJJLxBwfAlDbAQ0Lv+Ad/IjNbkBay2tZkTHtIJFqmSyiNVqEd4ug0YncY4ouz7r/GMCuUawNWAYnL7KZiAxpMes4e/Xk37RpTiZXGQWwZgBN5KwV8P613e3MGlRcOSlKS5htkUKhqBi598ELs+o9GOCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860358; c=relaxed/simple;
	bh=+ugh3RkeMKZtuFcE1Zx/uRlE7miUIMTXg4R6GOf1tD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mp80JhoW2Y5X6D8uQAMljqiQXp+xqKz4AKSAlS3icdx8pveSQUSc5uXb5AGB/2P+0GMJVomcP2CFr+3rJR5OFbpK5WGXNmDmLS1Ap//0y++uJYdW8ewpXPm3yn9ASbE3rnLRcN5K5uJw27m7f8ctntkKiTHjVAVBR7U9T0+asAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XeWtmz94; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XeWtmz94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781860356; x=1813396356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+ugh3RkeMKZtuFcE1Zx/uRlE7miUIMTXg4R6GOf1tD0=;
  b=XeWtmz94iRwSpofDupBY4hDHoWV+ERKykTvFcj+6ckwaN+m4JKKMP2sy
   a8Nw4pbO/iQlILNtkdoPe9tWrbDKz1UcMexYU+UIiABmLOBxvoy7t1qwi
   5iW5Si9DjOnrxM2/1PYlkmYUyk7bg5t6+eVPi61wewUtwuKsZekHa/+IX
   7ozdC5S3uEvdIRHrl/ecrXaW1C3yP10I44AEAFLC9AguNtDwiXN2ooihP
   xXIwx9aYbQXw+res4XX7MepdvpciEKKjhECMGfcBCPmuLDvfU/AUMyvJ9
   oBt9VMlYgNPLVmSrrlnl9PHJOb1zReVTt8XaUYfAt6jD+JVW999tlFbTF
   Q==;
X-CSE-ConnectionGUID: Emz7kXtvRiutEVjQhks9AA==
X-CSE-MsgGUID: xH6MxKIPRFWLgYcLZH4/HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82903394"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="82903394"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 02:12:36 -0700
X-CSE-ConnectionGUID: 03hamAibTmyLz7Skt7sgxw==
X-CSE-MsgGUID: c4XRkys4Twyi6qPyeZpLuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="248653106"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.170])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 02:12:35 -0700
Date: Fri, 19 Jun 2026 12:12:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Caio <caio.groff@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2591: replace persist switch statements
 with lookup table
Message-ID: <ajUIAGEmbWEvD1aT@ashevche-desk.local>
References: <20260617164258.9007-1-caio.groff@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617164258.9007-1-caio.groff@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 17, 2026 at 01:42:58PM -0300, Caio wrote:
> tsl2591_persist_cycle_to_lit() and tsl2591_persist_lit_to_cycle() are
> inverse mappings of the same 15-entry table, duplicating the same
> pairs across two switch statements. Replace both with a shared
> tsl2591_persist_table[] array and simple linear searches, eliminating
> the duplication.

I have a déjà vu about this...
https://lore.kernel.org/linux-iio/20260528185912.24774-1-matheus.feitosa@usp.br/
Ah, and this what was applied already. please, base your code on the respective
tree and branch.

-- 
With Best Regards,
Andy Shevchenko


