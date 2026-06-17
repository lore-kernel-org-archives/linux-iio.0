Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6772D2385;
	Wed, 17 Jun 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708032; cv=none; b=YQ6g9fnDA/lNknONPT3OFZXy2INt+mePWs2YGjfh/Xo4cS4M0B3x8N4Ay8F4hYs1m3u44FACzxFd8RSz16prppAETcacVbGuhcQ175Qf6K+Vu7Yqb+jP4iSAilJs6ZmEU2VsmTpZI4U1d+XFPkruzqDK/9VzXjdJgHwGk5ryw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708032; c=relaxed/simple;
	bh=V1NRBosTlHTYoXbxPdpLgFWsOOOcNZZ72MroQat0r84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9jzUOmPEFFW+UC2cjl+jBli+rmlJ/pDb7auy3P5gn3WbVQeoxWl4LrRGcNGSdJYyqzNmIvOxLhvpzxNOr5fF7QJiUe8yWdE8ZDK1DDlw1BZwYHs6tqrrxxNCHeu4z9yy/foBtZMCWeJANyPSabV/GrdOdbguyM5Wz/4EW9iKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDQcuGkP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDQcuGkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781708031; x=1813244031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V1NRBosTlHTYoXbxPdpLgFWsOOOcNZZ72MroQat0r84=;
  b=FDQcuGkP2t23gMiRUfO6X1VMuCjTEX3TUYMmGLYvke7Mq+1zw82ninHV
   KWVs2XnQJzmHvMrYroNG9/JPycsHEdFJWIJK3gudoVyxagwgWh3Q66uFV
   RT+bKCW8qnvPC1rKugrsSTJ0tw2ylvh7PuS4Ho9Isah7s2iEGobrkxTGt
   QDdPscqb5cPs7ducQSEdrou90oMTaocgNb7DdOeI++Ql+Z+VFac90GKYl
   N5ZkL/dyv+M8loPkABVUa1T66omiR3YYJ3cHA1IubTdX2wAvTSWZ6mcrh
   7AujNHVGIHvQ3cdPRSCJ8oVLrr8GAaUaveoa0SX+iGEaokJcfYV/nsqW8
   Q==;
X-CSE-ConnectionGUID: ecExvUo/QHeMqiiakWQOPQ==
X-CSE-MsgGUID: I4LSb8R4SJupMkQIM3e2mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="105308996"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="105308996"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 07:53:51 -0700
X-CSE-ConnectionGUID: 7Klp/y4BSYiXOLj7a21O2w==
X-CSE-MsgGUID: Cvwuv5u5RuGpp99kGs2wkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="248163093"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 07:53:47 -0700
Date: Wed, 17 Jun 2026 17:53:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/5] iio: adc: versal-sysmon: add I2C driver
Message-ID: <ajK0-KmjxDPW_g4M@ashevche-desk.local>
References: <20260616131559.3029543-1-salih.erim@amd.com>
 <20260616131559.3029543-4-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616131559.3029543-4-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 02:15:57PM +0100, Salih Erim wrote:
> Add an I2C transport driver for the Versal SysMon block. The SysMon
> provides an I2C slave interface that allows an external master to
> read voltage and temperature measurements through the same register
> map used by the MMIO path.
> 
> The I2C command frame is an 8-byte structure containing a 4-byte data
> payload, a 2-byte register offset, and a 1-byte instruction field.
> Read operations send the frame with a read instruction, then receive
> a 4-byte response containing the register value.
> 
> Events are not supported on the I2C path because there is no
> interrupt line and the I2C regmap backend cannot be called from
> atomic context.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


