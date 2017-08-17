Return-Path: <SRS0=c8Q6=7T=gmail.com=robherring2@kernel.org>
Date: Thu, 17 Aug 2017 17:17:58 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, wsa@the-dreams.de, mark.rutland@arm.com,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: srf08: add device tree binding for srf02 and
 srf10
Message-ID: <20170817221758.qjxdqgznq4enj6yl@rob-hp-laptop>
References: <20170816193323.GA24405@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170816193323.GA24405@arbeit>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Aug 16, 2017 at 09:33:23PM +0200, Andreas Klinger wrote:
> add trivial device tree binding "devantech,srf02" and "devantech,srf10"
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
>  1 file changed, 2 insertions(+)

I thought this was mentioned in the prior versions, but this file has 
moved. Rebase to 4.13. Please send trivial-devices.txt changes 
separately to me.

Rob
