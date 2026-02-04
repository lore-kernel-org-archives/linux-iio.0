Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0714299924;
	Wed,  4 Feb 2026 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171846; cv=none; b=XVILIgnZeu7a4B4DKS/hl0Bxtx6dBJz0FitL911edEuFADTk4SzUB5HxZN8CBVMz4T1sTN8KCTBUTmH3suqt2Jaky8CKB3g4b+SRjCjCTq6IfsIIUIIZekfVs8+ve0keUNE4nr7DLpJiyBzw8TovrbuLquSASIdcwIPUpm9SfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171846; c=relaxed/simple;
	bh=Xx/Yj0uD9Br35wU6BM2RxCfQKOclHvABfDmKfBxDIhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXqm2xxmAlNyRQQs/1jCGtmp/stED+PqlU01kRz6E65RQts7V4cRRgyFCbXNCNS3fh8ro3HAfBKRYI/L1w7lNlNivDp/zkw51ke433N3c0YEiUmbLZOFFIBwVNasSr1Bt3RCKRuGh6N+kTgb7YqCKQFrjMAFdNpSp0/ROYPqQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGmbe6Qm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGmbe6Qm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770171845; x=1801707845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xx/Yj0uD9Br35wU6BM2RxCfQKOclHvABfDmKfBxDIhE=;
  b=LGmbe6Qm6v38ym/KHTsoDubM3mR6LoRppSYF0ry9KpBHTf6Hnml6zJZj
   EAd5Z1xAiL0VFhP7/reQtag3g4k6R+08L5PIHTTslmJh1Ot7o7psA45Zf
   1Ofx67mRAWz9Ybx8qjQRGAT6ySFLOEP9JHjW3ko9jxREZi3y2gPnOpEw3
   FONtDRRG5uC4y5uLoey8bnjjhtjZ632Si5cPKSr07Gs0TP41tFANRX0nF
   xB5tzxDuK8HRDQuG6dBAs7GkmW2SyNyCLvs9OEbLheptyc3UuHgM0SSfR
   I8OzHbj5Jjr6Cj1LaLyMOLmIPyYezBEElaOMc1+tjINqILIyIRwfMP6Kw
   Q==;
X-CSE-ConnectionGUID: GBJBqn1jROe1uWYUgmNpKw==
X-CSE-MsgGUID: N6jhQn16SLW+8JDpqCK8sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71435690"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71435690"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 18:24:04 -0800
X-CSE-ConnectionGUID: H7cfBrlKS6KA05YKF2za0w==
X-CSE-MsgGUID: VZBk8KvXQLSIi2UTBhTAlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210097087"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 18:24:01 -0800
Date: Wed, 4 Feb 2026 04:23:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 9/9] iio: amplifiers: ad8366: Update device support
Message-ID: <aYKtvkITB3QFjnJB@smile.fi.intel.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
 <20260203-iio-ad8366-update-v3-9-5d5636b5181a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-iio-ad8366-update-v3-9-5d5636b5181a@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 11:24:15AM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add support for the following digital step attenuators:
> - HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT, 0.7 - 3.7 GHz
> - ADRF5720: 0.5 dB LSB, 6-Bit, Digital Attenuator, 9 kHz to 40 GHz
> - ADRF5730: 0.5 dB LSB, 6-Bit, Digital Attenuator, 100 MHz to 40 GHz
> - ADRF5731: 2 dB LSB, 4-Bit, Digital Attenuator, 100 MHz to 40 GHz
> - HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
> - HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
> 
> Additionally, copyright notice was updated with current year.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


