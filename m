Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-225.synserver.de ([212.40.185.225]:1055 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750851AbbKKTIO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Nov 2015 14:08:14 -0500
Message-ID: <5643921B.5070707@metafoo.de>
Date: Wed, 11 Nov 2015 20:08:11 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Martin Kepplinger <martink@posteo.de>, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 1/3] iio: mma8452: add freefall detection for Freescale's
 accelerometers
References: <1447267094-2248-1-git-send-email-martink@posteo.de>
In-Reply-To: <1447267094-2248-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/11/2015 07:38 PM, Martin Kepplinger wrote:
> This adds freefall event detection to the supported devices. It adds the 
> in_accel_x&y&z_mag_falling_en iio event attribute, which activates 
> freefall mode.
> 

Hi,

Thanks for the patch, looks pretty good. Just a few things.

> In freefall mode, the current acceleration values of all activated axis 
> are added and if the *sum* falls *under* the threshold specified

Are you sure its not the magnitude of the vector rather than the sum of the
individual components?

> (in_accel_mag_falling_value), the appropriate IIO event code is 
> generated.
[...]
> +enum { +	axis_x, +	axis_y, +	axis_z, +};

That should be part of patch two I guess.

[...]
> +static IIO_DEVICE_ATTR_NAMED(accel_xayaz_mag_falling_en, + 
> in_accel_x&y&z_mag_falling_en, +			     S_IRUGO | S_IWUSR, + 
> mma8452_get_freefall_mode, +			     mma8452_set_freefall_mode, + 0);

This should be created by the core based on the event spec, shouldn't it?
