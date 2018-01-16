Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33231 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751178AbeAPMrr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jan 2018 07:47:47 -0500
Subject: Re: [bug report] IIO: ADC: add stm32 DFSDM support for PDM microphone
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
References: <20180116114301.GA9506@mwanda>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <653a9bfc-ee0a-32c9-1496-17cc30360ad6@st.com>
Date: Tue, 16 Jan 2018 13:47:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180116114301.GA9506@mwanda>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Dan

On 01/16/2018 12:43 PM, Dan Carpenter wrote:
> Hello Arnaud Pouliquen,
> 
> The patch eca949800d2d: "IIO: ADC: add stm32 DFSDM support for PDM
> microphone" from Jan 10, 2018, leads to the following static checker
> warning:
> 
> 	drivers/iio/adc/stm32-dfsdm-adc.c:555 stm32_dfsdm_audio_dma_buffer_done()
> 	warn: potential shift truncation.  '0xffffff00 (0,256-4294967040) << 8'
> 
> drivers/iio/adc/stm32-dfsdm-adc.c
>    551          while (available >= indio_dev->scan_bytes) {
>    552                  u32 *buffer = (u32 *)&adc->rx_buf[adc->bufi];
>    553  
>    554                  /* Mask 8 LSB that contains the channel ID */
>    555                  *buffer = (*buffer & 0xFFFFFF00) << 8;
> 
> Is this shift, correct?  The comment just mentions that we're masking
> out the low bits.
Yes mask and shift are not correlated.
The Mask suppresses the 8 LSB that contain ID of the channel scanned
The shift is used for the 24 to 32 bits sample conversion.

Regards,
Arnaud
> 
>    556                  available -= indio_dev->scan_bytes;
>    557                  adc->bufi += indio_dev->scan_bytes;
>    558                  if (adc->bufi >= adc->buf_sz) {
>    559                          if (adc->cb)
>    560                                  adc->cb(&adc->rx_buf[old_pos],
>    561                                           adc->buf_sz - old_pos, adc->cb_priv);
>    562                          adc->bufi = 0;
>    563                          old_pos = 0;
>    564                  }
>    565          }
>    566          if (adc->cb)
>    567                  adc->cb(&adc->rx_buf[old_pos], adc->bufi - old_pos,
>    568                          adc->cb_priv);
>    569  }
> 
> regards,
> dan carpenter
> 
