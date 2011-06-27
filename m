Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4E084A4E.2020704@iis.fraunhofer.de>
Date: Mon, 27 Jun 2011 11:15:58 +0200
From: ManuelStahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Dummy device driver
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

as we have so many changes happening right now, I feel the need for 
something like a reference driver. One that uses the most recent IIO 
functions as they are intended.
This should be a dummy device that does not talk to real hardware, so we 
can use it on common x86 platforms.

What do you think?

Regards,
Manuel
