Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CE2F8EB3;
	Wed, 10 Jun 2026 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088279; cv=none; b=YCRHTXBdv4mrWXLdc3cTiJwrJtURSLsDYQrcLRGwmyeoMl1eB+UFObfzSK48W8BzS2gYIV6p50GFP14Bolv9ja6EAE3MTrgKS/0LyoDpKKZYWnKdMiFMBpoqKURQomUvwT0vYSlLQEfDcvKeu0bcOfRLONQn7VBKm7mZerAJ1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088279; c=relaxed/simple;
	bh=3Pi4T9vRFlyRBrrNDuQMfCPdAHMKA/ZCq6lsWD17hRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY7OoqQMPKsZZsyC06hnbPLfK8zRkok6H6c7A19gtUGKYge5JJjEXCL6JUOC9ToRbZ750Ct3IIfXSSEa4JFIvwDi0GxeYKgUN/o1ysT/LvYpymkNTpQWs7NBEXnWoPNtpJDGmcv3eofgWJTmT39XZhq0dMRHIy7roS2SSI5zT8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0UL9XBM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0UL9XBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781088277; x=1812624277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Pi4T9vRFlyRBrrNDuQMfCPdAHMKA/ZCq6lsWD17hRM=;
  b=m0UL9XBM8B250eSYUyAZsJl4+PE8ovLJTL+WQVXUeLkDlPh9QE8iPN4o
   u9GPBew3tE5HIJXhCaWvjOJeNa21cgHTB/sknXML0S60UxWfM0gNFKXUq
   MM1Llklge7B/aVc9PxaXV/zzTxX0jc7+wT60expjXNQNZJVtxRb19w5nl
   mhZuxy9EtUbrmEDmZ6+cLQ4hS7q1AEG/2gr4kZB5HAgZ/0Ca/wRcB06V1
   v8RO9qaf6xXDnvJVa6vpWObHEPxsTsJ5JnBJeMOv5ahtLzDSaQzWkahZ4
   CcMd0Ou8ukX4QQneFq6QbyoIDB3OG9hQXuXTdqt9sb24yng8KY0OdvAIO
   g==;
X-CSE-ConnectionGUID: odXtpyWGTp+ICLW11OrEZw==
X-CSE-MsgGUID: j+C3202DQ1msZLQbcvipIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84446371"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="84446371"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:44:36 -0700
X-CSE-ConnectionGUID: aOv5NTPVRu2ocQ/z9zqg5Q==
X-CSE-MsgGUID: ocia4NmLQVO20JfJqYMKww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="284214364"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:44:32 -0700
Date: Wed, 10 Jun 2026 13:44:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
	linux@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 12/12] iio: dac: ad5686: add gain control support
Message-ID: <ailADpIf3GY2Ph2H@ashevche-desk.local>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
 <20260609-ad5686-new-features-v2-12-70b423f5c76d@analog.com>
 <aihYO_X9YEqabaFi@ashevche-desk.local>
 <kzfu37rchq7zjus7jpsy745zfvw3zvpz57l7yqvddolwhb4yth@c7qx3pdq7tjy>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kzfu37rchq7zjus7jpsy745zfvw3zvpz57l7yqvddolwhb4yth@c7qx3pdq7tjy>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 09:25:25AM +0100, Rodrigo Alencar wrote:
> On 09/06/26 21:15, Andy Shevchenko wrote:
> > On Tue, Jun 09, 2026 at 11:13:07AM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> > > +	unsigned short			vref_mv;
> > 
> > _mV
> 
> Renaming would need to be a separate refactoring patch. I'll just keep
> as is and just have the field moved down.

I haven't noticed that it is in the original code. Yeah, in such a case it's
fine as is.

-- 
With Best Regards,
Andy Shevchenko


