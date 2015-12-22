Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48852 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbbLVSxW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2015 13:53:22 -0500
Subject: Re: [PATCH v4 0/2] IIO version of INA2xx
To: Marc Titinger <mtitinger@baylibre.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1450459432-16057-1-git-send-email-mtitinger@baylibre.com>
 <567580E7.5010307@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56799C1D.6060408@kernel.org>
Date: Tue, 22 Dec 2015 18:53:17 +0000
MIME-Version: 1.0
In-Reply-To: <567580E7.5010307@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/12/15 16:08, Jonathan Cameron wrote:
> On 18/12/15 17:23, Marc Titinger wrote:
>> v4:
>>  * squash previous small fixes into one patch and catch up with fixes from
>>    linux-iio git, 'testing' branch.
>>  * fix endianness hint by the use of IIO_CPU, following Andrew's comment
>>  * fix spacing issue.
>>  * add separate ABI documentation entry
>>
>> v3 and earlier : see http://www.spinics.net/lists/linux-iio/msg22100.html
>>
>> Marc Titinger (2):
>>   iio: ina2xx: add support for TI INA2xx Power Monitors
>>   iio: ina2xx: add ABI documentation entry sysfs-bus-iio-ina2xx-adc
>>
>>  Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc |  24 +
>>  drivers/iio/adc/Kconfig                            |  10 +
>>  drivers/iio/adc/Makefile                           |   1 +
>>  drivers/iio/adc/ina2xx-adc.c                       | 745 +++++++++++++++++++++
>>  4 files changed, 780 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
>>  create mode 100644 drivers/iio/adc/ina2xx-adc.c
>>
> The togreg branch to which I applied the previous is a non rebasing tree
> and a pull request went out to Greg so a new complete version is no use
> now.
> 
I've just put together a patch to fixup the wrong endianness issue and applied
it to the togreg branch of iio.git as I'm preparing a pull request and want
this fixed as this will be the last pull of this cycle.

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

