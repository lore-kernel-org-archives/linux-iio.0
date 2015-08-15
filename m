Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47703 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbbHOPWm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 11:22:42 -0400
Subject: Re: [PATCH] iio: percolate error if event fd fails
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
References: <1439287000-31506-1-git-send-email-linus.walleij@linaro.org>
 <CAEnQRZCen5ewAnnuiTSwQ5Yynpx0=_xnb0EUFohqb+v9LhZjzA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF5940.9000607@kernel.org>
Date: Sat, 15 Aug 2015 16:22:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCen5ewAnnuiTSwQ5Yynpx0=_xnb0EUFohqb+v9LhZjzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/15 11:52, Daniel Baluta wrote:
> On Tue, Aug 11, 2015 at 12:56 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> This makes the error from iio_event_getfd() percolate up
>> to userspace properly so we can know for sure there is no
>> events on this device (-ENODEV returned). Before this patch
>> we would bail out looking for the unsupported evens on the
>> erroneous (negative) file descriptor.
> 
> Good catch. s/evens/events
> 
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git.   Initially pushed
out as testing.  I'm not sending this as a fix as the error
that resulted was downright missleading, but unlikely to
have caused any nasty crashes or similar.

If you think if should be going in faster/ for stable then
let me know.

Jonathan
> 
>> ---
>>  drivers/iio/industrialio-core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 3524b0de8721..9492aa443a26 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1130,6 +1130,8 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>
>>         if (cmd == IIO_GET_EVENT_FD_IOCTL) {
>>                 fd = iio_event_getfd(indio_dev);
>> +               if (fd < 0)
>> +                       return fd;
>>                 if (copy_to_user(ip, &fd, sizeof(fd)))
>>                         return -EFAULT;
>>                 return 0;
>> --
>> 2.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

