Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36481 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKAUI0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2015 15:08:26 -0500
Received: by ykba4 with SMTP id a4so121336857ykb.3
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2015 12:08:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56365728.9020304@kernel.org>
References: <1446382725-11765-1-git-send-email-ciorneiioana@gmail.com>
	<56365728.9020304@kernel.org>
Date: Sun, 1 Nov 2015 22:08:25 +0200
Message-ID: <CAHWJYF=W__yY5iOK7Y_=B_tU5GwV2uFyS4913btpLAjae=Cu9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: gyro: check sscanf return value
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	outreachy-kernel <outreachy-kernel@googlegroups.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Nov 1, 2015 at 8:17 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 01/11/15 12:58, Ioana Ciornei wrote:
>> This patch fixes the checkpatch warnings:
>> WARNING: unchecked sscanf return value
>>
>> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
> Hi Ioana,
>
> Couple of minor process points (the patches are fine!)
>
> You should have cc'd the driver author and generally also
> the various listed reviewers in MAINTAINERS.  In this case
> of of them is the driver author so possibly just pinging him
> is the way to go.  In the case of Analog devices parts,
> Lars-Peter is also the maintainer so it's all about as
> easy as it gets in this case.

Ok. From now on I will cc the maintainers and the reviewers.
Sorry for the trouble.

Ioana

>
> Lars, looks fine to me.  Your driver so please sanity check.
> Clearly it's not a bug as the inputs are entirely controlled
> by the driver code, but I think having a sanity check on
> the return value is a good thing (from the point of view of
> best practice).
>
> There is a second patch for some the IIO drivers that are your
> problem as well - I'll let you pull that off the list as I'm
> feeling lazy ;)
>
> I did have to check that sscanf never returns any more helpful
> error codes, but unlike the glibc one it seems not.  What fun.
>
> Jonathan
>> ---
>>
>> based on linux-iio/testing branch
>>
>>  drivers/iio/gyro/adis16136.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
>> index 26de876..bb09bff 100644
>> --- a/drivers/iio/gyro/adis16136.c
>> +++ b/drivers/iio/gyro/adis16136.c
>> @@ -435,7 +435,9 @@ static int adis16136_initial_setup(struct iio_dev *indio_dev)
>>       if (ret)
>>               return ret;
>>
>> -     sscanf(indio_dev->name, "adis%u\n", &device_id);
>> +     ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
>> +     if (ret != 1)
>> +             return -EINVAL;
>>
>>       if (prod_id != device_id)
>>               dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
>>
>



-- 
Ioana Ciornei
Facultatea de Automatica si Calculatoare, UPB
Tel. 0753 861 668
