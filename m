Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38239 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbbCLIQi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2015 04:16:38 -0400
Received: by widex7 with SMTP id ex7so44748157wid.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2015 01:16:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426091777-30592-1-git-send-email-daniel.baluta@intel.com>
References: <1426091777-30592-1-git-send-email-daniel.baluta@intel.com>
Date: Thu, 12 Mar 2015 10:16:37 +0200
Message-ID: <CAE1zot+us4bP2n1xQkFdAvJ3iAWwqTFgMK4SNZbmugPD_nB_Lg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: trigger: Use standard attr for sampling frequency
From: Octavian Purdila <octavian.purdila@intel.com>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 11, 2015 at 6:36 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>
> As written in Documentation/ABI/testing/sysfs-bus-iio the trigger
> attribute for sampling frequency should be sampling_frequency.
>
> Fix this for iio-trig-periodic-rtc module in order to prepare it
> for moving out of staging.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
> Jonathan, this module is very useful for devices that do not have
> an interrupt pin.
>
> We are working on drivers for such devices and would be very nice to
> move this driver in advance to the IIO non-staging location.
>
> What do you say?
>

Hmm, I wonder what are the advantages of using RTC timers. Couldn't we
use a regular kernel timer instead?


>  drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> index 89df1d3..f1cfe2d 100644
> --- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> +++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
> @@ -87,12 +87,12 @@ error_ret:
>         return ret;
>  }
>
> -static DEVICE_ATTR(frequency, S_IRUGO | S_IWUSR,
> +static DEVICE_ATTR(sampling_frequency, S_IRUGO | S_IWUSR,
>             iio_trig_periodic_read_freq,
>             iio_trig_periodic_write_freq);
>
>  static struct attribute *iio_trig_prtc_attrs[] = {
> -       &dev_attr_frequency.attr,
> +       &dev_attr_sampling_frequency.attr,
>         NULL,
>  };
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
