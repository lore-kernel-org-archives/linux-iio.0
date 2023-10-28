Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91D6C0032E
	for <linux-iio@archiver.kernel.org>; Sat, 28 Oct 2023 15:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjJ1PXz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 28 Oct 2023 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1PXy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Oct 2023 11:23:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A093;
        Sat, 28 Oct 2023 08:23:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815ACC433C8;
        Sat, 28 Oct 2023 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698506632;
        bh=DfA14lJV5fCHDlTRV9h2PoOcI7/ngGn2Ntb0yXI7Urk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CO+Y4f5T7gTsX618YlDV3vWfgHW3+gp8LfOaz19r5Ua6TD3X7XyhXe/dDZNfOpzZI
         dhHYHS3kIpeU0aXZIZxsKB7A4dEPN0gMQelz1Two+6C8Y1PdtymcHj+PeDucTrB1Cs
         zxqs9uEx4WsOD9ACCTQDD1lYML1IXmS9u37r1kSBlrAuTJB+ZQoXbJnSZ83tqfN8Pm
         H8qpc7dVg7pKT6Gq/t3L2IcdX+QuKHciJZDmxXzU6Su/6aNLipFCtfJ0DmSg0BLsia
         VOmAZ8lh1H5cdXUHwjxNRFLNQZVTc/uJbo66lmZ2VOZz+eiUl5iRP+Ct6jgh0x29KZ
         fq5QHS4jqfZ6A==
Date:   Sat, 28 Oct 2023 16:23:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc:     <nuno.sa@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] iio: imu: adis: Use spi cs inactive delay
Message-ID: <20231028162313.5babf107@jic23-huawei>
In-Reply-To: <20231027140358.328699-1-ramona.gradinariu@analog.com>
References: <20231027140358.328699-1-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Oct 2023 17:03:55 +0300
Ramona Gradinariu <ramona.gradinariu@analog.com> wrote:

> A delay is needed each time the chip selected becomes inactive,
> even after burst data readings are performed.
> Currently, there is no delay added after a burst reading
> and in case a new SPI transfer is performed before
> the needed delay, the adis device becomes unresponsive until
> reset.
> 
> This commit is adding the needed delay directly to the spi driver,
> using the cs_inactive parameter, in case it is not set and is
> removing the additional chip select change delay present in adis
> APIs to remove the double delay.

Series applied.

I'm a bit confused though as this one is turning up in patchwork.
Meh, maybe a delay and it will show up soon.

Jonathan

> 
> Ramona Gradinariu (3):
>   iio: imu: adis: Use spi cs inactive delay
>   dt-bindings: adis16475: Add 'spi-cs-inactive-delay-ns' property
>   dt-bindings: adis16460: Add 'spi-cs-inactive-delay-ns' property
> 
>  .../bindings/iio/imu/adi,adis16460.yaml        |  4 ++++
>  .../bindings/iio/imu/adi,adis16475.yaml        |  4 ++++
>  drivers/iio/imu/adis.c                         | 18 ++++++------------
>  3 files changed, 14 insertions(+), 12 deletions(-)
> 
> --
> 2.34.1
> 

