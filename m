Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7634D38D;
	Wed, 22 Apr 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843421; cv=none; b=QzzFZbSvAg2rOQKozAL9A1ZfIic5Brrc+8OGeu8JhogsBSXlAyE7QJzhMDy19XZ6NSrBaulXnnV/d0WhZ1QeOciRqr7nXlU6+H4rLOEg/72qMle+AwM9sf68NWu7b6HDugIpXUgl4WCY2b9qTEUZteVjYZOtrVQvrCkXolT4jDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843421; c=relaxed/simple;
	bh=HVXvVtuJ160Tn2RmojgRPseyonqQ2Cw8TJH6ia9FHhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qrp6NQPz3AeFCWpxgG+Tw6m2Dr/CkZ5ypPB91zdEdjVfKPN47q3XYl9VmD4k7wfB3IkUm0q3YaG//Ym6RYY34NgitpyBgWrP+c5wCC+XhxUDGavlnSJQNTGF8eDozIEGPR8cJcvTmKJS9JOLUPFs+mWOXwaSpwu3ekdvwsYDuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHNKBtM2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHNKBtM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776843420; x=1808379420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HVXvVtuJ160Tn2RmojgRPseyonqQ2Cw8TJH6ia9FHhE=;
  b=PHNKBtM228+IeZ4nQIrtWLPc8OJ/3SXDafQHuwG/H3IgWLjxC88cztqb
   DfQ9ZfYvx+P3rl+KCuwjlNnlzaUvCO1qUzFeQFcpf1RtHsa5YdsB/VZES
   TMh8c4r+vSV8I+ylZYUIoAqD877REVateDGiRmy/EFrJP/E1TN6b2IIWa
   lCrMxnu7smbkYF8NhlRHXGBUsQOHVGlbFb3P3Kdn2li4D8s9UscUej0hu
   82+zaQ+gi0zgFZPa6RIDx5xZSbLcZqJ69aYUapTO12I6kCwkRwMbKgZc5
   xDbIo5SyJHUM7r7VvsRI3JMpN1gqGyvQNDs/2ee+3NO5HPHXbS4tF8Bfw
   g==;
X-CSE-ConnectionGUID: oBjC9g0hR6SRa/wsCUyzFw==
X-CSE-MsgGUID: BJCEWWU5RUOC28sTjRn5lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77772786"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77772786"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:37:00 -0700
X-CSE-ConnectionGUID: diljW+dcTrO8eyP3uQfhPA==
X-CSE-MsgGUID: B7TIsnRwTICd5xFnxgwL6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232187349"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:36:57 -0700
Date: Wed, 22 Apr 2026 10:36:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: ChiYuan Huang <cy_huang@richtek.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Kevin Tung <kevin.tung.openbmc@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tung <Kevin.Tung@quantatw.com>
Subject: Re: [PATCH] iio: adc: rtq6056: add i2c_device_id support
Message-ID: <aeh6l_yjStUr65-t@ashevche-desk.local>
References: <20260420-rtq6056_support_sysfs_instantiation-v1-1-483ccee27b63@gmail.com>
 <aeZekWfdcsSkm4SE@ashevche-desk.local>
 <20260421155426.45043750@jic23-huawei>
 <aegtZaOFkhZ4pHVL@git-send.richtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aegtZaOFkhZ4pHVL@git-send.richtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 10:07:33AM +0800, ChiYuan Huang wrote:
> On Tue, Apr 21, 2026 at 03:54:26PM +0100, Jonathan Cameron wrote:
> > On Mon, 20 Apr 2026 20:12:49 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Mon, Apr 20, 2026 at 08:52:52PM +0800, Kevin Tung wrote:
> > > > Add i2c_device_id table to support legacy I2C instantiation.
> > > > Update probe to use i2c_get_match_data() so device data can be
> > > > retrieved consistently for both OF and legacy I2C instantiation.  
> > > 
> > > Maybe someone finds this useful...
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > 
> > Applied.

> Since 89a1034cd841 ("iio: adc: rtq6056: Add support for the whole RTQ6056 family")
> break the sysfs usage, should we Cc <"stable@vger.kernel.org"> to make
> it backported?

In that case you need to add Fixes tag as well.

Fixes: 89a1034cd841 ("iio: adc: rtq6056: Add support for the whole RTQ6056 family")
Cc: stable@vger.kernel.org

-- 
With Best Regards,
Andy Shevchenko


