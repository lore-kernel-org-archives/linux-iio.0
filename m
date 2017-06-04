Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33876 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdFDNdO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jun 2017 09:33:14 -0400
MIME-Version: 1.0
In-Reply-To: <20170603095257.2a4042bf@kernel.org>
References: <20170528112438.10427-1-paolocretaro@gmail.com>
 <20170528154309.243555e3@kernel.org> <CAFBinCC9OQ1P-0K5DZyiFrod97xEuhk__bCSbmvPciXB3KnBBg@mail.gmail.com>
 <20170603095257.2a4042bf@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 4 Jun 2017 15:32:52 +0200
Message-ID: <CAFBinCC+fThR+h5mif7SRC44orrD_QKUQ_fxWVM-w1UVj1Wmhw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: use NULL instead of 0 for pointer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Paolo Cretaro <paolocretaro@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Paolo, Hi Jonathan,

On Sat, Jun 3, 2017 at 10:52 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 28 May 2017 23:17:57 +0200
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
>> Hi Paolo, Hi Jonathan,
>>
>> On Sun, May 28, 2017 at 4:43 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> > On Sun, 28 May 2017 13:24:38 +0200
>> > Paolo Cretaro <paolocretaro@gmail.com> wrote:
>> >
>> >> Fix sparse warning: Using plain integer as NULL pointer
>> >>
>> >> Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
>> > This looks fine to me, but ideally you should always try to include
>> > the driver author - particularly in the case of patches to a recent
>> > driver such as this one.
>> >
>> > To that end I've cc'd Martin.
>> thanks for spotting this (and providing a patch to fix it)
>> this looks good to me, so:
>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> if you can wait until next weekend then I can also test this on real hardware.
> I've applied it to the togreg branch of iio.git but as that always goes out
> as testing for at least a few days first (which I will happily rebase) give
> me a shout if anything goes wrong!
I have tested this on actual hardware and it seems that there's a bug
in the meson-saradc driver (before and after this patch):
if there are still "old" values in the FIFO then the driver currently
crashes because regmap_read (regmap_mmio_read in case of the
meson-saradc driver to be precise) de-references the "value" pointer
(the parameter which we're trying to clean up here) -> this leads to a
NULL de-reference. this happens regardless of whether we are passing
"0" or "NULL"

I posted a patch which fixes the crash - and as a bonus this should
also fix the sparse warning reported by Paolo:
http://lists.infradead.org/pipermail/linux-amlogic/2017-June/003863.html

> Jonathan
>>
>> > Jonathan
>> >> ---
>> >>  drivers/iio/adc/meson_saradc.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> >> index 81cd39a57fe3..fb3f67a9ae1f 100644
>> >> --- a/drivers/iio/adc/meson_saradc.c
>> >> +++ b/drivers/iio/adc/meson_saradc.c
>> >> @@ -481,7 +481,7 @@ static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
>> >>               if (!meson_sar_adc_get_fifo_count(indio_dev))
>> >>                       break;
>> >>
>> >> -             regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
>> >> +             regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, NULL);
>> >>       }
>> >>  }
>> >>
>> >
>>
>> Regards,
>> Martin
>
