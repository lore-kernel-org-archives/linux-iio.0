Return-Path: <SRS0=zsS4=7S=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v3 0/5] iio: srf08: add support for similar devices and
 triggered buffers
To: Andreas Klinger <ak@it-klinger.de>, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20170816193257.GA24393@arbeit>
From: Peter Rosin <peda@axentia.se>
Message-ID: <823ea9d0-0410-2d6d-813b-686582656d68@axentia.se>
Date: Wed, 16 Aug 2017 22:14:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170816193257.GA24393@arbeit>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 2017-08-16 21:32, Andreas Klinger wrote:
> This patch series adds support for:
> - triggered buffer
> - ultrasonic devices srf02 and srf10
> 
> Thanks for the review of Peter and Wolfram.
> 
> @Wolfram: please let me know, if you want a separate patch for [PATCH 1/5]

I think what you should do is rebase to something fresher, such as the
togreg branch in the iio repo. As you have discovered, master branch is
lagging behind in that repo.

And I think Jonathan would like that as well, but perhaps it doesn't
make a difference for him?

Cheers,
peda
