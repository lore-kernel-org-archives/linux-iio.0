Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35615 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbH0TQY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2015 15:16:24 -0400
Received: by igbjg10 with SMTP id jg10so1560337igb.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2015 12:16:24 -0700 (PDT)
Date: Thu, 27 Aug 2015 14:16:17 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Adding MAX1363 to BBB
Message-ID: <20150827191616.GA8285@deathstar>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4699@sfamail.SAKURAUS.LOCAL>
 <20150824165433.GA3398@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD498E@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD498E@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 27, 2015 at 12:10:06PM -0700, Greg Wilson-Lindberg wrote:
>  
> 
> > -----Original Message-----
> > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> > Of Michael Welling
> > Sent: Monday, August 24, 2015 9:55 AM
> > To: Greg Wilson-Lindberg
> > Cc: linux-iio@vger.kernel.org
> > Subject: Re: Adding MAX1363 to BBB
> > 
> > On Mon, Aug 24, 2015 at 09:26:53AM -0700, Greg Wilson-Lindberg wrote:
> > > I don't know if anybody on this list can answer this, we 
> > are going to add an IIO compatible Maxim MAX1363 4 channel 
> > ADC to our BBB cape and I am not sure how to specify in the 
> > dts file that it is connected to the I2C channel.
> > > If anyone can give me suggestions, it would be greatly appreciated.
> > >  
> > 
> > Give this a try:
> > 
> > &i2c1 {
> > 	status = "okay";
> > 
> > 	adc@34 {
> > 		compatible = "maxim,max1363";
> > 		vcc-supply = <&reg_3v3>;
> > 		reg = <0x34>;
> > 	};
> > };
> > 
> > This assume you have an i2c1 and reg_3v3 defined.
> > 
> > Here is a real example that looks like it uses the same driver:
> > http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx27-p
> > hytec-phycard-s-rdk.dts?v=3.14#L56
> > 
> 
> I've got the max1363 installed on a board and it is showing up as an I2C device, but not as an IIO device. I used your example above for the dts file.
> 
> Any thoughts?

Try using the following instead:
&i2c1 {
	status = "okay";

	adc@34 {
		compatible = "max1363";
		vcc-supply = <&reg_3v3>;
		reg = <0x34>;
	};
};

> 
> > 
> > > Greg Wilson-Lindberg
> > > Sakura Finetek
> > > 310-783-5075
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe 
> > linux-iio" 
> > > in the body of a message to majordomo@vger.kernel.org More 
> > majordomo 
> > > info at  http://vger.kernel.org/majordomo-info.html
> > 
