Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947FC349CD1;
	Tue, 12 May 2026 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584189; cv=none; b=YDP+Tq77SKex6vktx3lEXgKOPgRGKmX0C/x5ZYUUXI/H7tDCU3lk3Rh3HaBmM11HRSCw6lGFCN5Y1J/8WOle/0VThY72sDwh6rCRybH8JvE2PyOZGzUJWL8fikKQPW0NwqH78OL7TUASn0lMjZdqE3c4O8UPBlpwADiJbgg614U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584189; c=relaxed/simple;
	bh=ohGBaLjeHmPt1vQMs4Jtgwvse+71PlLdqmbm8jBkTho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrUz9KTCNbl9mpqAQ8WgpFXrkjhzt+9z3Goljuyva8yvFl8lMQKVzgYM476bhuco42AZ4tx+K8HtlYGJblhi1AH7lD6c3jCp/6g3gNq6iDXWUZ1k284Ck9xI2W9hvzeAcfyMBAqQ0K2JYrJG3TJ+ufq9MRn33uHDND+KL/oBZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IADZbS0i; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IADZbS0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778584188; x=1810120188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ohGBaLjeHmPt1vQMs4Jtgwvse+71PlLdqmbm8jBkTho=;
  b=IADZbS0iTvC6Hc5A7KL3VlFu2bKGT21HXwKZGN5vy5gBg+qYSCBtdzp5
   X45BEOqsYOmsWRLgxi2Kqxv+gK+HN5An7t6DyDVw0nihF3jVT/PibTbgG
   Ua0I0kGYKaif1aISwhNVF9upUuCJOM1tI2MaRaX0CMyYL87TSTHy6WclQ
   +b7byfybwA3uFJN1lUGVWCo1DidbfuJdcVM2JmmvV8hCfIc3UWr0d2ZN/
   W6bbHyODXc5zqR8zmQy2cy8AEYoeSKX3Bwdlz17ejmbE1blzr5zkjukUo
   n904/qnBS7lzXGJARjIwbHxnte2OxGZ8vAuT0hN8guufub3dUNfW0gqtj
   A==;
X-CSE-ConnectionGUID: a1vTR4zCT02zBfaDNAIdaQ==
X-CSE-MsgGUID: 4cftovIdShK3AE+3L3tX5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="102154530"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="102154530"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:09:47 -0700
X-CSE-ConnectionGUID: 0axKwaqUSHmu9d7EA06d9A==
X-CSE-MsgGUID: XwC+SI0PQUO7knI5ovVOng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="235072424"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:09:45 -0700
Date: Tue, 12 May 2026 14:09:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexander Koch <mail@alexanderkoch.net>,
	Michael Hornung <mhornung.linux@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] iio: light: opt3001: use local struct device
 and i2c_client variables
Message-ID: <agMKd0GVvDxqs7Xh@ashevche-desk.local>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-4-8018cf3a8a0a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-opt3001-cleanup-v2-4-8018cf3a8a0a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 12:57:24PM +0200, Joshua Crofts via B4 Relay wrote:

> Switch the driver to use local variables for struct device and struct
> i2c_client to improve code style.
> 
> While at it, ensure that parentheses alignment is correct in functions
> that were changed in this patch.

> No functional change.

Right, but what I meant is to drop dev member from struct opt3001 completely
and derive it from client. Maybe it's done in the following patches? Haven't
seen them yet.

...

> +	dev_info(dev, "Found %c%c OPT%04x\n", manufacturer[0], manufacturer[1],
> +		 device_id);

Ideally this %c%c needs to be replaced with %2pE (this is not in the scope of
the patch, though).

-- 
With Best Regards,
Andy Shevchenko


