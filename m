Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829083;
	b=jHHdMGtfyasJ6VnHsCf8JjJ43XBDoU5vGwHlnqgHa2vADtH5dW9htsaP0nxSYQPz32Fu
	 Gv0bf87R+Bx1tmvS5swkKQIerPLEouyttKak3QvADuY9KpZ0rfzg0zboMmYH6xv5cFkCE
	 bMYy622NI+JHuvO9HTm1dnRzwQR6SQaualTixHBLpCev7x44Sg36SQngOUosaidpIrfFT
	 h3JZMzXKQFgxh72gb2yWVW8rgWFerku4jmR9FtO6OF/of4Oc+tOJXJ1FGEHeZvnK2MrHH
	 rUjbOab0ah6UgAyBFB/3nJtRu7FmvKGixkoSoZ2j5tvP2xFIPH6Q8PXCmtMBbOUP8mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829083;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=z69RdKnM8/ZbXnE+dmVkLGDIqtvDQx6xepm1iPgSjiQ=;
	b=KHPWalxlfSF4Ppi8TOpiswUe6TqmyvGXrjFats1ePPNG7eFA/67T0umRW0xowPkWZM7i
	 MCk5RPQNCmmUvXhHzJq8gRLSDkFBoU9NPmNzpeiQNQA3rmINOJdEpI6WxJVTwNxF1GGAD
	 SGhA4a5vK16dO+pPIRp630Mxd/xhKg5pzNR3Mwe5kZs3NT5fmLV9Q6AYnrOtILBRm2EVY
	 9h3fu6NCtSi4rcyMyC/IQ2adZJVc6WYml/ufDuZx6yMcKetqUrv5/UK7TWiU7kz1RRv9Z
	 FroepzDXooRYuZfX2B3lxfnduj0oFRA/ZXisX8ne07FnA+IEDj+tP4x/8tLLPa3fIYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NQJyZIFW;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71E607032D;
	Wed,  4 Nov 2026 21:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B71E607032D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NQJyZIFW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793829082; x=1825365082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iIIOGDAI16erPIhc9n52UtIe6YdlWb/pynBMGT+3SDs=;
  b=NQJyZIFWF9sHlc5eEjcnUWafBpCOt5fobBWJCmbwVkvCkkV+ovP73h0H
   R7VLVpfu72JTgtJV0LtY6ZDPjHl3LPeArB8FJcQr2fUmyvADiIrbsPkrn
   ODjYhIqttiPZ6IizCUaimNzwUXnH/yTILvA7Id4zNmH7PmjGWtjEwFyEu
   fwc4u/7aMqQQ6GgUhQnPDtJHSwnfq691smldx1TPnH7JZI50USMJio3fn
   GnyFDtz+yj+ZSfjUdjTxi0jepPcpexlffVUfS3qUprJaU4FYTCnCKkrR7
   rYa9QSwWQWhEMQ0vlKMXUTNAAHKaByDI0awDIwULwFXtm9hDVKnt822fL
   Q==;
X-CSE-ConnectionGUID: 3Wm6A+/bSsSkm+chgvvXkQ==
X-CSE-MsgGUID: 71xDInSnRQ6XWEg83fhzYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2640296"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2640296"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:51:21 -0800
X-CSE-ConnectionGUID: dhGzFJViT52laHa73MV1ZA==
X-CSE-MsgGUID: 7XhsS7UWTJCyiXJQBfHNyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6944500"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:51:18 -0800
Date: Wed, 4 Nov 2026 23:51:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [PATCH v5] iio: chemical: ccs811: Make sampling frequency
 configurable
Message-ID: <auuo1JPrPLA4dnsh@ashevche-desk.local>
References: <20261104151138.9968-1-nikhilgtr@gmail.com>
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
In-Reply-To: <20261104151138.9968-1-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 08:41:38PM +0530, Nikhil Gautam wrote:
> Allow userspace to configure the CCS811 IAQ measurement rate through
> the IIO sampling_frequency attribute.
> 
> Support the three IAQ measurement modes with sampling frequencies of
> 1 Hz, 0.1 Hz, and approximately 0.016667 Hz, corresponding to
> measurement intervals of 1, 10, and 60 seconds.
> 
> Preserve unrelated bits in the MEAS_MODE register when updating the
> drive mode, and cache the selected mode after a successful register
> write. Expose the supported frequencies through
> sampling_frequency_available.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


