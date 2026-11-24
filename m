Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506183;
	b=yEGilwj74XK0+zz9/XGasKqloNXBvKjlwtthtYx37l1Fpkao/HCpksABFM2b5l7lSPLo
	 vImjGGzkt9MyBb61bfiK1rVd93B8VkHkf76nXtF+39bgo84tI4GzFRBndd3hFO0a+KDCG
	 qx8bImz0woxCiEo2Lxt5laBtupI8YuzlBxlVFnsp6KQLX8pXBZpmQ7y98zLuDwHQRqyNr
	 6LRqTuCvL09gki15HmkrK1TFPb7bA+ImwRFdkWa9CJukX12L7UVejf58aWgZ8kcRUT/Tt
	 JStu9CHQ2ODvh08lShv0/kyfBbSe3QtVh07MnktVe5Z0rQGkVn5spd4/WpEr4iYC73g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506183;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ofMeRTUK/d++vd0VVb6NYwvSqG1R2k68vtR0bdVpuMU=;
	b=XtwgDvGvN8mOcv7s3DrEDXfDKWsS/XiKW+4qyldSgFtwPF6AnBoBHSBdtRI9UgNHRId8
	 RhS/ikGCkfLihtdg3hisDTHLbAFRkq/qTZgetnyjfWIKm7bt8ZxR1KhX4RF+PHOpGSvP4
	 4NfRGYqdyJgnhKtvQ0iDgwngNHQoteX0DgGu9lX9s0sSlOMyy/WKsDtvmupI+/IiizEaW
	 ebf3wYgQENomCjeFCMEnjAOEXH054sAfIOml11/6pUBz/H4QejRjBgw4mU4DSoNVoJ3LS
	 840nOykmhtThB+7/CdtiF7nsvW7DAu/+JXE3uYjGuvxBBpUYTrsE0GxuL26Jg5DCW6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=llM368uR;
	arc=none smtp.remote-ip=91.218.175.239
Received: from mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D003B606A31E
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 07:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D003B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=llM368uR
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nUm9h5NzIsHA719PM5aMKgjtiDgEeXdY3gm36qPN1JU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795506180; v=1; x=1796110980;
 b=llM368uRlmFVfBP2Dh+llK1cRQmLQkZJeCtK//yrYnm4NIdrbVZ66yOBt/Hoy9sNl30/F6wv
 4KKWh6pcTyjIMDzkW0IVaiwSffcCGBmNB18DbWC4pRHgeO0iYpd6+fMxy3PX76BlssAlEGjsumk
 dmF1/44D0JsdPKfiTNuh3lN0=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 48930a964aa0b930;
	Tue, 24 Nov 2026 07:43:00 +0000
X-Mizu-Trace-ID: 48930a964aa0b930
X-Migadu-Flow: FLOW_OUT
Date: Tue, 24 Nov 2026 09:42:56 +0200
From: Petre Rodan <petre.rodan@linux.dev>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno S?? <nuno.sa@analog.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: accel: bma220: use
 iio_debugfs_reg_access_regmap()
Message-ID: <awU_3xHeImTF_N7n@sunspire.home.arpa>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
 <20261124065016.185124-5-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgE9aJuT6iuBwFGc"
Content-Disposition: inline
In-Reply-To: <20261124065016.185124-5-zoone.rupert@gmail.com>


--dgE9aJuT6iuBwFGc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello!

On Tue, Nov 24, 2026 at 08:50:14AM +0200, Rupesh Majhi wrote:
> The debugfs callback only reads or writes the regmap of the parent
> device, which is what the core helper does.
>=20
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
>  drivers/iio/accel/bma220_core.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_c=
ore.c
> index 23eff578158c..d2f21c0ab491 100644

passes all my unit tests (which do use debugfs regmap access) on both i2c a=
nd
spi sensors, thanks for the patch.

Tested-by: Petre Rodan <petre.rodan@subdimension.ro>

best regards,
peter

--dgE9aJuT6iuBwFGc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJPBAABCgA5FiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmsFP/4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEHQrJ6djOkljvhoP/35lNBdRKJKcMl0l08Gj
J0TxKq+1Ky7NjIocC9ND2KYZBadBWOn7gQWXyExKq9X7Afwoa/W7wVUjrdsM8RhE
JAZcWLyf67x/2vg01Vmvqmy2PfBdKu53H/oTKu9er3exwcLRRn02gAjHk06PGpv3
3q58yo+nbHpiW6RoAD3LH7/4W79xAdMIAUUj/KAepEswL6C6M3XYzIazKI+AdUeJ
CD0pAKL5ftTTW05lJZpA1NLU1g9Y8ldH8vRjpRKKqw4qNNfSNSQGO2X33fOoUx8O
/uYLd/kxmf7gZe6uX8rxdyNJE0bTK5aDofcTjj4GBw5vgsGPXwubmpTij2V27Lf3
qs1jMHb7te/X2eSzIPxojitu73q6Gwk4lJcIr83PpJQIV4fr+akho5V4nffD+SKO
zk6ao1Uki8YUARVNx3k2KIiUgoClz10EPpYNWTD6G5ShcOYIw86oi2FSnrKNY75A
JaatuLTYbmFkcJ+qrC/KGhaJMsca0gIp+0wcfATIko0sd4oHEa1fejlh+hvjAnFP
MVX6ljDu+DcqVPgPbwkywAzGhg9nB4/en7ir5QhJCFZgtmEsOXm6ixE5NCkZ7lgF
BzpsC7r1XXUVEnL3eICeAMPDBxvB9wANPy14VE+oZukmRM7IirgnjN5o6bbGcMoW
qWQrXppWcGjzNJ1INevcCFec
=+nKt
-----END PGP SIGNATURE-----

--dgE9aJuT6iuBwFGc--
