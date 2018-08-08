Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:42016 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbeHHMSp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Aug 2018 08:18:45 -0400
Date: Wed, 8 Aug 2018 10:59:05 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "leonard.crestez@intel.com" <leonard.crestez@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v4 3/6] regmap: Add regmap_noinc_read API [UNSCANNED]
Message-ID: <20180808095905.GG32322@imbe.wolfsonmicro.main>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
 <20180806143901.GP2414@sirena.org.uk>
 <1533569985.11050.9.camel@analog.com>
 <20180806160402.GR2414@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20180806160402.GR2414@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 06, 2018 at 05:04:02PM +0100, Mark Brown wrote:
> On Mon, Aug 06, 2018 at 03:39:53PM +0000, Popa, Stefan Serban wrote:
> > On Lu, 2018-08-06 at 15:39 +0100, Mark Brown wrote:
> 
> > > I suggested having an explicit operation to check if a register supports
> > > this mode of operation when I reviewed an earlier version, I didn't
> > > notice a reply on that?
> 
> > Sorry, I got confused about what needs to be done. Should I add a new field
> > to the regmap_config struct which will be checked during the function call?
> > Something like can_multi_write? How do you suggest it should be called? Is
> > readable_noinc_reg ok?
> 
> Like I said last time I'd suggest making it more like the readable and
> volatile checks - I'm fairly sure I've seen devices that don't
> autoincrement only for some registers.

I can confirm I have seen hardware that autoincrements for some
registers and not for others.

Thanks,
Charles
