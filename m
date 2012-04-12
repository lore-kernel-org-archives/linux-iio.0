Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] staging:iio:adc: Add SPEAr ADC driver
Date: Thu, 12 Apr 2012 10:15:34 +0200
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree-discuss@ozlabs.org" <devicetree-discuss@ozlabs.org>,
 "spear-devel" <spear-devel@list.st.com>,
 Jonathan Cameron <jic23@cam.ac.uk>
References: <1334150388-23296-1-git-send-email-sr@denx.de> <201204120903.48747.sr@denx.de> <4F868739.9050100@st.com>
In-Reply-To: <4F868739.9050100@st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201204121015.34257.sr@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday 12 April 2012 09:41:45 Viresh Kumar wrote:
> On 4/12/2012 12:33 PM, Stefan Roese wrote:
> >> > patch for devm_* variant of clk is also there.
> > 
> > Where is it? Is it already in "next"? Do you have a link for the patch?
> 
> Probably not in next till now.
> 
> https://lkml.org/lkml/2012/4/1/56

I just checked, it's not in "next". IIUC, there should be an updated patch 
version for this coming soon. So basing my patch on this one seems a bit too 
early from my point of view. Perhaps its best to update all iio drivers, once 
this devm_clk_* stuff in really available.

Thanks,
Stefan
