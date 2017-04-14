Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56501 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdDNOps (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 10:45:48 -0400
Subject: Re: [PATCH 0/2] Enhancements for TI INA219/220 current/voltage
 monitors
To: =?UTF-8?Q?Stefan_Br=c3=bcns?= <stefan.bruens@rwth-aachen.de>,
        linux-iio@vger.kernel.org
References: <e91408f6b96d461b8d59b8dbd6849bf2@rwthex-w2-b.rwth-ad.de>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <98174c5e-d785-38dc-7d1f-c2b14273539e@kernel.org>
Date: Fri, 14 Apr 2017 15:45:46 +0100
MIME-Version: 1.0
In-Reply-To: <e91408f6b96d461b8d59b8dbd6849bf2@rwthex-w2-b.rwth-ad.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/04/17 04:01, Stefan Brüns wrote:
> The ina2xx adc driver does not handle differences between INA219/220 and
> INA226/230/231 completely:
> 
> - The 219 uses a 4 bit register field for for the bus/shunt voltage adc
>   integration times each, whereas the 226 uses two 3 bit fields for the
>   integration times and an additional 3 bit averaging field.
> 
>   The first patch correct setting integration times in the config register.
> 
> - The 219 also has an adjustable PGA. The default setting allows the
>   maximum range, but also reduces accuracy.
> 
>   The second patch adds attributes for shunt PGA gain and bus voltage
>   range (bus voltage PGA), and sets the config register accordingly.
> 
> Stefan Brüns (2):
>   iio: adc: Fix integration time/averaging for INA219/220
>   iio: adc: Allow setting Shunt Voltage PGA gain and Bus Voltage range
> 
>  drivers/iio/adc/ina2xx-adc.c | 344 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 322 insertions(+), 22 deletions(-)
> 
These will definitely need an Ack from Marc Titinger if possible.
