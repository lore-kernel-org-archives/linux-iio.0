Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-251.synserver.de ([212.40.185.251]:1421 "EHLO
	smtp-out-227.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756789AbcA3PG6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2016 10:06:58 -0500
Subject: Re: [PATCH] staging: iio: ad5933: avoid uninitialized variable in
 error case
To: Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
References: <1453737099-1959671-1-git-send-email-arnd@arndb.de>
 <56ACC622.8000908@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56ACD18C.6000601@metafoo.de>
Date: Sat, 30 Jan 2016 16:06:52 +0100
MIME-Version: 1.0
In-Reply-To: <56ACC622.8000908@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/30/2016 03:18 PM, Jonathan Cameron wrote:
> On 25/01/16 15:50, Arnd Bergmann wrote:
>> The ad5933_i2c_read function returns an error code to indicate
>> whether it could read data or not. However ad5933_work() ignores
>> this return code and just accesses the data unconditionally,
>> which gets detected by gcc as a possible bug:
>>
>> drivers/staging/iio/impedance-analyzer/ad5933.c: In function 'ad5933_work':
>> drivers/staging/iio/impedance-analyzer/ad5933.c:649:16: warning: 'status' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>
>> This adds minimal error handling so we only evaluate the
>> data if it was correctly read.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Hi Arnd,
> 
> Thanks for the patch.   The handling in here is a little fiddly
> by the look of things. Lars can you take a look at this when
> you have a minute?
> 
> At a very high level, it doesn't make sense to fix this instance and
> not the one in the context of the patch below.
> See below...
>> ---
>>  drivers/staging/iio/impedance-analyzer/ad5933.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
>> index 10c43dda0f5a..304bb464e478 100644
>> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
>> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
>> @@ -647,6 +647,7 @@ static void ad5933_work(struct work_struct *work)
>>  	__be16 buf[2];
>>  	int val[2];
>>  	unsigned char status;
>> +	int ret;
>>  
>>  	mutex_lock(&indio_dev->mlock);
>>  	if (st->state == AD5933_CTRL_INIT_START_FREQ) {
>> @@ -658,9 +659,9 @@ static void ad5933_work(struct work_struct *work)
>>  		return;
>>  	}
>>  
>> -	ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status);
>> +	ret = ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status);
>>  
>> -	if (status & AD5933_STAT_DATA_VALID) {
>> +	if (!ret && (status & AD5933_STAT_DATA_VALID)) {
> The else is non trivial here as it assumes we will get the data later. If we
> get such a failure, we probably want to drop out completely rather than paper
> over the gaps..

I agree. Although we could argue that Arnd's approach allows to recover from
temporary failure. But then again we don't want to keep polling forever if
it's a permanent failure. I'd say the best thing for a quick fix is to just
error out and assume the error is permanent.

>>  		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
>>  					       indio_dev->masklength);
> Same issue on the next line - this results in known garbage data being spooled
> out.

Also agreed.

