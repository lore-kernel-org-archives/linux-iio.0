Return-Path: <bigeasy@linutronix.de>
Message-ID: <520E0307.70704@linutronix.de>
Date: Fri, 16 Aug 2013 12:46:31 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Zubair Lutfullah <zubair.lutfullah@gmail.com>, jic23@cam.ac.uk,
 dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, Russ.Dill@ti.com
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and trigger
 support
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com> <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com> <520CBEC6.8010400@kernel.org> <20130816100702.GD26895@linutronix.de> <520E0E22.4000403@kernel.org>
In-Reply-To: <520E0E22.4000403@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 08/16/2013 01:33 PM, Jonathan Cameron wrote:
> Ah, fixes-togreg is for this cycle, whereas new stuff like this needs
> to go on the togreg branch.  Hence please rebase on the togreg branch
> instead.

But he needs "iio: ti_am335x_adc: Fix wrong samples received on 1st
read" from that branch. How should the rebase be done?

> 
> That would explain it.

Sebastian
