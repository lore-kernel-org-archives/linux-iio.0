Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] staging:iio:adc: Add SPEAr ADC driver
Date: Thu, 12 Apr 2012 08:01:04 +0200
Cc: linux-iio@vger.kernel.org,
 devicetree-discuss@ozlabs.org,
 spear-devel@list.st.com,
 Viresh Kumar <viresh.kumar@st.com>
References: <1334150388-23296-1-git-send-email-sr@denx.de> <4F8589E4.7020809@cam.ac.uk>
In-Reply-To: <4F8589E4.7020809@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201204120801.05269.sr@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Wednesday 11 April 2012 15:40:52 Jonathan Cameron wrote:
> On 4/11/2012 2:19 PM, Stefan Roese wrote:
> > This patch implements the basic single data conversion support for
> > the SPEAr600 SoC ADC. The register layout of SPEAr600 differs a bit
> > from other SPEAr SoC variants (e.g. SPEAr3xx). These differences are
> > handled via DT compatible testing. Resuling in a multi-arch binary.
> 
> Resulting
> 
> > This driver is currently tested only on SPEAr600. Futur patches may add
> > support for other SoC variants (SPEAr3xx) and features like software
> > buffer or DMA.
> 
> Future
> 
> Ironically that's about it wrt to comments. Couple of totally trivial
> bits inline.
> Basically I'm happy, so if/when someone acks the device tree side of
> things, please
> clean up the trivial bits and send on to GregKH.
> 
> Nice short, clean driver.  The small line count lured me into reviewing
> it ahead of
> some others in my review pile!

Jonathan, thanks for the quick review. I'll address you comments and send an 
updated patch shortly.

Stefan
