Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F9DC83F33
	for <linux-iio@archiver.kernel.org>; Mon,  4 Sep 2023 20:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjIDUkX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Sep 2023 16:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDUkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2023 16:40:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D410CFB;
        Mon,  4 Sep 2023 13:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 942D3CE0ED4;
        Mon,  4 Sep 2023 20:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C59BC433C8;
        Mon,  4 Sep 2023 20:40:04 +0000 (UTC)
Date:   Mon, 4 Sep 2023 16:40:02 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee@kernel.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] counter: chrdev: remove a typo in header file comment
Message-ID: <ZPZAoh6B1vN2jqsR@ishi>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
 <20230829134029.2402868-3-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="thz1GdxEjcCjOPaP"
Content-Disposition: inline
In-Reply-To: <20230829134029.2402868-3-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--thz1GdxEjcCjOPaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 03:40:23PM +0200, Fabrice Gasnier wrote:
> Replace COUNTER_COUNT_SCOPE that doesn't exist by the defined
> COUNTER_SCOPE_COUNT.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Applied to counter-next as commit 631c15d5f14d.

Thanks,

William Breathitt Gray

--thz1GdxEjcCjOPaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZPZAogAKCRC1SFbKvhIj
K+noAP4+sSxlfiB2yBCeIDnhQcYNL15lMsj6+dHGrph+FsYuhAD/WFonHP2nDxW1
uapdulAZHV5XAKZVynE0IbaHpNnRKgE=
=QE7P
-----END PGP SIGNATURE-----

--thz1GdxEjcCjOPaP--
