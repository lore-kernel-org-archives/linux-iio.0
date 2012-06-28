Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: i.MX28 die temperature
Date: Thu, 28 Jun 2012 17:42:47 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
 linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com> <201206271433.15303.jbe@pengutronix.de> <201206280505.41201.marex@denx.de>
In-Reply-To: <201206280505.41201.marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201206281742.47936.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Marek Vasut,

> Dear Juergen Beisert,
> 
> [...]
> 
> So, I've been thinking about mapping channels and delay slots at runtime.
> Is it really necessary? I know it's really cool and all, but it adds a lot
> of complexity. For starters, I was thinking we should try to do static
> mapping. And when that's all perfected, go further and try doing it
> dynamically. What do you think about the following DT binding:
> 
> lradc@80050000 {
>         compatible = "fsl,imx28-lradc";
>         reg = <0x80050000 2000>;
>         interrupts = <10 14 15 16 17 18 19
>                         20 21 22 23 24 25>;
>         fsl,delay-freq = <10 100 50 60>;
>         fsl,delay-repeat = <3 10 5 6>;
>         fsl,delay-channels = <
>                 0 2 0 3 0 4 0 5
>                 1 8 1 9 2 12 3 13>;


btw. I don't like the idea of those tuples here ... any hint how to do it 
better?

>         status = "disabled";
> };
> 
> fsl,delay-freq would be an array (for all four delay channels) of their
> sampling frequencies.
> 
> fsl,delay-repeat would be an array (for all four delay channels) of the
> oversampling count.
> 
> fsl,delay-channels would be an array (for all four delay channels) of
> touples of delay channel, adc channel. In the above example, it's ADC
> channels 2,3,4,5 mapped to delay channel 0, ADC channels 8,9 mapped to
> delay channel 1 etc.
> 
> Now, it might be dumb, advice is welcome!
> 
> > > [...]
> > 
> > Regards,
> > Juergen
> 
> Best regards,
> Marek Vasut

Best regards,
Marek Vasut
