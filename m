Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1936403D;
	Thu, 16 Jul 2026 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784232742; cv=none; b=N46Z0uu4YOiReEtvVYIRCOOwZyE6dl/mTUsyu17lO4rzOlrnDTvlujqpBvwxmIqgsOb5/zi99CV0GKxDbA/K9c71APF2Mods2I/kJC+tXr9sXQ1gmbApmMHS4v4p3z+/GAAaw9X5zCEEhv+J9aK8pMjiBXyKeR+dyPzmGSDa/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784232742; c=relaxed/simple;
	bh=LHDKe8ABAlPPwJJAGfyf0yG/S51ouZkes/lfka0bxmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEWw5ifDxNpU3Su0d+x4ex1/FvRyp+cghkJKeMKA2/mmdnVSGKSdzpb/jlGKEGxny18l+thjMOBXIUHiXX7Um7EdR9aEoXJ28+xAfg/YOqiPK3V3TauJZeE2KxvCRQuJCDw3e6uZVIZ0Y2X1QcMfgdcgKK5NudygPU454w8VE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfHCUgu/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfHCUgu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784232740; x=1815768740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LHDKe8ABAlPPwJJAGfyf0yG/S51ouZkes/lfka0bxmY=;
  b=LfHCUgu/uDt45wlfFMAMoPbAduUL379i0nUPOIDXF6ZShhiike/dQqjc
   FDfYkNVe5HewMpU4WFCNw5VEjdv/vDAME1yeBwVmkZshg1xuVT3eTb6Zw
   Wej4vwMK5yTq2fGAHIindP3W/9wppyb9Pp9+qV5oETn8PUQc3ElHGflz1
   FO4caXUximzGSfqCMNuaIGuOlUaNKmXVvXLnEMaeQd+O7vb3uGoLuWI5D
   9kDkW/1CvPDdUH2EDWeLBOBZ2leD0f2puzCPmrL0vFkjO+Nxsa4A+irsc
   aoI+r+/9Hj9RjYuNanXKHmrg1PmW9rnlQpYkmZcJPSjPfeg4boYQtK+zi
   w==;
X-CSE-ConnectionGUID: ZngQdT6kRGqfQgUkzhiVpw==
X-CSE-MsgGUID: +RdYwkUYRQWKBADjtFJXXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84761649"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="84761649"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 13:12:19 -0700
X-CSE-ConnectionGUID: ReGrSJluRpyrAMjasNf57Q==
X-CSE-MsgGUID: TLl51aRDSpO0JHU2B0yNxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="260181006"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 13:12:18 -0700
Date: Thu, 16 Jul 2026 23:12:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: OrangeBlack0765@outlook.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: tsl2583: migrate to sysfs_emit() and
 sysfs_emit_at()
Message-ID: <alk7H41lph_OxMfb@ashevche-desk.local>
References: <OS3PR01MB824492E7AFD347208E0C149AAFC72@OS3PR01MB8244.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB824492E7AFD347208E0C149AAFC72@OS3PR01MB8244.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 09:04:35AM +0800, OrangeBlack0765@outlook.com wrote:

> Replace sprintf() with sysfs_emit() for single-value sysfs show
> functions, and use sysfs_emit_at() for lux_table_show() which
> concatenates multiple values. This ensures buffer safety and
> follows the modern kernel sysfs API.

Now it looks good to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


