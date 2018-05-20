Return-Path: <SRS0=k4mS=IH=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Sun, 20 May 2018 22:21:03 +0800
Message-ID: <CAJCx=g=9XoXygjdQ9r410jerbtDxOvUtN0a+KAdnj2OAb_1WGg@mail.gmail.com>
Subject: [RFC] Spectral ID sensor + floating point questions
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Jonathan et all,

Currently looking at ams AS7262 Spectral ID sensor, and thinking about
adding support to enable a project I'm working on.

But I noticed it is a bit odd in that outputs data for the 6 color
channels in either a) raw 16-bit ADC values b) or calibration adjusted
values (factory calibration) but are presented as 32-bit single
precision floats.

Clearly the latter data is  much more useful but of course it is a
floating point which isn't exactly the ideal in the kernel and there
isn't a precedent in iio (that I know of) for such values.

Datasheet: https://www.mouser.com/ds/2/588/AS7262_DS000486_2-00-1082195.pdf

Any thoughts, or suggestions?

Thanks,

Matt
