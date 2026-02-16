Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562F22D792;
	Mon, 16 Feb 2026 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228169; cv=none; b=AaF5BWapVzGXjA+MdVyDOBb+fcdRyIrbae0Y1NNWViHnRkWecYoaUIMRmOuOwXuvMxFe/3CvPrVop6WPS9yzQJbW6RbO+92a5xPg/CiRusP1ygWp1vRRPDlvpYCJNlw3KdfV815SOI5T/XstE8DRafhz7tcxf1LrRJoZkFbfdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228169; c=relaxed/simple;
	bh=Z/z4WzCbf15Sfh6GRYbABA7O+ZBY6ibHRRDWFYs5xdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1HcT+jfxkJAArWRmFy/pfBD0EIwK20BIIF4sC4q71fCNerBUBDoHkRHjbtTzYEaewFVki277YTCPLTEvdFY04Uq9oolSnvZiNQPpKaKk78ltWRJEWSZRSIFsejuQCjNW2iFsUcyz8o0url9ebSFbD8C1sImjoyicqhetBAfUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idN3B3/Z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idN3B3/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771228168; x=1802764168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z/z4WzCbf15Sfh6GRYbABA7O+ZBY6ibHRRDWFYs5xdI=;
  b=idN3B3/Zun5v9Q4Y5q4zVOy6+QIsloTgv2EIPMBJZXuy+vB5US4fTHcM
   U1jnSOZuc2Lhbwo68B46qJBokCtxTGi/Pn2MmJZ8qXsr+IQcvvj5Kii+b
   oB2nR8dlpmCfokM438LM9AgWEnwueKh3ZxEZvz7xSDZy3pJzg3bbjlN66
   HzOhLpZwO5WJqDtEHjVNiAl2tmHMmADUPuyxP/QDztFBUg8oIYcM+vGXH
   3NBeXW/9ytYts0iecJ80RItHgKtNSaYdbpPdHhe0HYn1XXJ6aYHkrCRA3
   NkJM27GmMZZlj62q/0GZlkE7pK7SYz/OOMWDHHHpY+k2b4JcU1BeaQA86
   Q==;
X-CSE-ConnectionGUID: d6VLEc6oSNutfKvJb0cCtg==
X-CSE-MsgGUID: Nm+l+6mjSnaBVRO+sWY/lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72209748"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="72209748"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:49:28 -0800
X-CSE-ConnectionGUID: WUzt8KVlQueA1Srk3t3WrQ==
X-CSE-MsgGUID: +9/+a/faRhuugiAMttTH2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="218503794"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:49:26 -0800
Date: Mon, 16 Feb 2026 09:49:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: add explicit scan buf layout
Message-ID: <aZLMA0KjwLOX_BKE@smile.fi.intel.com>
References: <20260214-iio-imu-bno055-repeated-element-v1-1-b57b08efd566@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214-iio-imu-bno055-repeated-element-v1-1-b57b08efd566@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 04:10:38PM -0600, David Lechner wrote:
> Move the scan buf.chans array into a union along with a struct that
> gives the layout of the buffer with all channels enabled.
> 
> Although not technically required in this case, if there had been a
> different number of items before the quaternion, there could have been
> a subtle bug with the special alignment needed for the quaternion
> channel data and the array would have been too small.

...

> +			struct {
> +				__le16 acc[3];
> +				__le16 magn[3];
> +				__le16 gyr[3];
> +				__le16 yaw;
> +				__le16 pitch;
> +				__le16 roll;

> +				IIO_DECLARE_REPEATED_ELEMENT(__le16, quaternion, 4);

Right, and like I suggested:

				IIO_DECLARE_QUATERNION(__le16, quaternion);

> +				__le16 lia[3];
> +				__le16 gravity[3];
> +			};

-- 
With Best Regards,
Andy Shevchenko


