Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89938237F;
	Mon, 31 Aug 2026 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159478; cv=none; b=rYDNWTnACn2fQBOdAXBdWeU6a3vxIaB1bLHuZSPINjWzFp68uSU3mb1N1WsOM9tYqmdbfKkBfRQeLNbyh/4dNl9JF3Sihz8LH1kR/Rov38/h5bKzw6wMZK5mdsatJz33qSfqiexb9Pojpki+sPqU9LUBYsqXpR/P/47+mNg+auY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159478; c=relaxed/simple;
	bh=LmvD3JiC/xB5iW/v5VHf0t0gZZwGDSVtsR2NuCRY0zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGrBkkh+ayZzH86i8D8EoNOARdVzL2fLUz0Q0WUT7MY9Gnvi+0rbamH2zCkA+j8E8qP7KBGEvw5b3fxIavcEBOxWC9ps4LwJqQ3n5WyyTte6QE2SCBxw7npxpDjutC773n7PF78LmKwyl3YM70lQDm6IvjyTV+SxNnJiHc7jfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcXi70i/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcXi70i/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788159475; x=1819695475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmvD3JiC/xB5iW/v5VHf0t0gZZwGDSVtsR2NuCRY0zY=;
  b=NcXi70i/fGBYSNvqDraYUUm3pwLJsS4+8S8qe+Y0i/PjwWkbcgDRoD06
   AaxVNn0QBdl6GpYhVJHMdtnAQTGDf+qq9qMrruorik4yw8NKwmBAoB0D0
   YodIZau+bepExRavs7DiITSfqXzC6+OHiiEDo508AOIXasLRF65JHOWiL
   Ezz0jeEfYMvCcvSEI7ytbyk/Qbra7m0spWnRWc3I+Lj+iXMMuKIxEtpCB
   JND1E4n07iVeVbzlV1bWr0eLQnt/o1SSX63GznOzx1Id2Pjl8UJJicl/m
   jhMg70W7zOWIDXpgKmISVdnqOqNOS9Mqn66IzGWy0ER19Otn+9TYRRTcq
   Q==;
X-CSE-ConnectionGUID: kqvLWLGWSpmIom73FuljUw==
X-CSE-MsgGUID: 4w+rZBiHS8SLQWjSxVn9yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="114094121"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="114094121"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:57:52 -0700
X-CSE-ConnectionGUID: O7Uuuot3RsC1rdmoEBxO1g==
X-CSE-MsgGUID: Bxbbq+7pRKuQC34f/h3RDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="266137786"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 23:57:49 -0700
Date: Mon, 31 Aug 2026 09:57:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Yash Suthar <yashsuthar983@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, grondon@gmail.com,
	linusw@kernel.org, hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com, srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: accel: bmc150: use DMA-safe buffers for
 regmap bulk reads
Message-ID: <apUl63M931lQDdGu@ashevche-desk.local>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
 <20260825085156.212042-3-yashsuthar983@gmail.com>
 <ao_hr-0BelQWI27t@ashevche-desk.local>
 <20260831012450.3382868c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831012450.3382868c@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 01:24:50AM +0100, Jonathan Cameron wrote:
> On Thu, 27 Aug 2026 10:05:19 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Aug 25, 2026 at 02:21:55PM +0530, Yash Suthar wrote:

...

> > >  		j = 0;
> > >  		iio_for_each_active_channel(indio_dev, bit)
> > > -			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
> > > +			memcpy(&data->scan.channels[j++],
> > > +			       &data->fifo_buff[i * 3 + bit],
> > >  			       sizeof(data->scan.channels[0]));  
> > 
> > While this works, I find a bit confusing usage of [j++] and [0] together.
> > 
> > IIUC the below is an equivalent
> > 
> > 		iio_for_each_active_channel(indio_dev, bit) {
> > 			__le16 *val = &data->scan.channels[j++];
> > 
> > 			memcpy(val, &data->fifo_buff[i * 3 + bit], sizeof(val));
> > 		}
> 
> This bit I fully agree with. Much more readable.
> > 
> > and if go further we may use asm/byteorder.h macros instead of plain memcpy().
> > 
> Here I'm lost.  We are just moving little endian values around.
> 
> For that matter if it is a single value, why can't see just assign it?
> 
> 		iio_for_each_active_channel(indio_dev, bit)
> 			data->scan.channels[j++] = data->fifo_buf[i * 3 + bit];

It depends on the alignment. I haven't checked the assignee and the source
for that.  That's why I mentioned byteorder.h (and implying also unaligned.h)
for the cases like put_unaligned_le16(le16_to_cpup(val)). If both sides are
aligned, then yours suggestion will work.

-- 
With Best Regards,
Andy Shevchenko


