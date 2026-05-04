Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36C1F5821;
	Mon,  4 May 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906094; cv=none; b=kD5/uprsAGBA0xr2B+sIIpTKcgPwUQ8GXeRxhdmNWMWbzTX3j6/4Sd1e3DZoUyR+N5g/q7EzlEmw1hlX5u6zmBYiKHSyeSMwUFgbrSnVhAyeSmDDtY3IPUak8Xen5xnDiivN7l5mov3y8On3mrWOrOxrl/ZiPKwyzXgan272MZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906094; c=relaxed/simple;
	bh=7hsSk15Y2U3a/cX1TKeGG4qGJqRpLuKOjb/Uwip3l80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgblY+jvlnY2v0JebSfsmjAXwm/mqPSqOzImdsCp1CW7k0aJrKURhW5u+j56ZFA6o5a33Q1TnIgy70/tjXsO9KqAFKyX33Ft8NSvESV+v5zvulBvul1ZH26NmGzudA18FoUToC+85c7vTyhkdsuliqOUhTpVc9IUx0nkTGXpx28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSQGFfWn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSQGFfWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777906093; x=1809442093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7hsSk15Y2U3a/cX1TKeGG4qGJqRpLuKOjb/Uwip3l80=;
  b=JSQGFfWnzCkiC2KmFXvgVdNrosJIKODzLXwTdrUqD4bsR54hDljnUzxp
   6sBq7EgWw1rtMZBMR6WJs7p5klHU6hiAPYNLdWcjo9uURvh3zbaYHem8W
   KriIWQqCpVrHhHm9L1jZ2nmx27OJlEQdWl6iVc3lLLginEJbltwXuLyNA
   FK4hIAMRyECa9iRcn/fsfyQubXSH220d71JAsPUVnzoGUD6fh8TbqTsSw
   7va78oF72zcFaKxsF3lbBIYCuXCXnyCIdv3GM02JHEJqczkU7czBlTfM4
   NV5DFrkioMhvwYTbbxsw4w5i5u7yuInvOaw4+pdc/sVFPD9ew24xxqn9A
   w==;
X-CSE-ConnectionGUID: sR7uzCNeTqCrROMrH0Uh3w==
X-CSE-MsgGUID: G2eUYtuVT2SBukL3hzXcng==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="104212275"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="104212275"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:48:12 -0700
X-CSE-ConnectionGUID: 0NI7P55ZQgy2XiHzRNPhgg==
X-CSE-MsgGUID: 47mRiMeQT3mNEKdVgtNIXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="239501632"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:48:09 -0700
Date: Mon, 4 May 2026 17:48:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/11] iio: adc: hx711: introduce hx711_chip_info
 structure
Message-ID: <afixpkdeWwmlps4A@ashevche-desk.local>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
 <20260503120949.80292-7-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503120949.80292-7-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 03, 2026 at 05:39:35PM +0530, Piyush Patle wrote:
> Add a per-variant static configuration structure and populate the IIO
> device fields from it at probe time.
> 
> This is a preparatory change for adding support for more HX711-compatible
> hardware variants without duplicating the probe-time setup.
> 
> No functional change for existing HX711 users.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


