Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84134753F;
	Wed, 13 May 2026 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690201; cv=none; b=gbVh1FHUA17v+RmMNpQ4GMfpf3hHPYvXbPk9hWQFst4wfxS0mxMkBb4CFIsEzfu/TiHjazUc87AEq/JbirFMiIO4OF7x1Rq8IbkQV0eGnTJK39yIPrq9u7VBGVLlWoesHYzm2LL+vVMQqA4ayBKMj2aVhyLPLaxY6+7XmLXigZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690201; c=relaxed/simple;
	bh=dsHu5EYz7HduD/lYnRDhol7a0sCp5dwCFcDoS8Qx2DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjMbiYX3ueH/Js8KoVcRlyEqc+I39w1ODBTXzk44d4T+rmfG50mY+eNH0q3wQDfAX6mUaueGkeD6Qk7gxX/0Sdo8DsJvr78313hT4EDGqh3gxouxu/P5AbJ26+do7POIEMoVj0RmMtv3MW1cA1sxojt2e8xig0wIQEUzV2cUhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jm1r40wj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jm1r40wj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778690199; x=1810226199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dsHu5EYz7HduD/lYnRDhol7a0sCp5dwCFcDoS8Qx2DE=;
  b=jm1r40wjd8UNlNOxfTCT3BKhhaQeEeOsJ4GExvKGSY0+wyUUuEtKasHz
   9hA5m+6I10gH4yOU+WfitWZjIi/qPhXh8VdKVCRCqyBUTPKwnmalEnyxl
   Vmmr7koZDEvghQn6TwavY2p5tTm5+4ell7goNkA5CqxSzR5nsmRCjihRM
   tsxgPOc7NJroloWJ5ie5ylAg0x3ZDGrh2noUHZVRKEXomWio9PcZoIgQZ
   LVC9lSi51iqVgArXF2ZHzs/Qnbe1w0rzcjG1fwBkiadRsNrwi+cLCFdA9
   vHbcVtUPb3Wtbk6VYqD+UkamZpklGabjDejv3VaAL09YtKFA8yMzUUcXj
   A==;
X-CSE-ConnectionGUID: aN8CAIPIRGWiGzUJXHqwlg==
X-CSE-MsgGUID: 9biBz0W0RX+AYfNb6Xc+Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83475335"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="83475335"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:36:38 -0700
X-CSE-ConnectionGUID: O3zQEe/TSruU4rpJlE4x/w==
X-CSE-MsgGUID: YJAtzaEhR8aTxGzTb8+9jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237276582"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:36:34 -0700
Date: Wed, 13 May 2026 19:36:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <agSokBtQ5R_6p5Zs@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
 <690B63AD-4429-4045-B413-29911ED7DA3D@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <690B63AD-4429-4045-B413-29911ED7DA3D@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 05:28:35PM +0530, Sanjay Chitroda wrote:
> On 13 May 2026 10:19:44 am IST, Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >These sensors provide two light channels (ALS and IR), I2C communication
> >and a multiplexed interrupt line to signal data ready and configurable
> >threshold alarms.

> Thank you for new driver support.
> 
> It would be good to add blank line after this to have iio and common header group separate.
> 
> Also, header should be in order.

Something went so wrong with your email. You answered with something like 5
lines of text in the messages of almost 2000 lines... (It seems your message
have the full text of the original one + HTML crap on top.)

Can you avoid doing that in the future, please?
Thanks!

-- 
With Best Regards,
Andy Shevchenko


