Return-Path: <akinobu.mita@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAC5umyjwYfK5SSi2BYvCr5SFY2BjxxpS4xRAXgvwmp93JrS3XA@mail.gmail.com>
References: <1453998392-562-1-git-send-email-akinobu.mita@gmail.com>
	<56ACEBDF.4020108@kernel.org>
	<CAC5umyjwYfK5SSi2BYvCr5SFY2BjxxpS4xRAXgvwmp93JrS3XA@mail.gmail.com>
Date: Sun, 7 Feb 2016 17:27:57 +0900
Message-ID: <CAC5umygXZFDiPhxi3H_eC8Pj2OvBRGmC18pVzWXbxx=f6+ahuw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: add support for ADC0832 8-bit ADC chips
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-02-01 0:18 GMT+09:00 Akinobu Mita <akinobu.mita@gmail.com>:
>>> +static int adc0831_adc_conversion(struct adc083x *adc)
>>> +{
>>> +     struct spi_device *spi = adc->spi;
>>> +     int ret;
>>> +
>>> +     ret = spi_read(spi, &adc->rx_buf, 2);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return (adc->rx_buf[0] << 2) | (adc->rx_buf[1] >> 6);
>>> +}

I tested with ADC0831 and found that the last line should be:

        /*
         * Skip TRI-STATE and a leading zero
         */
        return (adc->rx_buf[0] << 2 & 0xff) | (adc->rx_buf[1] >> 6);
