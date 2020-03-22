Return-Path: <SRS0=ud0C=5H=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5023C4332B
	for <linux-iio@archiver.kernel.org>; Sun, 22 Mar 2020 18:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9F02076E
	for <linux-iio@archiver.kernel.org>; Sun, 22 Mar 2020 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584901470;
	bh=yCz/ZT341lKLDKklGLVfKp6Q+x33rLv+tIrcibyvKJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aT//dBv8OjMB+c1Wd4kn+8s/Os58F+lRpV+pR5pghkP9NJzWwLVH2rYdZTfmX/M2H
	 KUKHxs1tm8QN0uJmNA0Dp5Fwla1c3FC4YUtv9e44Bvr5sNqh9t6ZNpFn/R7z1nHm/P
	 33crcavbk0SPAmjjqsOS65jpEaXwDDDGUQIBgCu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgCVSYY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 22 Mar 2020 14:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVSYX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 14:24:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16EAB206F9;
        Sun, 22 Mar 2020 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584901462;
        bh=yCz/ZT341lKLDKklGLVfKp6Q+x33rLv+tIrcibyvKJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0AfrCZThU/qf/WRxw+8nyxnzHig5IhoLfg2M1gD/6LwD6K3zDgO9Fa0JRZE/GZnI9
         mhSK6+zutycPn7AJuRr8JQfKtVriZG2Y5U/rkOVjUiiBQcZERn55lyVdeKlhE9HzVf
         DYKR0488Q5VkdbT7Dqgd1lzqo68OmqsWwJmi8nGk=
Date:   Sun, 22 Mar 2020 18:24:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: vcnl4000: convert bindings to
 YAML format
Message-ID: <20200322182416.079dc992@archlinux>
In-Reply-To: <f5ea512c-d427-94c7-cf5f-f1300cbd4aa3@gmail.com>
References: <cover.1584380360.git.agx@sigxcpu.org>
        <6182053bb8c442e0b4d72b34c83c7f1565f4a258.1584380360.git.agx@sigxcpu.org>
        <20200322172910.51456fe4@archlinux>
        <f5ea512c-d427-94c7-cf5f-f1300cbd4aa3@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 23:07:00 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> On 22/03/20 10:59 pm, Jonathan Cameron wrote:
> > On Mon, 16 Mar 2020 18:46:17 +0100
> > Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
> >  =20
> >> Convert the vcnl4000 device tree bindings to the new YAML format.
> >>
> >> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org> =20
> > Looks good to me. However, I've made far too many mistakes in
> > DT binding review recently, so will definitely be waiting for Rob to
> > get a chance to look at it!
> >=20
> > Jonathan
> >  =20
> >> ---
> >>   .../bindings/iio/light/vcnl4000.txt           | 24 ----------
> >>   .../bindings/iio/light/vcnl4000.yaml          | 45 +++++++++++++++++=
++
> >>   2 files changed, 45 insertions(+), 24 deletions(-)
> >>   delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4=
000.txt
> >>   create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4=
000.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt =
b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> >> deleted file mode 100644
> >> index 955af4555c90..000000000000
> >> --- a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
> >> +++ /dev/null
> >> @@ -1,24 +0,0 @@
> >> -VISHAY VCNL4000 -  Ambient Light and proximity sensor
> >> -
> >> -This driver supports the VCNL4000/10/20/40 and VCNL4200 chips
> >> -
> >> -Required properties:
> >> -
> >> -	-compatible: must be one of :
> >> -        vishay,vcnl4000
> >> -        vishay,vcnl4010
> >> -        vishay,vcnl4020
> >> -        vishay,vcnl4040
> >> -        vishay,vcnl4200
> >> -
> >> -	-reg: I2C address of the sensor, should be one from below based on t=
he model:
> >> -        0x13
> >> -        0x51
> >> -        0x60
> >> -
> >> -Example:
> >> -
> >> -light-sensor@51 {
> >> -	compatible =3D "vishay,vcnl4200";
> >> -	reg =3D <0x51>;
> >> -};
> >> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml=
 b/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
> >> new file mode 100644
> >> index 000000000000..74d53cfbeb85
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
> >> @@ -0,0 +1,45 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/light/vcnl4000.yaml# =20
> Shouldn't the devicetree binding document be named with the manufacturer=
=20
> part as well?

Yup. Good spot.  Told you I kept missing things ;)

Jonathan

>=20
> With regards,
> Nishant
>=20
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: VISHAY VCNL4000 ambient light and proximity sensor
> >> +
> >> +maintainers:
> >> +  - Peter Meerwald <pmeerw@pmeerw.net>
> >> +
> >> +description: |
> >> +  Ambient light sensing with proximity detection over an i2c
> >> +  interface.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - vishay,vcnl4000
> >> +      - vishay,vcnl4010
> >> +      - vishay,vcnl4020
> >> +      - vishay,vcnl4040
> >> +      - vishay,vcnl4200
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +- |
> >> +  i2c {
> >> +      #address-cells =3D <1>;
> >> +      #size-cells =3D <0>;
> >> +
> >> +      light-sensor@51 {
> >> +              compatible =3D "vishay,vcnl4200";
> >> +              reg =3D <0x51>;
> >> +      };
> >> +  };
> >> +... =20
> >  =20

