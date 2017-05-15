Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36716 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdEOE2Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 May 2017 00:28:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAAGUq_qi8GW4LVmTtU=1uZFTJvtjc-9RMP3AXbZYb9FcZZ2hDg@mail.gmail.com>
References: <1494623944-7174-1-git-send-email-harinath922@gmail.com>
 <bcf17863-87f3-2ba8-e7c9-768161a8c94a@kernel.org> <CAAGUq_qi8GW4LVmTtU=1uZFTJvtjc-9RMP3AXbZYb9FcZZ2hDg@mail.gmail.com>
From: harinath Nampally <harinath922@gmail.com>
Date: Mon, 15 May 2017 00:27:44 -0400
Message-ID: <CAAGUq_qL3YCrqh3amXqgOBsGk7X6y-ZGRLx5gStB2rcA2gFJjg@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: meter: Replace symbolic permissions with
 octal permissions
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan,

Thank you for letting me know about correct iio git tree.

I checked out 'togreg' branch, and noticed that
latest ade7758_core.c still has checkpatch.pl warnings.

Actually Quentin Swain fixed the similar warnings in the ade7854.c,
and my patch is fix for similar warnings but it is for different file
ade7758_core.c

Please refer to below link for Quentin Swain's patch.
https://www.spinics.net/lists/linux-iio/msg33010.html

Please let me know if I am wrong.

Thanks,
Harinath

On Mon, May 15, 2017 at 12:22 AM, harinath Nampally
<harinath922@gmail.com> wrote:
> Jonathan,
>
> Thank you for letting me know about correct iio git tree.
>
> I checked out 'togreg' branch, and noticed that
> latest ade7758_core.c still has checkpatch.pl warnings.
>
> Actually Quentin Swain fixed the similar warnings in the ade7854.c,
> and my patch is fix for similar warnings but it is for different file
> ade7758_core.c
>
> Please refer to below link for Quentin Swain's patch.
> https://www.spinics.net/lists/linux-iio/msg33010.html
>
> Please let me know if I am wrong.
>
> Thanks,
> Harinath
>
> On Sun, May 14, 2017 at 10:41 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On 12/05/17 22:19, Harinath Nampally wrote:
>>>
>>> This patch fixes below kind of warnings:
>>> WARNING: Symbolic permissions 'S_IXXX | S_IXXX' are not preferred.
>>>
>>> Issue found and fixed by checkpatch.pl
>>>
>>> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>>
>> Already done by Quentin Swain <dudebrobro179@gmail.com> last month...
>>
>> For IIO related patches, stuff gets queued up in iio.git on
>> kernel.org before it gets sent on to Greg.  This is relatively
>> unusual for staging, but does lead to lots of repeats of
>> patches like this unfortunately.
>>
>> Jonathan
>>
>>> ---
>>>   drivers/staging/iio/meter/ade7758_core.c | 50
>>> ++++++++++++++++----------------
>>>   1 file changed, 25 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/meter/ade7758_core.c
>>> b/drivers/staging/iio/meter/ade7758_core.c
>>> index 99c89e6..40498af 100644
>>> --- a/drivers/staging/iio/meter/ade7758_core.c
>>> +++ b/drivers/staging/iio/meter/ade7758_core.c
>>> @@ -301,103 +301,103 @@ static int ade7758_reset(struct device *dev)
>>>         return ret;
>>>   }
>>>   -static IIO_DEV_ATTR_VPEAK(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_VPEAK(0644,
>>>                 ade7758_read_8bit,
>>>                 ade7758_write_8bit,
>>>                 ADE7758_VPEAK);
>>> -static IIO_DEV_ATTR_IPEAK(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_IPEAK(0644,
>>>                 ade7758_read_8bit,
>>>                 ade7758_write_8bit,
>>>                 ADE7758_VPEAK);
>>> -static IIO_DEV_ATTR_APHCAL(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_APHCAL(0644,
>>>                 ade7758_read_8bit,
>>>                 ade7758_write_8bit,
>>>                 ADE7758_APHCAL);
>>> -static IIO_DEV_ATTR_BPHCAL(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_BPHCAL(0644,
>>>                 ade7758_read_8bit,
>>>                 ade7758_write_8bit,
>>>                 ADE7758_BPHCAL);
>>> -static IIO_DEV_ATTR_CPHCAL(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_CPHCAL(0644,
>>>                 ade7758_read_8bit,
>>>                 ade7758_write_8bit,
>>>                 ADE7758_CPHCAL);
>>> -static IIO_DEV_ATTR_WDIV(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_WDIV(0644,
>>>                 ade7758_read_8bit,
>>>                 ade7758_write_8bit,
>>>                 ADE7758_WDIV);
>>> -static IIO_DEV_ATTR_VADIV(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_VADIV(0644,
>>>                 ade7758_read_8bit,
>>>                 ade7758_write_8bit,
>>>                 ADE7758_VADIV);
>>> -static IIO_DEV_ATTR_AIRMS(S_IRUGO,
>>> +static IIO_DEV_ATTR_AIRMS(0444,
>>>                 ade7758_read_24bit,
>>>                 NULL,
>>>                 ADE7758_AIRMS);
>>> -static IIO_DEV_ATTR_BIRMS(S_IRUGO,
>>> +static IIO_DEV_ATTR_BIRMS(0444,
>>>                 ade7758_read_24bit,
>>>                 NULL,
>>>                 ADE7758_BIRMS);
>>> -static IIO_DEV_ATTR_CIRMS(S_IRUGO,
>>> +static IIO_DEV_ATTR_CIRMS(0444,
>>>                 ade7758_read_24bit,
>>>                 NULL,
>>>                 ADE7758_CIRMS);
>>> -static IIO_DEV_ATTR_AVRMS(S_IRUGO,
>>> +static IIO_DEV_ATTR_AVRMS(0444,
>>>                 ade7758_read_24bit,
>>>                 NULL,
>>>                 ADE7758_AVRMS);
>>> -static IIO_DEV_ATTR_BVRMS(S_IRUGO,
>>> +static IIO_DEV_ATTR_BVRMS(0444,
>>>                 ade7758_read_24bit,
>>>                 NULL,
>>>                 ADE7758_BVRMS);
>>> -static IIO_DEV_ATTR_CVRMS(S_IRUGO,
>>> +static IIO_DEV_ATTR_CVRMS(0444,
>>>                 ade7758_read_24bit,
>>>                 NULL,
>>>                 ADE7758_CVRMS);
>>> -static IIO_DEV_ATTR_AIRMSOS(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_AIRMSOS(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_AIRMSOS);
>>> -static IIO_DEV_ATTR_BIRMSOS(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_BIRMSOS(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_BIRMSOS);
>>> -static IIO_DEV_ATTR_CIRMSOS(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_CIRMSOS(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_CIRMSOS);
>>> -static IIO_DEV_ATTR_AVRMSOS(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_AVRMSOS(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_AVRMSOS);
>>> -static IIO_DEV_ATTR_BVRMSOS(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_BVRMSOS(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_BVRMSOS);
>>> -static IIO_DEV_ATTR_CVRMSOS(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_CVRMSOS(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_CVRMSOS);
>>> -static IIO_DEV_ATTR_AIGAIN(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_AIGAIN(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_AIGAIN);
>>> -static IIO_DEV_ATTR_BIGAIN(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_BIGAIN(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_BIGAIN);
>>> -static IIO_DEV_ATTR_CIGAIN(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_CIGAIN(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_CIGAIN);
>>> -static IIO_DEV_ATTR_AVRMSGAIN(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_AVRMSGAIN(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_AVRMSGAIN);
>>> -static IIO_DEV_ATTR_BVRMSGAIN(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_BVRMSGAIN(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_BVRMSGAIN);
>>> -static IIO_DEV_ATTR_CVRMSGAIN(S_IWUSR | S_IRUGO,
>>> +static IIO_DEV_ATTR_CVRMSGAIN(0644,
>>>                 ade7758_read_16bit,
>>>                 ade7758_write_16bit,
>>>                 ADE7758_CVRMSGAIN);
>>>
>>
>
>
>
> --
> Thanks,
> Harinath
> +1 312 560 8565
>
>



-- 
Thanks,
Harinath
+1 312 560 8565
