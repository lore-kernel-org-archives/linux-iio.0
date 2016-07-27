Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:37987 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757485AbcG0U3f (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 16:29:35 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id 3s066P1ZFFzwTJ5
	for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2016 22:29:33 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 2BC25538D35
	for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2016 22:29:33 +0200 (CEST)
Received: from [192.168.178.23] (p549AC00E.dip0.t-ipconnect.de [84.154.192.14])
	(Authenticated sender: giorgio.nicole@arcor.de)
	by mail-in-12.arcor-online.net (Postfix) with ESMTPA id 3s066N6ylKzXfn9
	for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2016 22:29:32 +0200 (CEST)
To: linux-iio@vger.kernel.org
From: Giorgio <giorgio.nicole@arcor.de>
Subject: trivial error in ti-ads1015.c
Message-ID: <b6dd0816-074c-a2a7-4e2c-55e417dfcf77@arcor.de>
Date: Wed, 27 Jul 2016 22:29:28 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ErcqfowDRU0022CC9tdb5VKWf90h1sMaO"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ErcqfowDRU0022CC9tdb5VKWf90h1sMaO
Content-Type: multipart/mixed; boundary="uog79T0pF4H4OirGMD2gs5k0aSgcpQLSB"
From: Giorgio <giorgio.nicole@arcor.de>
To: linux-iio@vger.kernel.org
Message-ID: <b6dd0816-074c-a2a7-4e2c-55e417dfcf77@arcor.de>
Subject: trivial error in ti-ads1015.c

--uog79T0pF4H4OirGMD2gs5k0aSgcpQLSB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed a trivial bug in the file 'drivers/iio/adc/ti-ads1015.c', in
the function:

static int ads1015_get_channels_config_of(struct i2c_client *client)
{
	struct ads1015_data *data =3D i2c_get_clientdata(client);
	struct device_node *node;
=2E..

The pointer 'data' is not correctly assigned; its definition should look
like:

	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
	struct ads1015_data *data =3D iio_priv(indio_dev);

as is the case in:

static void ads1015_get_channels_config(struct i2c_client *client)
{
=2E.

giorgio


--uog79T0pF4H4OirGMD2gs5k0aSgcpQLSB--

--ErcqfowDRU0022CC9tdb5VKWf90h1sMaO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF8EARECAB8FAleZGagYHGdpb3JnaW8ubmljb2xlQGFyY29yLmRlAAoJEGKm3Nod
0+VQK+MAnjJBpZGJrzmrg8T/Gl1JdvfPhXj0AKCnGEC0t407U6my15IJoTxm6Vou
pg==
=bZTb
-----END PGP SIGNATURE-----

--ErcqfowDRU0022CC9tdb5VKWf90h1sMaO--
