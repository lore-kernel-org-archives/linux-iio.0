Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E13B0AFA;
	Tue,  5 May 2026 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965949; cv=none; b=u9oSUfJG11VkofaY4hi7tHTFhkKjuGiSsp6qVnS0RBu/v0IkSkmhETSpd5+J+dB3BXPtl+oyQdxhuLUUYN6guioUIMpAiNwqTBGGDIXzhIAumAjsCbwc8KaE7aw8co15mP8sy0d5i9Sw1FsPbFpkDC4SWuFCXwQl9NLeuT+T9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965949; c=relaxed/simple;
	bh=RUk6UBb6FTaClFVR/bUT7VqZ8c/s5iNLJPcAeskk4Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6i2gPGzx2yALJNjVaNsvstZ+WmCjoXZ8iqo/8MNGzlWctx4pSGoGNP2Iekxpg6qAAnQucVqA7GxrVUYFU5dSiMWzCC4Bd4TP1B1/cnwAnB/6zFb0qPXAKgKOTNmAWS4mPLwz3pgo/31DkTBB7pyHwHBwDwOPwNCFB2ssL1dThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cu+6OmY2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cu+6OmY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777965948; x=1809501948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RUk6UBb6FTaClFVR/bUT7VqZ8c/s5iNLJPcAeskk4Es=;
  b=cu+6OmY25z1iKBuEoL9lOWq8rYEnzqE7utzXBGXHmNYuS5YpBmVVqwHD
   nejIK0mwzCd0A8AE6vqPUhyFW92vWoIAj1c/cmCE29zusq9/mGy/CcPk/
   Chu3OaNX+BnATEFc6vfftraJx5xVOHXoBBSJJ4uGOxzkAfp/rJfVXz8Zq
   wv/Uuo/6yeGllQsQxiOkLi5QEgYYeUoM9fGF+j9f2hwhs1Pk+zaTyPPot
   cfn1bJ82qcIUfoQOAkZfXKyRFh1OiyHj5BIdtLn8optZgPAwg1rZxvXZP
   hj6ljJTbrTlmZDqYBuqnvwM/ysFk7YjfieNbgEQDxRCHtzS1zjDJa3zYf
   A==;
X-CSE-ConnectionGUID: uaKAaFJeQkWj2so41ml8vg==
X-CSE-MsgGUID: GvcMixSQQWywfhN163RW+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82442995"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="82442995"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:25:47 -0700
X-CSE-ConnectionGUID: d07b3USdTmOJzQAwGSPjag==
X-CSE-MsgGUID: tMWKNNhoRlyNCALm6PuBNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240713718"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:25:44 -0700
Date: Tue, 5 May 2026 10:25:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: kmx61: Use guard(mutex)() family over
 manual locking
Message-ID: <afmbciAUMFDgIGVo@ashevche-desk.local>
References: <20260505005506.160891-1-m32285159@gmail.com>
 <CAKqfh0EgLxEnX1MxuKNqVU-y5d6O6zQWSctb_hHzF8_-WMQSKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0EgLxEnX1MxuKNqVU-y5d6O6zQWSctb_hHzF8_-WMQSKQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:46:04PM -0500, Maxwell Doose wrote:
> On Mon, May 4, 2026 at 7:55 PM Maxwell Doose <m32285159@gmail.com> wrote:
> >
> > Include linux/cleanup.h to take advantage of new macros.
> >
> > Replace manual mutex_lock() and mutex_unlock() calls across the file
> > with guard(mutex)() and scoped_guard() where appropriate. This will help
> > modernize the driver with up-to-date functions/macros.
> >
> > Remove now redundant gotos and ret variables, as the new RAII macros
> > make them unneeded.

[snip]

> I just got the report in from the CI bot on the v1, and there are
> still things in this patch that need to be fixed, consider this
> superseded. I'm going to be writing a v3 in the morning (my time) to
> resolve this.

Yes, you need to have a dedicated scope for guard()(). So, each case
in the switch that uses guard has to define the scope, id est be like

	case FOO: {
		...
		break; // or return ...;
	}

-- 
With Best Regards,
Andy Shevchenko


