Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ring0.de ([5.45.101.7]:43468 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbbJWSgV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 23 Oct 2015 14:36:21 -0400
Date: Fri, 23 Oct 2015 20:29:12 +0200
From: Sebastian Reichel <sre@ring0.de>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Remove .owner from spi_drivers
Message-ID: <20151023182911.GA14674@earth>
References: <1445608751-8432-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
In-Reply-To: <1445608751-8432-1-git-send-email-afd@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Oct 23, 2015 at 08:59:09AM -0500, Andrew F. Davis wrote:
> This series adds a helper macro to the SPI core that assigns the owner
> in spi_drivers so individual drivers do not have to do this, this is
> similar to other subsystems like platform_driver and i2c_driver that
> have made this change.

Probably it makes sense to also update the related coccinelle
script: scripts/coccinelle/api/platform_no_drv_owner.cocci

-- Sebastian

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWKnx0AAoJENju1/PIO/qakQkP/iBMf0gW76bpGYZ88bgGWHD+
hWF4q3PN8jQswRA4owg8gMqUuLkH/Yv42ISL7HA7wPyQFjpdUHSx3i3B+Obs1Qm9
K2+m12SZjYPh2R5LVtYIggQXID4mrcWlVnNfNEVYokrcCl+9BaZ+3JHZDWpum/9x
kLk5rAVUeD8iMp0TKSZgXhIzIlv+qlSJt8sNsrML7RlAk7EmlJrqcwmosknn99SI
zP1zIs92YjNh64/4lXO6BHhZFIFr4pCfQ8tLQGo4ArkaFJ2vRiEm1TIjWGBjhsg/
ej5N8JqSRLJtDjYLpRu9yjvHDgQuNYu27SMORUNF9Ytlk6OB0pDmkxlojs5YA8Uk
TBYmwXRO/e4ikMgCSoBK64sKktTiXxiYdwqWsPMZlDHHt/5QuOqZCczwLj5FN1Wf
Vi38JZ5KJyZmN7gaUS0LXDKR2A/FXkHsAO4BMhg6YNrQbDV6dLqiqAky8jMoDMYh
kWbRHEi+L4etey4ngyzP+JNMIFziNsAE0gPisHLcZXbiChfnsZBwA3lNmD8OJBWx
gZDkBxsezR8Tde1evv5lJ8xtuZVd86oWtLs4Ic4Wr6ElHZcI9P3PFrky5KP4I0sv
8AF6QJwOKgsMPp5n56XZuwMDiHtSjVcsOqlhBjGnoM1D/EvSfdBgnnKY65LW8tS5
MBSkaUR34hhJOlGnh4kN
=t6XM
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
