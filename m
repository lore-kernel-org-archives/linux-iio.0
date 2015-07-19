Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47645 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbbGSOCD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 10:02:03 -0400
Message-ID: <55ABADD9.4080308@kernel.org>
Date: Sun, 19 Jul 2015 15:02:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Cristina Opriceana <cristina.opriceana@gmail.com>
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
	octavian.purdila@intel.com
Subject: Re: [PATCH 2/3] tools: iio: Remove unnecessary braces
References: <cover.1436789446.git.cristina.opriceana@gmail.com> <45661e14b247cebfc130518e0c1c44fcec339f0d.1436789446.git.cristina.opriceana@gmail.com> <55A40800.1080805@gmx.de>
In-Reply-To: <55A40800.1080805@gmx.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/07/15 19:48, Hartmut Knaack wrote:
> Cristina Opriceana schrieb am 13.07.2015 um 15:17:
>> Single statement blocks don’t need braces.
>> Found with checkpatch.pl.
>>
>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
>> ---
> 
> Oops, that slipped through my hands. Thanks for taking care of this.
> 
>>  tools/iio/iio_event_monitor.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>> index 703f4cb..9ee1959 100644
>> --- a/tools/iio/iio_event_monitor.c
>> +++ b/tools/iio/iio_event_monitor.c
>> @@ -262,9 +262,8 @@ int main(int argc, char **argv)
>>  		printf("Found IIO device with name %s with device number %d\n",
>>  		       device_name, dev_num);
>>  		ret =sprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
>> -		if (ret < 0) {
>> +		if (ret < 0)
>>  			return -ENOMEM;
>> -		}
>>  	} else {
>>  		/*
>>  		 * If we can't find an IIO device by name assume device_name is
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

