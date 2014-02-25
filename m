Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48595 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbaBYUtO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2014 15:49:14 -0500
Message-ID: <530D01F3.1020209@kernel.org>
Date: Tue, 25 Feb 2014 20:49:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Dan Carpenter <dan.carpenter@oracle.com>
CC: linux-iio@vger.kernel.org
Subject: Re: iio:magnetometer:mag3110: Scale factor missing for temperature
References: <20140224220419.GC29170@elgon.mountain> <alpine.DEB.2.01.1402252053550.30927@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1402252053550.30927@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/02/14 20:00, Peter Meerwald wrote:
>
>> The patch f9279d3a8cc8: "iio:magnetometer:mag3110: Scale factor
>> missing for temperature" from Oct 1, 2014, leads to the following
>>                                ^^^^^^^^^^^
>> [ just the other day people were searching the internet for time
>>    travellers from the future ].
>
> this is indeed weird
Quite.  The interesting question is how did the date format get messed up.
>
>> 	drivers/iio/magnetometer/mag3110.c:197 mag3110_read_raw()
>> 	info: ignoring unreachable code.
>>
>> drivers/iio/magnetometer/mag3110.c
>>     185          case IIO_CHAN_INFO_SCALE:
>>     186                  switch (chan->type) {
>>     187                  case IIO_MAGN:
>>     188                          *val = 0;
>>     189                          *val2 = 1000;
>>     190                          return IIO_VAL_INT_PLUS_MICRO;
>>     191                  case IIO_TEMP:
>>     192                          *val = 1000;
>>     193                          return IIO_VAL_INT;
>>     194                  default:
>>     195                          return -EINVAL;
>>     196                  }
>>     197                  return IIO_VAL_INT_PLUS_MICRO;
>>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> Was -EINVAL intended here?
>
> no, this is dead code as the checker indicated
>
> thanks for reporting, sent fix to linux-iio
>
> p.
>

