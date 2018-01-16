Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:49132 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeAPLre (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jan 2018 06:47:34 -0500
Date: Tue, 16 Jan 2018 14:43:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: arnaud.pouliquen@st.com
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org
Subject: [bug report] IIO: ADC: add stm32 DFSDM support for PDM microphone
Message-ID: <20180116114301.GA9506@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Arnaud Pouliquen,

The patch eca949800d2d: "IIO: ADC: add stm32 DFSDM support for PDM
microphone" from Jan 10, 2018, leads to the following static checker
warning:

	drivers/iio/adc/stm32-dfsdm-adc.c:555 stm32_dfsdm_audio_dma_buffer_done()
	warn: potential shift truncation.  '0xffffff00 (0,256-4294967040) << 8'

drivers/iio/adc/stm32-dfsdm-adc.c
   551          while (available >= indio_dev->scan_bytes) {
   552                  u32 *buffer = (u32 *)&adc->rx_buf[adc->bufi];
   553  
   554                  /* Mask 8 LSB that contains the channel ID */
   555                  *buffer = (*buffer & 0xFFFFFF00) << 8;

Is this shift, correct?  The comment just mentions that we're masking
out the low bits.

   556                  available -= indio_dev->scan_bytes;
   557                  adc->bufi += indio_dev->scan_bytes;
   558                  if (adc->bufi >= adc->buf_sz) {
   559                          if (adc->cb)
   560                                  adc->cb(&adc->rx_buf[old_pos],
   561                                           adc->buf_sz - old_pos, adc->cb_priv);
   562                          adc->bufi = 0;
   563                          old_pos = 0;
   564                  }
   565          }
   566          if (adc->cb)
   567                  adc->cb(&adc->rx_buf[old_pos], adc->bufi - old_pos,
   568                          adc->cb_priv);
   569  }

regards,
dan carpenter
