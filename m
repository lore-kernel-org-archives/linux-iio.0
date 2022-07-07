Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410A1CCA479
	for <linux-iio@archiver.kernel.org>; Thu,  7 Jul 2022 17:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiGGRrh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 7 Jul 2022 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiGGRrY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jul 2022 13:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE55C97D;
        Thu,  7 Jul 2022 10:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47E32620A6;
        Thu,  7 Jul 2022 17:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56393C3411E;
        Thu,  7 Jul 2022 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657216041;
        bh=Om5lyrI/FUfOSiu1TyYTkifd9deSCv6M320djg1nrZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UG3QjZNLJDSaydTOuou9yLJk6u83CwpZbBj5O+2xK1GfiiaPV42R0bXH1JtEnday0
         VD8rGxK/iCJnQiv8eJhawEFOgxSSlbP+IMuWmfz05KTZ70HwZ1bZInOG0kRjWwB4oz
         /rYHtW+c6EhbNGb8LoEYFGQ+qQQsFvoepBMdDdBZx2Y9wKK5ika0GmVDbUGqaysUns
         Ymmd/E5JeU7n1pm72iF1aMQRgTHulPBLzXEIqitMDXSW6+Pkak3P9AvRCRbbF9xdlD
         sTw1r+Th1KduLILQQctDHy+F9Mo8g5U4kU8vZGJLN5zDSh/26hWksF8pEhMWFRGMxb
         AxpQbzIyw3J1Q==
Date:   Thu, 7 Jul 2022 18:57:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] iio: adc: mcp3911: add support for buffers
Message-ID: <20220707185703.4a5a3a30@jic23-huawei>
In-Reply-To: <Yr1fqi/49l1nWYtt@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-3-marcus.folkesson@gmail.com>
        <20220625124537.163bf426@jic23-huawei>
        <Yr1fqi/49l1nWYtt@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> > >  static const struct iio_info mcp3911_info = {
> > >  	.read_raw = mcp3911_read_raw,
> > >  	.write_raw = mcp3911_write_raw,
> > > @@ -303,7 +353,7 @@ static int mcp3911_probe(struct spi_device *spi)
> > >  		goto clk_disable;
> > >  
> > >  	indio_dev->name = spi_get_device_id(spi)->name;
> > > -	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;  
> > 
> > The core sets INDIO_BUFFER_TRIGGERED as part of devm_iio_triggered_buffer_setup()
> > so you need to set DIRECT_MODE here (that one isn't visible to the core)  
> 
> Ok, thank you. I sent patches that fixes this in two other ADC-drivers
> as well to avoid more people following the same thing.

Thanks. Much appreciated!

