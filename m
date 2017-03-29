Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:37724 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdC2MxR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 08:53:17 -0400
Subject: Re: [Outreachy kernel] [PATCH 4/4] iio: light: si1145: Replace
 ternary operator with min macro
To: Julia Lawall <julia.lawall@lip6.fr>,
        simran singhal <singhalsimran0@gmail.com>
References: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
 <1490790791-5694-5-git-send-email-singhalsimran0@gmail.com>
 <alpine.DEB.2.20.1703291440070.2989@hadrien>
Cc: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <bd1805f2-4c8b-f51a-89fc-87d719f20ed6@metafoo.de>
Date: Wed, 29 Mar 2017 14:53:08 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703291440070.2989@hadrien>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/29/2017 02:40 PM, Julia Lawall wrote:
> 
> 
> On Wed, 29 Mar 2017, simran singhal wrote:
> 
>> Use macro min() to get the minimum of two values for brevity and
>> readability.
>>
>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
>> ---
>>  drivers/iio/light/si1145.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
>> index 096034c..e7ad6fb 100644
>> --- a/drivers/iio/light/si1145.c
>> +++ b/drivers/iio/light/si1145.c
>> @@ -557,7 +557,7 @@ static int si1145_set_chlist(struct iio_dev *indio_dev, unsigned long scan_mask)
>>  	data->scan_mask = scan_mask;
>>  	ret = si1145_param_set(data, SI1145_PARAM_CHLIST, reg);
>>
>> -	return ret < 0 ? ret : 0;
>> +	return min(ret, 0);
> 
> A similar change involving max was already rejected.  ret < 0 is a
> standard way of detecting an error, so perhaps leaving that explicitly
> present will be preferred.

I think a more sensible thing to do here is to check whether ret/err can
actually take any positive values and if not, replace the whole thing with
just 'return ret;' or 'return some_fn()'. I'd expect that his can be done in
most of the cases.

