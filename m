Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900053;
	b=W0Gu+1BouAo9yI8mslpBwi3laOg7rKi/htSkcTWlnNAgFj+eSqt8zgwRZ379/ZlluzXd
	 3qym7jnjkJPHKCAWW06mtCNReDLMoWolnld9ynB9AFs9cGFS+vtxfZ2Gfi4p/qepGezoB
	 UxF2ytblNHjm5vDeNZBMTwXLGsWDs2s8Qk/UJJqZnHTqCQz38AlO4SSzc9kUH4MvSdvgv
	 sn3vu/BvDuPINocZup/qiOiPHF7khynvTCLN90L1a6XeHf2WKbFHr972Pylr5ZuKHNEii
	 ql3+VF8+RtitYPwP1ZqnPMja6KRjcK4kRhN5KrTUhiV55ENIt7fSjno4LY+JmRvWQMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900053;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=r78d25eq31clnnMyTRJuEPeA5cn2PAIMfFhC3qOaX7Q=;
	b=QABH8RdpeBt3geRrXpyJAlNc0D5IRLKiFsa+/sKy4a9FkShmKzo2qKbiMl5re5/H3W3T
	 c34B4mhBFjyEwpi8ru6A157j3M+9fOzOsRUm9r+DYTVbZpgKO3tErQcUnhv0fh6WstLwX
	 NpFa3/Q3bi4WVRlOm8IHr4slq0Ynhc3N5+s7z7zueuCdsHyLa7AFF4i63xCoEMJKCMvV1
	 zypLn/l7jLPQKLoagWYrODjdHAqeWP/PufztQBgT6l+l4UKZHAhyCpA01eiFnzPESfFxH
	 k53f52Dw/lwGxwmhkCI6g1g1py8aRK7O/Jjzd6QGZSsoTx0wetLzG/HVXQf3g1RlEGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lWL0RSuG;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC0606A323;
	Tue, 17 Nov 2026 07:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4CC0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lWL0RSuG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794900053; x=1826436053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RzqdnLYtnO8s7wQRK1Si3iRKel1Lg63Gwzwt8mNGBSk=;
  b=lWL0RSuGcI1hLaIxaMQ2CF/mR7ky93Hy/uOejQysOpDqgIcm/IeYG261
   /UQee29vIo0jwVoauWDwtE8lg5sOo8LOblfxizcUHMbonixjfPog5gwdx
   7cNosxN7ffzN155zfUJnJ8rMmiSBneY9kv6RLyF+HACgOvOEl0qXXqM0f
   FMi2KlJi6hUsJyjYkpNa+WsxjQjUWyaR+khomPWVEqxcyhw0uey5oJ72M
   /FBqJwtil/NqJ2C/noIVfWtwLRGOA9KGp8/mivPXW9nqnQfJvbxXRVjKo
   fFRvlD95aaEcz6PSFXviX40oc1umUo4hIeWNID/TRU8LDMVg7Ys9F+q7L
   w==;
X-CSE-ConnectionGUID: JdIpb/JqRwKoX46lGzsSog==
X-CSE-MsgGUID: SRHAJAvaSSC8Inia7OrffA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3768780"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3768780"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 23:20:52 -0800
X-CSE-ConnectionGUID: /FKFSvW7Rw2cAs0gbWxCkw==
X-CSE-MsgGUID: og9Hz5kZREeueRJOXccMhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10159146"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 23:20:45 -0800
Date: Tue, 17 Nov 2026 09:20:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Gustavo Silva <gustavograzs@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Esben Haabendal <esben@geanix.com>,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH 00/35] iio: closing default trigger handling leaks
Message-ID: <avwASv6SGjvLG0jr@ashevche-desk.local>
References: <20261116014823.3132576-1-jic23@kernel.org>
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
In-Reply-To: <20261116014823.3132576-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 01:47:48AM +0000, Jonathan Cameron wrote:
> 
> Note this is compile tested only!  I definitely want a few people
> to test that I didn't break everything.
> 
> This is the first part of what I think is a long term solution to the
> currently really fragile ordering constraints around setting default
> triggers. Today these are set by iio_dev->trig = iio_trigger_get(trig).
> The reference is only released on the iio_dev.release callback and
> only if we have set the mode to include one that means there might be
> a trigger set. That mode set only occurs when a buffer is registered.
> Thus trigger release only works if we have already registered a buffer.
> 
> One solution would be to reorder so that the default trigger is always
> set after the buffer registration (we have had various recent proposed
> patches to do that for individual drivers) but that is non obvious and
> fragile.
> 
> The solution here is easier to reason about. Decouple the setting
> of the default trigger from the acquisition of a reference. Thus
> we can acquire the reference in iio_device_register() when we know
> all the conditions for it's release have been achieved.
> So that's all we do in this part 1 series.
> 
> Part 2 will address immutable triggers and those that are effectively
> immutable but predate that logic. That is those that set a one to one
> relationship between device and trigger.  That change is rather less
> mechanical than this one and 35 patches is really a bit big anyway
> even if most of them are small!
> 
> Part 3 and beyond will move to a situation where the iio_dev->trig
> will become opaque. That should stop anyone manipulating that directly.
> I have a few related cunning plans to test out before we get to that,
> not because the particular challenge is hard, but because they will
> trample on the same code.

> Jonathan Cameron (35):
>   iio: core: add default_trigger and take reference in
>     iio_device_register()

I have reviewed the first patch and briefly looked at the rest which seems
like a semi-automatic translation in most cases.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

>   media: pci: mgb4: use IIO default_trigger
>   iio: chemical: ens160: use default_trigger
>   iio: adc: ad4130: use default_trigger
>   iio: adc: ad4170-4: use default_trigger
>   iio: adc: ad7768-1: use default_trigger
>   iio: adc: ad7779: use default_trigger
>   iio: adc: ti-ads131e08: use default_trigger
>   iio: addac: ad74115: use default_trigger
>   iio: addac: ad74413r: use default_trigger
>   iio: temperature: tmp006: use default_trigger
>   iio: adc: ad4062: use default_trigger
>   iio: accel: bma220: use default_trigger
>   iio: accel: bma400: use default_trigger
>   iio: imu: smi330: use default_trigger
>   iio: light: acpi-als: use default_trigger
>   iio: chemical: scd30: use default_trigger
>   iio: accel: bma180: use default_trigger
>   iio: accel: kxcjk-1013: use default_trigger
>   iio: accel: mma8452: use default_trigger
>   iio: chemical: ccs811: use default_trigger
>   iio: pressure: mpl3115: use default_trigger
>   iio: common: st_sensors: use default_trigger
>   iio: common: hid-sensors: use default_trigger
>   iio: pressure: bmp280: use default_trigger
>   iio: light: vl6180: use default_trigger
>   iio: gyro: itg3200: use default_trigger
>   iio: imu: bmi160: use default_trigger
>   iio: accel: adxl355: use default_trigger
>   iio: gyro: adxrs290: use default_trigger
>   iio: accel: adxl372: use default_trigger
>   iio: light: si1145: use default_trigger
>   iio: adc: ti-tsc2046: use default_trigger
>   iio: accel: mxc4005: use default_trigger
>   iio: gyro: mpu3050: use default_trigger

-- 
With Best Regards,
Andy Shevchenko


