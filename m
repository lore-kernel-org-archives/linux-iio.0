Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B3386551;
	Mon, 20 Apr 2026 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676909; cv=none; b=XzRutWFHczrDdzEw5EMnSMoeuzKrVFaF6xVYdmW2fItT2ta2arFlgVYtAb8a4s0cePopEYAtxVwpu8Eo1DAjccKOFkBIhKSD9Ghi0Id5th9EFWST7MVjhs+l/DPQ2Ir67MWgsY/yU6v95UljaUZWMOs5lDjmBETP4CLXxTwECxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676909; c=relaxed/simple;
	bh=nT9TOhxd3gox0+1XBOdyXoZMbU4M/tmT3wao+uStV3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB3MstuBc1hvxVe5nQj6C/ESiws9dEwHU8Lg33ltEohom/8V5XZOEx2va4a7ArD2yDbwfxohaczY2ALHDBTKaqscR1fqxJ0owq01yWkA1Kqz7Zd7eSnU28Mf73o+nb9V1JEGRqhGvoxImtX0GWOV7/Ij2JQsr0A9l83jSXO0LUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONnqyl4a; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONnqyl4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776676908; x=1808212908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nT9TOhxd3gox0+1XBOdyXoZMbU4M/tmT3wao+uStV3I=;
  b=ONnqyl4ahQc5joouE1nKRGCnAjvbfKGki9Pyw/rG95MXmOLRjS1fJqhP
   F/J+BHrNl57DAZ3kNAkLdFhEcRvIU5ekrHgAX0E6gkNu8LOBTMYDTo6/n
   F7rQyi/cyM3lJT41U6Z37mM4ogosdQU5wkAmT3mTq8jTPm7pL8FYeGKqp
   eeksbw4NfYESOzdJCSiZqKKF5axzE5DjwfHYzv2yFucSzWIJVBCKzC0LH
   /PpsNPWghyyBxXUfe0d6c099w8FbiW5Fz9WltR3kMtidMIY8sKWkt3X4r
   upaEGzl8JSJoKRLflkkKpi+17AytnQFw9CGjcg65ivNzTKTXNP7Xq1bY3
   w==;
X-CSE-ConnectionGUID: m1UBdV1rTyeLfW68axEfcQ==
X-CSE-MsgGUID: 1BOlVy0HRLSYVqpqAFFFxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95149325"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="95149325"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:21:47 -0700
X-CSE-ConnectionGUID: Blm0GayOR9WtVN1FU+50bw==
X-CSE-MsgGUID: cfY1FMsSQ7O5p8FX6JuOLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="228986084"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:21:45 -0700
Date: Mon, 20 Apr 2026 12:21:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gye976@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH] iio: buffer: fix warning in requesting threaded irq
Message-ID: <aeXwJyBlktTSX7eG@ashevche-desk.local>
References: <20260421015252.621393-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421015252.621393-1-junxiao.chang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 09:52:52AM +0800, Junxiao Chang wrote:
> IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
> handler, this flag should not be set.
> 
> This change fixes a warning during booting with kernel v7.0-rc3:
> 
> WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x2510, CPU#3: iio-sensor-prox/974
> Call Trace:
> request_threaded_irq+0x2c7/0x490
> iio_trigger_attach_poll_func+0x353/0x6b0
> __iio_update_buffers+0x2420/0x2c70
> enable_store+0x183/0x270
> dev_attr_store+0x5e/0x90

> sysfs_kf_write+0x1e8/0x290
> kernfs_fop_write_iter+0x406/0x5f0
> vfs_write+0x71c/0xea0

These 3 lines do not bring much value.

> v3: remove unneeded log in git message

No, it's still there.

> v2: use ternary and drop temp variable

Also the changelog is still noise part of the commit message.

Whatever, I leave it to Jonathan who usually tweaks the patches whilst
applying.

...

What it worth is to add a summary of the driver (and platform, if available)
in use.

-- 
With Best Regards,
Andy Shevchenko


