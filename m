Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCA73A7829;
	Tue, 31 Mar 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955171; cv=none; b=qd0Lv/tNmHCWoe9bN3XAJaM2ntAU/LQTEbOGexOCosICf5HdVDkshm0jJLNtzfZw2Jt2EkDb+XtFuw0JsmakD9p31clUW74n8ynuOKiTi5aVTHs5sY+/ZVXefP9Zlk4ewXfOCbhs/cnMYSG3Qio0p3GHvPoaeUYXggzLBt27RjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955171; c=relaxed/simple;
	bh=PoaVpc571Ec3442jL4M7Cr/PjqceHSOFOivugd3E58I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ3HibM4dxoJ71zumu57ZORfXx75SbOVmrGTHue3FbIy9OjH8rFXnBIUH3Mhl9laLXqUBL05USstYbc6u4L/IGa4LYd7TrbNliqQYbUbfUW5V7WAcmuxbzEnG1oLsp1uMCSysJ3Z5vzVHtkvelgNXpKLQT5Wg6ZGdSDcR9VhNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STOh0/JG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STOh0/JG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774955170; x=1806491170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PoaVpc571Ec3442jL4M7Cr/PjqceHSOFOivugd3E58I=;
  b=STOh0/JGW5SCjmyMYhB2Zh1dOPd7F+Ta/9StBfBTrStMydh3EsOai4KV
   bGLXIK1AVzGX2WyEUgr1PcfHhy7uFcJJ31HwRm2T0Js4euCVeT9cQksrd
   DpPkk3wB6cpkYdGk8XUoUw/32yu8CuiWJEVjpCyGe5S0qgSSzlB+3BPId
   vnKzk9gWd8NJj7Y17vTqMV10SQeYfsV8ezaMRdUTUXrWftnEv8mdS6oMy
   drSlWPmjqHqd4+mIy0iqeQ1JFjvvmf+RI17nGkAxYyhsH/ydbKpYgW/o+
   hA/6L/33gQnnOvDAd3oUOWaZIcdpzVV2qn1naqBwqWSR1MYby2hwRlLoX
   g==;
X-CSE-ConnectionGUID: Mri0rptbRX2OadUHZZEoHQ==
X-CSE-MsgGUID: 8jOPraVFQ9i192xci06AQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87429099"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="87429099"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 04:06:09 -0700
X-CSE-ConnectionGUID: mLpdyeuHSZ2oADhUrtgNPw==
X-CSE-MsgGUID: 6Kf1MVEeQKCanoEwrIut/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="226211574"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 04:06:06 -0700
Date: Tue, 31 Mar 2026 14:06:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <error27@gmail.com>
Cc: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] staging: iio: adc: ad7816: redefine mode
 constants to start from 0
Message-ID: <acuqnOdv-ym628fC@ashevche-desk.local>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
 <20260330181710.23258-2-mdmahmudulhasan1511@gmail.com>
 <acunqXdKj7im8tH7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acunqXdKj7im8tH7@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 01:53:29PM +0300, Dan Carpenter wrote:
> On Tue, Mar 31, 2026 at 12:17:07AM +0600, Md. Mahmudul Hasan Mabud wrote:

...

> >  /*
> >   * AD7816 config masks
> >   */
> > -#define AD7816_FULL			0x1
> > -#define AD7816_PD			0x2
> > +#define AD7816_FULL			0
> > +#define AD7816_PD			1
> 
> I don't love this.  AD7816_PD used to be related to the spec but now
> it's just a random number which tricks you into thinking it has
> meaning but it doesn't.
> 
> if (chip->mode == AD7816_PD) { /* operating mode 2 */

We can leave that and add a new member to the string array

	[_DEFAULT] = "default";

and associate it with the default choice which seems to be _FULL as per
kzalloc() in the IIO core.


-- 
With Best Regards,
Andy Shevchenko


