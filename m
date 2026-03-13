Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25426336895;
	Fri, 13 Mar 2026 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394207; cv=none; b=k0XHxFMKRpVHKhDQhQHwII1yNBcMuPd9VTJL67VlCCP0X+lfODBXXkTkwuU8Tn/I/+1oH/dfJgXq/EtFg8LC5NxwKVcaKZd4hhM6RZRZevdoC1WEmWW5RQbijhYc92QsAv+aJq179IbTorNIMwVtJiMawiKj+wf/a8k6zOX7V2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394207; c=relaxed/simple;
	bh=ClY2wRaESVURRmRqKK2FcwN9QyfCcetyXgPPPCHz0Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2YjgGpehh0k9EVgESla39A3QqNHlV4zk+IO8SPXj6lx508krmt45eSnFR6IzhZWrKwKNguceZX9JERVha67GFnqJI90N1IpF9JcRlcz3D3+w0PV8bxdsLIznwJ83w+z458RdV/Lwrf+tSgMdcT8bw4BgaRJUKV5g0dOXntRXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iT/cob3i; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iT/cob3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773394206; x=1804930206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ClY2wRaESVURRmRqKK2FcwN9QyfCcetyXgPPPCHz0Rw=;
  b=iT/cob3ik5s9UWlzsDNhCdZ7IRs92zdAig+4B5FKomGophqnVLM973h7
   WuXN2WIYHOWVKwitsdXYPh0gLZRmRs6H7kSFW4VmoE8PkxAx9a/keCnCz
   IBNjaAD9t2ElLqBHXKJcVQWRxsfOdoLt7YCcBo49dzXrCtqdTNwBLQq2o
   daH3q5sssWVDSwXJ0ijW5PfEJ2Vrh4DlnRE6aW6QWMTWIPIzsa6T1MlX3
   nFJjwEXuz7b7FG/LaA728apegyzE/clDUn/i9bh98/ZlUvnQdlFI5MfYM
   I/kadQ9EpT1LxyQJu7LBhVpo25uC/0LAHApXKd5TrdmsNWFk6rnvhl0kr
   w==;
X-CSE-ConnectionGUID: 30+7Ik/XS2yjcsJjOx9YSg==
X-CSE-MsgGUID: A5sf0y72Tt+qoN3XXgzl8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74380768"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74380768"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:30:05 -0700
X-CSE-ConnectionGUID: YbLZYZgbS5qp7ng0VxytMA==
X-CSE-MsgGUID: 2Z5y++EfR/aJlHbErsrYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="226068259"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:29:53 -0700
Date: Fri, 13 Mar 2026 11:29:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Peter Rosin <peda@axentia.se>,
	Marius Cristea <marius.cristea@microchip.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Benson Leung <bleung@chromium.org>,
	Jyoti Bhayana <jbhayana@google.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Ariana Lazar <ariana.lazar@microchip.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	Antonio Borneo <antonio.borneo@foss.st.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kurt Borja <kuurtb@gmail.com>, Waqar Hameed <waqar.hameed@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	=?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH] cleanup: uintptr_t to unsigned long
Message-ID: <abPZD-fLDYzE2WRc@ashevche-desk.local>
References: <20260313013435.25731-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313013435.25731-1-tomasborquez13@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 10:34:35PM -0300, Tomas Borquez wrote:
> Linus has been explicit that uintptr_t should not be used in the kernel.

And it's all usually about new code. The shuffling _existing_ code is a churn.
This churn has to be agreed upfront. (That's what Jonathan's mail is, so
you need to have two links and proper message.)

> The iio_chan_spec_ext_info struct uses uintptr_t for the private field
> and in its read/write function pointer signatures. Jonathan Cameron noted
> this should be cleaned up in one go across all users [1].
> 
> Update the struct definition in iio.h and backend.h, along with all
> drivers implementing or using iio_chan_spec_ext_info callbacks.
> 
> No functional change intended.

> [1] https://lore.kernel.org/linux-iio/20260111122034.174c754c@jic23-huawei/
> 

This should be Link tag. And to the original email.

> Suggested-by: Jonathan Cameron <jic23@kernel.org>

We don't accept wrongly prepared patches.
NAK.

...

>  drivers/iio/adc/stm32-dfsdm-adc.c             |  4 ++--
>  drivers/iio/afe/iio-rescale.c                 |  4 ++--
>  drivers/iio/amplifiers/hmc425a.c              |  4 ++--
>  drivers/iio/chemical/sunrise_co2.c            |  8 ++++----
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  4 ++--
>  drivers/iio/common/scmi_sensors/scmi_iio.c    |  2 +-
>  drivers/iio/dac/ad3530r.c                     |  4 ++--

Besides that, it's much better to group them one per subfolder: adc, dac,
et cetera. Currently this even spams tons of people who do not want to
be spammed.

Take your time and become familiar with the process before sending a proper
version of this.

-- 
With Best Regards,
Andy Shevchenko


