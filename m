Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EE36F91F;
	Thu,  4 Jun 2026 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555443; cv=none; b=JNrQ66UdBSbhnrdoi42pi99Y28a7yyZuwh20bo3TSwfzOIALnv3nzPL7u7cxdkSp5d8NAdmJ0eI0YYXVhYIaCLdglw3doP20W4Kwp7s3kEp03SkRgeef5gqDko5aeUICOpsImXfpFflXLPcHo7i4TfDI7lAG1Kst/IxPSttnyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555443; c=relaxed/simple;
	bh=I9gpjeWC9XNwlkkPlCY/2zYAu8ved+462plCF+qx1Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbTI/5A3loQ4l/DlWgtvcUzne+ikBSn61yRjup9/jnu1NVqP8rppb+mZhHAvEPdvl/AG4QSfIr0+D2D34ztTS2+c91hJW7E1YFBg5OXQeAoxObVAAw6rSMmfVxk9ntcum0gy1vfxFcmY1bSfrkZHWqebX5YLOSa84MYMZcilHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVbzsjls; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVbzsjls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780555442; x=1812091442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I9gpjeWC9XNwlkkPlCY/2zYAu8ved+462plCF+qx1Fo=;
  b=PVbzsjlso8sidKovfvi44KpsbfZcaBB3JEpmmcnRPy5kJW6d5hE1FIkE
   bg2TATzwtCF2fgFEvG0HJQA97UA8CZBvKHOblj+kRh6J2dhBt7DhC1Fqs
   S9MiO3rI+jNc2JPzUA5FnfLAZqqu293pKbVtyEqAtsewC67Gm2uVZP0ZO
   8qLfWKFWyxhbU387WBv9wDeZesNrkvbrL3PV3YjnsnMk07g4nsaVq71tH
   AqPov+8i7Cln04+ZDO5oF34u7DUK6XM3s5skpgcdRudXnGstedqGDoF09
   WAiqAxijW5sGv7hwHWi1tTFZLGIt3bn2xnkeuP8CuJCT4jm0orIwzmIhH
   g==;
X-CSE-ConnectionGUID: f3nXbQnJQP6crpqMG+WUHA==
X-CSE-MsgGUID: /RPAFF1xSByW3Ceo/eJ2qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80517076"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="80517076"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:44:01 -0700
X-CSE-ConnectionGUID: RQcnoIAvR2O6xx9ZioqS5Q==
X-CSE-MsgGUID: LI4MrR0eQGGoSDoCYOoSGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="274697039"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:43:59 -0700
Date: Thu, 4 Jun 2026 09:43:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/8] iio: light: opt3001: use local struct device and
 i2c_client variables
Message-ID: <aiEercskB3aV9IV-@ashevche-desk.local>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
 <20260603-opt3001-cleanup-v5-2-3ef7b926d555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-opt3001-cleanup-v5-2-3ef7b926d555@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 07:12:53PM +0200, Joshua Crofts wrote:
> Switch the driver to use local variables for struct device and struct
> i2c_client and remove struct device member from struct opt3001, as the
> former can be derived from struct client.
> 
> While at it, ensure that parentheses alignment is correct in functions
> that were changed in this patch.
> 
> No functional change.

...

>  static int opt3001_read_id(struct opt3001 *opt)

In this function...

>  	if (ret < 0) {
> -		dev_err(opt->dev, "failed to read register %02x\n",
> -				OPT3001_MANUFACTURER_ID);
> +		dev_err(dev, "failed to read register %02x\n",
> +			OPT3001_MANUFACTURER_ID);
>  		return ret;

...this and similar changes should be dropped from this patch as you anyway
convert to dev_err_probe() later on in the same series. So, please reduce
the churn.

>  	}

-- 
With Best Regards,
Andy Shevchenko


