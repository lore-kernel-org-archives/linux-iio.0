Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095164;
	b=Gnm4wmb0NEIfZa2PrvlYRhDjhmuhfOSWtJWbjptTpDBu2+NpVY4ODoFdEgHvPDFKCLmL
	 1XT/PF7EKTmHst/ke31NjXi9XMDEHWJAX0PQIsoxp3fSkWPgajOZ4rqXMDecYYiyak7T8
	 E1XcX7YIb5Z/qSe4SUDbvBkIh+5q5Nd6MzTyi+R+UqVy+vMzh+QY9519JpPjr0CLVroR8
	 HHU9XxuEhAvt71jELTzv4sLoTXuKpmx05TvVRnh/nHFl/CsQbUoyHddz/jcdrEZjNVPjU
	 i1RTGVzpC43DGURrmWQCCA4tqffToXW93d2iWQekuDbZzxcqagouZvD2Q4jCbsZgVeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095164;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jJLc9qmybkSAr5NsJew4JiBBQUabydgLQJmnHvmAdRs=;
	b=HZvvgauiz0C8FVC4xni3nBSs6NFbvXmKGivRCpIg15xnkSCCB5sE1OiKJKFZOoTSr5YO
	 WYliBr0sL9DfpxHuQcpoScxegne6mUdki0X2OAGXoN8Vg5wTe35m9i8NHNFND+EnU4BxG
	 MtXeW56+T0lDnK4t6ta4zUiZyBp2qa2ktEUMdjIzfhRgi5GQS+PiNOWCCzICFRn3pPdhE
	 cggIh5EZ1lrH3P2XJKdz4wNnGSLpsHG78B9eMbfr0TlWPy8oaigRIarXh3pbGDckQvjtH
	 cop15WJp+4EPom1EjaipI1qT3acOETGjTND+WHyEFD/r1UcpYO/g7t3nBsvGCCc0WSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gCTMZ1kA;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E7C606A31D
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 09:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E7C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gCTMZ1kA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793095163; x=1824631163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1vajDKaKenD94PFHu+Xz6a/3cmY75QWUUf0ZNDFkcZc=;
  b=gCTMZ1kAlPuTuAGgsoc4S1PD+v1qEFdpc92rWImvgJ30qu2bKu67FyNj
   6zTOS3Y6gbiTFRDyqIkKmhumE52NjfiTqAM7ccbxAX9TmJF7U37IiOnBr
   rgSzrrMUdHgpvs/710UoKJ7o22jbK47bhWxSffJuOQRjixaZIlsQUKlTm
   4RIz06B3ZDwNlcPwBGFD7cnF3El/gFWgVuUKSu9Ys42GjC2JRguT3ymIb
   rxZ+zHBsGxA1huNCRDk/TzC+PS8a9WNT4vzvc/nx2o2DZAr6YNOj3i0e1
   Y8ugCAPWoXyAlHd6icawcjw8plWhrARBxT06HOZ53H77f2sbqJHk4FJ7v
   g==;
X-CSE-ConnectionGUID: V0B4dV2ER/m+xPtEaklLGg==
X-CSE-MsgGUID: eUAoHOrGQDqjNA8/7sibpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1821794"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1821794"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 02:59:22 -0700
X-CSE-ConnectionGUID: SlwZF9enQdSUuDwEa4MeWA==
X-CSE-MsgGUID: anrEGKMrTTKEYxIM1yR5aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6349730"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 02:59:21 -0700
Date: Tue, 27 Oct 2026 11:59:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?iso-8859-1?Q?Nicol=E1s?= Antinori <nico.antinori.7@gmail.com>
Subject: Re: [PATCH 26/39] iio: humidity: am2315: use
 iio_push_to_buffers_with_ts() with a scan struct on stack
Message-ID: <auB19sOJY53q-X3i@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-26-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-26-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:44PM -0700, Jonathan Cameron wrote:
> Move the scan buffer out of struct am2315_data and make it local to
> am2315_trigger_handler(), as it has no need to persist between calls.
> This also removes the need to hold data->lock while filling it in.
> 
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

...

>  		i = 0;
>  		iio_for_each_active_channel(indio_dev, bit) {
> -			data->scan.chans[i] = (bit ? sensor_data.temp_data :
> -					       sensor_data.hum_data);
> +			scan.chans[i] = (bit ? sensor_data.temp_data :
> +					sensor_data.hum_data);

You can drop redundant parentheses.

>  			i++;
>  		}


...

> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> -					   pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				    pf->timestamp);

One line?

-- 
With Best Regards,
Andy Shevchenko


