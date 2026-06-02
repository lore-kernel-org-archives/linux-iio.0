Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FC30C37E;
	Tue,  2 Jun 2026 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438642; cv=none; b=NLA53F27DU54/kejZ+1UOqL4Wae/f33okRJLKiDGYvtGPaWTMIVSB+fnX/mtrrWQLnhAd4Npfwgn4R+/qv8PoHPbg8sZK5/thl7yK4ViRwgGH72kw7NdeCMw/wqxdR0IefxSgenbeTbfASZlxt147UD5x5gp4UV94UasicRHR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438642; c=relaxed/simple;
	bh=UHp4R2KbUMqK+YlWY1FwtJ3p5eYTTcVWukkz7P/2baw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZopcFoBqbpvLBoo3eoHHOoGl8eUxLysk3rwu+4lUq2zaCBAja30BSC79w298RzET3hpRbPT+nQ+Li0phSmpS2RAhjT6NN4J0aDIMewQcryAvGwu4GzCCOM0xf3nIT6SdoReEEN5sA5fCyk1NrcrLEtc5z8cYOFzZlIWlmdl43K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFwH3Qcd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFwH3Qcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780438640; x=1811974640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UHp4R2KbUMqK+YlWY1FwtJ3p5eYTTcVWukkz7P/2baw=;
  b=DFwH3Qcdh2gO4B4S/TxBVdB3W34zjDTczueSt9iAUOXYfL2vo0xUAMHa
   HqdtuF3pthbQZ3OHWD2qJJCIpzkFh0JURt+o3qq5c2lnCHrky9h5qCVwR
   PFcKCsVvMoAgqu+LlymLAY2bXVsl+EcOObtFceEnXXdwO49ckp4NfY9LE
   iF7bMpt6wtOxSWMfRUla+VlvCBqlJVpKPS6FgSveR0sMBegGfty4lBo7P
   5sYWicsoODJ58lQrGAPehHp3WXObdlywu2Rx3lJY6Gf0pZWDB2b0b4JOl
   spkpRyHtmSnYAa54IB2N/amD6fYEcG3mldig5T3LVnTyGCTUBPrtYK0AH
   Q==;
X-CSE-ConnectionGUID: /I3LGutAT2adaI5kJfG6dw==
X-CSE-MsgGUID: gh07aCIOTfa7pz29atYq8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80975020"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="80975020"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:17:20 -0700
X-CSE-ConnectionGUID: G1OUcX6fRomyQXw+v1242w==
X-CSE-MsgGUID: ibO+nOPFQUmK6GJOchWy+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="244144138"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:17:18 -0700
Date: Wed, 3 Jun 2026 01:17:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, andrea.merello@iit.it, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, hcazarim@yahoo.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: terminate dev_err() strings with a
 newline
Message-ID: <ah9Wa4jaKZwm_HVh@ashevche-desk.local>
References: <20260520190851.11390-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520190851.11390-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 21, 2026 at 12:08:50AM +0500, Stepan Ionichev wrote:
> Two dev_err() calls in bno055_ser_write_reg() and bno055_ser_read_reg()
> are missing the trailing newline, so the kernel log buffer continues
> the next message on the same line.
> 
> Add the missing \n.

Surprisingly the kernel log buffer will be fine even without this patch.
So the commit message should say something about consistency of the style
and theoretical problems in the future in case one switches back from dev_err()
to pr_err().

You can dig into sources to understand why your patch changes nothing in the
behaviour.

-- 
With Best Regards,
Andy Shevchenko


