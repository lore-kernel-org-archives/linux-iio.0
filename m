Return-Path: <SRS0=oppv=BF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C4DC433E0
	for <linux-iio@archiver.kernel.org>; Sun, 26 Jul 2020 12:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB3B2065F
	for <linux-iio@archiver.kernel.org>; Sun, 26 Jul 2020 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595767864;
	bh=Tiy4JSgM4TpbyNf0slTi9UaPjGZNDHxnwqMnKUaMZss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nR689XV8Dw/Xh1iKBNGzq8xpKwHjvOZLN1Mt/IsfbaE8lZtgqkyg61kQDTx4guipt
	 DajDGZYR1X2dYy6bDLZnP7uNWAiabu/tSEcl8Vkinh7L4TsyJZcoj4/97Pa8thd4rO
	 iX7D+AKCa+Lcja/2IZQtBZ79UjvmKTG595c6IPoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGZMvD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 26 Jul 2020 08:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGZMvD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:51:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A3B2065E;
        Sun, 26 Jul 2020 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595767863;
        bh=Tiy4JSgM4TpbyNf0slTi9UaPjGZNDHxnwqMnKUaMZss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=00B5D0t9pMPSfc7RlCO3d7GBDmTYzO4D1+hR4pZMlhJN1b48jvUBYH+1JI7IEbha9
         2tS10Kts27OogQs4aILr2uCngJHdoMsvzgIW6VIMAjUaehP368PzVc164hGUVqi5RN
         Uj7uV7SJXnfV7XxAXcQaHBzy6IjbWnciooR5prb0=
Date:   Sun, 26 Jul 2020 13:50:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Pop, Cristian" <Cristian.Pop@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] one-bit-adc-dac: Add initial version of one bit
 ADC, DAC
Message-ID: <20200726135059.1234aa71@archlinux>
In-Reply-To: <SN2PR03MB2317AC79D13C3A89882534F4E7770@SN2PR03MB2317.namprd03.prod.outlook.com>
References: <20200716072737.9535-1-cristian.pop@analog.com>
        <9bd0363c-e8fb-a36f-a107-0afd8f7851d0@metafoo.de>
        <20200720145225.4f5d552b@archlinux>
        <SN2PR03MB2317AC79D13C3A89882534F4E7770@SN2PR03MB2317.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

..
> >   
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	for (i = 0; i < num_ch; i++) {
> > > > +		channels[i] = (struct  
> > iio_chan_spec)ONE_BIT_ADC_DAC_CHANNEL(i +  
> > > > +							offset,
> > > > +							direction);
> > > > +		channels[i].extend_name = gpio_names[i];  
> > > I think we want to avoid using extend_name in new drivers because it
> > > makes for a very clumsy ABI. We should add a label property like we
> > > have for the device for channels to have a symbolic name of the channel.  
> The current dts looks like this:
> one-bit-adc-dac@0 {
> 				in-gpios = <&gpio 17 0>, <&gpio 27 0>;
> 				in-gpio-names = "i_17", "i_27";
> 				out-gpios = <&gpio 23 0>, <&gpio 24 0>;
> 				out-gpio-names = "o_23", "o_24";
> 			};
> Resulting in channels:
> in_voltage0_i_17_raw
> in_voltage1_i_27_raw
> out_voltage2_o_23_raw
> out_voltage3_o_24_raw
> If we want to lose extend_name, please provide an example for using labels.
> How the dts should look like, how do I use it in the driver?

Doesn't exist yet :)  Proposal was to add support for a label attribute
to the iio core.

If we were going to do a generic binding it would have to be part of the
existing channel bindings. e.g.
Documentation/devicetree/bindings/iio/adc/adc.txt

But here it might be fine to use the gpio-names to fill one in.
Alternative would be to use a binding where the gpio was specified
as part of the per channel child nodes rather than as a single entry.



