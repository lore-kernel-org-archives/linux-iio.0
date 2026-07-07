Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE93783B1;
	Tue,  7 Jul 2026 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436944; cv=none; b=aWrxB8/J444VbFaYxeBQzNgwtlrzywbo0knHGDB/v2Usa1H1Eos5n+E/UW94s3JwDNdDRYJgWOe1o5pyCemaVEWsyPoJVZT7Uf8pI085RaQLIH1klg+2MWlCJO1EY6arIMcVholrfaG0XD/x8yxmi7BHCouHSKrRAFWaIVcmNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436944; c=relaxed/simple;
	bh=UAen4zXRCc0vvVeqLV9W4K9s42S9Ywe7vEOmWCZd724=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jsf0ojmeljsxOpdSfD/9F/j/gxt7T0sV5QxMKiE29bTkw3Q6XUt7klDSi2Dzra5AdUNVd7kWkNFKI5Z+/3V2kJ+/wy/sxmCfrTitkqilIplp6aS6T/uzKE2mjoIRqisFhb+V5mwUmBoz6W9aK0Z8MB1AMxm+jPp3OrEITNENVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJhRfpwz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJhRfpwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783436943; x=1814972943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UAen4zXRCc0vvVeqLV9W4K9s42S9Ywe7vEOmWCZd724=;
  b=ZJhRfpwzAmkQTrzjxSQEdEM+IsIEwaNa+atVwAIstKszi6kSyTf88LSS
   Baa8OY0X1x2tXUY+tYknH4MxCN2yFYfgsh/8u/cUUwqGOXCdOccclFyLx
   G7gNQ9ZDoyid91xm4nYzfu1OoWSBSXBJv0uJFxKdN8+tzhXApu8npuliq
   4bTtKGbkVefwZo1Qv/tU73iS5F6Q1wi2qkOXsUQazYeOyDbw0Whnn6/xP
   uaXv+uQdH+qOEQTrDMQdmxmMTfVpR18iz5Ol+JjF2C+GOYHtqkOpmNAwE
   2Je7zifuuuq+HtdATogWj664oeReTpSHNo5dEpdCoeQJnBC+pDTz6ZsHs
   g==;
X-CSE-ConnectionGUID: uA+6Y1HlT2eQjkr3H/23OA==
X-CSE-MsgGUID: 5/OiKCguS1WVfEwBB+u6lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84177905"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84177905"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 08:09:03 -0700
X-CSE-ConnectionGUID: c9x+0rHQQ1OdRcmVhiuBCw==
X-CSE-MsgGUID: dAiq4uXySkm7cCOoYhuB+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="255939507"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.36])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 08:09:00 -0700
Date: Tue, 7 Jul 2026 18:08:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com
Subject: Re: [PATCH v9 0/2] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <ak0WiaBDEOdJ-nBz@ashevche-desk.local>
References: <20260707112714.2261727-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707112714.2261727-1-shofiqtest@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 02:27:12PM +0300, Md Shofiqul Islam wrote:
> Add DT bindings and an IIO driver for the Analog Devices MAX86150
> integrated biosensor, which combines two PPG optical channels (Red/IR
> LED) and one ECG biopotential channel in a single I2C device.

You have the same issue again!
Please, slow down and take care of your email and other configurations to make
sure that email you sent are chained into the thread.

Using `git format-patch --thread ...` helps. But you should really investigate
what's going on on your side.

-- 
With Best Regards,
Andy Shevchenko


