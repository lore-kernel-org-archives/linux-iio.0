Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43602 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab3FLOCO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jun 2013 10:02:14 -0400
Message-ID: <51B87F58.9070000@linutronix.de>
Date: Wed, 12 Jun 2013 16:02:00 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Samuel Ortiz <sameo@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Lee Jones <lee.jones@linaro.org>,
	=?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>,
	Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de> <20130611142358.GG29135@zurbaran> <20130611160415.GA379@core.coreip.homeip.net> <20130611161506.GK29135@zurbaran> <1565f2fb-7f16-4910-8fa2-cd5700e8986d@email.android.com> <20130611175519.GL29135@zurbaran> <51B877C7.8080001@linutronix.de> <20130612135042.GO29135@zurbaran>
In-Reply-To: <20130612135042.GO29135@zurbaran>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/12/2013 03:50 PM, Samuel Ortiz wrote:
> Hi Sebastian,

Hi Samuel,

>> By keep the regmap code you mean I am allowed to remove the regmap
>> usage in mfd (keep patch #1) or do you insist on adding its usage in
>> iio and input?
> I insist on keeping it on the MFD driver, i.e. _not_ keeping patch #1.

This forces me redo a few things and most likely adding it to the
iio and input driver to be consistent here.

Could you please give a reason why using the regmap here is a good
thing? I mentioned a few why it is not and why is better to leave it
out.

> Cheers,
> Samuel.

Sebastian
