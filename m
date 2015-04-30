Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1430404069.2525.112.camel@hadess.net>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
	<1430298111-20127-3-git-send-email-ao2@ao2.it>
	<CAEnQRZANgZM8in1WS_22Lcpf2oG_8aLO80p__=6CFJBbW2rHKA@mail.gmail.com>
	<20150430162552.f42e3caa42a44a7e04204d8e@ao2.it>
	<1430404069.2525.112.camel@hadess.net>
Date: Thu, 30 Apr 2015 18:05:22 +0300
Message-ID: <CAEnQRZBr4qq-JQ7OJ5iQb8d5B5MutiwdB-6HYLoDppByVX_xFg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: rename is_smo8500_device to polling_mode
From: Daniel Baluta <daniel.baluta@intel.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Antonio Ospite <ao2@ao2.it>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 30, 2015 at 5:27 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2015-04-30 at 16:25 +0200, Antonio Ospite wrote:
>> It was mainly to prevent error messages being printed in the logs
>> when
>> trying to getting a gpio descriptor, is that correct Bastien?
>
> Actually, to prevent it failing to init the driver altogether.

This is not true :).

I agree with Antonio :), this is just a hack to avoid this error message:

""acpi gpio get index failed"

The initial patch introducing is_smo8500_device shouldn't have been
merged from start :) but it was Jonathan's decision :).

See: http://marc.info/?l=linux-iio&m=141520240809938&w=2

I think dropping patch 2/3 is the best option for now.

thanks,
Daniel.
