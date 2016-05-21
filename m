Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46468 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcEUQXa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 May 2016 12:23:30 -0400
Subject: Re: [PATCH] iio: humidity: hdc100x: correct humidity integration time
 mask
To: Matt Ranostay <mranostay@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160520170633.GA2629@d830.WORKGROUP>
 <CAKzfze8evJnbffJid1vqTjNoC=4t41XHsaG=F38hkxq_vRBO+g@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3b43c1f3-70cd-7317-0f16-5dfbb8037805@kernel.org>
Date: Sat, 21 May 2016 17:23:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze8evJnbffJid1vqTjNoC=4t41XHsaG=F38hkxq_vRBO+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/16 18:44, Matt Ranostay wrote:
> Reviewed-by: Matt Ranostay <mranostay@gmail.com>
> 
> On Fri, May 20, 2016 at 10:06 AM, Alison Schofield <amsfield22@gmail.com> wrote:
>> Apply the correct mask to enable all available humidity integration
>> times.  Currently, the driver defaults to 6500 and all is okay with that.
>> However, if 3850 is selected we get a stuck bit and can't change back
>> to 6500 or select 2500.  (Verified with HDC1008)
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
Applied to the fixes-togreg-post-rc1 branch of iio.git

Thanks,

Jonathan
>> ---
>>  drivers/iio/humidity/hdc100x.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
>> index fa47676..59aa1cb 100644
>> --- a/drivers/iio/humidity/hdc100x.c
>> +++ b/drivers/iio/humidity/hdc100x.c
>> @@ -55,7 +55,7 @@ static const struct {
>>         },
>>         { /* IIO_HUMIDITYRELATIVE channel */
>>                 .shift = 8,
>> -               .mask = 2,
>> +               .mask = 3,
> 
> Yikes that is embarrassing on my part! I guess our validation was only
> in the high resolution mode... good catch!
> 
>>         },
>>  };
>>
>> --
>> 2.1.4
>>

