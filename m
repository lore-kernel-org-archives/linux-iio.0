Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48517 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdANRt3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 12:49:29 -0500
Subject: Re: Using IIO for high-speed DAQ
To: Matthias Klumpp <matthias@tenstral.net>
References: <CAKNHny9CYKzSoyq_-T3q35rq=1y1ekQPXr2Rg1ByhabadMWv9A@mail.gmail.com>
 <d1c324a3-17c9-ed66-3946-ccf9a0bbce5d@kernel.org>
 <07a0ebde-dffe-ba6a-5fac-eade517b5a21@metafoo.de>
 <CAKNHny_oY0bsfTZK7_KDKCm=x=KXiMaGkkGXpDFcUXB9SYkoRg@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <eb9bf135-9ea3-99b7-6a21-264dceb8a178@metafoo.de>
Date: Sat, 14 Jan 2017 18:49:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAKNHny_oY0bsfTZK7_KDKCm=x=KXiMaGkkGXpDFcUXB9SYkoRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/14/2017 06:18 PM, Matthias Klumpp wrote:
>> The IIO framework itself does not impose a limit on the maximum sampling
>> rate. It's all a matter of what the hardware is capable of handling. We have
>> systems where we do 3-digit MSPS continuous transfers and GSPS oneshot
>> transfers.
> 
> Since this is the first time I touched this area: Is there a group of
> chips which you would recommend that samples with 200ksps, has a 16bit
> bit-depth and bipolar mode and is accessible at that speed via IIO?
> I'll look around a bit to find a solution for this issue.

Unfortunately this is often as  much about the AP as it is about the
converter. In the setups we have we use a AP+FPGA combination where the AP
runs Linux with IIO and the FPGA is responsible for handling the SPI flow
control during the acquisition phase. For this we've developed the
SPI-Engine framework[1]. It is compatible with most ADI single-channel SAR
and Sigma-Delta ADCs[2].

- Lars

[1] https://wiki.analog.com/resources/fpga/peripherals/spi_engine
[2]
http://www.analog.com/en/products/analog-to-digital-converters/precision-adc-10msps/single-channel-ad-converters.html
