Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:55228 "EHLO
	ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0FGIrd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2010 04:47:33 -0400
Message-ID: <4C0CB21D.4090204@cam.ac.uk>
Date: Mon, 07 Jun 2010 09:47:25 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: gregkh@suse.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: fix typo
References: <1275878775-25681-1-git-send-email-21cnbao@gmail.com> <AANLkTinSUT6bxMPlfCKLJ4KoeFKgsvjM2o316VzBsFzy@mail.gmail.com>
In-Reply-To: <AANLkTinSUT6bxMPlfCKLJ4KoeFKgsvjM2o316VzBsFzy@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/10 07:12, Barry Song wrote:
> Sorry, pls ignore this patch because it will destory compiling.
> I just want to know why the api is called bps, but the function is called bpd.
> -barry
Not sure. You are right that there is indeed a naming issue here.
I think I went from referring to a set of channels at one time instant
as a 'datum' to a 'scan' as it isn't instantaneous (or even close to
it) for many ADCs. This was some time ago and I clearly failed to clean
up all the way through! If people are happy with the 'scan' naming
then lets go the other way (it also doesn't change userspace abi
which we should start to try keeping fixed).  Hence remove bpd from the
subsystem.  Having said it would be nice to keep the abi the same this
particular attribute is a bit opaque. Perhaps we should loose the acronym
and go with bytes_per_scan as the attribute name?
> 
> On Mon, Jun 7, 2010 at 10:46 AM, Barry Song <21cnbao@gmail.com> wrote:
>>
>> Signed-off-by: Barry Song <21cnbao@gmail.com>
>> ---
>>  drivers/staging/iio/industrialio-ring.c |    4 ++--
>>  drivers/staging/iio/ring_generic.h      |    2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
>> index ada159b..ac56d9e 100644
>> --- a/drivers/staging/iio/industrialio-ring.c
>> +++ b/drivers/staging/iio/industrialio-ring.c
>> @@ -340,7 +340,7 @@ EXPORT_SYMBOL(iio_read_ring_length);
>>  }
>>  EXPORT_SYMBOL(iio_write_ring_length);
>>
>> -ssize_t iio_read_ring_bps(struct device *dev,
>> +ssize_t iio_read_ring_bpd(struct device *dev,
>>                          struct device_attribute *attr,
>>                          char *buf)
>>  {
>> @@ -353,7 +353,7 @@ ssize_t iio_read_ring_bps(struct device *dev,
>>
>>        return len;
>>  }
>> -EXPORT_SYMBOL(iio_read_ring_bps);
>> +EXPORT_SYMBOL(iio_read_ring_bpd);
>>
>>  ssize_t iio_store_ring_enable(struct device *dev,
>>                              struct device_attribute *attr,
>> diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
>> index 0e44375..1b22bdb 100644
>> --- a/drivers/staging/iio/ring_generic.h
>> +++ b/drivers/staging/iio/ring_generic.h
>> @@ -269,7 +269,7 @@ ssize_t iio_write_ring_length(struct device *dev,
>>                              struct device_attribute *attr,
>>                              const char *buf,
>>                              size_t len);
>> -ssize_t iio_read_ring_bps(struct device *dev,
>> +ssize_t iio_read_ring_bpd(struct device *dev,
>>                          struct device_attribute *attr,
>>                          char *buf);
>>  ssize_t iio_store_ring_enable(struct device *dev,
>> --
>> 1.5.6.3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

