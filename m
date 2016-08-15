Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41762 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbcHOQHB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 12:07:01 -0400
Subject: Re: [PATCH] tools: iio: iio_generic_buffer: initialize channel array
 pointer
To: Gregor Boirie <gregor.boirie@parrot.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160727031734.GA31933@d830.WORKGROUP>
 <57986CF3.4070602@parrot.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <413c3362-48d4-6ba4-9849-e82f69652ece@kernel.org>
Date: Mon, 15 Aug 2016 17:06:58 +0100
MIME-Version: 1.0
In-Reply-To: <57986CF3.4070602@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/16 09:12, Gregor Boirie wrote:
> 
> On 07/27/2016 05:17 AM, Alison Schofield wrote:
>> Uninitialized channel pointer causes segmentation fault when we
>> call free(channel) during cleanup() with no channels initialized.
>> This happens when you exit early for usage errors.  Initialize
>> the pointer to NULL when it is declared.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>> ---
>>   tools/iio/iio_generic_buffer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
>> index 0e8a1f7..ae68bf0 100644
>> --- a/tools/iio/iio_generic_buffer.c
>> +++ b/tools/iio/iio_generic_buffer.c
>> @@ -348,7 +348,7 @@ int main(int argc, char **argv)
>>       int notrigger = 0;
>>       char *dummy;
>>   -    struct iio_channel_info *channels;
>> +    struct iio_channel_info *channels = NULL;
>>         register_cleanup();
>>   
> Tested-by: Gregor Boirie <gregor.boirie@parrot.com>
I'm not marking this for stable purely because the huge about of
churn in those files makes it tricky to be sure when it first
broke or if it was always broken!

Anyhow, applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
> greg.
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

