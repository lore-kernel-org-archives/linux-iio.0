Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37344 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbbHXQyo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2015 12:54:44 -0400
Received: by igui7 with SMTP id i7so60569151igu.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2015 09:54:44 -0700 (PDT)
Date: Mon, 24 Aug 2015 11:54:34 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Adding MAX1363 to BBB
Message-ID: <20150824165433.GA3398@deathstar>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4699@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4699@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 24, 2015 at 09:26:53AM -0700, Greg Wilson-Lindberg wrote:
> I don't know if anybody on this list can answer this, we are going to add an IIO compatible Maxim MAX1363 4 channel ADC to our BBB cape and I am not sure how to specify in the dts file that it is connected to the I2C channel.
> If anyone can give me suggestions, it would be greatly appreciated.
>  

Give this a try:

&i2c1 {
	status = "okay";

	adc@34 {
		compatible = "maxim,max1363";
		vcc-supply = <&reg_3v3>;
		reg = <0x34>;
	};
};

This assume you have an i2c1 and reg_3v3 defined.

Here is a real example that looks like it uses the same driver:
http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts?v=3.14#L56


> Greg Wilson-Lindberg
> Sakura Finetek
> 310-783-5075
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
