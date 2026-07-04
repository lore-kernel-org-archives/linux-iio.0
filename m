Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECED30C150;
	Sat,  4 Jul 2026 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783172664; cv=none; b=YRbbPR3yHybi7dzUn7efPLDhRMqtHq0pcem/eythE45Lvm4vU/DtZgBNJmGlisXc446Ixn/dDxDXebua/EMOg+XdaC2VqyPOZhAvurXgiY8ieot+XDPjJhobwXerGsvemubF9BRz0vA2Sxi5vh9YazHO8CGPIR+mWf2pZJAtQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783172664; c=relaxed/simple;
	bh=hGDQxo7Ohn0wGMoQC0mqdaFrCpPTHNlyoyY1jccl3xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaImir6QHlTlSQALXnDb66Dlog/IFJfvPQKKul0zsSO3G3T74Wh9mECU0qTs25gaa5hfhE9m7r1fwrpFafb5YolNNVsXjKRhpg1dOg50csUPdKP7onO3BZZbytdhL1dwIS4wOIKwagredK+NfCrnv8nXwCxxbFm0jPcbLz/C5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXgRT9lR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXgRT9lR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783172661; x=1814708661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hGDQxo7Ohn0wGMoQC0mqdaFrCpPTHNlyoyY1jccl3xQ=;
  b=GXgRT9lRTO5JjtikpuvlPDzxtectbydkPCwsP94r+Qe4WGw7/qQWv/n2
   q2E+KtazSMbKL5OJaOrDyMiDpw7Ig7iItsRra8k/pvLYhuPF+B7LPFZVP
   KWVqBuWKiGzuPy9UkVOKLcinQouWwbkx0/OptoZ8wyq/X83i8DWWIXZhb
   PiC+ztzsL/MNNzMRS8XMtDy+l3aMDkoiCWjW/oM2FJLENU2P35Z0AKUn3
   lTtfSBYSFGeAPV5wEf+kRBXBK9kRU2XliUzvP0MVTArPtRZQr4qnBkceY
   AjVTHt2ZSQLCuf43pJN+ZGvs+IYYRT+EOTzG4dTgbICOtpA9cR3lkGBYl
   Q==;
X-CSE-ConnectionGUID: 4NslfbSRRySanm/2pprI3Q==
X-CSE-MsgGUID: FB7JQhwZS4yPpcUi61caVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="83752010"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="83752010"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 06:44:20 -0700
X-CSE-ConnectionGUID: 47qaFs3pR6SXycbVSDPOxA==
X-CSE-MsgGUID: da56fFzNRUaWZqSImBmxCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="291454507"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 06:44:18 -0700
Date: Sat, 4 Jul 2026 16:44:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: add missing MODULE_DEVICE_TABLE()
Message-ID: <akkOMMlfGWzFReHz@ashevche-desk.local>
References: <20260704124224.4579-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704124224.4579-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 04, 2026 at 08:42:24PM +0800, Pengpeng Hou wrote:
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


