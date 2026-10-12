Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498232572F;
	Mon, 12 Oct 2026 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840513; cv=none; b=iOFAUI50hMQ6v8NqW8ncKfmYqQ80sSmMy7FJm4lUnvHsYZgiBx+nc4ze2ni+8jxLc6/tFMYgZuZKyG8x9pFQpkIf7UlxoK7AHVyuvSSFH9U3A9ObL92FIFvJc9j7WlQQLdX/mYjjsm+Gv+N2v1ZaQ/iXTYYdML/3ErIFnfXDSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840513; c=relaxed/simple;
	bh=z4aqwswhFe2SwLRpYaJmChtjS6q08hknCQP5ezHAMag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuN9/geuXSvkR7b12H88arRg+0TTuRgMO4Lm3h0stPu4OhctnNSydAUBx+O8cauJi7lEQO/yDy3v+tbFoWjsD3MPttCmZslrG2ro7c2hrWI27xbckm6ziea3vdaVCXNkJzGB/YJCXLH3pvnjm0APJnsgkX4wsFOEZBGrF/Z4YF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gL72qYWD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gL72qYWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791840512; x=1823376512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z4aqwswhFe2SwLRpYaJmChtjS6q08hknCQP5ezHAMag=;
  b=gL72qYWDHy6byXK2mRKe3OCTXz7MSpi1pjH3IGxmhJSM7Tf/DHOXa9HQ
   hu0MokBYoyJpn4LIpobDaBrdipdHvif42jQQHAx4m117emumbZQCJhMHP
   BjE/FDpZAN2FF3y4D/dFQEuV474hDEkmmh9ntwgKhZDqUIZGySGxo6Gty
   KAY3A6UdqSAe2DPh+rm4GUwTOxhltIvnlNXYl7dDH+dqhSFHR/25PQKGM
   /jakOOmqtX/erSaPGXy2pctv3neC2RM0ERVRQkGfJS6zKt2mmukxf+rC/
   /MraRDRDUsvCRYShh+PeEWrOj+7udpVLKrwxw71EgKZXqbfTH1/EYaaXJ
   A==;
X-CSE-ConnectionGUID: dMACsvrWQgy4GuH1fs4/Gg==
X-CSE-MsgGUID: 8vQ+4WQORPyFRrPFbnHBrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="455598"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="455598"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:28:31 -0700
X-CSE-ConnectionGUID: lsBMV2tsRSqOCpU3d2IVbw==
X-CSE-MsgGUID: KG8scPQdRI68bD02XpO5Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1004456"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:28:28 -0700
Date: Tue, 13 Oct 2026 00:28:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raffaele.tranfaglia@gmail.com
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: use dev_err_probe() for
 ldac GPIO
Message-ID: <as1Q-au8dpp9YFeG@ashevche-desk.local>
References: <20261011-adt7316-dev-err-probe-v1-1-27a4a8ac74f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-adt7316-dev-err-probe-v1-1-27a4a8ac74f3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 11, 2026 at 07:56:22PM +0100, Raffaele Tranfaglia via B4 Relay wrote:

> Use dev_err_probe() when requesting the ldac GPIO fails. This
> avoids logging an error when the GPIO controller is not ready yet
> and the request returns -EPROBE_DEFER, and records the deferral
> reason. It also simplifies the error path.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Although not sure if we need a Fixes tag as it might be an annoying (but quite
rare) case of flooding in the dmesg.

-- 
With Best Regards,
Andy Shevchenko


