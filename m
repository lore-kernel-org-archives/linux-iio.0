Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:48460 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeAPNJU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jan 2018 08:09:20 -0500
Date: Tue, 16 Jan 2018 16:08:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [bug report] IIO: ADC: add stm32 DFSDM support for PDM microphone
Message-ID: <20180116130846.lvfiucbis3z4vcz2@mwanda>
References: <20180116114301.GA9506@mwanda>
 <653a9bfc-ee0a-32c9-1496-17cc30360ad6@st.com>
 <20180116125018.nel3cwebi4wyz4mu@mwanda>
 <a68cc28c-748e-2398-f4cc-113f6de8a33d@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a68cc28c-748e-2398-f4cc-113f6de8a33d@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 16, 2018 at 02:03:49PM +0100, Arnaud Pouliquen wrote:
> 
> 
> On 01/16/2018 01:50 PM, Dan Carpenter wrote:
> > On Tue, Jan 16, 2018 at 01:47:29PM +0100, Arnaud Pouliquen wrote:
> >> Hello Dan
> >>
> >> On 01/16/2018 12:43 PM, Dan Carpenter wrote:
> >>> Hello Arnaud Pouliquen,
> >>>
> >>> The patch eca949800d2d: "IIO: ADC: add stm32 DFSDM support for PDM
> >>> microphone" from Jan 10, 2018, leads to the following static checker
> >>> warning:
> >>>
> >>> 	drivers/iio/adc/stm32-dfsdm-adc.c:555 stm32_dfsdm_audio_dma_buffer_done()
> >>> 	warn: potential shift truncation.  '0xffffff00 (0,256-4294967040) << 8'
> >>>
> >>> drivers/iio/adc/stm32-dfsdm-adc.c
> >>>    551          while (available >= indio_dev->scan_bytes) {
> >>>    552                  u32 *buffer = (u32 *)&adc->rx_buf[adc->bufi];
> >>>    553  
> >>>    554                  /* Mask 8 LSB that contains the channel ID */
> >>>    555                  *buffer = (*buffer & 0xFFFFFF00) << 8;
> >>>
> >>> Is this shift, correct?  The comment just mentions that we're masking
> >>> out the low bits.
> >> Yes mask and shift are not correlated.
> >> The Mask suppresses the 8 LSB that contain ID of the channel scanned
> >> The shift is used for the 24 to 32 bits sample conversion.
> >>
> > 
> > If you wanted to silence the static checker warning you could change the
> > mask to:
> > 
> > 		*buffer = (*buffer & 0x00FFFF00) << 8;
> 
> Thanks for the proposal, fill free to send the patch, otherwise i will
> add it in next patch series.
> For my personal information which static checker warns on this line?

It's some Smatch stuff that has too many false positives so I review it
but haven't published it.

regards,
dan carpenter

