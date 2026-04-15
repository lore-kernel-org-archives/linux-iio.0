Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B8311C2D;
	Wed, 15 Apr 2026 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248668; cv=none; b=tu3cv4kMnCjOTyGdMSdvnmgX4QHzfCVtHTGG6udjGA1S5xXwUY513JQmuxhUxKEUgJv/VqIF+lGkUoc0Pi37yraAh1Xjx2MIi18hqIbNiv4vSoL8NMNNKEgdiIt51vjcrHlksDU7xiaeHKOlhL1Tm2ZDkFhmEsjFSlOZZmrLDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248668; c=relaxed/simple;
	bh=9IoM9yBXen67tIdLXBhzLdXgkbAmI+roU8zpunyFLjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Muvve5TDY6SePRTsNzo5kevjyswYGssGi4YrGv5rSZgeeVy8zJtiY0f2r1CxAoO+m7WqtgxAX1AoyU1WNEXsB2b+s/AQSjlukI7sSCo8+SbUmqao1mbhM7VonlgTh4JsOKvmTO/V/+n4goOvHlx8HHGQXl7AOj8pAU3dWndae9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2idV4s0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2idV4s0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776248667; x=1807784667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9IoM9yBXen67tIdLXBhzLdXgkbAmI+roU8zpunyFLjs=;
  b=Q2idV4s0MolLMGnSHh+ooxPKAzb3iEy/8O07JD1Rd5wvcI9VVXyiCe5F
   WksxRjLMI+I133WjBWqs8ACy9KjF3eBOf9F9eAHJiFJmYIsX4YTVvsaQK
   Qnxor5JUkCb+JYL573sosKlDHXPn4FtiJlVpk404bRgkMyVKuZ3rL8Tqe
   aDuyP++oF9ypijLSCXmdJeyU6WOowyhFrVnkLlCfy1u3rDF2DaILlwDaF
   fhCXzT62VTZzpAjPzSF6q4Z2pkJRHqJEXJV14xYYCAkvStxNIIZPBHhyK
   VpR/hGuZkMb/Pc1skM+MUxuPbx7WxJbxkpbBhMCwbEXNBR/jW8dssOTre
   w==;
X-CSE-ConnectionGUID: fpQZArWzRbmMhztXMOxhHQ==
X-CSE-MsgGUID: D5G8OXbZTC+jjDN9GFzfOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="99862283"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="99862283"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:24:26 -0700
X-CSE-ConnectionGUID: 5qgTTAB5Q0aueSt/ZSh7PQ==
X-CSE-MsgGUID: 5KNBvISZQ5CI64oinCLDSQ==
X-ExtLoop1: 1
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:24:21 -0700
Date: Wed, 15 Apr 2026 13:24:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v10 00/11] ADF41513/ADF41510 PLL frequency synthesizers
Message-ID: <ad9nU61G-WjwwcFT@ashevche-desk.local>
References: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 10:51:43AM +0100, Rodrigo Alencar via B4 Relay wrote:
> This patch series adds support for the Analog Devices ADF41513 and ADF41510
> ultralow noise PLL frequency synthesizers. These devices are designed for
> implementing local oscillators (LOs) in high-frequency applications.
> The ADF41513 covers frequencies from 1 GHz to 26.5 GHz, while the ADF41510
> operates from 1 GHz to 10 GHz.
> 
> Key features supported by this driver:
> - Integer-N and fractional-N operation modes
> - High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> - 25-bit fixed modulus or 49-bit variable modulus fractional modes
> - Digital lock detect functionality
> - Phase resync capability for consistent output phase
> - Load Enable vs Reference signal syncronization
> 
> The series includes:
> 1. PLL driver implementation
> 2. Device tree bindings documentation
> 3. IIO ABI documentation
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
> Changes in v10:
> - Drop simple_strntoull() changes
> - Create kstrtodec64() and kstrtoudec64() helpers. 

On a brief look this looks quite good. I will review it later on. We still have
several weeks time.

-- 
With Best Regards,
Andy Shevchenko


