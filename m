Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio: tmp006: Set correct iio name
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
 <43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org> <571E854A.90404@gmail.com>
 <7621197a-95ed-239e-8baa-83014bc27a26@kernel.org>
 <571F49B0.4060407@metafoo.de>
 <CADO9-peu32UCxaep8yZUD6XW=ABLGiTYuQJewn-C3Gedc2JewA@mail.gmail.com>
 <571F588D.3010800@metafoo.de>
 <CADO9-peqytsYKxVCsEbYt_fLKH3CaiAeQzfgvA+4CsP6u2yJOQ@mail.gmail.com>
 <CAEnQRZCkcwDUPZHpEOTzcHxQ23xgq429fJQg63s5TUi0w69iWw@mail.gmail.com>
 <5720EFAA.3040407@intel.com> <5721C904.3010505@metafoo.de>
 <20160428142458.09e498e2@lxorguk.ukuu.org.uk>
 <alpine.DEB.2.02.1604281527010.10610@pmeerw.net>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>, Yong Li <sdliyong@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski@samsung.com>,
 Matt Ranostaj <mranostay@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <57221BF5.6000001@metafoo.de>
Date: Thu, 28 Apr 2016 16:19:33 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1604281527010.10610@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/28/2016 03:30 PM, Peter Meerwald-Stadler wrote:
> 
>>> It's clearly wrong. But the problem is there might be an application that
>>> depends on the wrong behavior, the driver has been around for 2.5 years. So
>>> it's difficult to fix. We might just go ahead in this case and take the
>>> chance that nobody will complain. But if somebody complains this will bring
>>> us the wrath of the Linus.
>>
>> Not if you put it into next, test it, then into a new release as early as
>> possible (for -rc1), clearly document that it's got a user visible change
>> that should not matter with instructions if anyone hits this as a
>> bisection for their app failing to email so you know and can revert it.
> 
> is this the only driver doing it wrong?
> 
> pmeerw@pmeerw:/var/git/linux/drivers/iio$ rgrep "indio_dev->name = dev_name" . 
> ./imu/inv_mpu6050/inv_mpu_core.c:		indio_dev->name = dev_name(dev);
> ./light/lm3533-als.c:	indio_dev->name = dev_name(&pdev->dev);
> ./dac/vf610_dac.c:	indio_dev->name = dev_name(&pdev->dev);
> ./dac/stx104.c:	indio_dev->name = dev_name(dev);
> ./dac/lpc18xx_dac.c:	indio_dev->name = dev_name(&pdev->dev);
> ./adc/mcp3422.c:	indio_dev->name = dev_name(&client->dev);
> ./adc/at91-sama5d2_adc.c:	indio_dev->name = dev_name(&pdev->dev);
> ./adc/vf610_adc.c:	indio_dev->name = dev_name(&pdev->dev);
> ./adc/ti_am335x_adc.c:	indio_dev->name = dev_name(&pdev->dev);
> ./adc/nau7802.c:	indio_dev->name = dev_name(&client->dev);
> ./adc/da9150-gpadc.c:	indio_dev->name = dev_name(dev);
> ./adc/lpc18xx_adc.c:	indio_dev->name = dev_name(&pdev->dev);
> ./adc/rockchip_saradc.c:	indio_dev->name = dev_name(&pdev->dev);
> ./adc/imx7d_adc.c:	indio_dev->name = dev_name(&pdev->dev);
> ./adc/cc10001_adc.c:	indio_dev->name = dev_name(&pdev->dev);
> ./adc/berlin2-adc.c:	indio_dev->name = dev_name(&pdev->dev);
> ./adc/exynos_adc.c:	indio_dev->name = dev_name(&pdev->dev);
> ./temperature/tmp006.c:	indio_dev->name = dev_name(&client->dev);
> ./chemical/ams-iaq-core.c:	indio_dev->name = dev_name(&client->dev);
> ./chemical/vz89x.c:	indio_dev->name = dev_name(&client->dev);
> ./humidity/si7005.c:	indio_dev->name = dev_name(&client->dev);
> ./humidity/hdc100x.c:	indio_dev->name = dev_name(&client->dev);
> ./humidity/si7020.c:	indio_dev->name = dev_name(&client->dev);

Yes, they are all wrong. Mostly of it is just copy'n'paste. We need to be
more careful to catch these in the future.
