Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A044DD3C5;
	Fri, 16 Oct 2026 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157699; cv=none; b=NxuNO9yA0ULBkFRkNR/awTEMwxCKtSjWJiPHxG0VnzY2+wiwmy4bavnaiw0WHl5X785ZoOxUJZnRKIHOziuQY8jdrS2/Ab059v0S4LHe0lnMt4D6QjlHdWY4+vABYQCPSDXCAVr9asR+I236UoIkZdPqFst/+17IY5EymGvwdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157699; c=relaxed/simple;
	bh=S1A05S73ADJaQSvm/UP/khLV1SiJNFFE4BN1Ob706d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ/hyLX2LBn9nq9OIn01UUmGiQPoYN0RTIOExJxxXeGQi+R7oNUshKXiN3swH+jpFQ6/xII/uO5p3VplX+RtGR/fwPzJI2XXMtsjki+w4TF84+f3gLCmO512HiCAmCiPwG1GTI1vWxxnmOoHgvsX6Fa57iCFjBVehHGeDGB0+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sd/lRglK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sd/lRglK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792157697; x=1823693697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S1A05S73ADJaQSvm/UP/khLV1SiJNFFE4BN1Ob706d4=;
  b=Sd/lRglK/SuYXXIR1wwSa89o3MQE35Lw4UMk3MQwFykdanhFLvBFw2MY
   SfEDtohHFUfdTlT5QDl2boryoT3RogldfI8gUBfq2/oc4hu+nlb6w0ucf
   lZo+/oKv5gUAfjlEqp1xlZspHT5b2YDOv9Y91GYUMjsOGNs9PoSadjhLt
   U7esMi8Z5BhQtC/qQjfEWaPeuhijJ5Q3oOJ4hjzPRCc1a9zWiJx6OJofE
   j7U5sAOEHw5riyqVhZY5VYHc+b9/eXpH+xxfU9+aZnvCHhrBfc/8Pueah
   4TZH/R7MNDpSgLv2SR3V236X3bOMGLeMY36ufea6of7UQ9HZ5avSLycvU
   A==;
X-CSE-ConnectionGUID: 90fgvJsESDqbIJpiz6C/ng==
X-CSE-MsgGUID: jFIWzyIISGuuDVtKsZjHcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="951237"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="951237"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:34:56 -0700
X-CSE-ConnectionGUID: XtG2S+i7RiaSDd1fbp1rIQ==
X-CSE-MsgGUID: zSFJHXqiRruZ1+h/qcFX9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3736595"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:34:31 -0700
Date: Fri, 16 Oct 2026 16:34:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: accel: adis16209: add missing SPI and OF
 matching table
Message-ID: <atIn5M6l__WKsjyv@ashevche-desk.local>
References: <20261016114527.128364-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016114527.128364-1-shehryar.amd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 04:45:25PM +0500, Shehryar Ahmad wrote:
> Replaced old manual matching via MODULE_ALIAS to modern SPI matching
> table.  Also added missing OF match table for DT based probe. Compatible
> adi,adis16209 is already enumerated in
> Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml

Both LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


