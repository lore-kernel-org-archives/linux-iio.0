Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436958;
	b=2fubCsdCvGVXwNIiO9Q0wKhMrpqYYC7RTxvCTWNZFf2Qkb/IEMF0tm3EBoMIMG2fOkxg
	 A1i257LETxaZYuRYNc18zV3BpFmAMuqC2ERurH1OwYQYZCGS1LYodZDHNubG1N/1St2MY
	 qskf+U7rKmXrUSztDgImqdI6nsUU7Yc8nB7wnhddaMX20jV2qd21e4Z1oEFdP/5JRe/nZ
	 eHeDPtQSPdkEemCUELewNZtOqnBMf98I5y0O/LfcqvMpJgQgTveQzpfbaOXrE6YsAIUPs
	 UjyhS0LhE5XPLsTo4nmf9XX7zmewxpCUT3qkU+RtwnLaCAn8Lu3zSCFfCGPyQGk5Vzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436958;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=TpG57D5r1lU2T1hO9/UVKS6qEvJQlV4XgEA7nKMmsdA=;
	b=fsljH7G88uKXzPkzySmXPZhyN3PTMUwlouPZDEO4s5N/832UOGoUfToROAozpn8fGvnU
	 Kk8S0ZvtPuqd0FBopJOoyOlhUj2Z2bsBbfDigJtw3Cb67QmM7uwzvS3Fo4oZYrTTRaat3
	 PTZ90znwuQD998b7hvB6ef8YEssinoTVgthieGSQxJcAZ8kLPtGb7R6PjficllJ8iUIcJ
	 HtJqJPA7q7iS+R5GHuDZ6ZUnFNBmt/eKH96eRM6F2SpSMbdOnWRQyL7ZzITxmt9V1lt49
	 i1LTBlz5cK5+qu77YWULmRl6KjKITXu9WMX2PJxjiRZhtjE5QIDWb01Smr4hMlGBO4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QUXGlwPw;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE4606A31F;
	Mon, 19 Oct 2026 19:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40DE4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QUXGlwPw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792436957; x=1823972957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rb/b13h+jFhVWzUzAl3ubaixIgBWcQk/eqQr2GkBJbU=;
  b=QUXGlwPwiTB/R3yi4q/twDsJePMMAIIM1VbEoiQWZQhXeGAlzSWmlGzL
   e7NjNZIyWeAW9xZn9BjFHBFmHWrS/9GqbaoQcZRAlBiUt31bctpOsQ7fJ
   EL3w9KWU9YTkmToIgZvOMwxU/tWp1QBdvYXLK0GGvuF9D8D4eU9n+WCzl
   XuXbFWPgrllZ+vVCUe9a/SJ+rLgmLdfqpsPleXXjsPS3IuuNCatLVjhLt
   hzxwluNBDwhbvxQR6t/3m15flosfI0pxP7rWsY1fXt4DdvPdMBpOWRfLB
   uL2ofE0g5ldp6Jdo+vzL4jTVzmwSWjuXRh1PdajCsUR3hIDSU46hYRASB
   w==;
X-CSE-ConnectionGUID: YaZphw5BRHmrfdGIabZ7pw==
X-CSE-MsgGUID: jzlzFFmgTHWaN3CoLc7O0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1231644"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1231644"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:09:17 -0700
X-CSE-ConnectionGUID: e19MQXKLRQmB9ZoHh1yAUA==
X-CSE-MsgGUID: poWNiUHNT+e8kFbHrSskMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="3077749"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 12:09:15 -0700
Date: Mon, 19 Oct 2026 22:09:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nithishvelan M <mnithishvelan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use
 guard(mutex) in ad5933_show()
Message-ID: <atZq2GstK_rxOgbj@ashevche-desk.local>
References: <20261019150248.416-1-mnithishvelan@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019150248.416-1-mnithishvelan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 03:02:48PM +0000, Nithishvelan M wrote:
> Use guard(mutex) to automatically manage the state lock in
> ad5933_show(). This simplifies the function by allowing direct returns
> from each switch case, eliminating the mutable return variables and
> manual mutex_unlock() calls.

...

>  	case AD5933_IN_PGA_GAIN:
> -		len = sysfs_emit(buf, "%s\n",
> -				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> -				 "1" : "0.2");
> -		break;
> +		return sysfs_emit(buf, "%s\n",
> +				  st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1 ? "1" : "0.2");

You can (re-)use ridx here as well

		ridx = st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1;
		return sysfs_emit(buf, "%s\n", ridx ? "1" : "0.2");

-- 
With Best Regards,
Andy Shevchenko


