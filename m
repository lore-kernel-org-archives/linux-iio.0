Return-Path: <bigeasy@linutronix.de>
Message-ID: <52B405E9.2020304@linutronix.de>
Date: Fri, 20 Dec 2013 09:55:05 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Zubair Lutfullah : <zubair.lutfullah@gmail.com>
CC: Lee Jones <lee.jones@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mfd: input: iio: ti_amm335x: Rework TSC/ADC synchronization
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de> <1387466911-3732-6-git-send-email-bigeasy@linutronix.de> <20131219190126.GA5123@gmail.com> <52B3FC6C.1070105@linutronix.de> <20131220033634.GB2596@gmail.com>
In-Reply-To: <20131220033634.GB2596@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/20/2013 04:36 AM, Zubair Lutfullah : wrote:
> Indeed, due to the separation of TSC/ADC drivers, getting
> them both to work simultaneously without fault is tricky.

The race window which leads to the lockup is (as I believe) when the
hardware is finishing its work for the TSC (pre interrupt) and the ADC
parts writes to the SE register. As long as you allow both parts to
write to the register bad things can happen (as it seems). So it does
not matter if you have two drivers or one :)

> Thanks
> Zubair
> 

Sebastian
