Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AE37C0E1;
	Fri,  8 May 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234304; cv=none; b=gFSw6xqcoQHbLOYJGQSPSwPgxNQ/wZvi6BXZfjBSImRwdMu3tVZYKvSfWFjVhII5QLGX5yNNFzPg7U3o69vlKpRBImE1p0WwuYkRTyTWMClXKovH7BIgt9+Vgs1I3yNtQ755qD8ITMor8Z/COUFIx6FUvhbSFxW7QBxFtvXLnmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234304; c=relaxed/simple;
	bh=1HAGahbBOcrkVACYKbjOCX60vAQb2Da1hcbOoqaetn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yril7UMRsnh9WQghCViFFbO20K0iMSd1aTDtsLeXOG/a7richc4QFgA8NSM7e3H+aEynlkttJonJqpqPzBDYc6lX9ku3wVQx112G2mcgV53dsbbVECl4AH8C3DBpwTYRSYUOf/TqT+M3B6+8yL1sgRKs2ob2RRsRalNxKoMR70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RL3p05Pn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RL3p05Pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778234304; x=1809770304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1HAGahbBOcrkVACYKbjOCX60vAQb2Da1hcbOoqaetn8=;
  b=RL3p05PnEVzPhZuCGhAnkihKPCHK4FThy2XH3SUqp3S5L/2seSpAf6mw
   3tO+WSKj30OwXU5eXSQPVdzH02qL7hzeZ87tsArWW2Eb4fh4fcfeKrZT1
   uwK9iBkTPaAAiXs0BxuoMF1/6wUZQBIItPM1UT2Y+Jr9WfYlVA2IqnLn0
   ynzzyvONKvvxDAN9eYoaksPCxMbr1IysAo6OvN1YAlqMm9g1Ob/8RBVWv
   LBlk4KXZEXAHabvQicUsC2AB++OR2cWyNFlEEDwsNkDbFApZ3F3QT7wor
   6h3XwKXKX72/Oc8FysGD9TVntnRF1sVBPaPY0hYz0XzAEm2voxxEdB2WV
   w==;
X-CSE-ConnectionGUID: GY+NKC30TUOZez0grauCgQ==
X-CSE-MsgGUID: vGJWaw13Q1KXEdMe/Z/wUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90301530"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90301530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:58:23 -0700
X-CSE-ConnectionGUID: tqxAwIURRducGySlwU4Waw==
X-CSE-MsgGUID: mMoe8XlgT1eDxSkH9qIJYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="232192415"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:58:20 -0700
Date: Fri, 8 May 2026 12:58:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
Message-ID: <af2zup3PFlgs2DtE@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 04:35:52PM +0200, Joshua Crofts via B4 Relay wrote:

> Switch the driver to use managed resources (devm_*) which simplifier
> error handling and allows removing ak8975_remove() method from
> the driver.
> 
> Note, on error path we now also set mode to POWER_DOWN state which is
> fine. Even if the device is in that mode, there is no problem to set
> that mode again, it should be no-op.
> 
> Additionally, remove any pm_runtime_get/put*() function calls that
> dummy cycled the counter to autosuspend the device.

...

> +static void devm_ak8975_power_off(void *data)
> +{
> +	struct ak8975_data *ak = data;
> +	struct device *dev = &ak->client->dev;
> +
> +	/* Only power down if currently active */
> +	if (pm_runtime_status_suspended(dev))

Is this one a correct one?
We also have pm_runtime_suspended(), which is different.

> +		return;
> +
> +	/* Soft-stop the chip before hard-stopping the regulators */
> +	ak8975_set_mode(data, POWER_DOWN);
> +	ak8975_power_off(data);
> +}

-- 
With Best Regards,
Andy Shevchenko


