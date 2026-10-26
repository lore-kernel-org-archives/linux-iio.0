Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005666;
	b=kG7dQ2nOJm4TMElwquRbYD21LxEu/ce9fj9gOnHTHfa11G7gUG+UpcuBI1NXQQKVDWyz
	 iD6C28hUDOTIg+3tY72zoIq0CggvO6GVZCk+Dx/QtsczFny+1HcxB57GIN3xQSG0SyVgA
	 BsF7TJvdN8axhIhkl12JlbB3uR+fc22WV8e89MEE0GAY6TbUG8tfAXfwvEPZuKjnoxZmE
	 JDYkQUEdooAILvhcV65k+5tC1lrGVPNnW9j5Z7SXmnps4kM6AIC5wT4ORxqdPR4qE0Zv6
	 EuyHjeUG7DPdFSIWMDfvMr988UCiSAyriUG1RekUTxAgII+MRlu6gXcmcVLpmvwelGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005666;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=tku1anvtsxeDxchSeNjnKF1Zpthldyy4qNBOIQp4nOc=;
	b=RraNLf8JEtAaFs/x7xk7JZRuv7KZkV4XtkYlPzP/HRXpMdoJNf1U7eXd+KIEgkAHbxBX
	 VKvQvtl1aWbwhKiK2Ta/UIMijHnhdGhLiWiDUQIOT0HtYLT27Eg4kUJtjJoED4Sds2pGx
	 EmU3qQ0yaIouCW/x9F1flQ7TyXyzPtbrnTn4k0U6FcvRLtaHF4762qzpglsF/LISOE/X+
	 /9KnhVLPeXN2yKw72dCSq5BCbqpnczHOtxZlTexC7SXjXpYfTn/SHTAP9cidrPdiKxW7L
	 HGjE156nsXLYJHUNBQJWRQBsdED7ek6ZVsAnrRg+WM4cC5hEUgLJEukbDIBecQ3ke+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SgtmbBEL;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E8606A31F;
	Mon, 26 Oct 2026 09:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A4E8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SgtmbBEL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793005665; x=1824541665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oRjbsiZqVRUV0hn32VGb6rhu6l3a8Gv47KkMMMF0Q68=;
  b=SgtmbBELmGMJXwdD2Z5jktDR/cwziyFNV/TIMbwMwOwh+ITRAMsxiRdd
   YoEJ63KVefAs3pml7A4lqiuTIN+zIWaMrcUCUzJ/PK8ae5KgGZQiIhjfE
   iynqyYkyNxYy7M5q2bfR6WOx2XBhmqhlBKEVVC92S/vN48HH5nmYbKUXu
   HfhlGZ7DhY6DhjKOfX8q2wCtZpsnDx+ulp06WGcGUVzRf5RI2SPZcGwPH
   JXD11U3WT75wVESFcFY83smJj45c2KmKTVJthLXWYoasomIEPCGGowRGA
   2di9dO5w2Y0t1m6tf3UlioS/aeyESImGeD6BhAfLBbFoTWUAIIBYyQZmg
   g==;
X-CSE-ConnectionGUID: MbaHcZjAQMCM63apN38zdQ==
X-CSE-MsgGUID: gg37bR7ASjqSH1RmouRvYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1566083"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1566083"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:07:44 -0700
X-CSE-ConnectionGUID: 9Vtw9D1DSD64C3SluN7cIQ==
X-CSE-MsgGUID: P4xaKnc+TyuJ/TiwCDReBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4267628"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:07:42 -0700
Date: Mon, 26 Oct 2026 11:07:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nithishvelan M <mnithishvelan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use
 guard(mutex) in ad5933_show()
Message-ID: <at8YW0nzftacwkga@ashevche-desk.local>
References: <20261019150248.416-1-mnithishvelan@gmail.com>
 <atZq2GstK_rxOgbj@ashevche-desk.local>
 <20261026024049.556c6642@jic23-hlaptop>
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
In-Reply-To: <20261026024049.556c6642@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 02:40:49AM +0000, Jonathan Cameron wrote:
> On Mon, 19 Oct 2026 22:09:12 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Oct 19, 2026 at 03:02:48PM +0000, Nithishvelan M wrote:

...

> > >  	case AD5933_IN_PGA_GAIN:
> > > -		len = sysfs_emit(buf, "%s\n",
> > > -				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> > > -				 "1" : "0.2");
> > > -		break;
> > > +		return sysfs_emit(buf, "%s\n",
> > > +				  st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1 ? "1" : "0.2");
> > 
> > You can (re-)use ridx here as well
> > 
> > 		ridx = st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1;
> > 		return sysfs_emit(buf, "%s\n", ridx ? "1" : "0.2");
> 
> Maybe call it something else here as its not the range index that I can see.

True! I have no idea where the part of my thought went during the previous
reply as I definitely kept in mind and wanted to add something like "(and this
might need a variable renaming)".

-- 
With Best Regards,
Andy Shevchenko


