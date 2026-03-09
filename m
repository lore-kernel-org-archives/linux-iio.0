Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54193921F1;
	Mon,  9 Mar 2026 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057157; cv=none; b=AtSW9T2pLLPv0LHH8NsVa5sPnwX90raXhyFVS3v6FDeB8ONzx0rrjeDCOYnD/lltoZVqwp+p9ySlvG3d/kKeE/N0U1VCX9m5d1YilOvX8z4lYhUAD/SIfFiE3mbBC/RPOz82w3f+DlDi63fa2qrnykJpcoErAffRbE3zf9NuhrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057157; c=relaxed/simple;
	bh=Dykc6BnsdLQJ0V8YqBH4eSolqlsSmJcxhnUPHlCYDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk4omuSYpDy50oOWKUlgLxPN1Vja1nt64fu9SEo0D7bGSvFQ1sNMqsvYChgGrgPEXXnz8EApUwN6LCo6OYDTh8FGP6WRcRbr0BDbHri1TK4Hn3/THzsuuAwrlXZ+1qSPKEHq2Wvii+hLi4BRYiE2PJ4lpEKxxfEvB4Uei+9K09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORPMDW9h; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORPMDW9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773057151; x=1804593151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dykc6BnsdLQJ0V8YqBH4eSolqlsSmJcxhnUPHlCYDm8=;
  b=ORPMDW9hKf1CAxo6MNeAhm27Jk3Bkz05kgFwtL3M05+WihgsXEi6hw8g
   0stqYNJX9pHLs089XeVPEK24NlU9998WjYz3QTTNzyxNnwHKJ1vR7oA4E
   5kQXhnuXliLKR/x1Xqbn0ClWsJKTt7pMBKfI21H2U0+d9h61aVjIqqmrP
   Tb9syRnvx2eCJAf/oBRjepHYC8xVepxKUfDpjQH4QpxDSWPgzR/wEpern
   B9iVjVbDXj0bJsUvW6x4RTBZEmqhJC/pj7h3J4Ul8ytUZ5HrIKKlFMNoL
   Jzxw3Rf2fhN8xxGwkbua/0JtA4Hjzrv5y9V2Bme7Jjf3NfYWfvJpV6Isi
   Q==;
X-CSE-ConnectionGUID: IZmgqlGGRUqxLQVPpa/g1w==
X-CSE-MsgGUID: EPqjbD13RSq81h9HWW/wEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73977711"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73977711"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:52:30 -0700
X-CSE-ConnectionGUID: 2J/O+TQWQfyP/VoYejueJQ==
X-CSE-MsgGUID: AMdSAiSXTMqMYEzL1lIdPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="216250207"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:52:28 -0700
Date: Mon, 9 Mar 2026 13:52:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 2/6] iio: adc: fix spelling mistakes in comments
Message-ID: <aa60eapboLEbFaFN@ashevche-desk.local>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
 <20260309104513.40359-3-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309104513.40359-3-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 04:15:09PM +0530, Shi Hao wrote:
> There were several spelling mistakes in comments such as mulitiply,
> referrence, ocurring, consequtive, and celcius, as well as other
> occurrences. Fix these spelling mistakes to improve code readability
> and consistency.

...

> static u8 twl6032_channel_to_reg(int channel)
>  {
> 	/*
> 	 * for any prior chosen channel, when the conversion is ready

While at it,

for --> For

> -	 * the result is avalable in GPCH0_LSB, GPCH0_MSB.
> +	 * the result is available in GPCH0_LSB, GPCH0_MSB.
> 	 */
> 
> 	return TWL6032_GPADC_GPCH0_LSB;

-- 
With Best Regards,
Andy Shevchenko


