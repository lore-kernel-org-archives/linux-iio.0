Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC016325707;
	Wed, 29 Apr 2026 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490490; cv=none; b=fualvatkdmgSnUjIKEESrZOtYHwUb7c7Yaf8dhG06WUOZrw8n/ArpFElrcdKLXHYO42Sl7bIrc/ldgXUozDMG3ZTInvu/ol/R1s5FZFCnqQJHgPQTzP8Xar8uSqPut5omr6Nnj9g/NbhOxHxEyGEWvnHK7j8Rl3bw1uPv+A5blM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490490; c=relaxed/simple;
	bh=OBiHJW9oNZ+zMRwgvcF3sptUGczq7ftl+sjACOSdJfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv3WvNhkHvCFnhLiyZu/C5Feba1T8rhZXN3k0eqyUd/P0b8EUVWRrF4Y4qJBm613Fx35DIOAhjWAmuRFLV9iylODNX8G0Q/A80kvC8X6x6Y5pPsz7RuXMQ1VmY93TDsv1HiCu3tZETQd7kGK+0FPoJBFBFpl4VSGajUwTRH2pbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+6Mgb81; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+6Mgb81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777490489; x=1809026489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OBiHJW9oNZ+zMRwgvcF3sptUGczq7ftl+sjACOSdJfg=;
  b=C+6Mgb81K9OkjBiN8HeveiCh6OYS0vcIVMgtdxJlVFGSj4UFSnVMzpTj
   hJHpvb1vRYlo+nRD/bBSvqLZAeDrJ3jc0BUZ5rpvelXziS/yT1eeyt6v8
   wLMVP6D2GL8gwrXevl1eDlR/G9NwMpjP+XavMM920dqMl9I/c/l7rk3dH
   Wj79SXm8mL63aDX+3LY8hHZ4HtLXMVhbLFdHC/bBSpRPepeZl4JAthxIQ
   EBgQEFGNcjX/guGjXzdPTER8MpjBbpvchiKnomiGEIvvbSwbQNE4Dlbkm
   zaNoi2a5DCEwITSQfGJ5NH0j8+elMe/ggjCFw9wuGoCh+1Kqn5h42vRbc
   Q==;
X-CSE-ConnectionGUID: d01tq0QHRTaVrWjr6aT4Lg==
X-CSE-MsgGUID: 8bPHz+W2S1eDAr3PlJpriQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89807441"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89807441"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:21:28 -0700
X-CSE-ConnectionGUID: zLsdyvcERhSshuwH16Qx1g==
X-CSE-MsgGUID: 3FazQi+eRpizJ6RSJrqggA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="230002721"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:21:26 -0700
Date: Wed, 29 Apr 2026 22:21:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] iio: light: si1133: add local variable for timeout
Message-ID: <afJaNB0WVFJ9z19o@ashevche-desk.local>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-6-469f21d960eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-si1133-checkup-v3-6-469f21d960eb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 05:04:54PM +0200, Joshua Crofts via B4 Relay wrote:

> Add local variable for timeout to improve readability.
> 
> No functional change.

Ah, with this it doesn't make much sense to indent properly but it makes me
think that this patch should go before that one.

-- 
With Best Regards,
Andy Shevchenko


