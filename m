Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: [PATCH] staging:iio:adc: Add SPEAr ADC driver
Date: Thu, 12 Apr 2012 09:03:48 +0200
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree-discuss@ozlabs.org" <devicetree-discuss@ozlabs.org>,
 "spear-devel" <spear-devel@list.st.com>,
 Jonathan Cameron <jic23@cam.ac.uk>
References: <1334150388-23296-1-git-send-email-sr@denx.de> <4F867232.3070509@st.com>
In-Reply-To: <4F867232.3070509@st.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201204120903.48747.sr@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday 12 April 2012 08:12:02 Viresh Kumar wrote:
> On 4/11/2012 6:49 PM, Stefan Roese wrote:
> > +static int __devinit spear_adc_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np = pdev->dev.of_node;
> > +       struct spear_adc_info *info;
> > +       struct resource *res;
> > +       int retval = -ENODEV;
> > +       struct iio_dev *iodev = NULL;
> > +       int irq;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res) {
> > +               dev_err(&pdev->dev, "failed to get platform I/O
> > memory\n"); +               retval = -EBUSY;
> > +               goto errout1;
> > +       }
> > +
> > +       iodev = iio_allocate_device(sizeof(struct spear_adc_info));
> > +       if (!iodev) {
> > +               dev_err(&pdev->dev, "failed allocating iio device\n");
> > +               retval = -ENOMEM;
> > +               goto errout1;
> > +       }
> > +
> > +       info = iio_priv(iodev);
> > +       info->np = np;
> > +
> > +       /*
> > +        * SPEAr600 has a different register layout than other SPEAr
> > SoC's +        * (e.g. SPEAr3xx). Let's provide two register base
> > addresses +        * to support multi-arch kernels.
> > +        */
> > +       info->adc_base_spear6xx = ioremap(res->start,
> > resource_size(res)); +       if (!info->adc_base_spear6xx) {
> > +               dev_err(&pdev->dev, "failed mapping memory\n");
> > +               retval = -EBUSY;
> > +               goto errout2;
> > +       }
> 
> This must be a DT only driver and so you can use of_iomap() instead of
> ioremap() and platform_get_resource()

Yes, thanks for spotting.
 
> > +       info->adc_base_spear3xx =
> > +               (struct adc_regs_spear3xx *)info->adc_base_spear6xx;
> > +
> > +       info->clk = clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(info->clk)) {
> > +               dev_err(&pdev->dev, "failed getting clock\n");
> > +               goto errout3;
> > +       }
> 
> patch for devm_* variant of clk is also there.

Where is it? Is it already in "next"? Do you have a link for the patch?

> > +       clk_enable(info->clk);
> 
> clk_prepare() is required now, before enable.

Ahh, I didn't follow the clk updates lately. Will update.
 
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if ((irq < 0) || (irq >= NR_IRQS)) {
> > +               dev_err(&pdev->dev, "failed getting interrupt
> > resource\n"); +               retval = -EINVAL;
> > +               goto errout4;
> > +       }
> > +
> > +       retval = request_irq(irq, spear_adc_isr, 0, MOD_NAME, info);
> > +       if (retval < 0) {
> > +               dev_err(&pdev->dev, "failed requesting interrupt\n");
> > +               goto errout4;
> > +       }
> > +
> 
> can use devm_* variants wherever possible.

Okay.

Thanks,
Stefan
