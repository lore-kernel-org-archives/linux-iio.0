Return-Path: <SRS0=NPK8=R3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F419C43381
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5FF21741
	for <linux-iio@archiver.kernel.org>; Sun, 24 Mar 2019 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553450432;
	bh=DY37NVQP+ZaipbtOBH4KojxY+dftd01isocVPJ6Rn3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VXd7DuPqjszc2EC3ag++i1ITPBX5Rw2QCQMotfNSE8x9S79TdlCiDF7WyWw3Z6JVb
	 4Ko9PWl9PgjcQrVlrQjVJM/a9wwl7m+EEcvOXSvX7osQQel6EXXSyw4fUg2fK0yZcM
	 3Ba3Q3qdydqlpIYjGXNg342DjdqhAITpCE4phUVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfCXSAb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfCXSAb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Mar 2019 14:00:31 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116202147C;
        Sun, 24 Mar 2019 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553450430;
        bh=DY37NVQP+ZaipbtOBH4KojxY+dftd01isocVPJ6Rn3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hYKmUVTUHQ8g4e8LlWQUsl+oulB2Vqzc2S7t6DCKWuO6F4mscae7g13OT5FuwIUtg
         EfTfZS8ZW4ujyFwMPuZCIG5Oj0HjumCQvhtnvxJYqZjqEw5+/i9oJIQF7SxJ968g4E
         Y8dvjXHZGNO7J3wIY2pRSrfsy2az2an8GoO7XZQ4=
Date:   Sun, 24 Mar 2019 18:00:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: Re: IIO channel type for status/error flag indicators
Message-ID: <20190324180025.77aa8426@archlinux>
In-Reply-To: <1553093626.13791.37.camel@analog.com>
References: <1553093626.13791.37.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Mar 2019 14:53:50 +0000
"Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:

> Hello,
>=20
> We are currently working on a new adis16495 IMU driver which is an upgrade
> from the adis16480 family:=C2=A0https://www.analog.com/media/en/technical=
-docume
> ntation/data-sheets/ADIS16495.pdf.
>=20
> This new chip supports a feature called "Burst Read Function" (page 13 in
> the datasheet). The burst read function (BRF) provides a method for readi=
ng
> a batch of data (status, temperature, gyroscopes, accelerometers, time
> stamp/data counter, and CRC code), which does not require a stall
> time between each 16-bit segment and only requires one command
> on the DIN line to initiate.
>=20
> Most of the data read in this way can be attributed to a type of channel:=
=C2=A0
> IIO_TEMP, IIO_ANGL_VEL, IIO_ACCEL, etc. However, there is no equivalent f=
or
> the status and CRC. The status register provides various error flags such
> as spi communication error, sensor failure, sync error, etc (Table 18 in
> the datasheet). This information together with the CRC error should be
> exposed to the user space. What is the best way to do it?=C2=A0

Ok, So this is not exactly unusual.  The issue has always been defining
a remotely generic userspace ABI.

>=20
> The most obvious way, but not necessarily the correct one, would be to add
> a new channel type called something like IIO_STATUS or IIO_FLAG. Is this
> acceptable?

No unfortunately. What does generic userspace do with it?

Part of the problem is we don't have a channel type to cover flags in
general (if we had digital inputs packed into bytes we would at least
be slightly better off).

>=20
> A more or less similar burst read function has been previously implemented
> as part of the adis16400 driver. Although a burst read will also produce
> diagnostic status data, it was ignored in the driver implementation.
Yup :)  Couldn't figure out how to do it at the time.

Normally these flags represent error conditions (if they map to events
in IIO then put them out like that).  The problem has always been that
Linux doesn't actually have generic simple error event handling.
There is RAS handling for servers, but who runs it on embedded boards
except possibly for some form of EDAC.

>=20
> Looking forward to any suggestion.

I'm not against us having meta data channels, but they pretty much need
to be as tightly defined as any other channel.  The other side issue
here is it's a new 'huge' space.  However, I'm not sure you are in
that territory here.  Looks to me like status really means error.
If you get an error, mostly it's game over.  If you get a CRC error
and want to check it, then drop the record and spit out a message.

So I'm a little unconvinced as yet that there is anything we actually
can use in this status message.

Jonathan


>=20
> -Stefan
