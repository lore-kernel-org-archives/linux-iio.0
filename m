Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60447 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbbC1NuI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 09:50:08 -0400
Message-ID: <5516B18D.1070605@kernel.org>
Date: Sat, 28 Mar 2015 13:50:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Isak Lichtenstein <Isak.Lichtenstein@kistler.com>,
	"'linux-iio@vger.kernel.org'" <linux-iio@vger.kernel.org>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>
Subject: Re: TI-am335x-adc
References: <91B4C1B91AAEFD42AC985EA0F3D4E668010B98E15D@kihagwinex01.int.kistler.com> <91B4C1B91AAEFD42AC985EA0F3D4E668012B0BCFD1@kihagwinex01.int.kistler.com>
In-Reply-To: <91B4C1B91AAEFD42AC985EA0F3D4E668012B0BCFD1@kihagwinex01.int.kistler.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/15 10:40, Isak Lichtenstein wrote:
> 
> Hi everybody,
> 
> I've started using the TI-am335x-adc driver in continuous mode on our custom board with AM3359 and yocto-linux-standard 3.17 and get a weird behavior when testing it using generic_buffer.c
> 
> Every now and then channel 0 seems to contain the value of channel 1, see the attached output of the following command: ./genericBuffer -n TI-am335x-adc -l 128 -c 100 ( I've added tabs to make it more readable).
> 
> 
> Is this a driver bug ( maybe already patched after 3.17 ), or is my board not properly configured?
> 
> I'm not using the TSC and my device tree is configured as follows:
> 
> #include "am33xx.dtsi"
> 
> &tscadc {
>             status = "okay";
>             /*
>             tsc {
>                         ti,wires = <4>;
>                         ti,x-plate-resistance = <200>;
>                         ti,coordinate-readouts = <5>;
>                         ti,wire-config = <0x00 0x11 0x22 0x33>;
>             };
>             */
> 
>             adc {
>                         ti,adc-channels = <0 1 2 3 4 5 6 7>;
>             };
> };
> 
> 
> Thanks in advance for your advice.
> 
> Best regards
> 
> Isak Lichtenstein
> 
Zubair, any thought on this?
(or anyone else for that matter!)


