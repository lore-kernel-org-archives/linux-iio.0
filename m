Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52090 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753190AbcHUPMR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 11:12:17 -0400
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: fix typo in val
 assignment
To: Matt Ranostay <mranostay@gmail.com>,
        Colin King <colin.king@canonical.com>
References: <1469484416-17305-1-git-send-email-colin.king@canonical.com>
 <CAKzfze97P6yJEMAeg6Wv5UMDV4iuqBSQOdeLjG1Ctf_xywQxSg@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ed277014-36e8-fc78-a7fb-1b52e258ef78@kernel.org>
Date: Sun, 21 Aug 2016 16:12:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze97P6yJEMAeg6Wv5UMDV4iuqBSQOdeLjG1Ctf_xywQxSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/16 10:28, Matt Ranostay wrote:
> On Mon, Jul 25, 2016 at 3:06 PM, Colin King <colin.king@canonical.com> wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Fix an incorrect assignment due to a typo on a variable name. The
>> variable val2 should be assigned 100000 and not val.
> 
> Yikes! Good catch..
> 
> Reviewed-By: Matt Ranostay <mranostay@gmail.com>
> 
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thanks Colin.

Applied to the fixes-togreg branch of iio.git. Should head upstream
in a day or two.

Jonathan
>> ---
>>  drivers/iio/chemical/atlas-ph-sensor.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
>> index ae038a5..407f141 100644
>> --- a/drivers/iio/chemical/atlas-ph-sensor.c
>> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
>> @@ -434,7 +434,7 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
>>                         break;
>>                 case IIO_ELECTRICALCONDUCTIVITY:
>>                         *val = 1; /* 0.00001 */
>> -                       *val = 100000;
>> +                       *val2 = 100000;
>>                         break;
>>                 case IIO_CONCENTRATION:
>>                         *val = 0; /* 0.000000001 */
>> --
>> 2.8.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

