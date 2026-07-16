Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13B1FF7C5
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215857; cv=none; b=ntlMjk9GAfmtxqJy1mzSOMASdpjInO4JQIhLuAH3C+aj8ec4lrAqJHEhkY/phskUQ6T6xV0CwVOKHmnrlnNGZcngGXW0JeTEVVdFbeKfMI67c775IyQbUU5uhMtgOIVn+TbnnDH6tea5vMEeymm7n0IrkyBc4QasSlDm5EeQpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215857; c=relaxed/simple;
	bh=6d5SxKF9c6pJQDFTDepqQfBLcy3z0isPCjndOLtk+ac=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:In-Reply-To:Subject:
	 From:To:References; b=kjlbWTUip68m1vZR4Q0Ce4PumPNmrpdARsUASComnQxc1dYYwKrKHsN5Sx+WCUJdUUm55yvex89GiJjt3rjvjr5TDbZTK8LHm4p/cdStLXCGb/6cg+Wvs/woKbubitz8cidt6x20NcUIChcWeoC9x+KlBYc0LLHeAwTWVDDP1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=R9JG3No+; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kWSfbjdo; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="R9JG3No+";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kWSfbjdo"
DKIM-Signature: a=rsa-sha256; b=R9JG3No+XiQF43rerjr1wbC+Xvt9UXGgAvvqQrnWZDaySS3AeZ32j1MgWNerJD0cWxJCoK88SqOhDWItSCA6NTE987poDpUTtnGg6qmE/8pi57ushXFmVnfV2C3mkALIu0qb2PKx21k2Sz5u9EcyrHRNeqFV82hcKaHJ0cOEzsIUCJ63LRfklOoljBqUVsbOeTr2u8f7IVmAWA7J/FmFRBCFTw1RXr7NJhX4hCwRF8LfkcGguT3Y6R9oLEPe5mFN6aXvurIs6LJC31idOYNJZ8FD24FQ6EhzXzKAFdEAYh6rMb1WQnfrVPU79847m3Kgm53acTFPR1x05j2Lr3mQ4A==; s=purelymail2; d=maxwelld.cc; v=1; bh=6d5SxKF9c6pJQDFTDepqQfBLcy3z0isPCjndOLtk+ac=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=kWSfbjdo6xQhUNum2ug86JEFcsHS1vqWIcvaGLD3QRQHtkBrjGImG5EXAb7pxa5yCaBVokCGYrP6PfbXwh2mwR5KWMj+FHK2omsVYmoU1Jw+IvbX+3WXfMEBdlbLhse1sk6felVkKi1z/5SjgjVeNF3iAi5Bj5yf9Qe1kF4c0s65zGsvpt454S1TXZnd3NZ7RBu/nL9IG2gqzXv0YU63yiGUb1r4O/vNpnsxgWF9EsAhdekhVHQQiTvYkfsxJ25LmhCJU6ykr2eYe/drSDT+IvHXE/RPiAan/VxfUq5o8WmLwIquBaEAh6eoGgDaMeaX3SRN+3tiiZQTsIs5CJnYeA==; s=purelymail2; d=purelymail.com; v=1; bh=6d5SxKF9c6pJQDFTDepqQfBLcy3z0isPCjndOLtk+ac=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1097519941;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 16 Jul 2026 15:30:51 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=321d551b64e195f5a3cce69929b112ea3ad53139b82720b7aaf27e32ce76;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 16 Jul 2026 10:30:43 -0500
Message-Id: <DK03QB4665XF.3RK4MG7Y9V9PR@maxwelld.cc>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>
In-Reply-To: <20260716005737.254577-5-jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH 04/22] iio: chemical: scd30: Remove redundant
 i2c_master_{send,recv}() length checks
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com>,
 <linux-iio@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
 <20260716005737.254577-5-jonathan.cameron@oss.qualcomm.com>

--321d551b64e195f5a3cce69929b112ea3ad53139b82720b7aaf27e32ce76
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Jul 15, 2026 at 7:57 PM CDT
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> i2c_master_send() and i2c_master_recv() return either a negative errno
> or exactly the count passed in, so a length check after the 'ret < 0'
> test can never be true. Drop the dead branches.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  drivers/iio/chemical/scd30_i2c.c | 4 ----
>  1 file changed, 4 deletions(-)
>

I'm not 100% sure that's the case but since the i2c docs aren't very
helpful on this I will probably pester the i2c maintainers about this.

--=20
best regards,
max

--321d551b64e195f5a3cce69929b112ea3ad53139b82720b7aaf27e32ce76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTMrEGfAFxnfnRQ/UIQghIb0dl/iQUCalj5JwAKCRAQghIb0dl/
iahEAX9HaRr7v+TKZI5Us8xQHOmpzTVTq0yKCzv7oo3OpborYOZG72Xf0AaKP2+b
Y+SMNNEBf1RHJayHh7oSW4Lesz8/gGRw7zdyRTW4nI2mJqKbnbQ2xDff6c05tsMg
xCT/6Bu5cQ==
=TIZ/
-----END PGP SIGNATURE-----

--321d551b64e195f5a3cce69929b112ea3ad53139b82720b7aaf27e32ce76--
