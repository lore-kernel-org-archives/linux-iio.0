Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011859;
	b=cIc3QQpTURMwTza+dorVtzECDp+9OHLlXZilVjJkSTP8K7gv0AfRY7Y4zlrZpej4Xg28
	 SujzGTszxBbc+/dpYXcu/j4OKhP7oMBF6CDYc0rKAHy3HH0qZWmKqajittdGgHeLf5nwu
	 ttBZtsYMWN3wgsbTRSE58e6SoLA1PTUajTxzV3yt+TYD5ykPTO0L9+4gAU/5l9vdOynXh
	 e9BFcQ6LvFLXRyOuDJ3m3STC2aJPM2xgzgijv9Acp0w3bbBM4T2H6bRwIKz/rDFUKIgEJ
	 cdC/i/pyPCr0BhRzr3gvJ88616zJQs85IxGFLYXjeMdhNjiXjo34Vf18QT3TGDzt7kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011859;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kmQEvKG4CMzbVMw4K/IBgEk1MXHDLqOQrYUZ7ewDtwU=;
	b=FgbfooT9jFqbzv5tqRFqbyWBRA/n37nRNPzUQIrvAof8ML3lgTOaXtgzf+zJaXfoK2lV
	 Vls1INoRek5bm79bBx3EPhOrsDT5F+pgOXMSs/CXfAOppfExRMF0lyY5IaKL2M0as0sfP
	 Kl7qXg7ZyQ0RV1ZBuitB01DOFsNpFH3fQ23qVSwbVA30QpHco1kfm0dz/Spu18nmhcNCp
	 lzVZ+Lpsi/HWKX3CFdMvO77RPOo75X4F1c5Kh54KXcg07cckt85q5UHEEY5W2LHQJjtQj
	 quwQLVZgVvYhCd8eDE1c0o0qmQ0XYHMk5G3p2HZYBpT0Q+xPHylkLvlhYut5CffhKaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L8sFEwZY;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A76606A33C;
	Mon, 26 Oct 2026 10:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A76606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L8sFEwZY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793011858; x=1824547858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=whmJtoIdcC46RFzy3YsAmoExsbtfQVq2H3BT00c+e84=;
  b=L8sFEwZY92wlVs0U5wxQI1GmXXb28V0a+cXPmdR067RgTrWmR8p1Xkmp
   76qu+jH71N1V2M4RQLL5lCbaL5jaGjSsFkskI6hh+Ftz6TjIqIti9srHI
   eRNPKsTkdvYU004+13Q1x6254BlfTezESIgQKqwQZUUztcvtCIMFS5eeg
   2IuXpXQZLIWioLD1DPiCOPoAh6wsCVG59m37wDDCKl+kfq+zreSvUhphV
   1VmrjqhRPpl6jWWMr6YYD/KIVagj+9O0y5sP7LwC/DVXCmRGlZBRzUiM1
   oZs9wLhBL3a9bZup+3JHKSToqW0hoNp8Mc4jpJ6Ewzd7RIiIfVrwTsi5z
   A==;
X-CSE-ConnectionGUID: Or5mGIjHRZ+9kzkNjTZFmQ==
X-CSE-MsgGUID: TUuMVJtrRX6zkR2zvAH5sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550204"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1550204"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:50:57 -0700
X-CSE-ConnectionGUID: 3c2W0tBMSlSqFshfQxFkAQ==
X-CSE-MsgGUID: yU0X9AesT5uhy3M1keiRnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4738167"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:50:54 -0700
Date: Mon, 26 Oct 2026 12:50:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Sabau, Radu bogdan" <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux <linux@analog.com>
Subject: Re: [PATCH v4 5/8] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <at8wi0tO7qR29i8E@ashevche-desk.local>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-5-a4d541ebfd13@analog.com>
 <ats2XBBnfGmusCI2@ashevche-desk.local>
 <LV9PR03MB841429F153BCF3BA9F18CC02F7612@LV9PR03MB8414.namprd03.prod.outlook.com>
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
In-Reply-To: <LV9PR03MB841429F153BCF3BA9F18CC02F7612@LV9PR03MB8414.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 10:22:22AM +0000, Sabau, Radu bogdan wrote:
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Friday, October 23, 2026 1:27 PM

...

> > > +static int adis16607_firmware_revision_show(struct seq_file *s, void *arg)
> > > +{
> > > +	struct adis16607 *st = s->private;
> > > +	u16 rev;
> > 
> > Can this be
> > 
> > 	struct revision {
> > 		u8 minor;
> > 		u8 major;
> > 	} rev;
> > 
> > ?
> 
> Although I like the idea, I have a question here.
> If u16 rev would be replaced by the struct and the read was done
> directly on the struct pointer, could it mess things up on big-endian
> targets? A native 16-bit store would place the value's low byte at
> the lower address on little-endian, but the high byte at the lower
> address on big-endian - so minor (at the lower offset) would only
> get the right byte on little-endian, and would actually get major's
> byte on big-endian, right?
> 
> What about we declare this struct and also have a u16 tmp declared,
> do the read on tmp, and then rev.minor/rev.major get assigned via
> FIELD_GET() - keeping the readability improvement without that risk?
> 
> struct {
>         u8 minor;
>         u8 major;
> } rev;
> u16 tmp;
> int ret;
> 
> ret = adis_read_reg_16(&st->adis, ADIS16607_REG_REV_ID, &tmp);
> if (ret)
>         return ret;
> 
> rev.major = FIELD_GET(GENMASK(15, 8), tmp);
> rev.minor = FIELD_GET(GENMASK(7, 0), tmp);
> 
> seq_printf(s, "%u.%u\n", rev.major, rev.minor);

Yes, this will work for me.

-- 
With Best Regards,
Andy Shevchenko


