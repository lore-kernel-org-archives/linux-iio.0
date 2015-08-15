Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47667 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbbHOPRM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 11:17:12 -0400
Subject: Re: [PATCH] iio: event_monitor: report unsupported events
To: Hartmut Knaack <knaack.h@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org
References: <1439296478-19567-1-git-send-email-linus.walleij@linaro.org>
 <55CA4302.8080609@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF57F7.3040108@kernel.org>
Date: Sat, 15 Aug 2015 16:17:11 +0100
MIME-Version: 1.0
In-Reply-To: <55CA4302.8080609@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/15 19:46, Hartmut Knaack wrote:
> Linus Walleij schrieb am 11.08.2015 um 14:34:
>> This makes the event monitor bail out with a helpful error
>> message if a device does not support events, as a related
>> fix to iio core now makes it return -ENODEV properly.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
>> ---
>>  tools/iio/iio_event_monitor.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>> index cd3fd41b481d..d51eb04202e9 100644
>> --- a/tools/iio/iio_event_monitor.c
>> +++ b/tools/iio/iio_event_monitor.c
>> @@ -284,7 +284,11 @@ int main(int argc, char **argv)
>>  	ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
>>  	if (ret == -1 || event_fd == -1) {
>>  		ret = -errno;
>> -		fprintf(stderr, "Failed to retrieve event fd\n");
>> +		if (ret == -ENODEV)
>> +			fprintf(stderr,
>> +				"This device does not support events\n");
>> +		else
>> +			fprintf(stderr, "Failed to retrieve event fd\n");
>>  		if (close(fd) == -1)
>>  			perror("Failed to close character device file");
>>  
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

