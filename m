Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700433254A6;
	Thu, 19 Feb 2026 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487549; cv=none; b=qhoIRSuF66LxbCgPCNRr4x1/+4hw74XE4fJAqyXZSf7CTG9IpW67OvcZpxP9YNPHe174HaAec4HdNmGucacqRjdawlOHi+gJwP4L/2c9F8DRevGapeI0E3Xivnq9ZcgD4AWjOs2Luy7IM1SW/EzcaFCsBSED5REU1faN2LNcvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487549; c=relaxed/simple;
	bh=TrI9YhEni0imOcWCGxOjyXuIpTO2mZu8aihX11q1nak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4y1+3xgUXVQtAAGH7bYITa35na/WN4gcv2fDRM1Ai3JhfCV+gc+Ga86WEHidXEdYFTsN3T6iJVywNY4zth1NtIT8O/IO0Bzm+Hd2pvMhtA5ujf2SbKsLCwB+7Uv+HR6cAQ0WAJy+oV6v0o6DvBotBPjmL3wgVEnNu1XyPZ4Mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W35kfMZ6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W35kfMZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771487548; x=1803023548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TrI9YhEni0imOcWCGxOjyXuIpTO2mZu8aihX11q1nak=;
  b=W35kfMZ6eeVSlMUr3ug+T5jUwbvN4PvETumOj9bDibihSCHKd40yurhG
   IcyNXq6DZXc3dmsMVpFNZvkV5ZFDM/4whNdauLgH7+cMNxhmDIrfnpYn9
   eHXqIXqfaxY+Rh9szRg3SaMVHu4zhMz9f3tzU5vDbL6pIDz31GBueN6UV
   qCm6dWCxdANl13gIc8oYzsmgTAo1iZF+s3Hp6DkRu/t4xux9Pc63t8GOj
   hYqXOZEZMwenidHl8SGBsKy06tMtOHDjQJ5Aj5DwsNesj/7K/MllL9vIY
   rAGjlCIf1ud+iyecKTOcYBzMPes700T48jh3MhjVB0d2RtgiPYBNaBr9U
   g==;
X-CSE-ConnectionGUID: u9qJl6fpRRSaVKXWv91Wgw==
X-CSE-MsgGUID: LCkF+1RnQYW0sPFRpqRyTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="90149633"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="90149633"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:52:28 -0800
X-CSE-ConnectionGUID: IBSUlyFRTK2TeQW26ksGCw==
X-CSE-MsgGUID: jGXnlIRFS9WA9FPw7Ue28Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="245042921"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:52:25 -0800
Date: Thu, 19 Feb 2026 09:52:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: adc: ti-ads7950: normalize return value of
 gpio_get
Message-ID: <aZbBNtjFDU8KL8RZ@smile.fi.intel.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-2-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219022929.3558081-2-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 18, 2026 at 06:29:25PM -0800, Dmitry Torokhov wrote:
> The GPIO get callback is expected to return 0 or 1 (or a negative error
> code). Ensure that the value returned by ti_ads7950_get() for output
> pins is normalized to the [0, 1] range.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


