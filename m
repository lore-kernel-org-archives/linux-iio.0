Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41050 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbEGJSb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 05:18:31 -0400
Message-ID: <554B2DE4.2030207@kernel.org>
Date: Thu, 07 May 2015 10:18:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Fabio Estevam <festevam@gmail.com>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ldv-project@linuxtesting.org
Subject: Re: [PATCH] iio: hid-sensors: Fix memory leak on failure path in
 hid_prox_probe()
References: <1430948924-4756-1-git-send-email-khoroshilov@ispras.ru>	<CAOMZO5AC=SUdXh6+np_2c3vqaKjpk-rZcR_baJ3-e+qt=dxx9w@mail.gmail.com> <CAEnQRZB9702wokxfMM4Yq=qsQJ8OEs5adtupd5uRw+WU2ifiBQ@mail.gmail.com>
In-Reply-To: <CAEnQRZB9702wokxfMM4Yq=qsQJ8OEs5adtupd5uRw+WU2ifiBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/15 08:43, Daniel Baluta wrote:
> On Thu, May 7, 2015 at 1:00 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Wed, May 6, 2015 at 6:48 PM, Alexey Khoroshilov
>> <khoroshilov@ispras.ru> wrote:
>>> If prox_parse_report() fails, memory allocated for channels is not
>>> deallocated, since it is still in local variable channels
>>> while kfree() is called with indio_dev->channels.
>>>
>>> Found by Linux Driver Verification project (linuxtesting.org).
>>>
>>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>>> ---
>>>  drivers/iio/light/hid-sensor-prox.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
>>> index 91ecc46ffeaa..d0d188108a11 100644
>>> --- a/drivers/iio/light/hid-sensor-prox.c
>>> +++ b/drivers/iio/light/hid-sensor-prox.c
>>> @@ -281,8 +281,9 @@ static int hid_prox_probe(struct platform_device *pdev)
>>>         ret = prox_parse_report(pdev, hsdev, channels,
>>>                                 HID_USAGE_SENSOR_PROX, prox_state);
>>>         if (ret) {
>>> +               kfree(channels);
>>>                 dev_err(&pdev->dev, "failed to setup attributes\n");
>>> -               goto error_free_dev_mem;
>>> +               return ret;
>>
>> Then the other calls to error_free_dev_mem will also miss to call
>> 'kfree(channels)'.
>>
>> What about this fix instead?
>>
>> --- a/drivers/iio/light/hid-sensor-prox.c
>> +++ b/drivers/iio/light/hid-sensor-prox.c
>> @@ -332,7 +332,7 @@ error_remove_trigger:
>>  error_unreg_buffer_funcs:
>>         iio_triggered_buffer_cleanup(indio_dev);
>>  error_free_dev_mem:
>> -       kfree(indio_dev->channels);
>> +       kfree(channels);
>>         return ret;
>>  }
> 
> Both patches are correct and I think we should go
> with Fabio's version since it's consistent with the
> rest of the code.
> 
> thanks,
> Daniel.
> 
Agreed. I'm travelling (again, yawn) for the next few days
but Fabio, could you send a formal version of your patch
with signoffs etc and a reported by for Alexey (or under
the circumstances Alexey, feel free to sign off on it
as well).

Thanks,

Jonathan
