Return-Path: <SRS0=oppv=BF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D22C433E0
	for <linux-iio@archiver.kernel.org>; Sun, 26 Jul 2020 12:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D7C2076A
	for <linux-iio@archiver.kernel.org>; Sun, 26 Jul 2020 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595767288;
	bh=/R1WA6MYU7yIXIWgG6Dp0pWFqZroIqUxlvdzRdL25LE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oljy/zDqFiYIbuigiZNQ9W2nKfzPB1Cn+RWIN/l/UiAHBRoeY6XRMWMHlWb1dgVud
	 7MA32vVehkqk3hVyq765DSueyLuCt2w5/h8+VHZKaJ2Ulvw0vdKw/y03kybZozQd4h
	 obWT4ZWZAO3fo2Mcv9BXtiQV+ccoi4khgUh0Cr2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGZMl2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 26 Jul 2020 08:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgGZMl2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:41:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53ECE20789;
        Sun, 26 Jul 2020 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595767287;
        bh=/R1WA6MYU7yIXIWgG6Dp0pWFqZroIqUxlvdzRdL25LE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sXJN+kzWJlXZYaMiBtsToUBO5j6Ay5bXBTsfPZonS8ToEUofRFzr+t/0+A21dKKb9
         pgVFBfjzC/OBUIm0EENjxSRdAIiFzNVHsktfgBHijXvcZ/iSCIOIc1YsxjZPHPgLgM
         K4iH5kB5SLynpFkKK77vi5TmhUgRb2koVW4Uc7Wk=
Date:   Sun, 26 Jul 2020 13:41:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Peter Rosin <peda@axentia.se>, od@zcrc.me,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: afe: rescale: Implement write_raw
Message-ID: <20200726134123.456bf3ad@archlinux>
In-Reply-To: <7CJSDQ.D8SUUUMJPNE02@crapouillou.net>
References: <20200210225438.112660-1-paul@crapouillou.net>
        <20200210225438.112660-2-paul@crapouillou.net>
        <20200215183249.2100b6e9@archlinux>
        <7CJSDQ.D8SUUUMJPNE02@crapouillou.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 01:16:55 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
>=20
> Le sam. 15 f=C3=A9vr. 2020 =C3=A0 18:32, Jonathan Cameron <jic23@kernel.o=
rg> a=20
> =C3=A9crit :
> > On Mon, 10 Feb 2020 19:54:38 -0300
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >  =20
> >>  Implement write_raw by converting the value if writing the scale, or
> >>  just calling the managed channel driver's write_raw otherwise.
> >>=20
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>   drivers/iio/afe/iio-rescale.c | 22 ++++++++++++++++++++++
> >>   1 file changed, 22 insertions(+)
> >>=20
> >>  diff --git a/drivers/iio/afe/iio-rescale.c=20
> >> b/drivers/iio/afe/iio-rescale.c
> >>  index 95802d9ee25e..a48f6af9316d 100644
> >>  --- a/drivers/iio/afe/iio-rescale.c
> >>  +++ b/drivers/iio/afe/iio-rescale.c
> >>  @@ -35,6 +35,27 @@ struct rescale {
> >>   	int *scale_data;
> >>   };
> >>=20
> >>  +static int rescale_write_raw(struct iio_dev *indio_dev,
> >>  +			     struct iio_chan_spec const *chan,
> >>  +			     int val, int val2, long mask)
> >>  +{
> >>  +	struct rescale *rescale =3D iio_priv(indio_dev);
> >>  +	unsigned long long tmp;
> >>  +
> >>  +	switch (mask) {
> >>  +	case IIO_CHAN_INFO_SCALE:
> >>  +		tmp =3D val * 1000000000LL;
> >>  +		do_div(tmp, rescale->numerator);
> >>  +		tmp *=3D rescale->denominator;
> >>  +		do_div(tmp, 1000000000LL);
> >>  +		return iio_write_channel_attribute(rescale->source, tmp, 0,
> >>  +						   IIO_CHAN_INFO_SCALE); =20
> >=20
> > Why is val2 always 0?  Won't that only work if the backend device
> > has integer scales? =20
>=20
> Sorry, somehow I didn't see your answer.
>=20
> Indeed, this will only work if the backend device has integer scales,=20
> but what should I do? Just pass 'val2' instead of 0? Will the value be=20
> correct if I only apply the scale ratio to 'val'?

I think you'll need to include it through the calculation. Given you
premultiply by 1000000000LL it should be easy enough to do.
Then for the final do_div you can easily work out the val2 part.

I'm not sure we currently have an inkern interface to get the type
of the channel attribute value though.  You may need to add one.

Jonathan



>=20
> Cheers,
> -Paul
>=20
>=20
> >>  +	default:
> >>  +		return iio_write_channel_attribute(rescale->source,
> >>  +						   val, val2, mask);
> >>  +	}
> >>  +}
> >>  +
> >>   static int rescale_convert(struct rescale *rescale, int type,
> >>   			   const int val, const int val2,
> >>   			   int *val_out, int *val2_out)
> >>  @@ -110,6 +131,7 @@ static int rescale_read_avail(struct iio_dev=20
> >> *indio_dev,
> >>   }
> >>=20
> >>   static const struct iio_info rescale_info =3D {
> >>  +	.write_raw =3D rescale_write_raw,
> >>   	.read_raw =3D rescale_read_raw,
> >>   	.read_avail =3D rescale_read_avail,
> >>   }; =20
> >  =20
>=20
>=20

