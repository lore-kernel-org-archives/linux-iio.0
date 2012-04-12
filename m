Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:36688 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753849Ab2DLIlz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Apr 2012 04:41:55 -0400
Message-ID: <4F8694EF.6080907@st.com>
Date: Thu, 12 Apr 2012 14:10:15 +0530
From: Viresh Kumar <viresh.kumar@st.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree-discuss@ozlabs.org" <devicetree-discuss@ozlabs.org>,
	spear-devel <spear-devel@list.st.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] staging:iio:adc: Add SPEAr ADC driver
References: <1334219819-2260-1-git-send-email-sr@denx.de>
In-Reply-To: <1334219819-2260-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/12/2012 2:06 PM, Stefan Roese wrote:
> +static int __devinit spear_adc_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct spear_adc_info *info;
> +       struct iio_dev *iodev = NULL;
> +       int ret = -ENODEV;
> +       int irq;
> +
> +       iodev = iio_allocate_device(sizeof(struct spear_adc_info));
> +       if (!iodev) {
> +               dev_err(&pdev->dev, "failed allocating iio device\n");
> +               ret = -ENOMEM;
> +               goto errout1;
> +       }
> +
> +       info = iio_priv(iodev);
> +       info->np = np;
> +
> +       /*
> +        * SPEAr600 has a different register layout than other SPEAr SoC's
> +        * (e.g. SPEAr3xx). Let's provide two register base addresses
> +        * to support multi-arch kernels.
> +        */
> +       info->adc_base_spear6xx = of_iomap(np, 0);
> +       if (!info->adc_base_spear6xx) {
> +               dev_err(&pdev->dev, "failed mapping memory\n");
> +               ret = -ENOMEM;
> +               goto errout2;
> +       }
> +       info->adc_base_spear3xx =
> +               (struct adc_regs_spear3xx *)info->adc_base_spear6xx;
> +
> +       info->clk = clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(info->clk)) {
> +               dev_err(&pdev->dev, "failed getting clock\n");
> +               goto errout3;
> +       }
> +
> +       ret = clk_prepare(info->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed preparing clock\n");
> +               goto errout3;
> +       }
> +
> +       ret = clk_enable(info->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed enabling clock\n");
> +               goto errout3;
> +       }
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if ((irq < 0) || (irq >= NR_IRQS)) {
> +               dev_err(&pdev->dev, "failed getting interrupt resource\n");
> +               ret = -EINVAL;
> +               goto errout4;
> +       }
> +
> +       ret = request_irq(irq, spear_adc_isr, 0, MOD_NAME, info);

devm_ ??

Otherwise: 

Acked-by: Viresh Kumar <viresh.kumar@st.com>
