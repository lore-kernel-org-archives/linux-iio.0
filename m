Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36282 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753765AbdEOM3I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 May 2017 08:29:08 -0400
Received: by mail-it0-f65.google.com with SMTP id z15so10233935ite.3
        for <linux-iio@vger.kernel.org>; Mon, 15 May 2017 05:29:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC70AB@WILL-MAIL002.REu.RohmEu.com>
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <CAEnQRZA=YwX4jP95JutzDkPmtTVCR4vbiYrQRr3aBRMpvT1+5w@mail.gmail.com> <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC70AB@WILL-MAIL002.REu.RohmEu.com>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Mon, 15 May 2017 15:29:06 +0300
Message-ID: <CAEnQRZBEOipt-JSET2_qz47W8_FAHTiFg3O_jw1Th5Lp6HYzTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] iio: light: rpr0521 disable sensor -bugfix
To: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 15, 2017 at 1:25 PM, Koivunen, Mikko
<Mikko.Koivunen@fi.rohmeurope.com> wrote:
> On 5.5.2017 14:24, Daniel Baluta wrote:
>> On Fri, May 5, 2017 at 2:19 PM, Mikko Koivunen
>> <mikko.koivunen@fi.rohmeurope.com> wrote:
>>> Sensor was marked enabled on each call even if the call was for disabling
>>> sensor.
>>>
>>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
>>> ---
>>> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
>>> Patch v2->v3 changes:
>>> whitespace change.
>>>
>>>  drivers/iio/light/rpr0521.c |   10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
>>> index 7de0f39..03504f6 100644
>>> --- a/drivers/iio/light/rpr0521.c
>>> +++ b/drivers/iio/light/rpr0521.c
>>> @@ -197,7 +197,10 @@ static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
>>>         if (ret < 0)
>>>                 return ret;
>>>
>>> -       data->als_dev_en = true;
>> How about:
>>
>> data->als_dev_en = !!(status & RPR0521_MODE_ALS_MASK);
>>
>> Thanks for fixing this!
>>
> I got the impression previously that we should prefer verbosity instead
> of shortness when it helps understanding the code. Otherwise yes, that
> could work too.

It depends on the mood :). But you are right, lets go with your variant.

Daniel.
