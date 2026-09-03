Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8D3C13F9;
	Thu,  3 Sep 2026 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416772; cv=none; b=LQR5o4jv740JnrJMP/MFJ/hxvx1IRmwdNZCenD34fmy+C+LO19RrujoZ02UGM/XE/MkLUNO5vYx+M/pVLhdYWqFonqvmu8zErlnptADWDKrcVCpShqEfxUj+kVwIS3QpLAFzSHAcDLmNIFjROT1rlzQVvql9XXg23KpznF3plAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416772; c=relaxed/simple;
	bh=XDns49MqTmXT/gYb6wNEuXJgGazq2MKUCvqx79q7NAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX+HY2NRXIvV8xPVP9yUKmAXRKnnsjI/Sbe4iNAABeH/mi7snegcJnCmoARwfeE9yVJO3KJagQ0vVjSh4nH7jMBU4DHpaAY8XxgDkNMI5izzfA/lo+NM0sXGkINSnKaxi8mgauF6YCZRe+or7LI18/b4Vee851oacxoS0UrgLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9ddF7xO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9ddF7xO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788416770; x=1819952770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XDns49MqTmXT/gYb6wNEuXJgGazq2MKUCvqx79q7NAw=;
  b=Y9ddF7xOtrqTf+eGY9HWm2S6ChTpOzagnSaifgoEUX5nCgewJ+VOiJyW
   CcdSYzYqgctwZbahzN0XLSDuUtJ8SNFgHyOW7fnM76EEHt/W60/OgWrfJ
   d5AT0Z8Ln8UF/VMe4CVxE3VIdTHP2K29Pt2UnKOaHQMLOcedjg1aITWdX
   0LaaBz4HtBmQHS5iIndPVu+RqBUPuCHU97o8f2E5gPzZ4ZfEi9Cnz4NxA
   61PYEuCeH/EzdY6704Th7YsxrAq7MFOKIjWU6gqfyOVZKKJD1ht+GUiNR
   kGkChfyJPYBXeIeqHpCwSIggiVU6fZy8ZxGtteENUsJJhoHuFcmgsp1oe
   A==;
X-CSE-ConnectionGUID: aoaDIS65RGyH+s6rGi/C2A==
X-CSE-MsgGUID: s0TVQdJZTpyBSj6DLpSzgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="100243498"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="100243498"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:26:09 -0700
X-CSE-ConnectionGUID: Zo9a0di6Ssui+FMN1Pq9mw==
X-CSE-MsgGUID: X0LJ4lslSKaennE2NY7fuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="266375521"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:26:05 -0700
Date: Thu, 3 Sep 2026 09:26:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 03/13] iio: adc: ad4134: Update include list to comply
 with IWYU principles
Message-ID: <apkS-zZGmELmDzQi@ashevche-desk.local>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <22e82ed7b6d6c04f6347f8cdd0c675ea35fcc22f.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e82ed7b6d6c04f6347f8cdd0c675ea35fcc22f.1788368334.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 02:22:16PM -0300, Marcelo Schmitt wrote:
> Add includes that were missing (according to include-what-you-use tool)
> to comply with include what is used principles. Namely, add bits.h for
> BIT and GENMASK, and time64.h for USEC_PER_SEC.
> 
> Remove time.h which is covered by time64.h and iio/types.h which is
> covered by iio/iio.h.
> 
> While updating the list, organize it to follow current IIO include list
> convention.

...

> @@ -7,6 +7,7 @@
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/bits.h>

No need, bitops.h implies it.

...

With that being addressed
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


