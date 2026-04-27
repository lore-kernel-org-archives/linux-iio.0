Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136B29ACC5;
	Mon, 27 Apr 2026 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276434; cv=none; b=T7/V03PrUPZc8fAiFyKMwfm90owT5R1D3yzFvda13x28KP8ydFpqnBxCe39MQqWlKN8itH57SG4tw1UGZ+dgXdMwW+YTGdLUcftbeta+u7CNvDCMECqEgna5Rkk3O+ol29lYamkQub7x+ThgdZX11LTmoxkbdxSYiCYTkUZ10Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276434; c=relaxed/simple;
	bh=aXXauhBu84m0zkaw5xvXwETxYMmftmj0mucH4ZqZV8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBQgbTKsvuwcZaUTyE/7lssNBSF+3kcQInNC3iB1I6oMpG5maCZNT9HVPyJMyETlRs2IV99Okrt6X4vSZ5rFaFpTd/QqX1HvF1zZu/lLliKgqEH25+MKzfDKkSAYXicQGZEHSp9e1GLJG6wlaH/7sZdX8B3modnw2aa7DO2NzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUvjZHfW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUvjZHfW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777276433; x=1808812433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aXXauhBu84m0zkaw5xvXwETxYMmftmj0mucH4ZqZV8E=;
  b=PUvjZHfW0XNDjFb4HUoQg3j5pEFg5vAeJepaqaXpmDSIPWShO2MhibPL
   Tbie7y3ccrZlBhlnunCg2oQOyK/aew4vORp8ULysgJWyLZe9YL/0RiNn5
   gQYzIAFwqesMhJfo8krnfhzAZ/nVeC+c7JecvakrliReI74LJ0NeqrBNE
   MnixcIfXLnm34h/IcVIfIcrKC4nwl3Izr8cKNsli+WlBN8eJFMUjqTTrz
   9GkFHesTv32JvBOB1NjX20W49/Ldhzuv3bsGu2T1ASZZzb+tmN10iOWp1
   IkvH0InfOOOH4jMrWHpJShPuZ+dOJRcR2qqW50ORhsWMpaE1oGXcHQRpF
   A==;
X-CSE-ConnectionGUID: wZHV/mtRTvSagPBzmJDsLw==
X-CSE-MsgGUID: bqQo9w/QSayQO0dFX62V4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="82018805"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="82018805"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:53:53 -0700
X-CSE-ConnectionGUID: zQnQN4EmRNuCfc+D6/YTJA==
X-CSE-MsgGUID: nACzrQHnS0+BN93wq5h6SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="227036888"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:53:48 -0700
Date: Mon, 27 Apr 2026 10:53:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/4] iio: adc: qcom-pm8xxx-xoadc: remove redundant
 error logs when reading values
Message-ID: <ae8WCnjrI-4XuWPF@ashevche-desk.local>
References: <20260426-pm8xxx-xoadc-label-v4-0-0ec782362615@smankusors.com>
 <20260426-pm8xxx-xoadc-label-v4-2-0ec782362615@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-pm8xxx-xoadc-label-v4-2-0ec782362615@smankusors.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 25, 2026 at 08:39:16PM +0000, Antony Kurniawan Soemardi wrote:
> Drop dev_err() logging for -EINVAL and -ETIMEDOUT cases and rely on
> return values to report errors, reducing unnecessary log noise.

Assuming that this error codes go to the user space without changes,
this LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

The EINVAL --> ENOENT can be discussed / changed separately later on.

...

> +	if (!wait_for_completion_timeout(&adc->complete,
> +					 VADC_CONV_TIME_MAX_US)) {

I would even dare to make this a single line (82 characters).

-- 
With Best Regards,
Andy Shevchenko


