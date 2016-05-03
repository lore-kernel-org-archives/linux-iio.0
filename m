Return-Path: <gregor.boirie@parrot.com>
Message-ID: <572872B8.8060000@parrot.com>
Date: Tue, 3 May 2016 11:43:20 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, One Thousand Gnomes
	<gnomes@lxorguk.ukuu.org.uk>
CC: Crestez Dan Leonard <leonard.crestez@intel.com>, Daniel Baluta
	<daniel.baluta@gmail.com>, Yong Li <sdliyong@gmail.com>, Hartmut Knaack
	<knaack.h@gmx.de>, Matt Ranostaj <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [was iio: tmp006: Set correct iio name] how to support multiple instances
 of same device type
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com> <43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org> <571E854A.90404@gmail.com> <7621197a-95ed-239e-8baa-83014bc27a26@kernel.org> <571F49B0.4060407@metafoo.de> <CADO9-peu32UCxaep8yZUD6XW=ABLGiTYuQJewn-C3Gedc2JewA@mail.gmail.com> <571F588D.3010800@metafoo.de> <CADO9-peqytsYKxVCsEbYt_fLKH3CaiAeQzfgvA+4CsP6u2yJOQ@mail.gmail.com> <CAEnQRZCkcwDUPZHpEOTzcHxQ23xgq429fJQg63s5TUi0w69iWw@mail.gmail.com> <5720EFAA.3040407@intel.com> <5721C904.3010505@metafoo.de> <20160428142458.09e498e2@lxorguk.ukuu.org.uk> <alpine.DEB.2.02.1604281527010.10610@pmeerw.net> <57221BF5.6000001@metafoo.de> <31d08cee-7ab8-d1e7-b15e-001cb6ea1c7c@kernel.org>
In-Reply-To: <31d08cee-7ab8-d1e7-b15e-001cb6ea1c7c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Just to let you know that I'm facing a problem to support multiple 
instances of
the ms5607 barometer onto the same board.

Referencing (i2c) id->name from indio_dev->name is not suitable in this 
case as
libiio and kernel iio tools such as generic_buffer all rely upon a 
unique iio
name to distinguish devices. Here is why.

generic_buffer expects a device name passed as argument to -n option
to get a reference to a device. In this case, it is not possible to
distinguish between devices holding the same name.

When libiio based apps use iio_context_find_device() to get a reference
to a device (by name), names should be unique across devices as above.
When retrieving a device reference by index through iio_context_get_device()
it is not possible to uniquely identify devices in a consistent way either.
Indeed, as indices assignment is automatically done at boot time, it is 
highly
dependent on module / driver loading ordering, devices / daughter board 
presence,
etc...
As a result, apps cannot assume indices are persistent across reboots.

Hence, using dev_name(&client->dev) to name a device is most certainly 
an acceptable
option despites inconsistencies it introduces with i2c name space.

I re-use device tree names to do the job. However, it will not work if 
not compiled
in (and needs patching). What would be a robust and generic naming 
solution then ?

On 05/01/2016 09:34 PM, Jonathan Cameron wrote:
> On 28/04/16 15:19, Lars-Peter Clausen wrote:
>> On 04/28/2016 03:30 PM, Peter Meerwald-Stadler wrote:
>>>>> It's clearly wrong. But the problem is there might be an application that
>>>>> depends on the wrong behavior, the driver has been around for 2.5 years. So
>>>>> it's difficult to fix. We might just go ahead in this case and take the
>>>>> chance that nobody will complain. But if somebody complains this will bring
>>>>> us the wrath of the Linus.
>>>> Not if you put it into next, test it, then into a new release as early as
>>>> possible (for -rc1), clearly document that it's got a user visible change
>>>> that should not matter with instructions if anyone hits this as a
>>>> bisection for their app failing to email so you know and can revert it.
>>> is this the only driver doing it wrong?
>>>
>>> pmeerw@pmeerw:/var/git/linux/drivers/iio$ rgrep "indio_dev->name = dev_name" .
>>> ./imu/inv_mpu6050/inv_mpu_core.c:		indio_dev->name = dev_name(dev);
>>> ./light/lm3533-als.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./dac/vf610_dac.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./dac/stx104.c:	indio_dev->name = dev_name(dev);
>>> ./dac/lpc18xx_dac.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./adc/mcp3422.c:	indio_dev->name = dev_name(&client->dev);
>>> ./adc/at91-sama5d2_adc.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./adc/vf610_adc.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./adc/ti_am335x_adc.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./adc/nau7802.c:	indio_dev->name = dev_name(&client->dev);
>>> ./adc/da9150-gpadc.c:	indio_dev->name = dev_name(dev);
>>> ./adc/lpc18xx_adc.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./adc/rockchip_saradc.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./adc/imx7d_adc.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./adc/cc10001_adc.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./adc/berlin2-adc.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./adc/exynos_adc.c:	indio_dev->name = dev_name(&pdev->dev);
>>> ./temperature/tmp006.c:	indio_dev->name = dev_name(&client->dev);
>>> ./chemical/ams-iaq-core.c:	indio_dev->name = dev_name(&client->dev);
>>> ./chemical/vz89x.c:	indio_dev->name = dev_name(&client->dev);
>>> ./humidity/si7005.c:	indio_dev->name = dev_name(&client->dev);
>>> ./humidity/hdc100x.c:	indio_dev->name = dev_name(&client->dev);
>>> ./humidity/si7020.c:	indio_dev->name = dev_name(&client->dev);
>> Yes, they are all wrong. Mostly of it is just copy'n'paste. We need to be
>> more careful to catch these in the future.
>>
> <expletive deleted>  Lars is unfortunately right, I don't think
> we can unwind this mess now.  If it had been just one driver I'd
> have crossed my fingers and taken it - unfortunately this is way
> too many.
>
> Only way we could clean this up would be define new ABI with the
> intended value and deprecate the old one over a very very long time.
> Do we want to do this?
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
