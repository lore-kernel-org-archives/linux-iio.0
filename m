Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7F13612FB;
	Wed, 17 Jun 2026 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679160; cv=none; b=VVe+ucMls+frkdzwrqmYiBaNF2GQkh53Sbj2AlFklRl1rn24T+rjMjWCLQMSQ83IxbJlMn32xH1RiTYBvQDULYeSq+VY1i2iiRAI8yZSdfnW8Gy5gOyCGf++dFZlNWy2cloKDooRnLhgyf2j1RypIms9DELh+s8XG4Gcvqq7aC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679160; c=relaxed/simple;
	bh=XOqs+o57Cxy+S8+hi4Nm79h/bpCBAwqsP8/yGaV0gl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wonq42u81vdT/YgCqIeeNiXbn9dhcIYQuLjz2CK6KyKsjHdYpPbjLQHB6SjAfmSGuafek7WtAxssIUs3v2lKJT/AlsnXH8WHw2hUCq25qkB1UlQOA3+b6N9MREKxWAG4ZIUy7B/xQCZ+0QCc9xkRJntSBD3x5zxpvOfVZM3uidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxeHXnLT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxeHXnLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781679158; x=1813215158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XOqs+o57Cxy+S8+hi4Nm79h/bpCBAwqsP8/yGaV0gl0=;
  b=UxeHXnLTk6gIRGM3yIhx3tKceq9fBCAyMU+RfS7Zup4xmW8Ts3d+YImt
   bjqgaTTuMxLtOeR6VVAem4IF53/d9i/xrM14BXmnIqZDkpAJl/e/jgpJy
   5JROzsotYaHJ40x/HuQDc1t9cTb7LJrgsnJudCSf7+np5WKn2aHSPXsVq
   HSQMjVfsDeRoaJMUGGB3P6pQ/FHVVXN5+mAjCm2C5yFDIaMXW8lqi1OVq
   avUtns2lE/A2Byz2JUfXRQhPv7EMNsC5N4f2er5dw0J30POivZqh5UpTM
   k8cms3Myk38Vnjn1OPcwvId1UjoNf/ziaanh5aoimGXySjWKWc1Vhodbh
   w==;
X-CSE-ConnectionGUID: vlEbmpqLSO6/6duoj/7g5g==
X-CSE-MsgGUID: ZoDbbqvdRBC2H3YsEBDcCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81592430"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="81592430"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:52:34 -0700
X-CSE-ConnectionGUID: z1lSjHE9S9+fupu1iR3/pQ==
X-CSE-MsgGUID: KfB0Nk2ISpKl99DifgNnhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="247857356"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:52:32 -0700
Date: Wed, 17 Jun 2026 09:52:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: ABI: testing: iio: minor cleanup
Message-ID: <ajJELTX_uJg0steQ@ashevche-desk.local>
References: <20260612121342.181358-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612121342.181358-2-manuelebner@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 12, 2026 at 02:13:43PM +0200, Manuel Ebner wrote:
> Add parenthesis and dashes.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  		used to mask the buffer output value appropriately. The storagebits
>  		value also specifies the data alignment. So s48/64>>2 will be a
> -		signed 48 bit integer stored in a 64 bit location aligned to a 64
> -		bit boundary. To obtain the clean value, shift right 2 and apply a
> -		mask to zero the top 16 bits of the result.
> +		signed 48-bit integer stored in a 64-bit location aligned to a
> +		64-bit boundary. To obtain the clean value, shift right 2 and apply
> +		a mask to zero the top 16 bits of the result.

We can reduce a churn by leaving 'a' as it was before (despite being long
line). But I leave this exercise to Jonathan if he wants to.

-- 
With Best Regards,
Andy Shevchenko


