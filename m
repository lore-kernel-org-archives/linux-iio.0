Return-Path: <SRS0=gyRF=YY=gmail.com=robherring2@kernel.org>
Date: Mon, 9 Jan 2017 23:35:43 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Allen Liu <liurenzhong@hisilicon.com>, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mark.rutland@arm.com, akinobu.mita@gmail.com,
	ludovic.desroches@atmel.com, krzk@kernel.org,
	vilhelm.gray@gmail.com, ksenija.stanojevic@gmail.com,
	zhiyong.tao@mediatek.com, daniel.baluta@intel.com,
	leonard.crestez@intel.com, ray.jui@broadcom.com,
	raveendra.padasalagi@broadcom.com, mranostay@gmail.com,
	amsfield22@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	xuejiancheng@hisilicon.com, kevin.lixu@hisilicon.com
Subject: Re: [PATCH] adc: add adc driver for Hisilicon BVT SOCs
Message-ID: <20170110053543.ir5alv727d23c6wm@rob-hp-laptop>
References: <1483784170-228765-1-git-send-email-liurenzhong@hisilicon.com>
 <41fbfc45-9f9a-c2cf-9c27-c4d5a39a400a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41fbfc45-9f9a-c2cf-9c27-c4d5a39a400a@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jan 07, 2017 at 12:51:31PM -0500, Jonathan Cameron wrote:
> On 07/01/17 05:16, Allen Liu wrote:
> > Add ADC driver for the ADC controller found on HiSilicon BVT SOCs, like Hi3516CV300, etc.
> > The ADC controller is primarily in charge of detecting voltage.
> > 
> > Reviewed-by: Kevin Li <kevin.lixu@hisilicon.com>
> > Signed-off-by: Allen Liu <liurenzhong@hisilicon.com>
> Hi Allen,
> 
> One quick submission process note first.  It is very important to clearly identify new
> versions of a patch and what changes have occurred since the previous posting.
> 
> So the email title should have been [PATCH V2] adc...
> 
> Also, below the --- please add a brief change log.
> 
> The driver is coming together nicely.  A few minor points inline.
> 
> Jonathan
> > ---
> >  .../devicetree/bindings/iio/adc/hibvt-lsadc.txt    |  23 ++
> >  drivers/iio/adc/Kconfig                            |  10 +
> >  drivers/iio/adc/Makefile                           |   1 +
> >  drivers/iio/adc/hibvt_lsadc.c                      | 335 +++++++++++++++++++++
> >  4 files changed, 369 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> >  create mode 100644 drivers/iio/adc/hibvt_lsadc.c
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> > new file mode 100644
> > index 0000000..fce1ff4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/hibvt-lsadc.txt
> > @@ -0,0 +1,23 @@
> > +Hisilicon BVT Low Speed (LS) A/D Converter bindings
> > +
> > +Required properties:
> > +- compatible: should be "hisilicon,<name>-lsadc"
> > +   - "hisilicon,hi3516cv300-lsadc": for hi3516cv300
> > +
> > +- reg: physical base address of the controller and length of memory mapped 
> > +	   region.
> > +- interrupts: The interrupt number for the ADC device.
> Ideally refer to the standard interrupt binding document.
> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> 
> > +
> > +Optional properties:
> > +- resets: Must contain an entry for each entry in reset-names if need support
> > +		  this option. See ../../reset/reset.txt for details.
> Don't use a relative path in a binding document. It's far too likely to
> be broken by a reorganization of the docs and cannot be grepped for.

However, in the filtered DT tree, the base path is already different. I 
haven't looked but I'm sure we have a mixture of different forms.

My preference would be just "reset/reset.txt" or ".../reset/reset.txt". 
We generally try to avoid bindings referring to other kernel docs, so 
this should be sufficient.

Rob
