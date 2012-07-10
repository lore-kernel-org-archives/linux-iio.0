Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46599 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab2GJJ0t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jul 2012 05:26:49 -0400
From: Marek Vasut <marex@denx.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Tue, 10 Jul 2012 11:26:32 +0200
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <1341368129-20468-1-git-send-email-marex@denx.de> <201207091203.09371.marex@denx.de> <201207101120.52892.jbe@pengutronix.de>
In-Reply-To: <201207101120.52892.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201207101126.32778.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Juergen Beisert,

> Hi Marek,
> 
> > > When I try to compile
> > > your code I get:
> > > 
> > > drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error:
> > > linux/iio/triggered_buffer.h: No such file or directory
> > 
> > You need this patches:
> >     iio:kfifo_buf Take advantage of the fixed record size used in IIO
> >     iio: kfifo - add poll support.
> > 
> > And use latest -next.
> 
> Thanks for the hints. Now it compiles and the driver seems to work.
> 
> One thing I do not understand: It does not matter what channel I read
> ('in_voltage*_raw'), only interrupt 16 ('mxs-lradc-channel0') counts up.
> Intended?
> Or did I a mistake by adding interrupt numbers "<13 14 15 16 17 18 19 20 21
> 22 23 24 25>" to the corresponding device tree entry?


They're wrong

lradc@80050000 {
        compatible = "fsl,imx28-lradc";
        reg = <0x80050000 2000>;
        interrupts = <10 14 15 16 17 18 19
                        20 21 22 23 24 25>;
        status = "disabled";
};


> Regards,
> Juergen

Best regards,
Marek Vasut
