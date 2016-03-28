Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44275 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbcC1JKj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 05:10:39 -0400
Subject: Re: [PATCH] iio: health: max30100: correct FIFO check condition
To: Matt Ranostay <mranostay@gmail.com>
References: <1458272888-26146-1-git-send-email-mranostay@gmail.com>
 <1458272888-26146-2-git-send-email-mranostay@gmail.com>
 <CAKzfze9pQwB0F2P+76gtn26ULMo4UDSyA9e-g+YTP7J5eF9LeQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	David Binderman <dcb314@hotmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8F50C.4060008@kernel.org>
Date: Mon, 28 Mar 2016 10:10:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze9pQwB0F2P+76gtn26ULMo4UDSyA9e-g+YTP7J5eF9LeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/03/16 03:42, Matt Ranostay wrote:
> This get lost in the inbox? :)
> Same fix as for APDS9660 issue in the FIFO
> 
> On Thu, Mar 17, 2016 at 8:48 PM, Matt Ranostay <mranostay@gmail.com> wrote:
>> Correct issue that the last entry in FIFO was being read twice due
>> to an incorrect decrement of entry count variable before condition
>> check.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Odd - disappeared without trace.  Well spotted.

Applied to the fixes-togreg-post-rc1 branch of iio.git

Thanks,

Jonathan
>> ---
>>  drivers/iio/health/max30100.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
>> index 09db893..90ab8a2d 100644
>> --- a/drivers/iio/health/max30100.c
>> +++ b/drivers/iio/health/max30100.c
>> @@ -238,12 +238,13 @@ static irqreturn_t max30100_interrupt_handler(int irq, void *private)
>>
>>         mutex_lock(&data->lock);
>>
>> -       while (cnt-- || (cnt = max30100_fifo_count(data) > 0)) {
>> +       while (cnt || (cnt = max30100_fifo_count(data) > 0)) {
>>                 ret = max30100_read_measurement(data);
>>                 if (ret)
>>                         break;
>>
>>                 iio_push_to_buffers(data->indio_dev, data->buffer);
>> +               cnt--;
>>         }
>>
>>         mutex_unlock(&data->lock);
>> --
>> 2.7.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

