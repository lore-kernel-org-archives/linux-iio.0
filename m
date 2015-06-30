Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 30 Jun 2015 13:39:10 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Martin Kepplinger <martink@posteo.de>
cc: jic23@kernel.org, christoph.muellner@theobroma-systems.com,
    martin.kepplinger@theobroma-systems.com, devicetree@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: mma8452: add support for 3 more devices
In-Reply-To: <1435663602-29868-1-git-send-email-martink@posteo.de>
Message-ID: <alpine.DEB.2.02.1506301336410.12832@pmeerw.net>
References: <1435663602-29868-1-git-send-email-martink@posteo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Martin,

> The first patch doesn't change anything for existing users of mma8452. Please
> test this if you can!

nice to see the driver improved!
the first patch does quite I bit more than it claims; it's not only
adding more device, I'd prefer the patch split up for review
 
> The second patch corrects how interrupts are described as IIO events. It exists
> seperately because it changes the driver's behaviour for existing users of
> mma8452.

what is the difference?

thanks, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
