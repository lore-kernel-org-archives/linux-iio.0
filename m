Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE283CCA15;
	Wed, 24 Jun 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312432; cv=none; b=LyHjiHgJdE9koQ5onhn4ioftErrtaPQEcDQv/2n9nbzQMWm3c2s1513WeEBA2J4FMhDTOM+D6dTRQy8CaIhO2+onGJp1gp1+jhrFdxFTA3d8d9OAgFMnNpRP6EofTotCQLwsIuSBPpj04eDoPyfXmXtz30CNFmu8XI0IxzHCweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312432; c=relaxed/simple;
	bh=b83vd6KPIC5ZsCxUK9aSfpbv7XAx9lhJYPveEjRv8Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZmnpaNLmF0Q400hFiEosXxGHyCVxN0QuWduzxE3vzvK7CSSC7ArFO9T+aqAJf5UnVC8xTaUm/3iS2Ib8TPJwlXjKqdbI1TRQ+4WRC1xLTow3XWFG8ZtIM7N8Etq9NK8UnijIqDIYgWa1s67JWnMMqh+7aA+szmF+zwGEiq01Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=ZVykrv9+; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="ZVykrv9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1782312423; x=1782917223; i=lukas.metz@gmx.net;
	bh=ZJ0yZxYcfiXSpEGRdwwCgv91OZx9waeGfd61/KpfhM8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZVykrv9+AS/UVewcaWMAwNw1lpXrcwtHdn0Yl4kySH8rhLGiNexF6Aow/xEB8IiE
	 ehqvBnszjyMXlPeuNGtJCh83zneshDLRVnpj/M/E6TQqBmUmunWw3KHWN7WRvUwxt
	 ISZaesFaxgm/gdMlSl1gFFcoifc7at/7BL/xUXYW/1ghxx2YzSNUDlwfF3s2hqluc
	 2iAObEA2vuTxJcqUFoPaNp8e/bV8TvO3d0dMb+pJ69L7sAHvBIQsYcB0l6Vw8AgiN
	 F3Hq19rMp4Y7RF/e4B+EnrJy3N9u1FSgOqGN/IrMJzJ/E+W65iXndZ6clklpFiYoy
	 pfqIpJEJhBBRHmHQIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1x9nce3QY2-00ilXo; Wed, 24
 Jun 2026 16:47:02 +0200
Date: Wed, 24 Jun 2026 16:47:00 +0200
From: Lukas <lukas.metz@gmx.net>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <ajvt5J5Cs5cOdTLt@berta-MS-7693>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
 <ajrg62FtXNObGkmc@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajrg62FtXNObGkmc@ashevche-desk.local>
X-Provags-ID: V03:K1:hnfAxXg9zFxBMPrLbWJlQYV3HQYjiD+QKSq5K6Un7URwWeAAWYZ
 3bK7aO0n16UDN6ZIVMQvLHU+u3xkF+mHDalRxj1kvkZnUtT9G+lvyGvANKmOtDxCgeVc75q
 arCF773GyE2lTNNGKdpYQLAhTJYyx475FMLfzwadydVW1y2KYi8qpTzVyP07l+T45HdvIRp
 AbJDsB6kRTYo3JDs6cJxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oXga12SGyp0=;Hbv8D/1dSWI+JfSEI6c3YO2TUTq
 /dvlzhCzbCWoBm1biIDbO8KAdy6otPJ23Own1zNDCu89JlAgPjRhjNGAPKOCX7Sw/HQ9E9BQ5
 hEVcIxvVW3j4PB4MeJpyron19jzPTPJPw6Godl3wpmrsHs6cHms8Hgi5OYlhW8ShEP43U1r3g
 T8wDtAZ0y3Z8t8OqM50nl977pCQNMGgw1cZXXTS4wXwnSxibQW2ozXAMmctIGmmSIm0len1XK
 tkLIMCxmIj84+OsH9RQVLzWUKpJQN+rDa2UdXhiP84ZePq1abfEYmLzw5JXm5N4y8iJ68b0Vs
 IzdS3jpi/FNnxbyFJKdjIV0xUg1vjZDAKA5A/8XSsdwWeknr/URvKPwEDc8fk9rPUH3HMZQyi
 AHjONX617160KnuRSYeceWm+gpUNAhID8CZotuNcqTO9Sj0TOqokSaZ+zKwvbGisIvGdrNDdi
 C2CY8pAph12jMtqknD21PFB9vHmskLl5gkQfWwBQkZej1pFwuo40ubK1yeRpSpdu++GByhCPB
 0QHb53FDzj2zEtCHkNLYP9cC4KAlkZaFn0dTpj0GTKKmNoVNLh9QZk9qel0pA1Q8LTW2sTJpX
 QdW3mJNSYTErN8BavYfE0njlynJcZ7gfOmrneMfIY/KmiRAnAPSft0m8b/UD/25N4IQpqdjKn
 aCKYq8jUUbELMXTPjSMLll9Zu7KaIUcp9/2zrnd8sq+llxuXY8eS1UI/iyZxmR4Bqk8oEEs0l
 Ph2jheknSucgycN87ihltflGs4DyGYotRAxe4pan0WYuwqUroYbjW8UWNm803jwtAMHGZRYlS
 NapnF3A1QSTjCDQIsvaZs/Jyxqbkfbo+uvKQ+1YFQqpyevx7RreYGyxMqlyDVJzWAFPMTDSbJ
 CsfgR2E0UoPrNqusulOiibo41vCICs8Z9yy4M6asIBW+t2h8AnMJ2j/sijbq3OaMaPZi/QxPf
 MG0dScb0VLfUuRAkIOTmRuZZY57uR5aEbdW4bHFvf0cKoFwATE0w7VtlrVptR1O1vVxHIT08h
 IvG2WreWAOmpHkTWdJY/OlSfnzUWwfcXE9DR8cMRlqG1kY3ZqUq9/fOpIwFyxvNN1NdnotyId
 zfuD3f2HPT33AUo7zrNXvdy3aLfvg2XC7N8c2ANTq2SuZ5y57ICir3SaYancyv8z9dfB2MEFM
 3o9ML767czZXxYtGfGGjq3IJanN/hUTCHM/IF/hkTLfX0qSDFNgv2QEPtSltI+oXMPjoBKR0x
 QjqlVQbn8vjd0BPTG3l62YU3zp8Qmk40a2tP268TZsZ91x+W0zM9UamBJtnL/pzJk7RJmtfMF
 7jilnIzXk/xwjiNaiokRPUWsA4ABQePSNtalLhEkYdXckMNIXysfatDpqQS5c7zY751BECGUe
 9vUVNH3hxKN09YvVC2mF8BfRCk5NFcqh6lHOKahIxQpcjdHehWB8c05NSL/Og3eVXLgZ4Q93F
 dfIs1ZRHfW43mSD0zNOeMsYm34k4nK3U5SXwLY/lXd58AdYLKzwah/cUnZOqWmuQcKxeHQB2E
 PBZCiB6mrxEOnD+Qux83VD9j+MjMd2QNYKH058mmkN/MqG0yEJaXgzEuGIiVMwKs8C5kKXE7E
 ENBCruaQ7Yqd/RUi7boMQgsgfzQI/aecMvp2aB6kyIdv3CinpKblZIZt5kj3dqqlgLH9wZRqf
 u/3y8YRtFC9zEi73+QkFdC4worwfyGLO/w7Fqzn5jtwLI2X765AJSVRs8tlm89r9oq+v7hYHW
 LKQNogeQzAwLtL9J4vxklfunGmymsfGStLcMJ2AUjFomiR6ycrRBICDh0uTs5h1a2mvQRQPj3
 hmgkt+zsQXWhFN3BewOaqggjZCutAe2fr4e/Ts98k4iLF0yg+WHlfVfZyvzeAFPneK9RsXG85
 bWdIRYZNPwFdwjTTaAt2ZmU/a147eX540/2mmMG5QFmTkI0fcpWH1z68bbDon9YqdiEIdMRFr
 /0THXGJygqeVaAiIznYip74x7kmsgKlKQvTfU6ANFUH1zINs6/n729Cb65GZVc+XA3Djqhgv8
 6RW55Z8c2DAX1sBpwyQYHPKwBwpim46gtj7ZJz9wk862rLlahvkWZ3nyN5nX7YkWjBylvYlV6
 mjuAaLf0aJNXbYNqgtL4cNma575ajZ08jskDxQjcKkktf0VF2j64I2wpzqfNk1eEgvfJSsd5+
 RDePxP5jp6f6Us+fxBH8IgA9zqTCQsXPtjU/yyRfHJu3OAJQogMr/YTiQq792H7Vcwpky8lMk
 SSx6/r98nkjy7+fl1/44IrsyGplonTa7KGbr6Qk8j+tX+c4TYO0Ksfqr8+U2s0obmb+VmVJOe
 PIMQ1VXrarbg2u6utjQOsz9qpja3HZcLE2jE6EjEuKftvEj2cfnb5WjDeZP2DHj3R6QAQzI9U
 954kqYIIy9xfnbNz+QJ5KKaF0kTKIvtdg+MfO6CEe4svgurBQfpcx+xFzwhYdkL2busDcehEg
 K9TXf1XKowpUgugZH0Y+JwCLVboCk63OlVl0/jTzYhBVzA8iAuSMKjfrJM+7jb/+uHbv49oGa
 MSUd+0GxuTGUp0Akkx8PqTIYX7O8uc5QYa0JSr7l0ZsHJn+8MgEWzfsMuMBVku+b6oL0kIbTq
 Lf4ovgOBoNGrQ5mjHCU5rBGhbyDVtCT5LPvn5YRIsTawAblE4sKRtKratvMiQGoNVmxgLPQiR
 R0rfY84FFhsT6UzncCFEO+INhCVpAECQn7tgACBOWjKwAcIQmqY+ua0DGMF56yT73tgwpSSR/
 m0L8v2zqVo1gX1KreUvlmK7FSgq9IypEGpo8macsz0V5dBJi825J3faXkLfr747KHS5t3yB5r
 egS1tqqrCMLI3JkZVdN6ROICf9YyTLNESr60ITpOAvKm5UF+1fpIDOHyezaze36gycL7Cs7Lg
 vQ53fX31V1U3orBb9zjUADq3Xv7EdCJdFYXHMXhPvUpuuiX5HQpmZRKWIEbqFT7k2UWV+Of0E
 vNbM62a+dnRa8O2ECqgyJcope9R3kUpN7ZeZn+9pObxCghfmm1rUu23Ds53EKYdGLwmw5biJ/
 cupgvQK2GIxDUfl2tbtlUJ8Kc6cWwMeZpy9e26zrdL9NUKYwKeYz+hhJmq/Xtcxh8kbNRaq6g
 EaVpmfS2ioHxaCDCAse1LC/DMctz8SDrtr+fi+zo1H5ebdVD+So3alCMykNSlSs75ps2vUZoc
 +7bciRDUdwNpNLV9BMAj7D3uoJ9yMgpZS6ozBM2Rg/MmVfAgg0+zA7KcRilF7p8+ctuwt6vBr
 khmYioHw6v7tba1GiJG1RhEZZv5N9OfITIbYl7us63KMVU3ouN6xyK9IARMWii617Bxd7xeMi
 k1P7ATUNBEEbCcHh4iEkVS88gTYznIowS7galWqM9Vc9F8A61gz5C92fqY16gBhK5H1adK7Ph
 KymUYcQ0t2HdVWJOgjUVdnc/8UVL465rljscZ1ciRK2OdEDkQ+1D1CTr6yzOCMKxlr8/eQYJz
 YkJfwYwCO75nAEmX1E6zTkYQksZd4JDillETpTyMqi1Jpx0tIlPV8zsWFgbHLWe80IG+x/ma0
 iLqGlP450Uuj5WQdWlXMbVFX7YdMEQCT34ZxWPQZjTTc1A0Y/sXQdWbHE30pZpcj7BHJM1EI6
 tQzPCXXJGJYGYWx6lbyxIuISfBLMgcXvyXZ5AhtAwbQSjuzBWg+nG/Wm8+PJkCOjZYIT7/xK+
 9tEI1CLj8p3yP9CAz17RO9RdYi+TYj1uogeKsBGavSHlkesJNMKGS6n7J4tqXEZnB4dm+5JoS
 KGDGsCGWf0NnriUEW5lT8mJJBQp7l5W+hajbX85NcaQZfnIoGwX8am6B24vcTzcOGBlDIJmAu
 tjQOjkrJSAxjxaUlAiv6N02gl37vjNs1kz55TMNku7OslGSH2X5y1rGpWDYacB0ggjbhG0vMV
 MBHw8UlY56VWslSDxbwFcYPzFZgQYY81w3WIo9PL6T53i8UoCn6e1Ybcjmqu8e3PBddtTrDIR
 UffCOeOZd6x5zNTFf4gkEcU+a8c7i83ouZdAEpA4Fs6/lOwR55KUjyXnfQ9dzqDIqiSpFleP8
 oxk9UMVPXJqkC+JmRoZgkridoNhuw1xgdyEnxkFKkDgKdJ54hA3NQMskrPxfs2Ym1xk1P6NHK
 ky96mg8Ngo2wNdmoT6AuDaYPQW8VwPRdwEWHQiNkveLdmg7ZShCj6RCqvbyqyc+aH7YDYEvU6
 qsFFsIPBdfq79X+JRyML18QA2CZ7+1x0o5ZcEjBWFKNh24w9s3wXtD7IpiPxepa13375IUO+X
 MBtqmsg6VBwNsIr7mWBf19nevrx/buY0ZBO4+NzS2gZXdlUuwNlRjTmABR1jOhqaf0hxnUhCv
 6HD/xwXR+6+jnlTkSyblMP8TbbDqGSDBZWUq2q8hmD5i0tNeTlgvKxl6MVNqHdi32/hFVqDjd
 JshBsRPpdbY/4IPCXp7a543elcF5P0Foyg9jzStHAigfajL6gd10mpF8GlzO6ifTf7sAi6J0L
 2pcQm+8NCSDz61Yzy5DvaBwEZxg9E2yCpxobyvdHkqwy6oGT30c4CXqZCtq/ypa/UU5bGMtn0
 4KM6LIIrjT/mVydqOgghchaJEfjTzIxUOkZm4J7nw75q9Gvc6JJdOEBHIwe8fp1bdvOZ8Z9Gw
 dFqmLA687ooolyC9Z9gVXU266qc1px0wucxYNbbvnzEaG8H2oaqHRwOxJ4Uc41retA/BEzg2i
 RhbcuaKJTDH28pYcTjHb7oy0AyOAVvOytoX/Ppz/fa56L8DyWNs9Z8arDrR10VW/aMWQjC1W2
 K9L1J01wTOMvy1U7rdIWlHqmu7gYyHPeONToyA+7mD8rrMSw/kQp9132Fw0vfYnHvM4ZbPt82
 ifTAtdhlatGyvURsthYZHxEGwHWOeQDGKMAPCPuI1Lvwps1JUVHUAkXHanumEMfVja4qZYym+
 g4vyu874oSe1zbFSEzovc7Yx2TytoWpn8A5Glr5j4LHp0kjWiAtfYLh9+uxx9xdNZH4uaidWV
 zWJeFw/16FtsFpfdaHZqDuLGaJd6g05W5epx6NG6U3z6jYGrtTEhCv0SOkMAUza73QelHkCsL
 UqhX8mR1R73/RDRAWW4Wh7CTLUKEWyWy5k3oOVvHWVblIKOXCZUoOhm9Cvs263CQoPvoiBZF7
 UtrTOITCzZ7ARHx2mOLIyQokJ3bEfN7rnL89XeTbrI8BrTQVfPwlAE4+SMHkrmI2B7GVWWZ4E
 1XKhQfcAVUCgdCS+EhesTSDbvQZeOB6JY3f2pzC61xt0Mg3edB4HddbrOQnSATlUngzirOqcp
 B82tbodloDuvShUmtV4tYE6ZEsD4Yaddw3j0Jed+uVjQ2YuohdkiZhRvPGdCBpSu0QS6Nq8h6
 GkrbcjWR80sjxTvV2+TF3eKkLtdN/+Ibo6WHcKn8+f1T/sJNq71WQBCVEEa0ZNCL5O6w2GLJm
 XL4plOMcdCW6kP97vtKhkOMQ==
Content-Transfer-Encoding: quoted-printable

Thanks a lot for all the comments.

On Tue, Jun 23, 2026 at 10:39:23PM +0300, Andy Shevchenko wrote:

> > +		dev_dbg(dev, "%s: val=3D%d val2=3D%d\n", __func__, val, val2);
>=20
> No. Is it RFC? PoC? Or production-ready? If not the latter, come when it=
 will
> be production-ready.
>

I will remove the debug print. I tried my best to make this driver product=
ion-ready.
I saw that other drivers also have similar debug messages so i didnt
remove it after my first tests and thought it is ok to leave it in
there. My intention was to try to apply the suggestions and comments i
get and send a second revision. Do you think thats the right way?

Best regards
Lukas
