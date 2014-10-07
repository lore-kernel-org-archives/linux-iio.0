Return-Path: <iivanov@mm-sol.com>
Message-ID: <1412682870.1027.58.camel@iivanov-dev>
Subject: Re: [PATCH v3] iio: iadc: Qualcomm SPMI PMIC current ADC driver
From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant
 Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Hartmut Knaack <knaack.h@gmx.de>, Fugang Duan <B38611@freescale.com>,  Lee
 Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-iio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
Date: Tue, 07 Oct 2014 14:54:30 +0300
In-Reply-To: <542FE207.2080508@kernel.org>
References: <1412180088-24683-1-git-send-email-iivanov@mm-sol.com>
	 <542FE207.2080508@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2014-10-04 at 13:03 +0100, Jonathan Cameron wrote:
> On 01/10/14 17:14, Ivan T. Ivanov wrote:
> > The current ADC is peripheral of Qualcomm SPMI PMIC chips. It has
> > 16 bits resolution and register space inside PMIC accessible across
> > SPMI bus.
> >
> > The driver registers itself through IIO interface.
> >
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> Looks good to me.  I would however like to wait for Mark Rutland to
> say whether he is happy with the bindings (and the rest if he
> feels like it ;)
> 
> Given the merge window will open shortly and hence the IIO merge
> window is long closed, we aren't in a particular rush at the moment.

Sure. Thank you.
Ivan

> 
> 
> Jonathan
