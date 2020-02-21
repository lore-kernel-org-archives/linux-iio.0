Return-Path: <SRS0=70H6=4J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34EEC35646
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 17:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63EF208E4
	for <linux-iio@archiver.kernel.org>; Fri, 21 Feb 2020 17:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="KnJtV3zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBUR21 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:28:27 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:45934 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbgBUR20 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 12:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RdODmHvydoNs/1kRxAwgLkbkKaSgefTaK09DDj4UNmo=; b=KnJtV3zBNHFdalbcFgT3kTppf
        yc9gX4IIJuOYCpMmQ3OBtZWpGO22pglxzH4D5svTkYDjKbVRFv10wqQI8IAcMlpgyKRL+pKyjav8c
        irGHiu0M0hligxSbLgBcvdj3GAdZoeXig1JIs4CkD95vnA/cTflf10uoxPl2DL6IlczwM=;
Received: from p200300ccff0c3400e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff0c:3400:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j5C66-0003pi-OB; Fri, 21 Feb 2020 18:28:19 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j5C65-0008Be-Uh; Fri, 21 Feb 2020 18:28:18 +0100
Date:   Fri, 21 Feb 2020 18:27:27 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v3 2/4] iio: adc: rn5t618: Add ADC driver for
 RN5T618/RC5T619
Message-ID: <20200221182727.0089e8dc@kemnade.info>
In-Reply-To: <20200221130733.240f0d6d@archlinux>
References: <20200218061725.22420-1-andreas@kemnade.info>
        <20200218061725.22420-3-andreas@kemnade.info>
        <20200221130733.240f0d6d@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bJVrdX=C51NqZmw7j0KRrxX"; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/bJVrdX=C51NqZmw7j0KRrxX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2020 13:07:33 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 18 Feb 2020 07:17:23 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
>=20
> > Both chips have an A/D converter capable of measuring
> > things like VBAT, VUSB and analog inputs.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info> =20
> One trivial comment inline.  Looks good to me and I'm assuming
> this will got through the mfd tree.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
ok, I will send a v4 with that return line fixed and the RFC patches droppe=
d,
since nobody seems to have time to test them.

Regards,
Andreas

--Sig_/bJVrdX=C51NqZmw7j0KRrxX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5QEwAACgkQl4jFM1s/
ye+9JRAAre3NDSBVb2y2l1lMlJimeh0lLUy58IwPuJysp1ijoXCcNIGM3OxrANTL
G9B5IF9OrB0hWRQ0eTeotgzyNPMqJlrNCRIu4QDwplWSIaXO0MEfta/BZ26vQxc7
nnJORKwZCVTgWNuFJAULGwkthA3Z/mzB/t1NlpzgkCrWux2OOaSZCNYBgWZcNaza
Hp3U0RQyLKh9RedhZ6/M4FrSSq7bnaLewC2J922VLJhEPNCKm//75XFmf59Rnlo+
LRFAbB+s+OFURv2uMx4NfUiX/nPswbXWoHqhZ/gnXeHAh4gbEL3UsUhT49K6eLzO
+MN+j+ah9+Xkk4Zuq/0KO8r2FDiBjagw0ACJpH2ihX7AwYBCnibftrtcxoBHAtNI
afgas+RdWZlKPIb9NgPM+W95sEZ5jNYeGcx3tn/BLT6ajvIzIND0HV6bIus7ev+g
N9qr8UWSPl9VVUMyAQ7JTqMjWvnwX3uiunYa8iX5Wt3KV8KybExmD/km0X/3MFPE
+NY4rR3lhdNKl/jloxIXzChOILkgQihKLovKQg6HWBNRTM7iNSgFtibzkOQI/l5H
rPX58GNKzxwyzp4xnJAsA16QdA8VJpgYsgAQz5GZ5iJQXMBQPaGxeQuCUCqOeXU9
k0mw/NwFBwFiDeZGknDDBNbVY5LbykTlCVg4Ka+Lq1Ku72sUNlE=
=GhBR
-----END PGP SIGNATURE-----

--Sig_/bJVrdX=C51NqZmw7j0KRrxX--
