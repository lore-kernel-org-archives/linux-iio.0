Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D948B376;
	Tue, 14 Jul 2026 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041347; cv=none; b=T+1qaLV2dGapBE7PZLWDdRkIBUCTP0O03crTT7TTcW2oRaBvPIfMImF/ERENj+/Izh9GGXibg1W3NqGZ7TLdnkPeNTGN5jM7/2JjzZD78uA7Z5mr9egEuDlsFXY7giDI9seLHQgg2XTykW/IiZko5WlSYwcflc2xPW6gxudBOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041347; c=relaxed/simple;
	bh=7ydq8tqvtCmS4MoJgzQ30CjzBQK3fiFJdrakEbDu+HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw7tD8MbUFRpFTgIUlhk31WTFu6lRaSIx3HgFCEycyW+AJaKaMX9iOAWUaA1S0+OMi8eOSu263pQKhEbEW0rNtTYMmDvgp0V17aveHqbqhv7o8Lt8bIYzFqty6IjGUijHaWdH7mOjiYHcQuN1qmF+7QaaFWfGIS1STjWwz2+PHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=pjfvjD11; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="pjfvjD11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1784041343; x=1784646143; i=lukas.metz@gmx.net;
	bh=ubKwVAq2K+QIy9+ON18v+CC5wtcezZuw8XxfkHBCvgE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pjfvjD11Dz83WjqtBWnRlSaLDkEi+MWBfEklt8BmmvhksCeWL8zDh+5qgyPS8+gs
	 4E8J0pUrB4wrV2A3u1EHIuN4H9Ojg43/Bfo0y3eOi6x1eMu/NZBFdz96ORYAHH5m2
	 IPVwO2fa0W4qzZsc1qXOk1XnZOColaGAJzQuT0GewfpY5rgU5cBUGjNsQWVVIshZi
	 /Zro94J2SEsfxHKmDkJR0Aj0Az3EhsaKduwQ2/rvUru4GAy3ps0fI/7N4ZgQgHr5X
	 4HhVgaYcY1CtfBP3xu8XpoY8fFnU/51qpniIenJV9lrODLU/4biqPLbicQvvYJGuZ
	 bhyYB8HwSQga92A2TQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1wnYNx0u5S-003etc; Tue, 14
 Jul 2026 17:02:23 +0200
Date: Tue, 14 Jul 2026 17:01:58 +0200
From: Lukas <lukas.metz@gmx.net>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: Add DAC8163
Message-ID: <alZPZuAQfiROz8kf@berta-MS-7693>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-1-3acd1bf20182@gmx.net>
 <20260708-spotty-spectacle-f270b4c66d18@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-spotty-spectacle-f270b4c66d18@spud>
X-Provags-ID: V03:K1:B6/GRT4zR/hLJKQzsqxHmJptu5sN0JrpB6L2hctM/XEerdFwaNh
 jnohlzidysH2wEIGOiI+LzP7os2pph7HQwY5TTQAdWvrIzH2RXPrCG2W552cv/HQOEZ4QyO
 K04dL6YXlSu02RsLKnqRu0vbSwyw1EpFcDE+HhSsUX/wisMVOoDpRnZ6LaWHdeBMe+hKlMn
 Ij8iLdR9+aP5bdT7hgZIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/nJvyZVj2J0=;wfF08yDmaSGR+iboZg1iEriwrD5
 XMhtV5Sw49eDrrRRm+JJtfuL47GbBYeILgY3SeeY88aHla6HbQloevLAEHZTI6SLRmV83xXyW
 Jjs1O75HsNHf+RIka0BhWWuLysVCRxJSjIXnYnQCziVGovoRUlo3Xb+tLpP014AqY7H5KuBak
 uWZRCTSZTib7gZ8vekm0SC9PXhcjeU5zw4KGx4isaCYiwJC7ejxXegSo5TpWPZPwBFsmNHXK+
 wJIR2omyHX+sfsx+F9By6ujL0HIVxu8q49JVRCEjlH0WnfNHQV+KQbYPPf+uMj/4dpKJN7eHf
 oU0g48kY4Pr6pfGI2PPje4sZhhbJsFFvIioRT2IjoWBG/0nuZyMIi54sxalm17IG0E0/YW2r6
 CUONM4wnHTT3Z2whvcRkqCC87VWmcS0ditGNGhL8H1T+u878tZPk6g61wLH2jw6E1gLtqvFGj
 ZwBiWZncs8xBhxrekITYHMeVJ4Yk2sJJ1sBhwkH7JvbSY2KbWTVgUAwL4rrIwqtV6zNY/RyLV
 FMF5JXqiDCuHZzn88W44vMQC1OssGO3BcFjQVVIuCb8PU7+isZM/jJjZwX2GqcPKwuj0LNsIE
 yEWCzREidS+sUGKfuBcuxjsvcoxt8Zyhc0fNA4LMlmFHavDYmGCwfogSkopZ7PSR0scNhoXv3
 ZlVvfbazcydyzQ+19pRwzAY0inzpozav8DJVepCdb1JVJWScnkuxe9eab8CuqE7GqqMGsBvsK
 zh84ho5expR8QXsJaI3UMLfEqSZ3bD7JPzveVuTJ8HN8aIj9qylH/LZCt6j2cW3rScg5qaMDs
 oIOMKyTSDmvkMqElxCWlcQobBww7zc/eJzV5m+7xfEMTdqMKplQ2iHai5xc4Q82XT82fmU2ZJ
 kn4h9SWLf4SApqx0oahFuECsYgjZ+7BXg5VIm5Rgg+J3VawtYfOQgKksKweD2kHxdMldOJwbO
 FFgUJLPqamFUhiqqBX5UwVkau4lGjLrKQF8RM2lsQuDHliD67Lf2hUp4dis/vAQW2MzjqOVwU
 QZSx296AvZHLbT4SGXyDLg0HC8X/2tfpQq5+62nbHvv0gd4FL6Iz5HvluEU+mD6DaowYmvUgH
 +1olz4Mb6Nz41eN38s7flbXLs+WgaODZvyiU4SdbfJyR7F5xSWxub0pFhpc8ZajmXuOMn3WVR
 LDwOB1j54SlnFw2dXTkhEO9bHQwa4ULuwGAFf7f2Df1hjVlPc1tGMqLBg2m9YBAUMbRVtEcnP
 BKTxZm7wFJOSlAWAQZ4WUdEZ4PL3ih2QYMjHFSKGnvje7X7rr1UTWoXAHqbkVrhoOA/AqHKiO
 CbJA683aEhaFXU+IEEXKtXRSc4v5qaTCaWlkuZ7R83yOkioRwi+ejswWY27VP0NC1rjKlRzdt
 z1hNBi0D3gh4Mv4+h0LzHovKo5jsfr0XH/BGUyrvRRvdDPIk1uM0m9n2WQTJmEj0PPJ/cL/2K
 YmA0B7lF9mtML2tBiBOSYLqk1IsbdJi9FlDgkEFvv1lHhVIG/ByX27fykCfI4Dl4S8xT3878Z
 ucwRILGh/TVBzqZspkOR9AvI942e8M4xOduEhjgG9ZUwtMLSG9zk6Giiize9Kj3NgGWU+sO8Q
 nYXu4JMI5XdSqjD2wFS8B+E7UHquIl2SrxoXkSkss/wB3zVBqC+hu98k4oIzL59ChFs4Dfjfg
 P7WZfKK7m5qHdQn1Jvt1UdeYTKciCi6Jz0pmDhrzOj0ZKTxwi0K6HukyR4Q5Ef7BkmkKSXp5I
 4rqGmkV0yI7I9RQXW+tq/DzPbO51ACnVEdwA5++wVXbqTWsZ8d3kdllaHvSl+YoAtGR/8o6vQ
 z2cMRFUDvZ/9+d2KG8i/ZGIOuK1FKDtinl3vwiy0dazImLSZpg76JR6aZgAFj59pel49FtCRj
 WCiNBFtX4ztWeNcaa6beMw57wCrJp8He9Whcw8AvfERuZe2hHX+nyT8z9B5QHVKAlYVhutY1t
 qq2LK6kBixrVWzZKOqQefVlveDL8x7XbmRbxAYDmYmAYbyrGjWaSEGz6QOLuwWp0Gl/lp2aQo
 XG+MVWTQZ+JMJfOCJnf5KYPzLKWHf1DJwfdrEGGpnbfEfMCogwCvkyGTP2r5uPAkr8GOZblHY
 U5I44dSta6JIM4Q0kntt0IlcdcHAh6Zh41yFtP2Hv1Ysvs7a0KmAG98feZCmkS39aL3mDgQNK
 94iHbcojLV/4F8a7Mmy/0h7Yjta78RNmQCVS4CWLsNfgbNvznZqGSLCst9y23kA6YBgjTdrmY
 q2JL15y09qAFsZKoPVVnmgSRdpttk2AocVUoY2ex8zb5QWOs93PoQvDaCnnAA2IKYzfbKm3xk
 lepJXuIy6DhPgJfYER9kwESLKgdarx5pXxr6vq7/dLDRVRG/aWymCXn9OSBcjbUHjZgIvKtGZ
 hDkJD53kvfcvSeRNwIV/ZFbah5SCNW+TXbGZtfFLEaY2sUWrI+RuwoBh1i2bpoZ8WHQ+wXR2s
 eEKPMYIH1x1aHV1Fls5hOoR7KslmClPIignzmU5zxt+gbBVZYpRPL1Fz24JcaJO/983NPRekQ
 SW5Sa0pt+7MSOzqJldCWWqdRvyo5ViA0S48F7XbpOQEuF2fjbzRSM2rnZnrGeFuGoPl6Pxuth
 oGVtKcLFAmL7nrNa1jzCy6YEe9N2KQ2t+0haTjKF6Mq9PmqPm3WZvQo075u3D9hBJAUbfRTvo
 D06HjHm4izKDOqGAr0cq+rWp3uBIUWPy1T0zVoVwj97l7ARpOys5BoXaWlXQ3FlPUdCk7ev9T
 FLCo6MXtBlm12SCBQfhoZrlD3RgavqewDnRtCkEJIkvmLfHwgZ8d2oZwNv42GySOKUF2/GSkb
 3RSWAgc2B5GoVjZiF85T1SHCZAOiFHpEqYmO6hO6fiTYCb1Z2UjJkrCNGxhCz4dq3fsVIp/P1
 k3yiL0iOtw4L5AcFHbtRcrye2jafHF7M7LqULk0GmWSAWFm+svQChtJiTJWqpZrWuH4MnhEdA
 9pHTMbLUoyq6464jaZwj46uZoKcGChXSupQVXozxeZ1wayM8uFja0v48EBvSlSoJnTr7RUc9P
 bQAoyM/OlP8WffS7l45v3dTr41NjPoQZuDrZG5LgTTSeB0Li/1S+fgk1/lVbPRlGy/KHy2/Kx
 FPk0mJIUBI8TaqcL7qF+5s0rqDVVYfGT+qoxd0Nsno4I1J56Af1Gud5Ij1Cw7hkN2q1ASFZPf
 V0yGQXWV7tNWlnRQ6n85/aKsq+uFaqeIrWOR1Xl4i0p7WL2UZSAihmlyBoHiSrjUOvSeo2wlY
 nZjrjNPi4tDxLIHmlXE44+4nf7QuAeH1yW+S2kTMwcfZNLx3wJyvku8Tn0SXFoxJ6iolle6bU
 jx/bn+pYQ4IqSC5EICEhfhZGqcOT5qIeX8bBB/BV8+ZOi67rzrUwsBde9X0VBa2I9NljXOPJc
 27RycIURZsM92JeGn6cEsL5iKYeb2J7Tr7FBD3yiZ3SUmSXY7FTNKlFLXFi7HgwQTgQwLsdlT
 w7rmkhalZCtOSI8Opnlsfs9hucQGAwNHCEypLWvbpPaKKoPVYSxDBHpd1XIrBMYRORbZo0uLe
 eZeE2Sae/Y3amAzNmfIbeQ7ifZv0VQ3ATMCW+0TrZ5oTTiehbxHDW+5kTLQf1qJA+1xM3WBYA
 DZhjUGEJFkjHgIfS15VKn8dPEe+W03SIFCs9Y1W53acKXU+3JQiSfo8EOtREUaHvS/Genokt4
 ao6g5+9PdwW2B7lXsVzleLPdaXKXhwxEsl8EvzMqZqXEdnXuc6Afs2SsmfMo+BF/qv+MiZK9D
 UPDdumseHw2XJP0YB21yAhakVEXiPoT4RAtT6AXd5hWpCHxyvBHop4v0UTSf0x1U7OnNEaimQ
 QsgoKKlgV2100Vq/bXB4ZLLGS1E+HQ05A6F+3z90FaOtqzdXtR1GxxLT33/TTF8OLTj7JWq6P
 joV9PQYSKAZzqkFWR0R/pDv3ItSQ8r0pynebkvHMBduyTxPDapn1FmbcQ7G+qLF9BKkYJ+IHu
 utmaQ5upWDPhqbareod+CUxwPJ8ujc61Q9euEwj3br+IxquWQz4MV2C1e6Xpa2QumdBpsHPtc
 Y5YxnQlnkj2yiTOkysaA2n6yiDaONCTqYJ/c0OuEW9O9HhR6o9k4H8oTt1XD8LgHFaYaenc+f
 wjwzViqhtaoL4W1eBiaDHiZnRGUGGONWyuY9ITVjIdWA5+xUgYiAUi1JnVOoqWdapPM6Qtduq
 AH1Q7aOJCTy8iiIgygpwKNbS+74KvWjB4f0QG8BclSQvAbGJ3EgPCENhNtv+/oQrAldBJkKCT
 L8aqhTUa/dqTqGBZruIEeInBqoAQjidlVUBjE9xyGGQVIKJoyGQLEx8C7oN4xMHKHlBdpM+Rt
 8+uC8n1O9BlJvenCDU2ACazwwjkWMg7PlDYrCyZRQAA7SxgsV8aNNSGolgG7tztDIrjJlPiV6
 +hEUR8lEUCG/S3GB4Dvt6hqdbmN6oIJfJQe75h8BEe7rw2Mq/vNeq9aVHKmlaal4e9+3Gx6GH
 lDk3HkJnJjkQ9aQJDWXg310fE7Ej13hrpltUzoigsojPvdAHeXJ+TIDmwXpE1Be8S76VL6oIn
 NgBsZX+yrhQ1Hmm0GFS5EwWd7AJDLb6zlNQwX4S3p0fGQWAglpfntuKzdzQRKWw6J9NSIPfck
 7Foi+2YQTGL133cQgYIqa+PJjB5GsEibROPAJG2/piOCRivEOEYgMgMUj31h18mgZuTmLFCIk
 eidpV8F7EwIDD3U28dL/v+8169hOjN4y1JBsv/tT4DJlKFsO3fHT+jxty9Fk1FhLrjwC5fIil
 lhGA0YwyHc/BD/G34Q5q2ncjxLYXChc6yqHxxZhZT/vWurAX1dbxwv6j/X1vyM3Q5VqbWCTB+
 1DaIDuCDM6U/6GE8WwRc7PXswWdQ2ZvNMctt3LihhwX80sksvXeOUOP3PrN9yRuIktJscEThf
 YorZ31pFsElPvM7SRfDs8W3pJeEYtZjMml6XTVV36ZbCpKVcHlPie9+LAroHW25yjPK4lCYAP
 kFxkFwYzL9OHkA1cwdtqyKki6gicIy+724Ex96vUItsjg9+64Ltn+Q1WAqIRE8niqAJ6QK6TV
 dQGbWTyn8/ccQFKDFVlk9MoIXuyUtLfLf1qrL6itzZwYhoFWi+edeGmg3VDTEhoDJCyvKHmdy
 nesv2pNXfWSie1mGTj8NVBb99TGpLgIxLClJJ2dH29KfBrcNgujBdynrwdvmlIq9Hv5b2ZJRu
 Va7lbW9CXs/YNOXrC8+gLoeYF6GrtjaOMKxPdLN6XGFjbIDtNhnePHeE2y9qeH/sCv75p1N1C
 8u2ZjEwMCGd768LAJn/zzeLt8PQikkKhSv2ZclF1Tz0jdHay9LlrCmHje5rEEuYjvDVoksHfC
 xk/BDiG4GTrmg3PR/IWeBw4xHAXPgyX9b+VNZzPBy0Yu6lZGqSYHgBN8QDWMsj6ArvEqXLbkB
 kLtjeDOoqwZLiQoutKLtOZ/3khyT7AVd8jQ7LWXJy5gKNu4TVtWUvgMsgC3NT0ajvRgN4OZ9D
 cK6JCC+o0pn7Jc3kxJappg7jyiyKhxQz/vwPqfe/Sh/StSlMO85v8OprA+N7UFv7QAQvzlZk8
 jm3Upkop4cAm0yML2ExZz+gtVxE=
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 05:37:44PM +0100, Conor Dooley wrote:
> > +  clr-gpios:
> > +    description:
> > +      The device registers are reset when this pin is asserted. The o=
utput is
> > +      set to zero (xxx2 devices) or mid-scale (xxx3 devices).
> > +    maxItems: 1
> > +
>=20
> Sounds like this should be reset-gpios?
>=20

Thanks for pointing this out. The description is actually wrong. The
datasheet says: "On activation of CLR, zero scale (DACxx62) or=20
mid-scale (DACxx63) is loaded to all input and DAC registers".
That means other registers are unaffected. I will update the description
but the clr-gpios is correct in this case i guess?

Best regards
Lukas
