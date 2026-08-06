Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3C3E3C49;
	Thu,  6 Aug 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052354; cv=none; b=jU4NqKvM8RkTuXcP8PBBNxo/tf/8pGiJTXc0mciJoQ+PL1hIVHYJDtDH9mQwGN/z129DiTZAKHtCjFfVH7AgNGQwZhcROikx2D3UnHIL6Tm8MdajQk2AbUiIOVTd+qR3TccdwXfdaAOliUb+RSQELzHvRmHTEdjYOFgRQzDDA18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052354; c=relaxed/simple;
	bh=UAGQcGrc+pF9SmEoLvjAupKFj+QmunUUBxrjmHOlLx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlsBNxDcTPZrV0/m1z9ELS8Gg9idvXo5tRbuK9h9K9dOVHjycp3RyY6GuuXjTWDvmtoK03gjVuqchweb+MGzOoGc+tFMuh1WgSiLT+42NdgMBP7qKdj1r7ps1Uq5xA1ZFpWpjjWBtmPbp7wXmSo5p+gQbyKLlr+cUnpKXpY1/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9kHpsez; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9kHpsez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786052351; x=1817588351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UAGQcGrc+pF9SmEoLvjAupKFj+QmunUUBxrjmHOlLx4=;
  b=j9kHpsezQUz3IHrHfiGRnOssq5+o6jf/V0+nxEfCE+QfvBIWY3jDvILV
   Z5y8y3nVBybMtDAndL0Ir52hMrqT/YefZdhvI50y6ICgpXSVjJw+ET5ZY
   MGrAi4sjuIIGMCbKEgnpVoH6D900Xh8OzCWEs9R/2pD5cRLn+BAk4ocyV
   glaeKg2AaAGOEzWD0/8K22kiqC/KmqoasXw6kmiInXL942b/HOAw9TgE7
   F+67E9kvF6jldD/4tyXgLn/VEz81QLYhCzbfNc/W45PxcPctOQdS2jW8z
   2/59AJ36GULssP1hJJ+hMww/WQ7V7SjVC6YkOMsQ7//cZzwZOI+64sDoc
   g==;
X-CSE-ConnectionGUID: vUliLZ4eRHKBu/Qkv3eI0A==
X-CSE-MsgGUID: IoH+b0bRT8OAQJ5UHoFseA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="89185210"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="89185210"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:39:08 -0700
X-CSE-ConnectionGUID: qm3FMHI3S2SrE/S4BAUIzQ==
X-CSE-MsgGUID: RS5s2t2+SgeG/8ZH/BG0jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="286895005"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:39:04 -0700
Date: Fri, 7 Aug 2026 00:39:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	Maslov Dmitry <maslovdmitry@seeed.cc>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: light: ltr501: Add ltr329 driver support
Message-ID: <anT-9vI9jD8V0Q0_@ashevche-desk.local>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
 <20260804-liteon-ltr329-v3-5-c6b768c7c745@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-liteon-ltr329-v3-5-c6b768c7c745@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 04, 2026 at 07:02:16PM +0200, Esben Haabendal wrote:
> This adds support for the LTR-329ALS-01 chip, which is similar to
> LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
> have.

...

>  	if (client->irq > 0) {
> +		if (!ltr501_has_irq_support(data->chip_info)) {
> +			dev_err(&client->dev, "chip does not support irq\n");
> +			ret = -EINVAL;

Can this be

			ret = dev_err_probe(-EINVAL);

?

> +			goto powerdown_on_error;
> +		}

-- 
With Best Regards,
Andy Shevchenko


