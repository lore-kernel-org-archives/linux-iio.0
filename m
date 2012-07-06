Return-Path: <anish198519851985@gmail.com>
MIME-Version: 1.0
Date: Fri, 6 Jul 2012 17:30:52 +0530
Message-ID: <CAK7N6voPsDGJLoh71Kgcz=bnWDE4QYmXjOrMv0x+bN7RTCHF3g@mail.gmail.com>
Subject: adc-jack-driver opinion related to IIO
From: anish singh <anish198519851985@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

I would be extremely happy if I can get your opinion on this.

Recently Myungjoo Ham had posted Extcon: adc-jack driver patch.

Description of this driver:
This is basically a Headset(jack) driver.Once the headset is inserted
a irq_handler is called and in this handler we have a callback(this
callback calls into pmic driver to get the adc value) to get
the adc value to determine the kind of headset: This headset could
be headset with mic, headset without mic or headset with
keys(volume-up/down) attached to it.One we have found out the kind
of headset we use extcon framework to notify the other interested drivers or
userspace that a headset with so and so capabilities has been inserted.

Question:
Does this driver fall into IIO as pointed by Mark Brown in his review comments?

Why do we need to use IIO to get the adc value?As for different boards the
method of getting adc is different.How does IIO help in this?

Thanks for your time.
