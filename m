Return-Path: <SRS0=UE/p=6U=embeddedor.com=garsilva@kernel.org>
Subject: Re: [PATCH] iio: adc: meson-saradc: add NULL check on
 of_match_device() return value
To: Jonathan Cameron <jic23@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20170707064630.GA21945@embeddedgus>
 <CAFBinCBgXAFvLqXP5e-j=UeQVd+foUDqKUNzO8hwQ71tKga1Vg@mail.gmail.com>
 <20170709190843.0bfa292f@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Carlo Caione <carlo@caione.org>,
 Kevin Hilman <khilman@baylibre.com>, linux-iio@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <96a56ec0-898e-5339-a0aa-81c6f8e96d88@embeddedor.com>
Date: Sun, 16 Jul 2017 23:55:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170709190843.0bfa292f@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 07/09/2017 01:08 PM, Jonathan Cameron wrote:
> On Sat, 8 Jul 2017 15:42:46 +0200
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
>> On Fri, Jul 7, 2017 at 8:46 AM, Gustavo A. R. Silva
>> <garsilva@embeddedor.com> wrote:
>>> Check return value from call to of_match_device()
>>> in order to prevent a NULL pointer dereference.
>>>
>>> In case of NULL print error message and return -ENODEV
>>>
>>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> thanks for finding this. a crash here is a rather theoretical problem
>> (since all compatible strings have their corresponding match data) -
>> but it doesn't hurt either, so:
>>
>> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Applied.
>

Thank you, Jonathan.

> Jonathan
>>
>>
>>> ---
>>>  drivers/iio/adc/meson_saradc.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>>> index 83da50e..07dbcc3 100644
>>> --- a/drivers/iio/adc/meson_saradc.c
>>> +++ b/drivers/iio/adc/meson_saradc.c
>>> @@ -915,6 +915,11 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>>>         init_completion(&priv->done);
>>>
>>>         match = of_match_device(meson_sar_adc_of_match, &pdev->dev);
>>> +       if (!match) {
>>> +               dev_err(&pdev->dev, "failed to match device\n");
>>> +               return -ENODEV;
>>> +       }
>>> +
>>>         priv->data = match->data;
>>>
>>>         indio_dev->name = priv->data->name;
>>> --
>>> 2.5.0
>>>
>>>
>>> _______________________________________________
>>> linux-amlogic mailing list
>>> linux-amlogic@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Gustavo A. R. Silva
