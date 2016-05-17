Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34737 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbcEQAiT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 May 2016 20:38:19 -0400
Received: by mail-yw0-f194.google.com with SMTP id i22so114104ywc.1
        for <linux-iio@vger.kernel.org>; Mon, 16 May 2016 17:38:19 -0700 (PDT)
MIME-Version: 1.0
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Mon, 16 May 2016 21:37:59 -0300
Message-ID: <CAKi4VALcCPONTWo8zZM2Vqku+-a-pcXQDFe0PWgqtWNiEFbZhQ@mail.gmail.com>
Subject: Scale and FS range information (was: Re: [PATCH v3] iio: adc:
 ti-ads1015: add support for ADS1115 part)
To: Matt Ranostay <matt.ranostay@intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Matt,

changing the subject to raise a question I remembered now that could
potentially be a problem in this driver, but isn't.

On Mon, May 16, 2016 at 2:18 AM, Matt Ranostay <matt.ranostay@intel.com> wrote:
> TI ADS1115 is a 16-bit resolution ADC that is register map
> compatible with the ADS1015 device.
>
> Cc: daniel.baluta@intel.com
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
> ---
>  Changes from v2:
>  * Add missing ads1115 data rate values
>  * Allow support defining data rates per chip
>
>  drivers/iio/adc/ti-ads1015.c | 124 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 109 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 73cbf0b..a835423 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -55,6 +55,11 @@
>  #define ADS1015_DEFAULT_DATA_RATE      4
>  #define ADS1015_DEFAULT_CHAN           0
>
> +enum {
> +       ADS1015,
> +       ADS1115,
> +};
> +
>  enum ads1015_channels {
>         ADS1015_AIN0_AIN1 = 0,
>         ADS1015_AIN0_AIN3,
> @@ -71,6 +76,10 @@ static const unsigned int ads1015_data_rate[] = {
>         128, 250, 490, 920, 1600, 2400, 3300, 3300
>  };
>
> +static const unsigned int ads1115_data_rate[] = {
> +       8, 16, 32, 64, 128, 250, 475, 860
> +};
> +
>  static const struct {
>         int scale;
>         int uscale;

I forgot to ask this some time ago. From the documentation for in_voltageY_raw:

Description:
                Raw (unscaled no bias removal etc.) voltage measurement from
                channel Y. In special cases where the channel does not
                correspond to externally available input one of the named
                versions may be used. The number must always be specified and
                unique to allow association with event codes. Units after
                application of scale and offset are millivolts.

So, taking the value and multiplying by scale.uscale gives us the
value in mV. However the main reason to change the scale is actually
to get the value you want within the FS range. It seems like IIO has
no information to export to tell about FS information?

In *this* case ADS1015 and ADS1115 do have the same FS, but they could
be completely different without the user ever knowing.



Lucas De Marchi
