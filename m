Return-Path: <SRS0=iV6u=XL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B73C49ED7
	for <linux-iio@archiver.kernel.org>; Mon, 16 Sep 2019 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179422171F
	for <linux-iio@archiver.kernel.org>; Mon, 16 Sep 2019 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568636541;
	bh=yHOzbpMEcbwauiIBvQWvyLa2ON/RzJ59C6+M1cS66lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H2/s9D/b0ta9ecyevPGY/93QocW4O/n8Q8gSzcwI61UINCOZMYR8DNVCpUqCPh7AA
	 H2+F8RTjOc1HHFKy4+/BozMCr8E2pT73Lo4VynC7kf9rndtZubhtx0tN4WyIDuUuRC
	 AjzTonELAJqkO26uBIWzlip3Ae0hNqRanH9aL0io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfIPMWU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfIPMWU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 08:22:20 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1007216C8;
        Mon, 16 Sep 2019 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568636539;
        bh=yHOzbpMEcbwauiIBvQWvyLa2ON/RzJ59C6+M1cS66lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Icn4J+qdTahvsgkyvsvWTs1BvyGizRYrZ1JlD7q6vpZUx7IfEaUWeI0gWBy6Dx5K/
         lo3v8QOTXBGwuExgp5G8gcQwmaQjEGERVhdhnh6T+Jd1d0MMlHC1SWKTVRs1kJjjXJ
         ICLrpwferpolBnKTjai5ziZQfGHM4ZH00golXIjw=
Date:   Mon, 16 Sep 2019 14:22:14 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [RFC PATCH] iio: imu: st_lsm6dsx: filter motion events in driver
Message-ID: <20190916122214.GD16063@localhost.localdomain>
References: <20190915143548.25383eb4@archlinux>
 <20190916090222.597444-1-sean@geanix.com>
 <20190916091649.GA16063@localhost.localdomain>
 <07c96bca-f952-71c0-4608-30746fbbc055@geanix.com>
 <20190916115538.GC16063@localhost.localdomain>
 <88815877-abde-8e2a-cb3d-fabb556ad7e5@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <88815877-abde-8e2a-cb3d-fabb556ad7e5@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 16, Sean Nyekjaer wrote:
>=20
>=20
> On 16/09/2019 13.55, Lorenzo Bianconi wrote:
> > >=20
> > >=20
> > > On 16/09/2019 11.16, Lorenzo Bianconi wrote:
> > > > > +	if (hw->event_en_mask & BIT(chan->channel2))
> > > > > +		goto out;
> > > > Why do we need this?
> > > >=20
> > >=20
> > > Guess we need to check if 0 < hw->enable_event before disabling the
> > > sensor...
> > > > > +
> > > > >    	/* do not enable events if they are already enabled */
> > > > >    	if (state && hw->enable_event)
> > > > > -		return 0;
> > > > > +		goto out;
> > >=20
> > > static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> > >                                             const struct iio_chan_spe=
c *chan,
> > >                                             enum iio_event_type type,
> > >                                             enum iio_event_direction =
dir,
> > >                                             int state)
> > > {
> > >          struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > >          struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > >          u8 _enable_event;
> >=20
> > please use enable_event instead of _enable_event
> >=20
> > >          int err =3D 0;
> > >=20
> > >          if (type !=3D IIO_EV_TYPE_THRESH)
> > >                  return -EINVAL;
> > >=20
> > >          if (state) {
> > >                  _enable_event =3D hw->enable_event | BIT(chan->chann=
el2);
> > >=20
> > >                  /* do not enable events if they are already enabled =
*/
> > >                  if (0 < hw->enable_event)
> > >                          goto out;
> >=20
> > we do not need this since there is the check:
> > if (hw->enable_event =3D=3D enable_event)
> > 	return 0;
>=20
> I actually think this is needed as if a channel is enabled and another
> channel is enabled, then 'state' will be 1 and '0 < hw->enable_event' is
> true. Then we don't want to do the event_setup again.

got what you mean here, right..just please do:

if (hw->enable_event)
	goto out;

>=20
> >=20
> > >          } else {
> > >                  _enable_event =3D hw->enable_event & ~BIT(chan->chan=
nel2);
> > >=20
> > >                  /* only turn off sensor if no events is enabled */
> > >=20
> > >=20
> > >=20
> > >=20
> > >                  if (0 !=3D _enable_event)
> > >                          goto out;

if (enable_event)
	goto out;

> >=20
> > we do not need this as well
> Like wise here, if we don't have this and to channels is enabled, if you
> deactivate one of the channels then enable_event indicates that a channel=
 is
> active but the sensor is disabled.
> Guess that is not what we want :-)
>=20
> >=20
> > >          }
> > >=20
> > >          /* stop here if no changes have been made */
> > >          if (hw->enable_event =3D=3D _enable_event)
> > >                  return 0;
> > >=20
> > >          err =3D st_lsm6dsx_event_setup(hw, state);
> > >          if (err < 0)
> > >                  return err;
> > >=20
>=20

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXX9+cwAKCRA6cBh0uS2t
rORVAQCmz1vWt8gaPNIFgU5Gf0BcqlVbhq4rlSsY6hcLJ/yJtQEA2sa9U3Vbk/HT
sIAAjWTIahfpmhLfZ3z6elj+WeyApgY=
=DgQT
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
