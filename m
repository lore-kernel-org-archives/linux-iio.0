Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167232;
	b=JBw8180eVbH118gMkAO1UWlQ4fKlfIABxtph6CG9sjujQ2/tOZBzxQnTSicwRFQ8Vw3e
	 Fdhm1z0Fy9Eeh5p7igGW1LTQ1Nar8Xb9A2z6RAF9p1Pf/WXj+iXerS3lrAjX5RLJrstDx
	 2laEcDmp3c3y0nrLFOoF6EPFrzGVYswvHU2TSjivk7smsUAx7sDvKsrfXWLu2eLcw7aW7
	 /iZr5uIivGt/wQ9+Ed5TQ1JMcju08NYhNMZE4e13GT2EdZvKjXCLCm0L0ddpbnf85/aZ8
	 pIK+gf9lnj6NPExPkpLmw2BMMmTGfgsdKq+QnNkS3ddrLMK8cCiH3znmkimMudoqv/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=RSlonO/vo/JHe1MF/tgoJK3TJE7a8ilB8wqiSFZzINg=;
	b=T9MMB4zU/Ld80htwQNybni9nfP58teO/z3EPfaZ8T9MPV97cQj2wMIASuttbhzinp6KD
	 44U4IYjKiLWdduEaR+n3o3erOkMMchHlvDlGNSchN14ep7obfwAPylghvRWptej8On2kn
	 uSKwOfn2/sKS7NLUp5K3Dx6PNwPNztj1wT5zCsGv4PpRczB0LTh3fhRGDH2kt+kbfjCbg
	 5/srgT1L/WdmSoDnk754dLFp9Qj3pCWM7w1/9b/2yqD7aPGzDCY1URAegdJcl/HlkQTUU
	 e1hOzIGCJ+58t5txuQsrcuF5FEo9MglYTxek9Ki8dYlaq71+nRXjZaq2RGxkQ4RcxdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JAQQ3UZ3;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBB60A2617;
	Fri, 20 Nov 2026 09:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83CBB60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JAQQ3UZ3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795167231; x=1826703231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c7CIMdHCya7Bu/b4WWPH/SDREIp3izS58hTgBmbmzXY=;
  b=JAQQ3UZ3jcQyyzIHUKnktWNqtG7g3UG3ExCyezfgGTyqnajnHR9pbFoQ
   4L7TqMaT2LFQUY16MrDbB9LYxJc9QtiviXLO9RccDsIJ393DYetALAwvs
   3J4clRjlfuIxJy4gPZdkxlpjL16nfAKvvaxeqhyH9wF4jluPHCs+285WQ
   4K3MYc+8hfX3QMYXcpkYb4SEGGgSjVYpKMzYNDiJ2sh34W13jxjOra0Yb
   inNIPhlQ+dtlINRxi4ODGj2E1lfoxlrO9F4R6BihePwmBw7zWK5q55YkQ
   6hb+G9zjnslureQmMi2ryh1U1totihkKJtTHuU4iIPK/RHZrT3dDXN1YV
   A==;
X-CSE-ConnectionGUID: V/5ckscjQUycir8GTvIUjw==
X-CSE-MsgGUID: iTHp1vwoSCWCjw4OY+1tEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3939553"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3939553"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:33:51 -0800
X-CSE-ConnectionGUID: W1Pqo1NdQMKeTE58IVV8VQ==
X-CSE-MsgGUID: 1oMwk6dYQZCqzuKnCWCqLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10994887"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:33:49 -0800
Date: Fri, 20 Nov 2026 11:33:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joe LeVeque <joe.l@reflexrobotics.com>
Cc: jean-baptiste.maneyrol@tdk.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: inv_icm42600: return -EBUSY for
 temperature reads when idle
Message-ID: <awAT-ofy0p_uhvGN@ashevche-desk.local>
References: <20261120020850.24318-1-joe.l@reflexrobotics.com>
 <20261120020850.24318-2-joe.l@reflexrobotics.com>
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
In-Reply-To: <20261120020850.24318-2-joe.l@reflexrobotics.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 06:08:49PM -0800, Joe LeVeque wrote:
> The temperature sensor only measures while the accel or gyro is on.
> With both off, its data register keeps the last measurement, so a
> temperature read returns stale data. On an ICM-42688-P, a value held at
> about 52 C was returned while the chip was at about 62 C. The data only
> reads as invalid before the first measurement after power-up.
> 
> The temperature is the die temperature, used for accel and gyro
> compensation, so return -EBUSY when both are off instead of stale data.

Hmm... EBUSY means they are doing something and kinda hints user to come again.
Would this condition change on its own if user comes again later with the same
request?

...

> +	/*
> +	 * The temperature sensor only measures while the accel or gyro is
> +	 * on; with both off, its data register holds a stale value.
> +	 */
> +	if (st->conf.gyro.mode == INV_ICM42600_SENSOR_MODE_OFF &&
> +	    st->conf.accel.mode == INV_ICM42600_SENSOR_MODE_OFF) {
> +		ret = -EBUSY;
> +		goto exit;
> +	}

I would choose one from the below (they all have their pros and cons)

ESTALE
something like this, but error message is specific about file handle

EL3HLT
what is level 3? But we have the only user, and it is outside network
and it sounds close to this case, but why not EL2HLT? (Also the users
are outside network.)

ENODATA
also used a lot, so semantics not so clear, and data is there, but outdated

Depending on the answer to the question at the top of my reply, the error
codes may be EIO, ENXIO, EPROTO, EAGAIN (but if EAGAIN fits to the flow,
EBUSY also fits).

-- 
With Best Regards,
Andy Shevchenko


