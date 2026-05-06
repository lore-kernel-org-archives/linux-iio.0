Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B688370D68;
	Wed,  6 May 2026 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052051; cv=none; b=nwh5gNuM/YQHszvTkAKXPnh50K3xx27WNHKLqFofiMgU5qkj744Xai6CanEmHMR51QlMIDtg8K0KWDJ5P5LFaB3JvTvSwPGZ0g+h7miAT+SgvNM+XGFA2ZAzolDkNROQ+XTmlqKCaHeI94+jIrO0bBWyLFrEQS8DzdCubrCB6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052051; c=relaxed/simple;
	bh=nkJBies3ceHSeof56lXHBaqx6Z8JWXVWMI5eIIe/FPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktZySqUrHSxqYpYlkIkwDVI/xHsVDQypniFkvvuGddonhj51+QLN4xZM5QGe5HCjKmnhZl54lWfo2xzb82rc51QxOYixI4xnjGhMqP0l+f7HZWrixXnRcSFluUgDHFtLca6UqeZ5ih1+WwaOAFzfku9WNd6jqzVTb7v6YPBjQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLHeaNNt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLHeaNNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778052049; x=1809588049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nkJBies3ceHSeof56lXHBaqx6Z8JWXVWMI5eIIe/FPI=;
  b=eLHeaNNtv/vpH6FMKu5CsJHyS41JlcjqOuvDyzBz0ZK2224/NZ37+FwL
   XDaIb5+9f0DBJ8R7yfBpc8W6ANx4TkAeAQxk3aXdm4S/R1FXp3BdkjrkJ
   KCWk7pb+zn369uVjiUI0PFs6lvTrMtkIJpIhkcKNEns71aa/iXdHlHdaa
   pQpIuAUl3qMkNc28QNvPL/A67d/WcGFQu8dbYJJ7V+RXJ4aoxlF7TjYSO
   jhZKqqsY5FRFs82x6dTbJ+wz4i0gwafk/mRjEQdeOoTkxRAbaI1/0uMC3
   z126od4VXsHvuIowAMzXpcGM2AHp2htjQGvtMyWJ3DtuqPW0Gi5fUhkJD
   A==;
X-CSE-ConnectionGUID: YpXNJI0HRAyX8XpbelCjJw==
X-CSE-MsgGUID: H/oQ/m0FQpGJFnUL0LJskg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78687932"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78687932"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:20:48 -0700
X-CSE-ConnectionGUID: DQ8fQPf9RveRHf0H+ZnS7A==
X-CSE-MsgGUID: wg8eOvhaQ/WMWV1LSlfGtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="236152641"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:20:47 -0700
Date: Wed, 6 May 2026 10:20:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/18] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
Message-ID: <afrrzM67n7NQWdE3@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-6-831b9b5550fc@gmail.com>
 <afrg7uXqyKs9il1Z@ashevche-desk.local>
 <CALoEA-z+K8FzgwbYfi_aJ3oL6qi2TyXFDYKpmn1Mmjw8XApvNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-z+K8FzgwbYfi_aJ3oL6qi2TyXFDYKpmn1Mmjw8XApvNA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 09:02:15AM +0200, Joshua Crofts wrote:
> On Wed, 6 May 2026 at 08:34, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, May 05, 2026 at 01:46:02PM +0200, Joshua Crofts via B4 Relay wrote:

...

> > >  static int ak8975_start_read_axis(struct ak8975_data *data,
> > >                                 const struct i2c_client *client)
> > >  {
> > > -     /* Set up the device for taking a sample. */
> > > -     int ret = ak8975_set_mode(data, MODE_ONCE);
> > > +     int ret;
> > >
> > > +     /* Set up the device for taking a sample. */
> > > +     ret = ak8975_set_mode(data, MODE_ONCE);
> >
> > But this piece does not belong to the main scope of the patch.
> 
> Fair, probably a badly resolved merge conflict.

Hmm... Usually what we use is interactive rebase. Very powerful tool!

	`git rebase --rebase-merges --interactive $SHA`

where $SHA is the same one that you used as --base for the series.

In conjunction with

	`git reset HEAD~1; git commit -s --interactive -c ORIG_HEAD`

technique, you can easily move parts between patches.

(There are even more advanced techniques, but I'm an old-school guy.)

-- 
With Best Regards,
Andy Shevchenko


