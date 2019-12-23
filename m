Return-Path: <SRS0=L16q=2N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F5CC2D0C0
	for <linux-iio@archiver.kernel.org>; Mon, 23 Dec 2019 17:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A7420715
	for <linux-iio@archiver.kernel.org>; Mon, 23 Dec 2019 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577121107;
	bh=obUXnfW3yzAW4mgWD9hdniGqKUSMLHPVaPXbFAwqpa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vvOjQIsJ2na6p9nhbMtwexXEBfcT0WtxISsPt6yf9ga5rUWk0iomGvQoM5OFCwbAp
	 1yGNIWIoPkVGzwhE/OuUUzJsG3qAPJoBYYfyQF3XmKoEN+mI+1XQKZkCpEU4W5QG6k
	 IaFHaWLepse6csqKpIC67fA3gg7UrbHupfYCygd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWRLq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWRLq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:11:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4BD220663;
        Mon, 23 Dec 2019 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577121105;
        bh=obUXnfW3yzAW4mgWD9hdniGqKUSMLHPVaPXbFAwqpa8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D6iOqX1dIeDAUApxyHJIaJZWDnfKV+s3ymAywU357pHO905FAqXmvhbEqsck0BBPn
         wd5tSVhN8fnQwZZ49G3Nul5DvOthKEYHGbpbUSsbYip2sAlCL3qPLuOo0wdZDNVLYA
         p5zpcmnSGzdZ7mQXsUrnJ5A/yK5XT6DFIgpiYhME=
Date:   Mon, 23 Dec 2019 17:11:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Device tree bindings for TI HDC20x0 humidity and
 temperature sensors
Message-ID: <20191223171140.55f6ce8b@archlinux>
In-Reply-To: <05D5E061-47A3-4446-BC4C-558B2DA054D3@norphonic.com>
References: <B0A4F7BA-0D41-4DA0-985E-F2603D66C48F@norphonic.com>
        <05D5E061-47A3-4446-BC4C-558B2DA054D3@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Dec 2019 15:57:30 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

Hi Eugene,

There is a bit of a movement to asking for power supplies being
described in dt bindings from the start. I'm not insisting on it
as it is easy to add later and always backwards compatible.
(if you don't need to describe a regulator from the start, then it
must always be on so a stub regulator will be fine).

Otherwise looks good to me, but dt bindings should always be cc'd to
the devicetree mailing list and maintainers.   See the MAINTAINERS
file for the email addresses.  For a simple binding there is a bit
of latitude for maintainers to take them without an explicit
review (to keep the DT maintainers sane!) but we always like to
give them the opportunity to comment.  As Rob and Mark will confirm
I'm far from always right in my reviews of these!

Thanks,

Jonathan




> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> 
> diff -uprN linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010 linux-5.3.8_docs/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
> --- linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	2019-12-02 11:09:25.803326999 +0100
> @@ -0,0 +1,9 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
> +KernelVersion:	5.3.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Controls the heater device within the humidity sensor to get
> +		rid of excess condensation.
> +
> +		Valid control values are 0 = OFF, and 1 = ON.
> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/hdc2010.yaml	2019-12-02 08:43:32.508277082 +0100
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/hdc2010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDC2010/HDC2080 humidity and temperature iio sensors
> +
> +maintainers:
> +  - Eugene Zaikonnikov <eugene.zaikonnikov@norophonic.com>
> +
> +description: |
> +  Relative humidity and tempereature sensors on I2C bus
> +
> +  Datasheets are available at:
> +    http://www.ti.com/product/HDC2010/datasheet
> +    http://www.ti.com/product/HDC2080/datasheet
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,hdc2010
> +      - ti,hdc2080
> +
> +  interrupts:
> +    description:
> +      interrupt mapping for IRQ
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      hdc200x@40 {
> +          compatible = "ti,hdc2010";
> +          reg = <0x40>;
> +      };
> +    };
> 

