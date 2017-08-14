Return-Path: <SRS0=L3dC=7Q=it-klinger.de=ak@kernel.org>
Date: Mon, 14 Aug 2017 12:39:18 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: srf08: add device tree binding for srf02 and
 srf10
Message-ID: <20170814103918.GB3062@imap.1und1.de>
References: <20170814085941.GA9759@arbeit>
 <20170814091106.rvdvebcxfbpggmjd@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170814091106.rvdvebcxfbpggmjd@ninjato>
List-ID: <linux-iio@vger.kernel.org>

Wolfram Sang <wsa@the-dreams.de> schrieb am Mon, 14. Aug 11:11:
> On Mon, Aug 14, 2017 at 10:59:41AM +0200, Andreas Klinger wrote:
> > add trivial device tree binding "devantech,srf02" and "devantech,srf10"
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
> 
> Again: This file has moved since v4.12-rc1. Please rebase to v4.12 or
> even v4.13-rc5.
> 

Then i split the patch series up in two parts:
- patch with only device tree binding against >= v4.12
- everything else as patch series against git tree of IIO

Ok?

Andreas

-- 
