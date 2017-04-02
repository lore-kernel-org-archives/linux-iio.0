Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47524 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdDBJVt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 05:21:49 -0400
Subject: Re: [PATCH] staging: iio: ad9832: use 4-digit octal permissions
To: Guru Das Srinagesh <gurooodas@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
References: <1490867739-12444-1-git-send-email-gurooodas@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c5c7f978-d9e1-d428-b47d-c93083df21ba@kernel.org>
Date: Sun, 2 Apr 2017 10:21:47 +0100
MIME-Version: 1.0
In-Reply-To: <1490867739-12444-1-git-send-email-gurooodas@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/03/17 10:55, Guru Das Srinagesh wrote:
> This fixes the coding style issue of using S_IWUSR in place of 4-digit
> octal numbers.
> 
> Issue detected by checkpatch.
> 
> Signed-off-by: Guru Das Srinagesh <gurooodas@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Most of these if not all should go away when this driver gets properly
cleaned up, but in the meantime I guess it's just about worth making this
change.

Jonathan
> ---
>  drivers/staging/iio/frequency/ad9832.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 425b8ab..6da46ed 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -250,22 +250,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>   * see dds.h for further information
>   */
>  
> -static IIO_DEV_ATTR_FREQ(0, 0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ0HM);
> -static IIO_DEV_ATTR_FREQ(0, 1, S_IWUSR, NULL, ad9832_write, AD9832_FREQ1HM);
> -static IIO_DEV_ATTR_FREQSYMBOL(0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ_SYM);
> +static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> +static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
>  static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
>  
> -static IIO_DEV_ATTR_PHASE(0, 0, S_IWUSR, NULL, ad9832_write, AD9832_PHASE0H);
> -static IIO_DEV_ATTR_PHASE(0, 1, S_IWUSR, NULL, ad9832_write, AD9832_PHASE1H);
> -static IIO_DEV_ATTR_PHASE(0, 2, S_IWUSR, NULL, ad9832_write, AD9832_PHASE2H);
> -static IIO_DEV_ATTR_PHASE(0, 3, S_IWUSR, NULL, ad9832_write, AD9832_PHASE3H);
> -static IIO_DEV_ATTR_PHASESYMBOL(0, S_IWUSR, NULL,
> +static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
> +static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
> +static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
> +static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
> +static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
>  				ad9832_write, AD9832_PHASE_SYM);
>  static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
>  
> -static IIO_DEV_ATTR_PINCONTROL_EN(0, S_IWUSR, NULL,
> +static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
>  				ad9832_write, AD9832_PINCTRL_EN);
> -static IIO_DEV_ATTR_OUT_ENABLE(0, S_IWUSR, NULL,
> +static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
>  				ad9832_write, AD9832_OUTPUT_EN);
>  
>  static struct attribute *ad9832_attributes[] = {
> 

