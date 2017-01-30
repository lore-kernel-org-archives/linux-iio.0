Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61103 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752428AbdA3QJz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 11:09:55 -0500
Subject: Re: [PATCH 4/7] IIO: add STM32 DFSDM ADC support
To: Jonathan Cameron <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-5-git-send-email-arnaud.pouliquen@st.com>
 <14320aef-7956-74bf-e4c3-5f2354cc5493@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <7d3336e8-ad0b-a52c-5aa8-9b39a503d426@st.com>
Date: Mon, 30 Jan 2017 17:02:44 +0100
MIME-Version: 1.0
In-Reply-To: <14320aef-7956-74bf-e4c3-5f2354cc5493@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,

Thanks for the reviews, i will integrate your comment in next version.

On 01/29/2017 01:15 PM, Jonathan Cameron wrote:
> On 23/01/17 16:32, Arnaud Pouliquen wrote:
>> Add driver to handle Sigma Delta ADC conversion for ADC
>> connected to DFSDM IP.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Various comments inline.  Again mostly reading this to grasp how the whole
> lot fits together.
> 
> At the moment, other than some new ABI, this is a fairly simple sysfs or in
> kernel polled ADC driver.  The hardware seems to support a whole lot more
> but fair enough to present this as a starting point!

Yes, from IIO point of view, should increase driver features in future
to integrate buffer, scan mode, triggers...
Or perhaps i will need to introduce some of these concepts to handle
ASoC requirement in IIO...

FYI, DFSDM also offers some features like Analog watchdog, short circuit
and SPI/manchester bus clock absence detection detection...:)

Regards
Arnaud

