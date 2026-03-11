Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B43CCFBF;
	Wed, 11 Mar 2026 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231521; cv=none; b=lt822k/94uXt+YOngPcWGL4SSsnMlXLbLtg4hgJcuYEUIZCajiIGGvrcEKcJ9plPaAIb0O12yz3Kj62tzeF1n0UQhsSeIIKrWQ0FdFnMaaTT2TgUoRAUaWqms7dCiIlJMiYIAlmj4VGtLICMEzMkG1N4T6FXTIZwj4m7ouqM8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231521; c=relaxed/simple;
	bh=InzsTl1hnNNecjD7snJvzJloux/8wy7GR5JJTXnPzPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTFytZLL9UdlWPV+EIpqiLYrJorZ0TcslVFfy8tNSj3eiPhJSVOE3vZH5uPHyEKbzVyRUCZiK+i8yG88jyY8lxJ1L42TWeE88EFTqgvArY1N66yvkB8drRSyNeAhWAe5M1XysDTTdy7v6Wl714+wFW6ko+glNglQXUArOiQij5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dW0btGjA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dW0btGjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773231518; x=1804767518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=InzsTl1hnNNecjD7snJvzJloux/8wy7GR5JJTXnPzPw=;
  b=dW0btGjAuQysQWg3OshxB5euFZbvvYgNQ1Bxb/2zpoBGiUOePSSw96WN
   PNwrfnOOiBdI0jNo+yt5pcjziHWyfELUe5Z1jLOrb5EsgbqYQLFcJAO81
   jVi0y15+o6MrsZ903Q734fVq5K3BY572V5icjR9YRrKyxMQg95niISHgm
   Fb1ytjkilWCtJdZOJA1nbzah5TeLnxJUXkBzrLVkNDZaeQx5Bu41Sb4r5
   Zc2KPE0xTn2uqidup0lFwGHHOnRqLNdMPGqr57pH/xU48G9/xsWv3cpFd
   co41l0kg4SRH08ilgq37Oh2odEqih9OGSHQDZgx3zoSl96NI6eZlC/UHb
   A==;
X-CSE-ConnectionGUID: +ZzF3ZinQmG3CZ8afSraVg==
X-CSE-MsgGUID: NpW5s2w6RjGFNrzdaljAig==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85001775"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85001775"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:18:37 -0700
X-CSE-ConnectionGUID: rX98UaKOQ3KCY4F3rIYAJA==
X-CSE-MsgGUID: EvJHbzg7Rq6ZduXdu4cmeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220499705"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:18:35 -0700
Date: Wed, 11 Mar 2026 14:18:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David =?utf-8?Q?Marinovi=C4=87?= <david.marinovic@pupin.rs>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: dac: ltc2632: add support for LTC2654 DAC family
Message-ID: <abFdmNIZYQFUIGIE@ashevche-desk.local>
References: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
 <82ba84f98db9c32d3fc4efd7ef6697a2@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82ba84f98db9c32d3fc4efd7ef6697a2@pupin.rs>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 10, 2026 at 04:29:48PM +0100, David Marinović wrote:
> 
> Add support for the Linear Technology LTC2654 quad DAC family.
> The LTC2654 is a 4-channel, 16-/12-bit DAC with SPI interface,
> sharing the same 24-bit SPI protocol as the existing LTC2632/
> LTC2634/LTC2636 devices supported by this driver.
> 
> Add support for the following variants:
> - LTC2654L-16: 16-bit, 2.5V internal reference
> - LTC2654L-12: 12-bit, 2.5V internal reference
> - LTC2654H-16: 16-bit, 4.096V internal reference
> - LTC2654H-12: 12-bit, 4.096V internal reference

...

> enum ltc2632_supported_device_ids {

>         ID_LTC2636H12,
>         ID_LTC2636H10,
>         ID_LTC2636H8,
> +       ID_LTC2654L16,
> +       ID_LTC2654L12,
> +       ID_LTC2654H16,
> +       ID_LTC2654H12

You see how nicely the new IDs landed here, but after you it will require an
unneeded churn.

>  };

...

> static const struct spi_device_id ltc2632_id[] = {

>         { "ltc2636-h12",
> (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H12] },
>         { "ltc2636-h10",
> (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H10] },
>         { "ltc2636-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H8]
> },
> +       { "ltc2654-l16",
> (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2654L16] },
> +       { "ltc2654-l12",
> (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2654L12] },
> +       { "ltc2654-h16",
> (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2654H16] },
> +       { "ltc2654-h12",
> (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2654H12] },
>         { }

Can we have a refactor patch to drop that enum and use separate chip_info
static objects?

>  };

...

> static const struct of_device_id ltc2632_of_match[] = {

>         }, {
>                 .compatible = "lltc,ltc2636-h8",
>                 .data = &ltc2632_chip_info_tbl[ID_LTC2636H8]
> +       }, {
> +               .compatible = "lltc,ltc2654-l16",
> +               .data = &ltc2632_chip_info_tbl[ID_LTC2654L16]
> +       }, {
> +               .compatible = "lltc,ltc2654-l12",
> +               .data = &ltc2632_chip_info_tbl[ID_LTC2654L12]
> +       }, {
> +               .compatible = "lltc,ltc2654-h16",
> +               .data = &ltc2632_chip_info_tbl[ID_LTC2654H16]
> +       }, {
> +               .compatible = "lltc,ltc2654-h12",
> +               .data = &ltc2632_chip_info_tbl[ID_LTC2654H12]
>         },

Ditto.

>         { }
>  };

...

> Subject: [PATCH 0/2] iio: dac: ltc2632: add support for LTC2654 DAC family
> Date: 10.03.2026 16:27
> From: David Marinović <david.marinovic@pupin.rs>
> To: jic23@kernel.org
> 
> This patch series adds support for the Linear Technology LTC2654
> quad DAC family to the existing ltc2632 driver.

Huh?!

-- 
With Best Regards,
Andy Shevchenko


