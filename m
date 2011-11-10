Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:32908 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750965Ab1KJSaU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2011 13:30:20 -0500
Message-ID: <4EBC1820.1060506@metafoo.de>
Date: Thu, 10 Nov 2011 19:29:52 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
CC: uclinux-dist-devel@blackfin.uclinux.org, linux-iio@vger.kernel.org
Subject: Re: [Device-drivers-devel] [PATCH] iio: dac - split ad5440 into common,
 i2c and spi modules
References: <1320941253-17857-1-git-send-email-dagenaisj@sonatest.com> <4EBC0250.3040101@metafoo.de> <0974CF3F-FFAB-4AEC-9051-F4C9D0437DAA@gmail.com>
In-Reply-To: <0974CF3F-FFAB-4AEC-9051-F4C9D0437DAA@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/2011 06:34 PM, Jean-Francois Dagenais wrote:
>=20
> On Nov 10, 2011, at 11:56, Lars-Peter Clausen wrote:
>=20
>> On 11/10/2011 05:07 PM, Jean-Fran=E7ois Dagenais wrote:
>>> v1: first proposal, works with i2c AD5622
>>>
>>
>> Hi,
>>
>> Thanks for your patch. I've recently send a patch which converts the=
 ad5446
>> to channel_spec, it would be good if you could rebase v2 of this pat=
ch ontop
>> of it. Unfortunately the patch isn't in GregKH tree yet, but you can=
 grab it
>> from the mailing list archives:
>> http://marc.info/?l=3Dlinux-iio&m=3D131914551420107&q=3Draw
> I am having trouble applying the patch, to you have a tree point (mai=
nline or elsewhere) I should apply the patch onto?
> Trying to be autonomous I have started digging my mailbox for "ad5446=
=2Ec" and found many patches affecting it recently. Starting from
> 3.1, should I do a patch-series with your patch ending the series may=
be?

Hm, looks like there are a few patches which were added in between 3.1 =
and my
patch. If you have a up-to-date linux git tree the following command sh=
ould
list you the missing commits: `git log v3.1..v3.2-rc1
drivers/staging/iio/dac/ad5446.c`

With those applied my patch applies fine ontop. But when sending patche=
s it is
always a good idea to base them on the subsystem maintainers developmen=
t tree.
=46or staging this is GregKH staging-next branch:
http://git.kernel.org/?p=3Dlinux/kernel/git/gregkh/staging.git;a=3Dshor=
tlog;h=3Drefs/heads/staging-next

>=20
>>
>> Some further comments inline.
>>
>>> The patch also contains some cleanup of defines that were not
>>> used.
>>
>> Cleanups should go in a separate patch. Makes it easier to review th=
em.
>>
>>> ---
>>> drivers/staging/iio/dac/Kconfig      |   27 +++-
>>> drivers/staging/iio/dac/Makefile     |    2 +
>>> drivers/staging/iio/dac/ad5446-i2c.c |  135 ++++++++++++++++++
>>> drivers/staging/iio/dac/ad5446-spi.c |  259 +++++++++++++++++++++++=
+++++++++++
>>> drivers/staging/iio/dac/ad5446.c     |  258 +++++++----------------=
-----------
>>> drivers/staging/iio/dac/ad5446.h     |   93 +++++-------
>>> 6 files changed, 510 insertions(+), 264 deletions(-)
>>> create mode 100644 drivers/staging/iio/dac/ad5446-i2c.c
>>> create mode 100644 drivers/staging/iio/dac/ad5446-spi.c
>>>
>>> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/=
dac/Kconfig
>>> index 7ddae35..bb960b5 100644
>>> --- a/drivers/staging/iio/dac/Kconfig
>>> +++ b/drivers/staging/iio/dac/Kconfig
>>> @@ -11,16 +11,37 @@ config AD5624R_SPI
>>> 	  AD5664R convertors (DAC). This driver uses the common SPI interf=
ace.
>>>
>>> config AD5446
>>> -	tristate "Analog Devices AD5444/6, AD5620/40/60 and AD5542A/12A D=
AC SPI driver"
>>> -	depends on SPI
>>> +	tristate "Analog Devices AD5444/6, AD5620/40/60/02/12/22 and AD55=
42A/12A DAC SPI/I2C driver"
>>> 	help
>>> 	  Say yes here to build support for Analog Devices AD5444, AD5446,
>>> 	  AD5512A, AD5542A, AD5543, AD5553, AD5601, AD5611, AD5620, AD5621=
,
>>> -	  AD5640, AD5660 DACs.
>>> +	  AD5640, AD5660, AD5601, AD5612, AD5622 DACs.
>>>
>>> 	  To compile this driver as a module, choose M here: the
>>> 	  module will be called ad5446.
>>>
>>> +config AD5446_SPI
>>> +	tristate "support SPI bus connection"
>>> +	depends on AD5446 && SPI
>>> +	default y
>>> +	help
>>> +	  Say Y here if you have AD5444/6, AD5620/40/60 and AD5542A/12A
>>> +	  DAC connected to a SPI bus.
>>> +
>>> +	  To compile this driver as a module, choose M here: the
>>> +	  module will be called ad5446-spi.
>>> +
>>> +config AD5446_I2C
>>> +	tristate "support I2C bus connection"
>>> +	depends on AD5446 && I2C
>>> +	default y
>>> +	help
>>> +	  Say Y here if you have AD5602/12/22 DAC connected to an I2C bus=
=2E
>>> +
>>> +	  To compile this driver as a module, choose M here: the
>>> +	  module will be called ad5446-i2c.
>>> +
>>> +
>>
>> I don't think we need to split this into two separate modules. Havin=
g one
>> handling both should be fine. The I2C and SPI specific sections shou=
ld be
>> rather small and can be put in a #ifdef CONFIG_... block.
> Yeah, it seemed cleaner, but a bit overkill. I was mimicking the ad71=
4x-i2c/spi strategy.
>>
>>> config AD5504
>>> 	tristate "Analog Devices AD5504/AD5501 DAC SPI driver"
>>> 	depends on SPI
>>> diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio=
/dac/Makefile
>>> index 7f4f2ed..481a1e9 100644
>>> --- a/drivers/staging/iio/dac/Makefile
>>> +++ b/drivers/staging/iio/dac/Makefile
>>> @@ -5,6 +5,8 @@
>>> obj-$(CONFIG_AD5624R_SPI) +=3D ad5624r_spi.o
>>> obj-$(CONFIG_AD5504) +=3D ad5504.o
>>> obj-$(CONFIG_AD5446) +=3D ad5446.o
>>> +obj-$(CONFIG_AD5446_I2C) +=3D ad5446-i2c.o
>>> +obj-$(CONFIG_AD5446_SPI) +=3D ad5446-spi.o
>>> obj-$(CONFIG_AD5791) +=3D ad5791.o
>>> obj-$(CONFIG_AD5686) +=3D ad5686.o
>>> obj-$(CONFIG_MAX517) +=3D max517.o
>>> diff --git a/drivers/staging/iio/dac/ad5446-i2c.c b/drivers/staging=
/iio/dac/ad5446-i2c.c
>>> new file mode 100644
>>> index 0000000..cee606e
>>> --- /dev/null
>>> +++ b/drivers/staging/iio/dac/ad5446-i2c.c
>>> @@ -0,0 +1,135 @@
>>> +/*
>>> + * AD5446 DAC driver SPI specific
>>> + *
>>> + * Copyright 2010 Analog Devices Inc.
>>> + *
>>> + * Licensed under the GPL-2 or later.
>>> + */
>>> +
>>> +#include <linux/device.h>
>>> +#include <linux/i2c.h>
>>> +
>>> +#include "../iio.h"
>>> +
>>> +#include "ad5446.h"
>>> +
>>> +static int ad5446_i2c_sync_to_chip(struct ad5446_state *st)
>>> +{
>>> +	struct i2c_client *client =3D to_i2c_client(st->dev);
>>> +	int error =3D i2c_transfer(client->adapter, &st->proto.i2c.msg, 1=
);
>>> +	if (unlikely(error < 0)) {
>>> +		dev_err(st->dev, "I2C write error: %d\n", error);
>>> +		return error;
>>> +	}
>>
>> Just use i2c_master_send.
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>
>> [...]
>>
>>> @@ -52,8 +37,19 @@ struct ad5446_state {
>>> 	unsigned			cached_val;
>>> 	unsigned			pwr_down_mode;
>>> 	unsigned			pwr_down;
>>> -	struct spi_transfer		xfer;
>>> -	struct spi_message		msg;
>>> +	union {
>>> +#ifdef __enabled_CONFIG_AD5446_SPI
>>
>> Uhm, I think the __enabled_ defines were not intended to be used dir=
ectly.
>> You should rather use the IS_ENABLED macro instead.
>>
>>> +		struct {
>>> +			struct spi_transfer		xfer;
>>> +			struct spi_message		msg;
>>> +		} spi;
>>> +#endif
>>> +#ifdef __enabled_CONFIG_AD5446_I2C
>>> +		struct {
>>> +			struct i2c_msg msg;
>>> +		} i2c;
>>> +#endif
>>> +	} proto;
>>> 	union {
>>> 		unsigned short		d16;
>>> 		unsigned char		d24[3];
>>> @@ -65,7 +61,7 @@ struct ad5446_state {
>>>  * @bits:		accuracy of the DAC in bits
>>>  * @storagebits:	number of bits written to the DAC
>>>  * @left_shift:		number of bits the datum must be shifted
>>> - * @int_vref_mv:	AD5620/40/60: the internal reference voltage
>>> + * @int_vref_mv:	AD5620/40/60: the internal reference voltage, 0 m=
eans vcc ref
>>>  * @store_sample:	chip specific helper function to store the datum
>>>  * @store_sample:	chip specific helper function to store the powerp=
own cmd
>>>  */
>>> @@ -77,33 +73,22 @@ struct ad5446_chip_info {
>>> 	u16			int_vref_mv;
>>> 	void (*store_sample)	(struct ad5446_state *st, unsigned val);
>>> 	void (*store_pwr_down)	(struct ad5446_state *st, unsigned mode);
>>> +	int  (*sync_to_chip) (struct ad5446_state *st);
>>
>> I would put the sync callback into the ad5446_state struct and initi=
alize it
>> in the I2C and SPI probe function. No need to store this information=
 on a
>> per chip basis. And maybe call it "write" or something instead.
>>
>> [...]
>>
>>> #endif /* IIO_DAC_AD5446_H_ */
>>
>=20
> As a general question, while digging, I found concerning mail about r=
andom kernel segfaults. I know staging gives out this big warning, but =
I thought I would be safe using a simple driver like the ad5446 for pro=
duction. Am I mistaken. I mean the chip is so dumb simple, I am now con=
sidering using i2cset from userspace instead since I will not really be=
 using the whole iio framework.
>

The IIO framework should be quite stable by now. So you shouldn't reall=
y get
any random segfaults by using it. To which mail are you referring to?

- Lars



