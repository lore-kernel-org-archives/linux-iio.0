Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF1337BB5
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363295; cv=none; b=e/KLXM4PzdLU+Na/hM4NY0k+G+BaZtzkCLLGOqqZs/yvrj+rzGsCPqkDpmhMlnK97mtJFrHF2Z5W62qMAeK7YiLJRauwARNbiH6UCWHWijMzIh24c5oAmSuhlYClbzlR+STaNWC+m6NlROWbW2nMWrpYa9mpxcLXZa+fJdqq3DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363295; c=relaxed/simple;
	bh=1FcKcIw/BXS+Eb4p/JxhCyNs/+niyI/tS2pN89mLj/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FweDRwr5YVO1F687BY8y5xnwu62oN1PajNy7/IOQ2KeNPt5teKemhLz5LCSgbPk3c8jVjcTfDdQG86shcGDJR1DEHOMiX1O6bSES3PmJ3/sNcCxBkIOeznS/lg4n/z87x7k+pzHHl1iB+2Wk7YBCp/ljFMUrFqg63DevWUro2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiz0NLwh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiz0NLwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777363293; x=1808899293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1FcKcIw/BXS+Eb4p/JxhCyNs/+niyI/tS2pN89mLj/E=;
  b=hiz0NLwhIjVvmwmQ3POCEn+FgT2G3caICm5SB1uCOriyxCv2JJ03ET0c
   XNPlDfIN5qPBdfaMRSjM5Oi5edp4JEpZ42V6iecoIzwnSm6vC/55GnBXq
   n+oerfjPyHfSYohJQVDs6GK22lDXBtycUAtLFftVA1UDiuhVnv7tuLqwN
   T1t4NIECUCQWEHG7XeDMovNHpuBKdfOGJuz0Xpya2Dn6tY54edmjTxiRn
   eg3XzY0lqhtHwPCmF1JLBbLCHuZGlAYgWVLyLNMICadkRg26m2BUiSHFh
   FsALkpjGHDLMPPducTv51FhToyK9V8qL4xP1MGO57EqIOWdsxaXjgEZmK
   g==;
X-CSE-ConnectionGUID: OoUFq2SWTKG2wXqJgrbWoA==
X-CSE-MsgGUID: utq+5GQjSEy/8voo+ph/uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77968785"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77968785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:01:33 -0700
X-CSE-ConnectionGUID: sXbqGlieRy65Ebm3JJYANQ==
X-CSE-MsgGUID: 1B+7C9ToSNel8Lgy2mQOkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237839207"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:01:30 -0700
Date: Tue, 28 Apr 2026 11:01:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Dias <guilhermeabreu200105@usp.br>
Cc: Jonathan Cameron <jic23@kernel.org>, nish.malpani25@gmail.com,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	=?iso-8859-1?Q?Jo=E3o?= Paulo Menezes Linaris <jplinaris@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
Message-ID: <afBpWD4YXew6cVrx@ashevche-desk.local>
References: <20260423223958.100487-1-guilhermeabreu200105@usp.br>
 <aes2tzgfXbuD6ccQ@ashevche-desk.local>
 <20260424113901.0508dbc2@jic23-huawei>
 <CAH1eeHs5M4rDhdtmyWadFFsx3qK9=xST67h1zwb0-CwDV=aLrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1eeHs5M4rDhdtmyWadFFsx3qK9=xST67h1zwb0-CwDV=aLrQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 07:04:23PM -0300, Guilherme Dias wrote:
> Em sex., 24 de abr. de 2026 às 07:39, Jonathan Cameron
> <jic23@kernel.org> escreveu:
> > On Fri, 24 Apr 2026 12:24:07 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Apr 23, 2026 at 07:37:51PM -0300, Guilherme Dias wrote:

...

> > > >     /* exercise a bulk data capture starting from reg DATAX0... */
> > > >     ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
> > > >                               sizeof(st->buffer.channels));
> > > > -   if (ret < 0)
> > > > -           goto out_unlock_notify;

> > > > +   if (ret >= 0)
> > No to this as well. Keep the error out of line.  Which makes the use
> > of guard() here tricky.  You could do a do { guard(); } while(0) loop so that
> > you can use break with out it being odd looking.
> >
> > (I don't like breaks out of scoped_guard() because it's non obvious scoped
> > guard is actually a loop.
> 
> Thanks for the suggestion — just to confirm I understood correctly, do
> you mean something like this?

Yes, with proper indentation made.

-- 
With Best Regards,
Andy Shevchenko


