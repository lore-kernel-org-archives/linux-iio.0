Return-Path: <lennox.wu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201407130545.23004.marex@denx.de>
References: <53C1F7DE.3060102@gmail.com>
	<201407130545.23004.marex@denx.de>
Date: Sun, 13 Jul 2014 17:27:44 +0800
Message-ID: <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for 'devm_ioremap_resource'
From: Lennox Wu <lennox.wu@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: Chen Gang <gang.chen.5i5j@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com,
	thierry.reding@gmail.com, jic23@kernel.org, wim@iguana.be,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, kys@microsoft.com,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, teg@jklm.no, Mischa.Jonker@synopsys.com,
	msalter@redhat.com, lars@metafoo.de, Richard Weinberger <richard@nod.at>, knaack.h@gmx.de,
	rdunlap@infradead.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-watchdog@vger.kernel.org, Liqin Chen <liqin.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

As I said before, some configurations don't make sense.
I don't think all of the patches are necessary.

Best,
Lennox

2014-07-13 11:45 GMT+08:00 Marek Vasut <marex@denx.de>:
> On Sunday, July 13, 2014 at 05:07:10 AM, Chen Gang wrote:
>> Several drivers need 'devm_ioremap_resource' which need HAS_IOMEM enabled.
>> So let them depend on HAS_IOMEM.
>>
>> The related error (with allmodconfig under score):
>>
>>     MODPOST 1365 modules
>>   ERROR: "devm_ioremap_resource" [drivers/watchdog/tegra_wdt.ko] undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko]
>> undefined! ERROR: "devm_ioremap_resource"
>> [drivers/staging/iio/adc/mxs-lradc.ko] undefined! ERROR:
>> "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] undefined! ERROR:
>> "devm_ioremap_resource" [drivers/input/serio/olpc_apsp.ko] undefined!
>> ERROR: "devm_ioremap_resource" [drivers/input/serio/arc_ps2.ko] undefined!
>
> This stuff should go through different trees, so I'd suggest to split this into
> multiple patches. Thanks for catching this stuff !
>
> Best regards,
> Marek Vasut
