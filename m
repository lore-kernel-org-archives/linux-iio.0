Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56317 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab3IUKbp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:31:45 -0400
Message-ID: <523D83B3.1040406@kernel.org>
Date: Sat, 21 Sep 2013 12:32:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: Fix crash when scan_bytes is computed with active_scan_mask
 == NULL
References: <1379538649-9675-1-git-send-email-pmeerw@pmeerw.net> <1379538649-9675-2-git-send-email-pmeerw@pmeerw.net> <523A9E4D.9010208@metafoo.de>
In-Reply-To: <523A9E4D.9010208@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 07:48, Lars-Peter Clausen wrote:
> On 09/18/2013 11:10 PM, Peter Meerwald wrote:
>> if device has available_scan_masks set and the buffer is enabled without
>> any scan_elements enabled, in a NULL pointer is dereferenced in iio_compute_scan_bytes()
>>
>> [   18.993713] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> [   19.002593] pgd = debd4000
>> [   19.005432] [00000000] *pgd=9ebc0831, *pte=00000000, *ppte=00000000
>> [   19.012329] Internal error: Oops: 17 [#1] PREEMPT ARM
>> [   19.017639] Modules linked in:
>> [   19.020843] CPU: 0    Not tainted  (3.9.11-00036-g75c888a-dirty #207)
>> [   19.027587] PC is at _find_first_bit_le+0xc/0x2c
>> [   19.032440] LR is at iio_compute_scan_bytes+0x2c/0xf4
>> [   19.037719] pc : [<c021dc60>]    lr : [<c03198d0>]    psr: 200d0013
>> [   19.037719] sp : debd9ed0  ip : 00000000  fp : 000802bc
>> [   19.049713] r10: 00000000  r9 : 00000000  r8 : deb67250
>> [   19.055206] r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : deb67000
>> [   19.062011] r3 : de96ec00  r2 : 00000000  r1 : 00000004  r0 : 00000000
>> [   19.068847] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> [   19.076324] Control: 10c5387d  Table: 9ebd4019  DAC: 00000015
>>
>> problem is the rollback code in iio_update_buffers(), old_mask may be NULL (e.g. on first
>> call)
>>
>> I'm not too confident about the fix; works for me...
> 
> Looks good. We should probably try to restructure the function at some point as it is quite hard to follow as it is
> right now.
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> 
I've back ported this fix to the current fixes-togreg branch of iio.git and
applied.  It will cause some merge grief so I'll try and remember to warn
Greg about that.

I'll probably apply at least some of Lars' fixes there as well so there might be
quite a bit of merge grief unfortunately.

What fun :)

Thanks,

Jonathan
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> ---
>>   drivers/iio/industrialio-buffer.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index 2361fbc..d5754b8 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -522,8 +522,15 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>>                * Note can only occur when adding a buffer.
>>                */
>>               list_del_init(&insert_buffer->buffer_list);
>> -            indio_dev->active_scan_mask = old_mask;
>> -            success = -EINVAL;
>> +            if (old_mask) {
>> +                indio_dev->active_scan_mask = old_mask;
>> +                success = -EINVAL;
>> +            }
>> +            else {
>> +                kfree(compound_mask);
>> +                ret = -EINVAL;
>> +                goto error_ret;
>> +            }
>>           }
>>       } else {
>>           indio_dev->active_scan_mask = compound_mask;
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
