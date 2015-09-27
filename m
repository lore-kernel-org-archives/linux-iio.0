Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37327 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156AbbI0P6Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 11:58:24 -0400
Subject: Re: [PATCH v2 0/4] iio: bmc150 regmap and SPI
To: "Tirdea, Irina" <irina.tirdea@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>
References: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
 <1F3AC3675D538145B1661F571FE1805F2F0C833A@irsmsx105.ger.corp.intel.com>
 <20150916101322.GJ1537@pengutronix.de>
 <1F3AC3675D538145B1661F571FE1805F2F0E78BA@irsmsx105.ger.corp.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5608121E.4050305@kernel.org>
Date: Sun, 27 Sep 2015 16:58:22 +0100
MIME-Version: 1.0
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0E78BA@irsmsx105.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/15 13:44, Tirdea, Irina wrote:
> 
> 
>> -----Original Message-----
>> From: Markus Pargmann [mailto:mpa@pengutronix.de]
>> Sent: 16 September, 2015 13:13
>> To: Tirdea, Irina
>> Cc: Jonathan Cameron; Srinivas Pandruvada; Lars-Peter Clausen; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
>> kernel@pengutronix.de
>> Subject: Re: [PATCH v2 0/4] iio: bmc150 regmap and SPI
>>
>> Hi Irina,
>>
>> On Wed, Sep 09, 2015 at 02:30:30PM +0000, Tirdea, Irina wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Markus Pargmann [mailto:mpa@pengutronix.de]
>>>> Sent: 20 August, 2015 15:50
>>>> To: Jonathan Cameron
>>>> Cc: Srinivas Pandruvada; Tirdea, Irina; Lars-Peter Clausen; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> kernel@pengutronix.de; Markus Pargmann
>>>> Subject: [PATCH v2 0/4] iio: bmc150 regmap and SPI
>>>>
>>>> Hi,
>>>>
>>>
>>> Hi Markus,
>>>
>>> I tested your patches with my BMA250E driver connected on the i2c bus .
>>> The code looks good and most of it works. There are a couple of issues I will mention
>>> below and in the individual patches.
>>>
>>> The patches in this version no longer apply cleanly on the togreg branch of the iio tree.
>>> I did the rebase myself, but since there were many conflicts I will do another test
>>> when you send the new rebased v3.
>>
>> Thank you for review and testing. I will integrate your comments and
>> send a rebased v3.
>>
>>>
>>>> this series converts the bmc150 driver to use regmap and adds an SPI interface.
>>>>
>>>> In v1 this was part of the series "Regmap max_raw_io and bmc150 SPI support".
>>>> It now depends on "regmap: i2c block support".
>>>>
>>>
>>> I used the patches that were already merged in the regmap tree. This bmc150 series should
>>> probably wait until the regmap patches end up in Jonathan's tree, otherwise they will
>>> break the build.
>>
>> It seems the necessary patches are already in v4.3-rc1:
>> 	29332534e2b6 (regmap-i2c: Add smbus i2c block support)
>>
> 
> AFAIK, Jonathan waits until changes from the main kernel get merged back
> into his togreg branch. Since you are using regmap_get_raw_read_max that
> is introduced in the regmap patches, the driver won't build without them
> (if they are merged now in the iio tree).
Exactly, I tend not to explicitly pull other trees into mine other than my
upstream (staging-next currently).  Those merges tend to only occur as fast
forward merges after Greg has accepted a pull request from me.  Right
now I have one outstanding.  After / if he takes that I can then fast forward
to a tree based on 4.3-rcX and apply these patches.
> 
> However, that does not prevent me from testing the changes using
> the regmap changes from v4.3-rc1.
> 
> Thanks,
> Irina
> 
>> Best Regards,
>>
>> Markus
>>
>>>
>>> Thanks,
>>> Irina
>>>
>>>> Changes in v2:
>>>> - Removed default values for regmap_config fields.
>>>> - Redesigned the fifo_transfer function to avoid running in errors first.
>>>> - Dropped irq checks patch as it is already mainline
>>>> - Core can now be built as module with autoselection of i2c and spi parts
>>>>
>>>> As my hardware is missing an interrupt line from the SPI connected bmc150 I am
>>>> not able to test the iio buffer code path and the i2c code path. Tests would be
>>>> appreciated.
>>>>
>>>> Best regards,
>>>>
>>>> Markus
>>>>
>>>>
>>>> Markus Pargmann (4):
>>>>   iio: bmc150: Use i2c regmap
>>>>   iio: bcm150: Remove i2c_client from private data
>>>>   iio: bmc150: Split the driver into core and i2c
>>>>   iio: bmc150: Add SPI driver
>>>>
>>>>  drivers/iio/accel/Kconfig                          |  14 +-
>>>>  drivers/iio/accel/Makefile                         |   4 +-
>>>>  .../accel/{bmc150-accel.c => bmc150-accel-core.c}  | 398 ++++++++-------------
>>>>  drivers/iio/accel/bmc150-accel-i2c.c               |  99 +++++
>>>>  drivers/iio/accel/bmc150-accel-spi.c               |  83 +++++
>>>>  drivers/iio/accel/bmc150-accel.h                   |  21 ++
>>>>  6 files changed, 367 insertions(+), 252 deletions(-)
>>>>  rename drivers/iio/accel/{bmc150-accel.c => bmc150-accel-core.c} (81%)
>>>>  create mode 100644 drivers/iio/accel/bmc150-accel-i2c.c
>>>>  create mode 100644 drivers/iio/accel/bmc150-accel-spi.c
>>>>  create mode 100644 drivers/iio/accel/bmc150-accel.h
>>>>
>>>> --
>>>> 2.4.6
>>>
>>>
>>
>> --
>> Pengutronix e.K.                           |                             |
>> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> 

