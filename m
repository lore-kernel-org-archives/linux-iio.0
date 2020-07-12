Return-Path: <SRS0=WZ3W=AX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A775AC433E0
	for <linux-iio@archiver.kernel.org>; Sun, 12 Jul 2020 10:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8262820725
	for <linux-iio@archiver.kernel.org>; Sun, 12 Jul 2020 10:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594551566;
	bh=m2ldq/P6eHCKFhsuxxrh5YUDTHV4+XhlQ3ie/UGHytY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VQWbZqcp+cQWdzklNvpsaxe59aP5Iy/CJ6SmrO4j1fZ6kjXagtdeVJDUhmWeghwws
	 kamLB6AKzSnsATpwSh4JeDz0UL+KRpWlFXDe+zAvOk5byq0vcK1Pt0ZOtx8Wr+yDjD
	 DRtfQjNMApHqj8Qk53x1Tj/aX/sepOCWxCTxzoCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgGLK7Z (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Jul 2020 06:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgGLK7Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 06:59:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3831420720;
        Sun, 12 Jul 2020 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594551564;
        bh=m2ldq/P6eHCKFhsuxxrh5YUDTHV4+XhlQ3ie/UGHytY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nnDVnbU7ES+2e9H77biTNBg1l0d6WFJsQYIUb4CiY9yr/CyZ8A3Cft1RdwqKGQqxo
         QqRrUxdG44IFfj7y+moOM1OFGSNY9pme2u9QX+xxyWAsmMG1g08B94A30zK7PzRv0M
         /VTl+AXZNOymhjMGrdSihK+nh8wTxx1zpjQ/+SuM=
Date:   Sun, 12 Jul 2020 11:59:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zaikonnikov <ez@norphonic.com>
Cc:     Rob Herring <robh+dt@kernel.org>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v9 2/2] dt-bindings: iio: humidity: Add TI HDC20x0
 support
Message-ID: <20200712115920.4041260c@archlinux>
In-Reply-To: <86blknd0id.fsf@norphonic.com>
References: <86d053d1re.fsf@norphonic.com>
        <86blknd0id.fsf@norphonic.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jul 2020 14:20:58 +0200
Eugene Zaikonnikov <ez@norphonic.com> wrote:

> Add device tree bindings for HDC2010/HDC2080 family of humidity and
> temperature sensors.
> 

As Andy mentioned for patch 1 please avoid attachments.

> Changes from v8:
> - document the use of reg
> - change the license terms to GPL-2.0-only

The change log should be after the --- (which isn't here because
of the attachments issue).  This is so we don't track a bunch of change
logs in the eventual git log.  They tend not to be of much interest once
a patch has merged.  If there is stuff in there of interest, it should usually
be added to the patch description itself (e.g. some design decision or similar).

The license terms seem to be dual with BSD, which is good, but
not what the change log says!

I've pasted in the actual patch content below, so others can easily
review this version.

Thanks,
Jonathan


> 
> Signed-off-by: Eugene Zaikonnikov <ez@norphonic.com>
> 

> diff -uprN linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
> --- linux-5.3.8/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_docs/Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml	2020-07-10 13:08:46.818076734 +0200
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/ti,hdc2010.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDC2010/HDC2080 humidity and temperature iio sensors
> +
> +maintainers:
> +  - Eugene Zaikonnikov <ez@norophonic.com>
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
> +  vdd-supply:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      humidity@40 {
> +          compatible = "ti,hdc2010";
> +          reg = <0x40>;
> +      };
> +    };
