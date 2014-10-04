Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57617 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaJDLM0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 07:12:26 -0400
Message-ID: <542FD618.9050800@kernel.org>
Date: Sat, 04 Oct 2014 12:12:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>,
	Robin van der Gracht <robin@protonic.nl>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: st_sensors: Fix buffer copy
References: <1411995607-22198-1-git-send-email-robin@protonic.nl> <542EA98A.4070906@st.com>
In-Reply-To: <542EA98A.4070906@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 14:50, Denis CIOCCA wrote:
> Acked-by: Denis Ciocca <denis.ciocca@st.com>
Applied to fixes-togreg branch of iio.git and marked for stable.

Note that given the timing this will probably not hit
mainline until after the coming merge window. Only
after that will it get picked up for stable.

Jonathan
> 
> Thanks!
> 
> Denis
> 
> On 09/29/14 15:00, Robin van der Gracht wrote:
>> Use byte_for_channel as iterator to properly initialize the buffer.
>>
>> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
>> ---
>>   drivers/iio/common/st_sensors/st_sensors_buffer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> index 1665c8e..e18bc67 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> @@ -71,7 +71,7 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>>   				goto st_sensors_free_memory;
>>   			}
>>   
>> -			for (i = 0; i < n * num_data_channels; i++) {
>> +			for (i = 0; i < n * byte_for_channel; i++) {
>>   				if (i < n)
>>   					buf[i] = rx_array[i];
>>   				else
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
