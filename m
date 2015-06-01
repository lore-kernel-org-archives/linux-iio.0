Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:65516 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbbFAWAa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 1 Jun 2015 18:00:30 -0400
Message-ID: <556CD5F3.6040900@gmx.de>
Date: Tue, 02 Jun 2015 00:00:19 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 20/32] tools:iio:iio_event_monitor: check if event
 is fully read
References: <cover.1433072539.git.knaack.h@gmx.de> <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de> <556B54A5.6050304@kernel.org>
In-Reply-To: <556B54A5.6050304@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb am 31.05.2015 um 20:36:
> On 31/05/15 13:40, Hartmut Knaack wrote:
>> Check that the read event is of the expected size.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Is this a meaningful thing to do?  Something has gone horribly wrong if this occurs..
> Perhaps just dropping out entirely is a better bet?
> 

Well, my main intention was just to prevent passing garbage data to print_event().
But if you put it this way, then aborting seems more reasonable. Will change it.
Thanks,

Hartmut

>> ---
>>  tools/iio/iio_event_monitor.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
>> index 1316527..ecee8ac 100644
>> --- a/tools/iio/iio_event_monitor.c
>> +++ b/tools/iio/iio_event_monitor.c
>> @@ -304,6 +304,11 @@ int main(int argc, char **argv)
>>  			}
>>  		}
>>  
>> +		if (ret != sizeof(event)) {
>> +			printf("Reading event failed, trying again\n");
>> +			continue;
>> +		}
>> +
>>  		print_event(&event);
>>  	}
>>  
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

