Return-Path: <hadess@hadess.net>
Message-ID: <1430404069.2525.112.camel@hadess.net>
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: rename is_smo8500_device to
 polling_mode
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ao2@ao2.it>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, "linux-iio@vger.kernel.org"
	 <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Date: Thu, 30 Apr 2015 16:27:49 +0200
In-Reply-To: <20150430162552.f42e3caa42a44a7e04204d8e@ao2.it>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
	 <1430298111-20127-3-git-send-email-ao2@ao2.it>
	 <CAEnQRZANgZM8in1WS_22Lcpf2oG_8aLO80p__=6CFJBbW2rHKA@mail.gmail.com>
	 <20150430162552.f42e3caa42a44a7e04204d8e@ao2.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2015-04-30 at 16:25 +0200, Antonio Ospite wrote:
> It was mainly to prevent error messages being printed in the logs 
> when
> trying to getting a gpio descriptor, is that correct Bastien?

Actually, to prevent it failing to init the driver altogether.
