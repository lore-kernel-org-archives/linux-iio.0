Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30846 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbcCIKCT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 9 Mar 2016 05:02:19 -0500
Message-ID: <56DFF4D2.4000708@parrot.com>
Date: Wed, 9 Mar 2016 11:02:58 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: <linux-iio@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v5 1/1] Fixes: 3145229f9191 ("iio:pressure:ms5611: power
 regulator support")
References: <cover.1457459537.git.gregor.boirie@parrot.com>	<26a4b9ab8ae9b40f9c96c51f12c977fdad36532f.1457459537.git.gregor.boirie@parrot.com> <CAEnQRZBsQ4_XPBXfuWu4WL_qLG7fo3ynsWfQ51v=Ya2O6-jXyQ@mail.gmail.com>
In-Reply-To: <CAEnQRZBsQ4_XPBXfuWu4WL_qLG7fo3ynsWfQ51v=Ya2O6-jXyQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Daniel,

On 03/08/2016 10:16 PM, Daniel Baluta wrote:
> On Tue, Mar 8, 2016 at 8:00 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:
>> When not compiled-in, regulator layer will return a NULL pointer when
>> trying to get a reference to any regulator using devm_regulator_get().  As
>> IS_ERR() does not consider this an error, the ms5611 probing operation will
>> try to enable a NULL regulator, which will invariably cause a kernel
>> crash.
>> This patch fixes this situation by using devm_regulator_get_optional()
>> instead of devm_regulator_get().
>>
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> $Subject should be here. And the commit subject should be something
> more appropriate like:
>
> iio: pressure: ms5611: Fix crash when ...
I'm a bit lost here since when Jonathan asked for "a fixes tag" inclusion
(http://permalink.gmane.org/gmane.linux.kernel.iio/22425), I supposed he
meant a tag such as one described in the Documentation/SubmittingPatches
file.
My initial attempt was sent with the subject:
"iio:pressure:ms5611: fix oops when probing regulator".

Would you please be kind enough to give me some sort of rules as to when 
and how
to write subject lines related to fixes patch ?

Regards,
Grégor.

>
>
>> ---
>>   drivers/iio/pressure/ms5611_core.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
>> index 37dbc04..a2a871b 100644
>> --- a/drivers/iio/pressure/ms5611_core.c
>> +++ b/drivers/iio/pressure/ms5611_core.c
>> @@ -387,8 +387,8 @@ static const struct iio_info ms5611_info = {
>>   static int ms5611_init(struct iio_dev *indio_dev)
>>   {
>>          int ret;
>> -       struct regulator *vdd = devm_regulator_get(indio_dev->dev.parent,
>> -                                                  "vdd");
>> +       struct regulator *vdd =
>> +               devm_regulator_get_optional(indio_dev->dev.parent, "vdd");
>>
>>          /* Enable attached regulator if any. */
>>          if (!IS_ERR(vdd)) {
>> @@ -398,6 +398,10 @@ static int ms5611_init(struct iio_dev *indio_dev)
>>                                  "failed to enable Vdd supply: %d\n", ret);
>>                          return ret;
>>                  }
>> +       } else {
>> +               ret = PTR_ERR(vdd);
>> +               if (ret != -ENODEV)
>> +                       return ret;
>>          }
>>
>>          ret = ms5611_reset(indio_dev);
>> --
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

