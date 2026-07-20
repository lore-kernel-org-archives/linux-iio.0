Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DE3DDAFB;
	Mon, 20 Jul 2026 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547225; cv=none; b=QG7f3fZkasV9JUMxDwMY7GX8hWDvo2pWUg3Ur2QxKixYkcxLKeHtnqaH1neOcHDEGeoIhIDGfwOJy4CbxqyqoGELlAy4vHQeYt7pGd3BIcuKxHT2MT5GqrLnLplhrs3szed5h6f8c7TTLrd6u0VM3E8X7LrYkvb9XvJR/W9V1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547225; c=relaxed/simple;
	bh=vSe1Rqk1ST0HVBj77geO8DRSvbPy4JV0STAzjzDBoN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR79XGVk/Mzrl4ZOe0j4fNEPCnHpVRzbAjclR/EOgqGS2IyTb5iad9FbGde6zu4qyOSDXT2YBFGZbedaCXa05hqfHN/0Hcbi5dig5IKsLtK8fUHECTpDkcIAFhgjiOR/OS1Pqll7TDVjlwLxSh1GgIKVY9ssEcDBmL6eLRU/SkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpfxJ6Xv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpfxJ6Xv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784547222; x=1816083222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vSe1Rqk1ST0HVBj77geO8DRSvbPy4JV0STAzjzDBoN8=;
  b=gpfxJ6XvCncIVI5aYfEG+4aTRMt6+KzI3yvcUWRjxCsQcxSOlWFHR8iL
   Czj/PWs9VHIcKZPiaypw71j5ZP8zUlfrUwkosVA+d6/GypE00IkFcrYmR
   yw/Bol1V1yHa7t2+H2rjgQSK7nd5eAHeg9hqFOgavJgOJUA10oB3eDAp0
   vidAH+VBRDxtWPtBwj3CV5XVWahw4HTXOBRTxWF9OIbRn64NJYBoSDtUa
   JVXYoVo+K6N4Sc3/rItgCsAI6rTZo80Ku0sJT9jatXqOkw36QaH+uSBwG
   w5eaQyZbFayI3LJJCojFPUbT/ThBJCgfLu2wpt7vM0GbpUCTvjMr4dnqo
   w==;
X-CSE-ConnectionGUID: RioKcpsVTGai6keGX03cGw==
X-CSE-MsgGUID: gC3AaZ2yTcWv/qTTrbxMzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="102675439"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="102675439"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:33:40 -0700
X-CSE-ConnectionGUID: s3L9+m+uS5Sfb2S/OkUXTA==
X-CSE-MsgGUID: wFZfjYG+TDWrscIoF+F80g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="253062336"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:33:38 -0700
Date: Mon, 20 Jul 2026 14:33:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: inv_sensors: better timestamp alignment when
 using watermark
Message-ID: <al4HkNK8kxxqUY0V@ashevche-desk.local>
References: <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
 <20260720-iio-common-inv-sensors-timestamp-rework-v2-2-aec31446809c@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-iio-common-inv-sensors-timestamp-rework-v2-2-aec31446809c@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 12:38:33PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Current interrupt timestamp alignment only changes the final timestamp.
> When the watermark is in use, we have a batch of samples for each
> interrupt. The current code doesn't manage to align the timestamp
> because the jitter is too high.
> 
> Instead modify the estimated inter interrupt period and use that to
> adjust the timestamp alignment over the batch in a linear fashion.

...

>  void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,

>  	if (sample_nb == 0)
>  		return;
>  
> +	/* no previous data, compute theoretical value from interrupt */
> +	if (ts->timestamp == 0) {
> +		/* elapsed time: sensor period * sensor samples number */
> +		interval = (s64)ts->period * (s64)sample_nb;

The both variables are unsigned. Why do we cast them to the signed type?

> +		ts->timestamp = timestamp - interval;
> +	}

...

> -	/* no previous data, compute theoretical value from interrupt */
> -	if (ts->timestamp == 0) {
> -		/* elapsed time: sensor period * sensor samples number */
> -		interval = (s64)ts->period * (s64)sample_nb;

Yeah, I see this is the original code, but consider revisiting.

> -		ts->timestamp = it->up - interval;
> -		return;
> -	}

-- 
With Best Regards,
Andy Shevchenko


