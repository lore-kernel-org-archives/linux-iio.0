Return-Path: <SRS0=vmB+=XF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1356C3A5A2
	for <linux-iio@archiver.kernel.org>; Tue, 10 Sep 2019 07:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C375B2171F
	for <linux-iio@archiver.kernel.org>; Tue, 10 Sep 2019 07:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568099578;
	bh=BrjNknZgaUbQJvh4TIl7DUiVKTih5GkTa1onzUFrWOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ayn0oy2hcQj5uUQmE+Ia4DfvRQKqwMD5NHDw+7Y90PCdKcZbhnSwIlDiltUifKtVk
	 4Qh9ScF7tlW04ld8EkRDg9CfCQG6d/bWtfciI4/Gv/DOTTPF310ZiMVqc7w4rA1JsC
	 P/l8DTqAntK+AOX8w/Q+4rP8vDXTmBE6DPGIHwDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfIJHM4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729707AbfIJHM4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Sep 2019 03:12:56 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0F32084D;
        Tue, 10 Sep 2019 07:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568099575;
        bh=BrjNknZgaUbQJvh4TIl7DUiVKTih5GkTa1onzUFrWOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pL4jZi3OPU3B+V+2ZHanx7qgBy7VYiYKYlQiCCLHls8AZEYS4hGdWSFeQr2KSTKhB
         3fuRNLmlps5vhIcZV2ADyp0t99c7QaBjdeKaVeOsTRdkj03SOJXy36Zbks5xKOjyFa
         U4TGL1K9rroYWUSKG4sIlkMYx7AZzM1BZU53knLU=
Date:   Tue, 10 Sep 2019 09:12:50 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190910071250.GA2712@localhost.localdomain>
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
 <20190909120546.GE2990@localhost.localdomain>
 <6e987a54-250c-c146-cff8-99fa33255f9b@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <6e987a54-250c-c146-cff8-99fa33255f9b@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Maybe I understood the issue between the buffered reading and event gen=
eration.
> > I guess it is a race here between when the device is generating the int=
errupt
> > and when you set enable_event. I think there are two solutions:
> > 1- trivial one: always read wakeup_src_reg
> > 2- set hw->enable_event as first instruction in st_lsm6dsx_write_event_=
config()
> > and roll back in case of error.
> >=20
> > Could you please try that changes and double check if you are still abl=
e to
> > trigger the issue?
> >=20

[...]

> $ cd /sys/bus/iio/devices/iio:device2
> $ echo 1 > events/in_accel_x_thresh_either_en
> $ echo 1 > events/in_accel_x_thresh_either_value
> $ echo 1 > scan_elements/in_accel_x_en
> $ echo 1 > buffer/enable
>=20
> FIFO interrupts ticking in... until I trigger the first event. :-(
> The event is reported correctly. The interrupt pin is staying high.
> The result is the same if I enable the FIFO first.
> I don't think we have a race in the driver around this, to me it looks li=
ke
> something in the ism330 device should be cleared.
> Could the device go into sleep or power down mode?

probably a silly question..are you tracing the interrupt line with an
oscilloscope or a logical analyser? If you dump interrupt counters in
/proc/interrupts will you see an interrupt storm for the selected irq
pin?

Regards,
Lorenzo

>=20
> 2. Seems like an okay idea, do you want this in v7?
>=20
> /Sean

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXdM7wAKCRA6cBh0uS2t
rJkBAP9SsQX5b3mEFNCbPu+Q/0j8F/upv89oqG3HmOXLV4D92AEAk3jr/ZDwDvxd
u+yy9q9M8R/uU1i0eC1b4L+aAvezAgc=
=YSAc
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
