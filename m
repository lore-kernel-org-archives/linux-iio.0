Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038AAC4332F
	for <linux-iio@archiver.kernel.org>; Sat, 12 Nov 2022 15:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiKLPb2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 12 Nov 2022 10:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLPb0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2022 10:31:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36617400;
        Sat, 12 Nov 2022 07:31:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3360C60BC2;
        Sat, 12 Nov 2022 15:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C892EC433C1;
        Sat, 12 Nov 2022 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267084;
        bh=L71ZhQpKy5eSChhgN4Kj+yrgtuB5OtzV1cbSWW50yuo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e1DU6eFAMaLBzzazikCIpNDcDy7PwJKf+UIYHJ+19B4fJ4tV3HYTGGqNNfv0TEwXA
         BV9RIn8xya/8PSyxH2T5RFZ69IdVcdLttRE5c8xu9tWLOaPbG9VdjnHSPkbHdhgFCw
         hcxSsUmTHFi6qvJOntDzY/P6K3zLb5UWbbblaNWeS8c6FhYOdeJEeLBMGe1FdTJd9L
         QLoJQ2wRdaPLViv+bfdEcV5UhYQtf8vrQYujuZ1MoqfNUE+jpvWx4l/lgaQ4Wf3+db
         wrIr0U8gUHOqcNDr3FVwgqlNUPdVVoytKsMJQOu3KhjQDiwoivKwqnjcWeQ1jMovGw
         YZ1KSOj6ZREtQ==
Date:   Sat, 12 Nov 2022 15:43:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v4 11/13] dt-bindings: iio: temperature: ltc2983: use
 generic node name in example
Message-ID: <20221112154337.0c0fa15d@jic23-huawei>
In-Reply-To: <ba6b64f733aaee22ff85feba467ff01ccb220913.camel@gmail.com>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
        <20221103130041.2153295-12-demonsingur@gmail.com>
        <20221107181328.GA1354289-robh@kernel.org>
        <ba6b64f733aaee22ff85feba467ff01ccb220913.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 08 Nov 2022 10:37:23 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On Mon, 2022-11-07 at 12:13 -0600, Rob Herring wrote:
> > On Thu, Nov 03, 2022 at 03:00:39PM +0200, Cosmin Tanislav wrote: =20
> > > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > >=20
> > > Examples should use the generic IIO node name. Fix it.
> > >=20
> > > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > > ---
> > > =C2=A0.../devicetree/bindings/iio/temperature/adi,ltc2983.yaml=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > index 467e165e9b0b..bd357ff28e65 100644
> > > ---
> > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > +++
> > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam
> > > l
> > > @@ -420,7 +420,7 @@ examples:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <=
1>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor_ltc2983: ltc2983@0=
 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 temp@0 { =20
> >=20
> > The DT spec defines 'temperature-sensor'. =20
>=20
> Jonathan, could you maybe fix this (replace 'temp' with
> 'temperature-sensor') while picking it up? Thanks.

Done.
>=20
> >  =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ltc2983";
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > > =C2=A0
> > > --=20
> > > 2.38.1
> > >=20
> > >  =20
>=20

