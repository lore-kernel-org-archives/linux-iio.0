Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C80348453;
	Mon,  4 May 2026 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884936; cv=none; b=YXmJOJjne4NXzeVQMpFCAk2is6nEpBuy01v+PO3QvPKn3r3gy3DWyMD2aE2rghfqidPW++2sPp009nUOVuioMYNlTS4c7Lu/w/R6w/F2cUSIUhUKsPWnBg/NgGz23Eue9OkXxYFRVpuahloHE4p+3dCV8w5kVOmQXVxQ1PrNwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884936; c=relaxed/simple;
	bh=9890xr9TEmXG4BnibQbhVkx9D1FhW5J/MMHHfaCmK8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URAcI7cHs3mzMbw84eqbX525m2wVhKDzvDzTlpOAlNJR8A5/y7JwblBBp3ittdceHKla0mfphbKbbGmXrLoPzKeVIR3+V1fVUOijUX4LAQHB8x49oZR5mTXVdOsVS0zUHN1Ccu+socIyuEUmn+WDTWfZ8ceufcLfQC7q/iCI42k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDCImhAQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDCImhAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777884936; x=1809420936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9890xr9TEmXG4BnibQbhVkx9D1FhW5J/MMHHfaCmK8U=;
  b=WDCImhAQ54ag4HWFLspI2tWNChdYysIAklVBaAjLx+OTVXNCbh19jFN7
   UQUvpj/+OpEb1rrT3yW1JtuYqw39M8FoiQ/WFFJITM0HvYkdHG+4qIMM7
   2XpX/y5IBQFGk38cZDI2Lj7btQRQsB+VxFUAN/tRwr9VyaKl61eFohr3D
   4DZtejSKdUOeB4w7KyUHGZdjEpTJLV1+yfXxfIuDCSmP89w2tGgIkKiN+
   YTbyRJwDIhtV36vD15lSiwCSrkMN819gIl5R2su4flOhrnWVDCEhgfCVi
   OewgyzvvYEpCvDyOIKhnxtP+tVKb7wlU05q7Magjw65Fi+7EmVAOJjmiJ
   A==;
X-CSE-ConnectionGUID: TmeLcXHWQSOWuZ86Ur7InQ==
X-CSE-MsgGUID: u+HNK0C9Rky2Mi7H1uBdWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="82350686"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82350686"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:55:35 -0700
X-CSE-ConnectionGUID: 3tVvQWmWSKGRzKvuywIvBg==
X-CSE-MsgGUID: LL42ETUvQnOjOKX/Ue7eYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="240444198"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:55:32 -0700
Date: Mon, 4 May 2026 11:55:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 0/8] iio: light: si1133: driver cleanup
Message-ID: <afhfAjTShsY8AYiu@ashevche-desk.local>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 30, 2026 at 05:04:20PM +0200, Joshua Crofts via B4 Relay wrote:
> This series deals with the cleanup and modernization of the Silicon
> Labs SI1133 UV/Ambient light sensor.
> 
> What seemed like a simple checkpatch cleanup turned out to be more
> complex, therefore I've ended up doing a patch series instead.
> 
> Changes include:
>  - adding missing headers
>  - removing unused macros
>  - adding guard(mutex)() support
>  - code style fixes
>  - race condition fixes reported by Sashiko

I'm not sure about patches 1 & 2 without testing on HW (the reports sound good
and fixes look reasonable, but it might be some behaviour that relies on a
[buggy] implementation). Also not sure about patch 7, however don't care much.
For the rest feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


