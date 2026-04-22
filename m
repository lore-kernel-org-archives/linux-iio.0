Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF71372685;
	Wed, 22 Apr 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889688; cv=none; b=mi5tPVd+09lHVkYpFt0qLa/QQb4ChwzKR8q/qgkdbYD7Q+477gCWMaOFeyO53CdOtoKunaRkq6GVsUGFBIvzf5Mxf5Q/fMNdGmxZQidCC+1tQtJJ4TFMH7OEoK0p7XYLTrwcyogDcX4Ger8gkNwoKg3UTbTmojbvBeY7+Jz8pMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889688; c=relaxed/simple;
	bh=nNeRYHOhXQoZprrKwwxdGkcK5H+iTWY8NjFprmFvOps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDDxAmNJH7o3ZsR/Uq5J5lI4lRhi+2BPB146XI4K7oJqJpOO/8tEN8ylCMZRi0u3vNKIYbGVxixXe38MO3YP0lD6P3u+tfGZJLJuo44n5qvBxS24MTYXyucWaaNk7vst/QdvhJy8j10bLzHnVdbB+GrgQzvvw1Q2LAfSY3pm6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiJG6fQ0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiJG6fQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776889687; x=1808425687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nNeRYHOhXQoZprrKwwxdGkcK5H+iTWY8NjFprmFvOps=;
  b=SiJG6fQ0JavthR/54rYfh2lkK/YZL+5WYsGPrKJVzkxeMjG5K1H2uwjo
   hYMu9tozwqY5FtE8NSYqSv5wVf7yvhF04ZEpLUta7UeyTDYvtsKs6Qj5y
   i2IQ+Rsw1zankEe3BR2s075IN8vlDi6oT77zk99JawwJMw4r4XlgTJuFn
   JTpnp0YrWVWMILF8brd4D2R7nVO+4LGsiZ5h1T9+6eDJO0QpvLs10T5Ah
   HQhWnh1TlNm4403+/3jQ+AchCfglnUdVMcp/STojSAIAyIeC6siqFb3oj
   d3VhSCMbTi7MQv5y9uWMSGuEbzy+pRIXbnbitys9+ypqtqNTnGIh79xKu
   w==;
X-CSE-ConnectionGUID: AtWfFK2gTQWg10U7FW/pTQ==
X-CSE-MsgGUID: FxZiRLvYTkutqibYYDxbew==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="103315023"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="103315023"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:28:07 -0700
X-CSE-ConnectionGUID: +i85qFizRXWElbz1ps92OA==
X-CSE-MsgGUID: g3HNlv3yQz6DCMJMCpGm0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="236452322"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:28:03 -0700
Date: Wed, 22 Apr 2026 23:28:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Auchter <michael.auchter@ni.com>,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 00/22] Extend device support for AD5686 driver
Message-ID: <aekvUKh2SoAaLKW6@ashevche-desk.local>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 03:45:34PM +0100, Rodrigo Alencar via B4 Relay wrote:
> This series adds support for multiple nanoDAC parts, adding triggered
> buffer and gain control support to the ad5686 DAC driver family, along
> with a number of driver cleanups and fixes.
> 
> Initial patches update the device-tree bindings:
> - Add compatible entries for missing and new parts;
> - Add GPIO properties for RESET, GAIN and LDAC pins;
> - Add missing power supplies properties.

> Driver cleanups and fixes:
> - Refactor include headers (IWYU);
> - Switch to device managed mutex initialization;
> - Drop enum chip id in favor of per-device chip_info structs;
> - Fix voltage reference control on single-channel devices;
> - Fix powerdown control on dual-channel devices;
> - Introduce bus ops struct with a sync() operation for batching
>   bus transfers.
> 
> New functionality:
> - Device support for: AD5316R, AD5675, AD5697R, AD5313R, AD5317R,
>   AD5674, AD5679, AD5687, AD5687R, AD5689 and AD5689R;
> - Consume optional reset and new power supplies;
> - LDAC GPIO handling (active-low, held low when unused);
> - SPI bus sync() implementation for batching multiple transfers;
> - Triggered buffer support, leveraging LDAC and sync() to flush
>   all channel writes atomically;
> - Gain control support through the scale property.

This is rather long series. Please, start from the fixes series first that is
independent on the features.

I see here ~3 sequential series. Can we rather do them this way?

Personally I stopped reviewing on patch 12 (without even opening DT stuff)
because it's exhaustive. Documentation usually suggests the series to be
limited by ~15 patches IIRC.

-- 
With Best Regards,
Andy Shevchenko


