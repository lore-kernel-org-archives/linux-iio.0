Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098169;
	b=pVq74CupwBXyDr2goXmfv8Fk9chjKSAYxXWV8HP/2G/faw5u2KSKoMBHhXyvjZUmNmUg
	 z/NgEB9o+h/7ghyBvWlWTpqSUCpdo3kSFHETBb57de1NoUQHLPsiu2VQGPezf/KN0cJ7V
	 J6WaHbSBHMfrVOeepowHkawovgWTiW5qmYYagY72Nv9o5ILVf6DNDOR+ZyZxXtQtEU6Tx
	 rc/56NNYkQMJ4xq5BWzXbOtuVMnvqZ6W2zIgHigPNaYY3SVkyfhb5n2OXmC3ZmSdzi91w
	 QADxbTS+jmK1pVPelrZ8bEF1tX9i18kLy6PFo1J+Ss5XRNMMFfQemXBh1qga3hWxWNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098169;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=2mdQBukQpeI3F9Lbm2xbpPIoPNN70gJPQuRztaPJQOQ=;
	b=UGb52OjYMvRic1CQE5FNxvwN4MAM7C86E/f9KNhnpOd5/dBTa5FG6A8PMN7V6RMzwBdb
	 4ca5R70g54Zs31kF2tSFn3aIHmqgrjPqjhIDiSbBmmwLBt1QkU+Z1iIGvyStar5Ivtvff
	 nC+2ZI7kko12VBupbVzdPQ9RocsLdskjTeqPl1jq5+CDL3MSPpEZGAhlGycIOFi0TnAFa
	 xtQkwHqNISV0Rv1unwvWWIIv6EM5PesQ9100xurRfpt+U3yts2yqQJPevdGqce6Hx88JB
	 XIAfMIpXKRGYey7roYZhDSlDgcV552Z1oKTfhT1ECrdkV0NlS0c0w1pWIrcj0acvaFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e1FOTTKk;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3E606A31D
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 10:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C3E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e1FOTTKk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793098169; x=1824634169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iBJGMBrSBrmWImm6EpGSn2umo1BDy3NXsZCbjBZoGo4=;
  b=e1FOTTKkRXcNb8/sgdmuOj01vF/HZpDE1xbBsdsbC1JjqrfbGcJFObD0
   FkcxeWIdsxu/BtZIKA2wC9nQGuS6hcsxQgukZs9odhWzk/gJKpF9Aewcw
   qYstkMIQHhRWG7Sxiwc/ngXtjyWiUHHelns1sWP3kYRs70cspg6UtNImC
   Bx5WbKTOf/HAChY98qbrzgK+QgtVFt8PsVP6bdpyncof2fJq/JhZ/skSW
   KNBR8kmg7cL33qOx7leWUcQGps6Q8/sEl3lXHDuAyRKE2B6hpzRvVgW24
   rP6zFI425WzfaJ6bHKSn7QK0Q9rKxfx2Tfr+vr5yjJNpNeTq1OpI6w4Uo
   Q==;
X-CSE-ConnectionGUID: XDd7ijo4SdKurv1RrvQibg==
X-CSE-MsgGUID: V01GlSPMQqWAhOyIBdcVSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1807089"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1807089"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:49:28 -0700
X-CSE-ConnectionGUID: D5EaDIESSUqqvpNx5dkAxA==
X-CSE-MsgGUID: OIeEFoWCRFe1zOHMeFG6AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4850583"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:49:25 -0700
Date: Tue, 27 Oct 2026 12:49:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Cheng-Yi Chiang <cychiang@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 36/39] iio: common: cros_ec_sensors: use
 iio_push_to_buffers_with_ts()
Message-ID: <auCBsyTztzrSUoIr@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-36-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-36-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:54PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> at both call sites.
> 
> Replace the raw samples byte array with a scan struct containing the
> channel data and an aligned timestamp, matching the layout it was
> already manually maintaining and removing the need for the
> CROS_EC_SAMPLE_SIZE size calculation and the casts used to access it
> as an array of s16.

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
> -					   iio_get_time_ns(indio_dev));

> +	iio_push_to_buffers_with_ts(indio_dev, &st->scan,

> +				    sizeof(st->scan),

There is room on the previous line for this one.

> +				    iio_get_time_ns(indio_dev));

-- 
With Best Regards,
Andy Shevchenko


