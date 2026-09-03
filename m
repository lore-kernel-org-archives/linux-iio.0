Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6452391507;
	Thu,  3 Sep 2026 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422165; cv=none; b=F9pncYO7VXY7vE19aZjRoZ1aL/1CH2tYQo7w1yGiJ+OTk6aVVwGts9Wr4Fm8sAGFzCZN17lsI3nEEC15M9BbyZJlx7o76yfHuw8gwy/sLRXpHPARFzU8mFfzBZwCNAhEsPd5Cap2XKPkNyGv3rL3C386/wEoqkxws6QkpGR7koo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422165; c=relaxed/simple;
	bh=KBBHEWALH09/aeugiqOEMRwOfgwx+Kf2hlkPG5RTIjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4/ott4ImbTfrc1MFbd+Ht1pNOJ6KmVf2xZRtPbJKRhZicyypz0pj3i3NTxCFZ1neGpjUpLzXqpCDahDll7qRUInNhaEugCh1QbxHYw2ZLFjThJVB4hj53uUq3MyHSn3Lr32t0RGr/9Rd4nh+ppaM0DlmJMwTZMu9Juy70TIw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzrVRlCr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzrVRlCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788422164; x=1819958164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KBBHEWALH09/aeugiqOEMRwOfgwx+Kf2hlkPG5RTIjU=;
  b=gzrVRlCrZeRdOdRfOpWQuMjCrd5YMMuL1Cko+mIvaINDIq/uCqApzyVE
   cVZhDiwzJsg0GO8Ng7N5X5bj1rvNApFS7owV2R0CJ5X5ODG6YsAkvcyDj
   cNubdgHCYFvVmNX0kmAxGbjizQ5k9ca0jfoWblMCyuRmMMMC2tytj8WNX
   Deon4kFHrkEBwqlFLstrOg5XvC2VfmsjAw08lOP5R52Abe8hnkbC0V9H4
   W4d+zRoimdeJGB3uh3K/86uf6MDp9Jd8dP+aYv7knI/ARfck8wyt20OHh
   8yEfqRhVq1P6HUAi8CnULCBmMkty+vrkPmvY1US3sO34ExQ80c/eJS4AZ
   g==;
X-CSE-ConnectionGUID: 2hjLVtXkSNyOSnskTcmO4Q==
X-CSE-MsgGUID: EPnaEme5QBOdie1CpD37kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99555891"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99555891"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:56:03 -0700
X-CSE-ConnectionGUID: t2/+K6XMQ0qf/QyZ9rKgmg==
X-CSE-MsgGUID: FhWDUmJXR/ippXWbjMs27w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="293144911"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:56:01 -0700
Date: Thu, 3 Sep 2026 10:55:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v3 1/5] iio: light: vcnl4000: use correct channel array
 size
Message-ID: <apkoD0RgLakoUMip@ashevche-desk.local>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
 <20260903-vcnl4000-v3-1-5e69c2e715a8@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-vcnl4000-v3-1-5e69c2e715a8@jacques.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 02:53:46PM +1000, Tsz Shan Chan wrote:
> vcnl4200_spec sets .channel to vcnl4040_channels but .num_channels uses
> ARRAY_SIZE(vcnl4000_channels). Use ARRAY_SIZE(vcnl4040_channels) so
> num_channels matches .channels.
> 
> Both arrays have the same size. No behaviour change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


