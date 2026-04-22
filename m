Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539526ADC;
	Wed, 22 Apr 2026 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847939; cv=none; b=V3yc8CymKxmPpTtyn5rcOZHTY2c4hj7+cgkY9whSqE5ezLVTNjuS1I77HE8fXY1qBl72MTpOPVYTnCAA8trYJyP9LEUnMVD9jRpDTBLLiZi1mZ6rPr6fhi6gZ7qhIeayKS9pK7oP3gNXPGCm4qEkDnYUZQwrEqVEWuEH9BvNgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847939; c=relaxed/simple;
	bh=BkRapnNHvmPjNh9wQe91xz1TFwssu6nCux8a2d4//Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNkfYZMJcWEHCFoHMOVeYswLr0U7Jn+In7DyGM26iqAyyYhJACAKIyKfZdloPbaP7gDxvAAVfYBHDeJ/HLqJB/pEOpS2s23DEGfvpDq75WD3WrMGs/qS1o/oia2h2HHY1rYAAjWmVGYv5PkMsAw3dCxw0eROZDqvhWzrngHfvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/ITLI77; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/ITLI77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776847939; x=1808383939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BkRapnNHvmPjNh9wQe91xz1TFwssu6nCux8a2d4//Vc=;
  b=g/ITLI77/JHHBg1DXQuvqxWY5ovkFTxcBulECx2sisn8ALBaZLSzIElA
   ix0VhhmHI6NAVcoDyTEiB8s6FlHUMS6yP7et7WXE0auC1MSb2KuSXWGrX
   zwhtF3lK65orQUvqHEfCAsZx6qhD3JAV12onmAtCQ9X4rm8uz5ozjiidG
   Lw9NbsqZ8gxr27UwVBsTIJfElJZt0Y2tEiTfvX0UVaXlPhVekCYLu++ty
   05ml9OMbCZqc0P6TV73WgmasmfVo3lMFhRqjpypM0/l2EjtOSIt0qEW7M
   RNAjDaEjInZXXidv+suqgwpX6uEYA2Y4Yhqldq9NS8S9RYAgMMQao3rZI
   Q==;
X-CSE-ConnectionGUID: 82ZGYhyQQFCbmQUY1KZfyA==
X-CSE-MsgGUID: FHyVTOKZQ5mGbSlR0tA3Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81407674"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81407674"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:52:18 -0700
X-CSE-ConnectionGUID: NUtlKbYJQTaFNya1gfcimQ==
X-CSE-MsgGUID: yRlj68JeRKqlgqBGiODNog==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:52:16 -0700
Date: Wed, 22 Apr 2026 11:52:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *'
 in cast
Message-ID: <aeiMPrBs4BJE0H_k@ashevche-desk.local>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
 <20260421100722.1296-4-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421100722.1296-4-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 10:07:21AM +0000, Joshua Crofts wrote:
> Change 'u8*' cast to 'u8 *' as the former triggers a checkpatch error.

"While at it, fix the indentation of the parameters in ...func...() call."

-- 
With Best Regards,
Andy Shevchenko


