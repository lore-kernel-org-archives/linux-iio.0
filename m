Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB83E6398;
	Mon, 27 Apr 2026 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312589; cv=none; b=ChC+ncW441JU2b7cyFnF+muSLGAmglKAVdH0MByCk8P6SzAyTisr9uoQtpE76jngT7rNYGaxpMlomJWI5BIZmZWChqCgvSMpyrr/Ezx7XGCBVgH0jqC4JIDyCms/XiW0CqnO5E+4/TxNv4g2f6RqroAjN53hUKfSMMd1AaUkevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312589; c=relaxed/simple;
	bh=VrpaQb07irau8edkgn66ClEgMuvOw3UZgNfUwzxGTBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj8nWUPvfwYua6x1CMhnZh11AkrKuOKcs6v9tLTPThJri7A1+r6/NZ/2AQL8ElbvMKpystO85NK2VqvH53mmM/dlJAudwDeISXALLakxUg3p3yQdHMNNr/aPon1Hk+IrXlV8w/eyGuac0bCf5NuP9Mo74AtQ16XWOg+gQddIx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdl/iu79; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdl/iu79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777312588; x=1808848588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VrpaQb07irau8edkgn66ClEgMuvOw3UZgNfUwzxGTBI=;
  b=kdl/iu79QVU+K7NxgPTcLs9rnhyM2e4IlxFE8thXgk+2HeeO7THQroe5
   RB/Hiw6bnNjbl5FubaebHZmEeiyGD3el614a0Cg7pzWpTvLvREwJ7PQQg
   jjzXjazoEygS3W5KjmYPISKYoxJcPdIfOxO7Xf1o6IpVlDd9A/Ms1B7Mo
   +qxhTYZVcrrN3DRGUx+VDKKgF2gXOuiRIOCTePkgRTNApG/HV0n8MsJuj
   z1OUBY4b9Qd/Rtnz7MdRlhZhg2pb6q7LSL1653q8NW/LnA1J5Q+EwyY67
   hbI1p6iHwxQvge6+zrEqepYKsrNe7Zqi4xDrc8mQBAqoBcuLuYmccf0XE
   A==;
X-CSE-ConnectionGUID: brjMXzz+SeqwPE/NDndLjw==
X-CSE-MsgGUID: tPPbMReVQ0CeXc6kcunSvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="95623775"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="95623775"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:56:27 -0700
X-CSE-ConnectionGUID: tXTyWcXnSWG+FC49vrcqbA==
X-CSE-MsgGUID: 4foeXQPSRAWOZE4a2BdgRw==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:56:24 -0700
Date: Mon, 27 Apr 2026 20:56:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 03/11] iio: dac: ad5686: acquire lock when doing
 powerdown control
Message-ID: <ae-jRatvg0XWSxWR@ashevche-desk.local>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
 <20260427-ad5686-fixes-v2-3-188e05199368@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-ad5686-fixes-v2-3-188e05199368@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 12:30:10PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Protect write access of pwr_down_mode and pwr_down_mask fields with
> existing mutex lock. Each channel exposes their own attributes for
> controlling powerdown modes and powerdown state. This fixes potential race
> conditions as those functions perform non-atomic read-modify-write
> operations to those pwr_down_* fields. This issue exists since the ad5686
> driver was first introduced.

General rule, besides trying to occupy as much room as we have to still use
consistent (more or less equal) line lengths. I would rewrap

  Protect write access of pwr_down_mode and pwr_down_mask fields with
  existing mutex lock. Each channel exposes their own attributes for
  controlling powerdown modes and powerdown state. This fixes potential
  race conditions as those functions perform non-atomic read-modify-write
  operations to those pwr_down_* fields. This issue exists since the
  ad5686 driver was first introduced.

-- 
With Best Regards,
Andy Shevchenko


