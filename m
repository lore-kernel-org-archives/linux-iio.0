Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482179;
	b=JoJ+sBQuqRGeOM293X2+nEDCHn2gAvS2OVPn0qtXwYRIx3nfRD3r+pZq9RhtAL0DHAfl
	 gcja529a82Bfai9XKg1a8cV6GucbCP/FV0yhUyB9t/fDOzvAtXPZONbKlGTkcKazXRxLr
	 02w5ohej6g9W8TFeR9xPf9guGjty8cCsRdmN2dZ0escdVd/Rf0yebPdP6QKKI0sH27lx9
	 hmDRgPyoBmWeQJFuvQXagn3Blr+U/o+ueXQmaP+3vA1vhL2/OUFceujED7IdQ4rVRZVdd
	 pXUr3nkE0jKfQHEBiOvMcytUYT05QBaosl+5No8/SI9fRWjrachKvw9Udaqk+nAk+Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482179;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=2loKeWf0wDURyAKswKxWApMnzZPMVFyCNh7CCsDHP4o=;
	b=sSiF8f48gwvW0xGIj1lnLjp+J6FkqDXcLgvUbwBK/IVikAM10YM2I5A69bGmsEt6NtIL
	 16OsDR73Ee/SHoeatI9njyRb9boIBrVWl2BiWaXyl+xwsZEt1W1I7yK3FzSY756NrCSL3
	 mq1alY715MR1TCKqmbKZDQb/uK1p7D8HLk2Q/aitCX3KRsg+xKF6lyTvLyLufhKaHcVpM
	 JUED+J4UDDISgWTIQyLtBl/jxcRZLR+0q3uMoFjPiVNOBni2NZlXJIqqp/kEdX/QFY+Sx
	 EoRQrLYSwY0OJVzeeuyLkQ0zcWLkucnd5/RN2MhqaOadXYP+++FUf5FiL3tLDLkyduw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gd1noZ4c;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4CA606A31C;
	Tue, 20 Oct 2026 07:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gd1noZ4c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792482178; x=1824018178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K65iELR37QU4nmOZbVW9Tg5Arj94zE4ccQ7nXnzwQIU=;
  b=gd1noZ4ceyS0FILXUQRNhL41uknl5j3jgN7Fpn6f28qN4jOwQbQP4M63
   Utv/rSiaruquTxzlWnGYs4KTPPK76FK0SDYrgHby83+tTe0Rl+VWrNR8C
   t42cw+IQFFeDlqkju57Hi1vBDMUgfSL9e3qDXP800PsWfqCpwH4TKNhQI
   GmEU6xDojaeac9n1TebqK4GvHutFSYpF/8yMQcuX9fdQVXhhG5KhZU5J8
   BFEHDXhtHf9IJYitsdmRf/bdNlGO9UJty7JiEGBLngpUN5Ed0XCtVdj/Q
   Jw7kJm6qyWrSa2XbQ3MxJlpHqwYj7xF5gJ8HNGa/5q8kA/3FX0zoVOt6+
   Q==;
X-CSE-ConnectionGUID: Ht8RsxZ5RZ2A3UA12x23lA==
X-CSE-MsgGUID: Fk7gG03QRfSRQdrO4rzMpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1190684"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1190684"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 00:42:57 -0700
X-CSE-ConnectionGUID: LcfO/NaOSCONLBn7dXEsDg==
X-CSE-MsgGUID: Mdj11aqLQCeGejcD6JjKAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2699737"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 00:42:53 -0700
Date: Tue, 20 Oct 2026 10:42:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>,
	vidhu.linux@gmail.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
Message-ID: <atcbe2O6REJqok2n@ashevche-desk.local>
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
 <20261020-tf-luna-v1-3-53a88f93db24@gmail.com>
 <20261020092316.00003339@gmail.com>
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
In-Reply-To: <20261020092316.00003339@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 09:23:16AM +0200, Joshua Crofts wrote:
> On Tue, 20 Oct 2026 00:03:43 +0530
> Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org> wrote:

...

> > When the signal strength is too low the sensor reports a dummy distance
> > of 0, so such readings, as well as overexposed ones, return -ENODATA
> > instead of a distance.
> > 
> > The datasheet is available at:
> > https://en.benewake.com/uploadfiles/2025/04/20250430174501874.pdf

Make it Datasheet tag.

> > Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>

...

> > +/* A measurement takes 10-20 ms in trigger mode */
> > +#define TF_LUNA_POLL_US			(2 * USEC_PER_MSEC)
> > +#define TF_LUNA_TIMEOUT_US		(100 * USEC_PER_MSEC)
> 
> uS is better instead of US.

Currently _US is established suffix, unfortunately. But I have no strong
opinion here, I'm full to support _uS, but OTOH the _US will be consistent.

...

> > +static const struct regmap_config tf_luna_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = TF_LUNA_REG_SIGNATURE + 3,

No cache?

> > +};

...

> > +static int tf_luna_measure(struct tf_luna_data *data, int *dist)
> > +{
> > +	__le16 buf[2];	/* distance in cm, signal strength */
> > +	u16 old_tick, tick, amp;
> > +	int ret, err;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = tf_luna_read_tick(data, &old_tick);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(data->regmap, TF_LUNA_REG_TRIG_ONE_SHOT,
> > +			   TF_LUNA_TRIG_ONE_SHOT);

> Why not have a local variable for regmap? It would allow the previous call
> to fit on one line.

Almost, but I agree.

	ret = regmap_write(map, TF_LUNA_REG_TRIG_ONE_SHOT, TF_LUNA_TRIG_ONE_SHOT);

-- 
With Best Regards,
Andy Shevchenko


