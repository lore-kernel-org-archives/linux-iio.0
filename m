Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1435663602-29868-2-git-send-email-martink@posteo.de>
References: <1435663602-29868-1-git-send-email-martink@posteo.de>
	<1435663602-29868-2-git-send-email-martink@posteo.de>
Date: Tue, 30 Jun 2015 14:49:45 +0300
Message-ID: <CAEnQRZCKkztOc1y4x3mJAakYewDUB52yVd7C03N9eRX=vrrOvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: mma8452: add support for 3 more accelerometer chips
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>,
	christoph.muellner@theobroma-systems.com,
	martin.kepplinger@theobroma-systems.com, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jun 30, 2015 at 2:26 PM, Martin Kepplinger <martink@posteo.de> wrote:
> The one that supports the existing event interrupt settings, uses it. The
> others use their motion detection interrupts.
>
> This is tested on the MMA8653FC.

Would be nice to explicitly add here the names of the new supported
chips, together with link to their datasheets (if available).

thanks,
Daniel.
