Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3174194A6C;
	Wed, 29 Apr 2026 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492031; cv=none; b=AvoZhHS5TRim59tz9bkHMSHH8hczVDgogXic0Oy6ZfiZyFi/kbad0hoAkwJUlztIVO0UL14jAjYOv3nL0x3kaEQkH7uhDU7bv3kwJigCJ4Q2HIV8Cn2u/tkJruLNIdylrUruuB+GMpK6+2OllBDsD/kkEVWyxBLOmim/7Uuw+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492031; c=relaxed/simple;
	bh=6zMJPlCzBFsIzmH9C7DCUzlFezjuerKEUd/NjhQDdwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF/bcQXJvgYRsrqIVpV48MRnBnvRIM2ec3knsftdlHXH8kujlvh8JbQDsR1bdn3KVQgnnM7GdzHQprvPB5y1OI2CDIpIzR+5lLlzpvfcwbTTKFxpdIKICHMb7+kKF4RFyJxNYuJugAXhUdFGU0BgCcfa/Dsd/OaH8DkFlNruoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDeJOgP7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDeJOgP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777492030; x=1809028030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6zMJPlCzBFsIzmH9C7DCUzlFezjuerKEUd/NjhQDdwg=;
  b=IDeJOgP7TQyK/eJ0hXGUD0yjckqox5pY8IvCfVGYdBJG7TiMvZk2WeI2
   gV1y5867WVj3ARg815j7ZEKmcLf6WmWo/H9Crg8XAxbdn79JyXrMtGnyO
   Fzdkorw+5eR7DRoAkQTZgaWQ4cKtXz4WQb8dA8udDe5/Vd9yJ/bllKfcS
   CzxbNMiy9VuMeqAb8Rs4qxIG6MNnwORNQgHHf6BuVO08hjHcQa+tE8wnM
   04scjTMFqau12JClPK1xxoD38nE4RYkY4cswY1OlBZwHJYqSVjnz7UgQG
   tqsj9F1n7Ih1cmjaagI1JnRI0u6ldjWXSZ+bVqbKJtqsyuwZniiekRU6W
   A==;
X-CSE-ConnectionGUID: x9wDsoBxRCiWd8FSpq8kLQ==
X-CSE-MsgGUID: KcdW0avPROWgxG0zm9vzSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89031424"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89031424"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:47:05 -0700
X-CSE-ConnectionGUID: lM+CHRiGTVqpdkJdp+sBHQ==
X-CSE-MsgGUID: vweuhPFcRfqvaT4k8qwKTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="227858748"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:47:01 -0700
Date: Wed, 29 Apr 2026 22:46:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH V3 6/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID: <afJgM5DhK6Repa1d@ashevche-desk.local>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-7-macroalpha82@gmail.com>
 <f1ae57fe-1ad5-46ee-9f0c-245f4deec7ce@baylibre.com>
 <PH0PR19MB997338EE6A13BD08879C4B9B2BA5372@PH0PR19MB997338.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR19MB997338EE6A13BD08879C4B9B2BA5372@PH0PR19MB997338.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 09:01:12AM -0500, Chris Morgan wrote:
> On Fri, Apr 10, 2026 at 05:59:05PM -0500, David Lechner wrote:
> > On 3/30/26 2:58 PM, Chris Morgan wrote:

...

> > > +/* IIO format int + nano */
> > 
> > Usually we make these 2-D arrays for readability and then cast to int * if needed.
> > 
> > > +static const int inv_icm42607_accel_scale[] = {
> > > +	/* +/- 16G => 0.004788403 m/s-2 */
> > > +	[2 * INV_ICM42607_ACCEL_FS_16G] = 0,
> > > +	[2 * INV_ICM42607_ACCEL_FS_16G + 1] = 4788403,
> > > +	/* +/- 8G => 0.002394202 m/s-2 */
> > > +	[2 * INV_ICM42607_ACCEL_FS_8G] = 0,
> > > +	[2 * INV_ICM42607_ACCEL_FS_8G + 1] = 2394202,
> > > +	/* +/- 4G => 0.001197101 m/s-2 */
> > > +	[2 * INV_ICM42607_ACCEL_FS_4G] = 0,
> > > +	[2 * INV_ICM42607_ACCEL_FS_4G + 1] = 1197101,
> > > +	/* +/- 2G => 0.000598550 m/s-2 */
> > > +	[2 * INV_ICM42607_ACCEL_FS_2G] = 0,
> > > +	[2 * INV_ICM42607_ACCEL_FS_2G + 1] = 598550,
> > > +};
> 
> I've gone through and implemented all of the changes everyone suggested, though
> this is one of the few on which I had a question. Obviously this driver was
> cobbled together from 2 different sources and checked to the best of my ability
> and tested/validated against the data sheet, but there are a few bits I'm not
> fully clear on such as this.

> What's the correct way to represent this data? Since it looks like one of the
> values is always 0, should I just assume it's always 0 and only represent the
> values that change in this scale?

Isn't the comment is clear about that? The first one is integer, the second one
is fraction. So, no, your assumption is wrong strictly speaking.

-- 
With Best Regards,
Andy Shevchenko


