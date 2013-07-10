Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.5]:12508 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754362Ab3GJKrO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2013 06:47:14 -0400
Message-ID: <51DD3BA5.6000402@digi.com>
Date: Wed, 10 Jul 2013 12:47:01 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307051337.39215.marex@denx.de> <51D6BED7.6060703@digi.com> <201307051510.29011.marex@denx.de>
In-Reply-To: <201307051510.29011.marex@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

On 07/05/2013 03:10 PM, Marek Vasut wrote:
> Dear Hector Palacios,
>
>> Dear Marek,
>>
>> On 07/05/2013 01:37 PM, Marek Vasut wrote:
>>> Dear Hector Palacios,
>>>
>>>> The LRADC virtual channels have an 18 bit field to store the sum of up
>>>> to 2^5 accumulated samples. The read_raw function however only operates
>>>> over a single sample (12 bit resolution).
>>>> In order to use this field for scaling operations, we need it to be the
>>>> exact resolution value of the LRADC.
>>>
>>> How would this work once the accumulation is supported?
>>
>> As I see it, when you read a channel the driver should give you the 12-bit
>> value either of one single sample or of N samples.
>
> The hardware will always give you 18 bit value, let's call it A of N accumulated
> samples, each 12 bit long. N is in range of 1 to 32 .
>
> The driver currently supports N = 1.
>
> Do I understand it correctly that if we want to support N > 1, we have to do the
> division of A / N in the driver and therefore we will again report only a 12-bit
> value to the userland ?
>
> If so,
>
> Acked-by: Marek Vasut <marex@denx.de>

Coming back to this patch, I just noticed that it is not enough to just change the 
realbits from 18 to 12. When using this driver as touchscreen for Yocto's SATO graphic 
rootfs I noticed that the driver is using LRADC_CH_VALUE_MASK for reporting the 
coordinates.

	input_set_abs_params(input, ABS_X, 0, LRADC_CH_VALUE_MASK, 0, 0);
	input_set_abs_params(input, ABS_Y, 0, LRADC_CH_VALUE_MASK, 0, 0);
	input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_CH_VALUE_MASK, 0, 0);

which is defined as an 18bit mask:

	#define	LRADC_CH_VALUE_MASK			0x3ffff

The result is that the touch calibration range in Xorg is expecting values between 0 
and 262143 (0x3ffff), which causes trouble (at least I had problems to calibrate it).

root@computer:~# xinput --list mxs-lradc
mxs-lradc                                       id=6    [slave  pointer  (2)]
         Reporting 4 classes:
                 Class originated from: 6. Type: XIButtonClass
                 Buttons supported: 5
                 Button labels: "Button Unknown" "Button Unknown" "Button Unknown" 
"Button Wheel Up" "Button Wheel Down"
                 Button state:
                 Class originated from: 6. Type: XIValuatorClass
                 Detail for Valuator 0:
                   Label: Abs X
                   Range: 0.000000 - 262143.000000
                   Resolution: 0 units/m
                   Mode: absolute
                   Current value: 2512.000000
                 Class originated from: 6. Type: XIValuatorClass
                 Detail for Valuator 1:
                   Label: Abs Y
                   Range: 0.000000 - 262143.000000
                   Resolution: 0 units/m
                   Mode: absolute
                   Current value: 1688.000000
                 Class originated from: 6. Type: XIValuatorClass
                 Detail for Valuator 2:
                   Label: Abs Pressure
                   Range: 0.000000 - 262143.000000
                   Resolution: 0 units/m
                   Mode: absolute
                   Current value: 0.000000

So probably we should complete this patch with the following:

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 407a124..d2a0a83 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -275,6 +275,9 @@ struct mxs_lradc {
  #define        LRADC_CTRL4_LRADCSELECT_MASK(n)         (0xf << ((n) * 4))
  #define        LRADC_CTRL4_LRADCSELECT_OFFSET(n)       ((n) * 4)

+#define LRADC_RESOLUTION                       12
+#define LRADC_SINGLE_SAMPLE_MASK               ((1 << LRADC_RESOLUTION) - 1)
+
  static int mxs_lradc_read_single(struct iio_dev *iio_dev,
                         const struct iio_chan_spec *chan,
                         int *val, int *val2, long m)
@@ -737,9 +740,10 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
         __set_bit(EV_ABS, input->evbit);
         __set_bit(EV_KEY, input->evbit);
         __set_bit(BTN_TOUCH, input->keybit);
-       input_set_abs_params(input, ABS_X, 0, LRADC_CH_VALUE_MASK, 0, 0);
-       input_set_abs_params(input, ABS_Y, 0, LRADC_CH_VALUE_MASK, 0, 0);
-       input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_CH_VALUE_MASK, 0, 0);
+       input_set_abs_params(input, ABS_X, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
+       input_set_abs_params(input, ABS_Y, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
+       input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_SINGLE_SAMPLE_MASK,
+                            0, 0);

         lradc->ts_input = input;
         input_set_drvdata(input, lradc);
@@ -1014,7 +1018,7 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
         .address = (idx),                                       \
         .scan_type = {                                          \
                 .sign = 'u',                                    \
-               .realbits = 18,                                 \
+               .realbits = LRADC_RESOLUTION,                   \
                 .storagebits = 32,                              \
         },                                                      \
  }

Notice that I leave the existing LRADC_CH_VALUE_MASK 18bit mask in the rest of the 
driver, to support accumulated samples.
Curiously, ts_lib works fine without this (maybe the calibration fixes this?), but 
nevertheless the information passed by the driver is incorrect, I guess.
Is anybody out there working with the touch? Under which graphic system?

Best regards,
--
Hector Palacios
