Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:54494 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbaHTI4Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Aug 2014 04:56:16 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so7552156wgh.22
        for <linux-iio@vger.kernel.org>; Wed, 20 Aug 2014 01:56:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1408488206-2633-6-git-send-email-pmeerw@pmeerw.net>
References: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net>
	<1408488206-2633-6-git-send-email-pmeerw@pmeerw.net>
Date: Wed, 20 Aug 2014 11:56:14 +0300
Message-ID: <CAEnQRZDOGWFXpQ2H-uU2CH_mG5PPzU+KTbBJOn72KvX5u9+Kvw@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] iio:bma180: Expose temperature channel
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 20, 2014 at 1:43 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> 8-bit signed; 0 LSB @ 24 °C, 0.5 °C per LSB
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> ---
>  drivers/iio/accel/bma180.c | 80 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 59 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index aa7566f..91260a0 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -29,6 +29,7 @@
>  /* Register set */
>  #define BMA180_CHIP_ID         0x00 /* Need to distinguish BMA180 from other */
>  #define BMA180_ACC_X_LSB       0x02 /* First of 6 registers of accel data */
> +#define BMA180_TEMP            0x08
>  #define BMA180_CTRL_REG0       0x0d
>  #define BMA180_RESET           0x10
>  #define BMA180_BW_TCS          0x20
> @@ -84,27 +85,37 @@ struct bma180_data {
>         char *buff;
>  };
>
> -enum bma180_axis {
> +enum bma180_chan {
>         AXIS_X,
>         AXIS_Y,
>         AXIS_Z,
> +       TEMP
>  };

Nit: For future patches, add a semicolon after TEMP.

Daniel.
