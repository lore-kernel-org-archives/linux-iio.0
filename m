Return-Path: <SRS0=BVh5=L7=xilinx.com=michals@kernel.org>
Subject: Re: [PATCH v2 2/4] iio: Documentation: Add Xilinx AMS sysfs
 documentation
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Michal Simek
	<michal.simek@xilinx.com>
CC: Jonathan Cameron <jic23@kernel.org>, Manish Narani
	<manish.narani@xilinx.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
	<sudeep.holla@arm.com>, <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>,
	<broonie@kernel.org>, <arnaud.pouliquen@st.com>,
	<eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
	<geert@linux-m68k.org>, <ak@it-klinger.de>, <freeman.liu@spreadtrum.com>,
	<lukas@wunner.de>, <vilhelm.gray@gmail.com>, <gregkh@linuxfoundation.org>,
	<kstewart@linuxfoundation.org>, <sgoud@xilinx.com>, <anirudh@xilinx.com>,
	<linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
 <1536909510-7166-3-git-send-email-manish.narani@xilinx.com>
 <20180916111242.73af71ed@archlinux>
 <cf2acc8a-ed2d-27f4-ca58-3e2132e17d2a@xilinx.com>
 <20180917110215.00002846@huawei.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <469597c5-724f-08c9-ccbc-f076673e1744@xilinx.com>
Date: Mon, 17 Sep 2018 12:23:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180917110215.00002846@huawei.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 17.9.2018 12:06, Jonathan Cameron wrote:
> On Mon, 17 Sep 2018 11:56:08 +0200
> Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> On 16.9.2018 12:12, Jonathan Cameron wrote:
>>> On Fri, 14 Sep 2018 12:48:28 +0530
>>> Manish Narani <manish.narani@xilinx.com> wrote:
>>>   
>>>> Add documentation for xilinx-ams driver. This contains information about
>>>> various voltages and temperatures on PS (Processing System), PL
>>>> (Programmable Logic) and AMS Control Block.
>>>>
>>>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>  
>>> The more I look at this device the more I'm convinced it is very much a dedicated
>>> hardware monitoring function, not a generic ADC sensing unit at all.
>>>
>>> Hmm.  It is still fine to have it in IIO but you need to think in detail
>>> about how you are going to interface this to hwmon via the iio-hwmon bridge.
>>>
>>> Some of the interface complexity should only really be apparent when we hit
>>> hwmon perhaps rather than having so many different custom interfaces in IIO.
>>>
>>> Please also loop in the maintainers and lists for hwmon in the next
>>> version so we can get their input.  
>>
>> Isn't there iio-hwmon driver for this?
>>
>> Thanks,
>> Michal
> 
> Absolutely.  The interesting bit is that if we are planning to actually expose
> the many monitoring channels via iio-hwmon IIRC it won't use the extended names
> at all (I may have missremembered this thogh).  As such we may want to reduced
> the amount of custom ABI in IIO in favour of a level of opaqueness with the
> 'real' interface provided by the iio-hwmon bridge driver.  A quick glance
> suggested we may need to increase the information exposed by the iio-hwmon
> driver to make this work.

ok.


> When we have run into cases like this (a very much hardware monitoring oriented
> device with a few general purpose channels) in the past we have always gotten
> agreement from the hwmon maintainers that they are happy with using an IIO provider
> and the iio-hwmon driver route. It is just nice to keep everyone in agreement
> and have no surprises!

Definitely I agree with this.

Thanks,
Michal
