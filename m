Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51894 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbaKEPsA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 10:48:00 -0500
Message-ID: <1415202439.7630.13.camel@hadess.net>
Subject: Re: [PATCH v3] iio:kxcjk-1013: Add support for SMO8500 device
From: Bastien Nocera <hadess@hadess.net>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Wed, 05 Nov 2014 16:47:19 +0100
In-Reply-To: <CAEnQRZDD40S7ScRsKmAHR_XsA-moAzyvYUqEyiT9ME6dDM9zfA@mail.gmail.com>
References: <1415056822.4506.24.camel@hadess.net>
	 <545A3671.2010102@kernel.org>
	 <CAEnQRZDD40S7ScRsKmAHR_XsA-moAzyvYUqEyiT9ME6dDM9zfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2014-11-05 at 17:22 +0200, Daniel Baluta wrote:
> >> @@ -1397,6 +1404,7 @@ static const struct acpi_device_id
> kx_acpi_match[] = {
> >>       {"KXCJ1013", KXCJK1013},
> >>       {"KXCJ1008", KXCJ91008},
> >>       {"KXTJ1009", KXTJ21009},
> >> +     {"SMO8500",  KXCJK1013},
> 
> Commit message says that your accel is KXCJ9, but here you use the
> index
> for KXCJK1013. Which one is true?
> 
> >>       { },
> >>  };
> >>  MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
> >> @@ -1405,6 +1413,7 @@ static const struct i2c_device_id
> kxcjk1013_id[] = {
> >>       {"kxcjk1013", KXCJK1013},
> >>       {"kxcj91008", KXCJ91008},
> >>       {"kxtj21009", KXTJ21009},
> >> +     {"SMO8500",   KXCJK1013},
> 
> Ditto.

Missed this. Will respin a patch after testing, though the differences
in code between the 2 devices are very minimal it seems (only some PM
functionality).

