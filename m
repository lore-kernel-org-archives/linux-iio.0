Return-Path: <bigeasy@linutronix.de>
Date: Tue, 4 Jun 2013 12:27:14 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 15/19] input/ti_am335x_tsc: tiny cleanup
Message-ID: <20130604102714.GE1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-16-git-send-email-bigeasy@linutronix.de>
 <51AB85A0.4040004@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51AB85A0.4040004@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

* Jonathan Cameron | 2013-06-02 18:49:20 [+0100]:

>On 05/27/2013 08:12 PM, Sebastian Andrzej Siewior wrote:
>> Things that can be done to done without using make up:
>That causes some amusing images of code with lipstick ;)  'wake up' perhaps?

Well, make up is usually used to cover up for the bad looks. In that
case, the code passed checkpatch but looks ugly as hell so it had to use
some kind of make to get through the review process :) This patch tries
to clean that code so the make up is not required any more.

Sebastian
