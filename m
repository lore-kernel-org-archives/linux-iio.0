Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0253F164F;
	Wed, 22 Apr 2026 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886702; cv=none; b=ELB7DTCMqRTVameNbGR2sNaRNehy/7ZlMQCmOW+uh1ugxSVSVCmUrGO+WR96Y3gQSxg0Wbx7m/X18gI7xXqlp65ajInHNkflzB7opKbFHhVSjRSUBL1BVU+j3clMafLgEn+HhxwyCjupKujPz2M9yV9YVCxyecMVXPypGec734E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886702; c=relaxed/simple;
	bh=DE0FPvjfBYotEQi2eAupMjb+IH+bLEmgiAAFZw0n0Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXeCvcduYBueUKiHYxTlyAnX+LtzliK0PACL0TevwM+iYYv+Pmerv4zRBv19y70at2yzbm+3gnLtgVE7+NzIdCmOBLO5hLD+YcwrDRp8BRKXNGjbjEIJ4tNsDNLeCQ87EEaUjd4C9qKxV7ffeAeQojPb8vgxsQreSrOZJZwVUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcNmiiV8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcNmiiV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776886700; x=1808422700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DE0FPvjfBYotEQi2eAupMjb+IH+bLEmgiAAFZw0n0Ls=;
  b=lcNmiiV8cyZR2uxPxfXr28WXitoHKU2cwV/jDFWYIA0ibbvUIZGbog6u
   3F3X8t52AaxrfgEIgzDGVdqnPmLM+hf/Fr9dQeMDXZVetZwr1yzUYhxab
   WmbRVOkPPKP4kqhsi1TgFYgLeJU6glwoGN2Z4W8fQhS3LG5tMSrHIMGKK
   aIAo/XTfSXqM5Ki2cQnQolDjmxJGCqn4lMVYYiPm7DcbzSA864BsqIQID
   Tch+zOaE5XZLLmnazFYxDwwVRPDsR6OgeUeZYgYSccniKkD91e7DGJJEU
   cdEmQmVoQ7dOKKYwW9fiGPxo7J3jzStuzlRGGzQFmoOA+se1rTJnETPwW
   Q==;
X-CSE-ConnectionGUID: DZsKSULBQbuuiZJ5wosgKQ==
X-CSE-MsgGUID: 3JvWZPu8SCOyViw63qd43A==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="100504308"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="100504308"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:38:19 -0700
X-CSE-ConnectionGUID: wxAXZq7hQUqKP85lOKWqhw==
X-CSE-MsgGUID: PsCeOjYESb+E/SQVioOaJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="232301317"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:38:16 -0700
Date: Wed, 22 Apr 2026 22:38:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
Message-ID: <aekjpkSW_BXO2Y_X@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
 <20260422165643.2148195-6-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422165643.2148195-6-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 10:26:42PM +0530, Sanjay Chitroda wrote:

> Use pm_ptr() and DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops pointer is
> automatically handle when CONFIG_PM is enabled/disabled. This follows
> modern kernel power-management conventions.

After this patch there are still CONFIG_PM ifdeffery left, why?

-- 
With Best Regards,
Andy Shevchenko


