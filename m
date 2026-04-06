Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BBB40DFC9;
	Mon,  6 Apr 2026 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500426; cv=none; b=AAlVepeVA4cHHdm2Wrutz6NstQVPmTq84mVS0+mAjRAyf6M+4omnmcqhtVvePWbqDkXA1ZtGAJjTcdgPL5nvIOk9ahjpJCgjy6+GdHWQfrr7xNxoEQTr6Os9InkxwAX8KcogDbmLpgRhJq1JLn/qXH+CKQ7DyHFIVMOMImcof0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500426; c=relaxed/simple;
	bh=S4hIlqmESZzZKTl9wJpgwcDeCDqe8dmTf3YMZbGokvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUcVRV4Mk8rCYTp3LE1ZD8IJYvQ90Xfkucf54W3NQ4M003r579wGG0YGBZPISWM45/hHYEbGBQoSfGOp7vXxWpJ2Onb+q0yM6x5LPPc3NJ3fmq+lNzRNrkVuwPcRJdoFFaQVrLAtFVObpMf6F6VXPuCmRqoWQQIJLlgQ17UVod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaZAQ3ND; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaZAQ3ND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775500425; x=1807036425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S4hIlqmESZzZKTl9wJpgwcDeCDqe8dmTf3YMZbGokvg=;
  b=YaZAQ3ND6QpS7qOfFIGRrQUGvlr1anlfAI0SMW3N8vSCwRbuN8YpDOoL
   jGTMuYZkHYLrYU57k9c3ob5/M4ThS/zF3oRl+9uzHDDsrP35pfHeflCij
   1Q8cY2y6Cg2ic3EpLv3BIBKMLEtWKHB8ZqLtQOd2Nq9ZBu15GpiwcqQuf
   qY/rpuSMu2T3uSLz+9qzX94f0vMQZUM3SPucjouB4M40hRt/Vwz8Il8SO
   MoQat+1f2DKJlBCBbzWGmDJrI7znfE0LAxwXMLsrNpkVkum9NunzukA/e
   pfjn14FWuunyNBpxT/OgSqZZV/B7ps3IRpLbxTqcwafgg4WLGhxl7wLoV
   g==;
X-CSE-ConnectionGUID: OB/liYtwTCWCQmLENuXu4g==
X-CSE-MsgGUID: RPjHEW3kSZitFNBCYvgANw==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76576919"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76576919"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 11:33:44 -0700
X-CSE-ConnectionGUID: JR/OIhDmSG68rqBoB4DjaA==
X-CSE-MsgGUID: Cm/nnFSSTRSV2vbLxsvOxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="228212835"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 11:33:42 -0700
Date: Mon, 6 Apr 2026 21:33:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] iio: ssp_sensors: cleanup codestyle warning
Message-ID: <adP8g8rYuXbfT3Um@ashevche-desk.local>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
 <20260406080852.2727453-2-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406080852.2727453-2-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 06, 2026 at 01:38:48PM +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Reported by checkpatch:
> FILE: drivers/iio/common/ssp_sensors/ssp_spi.c
> 
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));

Do we need __packed to be there in the first place? Isn't it naturally aligned?

-- 
With Best Regards,
Andy Shevchenko


