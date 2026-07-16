Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C72EC081;
	Thu, 16 Jul 2026 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226033; cv=none; b=Uaa5Hb+2xePauB/8wIybcUHDYJKdGI4ZyyeGiUUTckP89x/yineDxBkLZGxM5peF3Bcio8xgiRoNF7BkMGpEZ3KU3AGfoHFkOxpDfDnpjtmat7ELR+uH3QBGzl0pxd0/0KopOrhRN4HqImB+juwAOI1kZ0WDVbedo/gHosedLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226033; c=relaxed/simple;
	bh=24eintMYvxcw58OHzK8Wnaf0Nox9PZE2k7ELRIva174=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNmUDiupmKVJm7kJ+UksvzwV4NvrDZ8kjf/VMBwww2pJyx7eaRnOChQOhbO0nlQQqpEJW3JMVTLDf0Euc1JHsjjLvu/MFt8ugOqV3SedOv2Am2gQi3JdO4RQBcYD49hEsXBWB765WXX9lf9nCh6Idfsr3KAb9vEaIpEIT4KiNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGcAUnGo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGcAUnGo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784226030; x=1815762030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=24eintMYvxcw58OHzK8Wnaf0Nox9PZE2k7ELRIva174=;
  b=LGcAUnGom0qMlNgA3d72rYXkP4lExRt930wpYwr04YjitW/zAtyOh+Co
   y6ndIMT0FpjPjq9JCxGmvjiGyFkGBNmwmrb8oPPA2Q7rRpOwIzaVZAMfT
   upHo+E67c2n+VpdnjdmeDPUBH1vAZgiNzkrOv63e6Ey1oaLsw581GGI4m
   8DpC/tNRWBNYPuZYu/UGVjjUeCkdb5NdUQPb3v4d8O6zXWvGf9vDvlhqU
   mYjeG9gwRJpdMrNvrJ+TxAqHB72AVd0yJwpMIDausocU1Kbn2GNbiPNiZ
   /+Ah6KfVFcsvU9ckUGlHeDUXADbmaqIoh8Hw8SkYcJKdbqroh97IOgw9S
   g==;
X-CSE-ConnectionGUID: /FXkuLuwQRuhxgYAHcECYg==
X-CSE-MsgGUID: TS9kTTQTQEW/QK4ftJne8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84923569"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84923569"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:20:28 -0700
X-CSE-ConnectionGUID: oodpDedwSbOuRPxeLDExXA==
X-CSE-MsgGUID: nqU6mNu2QEe18m2Cx6ziMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="294792462"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:20:26 -0700
Date: Thu, 16 Jul 2026 21:20:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?utf-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: resolver: ad2s1200: use dev_err_probe()
Message-ID: <alkg54Nc79f-bmha@ashevche-desk.local>
References: <20260716170306.166804-1-vo.kratky@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716170306.166804-1-vo.kratky@seznam.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 07:03:06PM +0200, Vojtěch Krátký wrote:
> Use dev_err_probe() instead of dev_err() to simplify the error path
> and cleanly handle deferred probing.

Wait at least 24h before sending a new version. Please, read the comments
I gave against v1.

...

No need to send a v3, now it's a good time to read comments, discuss, take
other opinions. For example, if Jonathan is okay with v2, it maybe good to
go.

-- 
With Best Regards,
Andy Shevchenko


