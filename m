Return-Path: <SRS0=bx8B=SC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CDAC43381
	for <linux-iio@archiver.kernel.org>; Sun, 31 Mar 2019 11:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAA220870
	for <linux-iio@archiver.kernel.org>; Sun, 31 Mar 2019 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554030690;
	bh=vKOKztm6nwH2zfAkSlZFgSfmG6LZkrqvY8OTas3dhWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AVMUFehlzmazfXa2MqezTcZYa5BTgnyMvmC1JfTEA8Wm5rHdPux31SDuv5h7lBkRa
	 U8eM9xPw/WIcCDuEYMd28s9eZvpHWtqDrxgtVEMaZgcWg8jYDiXlUPGtZvKA0SHE+4
	 2aXtJjmcDJHauV/h4u7z459zVA4mG6jW9JdJ1arY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfCaLLa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 31 Mar 2019 07:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfCaLLa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Mar 2019 07:11:30 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897932085A;
        Sun, 31 Mar 2019 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554030688;
        bh=vKOKztm6nwH2zfAkSlZFgSfmG6LZkrqvY8OTas3dhWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C1gzrCxRrv4uHi1unZSVn2dyWzpLmJZMUeCXihRkkjQ5s3tiEczzuwastnF7HcSLt
         enj3EJYwlU6jMnNT3pOVcYTUsybF2TE8kDraKOPDnAffqVZi0r4AjOmKMRyFq172Qa
         jdPQT8edz6MVKWtByAuB75LU4cxH9kxjSJk0RCm0=
Date:   Sun, 31 Mar 2019 12:11:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: IIO channel type for status/error flag indicators
Message-ID: <20190331121124.06596c1e@archlinux>
In-Reply-To: <1553798299.13791.47.camel@analog.com>
References: <1553093626.13791.37.camel@analog.com>
        <20190324180025.77aa8426@archlinux>
        <1553798299.13791.47.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Mar 2019 18:38:21 +0000
"Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:

> Hi Jonathan,
>=20
> Thank you for taking the time to answer.
>=20
> These devices are mostly used in automotive/aerospace industries where th=
ey
> usually require a continuous stream of data even if an error occurs. This
> is why we cannot just "drop the record" :).
> So, should we maybe think of a way of covering flags channel types?

Propose an interface and we can certainly talk about it :)  Keep in mind
that it needs to be lightweight for anything not making use of it and
that I can see this absorbing a lot of namespace / id space (particularly
in potential event codes) so keep that in mind as well.

I'd argue that those automotive / aerospace devices should certainly
cope with missing data, but perhaps that's wishful thinking.

Anyhow, I'm not against this in principle but think it's a non trivial
exercise so prepare yourself for a big job and quite a few rounds of
interface descriptions!

Jonathan

>=20
> Regards,
> -Stefan=C2=A0
>=20
> On Du, 2019-03-24 at 18:00 +0000, Jonathan Cameron wrote:
> >=20
> >=20
> > On Wed, 20 Mar 2019 14:53:50 +0000
> > "Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:
> >  =20
> > >=20
> > > Hello,
> > >=20
> > > We are currently working on a new adis16495 IMU driver which is an
> > > upgrade
> > > from the adis16480 family: https://www.analog.com/media/en/technical-=
do
> > > cume
> > > ntation/data-sheets/ADIS16495.pdf.
> > >=20
> > > This new chip supports a feature called "Burst Read Function" (page 13
> > > in
> > > the datasheet). The burst read function (BRF) provides a method for
> > > reading
> > > a batch of data (status, temperature, gyroscopes, accelerometers, time
> > > stamp/data counter, and CRC code), which does not require a stall
> > > time between each 16-bit segment and only requires one command
> > > on the DIN line to initiate.
> > >=20
> > > Most of the data read in this way can be attributed to a type of
> > > channel:
> > > IIO_TEMP, IIO_ANGL_VEL, IIO_ACCEL, etc. However, there is no equivale=
nt
> > > for
> > > the status and CRC. The status register provides various error flags
> > > such
> > > as spi communication error, sensor failure, sync error, etc (Table 18
> > > in
> > > the datasheet). This information together with the CRC error should be
> > > exposed to the user space. What is the best way to do it? =20
> > Ok, So this is not exactly unusual.=C2=A0=C2=A0The issue has always bee=
n defining
> > a remotely generic userspace ABI.
> >  =20
> > >=20
> > >=20
> > > The most obvious way, but not necessarily the correct one, would be to
> > > add
> > > a new channel type called something like IIO_STATUS or IIO_FLAG. Is
> > > this
> > > acceptable? =20
> > No unfortunately. What does generic userspace do with it?
> >=20
> > Part of the problem is we don't have a channel type to cover flags in
> > general (if we had digital inputs packed into bytes we would at least
> > be slightly better off).
> >  =20
> > >=20
> > >=20
> > > A more or less similar burst read function has been previously
> > > implemented
> > > as part of the adis16400 driver. Although a burst read will also
> > > produce
> > > diagnostic status data, it was ignored in the driver implementation. =
=20
> > Yup :)=C2=A0=C2=A0Couldn't figure out how to do it at the time.
> >=20
> > Normally these flags represent error conditions (if they map to events
> > in IIO then put them out like that).=C2=A0=C2=A0The problem has always =
been that
> > Linux doesn't actually have generic simple error event handling.
> > There is RAS handling for servers, but who runs it on embedded boards
> > except possibly for some form of EDAC.
> >  =20
> > >=20
> > >=20
> > > Looking forward to any suggestion. =20
> > I'm not against us having meta data channels, but they pretty much need
> > to be as tightly defined as any other channel.=C2=A0=C2=A0The other sid=
e issue
> > here is it's a new 'huge' space.=C2=A0=C2=A0However, I'm not sure you a=
re in
> > that territory here.=C2=A0=C2=A0Looks to me like status really means er=
ror.
> > If you get an error, mostly it's game over.=C2=A0=C2=A0If you get a CRC=
 error
> > and want to check it, then drop the record and spit out a message.
> >=20
> > So I'm a little unconvinced as yet that there is anything we actually
> > can use in this status message.
> >=20
> > Jonathan
> >=20
> >  =20
> > >=20
> > >=20
> > > -Stefa =20

