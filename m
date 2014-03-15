Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60479 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087AbaCOPry (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Mar 2014 11:47:54 -0400
Message-ID: <53247666.3000504@kernel.org>
Date: Sat, 15 Mar 2014 15:48:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging:iio:ad799x: Move ring functions to the main
 file
References: <1394447484-29334-1-git-send-email-lars@metafoo.de> <531E3BDC.4020609@gmx.de>
In-Reply-To: <531E3BDC.4020609@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/14 22:25, Hartmut Knaack wrote:
> Lars-Peter Clausen schrieb:
>> The ad799x_ring.c file is pretty much only one function these days. No need to
>> keep it in a separate file. Since there is then only one user of the header left
>> also move everything from the header to the main file.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>   drivers/staging/iio/adc/Kconfig       |  13 +--
>>   drivers/staging/iio/adc/Makefile      |   1 -
>>   drivers/staging/iio/adc/ad799x.h      | 121 ----------------------------
>>   drivers/staging/iio/adc/ad799x_core.c | 145 +++++++++++++++++++++++++++++++++-
>>   drivers/staging/iio/adc/ad799x_ring.c |  84 --------------------
>>   5 files changed, 143 insertions(+), 221 deletions(-)
>>   delete mode 100644 drivers/staging/iio/adc/ad799x.h
>>   delete mode 100644 drivers/staging/iio/adc/ad799x_ring.c
>>
>>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Small point Hartmut, but if adding an ack, put it just below the last sign off etc
above.  Makes it harder for me to miss ;)

Applied to the togreg branch of iio.git

Thanks and keep up the good work. I'll start pesting Lars about drivers I think he
is being too fussy about ;)
>

