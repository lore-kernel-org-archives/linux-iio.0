Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48930 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbcDCJ50 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 05:57:26 -0400
Subject: Re: [PATCH] iio: st_magn: always define ST_MAGN_TRIGGER_SET_STATE
To: Denis Ciocca <denis.ciocca@st.com>, Arnd Bergmann <arnd@arndb.de>
References: <1459283273-1059478-1-git-send-email-arnd@arndb.de>
 <20160330063353.GA6253@beicxl1122>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Giuseppe BARBA <giuseppe.barba@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5700E902.5050705@kernel.org>
Date: Sun, 3 Apr 2016 10:57:22 +0100
MIME-Version: 1.0
In-Reply-To: <20160330063353.GA6253@beicxl1122>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/03/16 07:33, Denis Ciocca wrote:
> Hi Arnd,
> 
> yup, my fault. Thanks.
> 
> Acked-by: Denis Ciocca <denis.ciocca@st.com>
Applied to my fixes-togreg-post-rc1 branch and marked for stable.

Thanks,

Jonathan
> 
> 
> On |29 Mar 16 @ 22:27|, Arnd Bergmann wrote:
>> When CONFIG_IIO_TRIGGER is enabled but CONFIG_IIO_BUFFER is
>> not, we get a build error in the st_magn driver:
>>
>> drivers/iio/magnetometer/st_magn_core.c:573:23: error: 'ST_MAGN_TRIGGER_SET_STATE' undeclared here (not in a function)
>>   .set_trigger_state = ST_MAGN_TRIGGER_SET_STATE,
>>                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Apparently, this ST_MAGN_TRIGGER_SET_STATE macro was meant to
>> be set to NULL when the definition is not available because
>> st_magn_buffer.c is not compiled, but the alternative definition
>> was not included in the original patch. This adds it.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 74f5683f35fe ("iio: st_magn: Add irq trigger handling")
>> ---
>>  drivers/iio/magnetometer/st_magn.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
>> index 06a4d9c35581..9daca4681922 100644
>> --- a/drivers/iio/magnetometer/st_magn.h
>> +++ b/drivers/iio/magnetometer/st_magn.h
>> @@ -44,6 +44,7 @@ static inline int st_magn_allocate_ring(struct iio_dev *indio_dev)
>>  static inline void st_magn_deallocate_ring(struct iio_dev *indio_dev)
>>  {
>>  }
>> +#define ST_MAGN_TRIGGER_SET_STATE NULL
>>  #endif /* CONFIG_IIO_BUFFER */
>>  
>>  #endif /* ST_MAGN_H */
>> -- 
>> 2.7.0
>>

