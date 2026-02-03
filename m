Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8632F757;
	Tue,  3 Feb 2026 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118930; cv=none; b=tyLf1xk2o/0+9IWcTjvu7QjCLkBEVBagUAFCOh6q+vLkXOxROHL8zUSv4VajOj1zqFZkiV0EvEkg2+JaKmmK5J9eOUiy78gJztHCe0gSG/2vKYPXA3wNveDgxZOllV0MQ1N092a31D7+a3nXJau80tU/tfKBMWpImqdaY6DkmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118930; c=relaxed/simple;
	bh=wDddQDTjIqCaB6sjxDU9jEW+R9KHVkRHph26vRiLqDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNWr2bHNfdEVIrxcZcD89cxx29963kNL91SOPVus93sHI13CV+MkwObUmnncAIZ/5ZBIUXqrAgHp8glg85mIxShJi3P7dR8K1rqvZtTTaVUrtQRHaNYMghvAGi9bEBszXP8+HHh6edI/7ZIzRu0Cjvzcq1KBa3ntVGE1EXnsvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFpQ3vWh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFpQ3vWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770118930; x=1801654930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wDddQDTjIqCaB6sjxDU9jEW+R9KHVkRHph26vRiLqDg=;
  b=jFpQ3vWh8gXrEePMHN8SC/AWfxrVeIRNzhrl2o/ZVqB4VjeYiqKsm4sb
   RunSleLdglHk+DXCw3RSUgDKtIl06DW4CR4Mq2ozdoIplgWkJcmOecTru
   w9E34rDFLicBV6VRagNvtL+8FLWkQVZ9YpJHF8LD7WFhOSU+oC/ryQQOa
   4FrSbLrohrygReq0/Q6+3yZs4szkAMdOlCuAEF8UMPmM41KblODv0FC2Z
   LLiy/Z4paW+3LLgdhZhkc+/FHUtpM5wg85lQydElYIUgn7YWBdImbSajU
   s4apFoYIVzbV0ShSw1zrRLlaV8zKzPi7bOn54DkIlHSqKZaQ0CuJtqrdo
   A==;
X-CSE-ConnectionGUID: /Y12HHWuT0yohWn8HX0DnQ==
X-CSE-MsgGUID: DGI4YPNiTmCOyERDFD+yHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="93939447"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="93939447"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:42:09 -0800
X-CSE-ConnectionGUID: H1Tez6wiSGGm+yO5JZcpjA==
X-CSE-MsgGUID: 9htARrmcT3eLoknNy8aJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214784489"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:42:06 -0800
Date: Tue, 3 Feb 2026 13:42:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: imu: lsm6dsx: Support SMOCF05 ACPI ID
Message-ID: <aYHfDJgLmzKLV_kT@smile.fi.intel.com>
References: <20260201225450.1649001-2-samuel@dionne-riel.com>
 <aYHeY7efMRwSnPtL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYHeY7efMRwSnPtL@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 01:39:15PM +0200, Andy Shevchenko wrote:
> On Sun, Feb 01, 2026 at 05:54:48PM -0500, Samuel Dionne-Riel wrote:
> > This patch set adds the alternative identifier for the LSM6DS3TR-C,
> > just like the windows driver allows.
> 
> > (For brevity, the methodology and DSDT fragment are not repeated from
> > the first version's cover letter of these changes.)
> 
> ...which is needed for further discussions and in the formal commit message of
> the respective patch (in some short form).
> 
> > I have not made any change related to Andy Shevchenko's comments, other
> > than the cleanup, as I am lacking the context to understand what would
> > need to be done.
> 
> The worry is about having SLA0 and SLG0 methods for mounting. Even if it's
> the same device (like here) it might be better still to map the proper method
> to the respective device. Id est if device is Gyroscope, use SLG0, if an
> Accelerometer, use SLA0. Or did I misread the DSDT and this can't be achieved?

And they also have vendor data to match the I2C resource and interrupt with
the actual user (and hence the method used). The Q was if we can use that
information to properly parse the _CRS and mount matrix methods.

> > I am still sending this v2, not ignoring the request, but to at least
> > progress getting the device in a working state.

-- 
With Best Regards,
Andy Shevchenko


