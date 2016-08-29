Return-Path: <stillcompiling@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
From: Joshua Clayton <stillcompiling@gmail.com>
Subject: iio channel sync
Message-ID: <4284e190-84c2-07cc-1157-ef6d2fdd0e8c@gmail.com>
Date: Mon, 29 Aug 2016 10:03:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Jonathan,

I have an out-of tree driver I am working on mainlining. 

The device is a sensor that gets phase and amplitude (x and y) data

on multiple physical and/or time multiplexed channels.

It also has up to 4 optical encoders to get physical location.

The existing driver bundles x and y together with a snapshot

of the encoder sums at that moment.


This seems like a good fit for iio, but one item is bothering me.

How is synchronization between streams usually handled with

iio drivers? Timing can be important.

Joshua Clayton
