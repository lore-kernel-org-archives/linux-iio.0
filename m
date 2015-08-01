Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35491 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbbHAT6B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 1 Aug 2015 15:58:01 -0400
Date: Sat, 1 Aug 2015 21:57:56 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 2/8] eeprom: at24: use
 i2c_smbus_read_i2c_block_data_or_emulated
Message-ID: <20150801195756.GB1590@katana>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
 <1435916017-12859-3-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
In-Reply-To: <1435916017-12859-3-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +		if (at24->use_smbus) {
> +			status =
> +			    i2c_smbus_read_i2c_block_data_or_emulated(client,
> +								      offset,
> +								      count,
> +								      buf);

Please ignore checkpatch warnings for this one and find a nice readable
way to squeeze that into two lines.


--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvSTEAAoJEBQN5MwUoCm2/T4P/i6/AIs/wo0ZLNCEl5GKUDnv
/xSwVvJc25837a3HkhIPzlpu+mfoUAzX5VQBrnF+uKFZADr8F7n6wpeT53w5RCGJ
HaC6wpOpSQEN0IrB1V04f4Ek3dt2nUUEi+t1+fZhQn5uRG/k4YKnEx5zp+7K8NSO
/x6WsI3GEZWSTI7+gBfGf3d54pg5XJQAoYB5RnOXASP9Uh3WVqzNtfDRGfH3zzFD
Qb4YpQDrlaAZXo2ywa+zcACbDRQP5XnWxzc9s3apj1LImiym+6M/VXh4Gpr6kt/W
ohY4opxUNROCCeUkmbQDIK31XAbe37aOqacIttTlqbmigkJlACYOS2VaFW6x09Gk
Bq3DGt66loou7bVB79w1Ch06oVjs74x8suCTukMBAeemjHcdoV7gpCHRaui3HUNR
OaJgy3gUQFNJS3D3eiDLnVDPcS8KhMj3+oZMyS0rfUFfbwYYdHJTMboBGasAgmDI
t/x3l9RqEUSy/0ioGmLzXnxNC9Vwp68PWCmCkVIKHZFJl5siCpR740KhVhKZ3nz/
VV9s6R+Jah72Es9iV9Nprsyxth3jne3fdiTYxRT34ZPQTEettUzdjeXhlHmMHacS
dfZocPohWHoXTUM3Ly/sdjA+f7/Ms6SjrZo8ALoxMYo6Utu8mREAShxp0gRJNpzI
6tB8y+HFFcXH7OYMZttq
=2vqt
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
