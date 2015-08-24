Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54390 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291AbbHXLta (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 24 Aug 2015 07:49:30 -0400
Date: Mon, 24 Aug 2015 13:49:19 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	"mpa@pengutronix.de" <mpa@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Tirdea, Irina" <irina.tirdea@intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v5 6/8] iio: gyro: bmg160: optimize i2c transfers in
 trigger handler
Message-ID: <20150824114919.GA3608@katana>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-7-git-send-email-irina.tirdea@intel.com>
 <55D056DF.5020201@kernel.org>
 <20150817090943.GO19600@pengutronix.de>
 <20150821102125.GA1656@katana>
 <1440172701.4081.1.camel@intel.com>
 <20150822040258.GA1605@katana>
 <55D8B174.1010403@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <55D8B174.1010403@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Do we want to insist on a much larger change (conversion to regmap)
> when if this in place, a simple single functional call change will do the
> job?

I'd assume that regmap conversion will happen later quite likely anyhow.
Most of those devices will have I2C/SPI dual interfaces; or people will
find out that caching registers can reduce the bus load, etc...

That being said, I'll keep Irina's patches for the next merge window.
But we should keep an eye how/if the new function is used. Kernel
growth is an issue at times...

Thanks,

   Wolfram


--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV2wS/AAoJEBQN5MwUoCm21IMP/2VVCfq52tdyyknr0oNhIrjD
redHw6gmXt2NATG6U3aF0AmJ6geHsd/Gmj6VhUqzfkNBGVk2ATr5BRSc4DMPMVhv
m2AYPcJbJErHzNRAjo/pb/f7Kol33Uc25Cr7dbvjqJEgiz/zrW/3voidMQhlsSrv
FnF/VpSO9h0NxGdY+NoOc8U+um2xezbhTNXpq4LAU5zvs0jBXW/kwSFKFkQV8n4X
g5SrIkbY3hDty2OLR6PM6DuBHgkSSh39WHpGhNlQWfn7GCND/Er9zRB2Yx3qxUJk
JGNXVaJ/fXUB1+T7Andmoy/AV2Jvd14JSi0C7Lf+695FHOwzcGduq4quUX4f5M2s
E17cifEN1aZJpTCPCD59aNTM3DY0kXq0YD8GYVOVuwocpdbqRRJNU5peQjsMfA0o
dxd24w31cr6/1P0CTV2iZj9Gp8TchCH8QPdqWlO1Vaq7AC/Zys/bbcYbpTVFSUGj
24x/6RuYKXQFvcSEFAeGekL07y/Fl0wh/KcIwv0/62L5NFaJa8HtGfqXk7MKfT4Q
ObFPW1F3wGd5TC9CRrFe+j66v/wROTphioaXndl970y06z9qTw5mCkUNF/wJ0dpt
rWl72Oyr6KjQ51z6wtm3T13687QmtE+3XDjgKNUl1zffTaJUZ6l2R4U1qac3yquY
PMJu5vq0pSqm3OebQ2xm
=NjqQ
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
