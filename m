Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.177]:34412 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdBWJ4A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Feb 2017 04:56:00 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 5/8] dt-bindings: input: move ads7846 bindings to touchscreen subdirectory
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <07298be658b70f006e6598e7888dd5b5f304f65c.1482936802.git.hns@goldelico.com>
Date: Thu, 23 Feb 2017 10:54:04 +0100
Cc: linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com, Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nikolaus Schaller <hns@goldelico.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nick Dyer <nick@shmanahar.org>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Michel Verlaan <michel.verl@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Message-Id: <484A61F4-72F5-4236-8ADF-A4921EC0E6B0@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <cover.1482936802.git.hns@goldelico.com> <07298be658b70f006e6598e7888dd5b5f304f65c.1482936802.git.hns@goldelico.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dmitry,
this patch from the series seems to have been lost in the other =
discussions.
It is just moving a bindings document to where it should be.
I don't know if it should go through your git.
BR and thanks,
Nikolaus

> Am 28.12.2016 um 15:53 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Documentation/devicetree/bindings/input/{ =3D> =
touchscreen}/ads7846.txt | 0
> 1 file changed, 0 insertions(+), 0 deletions(-)
> rename Documentation/devicetree/bindings/input/{ =3D> =
touchscreen}/ads7846.txt (100%)
>=20
> diff --git a/Documentation/devicetree/bindings/input/ads7846.txt =
b/Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/input/ads7846.txt
> rename to =
Documentation/devicetree/bindings/input/touchscreen/ads7846.txt
> --=20
> 2.7.3
>=20

