Return-Path: <SRS0=EKtD=XP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE264C3A5A2
	for <linux-iio@archiver.kernel.org>; Fri, 20 Sep 2019 21:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E00208C0
	for <linux-iio@archiver.kernel.org>; Fri, 20 Sep 2019 21:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569016549;
	bh=2LPNO3Z7aNCJXY5snMM7bi+R6Y44nv08WAYUt4oH4OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EO82DSJ1r4UPhGyiCtVohg00+2XRWEp96Kj9dLC7dHzVerCjYghbtxLwc51rBRPgE
	 /FC0N8Qtx6RZvYlizwy1UrCIdftDFFqkBYK+Nipcuew4iqziWO2oa19J5zxipc1fjs
	 vfsaSuzLE1uIePrCwzOkBXDg/ta/ur7jsOYaFnTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfITVzt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbfITVzs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Sep 2019 17:55:48 -0400
Received: from localhost.localdomain (unknown [151.66.30.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A85208C0;
        Fri, 20 Sep 2019 21:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569016547;
        bh=2LPNO3Z7aNCJXY5snMM7bi+R6Y44nv08WAYUt4oH4OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ndw6EVrIBznt9EWDBQaOy1SbyQHaBS8RMZxiVZqOa5aJ6m92lBHsW1nTIAmA0CR8f
         rO9QOm7YMTS2/I+UdB1YZHDofpBNyye/1ZOQ33Z6pvPXAl7N6xlXXxUdosFxGs2/e7
         4TTrqL+EQqUh23PasYcsEtoBdarEle6sZp7TjbWQ=
Date:   Fri, 20 Sep 2019 23:55:42 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Bobby Jones <rjones@gateworks.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: LSM9DS1 testing with st_lsm6dsx driver
Message-ID: <20190920215542.GA16493@localhost.localdomain>
References: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
 <20190920064214.GA31900@lore-desk-wlan.lan>
 <CALAE=UDmg_+q=zt9Z6D5BrsnpFXi7dVMdTMVdHk2SMXCtxoJTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <CALAE=UDmg_+q=zt9Z6D5BrsnpFXi7dVMdTMVdHk2SMXCtxoJTw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > LSM9DS1 does not support hw FIFO for the moment. Are you trying to enab=
le
> > buffered reading?
>=20
> I am not manually interacting with the device at all when this
> exception occurs. This happens during the driver probe.
>=20
> > Could you please try if the following patch helps? (just compiled)
>=20
> I no longer receive the exception with this patch and it makes sense, tha=
nks.

Hi Bobby,

thx a lot for testing. Could you please try to drop the previous patch and
apply the following one? Does it fix the issue as well?

iio: imu: st_lsm6dsx: check read_fifo pointer in st_lsm6dsx_handler_thread

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_buffer.c
index b0f3da1976e4..f4fd4842bd79 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -666,6 +666,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, v=
oid *private)
 	struct st_lsm6dsx_hw *hw =3D private;
 	int count;
=20
+	if (!hw->settings->fifo_ops.read_fifo)
+		return IRQ_NONE;
+
 	mutex_lock(&hw->fifo_lock);
 	count =3D hw->settings->fifo_ops.read_fifo(hw);
 	mutex_unlock(&hw->fifo_lock);
--=20
2.21.0

>=20
> For context I'm working with a board that has every data ready and
> interrupt signal connected to the LSM9DS1. Could you clarify what the
> proper usage of the "st,drdy-int-pin" would be in this case and
> whether or not I need more than one interrupt called out in my device
> tree node?
> I'm not really understanding how they're currently being utilized for
> this device in the driver.

For the moment irq line in lsm9ds1 (acc/gyro) is not used at all,
so you can omit the "st,drdy-int-pin" property

>=20
> Also, I know support for this device was added recently and the combo
> device hardware FIFO is complex, but is support for this something
> that's currently being worked on?

It is actually in my ToDo list but I have no this device at the moment, so
patches are welcome :)

Regards,
Lorenzo

>=20
> Thanks,
> Bobby Jones
>=20
> > Regards,
> > Lorenzo
> >
> > iio: imu: st_lsm6dsx: do not configure the fifo if not supported
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index b65a6ca775e0..90a0e5ce44e5 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1572,7 +1572,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq,=
 int hw_id,
> >                         return err;
> >         }
> >
> > -       if (hw->irq > 0) {
> > +       if (hw->irq > 0 && hw->settings->fifo_ops.update_fifo) {
> >                 err =3D st_lsm6dsx_fifo_setup(hw);
> >                 if (err < 0)
> >                         return err;
> > --
> > 2.21.0
> >
> >

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXYVK2wAKCRA6cBh0uS2t
rESQAQC1tUKnGxvXLDilhV2O1wPJkI2by8Cl8kanbeUbWG4bZAEA7zTbg0fjr8GV
C1wMzcgU6IVcv/YZUvgwyFM1HFDNSQE=
=/SYo
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
