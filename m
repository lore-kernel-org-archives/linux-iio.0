Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBA2FFF8D;
	Tue, 14 Apr 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156694; cv=none; b=lRjP6FtsU8n1M9kbHU6CSTCMGUsxpMSWdVUSUnGaTHy3awar3dxFj1Ed0vy4DVxsBsQHncjhO9ciccK7H2q7Zr92Q7NgtooxPW2PCVcQYUJ/+1TDz2I8nHbMxz9dx452wcoyOZL69xCFeIBz/KEycsYYa0G8nK5KElwT6ys7I7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156694; c=relaxed/simple;
	bh=RnX7Vkth35Vq24G1TAHKAs4v16MipVeSbcfs0BNSI4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1EVEd7rMlDvw1Z2xz36dfaxgJjnUpuAViNX0y5NMbDerlJC+wXeSSwOMlQVwgqqYEtRjShQBexBUzZzmkzr3HloSQl7ijnq5Q6+7s0yD2Wrm4cHTJQvfWzwydke2wv6BqI8l3Ni50dWXZMt3TYRlbgZj1QhsE9S0HG8wT0YH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZ0qnwfm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZ0qnwfm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776156693; x=1807692693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RnX7Vkth35Vq24G1TAHKAs4v16MipVeSbcfs0BNSI4U=;
  b=AZ0qnwfmZanqvraqPAXdqJb1yUs4AiNJY2/k+qiflWx6yNG+eRHqiIxd
   sbmqYI9LhcSNI2hvT7flK9/BUQGVbeQgG/IMTDVOPdBvDZV2kyk8hUjKH
   WSSxuPPWuTYDG6YHNalgOw1q5LIKMSp6zr1Nk+FqMiuoh4LpslO+n4PuB
   lPijXaY/JXP/3mj5aTU48j5IZaUpHrigjGYiE3fz1iGMWKUoflq6YaCan
   vSk0qlkynmdKELPddCS49OSMXAUhi+qqs0S3Jm9sz4xoNDfSmk+k11PNA
   Ha0+O3JgMT/g2zV5/OCuzg9a/eS7/yiPihXCVoUVkSBoHSgIbuyaDOCJW
   A==;
X-CSE-ConnectionGUID: S/oPQybgS/qMloyiv1DZDg==
X-CSE-MsgGUID: YzDczgu8TPOOebtc9uEtCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="94507281"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94507281"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:51:32 -0700
X-CSE-ConnectionGUID: Jn/6DJRbRYy4uGONwJcS4w==
X-CSE-MsgGUID: Cze8uPm5TPi9Duhb5rfiPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="268013300"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 01:51:29 -0700
Date: Tue, 14 Apr 2026 11:51:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Carlier <devnexen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Tomer Maimon <tmaimon77@gmail.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: npcm: fix unbalanced clk_disable_unprepare()
Message-ID: <ad4ADuwCgRGO99u2@ashevche-desk.local>
References: <20260411123517.15083-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411123517.15083-1-devnexen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 11, 2026 at 01:35:17PM +0100, David Carlier wrote:

...

>  	ret = devm_request_irq(&pdev->dev, irq, npcm_adc_isr, 0,
>  			       "NPCM_ADC", indio_dev);
>  	if (ret < 0) {

>  		dev_err(dev, "failed requesting interrupt\n");

Also consider killing this message as it dups what IRQ core prints already.

> -		goto err_disable_clk;
> +		return ret;
>  	}

-- 
With Best Regards,
Andy Shevchenko


