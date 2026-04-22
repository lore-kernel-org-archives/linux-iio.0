Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52CA2D876B;
	Wed, 22 Apr 2026 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776888459; cv=none; b=ulVbEMif61ctyojqaEDAeUu/ZNeQj2KrTI4ChCH5+s8rmC+FVaUbAtmFXFOEeM+mmO8HaYhOV7wKuCmYMUUsfe3TViOIPbUDC75Pqh/mmFsRTG75uOvFvA907UI435/p6c/IhAfO3/OTlQxHL7ji7a8Sk5kw3LtFsjnmKZOqSfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776888459; c=relaxed/simple;
	bh=HLLau1ZgdCGc/DGcEKTpYpZPx17o1JJfEXRatzhhzec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6g1B14BRsSZapkY0B263gAiaVtyMNv+/naqdgDG4EbvwygZMjvpohkLuZ4uv5h7/W0Hl/e+y3zUp9c3EnwDrfqplfzfQbw76ZmH6Btz6KU9cbUFLMkW3z0URB99lxbxFuyr03UXRkDD3KMypJAxJVXhImKfqEyv9DctpMQnuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OI8JhCyk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OI8JhCyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776888458; x=1808424458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HLLau1ZgdCGc/DGcEKTpYpZPx17o1JJfEXRatzhhzec=;
  b=OI8JhCykbTKrVUG6nuhTfKc1igvfzuLos2XYkdu7JR1VCOcjVHze7LqL
   CdUn/nETDGT6y2uN9Cet301KizCa50zgEBQSyT0B2I62mLf4ef1DqeNYU
   nROTXVcWfSz0fLm1XscdBVymUoWS42hbUd8VgHcFEK5YfrrgIpg6M6ZXJ
   Qk/1xmj+mhF1tWWfvkdU3RnkGw1EapmWa6WdV4kbKKh1lpbHS/CasL6nN
   LxOwKMAx7eNFrJJ2Aj/XRAzgLLaQsZSfacPIFyLTa4KZth5dgzbfH8R7Y
   FCmhRv6ocljKJSQ65qZTzzNhcG1SVHx4pp8CxBAAWb/OSuvKFTDeE1P0W
   g==;
X-CSE-ConnectionGUID: /1l40OONQ/SWLYzw7Fm2YQ==
X-CSE-MsgGUID: qRCpBSUfT7q+wf2JIgETlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="103313439"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="103313439"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:07:37 -0700
X-CSE-ConnectionGUID: gcil6mfXRw+lb+YR44BQJQ==
X-CSE-MsgGUID: m0p8rUT6QY6Z70p3Sq0Gfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="236448206"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:07:33 -0700
Date: Wed, 22 Apr 2026 23:07:30 +0300
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
Subject: Re: [PATCH 17/22] iio: dac: ad5686: update device list description
Message-ID: <aekqgoWnBOPmN64s@ashevche-desk.local>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-17-ed7dca001d1b@analog.com>
 <aekqUXej04Dg8wk2@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aekqUXej04Dg8wk2@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:06:47PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2026 at 03:45:51PM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> Looking at the core description it let me think that that has to be in i2c and
> spi cases as well. One may deduct the list of supported devices from the ID
> table(s). This also increases a lot readability — instead of searaching in the
> monolithic list, the ID tables are ordered and one per line. Much easier to
> find if user's device is supported or not.

Also make sure the MODULE_DESCRIPTION() text is aligned with this.

-- 
With Best Regards,
Andy Shevchenko


