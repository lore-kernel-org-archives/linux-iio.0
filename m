Return-Path: <harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jul 2013 21:43:49 +0200
From: <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: <linux-iio@vger.kernel.org>
Subject: Re: humidity sensors
In-Reply-To: <500695c3-bb30-46e7-8fab-3ba32a01a246@email.android.com>
References: <E1UwWkL-0000pI-8V@stardust.g4.wien.funkfeuer.at> <51DC4FE0.1080402@kernel.org> <E1Uwfov-0000cI-Mb@stardust.g4.wien.funkfeuer.at> <500695c3-bb30-46e7-8fab-3ba32a01a246@email.android.com>
Message-ID: <5bb3a4a786b9e02708d0b5dfeb7f570c@imap.cosmopool.net>
List-ID: <linux-iio@vger.kernel.org>

On Wed, 10 Jul 2013 10:46:50 +0100, Jonathan Cameron <jic23@kernel.org>
wrote:
> Harald Geyer <harald@ccbib.org> wrote:
>>I didn't look into this in detail yet, but porting the driver to
>>hwmon probably isn't much more work than adding humidity
>>support to IIO. Which way do you prefer?
> 
> I don't really mind but as they have been controversial in hwmon perhaps
> iio is a better bet.

Ok, so I'll prepare a patch to add humidity support and update the
dht11-gpio driver accordingly.

One (hopefully) last question: Into which subdirectory should the
dht11-gpio driver (temperature and humidity) go?

Harald
