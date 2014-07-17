Return-Path: <naveenkrishna.ch@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK5sBcFR0nwmL97CYxhHHhwHREdNOMYZnc2DF+O=WdQLBHQbLA@mail.gmail.com>
References: <1405595993-16661-1-git-send-email-ch.naveen@samsung.com>
 <1405595993-16661-2-git-send-email-ch.naveen@samsung.com> <CAK5sBcFR0nwmL97CYxhHHhwHREdNOMYZnc2DF+O=WdQLBHQbLA@mail.gmail.com>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Thu, 17 Jul 2014 17:41:16 +0530
Message-ID: <CAHfPSqDBfdmt2R4yB1AUG9U8UvsYtmVtL03-OMuozKGXYGdMgw@mail.gmail.com>
Subject: Re: [PATCH 1/4 v2] iio: exyno-adc: use syscon for PMU register access
To: Sachin Kamat <spk.linux@gmail.com>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>, linux-iio@vger.kernel.org,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>, cpgs@samsung.com, Grant Grundler <grundler@chromium.org>,
	jic23@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello Sachin,

On 17 July 2014 17:24, Sachin Kamat <spk.linux@gmail.com> wrote:
> Hi Naveen,
>
> On Thu, Jul 17, 2014 at 4:49 PM, Naveen Krishna Chatradhi
> <ch.naveen@samsung.com> wrote:
>> This patch updates the IIO based ADC driver to use syscon and regmap
>> APIs to access and use PMU registers instead of remapping the PMU
>> registers in the driver.
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> To: linux-iio@vger.kernel.org
>
> With only this patch applied, I believe the ADC functionality would be broken.
> Perhaps the DT changes should be merged along with this patch?

Jonathan already mentioned that, he would wait for Ack from Kukjin.
With out the dts changes ADC driver will fail to probe but it wont
crash the system.
git bisect should still work.

>
> --
> Regards,
> Sachin.



-- 
Shine bright,
(: Nav :)
