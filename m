Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41778 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdCHJDo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Mar 2017 04:03:44 -0500
Subject: Re: [PATCH] iio: multiplexer: fix unsigned check with less than zero
To: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20170307150631.31043-1-colin.king@canonical.com>
 <910dd7ee-9b07-4e43-6ba3-cf5736c94348@axentia.se>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <687fdd3a-4e0d-1eda-e8fc-27173c611909@canonical.com>
Date: Wed, 8 Mar 2017 09:03:19 +0000
MIME-Version: 1.0
In-Reply-To: <910dd7ee-9b07-4e43-6ba3-cf5736c94348@axentia.se>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/03/17 08:59, Peter Rosin wrote:
> On 2017-03-07 16:06, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Comparing a size_t with less than zero is always false as size_t
>> is unsigned. The intent of the comparison was to check if the size
>> was -1 (that is, undefined), so use that instead.
>>
>> Detected by CoverityScan, CID#1415278 ("Unsigned compared against 0")
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Hi!
> 
> Oops, thanks for highlighting this! However, I think I prefer to instead
> change the type of the struct mux_ext_info_cache member 'size' to ssize_t.
> That way, there is no annoying explicit cast. And perhaps add an early
> check
> 
> 	if (len >= PAGE_SIZE)
> 		return -EINVAL;
> 
> to mux_write_ext_info (because the sysfs read function in use for iio ext
> info can't handle more than a page anyway, IIUC). That way it is fairly
> certain that the ssize_t type will always be big enough. :-)

Sounds like a far better solution.

> 
> So, I'm going send out a patch like that instead, unless someone happens to
> beat me to it...
> 
> Cheers,
> peda

Thanks,

Colin
> 
>> ---
>>  drivers/iio/multiplexer/iio-mux.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
>> index 94d40f9b..6c23033 100644
>> --- a/drivers/iio/multiplexer/iio-mux.c
>> +++ b/drivers/iio/multiplexer/iio-mux.c
>> @@ -61,7 +61,7 @@ static int iio_mux_select(struct mux *mux, int idx)
>>  
>>  			cache = &child->ext_info_cache[i];
>>  
>> -			if (cache->size < 0)
>> +			if (cache->size == (size_t)-1)
>>  				continue;
>>  
>>  			ret = iio_write_channel_ext_info(mux->parent, attr,
>>
> 

