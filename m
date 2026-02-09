Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B4322A;
	Mon,  9 Feb 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632991; cv=none; b=RM8/CYfFA4mH3oVjTfr1VbgjtaZuTIszJRyx30epYUd0R1NNtz2lc6c0s1ko3cOH9uWl5tmqREkCMvMJt6v4bpYxMYUEdmFOULJGo2DyXr2HMWAAu/41Ddz7LvFhaM7+yE2/Fck5IM2NqpFArkxh5TIIqfWyhXmLsFcaIWxZxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632991; c=relaxed/simple;
	bh=xZAYrTTulIZUYoCgEfQWTg7GfovcesjeRz77/U3qLpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agq3ygZ9unIHc+sY6/LzYwpFBazvDaNaoWeXcp5F5Ll2zfoG45u8xfH73+LP+cpaRdIgtQUW4Avf2zxTEYI2QS4S9lsLVEDPqH2np/QgWTNd0WyyVk58RDxCQ3KoJTyxOotSoTDMGPzV+9kZfspfWIAsE9fz0KNKS/t2nYrzX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuHYdjzQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuHYdjzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770632991; x=1802168991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xZAYrTTulIZUYoCgEfQWTg7GfovcesjeRz77/U3qLpw=;
  b=AuHYdjzQCkoVb7/uJiKqNr8c+FrmvZeX06JoDfBEg67ELXQ6pfLLT00Q
   BRPZOeWj3+ER7ExkMAjTLlk/b1OecQHRbtUgGuF/Ye4+KdX1FBkfxUCDr
   Ymp0lPpy3DMmqG23RP698HYWymWX2fKVpNDkwem8I8XnWJ/4InuJs2+P8
   TMB8pZYlRcKf58Ea71U+xRd/JJu9ElBuRzIltbhLUOXfNf29G81RwM1Z8
   PWJ1SWBhg/52Vwtd/gACe2p1/w/V6JBlQPH9AVH7IX6mXFeWzZv20jLQq
   a3HFE5mZy4rDOzR59LHJKzQ63VylM6vuiO29uFEqQyfNc4CY9txqQMI3W
   g==;
X-CSE-ConnectionGUID: fMGkYcOUT2eUJ+pHrmr/Nw==
X-CSE-MsgGUID: Z6trS8AdRXmEE1Ado0l4MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="59307693"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="59307693"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 02:29:50 -0800
X-CSE-ConnectionGUID: wPkm/+a5QT+WbU9iN08AwQ==
X-CSE-MsgGUID: aGNt7k67TQa/UZrfTT3jng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="210855132"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 02:29:47 -0800
Date: Mon, 9 Feb 2026 12:29:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 06/13] iio: dac: ds4424: use device match data for
 chip info
Message-ID: <aYm3GBNKalUWloA2@smile.fi.intel.com>
References: <20260203093434.2548978-7-o.rempel@pengutronix.de>
 <aYHH69gXyuwmQR03@smile.fi.intel.com>
 <aYHLRvfJH54XumUA@pengutronix.de>
 <aYHhO7pJPEew7QMC@smile.fi.intel.com>
 <aYHjQhO92yxoy_9o@pengutronix.de>
 <aYIMgEEDd8ZfLv71@smile.fi.intel.com>
 <20260205204325.5bd09d97@jic23-huawei>
 <aYWe0-2KMLijFVh6@pengutronix.de>
 <aYW7lt26Tn-6Fgno@smile.fi.intel.com>
 <aYmnRXp6ChsUAjnB@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYmnRXp6ChsUAjnB@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 10:22:13AM +0100, Oleksij Rempel wrote:
> On Fri, Feb 06, 2026 at 11:59:50AM +0200, Andy Shevchenko wrote:
> > On Fri, Feb 06, 2026 at 08:57:07AM +0100, Oleksij Rempel wrote:
> > > On Thu, Feb 05, 2026 at 08:43:25PM +0000, Jonathan Cameron wrote:
> > > > On Tue, 3 Feb 2026 16:56:00 +0200
> > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> > > > > Just do not introduce that change (change of the ->name field) in the original
> > > > > patch, in that case no revert churn would be needed.
> > > > > 
> > > > I think this got dealt with in discussion of next version but
> > > > safest route is just have an extra copy of the name in the
> > > > chip_info structure.  Then we know it's stable against different
> > > > firmware types etc.
> > > 
> > > Something like this?
> > 
> > Yes, but make it in the patch that introduces DT support.
> 
> Hm, I'm not sure what do you mean. There is no patch which "introduces
> DT support" in this series. Do you mean, this one:
> https://lore.kernel.org/all/20260204140045.390677-7-o.rempel@pengutronix.de/

Yes, I meant that one.

> Or should it be better a separate patch?

Perhaps just after the above mentioned one. Either works for me.

-- 
With Best Regards,
Andy Shevchenko


