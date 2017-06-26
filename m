Return-Path: <SRS0=oBiA=57=microchip.com=Eugen.Hristev@kernel.org>
To: <jic23@kernel.org>, <linux-iio@vger.kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: Guidelines for ADC resistive touchscreen
CC: <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>
Message-ID: <073067e9-4c8e-32f1-d68c-8fb10682a8f3@microchip.com>
Date: Mon, 26 Jun 2017 13:05:01 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

I want to kindly ask for some advice regarding the support for our
resistive touchscreen over ADC for SAMA5D2 SoC.

The ADC block supports both classic ADC and can use 4/5 channels
for a connected resistive touchscreen measurements.
A MFD driver works ok, but I was considering doing it a little
bit better (or different, that is).

One idea that comes to my mind is to change the channel exposure
for the ADC towards the subsystem and add distance or another type of
channel (perhaps a x-y mod ?) and pressure channels, and then report
events on those channels using the event system from the iio.

This way, the touchscreen input driver would be minimal and register
to the events and report them to the input subsystem (The ADC
driver would handle the register settings, continuous trigger start,
touchscreen IRQ, retrieving the data from the touch, and then report
them as events).

This can also include exposing the continuous trigger for touch sampling
and the channels as digital values and let the touchscreen driver
register them as a consumer for the trigger.

Or you think a MFD driver is still the best idea, and divide the
register settings between the two subdrivers ? (and have the common
grounds like regulators in the MFD driver)

I see some other drivers have an input device registered directly
from the iio driver. Is that still applicable ?

Any insight is appreciated and thanks,
Eugen
