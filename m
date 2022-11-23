Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A54C433FE
	for <linux-iio@archiver.kernel.org>; Wed, 23 Nov 2022 20:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiKWUgl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 23 Nov 2022 15:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiKWUgQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 15:36:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92185E0DEF;
        Wed, 23 Nov 2022 12:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B2961EFC;
        Wed, 23 Nov 2022 20:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5C3C433D6;
        Wed, 23 Nov 2022 20:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669235592;
        bh=B8fMMVHm0c3Mnc+9FQNgfFP/mxzdHWei2MQUrXKNUSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cTI+o5R0vSFAqifl6DVt5eWM6oNiEf0ZFZTgWM4UIWpqu68XLporbVmtfNnF/uVIw
         XN/JS7rccLfro5rXTW8lfbPYuIQbI4FdqvC6ithepcc7Hno9OLagiPMxWpwshdLBEH
         iy9kWI08HC3DdIq4UxbSo37nUSRSo/Aw6xmQ4cnqfhrcArS0extNivizjq6/oUnFwB
         RkUVL1lNHg/20ZPApaEGatlO80Zc4RPpvDlLy1aPMAp8T0Xc6QTHqGEYbR5PVRI9O6
         a7LC7GmLCuAs1L3BhXbYC1C3fO9OXlp2q62KiKqwRrfjRmZ7Ls20kEMxN+8KwUwqgu
         jQ/CTwiletQvQ==
Date:   Wed, 23 Nov 2022 20:45:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: addac: ad74413r: fix integer promotion bug in
 ad74413_get_input_current_offset()
Message-ID: <20221123204544.6a2b05a1@jic23-huawei>
In-Reply-To: <b81d2ffe-efc3-8e2d-de7b-ed2bfa2449d0@rasmusvillemoes.dk>
References: <20221118123209.1658420-1-linux@rasmusvillemoes.dk>
        <SJ0PR03MB6778D6C0682294002296E54C99099@SJ0PR03MB6778.namprd03.prod.outlook.com>
        <b81d2ffe-efc3-8e2d-de7b-ed2bfa2449d0@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Nov 2022 14:29:23 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 18/11/2022 14.17, Sa, Nuno wrote:
>=20
> >> Casting to int avoids that promotion and results in the correct -32767
> >> output.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> --- =20
> >=20
> > After adding proper Fixes: tag,
> >=20
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
>=20
> That would be
>=20
> Fixes: fea251b6a5db (iio: addac: add AD74413R driver)
>=20
Applied to the togreg branch of iio.git (as very late in cycle)
and marked for stable.

Thanks,

Jonathan

> Thanks,
> Rasmus
>=20

