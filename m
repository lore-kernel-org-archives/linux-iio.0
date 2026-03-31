Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68E41A8F;
	Tue, 31 Mar 2026 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938653; cv=none; b=lusBYc3GxP20dFA83HjRRsMxd7uoEdrpCAUpG1LKhnOuovCRy5PYzgbe5q/l8320NhzFpRqyHEqMSP+MaKVLJlZNkz8a5FkR+CEt0uWvgNUnRSkmfbkp1Kt/xZ0j87/JfWt+S5np/lCtyKVH4qX+nfGHQUaVlvV9ynhPaBLgyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938653; c=relaxed/simple;
	bh=dY8OsgrhIvSH+L2YEYITYEe02QWApJnuHoTo2ncRA/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFydCjgBeaJK7AOrwCpjBLEjgPP35IDN2eyn36cbUFZlbhG7k9DFGToEeIUyN6vFzsUyKMQS7OmXGIvR9ke2OFofOPk8Li0NT1WSMlMTtnICm4Y7sS/BwtyTmjB/w4MfG4qedPVg/6zmao/zcIYhsO4c5HDfknfE/DRR5Vn/E7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTsdVGhP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTsdVGhP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774938653; x=1806474653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dY8OsgrhIvSH+L2YEYITYEe02QWApJnuHoTo2ncRA/w=;
  b=MTsdVGhPNLfTOUCkyFhwr4tHMaTqWNNhkSI4Ow3FGsNvJQNmBi4FHglN
   hfGf0ZRj/GplXW+/b3XBovksHHLFCXVCnz/Zbqcfpl6UUak97WPflD5m0
   u9QoBn6VD5RQyY4hCvjlNAN1JJ3yR7ZXwcJyhEsdjIxHwbvRV5omhN0Qu
   dUVAOxA8ISyAVHWLWjSLSlJ10nlCwn58plLmkntWO8zti3aL0jqO9VD4H
   /gXABP2Lt+c6bNsu+2PxYjj0nvGGp6g0Z2igcPTrGmqKoneQqy1Ul3cYg
   rLGTxQ2dGeK5wrDEUrMrpPOy3E2X2K19sMwLasDxkM8tLUA/DHMdJGfIx
   Q==;
X-CSE-ConnectionGUID: 6jU4QAulRja1fVkk7kqnKw==
X-CSE-MsgGUID: extkTIqEThe3d1XqTulwmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="101398930"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="101398930"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 23:30:52 -0700
X-CSE-ConnectionGUID: 1ILWADRFSDK14XY2SgMloQ==
X-CSE-MsgGUID: vnRb2JdqTySH5w5qwGLwnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="227888377"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 23:30:49 -0700
Date: Tue, 31 Mar 2026 09:30:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] staging: iio: adc: ad7816: redefine mode
 constants to start from 0
Message-ID: <actqF7WOXIVY_h_2@ashevche-desk.local>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
 <20260330181710.23258-2-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330181710.23258-2-mdmahmudulhasan1511@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 12:17:07AM +0600, Md. Mahmudul Hasan Mabud wrote:
> Redefine AD7816_FULL and AD7816_PD constants to start from 0 instead
> of 1. This change is necessary to use these constants as direct
> indices for the mode string array and to align with standard
> indexing in modern sysfs helpers.

...

> -#define AD7816_FULL			0x1
> -#define AD7816_PD			0x2
> +#define AD7816_FULL			0
> +#define AD7816_PD			1

+ blank line here.

>  #define AD7816_CS_MASK			0x7
>  #define AD7816_CS_MAX			0x4

-- 
With Best Regards,
Andy Shevchenko


