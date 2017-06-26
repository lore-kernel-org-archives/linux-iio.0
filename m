Return-Path: <martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <7D7489FD-BA5C-4AA0-B490-8EDA86ADC339@jic23.retrosnub.co.uk>
References: <14984537865458@kroah.com> <CAFBinCDOSaHF9GwGhMUpZjR7AUVWVwk7EJmHWt0q8bkChBhMZA@mail.gmail.com>
 <7D7489FD-BA5C-4AA0-B490-8EDA86ADC339@jic23.retrosnub.co.uk>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 26 Jun 2017 23:03:16 +0200
Message-ID: <CAFBinCBzh_EsvjQk+wtbwkvA6+pgnkhCjWfcftf7dxqL-Bcf7w@mail.gmail.com>
Subject: Re: patch "iio: adc: meson-saradc: use NULL instead of 0 for pointer"
 added to staging-testing
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, paolocretaro@gmail.com,
	linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 26, 2017 at 9:30 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 26 June 2017 19:57:18 BST, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>>Hi Greg, Hi Jonathan,
>>
>>On Mon, Jun 26, 2017 at 7:09 AM,  <gregkh@linuxfoundation.org> wrote:
>>>
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     iio: adc: meson-saradc: use NULL instead of 0 for pointer
>>>
>>> to my staging git tree which can be found at
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
>>> in the staging-testing branch.
>>>
>>> The patch will show up in the next release of the linux-next tree
>>> (usually sometime within the next 24 hours during the week.)
>>>
>>> The patch will be merged to the staging-next branch sometime soon,
>>> after it passes testing, and the merge window is open.
>>>
>>> If you have any questions about this process, please let me know.
>>is there a way to drop below patch from your repo?
>>during testing I found out that the code before and after this patch
>>leads to a NULL deref. I provided a fix (see [0]) which solves the
>>crash and the warning as reported by Paolo - and that fix is already
>>part of v4.12-rc6
>>so the patch below will cause a merge conflict
>
> Sorry my mess up. Will probably fall out in the wash or Greg could revert.  Will have to check
>  the merge resolution in Linux next and when Linus pulls if it isn't reverted.  Should be fine
>  either way.
OK, I will re-check this once the everything has landed in Linus' tree
actually it's me who made the mess (by implementing broken stuff in
the first place) - but it will all be fine!

> Jonathan
>>
>>> From 6b503b216d1eff4d61a0bc34e09d1fd4d6e0ee79 Mon Sep 17 00:00:00
>>2001
>>> From: Paolo Cretaro <paolocretaro@gmail.com>
>>> Date: Sun, 28 May 2017 13:24:38 +0200
>>> Subject: iio: adc: meson-saradc: use NULL instead of 0 for pointer
>>>
>>> Fix sparse warning: Using plain integer as NULL pointer
>>>
>>> Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
>>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>>> ---
>>>  drivers/iio/adc/meson_saradc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/adc/meson_saradc.c
>>b/drivers/iio/adc/meson_saradc.c
>>> index 81cd39a57fe3..fb3f67a9ae1f 100644
>>> --- a/drivers/iio/adc/meson_saradc.c
>>> +++ b/drivers/iio/adc/meson_saradc.c
>>> @@ -481,7 +481,7 @@ static void meson_sar_adc_clear_fifo(struct
>>iio_dev *indio_dev)
>>>                 if (!meson_sar_adc_get_fifo_count(indio_dev))
>>>                         break;
>>>
>>> -               regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
>>> +               regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD,
>>NULL);
>>>         }
>>>  }
>>>
>>> --
>>> 2.13.1
>>>
>>>
>>
>>Regards,
>>Martin
>>
>>[0]
>>http://lists.infradead.org/pipermail/linux-amlogic/2017-June/003863.html
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
