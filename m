Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33047 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdCCHmt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Mar 2017 02:42:49 -0500
Date: Fri, 3 Mar 2017 00:20:55 -0600
From: Rob Herring <robh@kernel.org>
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
        michael.hennerich@analog.com, daniel.baluta@gmail.com,
        amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: iio: accel: Document ADXL345
 accelerometer binding
Message-ID: <20170303062055.alruihgsgjjuvgd5@rob-hp-laptop>
References: <cover.1488248485.git.eraretuya@gmail.com>
 <dec0c0561b579095dfc6d67fac4bf911a1b450f4.1488248485.git.eraretuya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dec0c0561b579095dfc6d67fac4bf911a1b450f4.1488248485.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 28, 2017 at 10:37:16AM +0800, Eva Rachel Retuya wrote:
> Add the device tree binding documentation for the ADXL345 3-axis digital
> accelerometer.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> ---
> Changes from v4:
> * Update subject-prefix 
> * Update node name from "adxl345@unit-address" to "accelerometer@unit-address"
> 
>  .../devicetree/bindings/iio/accel/adxl345.txt      | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt

Acked-by: Rob Herring <robh@kernel.org>
