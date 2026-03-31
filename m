Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85C3D34A2;
	Tue, 31 Mar 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943657; cv=none; b=Qz/GAeq6K3SAjoPoRYhHcR2nGB8willdftef1E1+Sx/Pa79af1sc3lIynYWy1x5h44jDavcgGhjrucB5D7kzqTUhAbvVWfTnWdeX2wWWay6X5sAZyo9js9ndDiEuyYRtuZ8OD/Zei2TzAn2EPX36d0799de91yPaCrQCgyle8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943657; c=relaxed/simple;
	bh=2IMj/BIRJdFD9ABWnfO2RCXpsCT0xr19nkrSOpbX9DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBVLTS9AqnkAgbESuiBA1IRUHj4ftAP0sSgQHxIdHzkmlAFzKdi8cibWhYbS/6Mw47nwKF+3kWfedTsiEsSF2E+q1CA6NwlFsGGRgnWIapI45uVp+QTPB+DuTtl7JIMvsIS4XkCzc/8g8fDoFKUi20AAYtOCT7HY4bk6xEmFsvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eUdhRMM0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eUdhRMM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774943657; x=1806479657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2IMj/BIRJdFD9ABWnfO2RCXpsCT0xr19nkrSOpbX9DY=;
  b=eUdhRMM0aq3Pt8ZAOmo9qo502te5pqdyWqjZvjmAbX/dQTXhvCgt+eq4
   TDi8YjwEZmszIZ/S5vcSKptHAzf5ua6PxghubAER88kbhmAJDAbWYcGLI
   3QfOCC/j3uzQxtLBzGpSk080HOZ3TZ4rU8omQh227nVQclQXfbfrNDHxj
   bbQq3JK9dKkplGH+louHq4HT07B5PUQhTt88WRlGx6O9ZiD8aIfS22xLt
   EmRlaiz/KeFBD4oMgmuy/stNvu2iE26OeRuhRbIeSuD8eD9kEP6qndRdG
   Sbu7jpKFsYqO5X85yfu+deWN5iDeRlNBmQl2hBvOt2lD4OZojbOY36a2j
   Q==;
X-CSE-ConnectionGUID: 2egAJwVPSj6tvudZNFZ5ww==
X-CSE-MsgGUID: Hu8dwAdDQIik0kyc1EJOaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75833775"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75833775"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:54:16 -0700
X-CSE-ConnectionGUID: KUk4/kGBShycdY6SwnesBw==
X-CSE-MsgGUID: XeTFZwvSS4qJAUkryx1aeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221885885"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:54:12 -0700
Date: Tue, 31 Mar 2026 10:54:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] staging: iio: adc: ad7816: use modern IIO
 attribute macros
Message-ID: <act9ovNVsJvWO6Cx@ashevche-desk.local>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
 <20260330181710.23258-5-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330181710.23258-5-mdmahmudulhasan1511@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 12:17:10AM +0600, Md. Mahmudul Hasan Mabud wrote:
> Modernize the driver by using IIO_DEVICE_ATTR_RW and

IIO_DEVICE_ATTR_RW()

> IIO_DEVICE_ATTR_RO macros. This involves renaming the callback

IIO_DEVICE_ATTR_RO()

> functions to standard <name>_show and <name>_store formats, making

"...<name>_show() and <name>_store()..."

> the code cleaner and more maintainable.

...

> -static ssize_t ad7816_show_mode(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> +static ssize_t mode_show(struct device *dev,
> +			 struct device_attribute *attr,
> +			 char *buf)

You can use room on the previous line(s)

static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
			 char *buf)

...

> -static ssize_t ad7816_store_mode(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf,
> -				 size_t len)
> +static ssize_t mode_store(struct device *dev,
> +			  struct device_attribute *attr,
> +			  const char *buf,
> +			  size_t len)

static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
			  const char *buf, size_t len)

And so on...

...

> -static ssize_t ad7816_show_available_modes(struct device *dev,
> -					   struct device_attribute *attr,
> -					   char *buf)
> +static ssize_t available_modes_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)

This is okay to leave as is, as it might be too long (over 80).

-- 
With Best Regards,
Andy Shevchenko


