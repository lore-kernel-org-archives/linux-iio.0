Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49872 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbaLLSPl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 13:15:41 -0500
Message-ID: <548B30CB.7000909@kernel.org>
Date: Fri, 12 Dec 2014 18:15:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	kbuild test robot <fengguang.wu@intel.com>
CC: kbuild-all@01.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iio] iio: imu: kmx61: kmx61_set_wake_up_odr() can be static
References: <201412130004.58sFmPKu%fengguang.wu@intel.com>	<20141212162852.GA40238@snb.sh.intel.com> <CAEnQRZBc4=coYPy8-04oKB9OWCjD_CKovMYtmeV348-tLx2kpA@mail.gmail.com>
In-Reply-To: <CAEnQRZBc4=coYPy8-04oKB9OWCjD_CKovMYtmeV348-tLx2kpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/12/14 16:41, Daniel Baluta wrote:
> On Fri, Dec 12, 2014 at 6:28 PM, kbuild test robot
> <fengguang.wu@intel.com> wrote:
>> drivers/iio/imu/kmx61.c:422:5: sparse: symbol 'kmx61_set_wake_up_odr' was not declared. Should it be static?
>>
>> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git.

Thanks!

Jonathan
> 
>> ---
>>  kmx61.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
>> index bda9c40..9b32f01 100644
>> --- a/drivers/iio/imu/kmx61.c
>> +++ b/drivers/iio/imu/kmx61.c
>> @@ -419,7 +419,7 @@ static int kmx61_get_mode(struct kmx61_data *data, u8 *mode, u8 device)
>>         return 0;
>>  }
>>
>> -int kmx61_set_wake_up_odr(struct kmx61_data *data, int val, int val2)
>> +static int kmx61_set_wake_up_odr(struct kmx61_data *data, int val, int val2)
>>  {
>>         int ret, odr_bits;
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

