Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC8FC433F5
	for <linux-iio@archiver.kernel.org>; Sat, 28 May 2022 16:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbiE1QmH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 28 May 2022 12:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbiE1QmG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 May 2022 12:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D0915721
        for <linux-iio@vger.kernel.org>; Sat, 28 May 2022 09:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52AD760F4C
        for <linux-iio@vger.kernel.org>; Sat, 28 May 2022 16:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA1EC34100;
        Sat, 28 May 2022 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653756124;
        bh=VIpPPu1RjXNZmMksRK1bL6YelkeODBGQsZ//Ac0e60s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tgmAdHu1U0lGYI2HrdlhxiIF0RrmE2iZjCfbNVfU95L0fXvY+zAqiyYcaYPeBfi0N
         qPdk9nYrfkb4Qi/Q5b5dz7UjvGkcl6KuS6wmxANdNsO6Vb+S9fdCi6h+Jt7KX0Hi04
         nlf/cFay5Ibmy2p2W5L/IwvtCK8V0Nm0SIwi6p+nUwMzMZDILulB1H2eEVxbLj1+UG
         Qy5VHhMfRZvo0aei7+fRPSycEbYlXdjJwBvTJ5nfHVHyeXwJg8AT/J6JdJTFshf4Up
         AxXOratcZyWlw/Ad8ShvuEhwZYtWcwrc/CceYbOKD0UxmJeAKHbtt9s25ZfXFsQvHz
         YzMdAR0b/IQ8Q==
Date:   Sat, 28 May 2022 17:50:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH 0/5] dt-bindings: iio: update maintainers
Message-ID: <20220528175055.091c4ea0@jic23-huawei>
In-Reply-To: <20220526134603.75216-1-alexandru.tachici@analog.com>
References: <20220526134603.75216-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 May 2022 16:45:57 +0300
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Some of the emails in bindings maintainers section are not
> working anymore. Update them with current ones.

Hi Alexandru,

Where possible for maintainer changes, cc the original person
on their new email addresses.  Alexandru is still active on the
list +CC.

Now, if they don't reply I don't mind switching these maintainers
over but nice to give them a heads up.

Thanks,

Jonathan

> 
> Alexandru Tachici (5):
>   dt-bindings: iio: accel: ADIS16240: update maintainers
>   dt-bindings: iio: adc: AD9467: update maintainers
>   dt-bindings: iio: adc: axi-adc: update maintainers
>   dt-bindings: iio: dac: AD5770R: update maintainers
>   dt-bindings: iio: imu: adis16480: update maintainers
> 
>  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml      | 1 -
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml     | 1 -
>  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 2 +-
>  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 2 +-
>  5 files changed, 3 insertions(+), 5 deletions(-)
> 

