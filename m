Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:35581 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751440Ab2JHUdz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Oct 2012 16:33:55 -0400
Message-ID: <507338B5.60307@metafoo.de>
Date: Mon, 08 Oct 2012 22:33:57 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Pavel Machek <pavel@denx.de>
CC: Denis CIOCCA <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz>
In-Reply-To: <20121008195007.GA32042@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/08/2012 09:50 PM, Pavel Machek wrote:
> 
>>> drivers/iio/accel/STMicroelectronics_accelerometers_iio_i2c.c
>>>   create mode 100644
>>> drivers/iio/accel/STMicroelectronics_accelerometers_iio_spi.c
>>>   create mode 100644
>>> drivers/iio/accel/STMicroelectronics_accelerometers_iio_trigger.c
>>
>> the file names are a bit excessive in my opinion. How about
>> st_accel_{buffer,core,i2c,...}.c?
> 
> drivers/iio/accel/st/iio_spi.c ?

Maybe. I'd still vote for st_accel though, since I think it is most
descriptive. Since trigger and buffer should go down to a few lines it probably
makes sense to put their content into the core file and I don't think we need a
extra directory for the driver then.

- Lars
