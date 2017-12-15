Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43861 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755650AbdLOVmP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Dec 2017 16:42:15 -0500
Date: Fri, 15 Dec 2017 15:42:13 -0600
From: Rob Herring <robh@kernel.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marius Tarcatu <marius.tarcatu@infineon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Add Infineon TLV493D-A1B6
Message-ID: <20171215214213.u6tqtpxfkgxtbsf2@rob-hp-laptop>
References: <20171209232507.18594-1-afaerber@suse.de>
 <20171209232507.18594-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171209232507.18594-2-afaerber@suse.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Dec 10, 2017 at 12:25:06AM +0100, Andreas Färber wrote:
> The Infineon TLV493D-A1B6 is an I2C-based 3D Magnetic Sensor.
> 
> Cc: Marius Tarcatu <marius.tarcatu@infineon.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)

I take trivial-devices.txt changes to avoid any conflicts, so I've 
applied.

Rob
