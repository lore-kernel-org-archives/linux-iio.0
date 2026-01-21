Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E44492184;
	Wed, 21 Jan 2026 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007943; cv=none; b=U46ZM1X42JUbXHpmCAX3Yu+jw1vvMIGP7LMKrgLUKocFQGy16u4etrUO33e3YNjuaSGtlc+lre0e3LsZ1hjNxDcdnkbXKJgOG3RRnEMTI0HBlhPTcDLO4w6gfzziWM6BkrcozKm+cOIAf7td7O/UItUBr6HCz/F43snZMKfGFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007943; c=relaxed/simple;
	bh=TJra7LD1zP07usuMour7+qx8Zn4nnkCD9l2K5xuIrpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDiO/dUC2fxVC7tcIV0OHgIzkn3CqVCjoi14eNB2qZu+0NUPvM4ea1CoieIhntGC7gqVMwyJBEGW2oranse2q/5gT9GPSOhaZ4HKvvVhSU/IsuaLwvtrRau8CuMSH6KBem5uSxCtRy7aQD9nv0940AX6PaBVUDCVL97/m9dtN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DcF2VhZp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcF2VhZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769007942; x=1800543942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TJra7LD1zP07usuMour7+qx8Zn4nnkCD9l2K5xuIrpc=;
  b=DcF2VhZpmfi06UgWds4kSfu4Np30JzBmdq9F05PHQQNCxRtImlHpLlTL
   beovHT8SoP3232PvHR5okQkyaVVmqMeihTuV5N1SzPtIvoeDFlE3yFwTW
   rB1p87derNE5aumCCZzBfieToBrglxSwbHlEfMoHQC8dNK9dzIC1eDYvp
   paEzLtcCZYqPLsD6c2whvwuo5pPTVSeIlOHj2FmhvjceOFT+eupCS/2ew
   t7fgd4m3rp/M4++qfgJExeh5v1bPODIDhIL9zC4bIiT0pZKkpGqHaJkMO
   CaSag63JlMaEEh7Wb2QjeDOUUAqJG8hnMlsGSemKT3dLZoR/JPsezSk1l
   Q==;
X-CSE-ConnectionGUID: qnSo3er0QbONXf4qTdy7Gg==
X-CSE-MsgGUID: JNRrzkEMRAmPnzLPt2g3hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69961493"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="69961493"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 07:05:42 -0800
X-CSE-ConnectionGUID: Q7kF8WbcRkyBtyc/erq3aQ==
X-CSE-MsgGUID: pDPJGAoxQhW0xgMlyykG4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210908026"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 07:05:39 -0800
Date: Wed, 21 Jan 2026 17:05:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix check for invalid samples from
 FIFO
Message-ID: <aXDrQGzTGrAeA-fB@smile.fi.intel.com>
References: <20260121112758.1831077-1-flavra@baylibre.com>
 <20260121112758.1831077-4-flavra@baylibre.com>
 <aXDK6KRIIPjJxfFK@smile.fi.intel.com>
 <0168c543e320aeacbbdcdd7f4f3bb0edb81b79f4.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0168c543e320aeacbbdcdd7f4f3bb0edb81b79f4.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 21, 2026 at 03:05:54PM +0100, Francesco Lavra wrote:
> On Wed, 2026-01-21 at 14:47 +0200, Andy Shevchenko wrote:
> > On Wed, Jan 21, 2026 at 12:27:57PM +0100, Francesco Lavra wrote:

...

> > >  st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> > >                             u8 *data, s64 ts)
> > >  {
> > > -       s16 val = le16_to_cpu(*(__le16 *)data);
> > >         struct st_lsm6dsx_sensor *sensor;
> > >         struct iio_dev *iio_dev;
> > >  
> > >         /* invalid sample during bootstrap phase */
> > > -       if (val >= ST_LSM6DSX_INVALID_SAMPLE)
> > > +       if ((tag == ST_LSM6DSX_GYRO_TAG || tag == ST_LSM6DSX_ACC_TAG)
> > > &&
> > > +           (s16)le16_to_cpup((__le16 *)data) >=
> > > ST_LSM6DSX_INVALID_SAMPLE)
> > 
> > Since data is u8 *, it might appear on unaligned addresses and the proper
> > conversion here is to use get_unaligned_le16() without any of those ugly
> > castings.
> 
> data here corresponds to iio_buff in st_lsm6dsx_read_tagged_fifo(), which
> is declared as __aligned(8), so it cannot appear on unaligned addresses.

You know that, compiler might not. If you sure, you should change u8 *data
to be __le16 *data in the function parameter. Until it's u8 *, the
get_unaligned_le16() is the error free thing to achieve that.

> > >                 return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


