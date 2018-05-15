Return-Path: <SRS0=eGl7=IC=st.com=fabrice.gasnier@kernel.org>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Add support for stm32mp1
To: Jonathan Cameron <jic23@kernel.org>
CC: Rob Herring <robh@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
References: <1525266323-4922-1-git-send-email-fabrice.gasnier@st.com>
 <20180507205151.GA25321@rob-hp-laptop> <20180512103324.5068c893@archlinux>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <781b346a-e457-9c67-2e11-6f6edba88d63@st.com>
Date: Tue, 15 May 2018 17:23:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180512103324.5068c893@archlinux>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 05/12/2018 11:33 AM, Jonathan Cameron wrote:
> On Mon, 7 May 2018 15:51:51 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
>> On Wed, May 02, 2018 at 03:05:23PM +0200, Fabrice Gasnier wrote:
>>> Add support for DFSDM (Digital Filter For Sigma Delta Modulators)
>>> to STM32MP1. This variant is close to STM32H7 DFSDM, it implements
>>> 6 filter instances. Registers map is also increased.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> ---
>>>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt         |  7 +++++--
>>>  drivers/iio/adc/stm32-dfsdm-core.c                  | 21 +++++++++++++++++++++
>>>  2 files changed, 26 insertions(+), 2 deletions(-)  
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> Applied.   Whilst doing this I note that I'm getting a few sparse
> warnings for this driver that would be nice to clean up...
> 
>   CHECK   drivers/iio/adc/stm32-dfsdm-adc.c
> drivers/iio/adc/stm32-dfsdm-adc.c:503:21: warning: expression using sizeof(void)
> drivers/iio/adc/stm32-dfsdm-adc.c:503:21: warning: expression using sizeof(void)
> 
> Which is mystifying at first glance... Something deep and dirty in the min macro
> but I can't see what..

Hi Jonathan,

I just sent a patch to clean bellow warning. But this is more obscure
regarding min macro...

Many thanks,
Fabrice

> 
> drivers/iio/adc/stm32-dfsdm-adc.c:680:5: warning: symbol 'stm32_dfsdm_get_buff_cb' was not declared. Should it be static?
> drivers/iio/adc/stm32-dfsdm-adc.c:703:5: warning: symbol 'stm32_dfsdm_release_buff_cb' was not declared. Should it be static?
> 
> Are rather more obvious
> 
