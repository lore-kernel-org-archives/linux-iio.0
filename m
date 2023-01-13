Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD333C3DA78
	for <linux-iio@archiver.kernel.org>; Fri, 13 Jan 2023 19:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjAMTzP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 13 Jan 2023 14:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjAMTy4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2023 14:54:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6154E892F6
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2023 11:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F16D762302
        for <linux-iio@vger.kernel.org>; Fri, 13 Jan 2023 19:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA39C433D2;
        Fri, 13 Jan 2023 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639695;
        bh=v0lD60A8qEt2WeZllMnEaIiAuKpfHyB1IIJvrHEn5+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AENadh1/UgBDVqMFtbt2/Has+p2Wcs2XMT0il2w6UZ9ApncKh53sQJCpaiCAgfPSm
         qFpYmuHnUw3AvIm9nsoK4acCDWDO2h28ouHzK5QXL5vLi+lJXV+IbNW8Dhjh/uNYfQ
         kJ8orZSKtZjF+DPt5DoA9bteJNSVKjhvojOACYW90iMvGgBtPdytJKFeeNvd6+8eMg
         bxBynZVIWbij56QePT29E4/xd0LzPe2b8x7AKzCI42qT8qFPgCyx6miH+0bs5rgakl
         s1HthFBUDEYhLxJ/ubBGlaofe/aMPLhskU1xj0W3llPXvzciQRRMv7Lr49tgwb7qc0
         w04MznLmYrJuQ==
Date:   Fri, 13 Jan 2023 14:54:52 -0500
From:   William Breathitt Gray <wbg@kernel.org>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] counter: microchip: Add appropriate arch deps for
 TCP driver
Message-ID: <Y8G3DPDMG+jEep/y@ishi>
References: <20230108074750.443705-1-pbrobinson@gmail.com>
 <20230108074750.443705-4-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ayFC2XdsfsdjGoyi"
Content-Disposition: inline
In-Reply-To: <20230108074750.443705-4-pbrobinson@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ayFC2XdsfsdjGoyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 08, 2023 at 07:47:50AM +0000, Peter Robinson wrote:
> Add the CONFIG_SOC_AT91SAM9 and CONFIG_SOC_SAM_V7 deps for the
> Microchip SoCs that support this IP block/driver plus compile
> time testing.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied to counter-next, thanks.

William Breathitt Gray

--ayFC2XdsfsdjGoyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY8G3DAAKCRC1SFbKvhIj
KwF5AP4sCNAsVZaAMgBntraJaU473MhvUFT441LFnL7WSU4Q2wEAgpIu4Vr+3KDU
/QiHWyECcV1/jZYLeny8BR7e+coEpA4=
=HL2O
-----END PGP SIGNATURE-----

--ayFC2XdsfsdjGoyi--
